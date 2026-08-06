require "TimedActions/ISBaseTimedAction"

ISUpgradeDistillStillSmall = ISBaseTimedAction:derive("ISUpgradeDistillStillSmall")

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
    local facing = self.still:getFacing()
    local sprite = "crafted_01_51"
    if facing == IsoDirections.E then
        sprite = "crafted_01_52"
    end

    self.square:transmitRemoveItemFromSquare(self.still)
    self.square:RemoveTileObject(self.still)

    local newstill = self.square:addWorkstationEntity("DistillStillMedium", sprite)
    newstill:sync()

    local inv = self.character:getInventory()
    sendRemoveItemFromContainer(inv, self.filter)
    inv:Remove(self.filter)
    sendRemoveItemFromContainer(inv, self.ductTape)
    inv:Remove(self.ductTape)

    return true
end

function ISUpgradeDistillStillSmall:getDuration()
    if self.character:isTimedActionInstant() then
        return 1
    end
    return 200
end

function ISUpgradeDistillStillSmall:new(character, still, filter, ductTape)
    local o = ISBaseTimedAction.new(self, character)
    o.maxTime = o:getDuration()
    o.character = character
    o.still = still
    o.square = still:getSquare()
    o.filter = filter
    o.ductTape = ductTape
    return o
end
