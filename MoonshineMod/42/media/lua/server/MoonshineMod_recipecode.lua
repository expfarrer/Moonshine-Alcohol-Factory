Moonshine = Moonshine or {}
RecipeCodeOnCreate = RecipeCodeOnCreate or {}


-- ===================================================================
-- ROUND 7 / R7-A (2026-09-04)  --  ReturnEmptyVessel
-- ===================================================================
-- Every "pour it out and give the vessel back" recipe used to do a bare
--     character:getInventory():AddItem("Base.Whiskey")
-- and print "An empty whiskey bottle back!".  It is NOT empty.
-- InventoryItemFactory initialises an item's FluidContainer component from the
-- item script's Fluids{} block AT SPAWN TIME, so Base.Whiskey spawns holding
-- 1.00 L of Whiskey, Base.PopBottle 2.00 L of Cola, Base.WaterBottle 1.00 L of
-- Water, Base.Bleach 1.00 L of Bleach, Base.WineOpen / Base.Sportsbottle a
-- randomised part-fill.  24 of the mod's 41 pour-out recipes were minting real
-- vanilla booze/soda/clean water out of nothing, once per craft.
--
-- A native `outputs { item 1 Base.Whiskey }` line does NOT avoid this -- the
-- fill happens inside InventoryItemFactory, below both the output-line path and
-- the AddItem path (measured: results/round7-probe-2026-09-04.txt).  So the
-- emptying has to be Lua, and it has to be here.
--
-- (This corrects craftRecipe quirks rule 31: a FluidContainer item DOES spawn
--  from an output line.  What rule 31 was really about is that it spawns FULL.)
--
-- No mod item declares a FluidContainer component, so the Empty() below only
-- ever touches a vanilla vessel; for a mod pot/drum/can it is a no-op.
--
-- ===================================================================
-- ROUND 8 (2026-09-04)  --  AddItemSynced: the MP client-sync half
-- ===================================================================
-- R7-A gave the right vessel back, but LIVE MP TEST showed it stayed INVISIBLE
-- in the client's inventory/crafting menu until a full rejoin.  A server-side
-- inv:AddItem() inside a recipe OnCreate is authoritative immediately but sends
-- the connected client NO packet -- vanilla's own ISHandcraftAction:performRecipe()
-- literally reads `-- todo handle syncing items and inventory stuff here` at
-- exactly this spot.  (Quirks rule 22 / reference_mp_multiitem_oncreate_sync_gap:
-- the gap is NOT specific to bursts of AddItem, a SINGLE one is enough when it
-- comes from a craft OnCreate rather than from a native outputs{} line.)
--
-- Fix = the same three globals the vanilla admin /additem path and
-- MoonshineMod_TestLoadoutsServer.provision() use.  Decompiled (CFR, 42.20.0):
--   LuaManager$GlobalObject.sendAddItemsToContainer/sendItemStats each open with
--   `if (GameServer.server)`, so they are already no-ops in single-player;
--   GameServer.sendAddItemsToContainer -> INetworkPacket.send(IsoPlayer,..) which
--   null-checks getConnectionFromPlayer(), so a character with no UdpConnection
--   (the headless synthetic tester) is a safe no-op too, never a throw.
--   The isServer() guard below is therefore belt-and-braces, kept only to mirror
--   the established provision() pattern.
-- ORDER MATTERS and is copied from provision(): AddItem -> mutate item state
-- (fc:Empty()) -> sendAddItemsToContainer (the add packet, so the emptied state
-- serialises WITH the item) -> sendItemStats (follow-up for anything the add
-- packet does not carry).
--
-- Use this for EVERY item an OnCreate hands out.  A native outputs{} line still
-- syncs by itself and needs nothing -- this is only for the Lua path, which R7-A
-- forced back into existence (an output line spawns a FluidContainer item FULL).
function Moonshine.AddItemSynced(inv, fullType, prepare)
    if not inv then return nil end
    local it = inv:AddItem(fullType)
    if not it then
        print("[Moonshine] AddItemSynced: unknown item id " .. tostring(fullType))
        return nil
    end
    if prepare then prepare(it) end
    if isServer() then
        local bulk = ArrayList.new()
        bulk:add(it)
        sendAddItemsToContainer(inv, bulk)
        sendItemStats(it)
    end
    return it
end

local function emptyVessel(it)
    local fc = it:getFluidContainer()
    if fc then fc:Empty() end
