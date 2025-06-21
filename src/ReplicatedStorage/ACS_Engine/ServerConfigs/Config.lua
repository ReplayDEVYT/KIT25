local ServerConfig = {
----------------------------------------------------------------------------------------------------
-----------------=[ General ]=----------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
	 TeamKill = true					--- Enable TeamKill?
	,TeamDamageMultiplier = 1			--- Between 0-1 | This will make you cause less damage if you hit your teammate
	,MaxRagdollBlood = 35
	,ReplicatedBullets = true			--- Keep in mind that some bullets will pass through surfaces...
	,BulletSplash = true				--- Shrapnel damage to bullets shot near you
	
	,AntiBunnyHop = true				--- Enable anti bunny hop system?
	,JumpCoolDown = 1					--- Seconds before you can jump again
	,JumpPower = 24						--- Jump power, default is 50
	
	,RealisticLaser = true				--- True = Laser line is invisible
	,ReplicatedLaser = true				
	,ReplicatedFlashlight = true
	
	,EnableRagdoll = true				--- Enable ragdoll death?
	,TeamTags = false					--- Aaaaaaa
	,HitmarkerSound = false				--- GGWP MLG 360 NO SCOPE xD
----------------------------------------------------------------------------------------------------
------------------=[ Core GUI ]=--------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
	,CoreGuiHealth = false				--- Enable Health Bar?
	,CoreGuiPlayerList = false			--- Enable Player List?
	,TopBarTransparency = 1
----------------------------------------------------------------------------------------------------
------------------=[ Status UI ]=-------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
	,EnableStatusUI = true				--- Don't disabled it...
	,RunWalkSpeed = 19
	,NormalWalkSpeed = 13.242
	,SlowPaceWalkSpeed = 6	
	,CrouchWalkSpeed = 6
	,ProneWalkSpeed = 4

	,EnableHunger = true				--- Hunger and Thirst system
	,MetabolismWaitTime = 60	

	,CanDrown = true 					--- Welp.. That's it
	
	,EnableStamina = true 				--- Weapon Sway based on stamina	
	,RunValue = 0.5						--- Stamina consumption
	,AimValue = 0.1						--- Stamina consumption on arms when aiming
	,StandRecover = 1.25					--- Stamina recovery while stading
	,CrouchRecover = 1.25					--- Stamina recovery while crouching
	,ProneRecover = 1.25				--- Stamina recovery while lying
	,EnableGPS = true					--- GPS shows your allies around you
	,GPSdistance = 100

	,InteractionMenuKey = Enum.KeyCode.LeftControl
----------------------------------------------------------------------------------------------------
----------------=[ Medic System ]=------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
	,EnableMedSys = true
	,BleedDamage = 25					--- The damage needed to start bleeding
	,InjuredDamage = 57					--- The damage needed to get injured
	,KODamage = 90						--- The damage needed to pass out
	,PainMult = 1						--- 
	,BloodMult = 0.025					--- 

	,EnableFallDamage = true			--- Enable Fall Damage?
	,MaxVelocity = 75					--- Velocity that will trigger the damage
	,DamageMult = 1 					--- The min time a player has to fall in order to take fall damage.
	
	----------------------------------------------------------------------------------------------------
	----------------=[ Wallbang Settings ]=-------------------------------------------------------------
	----------------------------------------------------------------------------------------------------
	--- EXPERIMENTAL

	,WallbangEnabled = true
	,WallbangDamage = true		-- Bullet damage diminished from wallbang

	,WallbangConstant = 0.825		-- Wallbang penetration constant - higher values = stronger bullets

	,WallbangMaterialHardness = {	-- resistance to wallbang penetration of each material
		default = 1.2,			-- default material hardness, DO NOT DELETE
		Concrete = 1.2,
		Brick = 1.2,

		Wood = 0.225,
		WoodPlanks = 0.225,

		Metal = 5,
		DiamondPlate = 5,
		CorrodedMetal = 5,

		Grass = 0.8,
		LeafyGrass = 0.8,
		Dirt = 0.8,
		Ground = 0.8,

		Mud = 0.5,
		Sand = 0.5,

		Snow = 0.3,
		Fabric = 0.3,

		Glass = 0.3,
		Neon = 0.3,
	}

	,WallbangSpecialNames = { -- parts with special names will override material based wallbang resistance
		BulletproofGlass = 2,
		Stomach = 900,
	}

	,WallbangBulletIndex = { -- penetrative power per bullet caliber, first fallback values when not specified in gun
		[".50 BMG"] = 3,
	}

----------------------------------------------------------------------------------------------------
--------------------=[ Others ]=--------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
	,VehicleMaxZoom = 15
	,RicochetEnabled = true		-- bullets can bounce off of surfaces 

	-- Max angle between incident path of bullet and the surface of the object for ricochet to happen (degrees)
	,RicochetMaterialMaxAngles = {
		default = 5,			-- default material max angle for ricochet, DO NOT DELETE

		Wood = 1,
		WoodPlanks = 1,

		Metal = 15,
		DiamondPlate = 15,
		CorrodedMetal = 15,

		Grass = 3,
		LeafyGrass = 3,
		Dirt = 3,
		Ground = 3,
		Sand = 3,

		Mud = 0,

		Snow = 0,
		Fabric = 0,
	}

	,RicochetLoss = 0.35			-- energy lost from richochet
	,AimRecoverDuration = .5
}

return ServerConfig
