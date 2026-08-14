require "TimedActions/ISBaseTimedAction"

-- Vanilla's own "Transfer Fluids" UI (ISFluidTransferAction -> FluidContainer.CanTransfer)
-- was confirmed broken for portable-item-to-portable-item transfers even between two
-- plain vanilla items (Beer -> empty Wine bottle: animation/progress bar completes,
-- nothing actually transfers). The container itself accepts fluid fine (confirmed via
-- the debug "Add Fluid" cheat, which bypasses CanTransfer entirely) - the bug is in the
-- transfer action's validation, not the container. Real vanilla WaterDispenser sidesteps
-- this the same way: never uses the generic Transfer UI, calls
-- fluidContainer:copyFluidsFrom(other) directly from its own Lua. Doing the same here.

ISPourMoonshineFluidAction = ISBaseTimedAction:derive("ISPourMoonshineFluidAction")

function ISPourMoonshineFluidAction:isValid()
    return self.source and self.target
        and self.source:getFluidContainer() and self.target:getFluidContainer()
        and not self.source:getFluidContainer():isEmpty()
end

function ISPourMoonshineFluidAction:waitToStart()
    return self.character:shouldBeTurning()
end

function ISPourMoonshineFluidAction:update()
    self.character:setMetabolicTarget(Metabolics.LightDomestic)
end

function ISPourMoonshineFluidAction:start()
    self:setActionAnim("MixFluids")
    self.sound = self.character:playSound("TransferLiquid")
end

function ISPourMoonshineFluidAction:stop()
    if self.sound and self.character:getEmitter():isPlaying(self.sound) then
        self.character:stopOrTriggerSound(self.sound)
    end
    ISBaseTimedAction.stop(self)
end

function ISPourMoonshineFluidAction:perform()
    if self.sound and self.character:getEmitter():isPlaying(self.sound) then
        self.character:stopOrTriggerSound(self.sound)
    end
    ISBaseTimedAction.perform(self)
end

function ISPourMoonshineFluidAction:complete()
    local sourceCont = self.source:getFluidContainer()
    local targetCont = self.target:getFluidContainer()

    local amountToPour = math.min(sourceCont:getAmount(), targetCont:getFreeCapacity())

    targetCont:copyFluidsFrom(sourceCont)
    sourceCont:removeFluid(amountToPour, false)

    self.source:syncItemFields()
    self.target:syncItemFields()

    return true
end

function ISPourMoonshineFluidAction:getDuration()
    if self.character:isTimedActionInstant() then
        return 1
    end
    return 50
end

function ISPourMoonshineFluidAction:new(character, source, target)
    local o = ISBaseTimedAction.new(self, character)
    o.maxTime = o:getDuration()
    o.character = character
    o.source = source
    o.target = target
    return o
end
