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

--

function RecipeCodeOnCreate.GiveBackWhiskeyBottle(recipeData, character)

character:getInventory():AddItem("Base.Whiskey")
print("An empty whiskey bottle back!")end

--

function RecipeCodeOnCreate.GiveBackBeerBottle(recipeData, character)

character:getInventory():AddItem("Base.BeerEmpty")
print("An empty beer bottle back!")end

--

function RecipeCodeOnCreate.GiveBackWineBottle(recipeData, character)

character:getInventory():AddItem("Base.WineOpen")
print("An empty wine bottle back!")end

--

function RecipeCodeOnCreate.GiveBackEmptyJar(recipeData, character)

character:getInventory():AddItem("Base.EmptyJar")
print("An empty jar back!")end

--

function RecipeCodeOnCreate.GiveBackSodaBottle(recipeData, character)

character:getInventory():AddItem("Base.PopBottle")
print("An empty soda bottle back!")end

--

function RecipeCodeOnCreate.GiveBackWaterBottle(recipeData, character)

character:getInventory():AddItem("Base.WaterBottle")
print("An empty water bottle back!")end

--

function RecipeCodeOnCreate.GiveBackSportsBottle(recipeData, character)

character:getInventory():AddItem("Base.Sportsbottle")
print("An empty sports bottle back!")end

--

function RecipeCodeOnCreate.GiveBackBleachBottle(recipeData, character)

character:getInventory():AddItem("Base.Bleach")
print("An empty bleach bottle back!")end

--

function RecipeCodeOnCreate.GiveBackMug(recipeData, character)

character:getInventory():AddItem("Base.Mugl")
print("An empty mug back!")end

--

function RecipeCodeOnCreate.GiveBackMugWhite(recipeData, character)

character:getInventory():AddItem("Base.MugWhite")
print("An empty white mug back!")end

--

function RecipeCodeOnCreate.GiveBackMugSpiffo(recipeData, character)

character:getInventory():AddItem("Base.MugSpiffo")
print("An empty spiffo mug back!")end

--

function RecipeCodeOnCreate.GiveBackKettle(recipeData, character)

character:getInventory():AddItem("Base.Kettle")
print("An empty kettle back!")end

--

function RecipeCodeOnCreate.GiveBackSaucepan(recipeData, character)

character:getInventory():AddItem("Base.Saucepan")
print("An empty saucepan back!")end

--

function RecipeCodeOnCreate.GiveBackBucket(recipeData, character)

character:getInventory():AddItem("Base.BucketEmpty")
print("An empty bucket back!")end

--

function RecipeCodeOnCreate.GiveBackWateringcan(recipeData, character)

character:getInventory():AddItem("Base.WateredCan")
print("An empty watering can back!")end

--

function RecipeCodeOnCreate.GiveBackGasoholDrum(recipeData, character)

character:getInventory():AddItem("Moonshine.EmptyGasoholDrum")
print("An empty gasohol drum back!")end

--

function RecipeCodeOnCreate.GiveBackMotorOilCan(recipeData, character)

character:getInventory():AddItem("Moonshine.EmptyMotorOilCan1")
print("An empty motor oil can back!")end







-- GiveOil and GiveMotorOil removed: converted to native outputs blocks on
-- FillDistillIIIWithMotorOil / RefillMotorOilCanWithMotorOil (sync-gap fix).


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

-- GiveCoalSmall/Medium/Large and GiveWoodSmall/Medium/Large removed: converted
-- to native outputs blocks on RemoveCoalFromDistillI/II/III and
-- RemoveWoodFromDistillI/II/III (sync-gap fix).
--




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






