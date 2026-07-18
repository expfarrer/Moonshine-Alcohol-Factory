TestItemIcon = {}

function TestItemIcon.loadTextures()
        getTexture("DistillPot.png");
	getTexture("WaterDistillPot.png");
        getTexture("DistillPotMash.png");
print("Moonshien Mod - textures loaded !")

	
end


Events.OnGameBoot.Add(TestItemIcon.loadTextures);


