require "TimedActions/ISBaseTimedAction"

ISUpgradeDistillStillSmall = ISBaseTimedAction:derive("ISUpgradeDistillStillSmall")

-- addWorkstationEntity("DistillStillMediumUpgraded", ...) was tried here to swap
-- the Small still directly into a Medium in place. It failed 100% of the time in
-- live MP testing (300+ retries across ticks, never once succeeded), even though
-- the entity script itself is valid (clean server boot, no duplicate/invalid
-- SpriteConfig warnings tied to it). Not a content/config issue on our side -
-- addWorkstationEntity is unreliable for a freshly-introduced entity type in this
-- build. Dropped entirely. Instead: dismantle the Small still, refund its build
-- materials, and let the player build the Medium through the normal crafting
-- menu - the one entity-creation path that has been reliable all along.

local SMALL_STILL_MATERIALS = {
    "Base.BucketEmpty",
    "Base.MetalPipe",
    "Base.MetalPipe",
    "Base.ScrapMetal",
    "Base.Wire",
    "Base.Pot",
    "Base.SmallSheetMetal",
    "Base.DuctTape",
    "Base.PropaneTank",
}

function ISUpgradeDistillStillSmall:isValid()
    return self.still and self.still:getSquare() ~= nil
end

function ISUpgradeDistillStillSmall:waitToStart()
    self.character:faceThisObject(self.still)
    return self.character:shouldBeTurning()
end

function ISUpgradeDistillStillSmall:update()
    self.character:faceThisObject(self.still)
    self.character:setMetabolicTarget(Metabolics.HeavyDomestic)
end

function ISUpgradeDistillStillSmall:start()
    self:setActionAnim("Loot")
    self.character:SetVariable("LootPosition", "Mid")
end

function ISUpgradeDistillStillSmall:stop()
    ISBaseTimedAction.stop(self)
end

function ISUpgradeDistillStillSmall:perform()
    ISBaseTimedAction.perform(self)
end

function ISUpgradeDistillStillSmall:complete()
    self.square:transmitRemoveItemFromSquare(self.still)
    self.square:RemoveTileObject(self.still)

    local inv = self.character:getInventory()

    for _, itemType in ipairs(SMALL_STILL_MATERIALS) do
        local newItem = inv:AddItem(itemType)
        sendAddItemToContainer(inv, newItem)
    end

    self.character:Say(getText("IGUI_Moonshine_UpgradeStillDismantled"))

    return true
end

function ISUpgradeDistillStillSmall:getDuration()
    if self.character:isTimedActionInstant() then
        return 1
    end
    return 200
end

function ISUpgradeDistillStillSmall:new(character, still)
    local o = ISBaseTimedAction.new(self, character)
    o.maxTime = o:getDuration()
    o.character = character
    o.still = still
    o.square = still:getSquare()
    return o
end
