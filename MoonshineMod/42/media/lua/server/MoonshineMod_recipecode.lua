Moonshine = Moonshine or {}
RecipeCodeOnCreate = RecipeCodeOnCreate or {}


--
--

function RecipeCodeOnCreate.GiveDistillMed(recipeData, character)

character:getInventory():AddItem("Moonshine.Alc_DistillPotMedium")
print("A medium distll back!")end

--

function RecipeCodeOnCreate.GiveDistillMedEmpty(recipeData, character)

character:getInventory():AddItem("Moonshine.DistillPotMedium")
print("A medium empty distll back!")end

--

function RecipeCodeOnCreate.GiveDistillSmallEmpty(recipeData, character)

character:getInventory():AddItem("Moonshine.DistillPotSmall")
print("A small empty distll back!")end

--


function RecipeCodeOnCreate.GiveDistillLarge(recipeData, character)

character:getInventory():AddItem("Moonshine.Alc_DistillPotLarge")
print("A large distll back!")end

--

function RecipeCodeOnCreate.GiveDistillLargeEmpty(recipeData, character)

character:getInventory():AddItem("Moonshine.DistillPotLarge")
print("A large empty distll back!")end



--

function RecipeCodeOnCreate.GiveEmptyPetrol(recipeData, character)

character:getInventory():AddItem("Base.EmptyPetrolCan")
print("A empty petrol can back!")end

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
function RecipeCodeOnCreate.FillKeptContainerWithWater(recipeData, character)
    local kept = recipeData:getAllKeepInputItems()
    if not kept then
        print("[Moonshine] FillKeptContainerWithWater: no kept inputs")
        return
    end
    for i = 0, kept:size() - 1 do
        local it = kept:get(i)
        local fc = it and it:getFluidContainer()
        if fc then
            fc:Empty()
            fc:addFluid("Water", fc:getCapacity())        -- name FIRST, then litres
            print("[Moonshine] " .. tostring(it:getFullType()) .. " filled with "
                  .. tostring(fc:getAmount()) .. "L distilled water")
            return
        end
    end
    print("[Moonshine] FillKeptContainerWithWater: no kept fluid container found")
end

--

function RecipeCodeOnCreate.GiveBackWhiskeyBottle(recipeData, character)

character:getInventory():AddItem("Base.Whiskey")
print("An empty whiskey bottle back!")end

--

function RecipeCodeOnCreate.GiveBackBeerBottle(recipeData, character)

character:getInventory():AddItem("Base.BeerEmpty")
print("An empty beer bottle back!")end

--

function RecipeCodeOnCreate.GiveBackWineBottle(recipeData, character)

character:getInventory():AddItem("Base.WineOpen")
print("An empty wine bottle back!")end

--

function RecipeCodeOnCreate.GiveBackEmptyJar(recipeData, character)

character:getInventory():AddItem("Base.EmptyJar")
print("An empty jar back!")end

--

function RecipeCodeOnCreate.GiveBackSodaBottle(recipeData, character)

character:getInventory():AddItem("Base.PopBottle")
print("An empty soda bottle back!")end

--

function RecipeCodeOnCreate.GiveBackWaterBottle(recipeData, character)

character:getInventory():AddItem("Base.WaterBottle")
print("An empty water bottle back!")end

--

function RecipeCodeOnCreate.GiveBackSportsBottle(recipeData, character)

character:getInventory():AddItem("Base.Sportsbottle")
print("An empty sports bottle back!")end

--

function RecipeCodeOnCreate.GiveBackBleachBottle(recipeData, character)

character:getInventory():AddItem("Base.Bleach")
print("An empty bleach bottle back!")end

--

function RecipeCodeOnCreate.GiveBackMug(recipeData, character)

character:getInventory():AddItem("Base.Mugl")
print("An empty mug back!")end

--

function RecipeCodeOnCreate.GiveBackMugWhite(recipeData, character)

character:getInventory():AddItem("Base.MugWhite")
print("An empty white mug back!")end

--

function RecipeCodeOnCreate.GiveBackMugSpiffo(recipeData, character)

character:getInventory():AddItem("Base.MugSpiffo")
print("An empty spiffo mug back!")end

--

function RecipeCodeOnCreate.GiveBackKettle(recipeData, character)

character:getInventory():AddItem("Base.Kettle")
print("An empty kettle back!")end

--

function RecipeCodeOnCreate.GiveBackSaucepan(recipeData, character)

character:getInventory():AddItem("Base.Saucepan")
print("An empty saucepan back!")end

--

function RecipeCodeOnCreate.GiveBackBucket(recipeData, character)

character:getInventory():AddItem("Base.BucketEmpty")
print("An empty bucket back!")end

--

