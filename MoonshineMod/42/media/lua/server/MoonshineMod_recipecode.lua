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


function Moonshine.GiveDistillPartsMd(items, result, player)


    print("Distill parts back!")




    player:getInventory():AddItem("Base.MetalPipe")
    player:getInventory():AddItem("Base.BucketEmpty")

    player:getInventory():AddItem("Base.Wire")
    player:getInventory():AddItem("Base.Pot")

	player:getInventory():AddItem("Base.SmallSheetMetal")
    player:getInventory():AddItem("Base.PropaneTank")

    player:getInventory():AddItem("Base.BeerCanEmpty")



end

function Moonshine.GiveDistillPartsLg(items, result, player)


    print("Distill parts back!")
	player:getInventory():AddItem("Base.MetalPipe")
	player:getInventory():AddItem("Base.MetalPipe")

    player:getInventory():AddItem("Base.BucketEmpty")

    player:getInventory():AddItem("Base.Wire")
    player:getInventory():AddItem("Base.Pot")

	player:getInventory():AddItem("Base.SmallSheetMetal")
    player:getInventory():AddItem("Base.PropaneTank")

    player:getInventory():AddItem("Base.BeerCanEmpty")



end


function Moonshine.DistillPartsFilter(items, result, player)


    print("filter parts back!")




        player:getInventory():AddItem("Base.MetalPipe")
	    player:getInventory():AddItem("Moonshine.Coal")
	  	player:getInventory():AddItem("Moonshine.Coal")
	  	player:getInventory():AddItem("Moonshine.Coal")

	   player:getInventory():AddItem("Base.SmallSheetMetal")
       player:getInventory():AddItem("Base.BeerCanEmpty")



end

function Moonshine.GiveDistillPartsColumn(items, result, player)


    print("Column parts back!")
	player:getInventory():AddItem("Base.MetalPipe")
	player:getInventory():AddItem("Base.MetalPipe")



    player:getInventory():AddItem("Base.Wire")
    player:getInventory():AddItem("Base.Pot")

	player:getInventory():AddItem("Base.CarBattery1")
    player:getInventory():AddItem("Base.SmallSheetMetal")
    player:getInventory():AddItem("Base.SmallSheetMetal")
    player:getInventory():AddItem("Base.SmallSheetMetal")

    player:getInventory():AddItem("Base.BeerCanEmpty")



end


--

--------------------------------------------------------------------
--------------------------------------------------------------------
--------------------------------------------------------------------
------------------return char:getInventory():contains("Apple");---------------------------------------------------



--
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
