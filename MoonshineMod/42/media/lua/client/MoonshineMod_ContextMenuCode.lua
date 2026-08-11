require "TimedActions/ISUpgradeDistillStillSmall"
require "TimedActions/ISUpgradeDistillStillMedium"
require "TimedActions/ISDismantleDistillStillLarge"

ContextMenuCode = ContextMenuCode or {}

-- Filter/Column are no longer checked here - they're required inputs on the
-- next tier's own CraftRecipe now, so the game itself won't let the rebuild
-- step complete without them. Disassembly itself has no part requirement.

function ContextMenuCode.UpgradeDistillStillSmall(context, entity, character, param)
    if not luautils.walkAdj(character, entity:getSquare(), false) then
        return
    end

    ISTimedActionQueue.add(ISUpgradeDistillStillSmall:new(character, entity))
end

function ContextMenuCode.UpgradeDistillStillMedium(context, entity, character, param)
    if not luautils.walkAdj(character, entity:getSquare(), false) then
        return
    end

    ISTimedActionQueue.add(ISUpgradeDistillStillMedium:new(character, entity))
end

function ContextMenuCode.DismantleDistillStillLarge(context, entity, character, param)
    if not luautils.walkAdj(character, entity:getSquare(), false) then
        return
    end

    ISTimedActionQueue.add(ISDismantleDistillStillLarge:new(character, entity))
end
