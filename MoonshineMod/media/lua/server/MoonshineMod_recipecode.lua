require "recipecode"
require 'timedactionshelper'

Moonshine = Moonshine or {}


--
--

function Moonshine.GiveDistillMed(items, result, player)

player:getInventory():AddItem("Moonshine.Alc_DistillPotMedium")
print("A medium distll back!")
end

--

function Moonshine.GiveDistillMedEmpty(items, result, player)

player:getInventory():AddItem("Moonshine.DistillPotMedium")
print("A medium empty distll back!")
end

--

function Moonshine.GiveDistillSmallEmpty(items, result, player)

player:getInventory():AddItem("Moonshine.DistillPotSmall")
print("A small empty distll back!")
end

--


function Moonshine.GiveDistillLarge(items, result, player)

player:getInventory():AddItem("Moonshine.Alc_DistillPotLarge")
print("A large distll back!")
end

--

function Moonshine.GiveDistillLargeEmpty(items, result, player)

player:getInventory():AddItem("Moonshine.DistillPotLarge")
print("A large empty distll back!")
end



--

function Moonshine.GiveEmptyPetrol(items, result, player)

player:getInventory():AddItem("Base.EmptyPetrolCan")
print("A empty petrol can back!")
end

--
-- Fill Gasohol Drum recipes (MoonshineMod_DrumRecipes.txt) destroy a bulk quantity of full
-- fuel cans/bottles to fill one drum but never returned the empties - these give them back.

function Moonshine.GiveEmptyPetrolCans20(items, result, player)
for i=1,20 do
player:getInventory():AddItem("Base.EmptyPetrolCan")
end
print("20 empty petrol cans back!")
end

--

function Moonshine.GiveEmptyMotorOilCans80(items, result, player)
for i=1,80 do
player:getInventory():AddItem("Moonshine.EmptyMotorOilCan1")
end
print("80 empty motor oil cans back!")
end

--

function Moonshine.GiveBleachEmpty80(items, result, player)
for i=1,80 do
player:getInventory():AddItem("Base.BleachEmpty")
end
print("80 empty bleach bottles back!")
end

--

function Moonshine.GiveWhiskeyEmpty80(items, result, player)
for i=1,80 do
player:getInventory():AddItem("Base.WhiskeyEmpty")
end
print("80 empty whiskey bottles back!")
end

--

function Moonshine.GiveBeerEmpty80(items, result, player)
for i=1,80 do
player:getInventory():AddItem("Base.BeerEmpty")
end
print("80 empty beer bottles back!")
end

--

function Moonshine.GiveWineEmpty80(items, result, player)
for i=1,80 do
player:getInventory():AddItem("Base.WineEmpty")
end
print("80 empty wine bottles back!")
end







function Moonshine.GiveOil(items, result, player)

--player:getInventory():AddItem("Moonshine.Oil_DistillPotLarge")
player:getInventory():AddItem("Base.RippedSheetsDirty")
print("A Oiler back!")
end




function Moonshine.GiveMotorOil(items, result, player)

player:getInventory():AddItem("Moonshine.MotorOilCan1")
player:getInventory():AddItem("Moonshine.MotorOilCan1")
player:getInventory():AddItem("Moonshine.MotorOilCan1")
player:getInventory():AddItem("Moonshine.MotorOilCan1")
player:getInventory():AddItem("Moonshine.MotorOilCan1")
player:getInventory():AddItem("Moonshine.MotorOilCan1")
player:getInventory():AddItem("Moonshine.MotorOilCan1")
player:getInventory():AddItem("Moonshine.MotorOilCan1")
player:getInventory():AddItem("Base.RippedSheetsDirty")
print("A Oiler back!")
end





function Moonshine.BucketCover(items, result, player)
  local inventory = player:getInventory()
  print("A Tarp back!")

  --function BucketCover(items, result, player)
    local tarpChance = ZombRand(1, 7)

    if tarpChance == 1 then
      player:getInventory():AddItem("Base.RubberBand")
      player:getInventory():AddItem("Base.Tarp")
    elseif tarpChance == 2 then
      player:getInventory():AddItem("Base.Tarp")
      player:getInventory():AddItem("Base.RubberBand")
    elseif tarpChance == 3 then
      player:getInventory():AddItem("Base.RubberBand")
      player:getInventory():AddItem("Base.Tarp")
      player:getInventory():AddItem("Base.RubberBand")
    elseif tarpChance == 4 then
      player:getInventory():AddItem("Base.RubberBand")
      player:getInventory():AddItem("Base.Tarp")
    elseif tarpChance == 5 then
      player:getInventory():AddItem("Base.RubberBand")
      player:getInventory():AddItem("Base.Tarp")
    elseif tarpChance == 6 then
      player:getInventory():AddItem("Base.RubberBand")
      player:getInventory():AddItem("Base.Tarp")
      player:getInventory():AddItem("Base.Button")
    end
  end