function RecipeCodeOnCreate.GiveBackWateringcan(recipeData, character)

character:getInventory():AddItem("Base.WateredCan")
print("An empty watering can back!")end

--

function RecipeCodeOnCreate.GiveBackGasoholDrum(recipeData, character)

character:getInventory():AddItem("Moonshine.EmptyGasoholDrum")
print("An empty gasohol drum back!")end

--

function RecipeCodeOnCreate.GiveBackMotorOilCan(recipeData, character)

character:getInventory():AddItem("Moonshine.EmptyMotorOilCan1")
print("An empty motor oil can back!")end







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


function RecipeCodeOnCreate.DoubbleFilledReturn(recipeData, character)
 local bottleChance = ZombRand(1, 7)
 print("A vessel back!")



  if bottleChance == 1 then
    character:getInventory():AddItem("Base.WhiskeyEmpty")
	character:getInventory():AddItem("Base.WhiskeyEmpty")
	 character:getInventory():AddItem("Base.WaterBottleEmpty")
	  character:getInventory():AddItem("Base.BeerEmpty")
	 	character:getInventory():AddItem("Base.WaterBottleEmpty")
	 	character:getInventory():AddItem("Base.WaterBottleEmpty")
	 
  elseif bottleChance == 2 then
    character:getInventory():AddItem("Base.WaterBottleEmpty")
	character:getInventory():AddItem("Base.WhiskeyEmpty")
	character:getInventory():AddItem("Base.WhiskeyEmpty")
	character:getInventory():AddItem("Base.WaterBottleEmpty")
		character:getInventory():AddItem("Base.WaterBottleEmpty")
			character:getInventory():AddItem("Base.WaterBottleEmpty")
	
  elseif bottleChance == 3 then
    character:getInventory():AddItem("Base.WaterBottleEmpty")
	  character:getInventory():AddItem("Base.EmptyJar")
	character:getInventory():AddItem("Base.WhiskeyEmpty")
	character:getInventory():AddItem("Base.WhiskeyEmpty")
	character:getInventory():AddItem("Base.WaterBottleEmpty")
		character:getInventory():AddItem("Base.WaterBottleEmpty")
	
  elseif bottleChance == 4 then
    character:getInventory():AddItem("Base.PopBottleEmpty")
	 character:getInventory():AddItem("Base.WaterBottleEmpty")
	character:getInventory():AddItem("Base.WhiskeyEmpty")
	character:getInventory():AddItem("Base.WhiskeyEmpty")
	character:getInventory():AddItem("Base.WaterBottleEmpty")
		character:getInventory():AddItem("Base.WaterBottleEmpty")
	
  elseif bottleChance == 5 then
    character:getInventory():AddItem("Base.BeerEmpty")
	  character:getInventory():AddItem("Base.WaterBottleEmpty")
	character:getInventory():AddItem("Base.WhiskeyEmpty")
	character:getInventory():AddItem("Base.WhiskeyEmpty")
	character:getInventory():AddItem("Base.WaterBottleEmpty")
		character:getInventory():AddItem("Base.WaterBottleEmpty")
		
  elseif bottleChance == 6 then
    character:getInventory():AddItem("Base.WineEmpty2")
	  character:getInventory():AddItem("Base.WaterBottleEmpty")
	character:getInventory():AddItem("Base.WhiskeyEmpty")
	character:getInventory():AddItem("Base.WhiskeyEmpty")
	character:getInventory():AddItem("Base.WaterBottleEmpty")
		character:getInventory():AddItem("Base.WaterBottleEmpty")
	
  end
 end


--




function RecipeCodeOnCreate.DoubbleFilledReturnMed(recipeData, character)
 local bottleChance = ZombRand(1, 7)
 print("A vessel back!")



    character:getInventory():AddItem("Moonshine.Alc_DistillPotMediumRefillSpirit")

	 

 end



--
function RecipeCodeOnCreate.DoubbleFilledReturnLg(recipeData, character)
 local bottleChance = ZombRand(1, 7)
 print("A vessel back!")



    character:getInventory():AddItem("Moonshine.Alc_DistillPotLargeRefillSpirit")

	 

 end

--



-- checks to make sure using Liquor ro make a Molotov Cocktail requires a full bottle; could be changed to a set amount so the game could have mini-bottles of liquor, for example.
function Moonshine.FullPetrol(item)
	if not item:hasTag("Petrol") then return true end
    return item:getUsedDelta() == 1
end

--
--


function Moonshine.CheckDrumXD(item, result, player)
    print("CheckDrum")
    local drum = item:getType()
    local condition = 12

    -- print("Main item: " .. item:getName())

    if drum == "EmptyGasoholDrum" then
        print("Main item no name: " .. drum)

    end
end






