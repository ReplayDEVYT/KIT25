local Tool = script.Parent.Parent.Parent
local ACS = Tool:WaitForChild("ACS_Modulo")
local Var = ACS:WaitForChild("Variaveis")

local Config = {

----------------------------------------------------------------------------------------------------
---------------------=[ GERAL ]=--------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
	 Name = "AGS 30x29 mm automatic grenade launcher"
	,BulletType = "30x29mm VOG-30"
	,Ammo = Var.Ammo.Value
	,ChangeFOV = {45,45}
	,ZoomAnim = false
	,FocusOnSight = false
	,FocusOnSight2 = false
	,MagCount = false
	,Bullets = 1
	,FireRate = 600
	,BurstFireRate = 900
	,BurstShot = 3
	,GunType = 0				--- 1 - Rifle, 2 - Shotgun
	,ReloadType = 1				--- 1 - Magazine, 2 - Shell inserting
	,Mode = "Auto"				--- Semi, Burst, Auto, Explosive || Bolt-Action, Pump-Action
	,FireModes = {
		ChangeFiremode = false;		
		Semi = true;
		Burst = false;
		Auto = false;
		Explosive = false;}
----------------------------------------------------------------------------------------------------
-----------------------=[ PUMP-ACTION ]=------------------------------------------------------------
----------------------------------------------------------------------------------------------------
	,AutoChamber = true
	,ChamberWhileAim = true
----------------------------------------------------------------------------------------------------
-----------------=[ RECOIL & PRECISAO ]=------------------------------------------------------------
----------------------------------------------------------------------------------------------------
		,VRecoil = {2.5,4}				--- Vertical Recoil
		,HRecoil = {0,0.12}				--- Horizontal Recoil
		,AimRecover = 1					---- Between 0 & 1
		,rMain = 0.1					--dont even change this
		,hStep = {-.5,.5}				--horizontalStep, horizontal spread of the weapon
		,tStep = 0.15					--timeStep, might not wanna change this
		,vStep = {1,1.75}					--verticalStep, ok you probably shouldnt change any of these
		,RecoilPunch = .15
		,VPunchBase = 1.15				--- Vertical Punch
		,HPunchBase = 0.46				--- Horizontal Punch
		,DPunchBase = 1 				--- Tilt Punch | useless

		,AimRecoilReduction = 5 		--- Recoil Reduction Factor While Aiming (Do not set to 0)
		,PunchRecover = 0.2
		,MinRecoilPower = 1
		,MaxRecoilPower = 3
		,RecoilPowerStepAmount = .25

		,MinSpread = 3					--- Min bullet spread value | Studs
		,MaxSpread = 40					--- Max bullet spread value | Studs
		,AimInaccuracyStepAmount = 2.5
		,WalkMultiplier = 0				--- Bullet spread based on player speed

		,SwayBase = 0.25				--- Weapon Base Sway | Studs
		,MaxSway =	1					--- Max sway value based on player stamina | Studs
----------------------------------------------------------------------------------------------------
---------------------=[ DANO ]=---------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
	,LimbsDamage = {250,300}
	,TorsoDamage = {420,999}
	,HeadDamage = {999,999}
	,BulletPenetration = 35			 ---- Between 0 & 100%
	,FallOfDamage = 2
----------------------------------------------------------------------------------------------------
-------------------=[ PROJETIL ]=-------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
	,Distance = 10000
	,BDrop = 0.02
	,BSpeed = 280

	,SuppressMaxDistance = 25	--- Studs
	,SuppressTime = 10			--- Seconds

	,BulletWhiz = false
	,BWEmitter = 25
	,BWMaxDistance = 200
	
	,BulletFlare = true
	,BulletFlareColor = Color3.fromRGB(255,55,25)

	,Tracer = true
	,TracerColor = Color3.fromRGB(255,55,45)
	,TracerLightEmission = 1
	,TracerLightInfluence = 0
	,TracerLifeTime = .2
	,TracerWidth = .1
	,RandomTracer = false
	,TracerEveryXShots = 1
	,TracerChance = 100
	
	,BulletLight = true
	,BulletLightBrightness = 1
	,BulletLightColor = Color3.fromRGB(255,55,25)
	,BulletLightRange = 10

	,ExplosiveHit = true
	,ExPressure = 250
	,ExpRadius = 15
	,DestroyJointRadiusPercent = 0	--- Between 0 & 1
	,ExplosionDamage = 50

	,LauncherDamage = 100
	,LauncherRadius = 25
	,LauncherPressure = 500
	,LauncherDestroyJointRadiusPercent = 0
----------------------------------------------------------------------------------------------------
--------------------=[ OUTROS ]=--------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
	,FastReload = true					--- Automatically operates the bolt on reload if needed
	,SlideLock = false
	,MoveBolt = false
	,BoltLock = false
	,CanBreachDoor = true
	,CanBreak = false					--- Weapon can jam?
	,JamChance = 1000					--- This old piece of brick doesn't work fine >;c
	,IncludeChamberedBullet = true		--- Include the chambered bullet on next reload
	,Chambered = false					--- Start with the gun chambered?
	,LauncherReady = false				--- Start with the GL ready?
	,CanCheckMag = false				--- You can check the magazine
	,ArcadeMode = false					--- You can see the bullets left in magazine
	,RainbowMode = false				--- Operation: Party Time xD
	,ModoTreino = false					--- Surrender enemies instead of killing them
	,GunSize = 5
	,GunFOVReduction = 8

	,BoltExtend = Vector3.new(0, 0, 0.4)
	,SlideExtend = Vector3.new(0, 0, 0.2)	
----------------------------------------------------------------------------------------------------
--------------------=[ CFRAME ]=--------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
	,EnableHolster = false
	,HolsterTo = 'Torso'				 -- Put the name of the body part you wanna holster to
	,HolsterPos = CFrame.new(0,0,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
	
		,RightArmPos = CFrame.new(-.815, 0.15, -1.1) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))	--Server
		,LeftArmPos = CFrame.new(.815,0.15,-1.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0))

		,ServerGunPos = CFrame.new(-.3, -1, -0.4) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))
		,GunPos = CFrame.new(0.3, -0.15, 1) * CFrame.Angles(math.rad(90), math.rad(0), math.rad(0))

		,RightPos = CFrame.new(-.815, 0.15, -1.1) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))	--Client
		,LeftPos = CFrame.new(.815,0.15,-1.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0))	--Client
	}

return Config

