Moonshine = Moonshine or {}
RecipeCodeOnCreate = RecipeCodeOnCreate or {}


--
--

function RecipeCodeOnCreate.GiveDistillMed(recipeData, character)

character:getInventory():AddItem("Moonshine.Alc_DistillPotMedium")
print("A medium distll back!")end

--

function RecipeCodeOnCreate.GiveDistillMedEmpty(recipeData, character)

character:getInventory():AddItem("Moonshine.DistillPotMedium")
print("A medium empty distll back!")end

--

function RecipeCodeOnCreate.GiveDistillSmallEmpty(recipeData, character)

character:getInventory():AddItem("Moonshine.DistillPotSmall")
print("A small empty distll back!")end

--


function RecipeCodeOnCreate.GiveDistillLarge(recipeData, character)

character:getInventory():AddItem("Moonshine.Alc_DistillPotLarge")
print("A large distll back!")end

--

function RecipeCodeOnCreate.GiveDistillLargeEmpty(recipeData, character)

character:getInventory():AddItem("Moonshine.DistillPotLarge")
print("A large empty distll back!")end



--

function RecipeCodeOnCreate.GiveEmptyPetrol(recipeData, character)

character:getInventory():AddItem("Base.EmptyPetrolCan")
print("A empty petrol can back!")end







function RecipeCodeOnCreate.GiveOil(recipeData, character)

--character:getInventory():AddItem("Moonshine.Oil_DistillPotLarge")
character:getInventory():AddItem("Base.RippedSheetsDirty")
print("A Oiler back!")end




function RecipeCodeOnCreate.GiveMotorOil(recipeData, character)

character:getInventory():AddItem("Moonshine.MotorOilCan1")
character:getInventory():AddItem("Moonshine.MotorOilCan1")
character:getInventory():AddItem("Moonshine.MotorOilCan1")
character:getInventory():AddItem("Moonshine.MotorOilCan1")
character:getInventory():AddItem("Moonshine.MotorOilCan1")
character:getInventory():AddItem("Moonshine.MotorOilCan1")
character:getInventory():AddItem("Moonshine.MotorOilCan1")
character:getInventory():AddItem("Moonshine.MotorOilCan1")
character:getInventory():AddItem("Base.RippedSheetsDirty")
print("A Oiler back!")end





function RecipeCodeOnCreate.BucketCover(recipeData, character)
  local inventory = character:getInventory()
  print("A Tarp back!")

  --function BucketCover(items, result, character)
    local tarpChance = ZombRand(1, 7)

    if tarpChance == 1 then
      character:getInventory():AddItem("Base.RubberBand")
      character:getInventory():AddItem("Base.Tarp")
    elseif tarpChance == 2 then
      character:getInventory():AddItem("Base.Tarp")
      character:getInventory():AddItem("Base.RubberBand")
    elseif tarpChance == 3 then
      character:getInventory():AddItem("Base.RubberBand")
      character:getInventory():AddItem("Base.Tarp")
      character:getInventory():AddItem("Base.RubberBand")
    elseif tarpChance == 4 then
      character:getInventory():AddItem("Base.RubberBand")
      character:getInventory():AddItem("Base.Tarp")
    elseif tarpChance == 5 then
      character:getInventory():AddItem("Base.RubberBand")
      character:getInventory():AddItem("Base.Tarp")
    elseif tarpChance == 6 then
      character:getInventory():AddItem("Base.RubberBand")
      character:getInventory():AddItem("Base.Tarp")
      character:getInventory():AddItem("Base.Button")
    end
end

--

function RecipeCodeOnCreate.GiveCoalSmall(recipeData, character)

  print("A coal sm back!")
  character:getInventory():AddItem("Moonshine.Coal")
  character:getInventory():AddItem("Moonshine.Coal")
  character:getInventory():AddItem("Moonshine.Coal")
  character:getInventory():AddItem("Moonshine.Coal")
end
--

function RecipeCodeOnCreate.GiveCoalMedium(recipeData, character)
  
  print("A coal med back!")
  character:getInventory():AddItem("Moonshine.Coal")
  character:getInventory():AddItem("Moonshine.Coal")
  character:getInventory():AddItem("Moonshine.Coal")
  character:getInventory():AddItem("Moonshine.Coal")
  character:getInventory():AddItem("Moonshine.Coal")
  character:getInventory():AddItem("Moonshine.Coal")end
--
function RecipeCodeOnCreate.GiveCoalLarge(recipeData, character)
  
  print("A coal lg back!")
  character:getInventory():AddItem("Moonshine.Coal")
  character:getInventory():AddItem("Moonshine.Coal")
  character:getInventory():AddItem("Moonshine.Coal")
  character:getInventory():AddItem("Moonshine.Coal")
  character:getInventory():AddItem("Moonshine.Coal")
  character:getInventory():AddItem("Moonshine.Coal")
  character:getInventory():AddItem("Moonshine.Coal")
  character:getInventory():AddItem("Moonshine.Coal")end




--

