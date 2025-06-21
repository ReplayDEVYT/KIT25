local Settings = {

	--==============FILE LOCATION==============--
	
	toolFolder = game:WaitForChild("ServerStorage"):WaitForChild("AllTools") --Replace this with the TOOLS folder/model.
   ,lootFolder = game:WaitForChild("ReplicatedStorage"):WaitForChild("ACS_Engine"):WaitForChild("GunModels"):WaitForChild("Server") --Server gun storage.
   ,customPlrLoot = game:WaitForChild("ReplicatedStorage").BagPart --The model, set up the same as a loot container, without the script, to use if ragdoll is false.
	
	--==========RESPAWN CONFIGURATION==========--
	
   ,cooldown = 1 --Respawn cooldown/timer in minutes.
   ,replace = false --Will a respawn cycle replace the currently spawned weapon?

	--=================LOOTING=================--
	
   ,button = "F" --What key is pressed to loot the weapon?
   ,lootRange = 5 --Range in studs at which you can loot a weapon.
   ,dropLoot = true --Should the loot drop on death?
   ,lootClear = 999 --How long should bodies stay in minutes?
   ,lootSave = false --Should player loot save?
   ,plrLooting = true --Allow player looting?	
	
	--=================CAMERAS=================--

   ,firstPerson = false --Lock the camera in first person?
	
	--==================OTHER==================--
	
   ,ragdoll = true --Should the dead players ragdoll?
}

return Settings