end

function Moonshine.ReturnEmptyVessel(inv, fullType)
    return Moonshine.AddItemSynced(inv, fullType, emptyVessel)
end

-- The 20 refund callbacks the recipe scripts name.  Same one-line body, so they
-- are generated rather than copy-pasted: near-identical hand-written refund
-- functions are exactly what produced the O2 bug (a mash recipe reusing the
-- cover-removal OnCreate and spraying free tarps).
local RETURN_VESSEL = {
    GiveBackWhiskeyBottle  = "Base.Whiskey",
    GiveBackBeerBottle     = "Base.BeerEmpty",
    GiveBackWineBottle     = "Base.WineOpen",
    GiveBackEmptyJar       = "Base.EmptyJar",
    GiveBackSodaBottle     = "Base.PopBottle",
    GiveBackWaterBottle    = "Base.WaterBottle",
    GiveBackSportsBottle   = "Base.Sportsbottle",
    GiveBackBleachBottle   = "Base.Bleach",
    GiveBackMug            = "Base.Mugl",
    GiveBackMugWhite       = "Base.MugWhite",
    GiveBackMugSpiffo      = "Base.MugSpiffo",
    GiveBackKettle         = "Base.Kettle",
    GiveBackSaucepan       = "Base.Saucepan",
    GiveBackBucket         = "Base.BucketEmpty",
    GiveBackWateringcan    = "Base.WateredCan",
    GiveBackGasoholDrum    = "Moonshine.EmptyGasoholDrum",
    GiveBackMotorOilCan    = "Moonshine.EmptyMotorOilCan1",
    GiveDistillSmallEmpty  = "Moonshine.DistillPotSmall",
    GiveDistillMedEmpty    = "Moonshine.DistillPotMedium",
    GiveDistillLargeEmpty  = "Moonshine.DistillPotLarge",
}
for fn, fullType in pairs(RETURN_VESSEL) do
    RecipeCodeOnCreate[fn] = function(recipeData, character)
        Moonshine.ReturnEmptyVessel(character:getInventory(), fullType)
    end
end

-- Deleted in the same pass (ROUND 7 / R7-C), zero script references anywhere in
-- the 42/ tree: GiveDistillMed, GiveDistillLarge, GiveEmptyPetrol (which handed
-- back "Base.EmptyPetrolCan", not a B42 item id), DoubbleFilledReturn (a
-- ZombRand ladder over four item ids that do not exist in B42 -- WhiskeyEmpty,
-- WaterBottleEmpty, PopBottleEmpty, WineEmpty2), Moonshine.FullPetrol and
-- Moonshine.CheckDrumXD (a bare print).  ~95 lines.

--

-- B1: FillPetrolCanFromDistillPotIII.
-- Base.PetrolCan is a real component FluidContainer, so it can NOT be produced by an
-- `item 1 Base.PetrolCan` output line (craftRecipe quirks rule 31).  The recipe instead
-- keeps the player's own empty can (`mode:keep flags[IsEmpty;ItemCount]`) and this
-- callback fills THAT SAME INSTANCE with real vanilla Petrol.
-- Deliberately does NOT Remove/AddItem anything: removing a mode:keep input from its own
-- OnCreate is the rule-27 SyncItemFields rollback, and re-spawning a FluidContainer is
-- rule 31 + the rule-22 MP sync gap.  Editing the kept item's fluid in place is exactly
-- what the engine's post-craft sync packet is for.
function RecipeCodeOnCreate.FillPetrolCanWithGasohol(recipeData, character)
    local kept = recipeData:getAllKeepInputItems()
    if not kept then return end
    for i = 0, kept:size() - 1 do
        local it = kept:get(i)
        if it and it:getFullType() == "Base.PetrolCan" then
            local fc = it:getFluidContainer()
            if fc then
                fc:Empty()
                fc:addFluid("Petrol", fc:getCapacity())   -- name FIRST, then litres
                print("[Moonshine] gas can filled with " .. tostring(fc:getAmount()) .. "L gasohol")
            end
            return
        end
    end
    print("[Moonshine] FillPetrolCanWithGasohol: no kept Base.PetrolCan found")
end