function RecipeCodeOnCreate.GiveWoodSmall(recipeData, character)
  
  
    print("A branch small back!")
    character:getInventory():AddItem("Base.TreeBranch")
 character:getInventory():AddItem("Base.TreeBranch")
 character:getInventory():AddItem("Base.TreeBranch")
 character:getInventory():AddItem("Base.TreeBranch")
     character:getInventory():AddItem("Base.TreeBranch")
 character:getInventory():AddItem("Base.TreeBranch")
end

--
function RecipeCodeOnCreate.GiveWoodMedium(recipeData, character)
  
  
    print("A branch small back!")
    character:getInventory():AddItem("Base.TreeBranch")
    character:getInventory():AddItem("Base.TreeBranch")
    character:getInventory():AddItem("Base.TreeBranch")
    character:getInventory():AddItem("Base.TreeBranch")
end
--
function RecipeCodeOnCreate.GiveWoodLarge(recipeData, character)
  
  
    print("A branch Lg back!")
    character:getInventory():AddItem("Base.TreeBranch")
    character:getInventory():AddItem("Base.TreeBranch")
  

	
     end
--


function RecipeCodeOnCreate.GiveDistillPartsSm(recipeData, character)
  
  
    print("Distill parts back!")
	



    character:getInventory():AddItem("Base.MetalPipe")
    character:getInventory():AddItem("Base.Pot")
	
	character:getInventory():AddItem("Base.SmallSheetMetal")
    character:getInventory():AddItem("Base.PropaneTank")
	
    character:getInventory():AddItem("Base.BeerCanEmpty")
 

end


function RecipeCodeOnCreate.GiveDistillPartsMd(recipeData, character)
  
  
    print("Distill parts back!")
	



    character:getInventory():AddItem("Base.MetalPipe")
    character:getInventory():AddItem("Base.BucketEmpty")

    character:getInventory():AddItem("Base.Wire")
    character:getInventory():AddItem("Base.Pot")
	
	character:getInventory():AddItem("Base.SmallSheetMetal")
    character:getInventory():AddItem("Base.PropaneTank")
	
    character:getInventory():AddItem("Base.BeerCanEmpty")
 

end

function RecipeCodeOnCreate.GiveDistillPartsLg(recipeData, character)
  
  
    print("Distill parts back!")
	character:getInventory():AddItem("Base.MetalPipe")
	character:getInventory():AddItem("Base.MetalPipe")
	  
    character:getInventory():AddItem("Base.BucketEmpty")

    character:getInventory():AddItem("Base.Wire")
    character:getInventory():AddItem("Base.Pot")
	
	character:getInventory():AddItem("Base.SmallSheetMetal")
    character:getInventory():AddItem("Base.PropaneTank")
	
    character:getInventory():AddItem("Base.BeerCanEmpty")
 

end


function RecipeCodeOnCreate.DistillPartsFilter(recipeData, character)
-- Used by DismantleCharcoalFilter (scraps the filter) - must NOT return a filter.

    print("filter parts back!")



        character:getInventory():AddItem("Base.MetalPipe")
	    character:getInventory():AddItem("Moonshine.Coal")
	  	character:getInventory():AddItem("Moonshine.Coal")
	  	character:getInventory():AddItem("Moonshine.Coal")

	   character:getInventory():AddItem("Base.SmallSheetMetal")
       character:getInventory():AddItem("Base.BeerCanEmpty")

end

