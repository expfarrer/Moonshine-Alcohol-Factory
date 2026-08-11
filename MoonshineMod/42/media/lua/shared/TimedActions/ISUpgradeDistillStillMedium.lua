require "TimedActions/ISBaseTimedAction"

-- Mirrors ISUpgradeDistillStillSmall.lua: dismantle the still, refund its
-- build materials, let the player build the next tier through the normal
-- crafting menu. See that file's header comment for why (addWorkstationEntity
-- proven unreliable, not used here).

ISUpgradeDistillStillMedium = ISBaseTimedAction:derive("ISUpgradeDistillStillMedium")

local MEDIUM_STILL_MATERIALS = {
    "Base.BucketEmpty",
    "Base.MetalPipe",
    "Base.MetalPipe",
    "Base.MetalPipe",
    "Base.ScrapMetal",
    "Base.Wire",
    "Base.Wire",
    "Base.Pot",
    "Base.SmallSheetMetal",
    "Base.DuctTape",
    "Base.DuctTape",
    "Base.PropaneTank",
    "Base.BeerCanEmpty",
    "Base.Bleach",
}

function ISUpgradeDistillStillMedium:isValid()
    return self.still and self.still:getSquare() ~= nil
end

function ISUpgradeDistillStillMedium:waitToStart()
    self.character:faceThisObject(self.still)
    return self.character:shouldBeTurning()
end

function ISUpgradeDistillStillMedium:update()
    self.character:faceThisObject(self.still)
    self.character:setMetabolicTarget(Metabolics.HeavyDomestic)
end

function ISUpgradeDistillStillMedium:start()
    self:setActionAnim("Loot")
    self.character:SetVariable("LootPosition", "Mid")
end

function ISUpgradeDistillStillMedium:stop()
    ISBaseTimedAction.stop(self)
end

function ISUpgradeDistillStillMedium:perform()
    ISBaseTimedAction.perform(self)
end

function ISUpgradeDistillStillMedium:complete()
    self.square:transmitRemoveItemFromSquare(self.still)
    self.square:RemoveTileObject(self.still)

    local inv = self.character:getInventory()

    for _, itemType in ipairs(MEDIUM_STILL_MATERIALS) do
        local newItem = inv:AddItem(itemType)
        sendAddItemToContainer(inv, newItem)
    end

    self.character:Say(getText("IGUI_Moonshine_UpgradeStillLargeDismantled"))

    return true
end

function ISUpgradeDistillStillMedium:getDuration()
    if self.character:isTimedActionInstant() then
        return 1
    end
    return 200
end

function ISUpgradeDistillStillMedium:new(character, still)
    local o = ISBaseTimedAction.new(self, character)
    o.maxTime = o:getDuration()
    o.character = character
    o.still = still
    o.square = still:getSquare()
    return o
end
