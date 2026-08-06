require "TimedActions/ISUpgradeDistillStillSmall"

ContextMenuCode = ContextMenuCode or {}

function ContextMenuCode.UpgradeDistillStillSmall(context, entity, character, param)
    if not luautils.walkAdj(character, entity:getSquare(), false) then
        return
    end

    local inv = character:getInventory()
    local filter = inv:getFirstTypeRecurse("Moonshine.DistillPotFilter")
    local ductTape = inv:getFirstTypeRecurse("Base.DuctTape")

    if not filter or not ductTape then
        character:Say(getText("IGUI_Moonshine_UpgradeStillMissingItems"))
        return
    end

    ISTimedActionQueue.add(ISUpgradeDistillStillSmall:new(character, entity, filter, ductTape))
end
