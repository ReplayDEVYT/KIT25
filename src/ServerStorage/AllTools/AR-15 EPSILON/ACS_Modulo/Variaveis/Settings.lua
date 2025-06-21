local Tool = script.Parent.Parent.Parent
local ACS = Tool:WaitForChild("ACS_Modulo")
local Var = ACS:WaitForChild("Variaveis")

local Config = {

----------------------------------------------------------------------------------------------------
---------------------=[ GERAL ]=--------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
	 Name = "Epsilon M4A1"
	,BulletType = "5.56x45mm M856A1"
	,Ammo = Var.Ammo.Value
	,ChangeFOV = {60, 50}
	,ZoomAnim = true
	,FocusOnSight = false
	,FocusOnSight2 = false
	,MagCount = true
	,Bullets = 1
	,FireRate = 800
	,BurstFireRate = 900
	,BurstShot = 3
	,GunType = 1				--- 1 - Rifle, 2 - Shotgun
	,ReloadType = 1				--- 1 - Magazine, 2 - Shell inserting
	,Mode = "Auto"				--- Semi, Burst, Auto, Explosive || Bolt-Action, Pump-Action
	,FireModes = {
		ChangeFiremode = true;		
		Semi = true;
		Burst = false;
		Auto = true;
		Explosive = false;}
----------------------------------------------------------------------------------------------------
-----------------------=[ PUMP-ACTION ]=------------------------------------------------------------
----------------------------------------------------------------------------------------------------
	,AutoChamber = false
	,ChamberWhileAim = false
----------------------------------------------------------------------------------------------------
-----------------=[ RECOIL & PRECISAO ]=------------------------------------------------------------
----------------------------------------------------------------------------------------------------
	,VRecoil = {4,6}				--- Vertical Recoil
	,HRecoil = {1.125,2.5}				--- Horizontal Recoil
	,AimRecover = .65				---- Between 0 & 1
	,rMain = 0.125					--dont even change this
	,hStep = {-.75,.75}				--horizontalStep, horizontal spread of the weapon
	,tStep = 0.15					--timeStep, might not wanna change this
	,vStep = {2.5,3}					--verticalStep, ok you probably shouldnt change any of these
	
	,RecoilPunch = .15
	,VPunchBase = 2.55				--- Vertical Punch
	,HPunchBase = 1.6				--- Horizontal Punch
	,DPunchBase = 1 				--- Tilt Punch | useless
	
	,AimRecoilReduction = 5 		--- Recoil Reduction Factor While Aiming (Do not set to 0)
	,PunchRecover = 0.2
	,MinRecoilPower = 0.88
	,MaxRecoilPower = 3
	,RecoilPowerStepAmount = .25
	
	,MinSpread = 0.56				--- Min bullet spread value | Studs
	,MaxSpread = 35					--- Max bullet spread value | Studs
	,AimInaccuracyStepAmount = 0.5
	,WalkMultiplier = 0				--- Bullet spread based on player speed
	
	,SwayBase = 0.05				--- Weapon Base Sway | Studs
	,MaxSway =	0.5					--- Max sway value based on player stamina | Studs
	----------------------------------------------------------------------------------------------------
	---------------------=[ DANO ]=---------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------
	,LimbsDamage = {45,51}
	,TorsoDamage = {45,51}
	,HeadDamage = {111,169}
	,BulletPenetration = 52			 ---- Between 0 & 100%
	,FallOfDamage = .9
	----------------------------------------------------------------------------------------------------
	-------------------=[ PROJETIL ]=-------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------
	,Distance = 10000
	,BDrop = .25
	,BSpeed = 947
	
	,SuppressMaxDistance = 25	--- Studs
	,SuppressTime = 10			--- Seconds
	
	,BulletWhiz = true
	,BWEmitter = 25
	,BWMaxDistance = 200
	
	,BulletFlare = false
	,BulletFlareColor = Color3.fromRGB(255,255,255)
	
	,Tracer = true
	,TracerColor = Color3.fromRGB(255,55,45)
	,TracerLightEmission = 1
	,TracerLightInfluence = 0
	,TracerLifeTime = .05
	,TracerWidth = .3
	,RandomTracer = false
	,TracerEveryXShots = 1
	,TracerChance = 100
	
	,BulletLight = true
	,BulletLightBrightness = 4
	,BulletLightColor = Color3.fromRGB(255,55,25)
	,BulletLightRange = 10

	,ExplosiveHit = false
	,ExPressure = 500
	,ExpRadius = 25
	,DestroyJointRadiusPercent = 0	--- Between 0 & 1
	,ExplosionDamage = 100

	,LauncherDamage = 100
	,LauncherRadius = 25
	,LauncherPressure = 500
	,LauncherDestroyJointRadiusPercent = 0
----------------------------------------------------------------------------------------------------
--------------------=[ OUTROS ]=--------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
	,FastReload = true					--- Automatically operates the bolt on reload if needed
	,SlideLock = true
	,MoveBolt = false
	,BoltLock = false
	,CanBreachDoor = false
	,CanBreak = true					--- Weapon can jam?
	,JamChance = 1000					--- This old piece of brick doesn't work fine >;c
	,IncludeChamberedBullet = true		--- Include the chambered bullet on next reload
	,Chambered = false					--- Start with the gun chambered?
	,LauncherReady = false				--- Start with the GL ready?
	,CanCheckMag = true					--- You can check the magazine
	,ArcadeMode = false					--- You can see the bullets left in magazine
	,RainbowMode = false				--- Operation: Party Time xD
	,ModoTreino = false					--- Surrender enemies instead of killing them
	,GunSize = 5.25
	,GunFOVReduction = 5

	,BoltExtend = Vector3.new(0, 0, 0.4)
	,SlideExtend = Vector3.new(0, 0, 0.4)	
----------------------------------------------------------------------------------------------------
--------------------=[ CFRAME ]=--------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
	,EnableHolster = false
	,HolsterTo = 'Torso'				 -- Put the name of the body part you wanna holster to
	,HolsterPos = CFrame.new(0,0,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
	
	,RightArmPos = CFrame.new(-0.85, -0.2, -1.2) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))	--Server
	,LeftArmPos = CFrame.new(0.8,0.5,-1.2) * CFrame.Angles(math.rad(-100),math.rad(25),math.rad(-20))	--server
	
	,ServerGunPos = CFrame.new(-.3, -1, -0.4) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))
	,GunPos = CFrame.new(0.15, -0.15, 1) * CFrame.Angles(math.rad(90), math.rad(0), math.rad(0))

	,RightPos = CFrame.new(-.65, -0.2, -1) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))    --Client
	,LeftPos = CFrame.new(1.2,0.1,-1.6) * CFrame.Angles(math.rad(-120),math.rad(35),math.rad(-20))    --Client
}

return Config