function RecipeCodeOnCreate.DowngradeGiveFilter(recipeData, character)
-- Used by DowngradeDistillIIToI - must return the filter (that's what makes it a downgrade, not a dismantle).

    print("filter parts + filter back!")

        character:getInventory():AddItem("Base.MetalPipe")
	    character:getInventory():AddItem("Moonshine.Coal")
	  	character:getInventory():AddItem("Moonshine.Coal")
	  	character:getInventory():AddItem("Moonshine.Coal")

	   character:getInventory():AddItem("Base.SmallSheetMetal")
       character:getInventory():AddItem("Base.BeerCanEmpty")
       character:getInventory():AddItem("Moonshine.DistillPotFilter")

end

function RecipeCodeOnCreate.GiveDistillPartsColumn(recipeData, character)
-- Used by DismantleControllableColumn (scraps the column) - must NOT return a column.

    print("Column parts back!")
	character:getInventory():AddItem("Base.MetalPipe")
	character:getInventory():AddItem("Base.MetalPipe")

    character:getInventory():AddItem("Base.Wire")
    character:getInventory():AddItem("Base.Pot")

	character:getInventory():AddItem("Base.CarBattery1")
    character:getInventory():AddItem("Base.SmallSheetMetal")
    character:getInventory():AddItem("Base.SmallSheetMetal")
    character:getInventory():AddItem("Base.SmallSheetMetal")

    character:getInventory():AddItem("Base.BeerCanEmpty")

end

function RecipeCodeOnCreate.DowngradeGiveColumn(recipeData, character)
-- Used by DowngradeDistillIIIToII - must return the column (that's what makes it a downgrade, not a dismantle).

    print("Column parts + column back!")
	character:getInventory():AddItem("Base.MetalPipe")
	character:getInventory():AddItem("Base.MetalPipe")

    character:getInventory():AddItem("Base.Wire")
    character:getInventory():AddItem("Base.Pot")

	character:getInventory():AddItem("Base.CarBattery1")
    character:getInventory():AddItem("Base.SmallSheetMetal")
    character:getInventory():AddItem("Base.SmallSheetMetal")
    character:getInventory():AddItem("Base.SmallSheetMetal")

    character:getInventory():AddItem("Base.BeerCanEmpty")
    character:getInventory():AddItem("Moonshine.DistillPotColumn")

end


--

--------------------------------------------------------------------
--------------------------------------------------------------------
--------------------------------------------------------------------
------------------return char:getInventory():contains("Apple");---------------------------------------------------



--
--


function RecipeCodeOnCreate.DoubbleFilledReturn(recipeData, character)
 local bottleChance = ZombRand(1, 7)
 print("A vessel back!")



  if bottleChance == 1 then
    character:getInventory():AddItem("Base.WhiskeyEmpty")
	character:getInventory():AddItem("Base.WhiskeyEmpty")
	 character:getInventory():AddItem("Base.WaterBottleEmpty")
	  character:getInventory():AddItem("Base.BeerEmpty")
	 	character:getInventory():AddItem("Base.WaterBottleEmpty")
	 	character:getInventory():AddItem("Base.WaterBottleEmpty")
	 
  elseif bottleChance == 2 then
    character:getInventory():AddItem("Base.WaterBottleEmpty")
	character:getInventory():AddItem("Base.WhiskeyEmpty")
	character:getInventory():AddItem("Base.WhiskeyEmpty")
	character:getInventory():AddItem("Base.WaterBottleEmpty")
		character:getInventory():AddItem("Base.WaterBottleEmpty")
			character:getInventory():AddItem("Base.WaterBottleEmpty")
	
  elseif bottleChance == 3 then
    character:getInventory():AddItem("Base.WaterBottleEmpty")
	  character:getInventory():AddItem("Base.EmptyJar")
	character:getInventory():AddItem("Base.WhiskeyEmpty")
	character:getInventory():AddItem("Base.WhiskeyEmpty")
	character:getInventory():AddItem("Base.WaterBottleEmpty")
		character:getInventory():AddItem("Base.WaterBottleEmpty")
	
  elseif bottleChance == 4 then
    character:getInventory():AddItem("Base.PopBottleEmpty")
	 character:getInventory():AddItem("Base.WaterBottleEmpty")
	character:getInventory():AddItem("Base.WhiskeyEmpty")
	character:getInventory():AddItem("Base.WhiskeyEmpty")
	character:getInventory():AddItem("Base.WaterBottleEmpty")
		character:getInventory():AddItem("Base.WaterBottleEmpty")
	
  elseif bottleChance == 5 then
    character:getInventory():AddItem("Base.BeerEmpty")
	  character:getInventory():AddItem("Base.WaterBottleEmpty")
	character:getInventory():AddItem("Base.WhiskeyEmpty")
	character:getInventory():AddItem("Base.WhiskeyEmpty")
	character:getInventory():AddItem("Base.WaterBottleEmpty")
		character:getInventory():AddItem("Base.WaterBottleEmpty")
		
  elseif bottleChance == 6 then
    character:getInventory():AddItem("Base.WineEmpty2")
	  character:getInventory():AddItem("Base.WaterBottleEmpty")
	character:getInventory():AddItem("Base.WhiskeyEmpty")
	character:getInventory():AddItem("Base.WhiskeyEmpty")
	character:getInventory():AddItem("Base.WaterBottleEmpty")
		character:getInventory():AddItem("Base.WaterBottleEmpty")
	
  end
 end


--




function RecipeCodeOnCreate.DoubbleFilledReturnMed(recipeData, character)
 local bottleChance = ZombRand(1, 7)
 print("A vessel back!")



    character:getInventory():AddItem("Moonshine.Alc_DistillPotMediumRefillSpirit")

	 

 end



--
function RecipeCodeOnCreate.DoubbleFilledReturnLg(recipeData, character)
 local bottleChance = ZombRand(1, 7)
 print("A vessel back!")



    character:getInventory():AddItem("Moonshine.Alc_DistillPotLargeRefillSpirit")

	 

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

function RecipeCodeOnCreate.GiveEmptyMotorOilCans80(recipeData, character)
-- Used by FillGasoholDrum2 (80x Moonshine.MotorOilPetrolCan consumed) - returns the 80 emptied cans.
    for i=1,80 do
        character:getInventory():AddItem("Moonshine.EmptyMotorOilCan1")
    end
end

function RecipeCodeOnCreate.GiveEmptyBeerBottles80(recipeData, character)
-- Used by FillGasoholDrum5 (80x Moonshine.BeerPetrolCan consumed) - returns the 80 emptied bottles.
    for i=1,80 do
        character:getInventory():AddItem("Base.BeerEmpty")
    end
end