-- F11/U8 (2026-09-02).  The 33 RefillWaterIn* recipes used to consume the
-- player's real vessel and hand back a Moonshine.*WaterRefill base:drainable
-- CLONE -- an item that looks like water but is not a fluid container, so the
-- mod's OWN mash recipes (`item 1 [Base.WaterBottle] mode:keep` + `-fluid 0.8
-- [Water]`) could not read it.  "Distil water, use it for the next mash" did
-- not close.  Now every one of them keeps the player's own EMPTY container
-- (`mode:keep flags[IsEmpty;ItemCount]`) and this callback fills THAT SAME
-- INSTANCE with real vanilla Water, exactly like FillPetrolCanWithGasohol.
-- Generic on purpose: it fills the first kept input that has a FluidContainer,
-- so one function serves every vessel (bottle, mug, jar, beer/wine/whiskey/
-- bleach/soda/sports bottle).
-- Same two prohibitions as above: never Remove/AddItem a mode:keep input
-- (rule 27 rollback, rule 22 sync gap) -- only edit its fluid in place.
--- Fill the first kept input that has a FluidContainer.
--- `litres` nil  -> fill to the container's CAPACITY (the F11/U8 behaviour).
--- `litres` set  -> put exactly that many litres in, clamped to capacity.
--- Returns the item filled, or nil.
function Moonshine.FillKeptContainerWith(recipeData, fluid, litres, label)
    local kept = recipeData and recipeData:getAllKeepInputItems()
    if not kept then
        print("[Moonshine] " .. tostring(label) .. ": no kept inputs")
        return nil
    end
    for i = 0, kept:size() - 1 do
        local it = kept:get(i)
        local fc = it and it:getFluidContainer()
        if fc then
            fc:Empty()
            local amount = litres or fc:getCapacity()
            if amount > fc:getCapacity() then amount = fc:getCapacity() end
            fc:addFluid(fluid, amount)                    -- name FIRST, then litres
            print("[Moonshine] " .. tostring(it:getFullType()) .. " filled with "
                  .. tostring(fc:getAmount()) .. "L " .. tostring(fluid))
            return it
        end
    end
    print("[Moonshine] " .. tostring(label) .. ": no kept fluid container found")
    return nil
end

function RecipeCodeOnCreate.FillKeptContainerWithWater(recipeData, character)
    Moonshine.FillKeptContainerWith(recipeData, "Water", nil,
                                    "FillKeptContainerWithWater")
end

-- BACKLOG 2.8 (2026-09-06) -- RefillWaterInBucket / 2 / 3.
-- The bucket cannot use FillKeptContainerWithWater: that fills to CAPACITY, and
-- a 10 L bucket filled from one 1 L serving of a 4 L still pot is a free-water
-- machine (measured 10.00 L, and FillDistillWithWater buys a fresh 4 L pot back
-- for 4 of them -- tools/pzrepl/tests/bucketdecant.lua).  These three take the
-- WHOLE pot (`flags[IsFull;ItemCount]` in the recipe) and put in exactly the
-- litres that pot is worth, which is also exactly what FillDistillWithWater
-- charges to refill it.  Break-even by construction.
-- Table-generated rather than three copy-pasted bodies, per rule 58.
local DECANT_WATER_INTO_BUCKET = {
    DecantWaterPotSmallIntoBucket  = 4.0,   -- Water_DistillPotSmall,  4 servings
    DecantWaterPotMediumIntoBucket = 6.0,   -- Water_DistillPotMedium, 6 servings
    DecantWaterPotLargeIntoBucket  = 8.0,   -- Water_DistillPotLarge,  8 servings
}
for fn, litres in pairs(DECANT_WATER_INTO_BUCKET) do
    RecipeCodeOnCreate[fn] = function(recipeData, character)
        Moonshine.FillKeptContainerWith(recipeData, "Water", litres, fn)
    end
end
-- NOTE: no empty-pot handout here on purpose.  `flags[ItemCount]` (as opposed
-- to `mode:destroy`) leaves the pot's own ReplaceOnDeplete free to return the
-- empty Moonshine.DistillPot* natively, which has no MP sync gap (rule 59).

--









-- GiveOil and GiveMotorOil removed: converted to native outputs blocks on
-- FillDistillIIIWithMotorOil / RefillMotorOilCanWithMotorOil (sync-gap fix).


-- BucketCover removed (ROUND 7 / O2, 2026-09-04): converted to native outputs
-- blocks on the 6 FillDistillWith{Corn,Potato}Mash{,2,3} recipes.
-- It was a ZombRand(1, 7) ladder -- ZombRand's upper bound is EXCLUSIVE, so every
-- one of the 6 reachable branches returned Base.Tarp + Base.RubberBand, and two of
-- them (3 and 6) additionally handed out a free second RubberBand or a free
-- Base.Button.  Measured headlessly: 1 free extra item per ~3 mash batches.
-- Same reason as GiveCoal*/GiveWood* below: output lines are deterministic and
-- survive the MP AddItem sync gap.

--

-- GiveCoalSmall/Medium/Large and GiveWoodSmall/Medium/Large removed: converted
-- to native outputs blocks on RemoveCoalFromDistillI/II/III and
-- RemoveWoodFromDistillI/II/III (sync-gap fix).
--




--

--------------------------------------------------------------------
--------------------------------------------------------------------
--------------------------------------------------------------------
------------------return char:getInventory():contains("Apple");---------------------------------------------------



--
--


-- ROUND 8 (2026-09-04): the two "pour 6 bottles back into the empty pot" refills.
-- Still LIVE (4 recipes in MoonshineMod_DisinfectantRecipes.txt: RefillDistillPotII
-- With6XSpirit/2 -> Med, RefillDistillPotIIIWith8XSpirit/2 -> Lg).  They are NOT
-- routed through ReturnEmptyVessel on purpose -- Alc_DistillPot*RefillSpirit is a
-- mod item with no FluidContainer, so there is nothing to Empty() -- but they had
-- the SAME bare-AddItem MP sync gap, so they now go through AddItemSynced.
-- (The `local bottleChance = ZombRand(1, 7)` each carried was dead: never read.)
-- ===================================================================
-- 2026-09-08  --  the INVERSE-SWEEP refunds (quirks rule 93)
-- ===================================================================
-- MakeDistillPotI consumes a whole Base.PropaneTank (`mode:destroy
-- flags[ItemCount]`, e57c778) and MakeControllableDistillColumn a whole
-- Base.CarBattery1/2/3.  Neither came back from the matching dismantle, so
-- dismantling silently ate them -- the exact defect rule 93 exists for.
--
-- Why these two cannot just be an `outputs { item 1 Base.PropaneTank }` line:
-- both are base:drainable, and an output line spawns a drainable FULL
-- (rule 75).  MEASURED live 2026-09-08: a fresh Base.PropaneTank is
-- 5000.00/5000 uses and weighs 10.00; a fresh Base.CarBattery1 is
-- 100000/100000.  Vanilla's ONLY propane recipe, RefillBlowTorch, drains a
-- tank into blowtorch charges, so a full tank is real currency -- refunding
-- one would make "build a still, dismantle it" a propane mint costing a
-- single use of duct tape.
--
-- So the refund is the EMPTY SHELL, which is exactly what the item scripts
-- model: PropaneTank declares WeightEmpty = 5.0 and KeepOnDeplete = true, and
-- CarBattery* is KeepOnDeplete too.  MEASURED after setUsedDelta(0) +
-- updateWeight(): tank 0.00 uses / weight 5.00, battery 0.00 uses, and BOTH
-- stay in the inventory.  The player gets the steel back (both are smeltable),
-- never the gas or the charge.
local function drainDry(it)
    it:setUsedDelta(0)
    if instanceof(it, "DrainableComboItem") then it:updateWeight() end
end

function RecipeCodeOnCreate.GiveBackEmptyPropaneTank(recipeData, character)
    Moonshine.AddItemSynced(character:getInventory(), "Base.PropaneTank", drainDry)
end

-- MakeControllableDistillColumn accepts CarBattery1/2/3 (they differ only by
-- VehicleType); the refund is deliberately always the type-1 shell, so the
-- recipe can never hand back a better battery than went in.
function RecipeCodeOnCreate.GiveBackDeadCarBattery(recipeData, character)
    Moonshine.AddItemSynced(character:getInventory(), "Base.CarBattery1", drainDry)
end

function RecipeCodeOnCreate.DoubbleFilledReturnMed(recipeData, character)
    Moonshine.AddItemSynced(character:getInventory(),
                            "Moonshine.Alc_DistillPotMediumRefillSpirit")
end

function RecipeCodeOnCreate.DoubbleFilledReturnLg(recipeData, character)
    Moonshine.AddItemSynced(character:getInventory(),
                            "Moonshine.Alc_DistillPotLargeRefillSpirit")
end

--
