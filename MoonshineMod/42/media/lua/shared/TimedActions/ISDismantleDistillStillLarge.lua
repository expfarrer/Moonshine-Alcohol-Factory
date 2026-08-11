require "TimedActions/ISBaseTimedAction"

-- Large has no tier above it to upgrade into, so it needs its own standalone
-- dismantle action (Small/Medium get this for free as a side effect of their
-- upgrade actions). Same proven pattern: remove entity, refund materials.

ISDismantleDistillStillLarge = ISBaseTimedAction:derive("ISDismantleDistillStillLarge")

local LARGE_STILL_MATERIALS = {
    "Base.BucketEmpty",
    "Base.MetalPipe",
    "Base.MetalPipe",
    "Base.MetalPipe",
    "Base.MetalPipe",
    "Base.ScrapMetal",
    "Base.ScrapMetal",
    "Base.Wire",
    "Base.Wire",
    "Base.Wire",
    "Base.Pot",
    "Base.SmallSheetMetal",
    "Base.SmallSheetMetal",
    "Base.DuctTape",
    "Base.DuctTape",
    "Base.PropaneTank",
    "Base.BeerCanEmpty",
    "Base.CarBattery1",
    "Moonshine.DistillPotColumn",
}

function ISDismantleDistillStillLarge:isValid()
    return self.still and self.still:getSquare() ~= nil
end

function ISDismantleDistillStillLarge:waitToStart()
    self.character:faceThisObject(self.still)
    return self.character:shouldBeTurning()
end

function ISDismantleDistillStillLarge:update()
    self.character:faceThisObject(self.still)
    self.character:setMetabolicTarget(Metabolics.HeavyDomestic)
end

function ISDismantleDistillStillLarge:start()
    self:setActionAnim("Loot")
    self.character:SetVariable("LootPosition", "Mid")
end

function ISDismantleDistillStillLarge:stop()
    ISBaseTimedAction.stop(self)
end

function ISDismantleDistillStillLarge:perform()
    ISBaseTimedAction.perform(self)
end

function ISDismantleDistillStillLarge:complete()
    self.square:transmitRemoveItemFromSquare(self.still)
    self.square:RemoveTileObject(self.still)

    local inv = self.character:getInventory()

    for _, itemType in ipairs(LARGE_STILL_MATERIALS) do
        local newItem = inv:AddItem(itemType)
        sendAddItemToContainer(inv, newItem)
    end

    self.character:Say(getText("IGUI_Moonshine_DismantleStillLargeDismantled"))

    return true
end

function ISDismantleDistillStillLarge:getDuration()
    if self.character:isTimedActionInstant() then
        return 1
    end
    return 200
end

function ISDismantleDistillStillLarge:new(character, still)
    local o = ISBaseTimedAction.new(self, character)
    o.maxTime = o:getDuration()
    o.character = character
    o.still = still
    o.square = still:getSquare()
    return o
end
