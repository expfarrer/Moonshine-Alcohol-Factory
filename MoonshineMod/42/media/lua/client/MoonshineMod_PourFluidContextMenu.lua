require "TimedActions/ISPourMoonshineFluidAction"

-- Scoped to Moonshine's own fluid-bearing items only, not a general vanilla
-- fluid-transfer patch. See ISPourMoonshineFluidAction.lua for why this
-- exists instead of just using vanilla's native "Transfer Fluids" UI.

local function isMoonshineFluidItem(item)
    if not item then return false end
    local cont = item:getFluidContainer()
    if not cont then return false end
    -- FluidType is a fixed native enum (~33 vanilla fluids); every modded
    -- fluid (including this one) reports as FluidType.Modded there, so
    -- FluidType.FromNameLower("moonshine") always silently returns nil.
    -- The actual per-script fluid (native or modded) lives on the separate
    -- Fluid class instead - cont:contains() expects one of those.
    local moonshineFluid = Fluid.Get("Moonshine")
    return moonshineFluid ~= nil and cont:contains(moonshineFluid)
end

local function doPourMoonshine(playerObj, source, target)
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

    if not isMoonshineFluidItem(firstItem) then return end

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
                subMenu:addOption(candidate:getDisplayName(), playerObj, doPourMoonshine, firstItem, candidate)
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