--

function Moonshine.GiveCoalSmall(items, result, player)
  
  print("A coal sm back!")
  player:getInventory():AddItem("Moonshine.Coal")
  player:getInventory():AddItem("Moonshine.Coal")
  player:getInventory():AddItem("Moonshine.Coal")
  player:getInventory():AddItem("Moonshine.Coal")
end
--

function Moonshine.GiveCoalMedium(items, result, player)
  
  print("A coal med back!")
  player:getInventory():AddItem("Moonshine.Coal")
  player:getInventory():AddItem("Moonshine.Coal")
  player:getInventory():AddItem("Moonshine.Coal")
  player:getInventory():AddItem("Moonshine.Coal")
  player:getInventory():AddItem("Moonshine.Coal")
  player:getInventory():AddItem("Moonshine.Coal")
end
--
function Moonshine.GiveCoalLarge(items, result, player)
  
  print("A coal lg back!")
  player:getInventory():AddItem("Moonshine.Coal")
  player:getInventory():AddItem("Moonshine.Coal")
  player:getInventory():AddItem("Moonshine.Coal")
  player:getInventory():AddItem("Moonshine.Coal")
  player:getInventory():AddItem("Moonshine.Coal")
  player:getInventory():AddItem("Moonshine.Coal")
  player:getInventory():AddItem("Moonshine.Coal")
  player:getInventory():AddItem("Moonshine.Coal")
end




--

function Moonshine.GiveWoodSmall(items, result, player)
  
  
    print("A branch small back!")
    player:getInventory():AddItem("Base.TreeBranch")
 player:getInventory():AddItem("Base.TreeBranch")
 player:getInventory():AddItem("Base.TreeBranch")
 player:getInventory():AddItem("Base.TreeBranch")
     player:getInventory():AddItem("Base.TreeBranch")
 player:getInventory():AddItem("Base.TreeBranch")

end

--
function Moonshine.GiveWoodMedium(items, result, player)
  
  
    print("A branch small back!")
    player:getInventory():AddItem("Base.TreeBranch")
    player:getInventory():AddItem("Base.TreeBranch")
    player:getInventory():AddItem("Base.TreeBranch")
    player:getInventory():AddItem("Base.TreeBranch")

end
--
function Moonshine.GiveWoodLarge(items, result, player)
  
  
    print("A branch Lg back!")
    player:getInventory():AddItem("Base.TreeBranch")
    player:getInventory():AddItem("Base.TreeBranch")
  

	
     
end
--


-- Realistic cumulative dismantle returns: tearing down an assembled pot recovers
-- everything that ever went into building it up to that tier. Filter/Column come
-- back as intact salvaged components (matching how Downgrade already treats them),
-- not unpacked into their own raw sub-materials.

function Moonshine.GiveDistillPartsSm(items, result, player)
-- Full build cost of Create Distill Pot(I) (ScrapMetal excluded - the recipe's own
-- declared Result already gives that back): BucketEmpty, 2x MetalPipe, Wire,
-- Bleach, Pot, SmallSheetMetal, DuctTape, PropaneTank, BeerCanEmpty.

    print("Distill parts back!")
    player:getInventory():AddItem("Base.BucketEmpty")
    player:getInventory():AddItem("Base.MetalPipe")
    player:getInventory():AddItem("Base.MetalPipe")
    player:getInventory():AddItem("Base.Wire")
    player:getInventory():AddItem("Base.Bleach")
    player:getInventory():AddItem("Base.Pot")
    player:getInventory():AddItem("Base.SmallSheetMetal")
    player:getInventory():AddItem("Base.DuctTape")
    player:getInventory():AddItem("Base.PropaneTank")
    player:getInventory():AddItem("Base.BeerCanEmpty")

end


function Moonshine.GiveDistillPartsMd(items, result, player)
-- Small-tier build cost + Upgrade Distill(I)to(II)'s own cost (DuctTape + the
-- intact DistillPotFilter component, salvageable and dismantlable on its own).

    print("Distill parts back!")
    player:getInventory():AddItem("Base.BucketEmpty")
    player:getInventory():AddItem("Base.MetalPipe")
    player:getInventory():AddItem("Base.MetalPipe")
    player:getInventory():AddItem("Base.Wire")
    player:getInventory():AddItem("Base.Bleach")
    player:getInventory():AddItem("Base.Pot")
    player:getInventory():AddItem("Base.SmallSheetMetal")
    player:getInventory():AddItem("Base.DuctTape")
    player:getInventory():AddItem("Base.PropaneTank")
    player:getInventory():AddItem("Base.BeerCanEmpty")
    player:getInventory():AddItem("Base.DuctTape")
    player:getInventory():AddItem("Moonshine.DistillPotFilter")

