require "TimedActions/ISBaseTimedAction"

-- Vanilla's own "Transfer Fluids" UI (ISFluidTransferAction -> FluidContainer.CanTransfer)
-- was confirmed broken for portable-item-to-portable-item transfers even between two
-- plain vanilla items (Beer -> empty Wine bottle: animation/progress bar completes,
-- nothing actually transfers). The container itself accepts fluid fine (confirmed via
-- the debug "Add Fluid" cheat, which bypasses CanTransfer entirely) - the bug is in the
-- transfer action's validation, not the container.
--
-- copyFluidsFrom(source) (no amount argument) was tried first, matching how real vanilla
-- WaterDispenser uses it - but live testing found it does NOT respect the target's free
-- capacity for a partial pour: pouring a 5L bucket into a 1.5L pot left the pot "full"
-- (1.5L, correctly capped) but the bucket fully EMPTIED anyway, silently discarding the
-- remaining 3.5L instead of leaving it in the source. copyFluidsFrom appears to mean
-- "transfer everything, capping the target, draining the source regardless" - fine for
-- WaterDispenser (an infinite source), wrong for a finite portable container. Fixed by
-- computing the fluid identity explicitly and using addFluid/removeFluid with the exact
-- clamped amount instead, never calling copyFluidsFrom.
local POURABLE_FLUIDS = { "Moonshine", "RubbingAlcohol", "Petrol" }

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

    if amountToPour > 0 then
        local pouredFluid = nil
        for _, fluidName in ipairs(POURABLE_FLUIDS) do
            local fluid = Fluid.Get(fluidName)
            if fluid ~= nil and sourceCont:contains(fluid) then
                pouredFluid = fluid
                break
            end
        end

        if pouredFluid then
            targetCont:addFluid(pouredFluid, amountToPour)
            sourceCont:removeFluid(amountToPour, false)
        end
    end

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
