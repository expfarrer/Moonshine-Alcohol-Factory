require "TimedActions/ISPourMoonshineFluidAction"

-- Scoped to this mod's own still-output fluids only, not a general vanilla
-- fluid-transfer patch. See ISPourMoonshineFluidAction.lua for why this
-- exists instead of just using vanilla's native "Transfer Fluids" UI.

-- Fluids this mod's stills can produce, that the pour menu should offer.
-- FluidType is a fixed native enum (~33 vanilla fluids); every modded fluid
-- (like Moonshine) reports as FluidType.Modded there, so
-- FluidType.FromNameLower() always silently returns nil for those. The
-- actual per-script fluid (native or modded) lives on the separate Fluid
-- class instead - cont:contains() expects one of those.
local POURABLE_FLUID_NAMES = { "Moonshine", "RubbingAlcohol" }

-- Petrol is deliberately NOT in POURABLE_FLUID_NAMES above - unlike Moonshine
-- and RubbingAlcohol, Petrol is common vanilla content (gas cans, jerry cans,
-- vehicles), and vanilla likely restricts pouring/siphoning it on purpose
-- (balance/realism). So our own Petrol-filled items are allowed by item type
-- identity instead, not by fluid identity - this keeps the pour menu off
-- every other Petrol-holding item in the game.
local POURABLE_ITEM_TYPES = { "Moonshine.GasoholJarLarge", "Moonshine.GasoholDrumLarge" }

local function isPourableFluidItem(item)
    if not item then return false end
    local cont = item:getFluidContainer()
    if not cont then return false end

    local fullType = item:getFullType()
    for _, itemType in ipairs(POURABLE_ITEM_TYPES) do
        if fullType == itemType then
            return true
        end
    end

    for _, fluidName in ipairs(POURABLE_FLUID_NAMES) do
        local fluid = Fluid.Get(fluidName)
        if fluid ~= nil and cont:contains(fluid) then
            return true
        end
    end
    return false
end

local function doPourFluid(playerObj, source, target)
    ISTimedActionQueue.add(ISPourMoonshineFluidAction:new(playerObj, source, target))
end

local function onFillInventoryObjectContextMenu(player, context, items)
    local playerObj = getSpecificPlayer(player)
    if not playerObj then return end

    -- items entries are either a plain InventoryItem, or a stack wrapper
    -- table with an .items array (same shape vanilla itself unpacks in
    -- e.g. ISRemoveItemTool.lua)
    local firstItem = nil
    for _, v in ipairs(items) do
        if instanceof(v, "InventoryItem") then
            firstItem = v
        elseif v.items and v.items[1] then
            firstItem = v.items[1]
        end
        break
    end
    if not firstItem then return end

    if not isPourableFluidItem(firstItem) then return end

    local allItems = playerObj:getInventory():getItems()

    local option = context:addOption(getText("ContextMenu_Moonshine_PourSpirit"), nil, nil)
    local subMenu = ISContextMenu:getNew(context)
    context:addSubMenu(option, subMenu)

    local addedAny = false
    for i = 0, allItems:size() - 1 do
        local candidate = allItems:get(i)
        if candidate ~= firstItem and candidate:getFluidContainer() then
            local cont = candidate:getFluidContainer()
            if cont:getFreeCapacity() > 0 then
                subMenu:addOption(candidate:getDisplayName(), playerObj, doPourFluid, firstItem, candidate)
                addedAny = true
            end
        end
    end

    if not addedAny then
        local noneOption = subMenu:addOption(getText("ContextMenu_Moonshine_NoContainers"), nil, nil)
        noneOption.notAvailable = true
    end
end

Events.OnFillInventoryObjectContextMenu.Add(onFillInventoryObjectContextMenu)