end

function Moonshine.GiveDistillPartsLg(items, result, player)
-- Medium-tier cumulative cost + Upgrade Distill(II)to(III)'s own cost (DuctTape +
-- the intact DistillPotColumn component, salvageable and dismantlable on its own).

    print("Distill parts back!")
    player:getInventory():AddItem("Base.BucketEmpty")
    player:getInventory():AddItem("Base.MetalPipe")
    player:getInventory():AddItem("Base.MetalPipe")
    player:getInventory():AddItem("Base.Wire")
    player:getInventory():AddItem("Base.Bleach")
    player:getInventory():AddItem("Base.Pot")
    player:getInventory():AddItem("Base.SmallSheetMetal")
    player:getInventory():AddItem("Base.DuctTape")
    player:getInventory():AddItem("Base.PropaneTank")
    player:getInventory():AddItem("Base.BeerCanEmpty")
    player:getInventory():AddItem("Base.DuctTape")
    player:getInventory():AddItem("Moonshine.DistillPotFilter")
    player:getInventory():AddItem("Base.DuctTape")
    player:getInventory():AddItem("Moonshine.DistillPotColumn")



end


function Moonshine.DistillPartsFilter(items, result, player)
-- Used by Dismantle Charcoal Filter (scraps the filter) - must NOT return a filter.
-- Returns the FULL build cost of Create Distill Coal Filter (ScrapMetal excluded -
-- the recipe's own declared Result already gives that back): 3x MetalPipe, Bleach,
-- OatsRaw, 8x Coal, Wire, DuctTape, BeerCanEmpty.

    print("filter parts back!")

    player:getInventory():AddItem("Base.MetalPipe")
    player:getInventory():AddItem("Base.MetalPipe")
    player:getInventory():AddItem("Base.MetalPipe")
    player:getInventory():AddItem("Base.Bleach")
    player:getInventory():AddItem("Base.OatsRaw")
    for i=1,8 do
        player:getInventory():AddItem("Moonshine.Coal")
    end
    player:getInventory():AddItem("Base.Wire")
    player:getInventory():AddItem("Base.DuctTape")
    player:getInventory():AddItem("Base.BeerCanEmpty")



end

function Moonshine.DowngradeGiveFilter(items, result, player)
-- Used by Downgrade Distill(II)to(I) - must return the filter (that's what makes it a downgrade, not a dismantle).
-- Fixes a long-standing live bug: this recipe used to call DistillPartsFilter (scrap-only),
-- so downgrading never actually returned the DistillPotFilter component.

    print("filter parts + filter back!")

        player:getInventory():AddItem("Base.MetalPipe")
	    player:getInventory():AddItem("Moonshine.Coal")
	  	player:getInventory():AddItem("Moonshine.Coal")
	  	player:getInventory():AddItem("Moonshine.Coal")

	   player:getInventory():AddItem("Base.SmallSheetMetal")
       player:getInventory():AddItem("Base.BeerCanEmpty")
       player:getInventory():AddItem("Moonshine.DistillPotFilter")

end

function Moonshine.GiveDistillPartsColumn(items, result, player)
-- Used by Dismantle Controllable Column (scraps the column) - must NOT return a column.
-- Returns the FULL build cost of Create Controllable Distill Column (ScrapMetal
-- excluded - the recipe's own declared Result already gives that back): Extinguisher,
-- AlarmClock2, CarBattery1, Wire, 5x ElectronicsScrap, DuctTape.

    print("Column parts back!")
    player:getInventory():AddItem("Base.Extinguisher")
    player:getInventory():AddItem("Base.AlarmClock2")
    player:getInventory():AddItem("Base.CarBattery1")
    player:getInventory():AddItem("Base.Wire")
    for i=1,5 do
        player:getInventory():AddItem("Base.ElectronicsScrap")
    end
    player:getInventory():AddItem("Base.DuctTape")



end

function Moonshine.DowngradeGiveColumn(items, result, player)
-- Used by Downgrade Distill(III)to(II) - must return the column (that's what makes it a downgrade, not a dismantle).
-- Fixes a long-standing live bug: this recipe used to call GiveDistillPartsColumn (scrap-only),
-- so downgrading never actually returned the DistillPotColumn component.

    print("Column parts + column back!")
	player:getInventory():AddItem("Base.MetalPipe")
	player:getInventory():AddItem("Base.MetalPipe")

    player:getInventory():AddItem("Base.Wire")
    player:getInventory():AddItem("Base.Pot")

	player:getInventory():AddItem("Base.CarBattery1")
    player:getInventory():AddItem("Base.SmallSheetMetal")
    player:getInventory():AddItem("Base.SmallSheetMetal")
    player:getInventory():AddItem("Base.SmallSheetMetal")

    player:getInventory():AddItem("Base.BeerCanEmpty")
    player:getInventory():AddItem("Moonshine.DistillPotColumn")

end


--

--------------------------------------------------------------------
--------------------------------------------------------------------
--------------------------------------------------------------------
------------------return char:getInventory():contains("Apple");---------------------------------------------------



--
--


function Moonshine.DoubbleFilledReturn(items, result, player)
 local bottleChance = ZombRand(1, 7)
 print("A vessel back!")



  if bottleChance == 1 then
    player:getInventory():AddItem("Base.WhiskeyEmpty")
	player:getInventory():AddItem("Base.WhiskeyEmpty")
	 player:getInventory():AddItem("Base.WaterBottleEmpty")
	  player:getInventory():AddItem("Base.BeerEmpty")
	 	player:getInventory():AddItem("Base.WaterBottleEmpty")
	 	player:getInventory():AddItem("Base.WaterBottleEmpty")
	 
  elseif bottleChance == 2 then
    player:getInventory():AddItem("Base.WaterBottleEmpty")
	player:getInventory():AddItem("Base.WhiskeyEmpty")
	player:getInventory():AddItem("Base.WhiskeyEmpty")
	player:getInventory():AddItem("Base.WaterBottleEmpty")
		player:getInventory():AddItem("Base.WaterBottleEmpty")
			player:getInventory():AddItem("Base.WaterBottleEmpty")
	
  elseif bottleChance == 3 then
    player:getInventory():AddItem("Base.WaterBottleEmpty")
	  player:getInventory():AddItem("Base.EmptyJar")
	player:getInventory():AddItem("Base.WhiskeyEmpty")
	player:getInventory():AddItem("Base.WhiskeyEmpty")
	player:getInventory():AddItem("Base.WaterBottleEmpty")
		player:getInventory():AddItem("Base.WaterBottleEmpty")
	
  elseif bottleChance == 4 then
    player:getInventory():AddItem("Base.PopBottleEmpty")
	 player:getInventory():AddItem("Base.WaterBottleEmpty")
	player:getInventory():AddItem("Base.WhiskeyEmpty")
	player:getInventory():AddItem("Base.WhiskeyEmpty")
	player:getInventory():AddItem("Base.WaterBottleEmpty")
		player:getInventory():AddItem("Base.WaterBottleEmpty")
	
  elseif bottleChance == 5 then
    player:getInventory():AddItem("Base.BeerEmpty")
	  player:getInventory():AddItem("Base.WaterBottleEmpty")
	player:getInventory():AddItem("Base.WhiskeyEmpty")
	player:getInventory():AddItem("Base.WhiskeyEmpty")
	player:getInventory():AddItem("Base.WaterBottleEmpty")
		player:getInventory():AddItem("Base.WaterBottleEmpty")
		
  elseif bottleChance == 6 then
    player:getInventory():AddItem("Base.WineEmpty2")
	  player:getInventory():AddItem("Base.WaterBottleEmpty")
	player:getInventory():AddItem("Base.WhiskeyEmpty")
	player:getInventory():AddItem("Base.WhiskeyEmpty")
	player:getInventory():AddItem("Base.WaterBottleEmpty")
		player:getInventory():AddItem("Base.WaterBottleEmpty")
	
  end
 
end


--




function Moonshine.DoubbleFilledReturnMed(items, result, player)
 local bottleChance = ZombRand(1, 7)
 print("A vessel back!")



    player:getInventory():AddItem("Moonshine.Alc_DistillPotMediumRefillSpirit")

	 

 
end



--
function Moonshine.DoubbleFilledReturnLg(items, result, player)
 local bottleChance = ZombRand(1, 7)
 print("A vessel back!")



    player:getInventory():AddItem("Moonshine.Alc_DistillPotLargeRefillSpirit")

	 

 
end

--



-- checks to make sure using Liquor ro make a Molotov Cocktail requires a full bottle; could be changed to a set amount so the game could have mini-bottles of liquor, for example.
function Moonshine.FullPetrol(item)
	if not item:hasTag("Petrol") then return true end
    return item:getUsedDelta() == 1
end

--
--


function Moonshine.CheckDrumXD(item, result, player)
    print("CheckDrum")
    local drum = item:getType()
    local condition = 12
    
    -- print("Main item: " .. item:getName())
    
    if drum == "EmptyGasoholDrum" then
        print("Main item no name: " .. drum)
      	
    end
end



--
--



Events.OnTick.Add(Tick);