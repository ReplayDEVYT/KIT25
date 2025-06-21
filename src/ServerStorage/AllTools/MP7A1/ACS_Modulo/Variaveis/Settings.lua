local Tool = script.Parent.Parent.Parent
local ACS = Tool:WaitForChild("ACS_Modulo")
local Var = ACS:WaitForChild("Variaveis")

local Config = {

----------------------------------------------------------------------------------------------------
---------------------=[ GERAL ]=--------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
	 Name = "Vityaz SN"
	,BulletType = "4.6x30mm AP SX"
	,Ammo = Var.Ammo.Value
	,ChangeFOV = {55, 55}
	,ZoomAnim = false
	,FocusOnSight = false
	,FocusOnSight2 = false
	,MagCount = true
	,Bullets = 1
	,FireRate = 950
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
	,HRecoil = {7.5,9}				--- Horizontal Recoil
	,AimRecover = 1					---- Between 0 & 1
	,rMain = 0.1					--dont even change this
	,hStep = {-.6,.6}				--horizontalStep, horizontal spread of the weapon
	,tStep = 0.15					--timeStep, might not wanna change this
	,vStep = {1.25,2}					--verticalStep, ok you probably shouldnt change any of these
	,RecoilPunch = .25
	,VPunchBase = 1.1				--- Vertical Punch
	,HPunchBase = 0					--- Horizontal Punch
	,DPunchBase = 1 				--- Tilt Punch | useless

	,AimRecoilReduction = 5 		--- Recoil Reduction Factor While Aiming (Do not set to 0)
	,PunchRecover = 0.2
	,MinRecoilPower = 0.6
	,MaxRecoilPower = 3
	,RecoilPowerStepAmount = .5

	,MinSpread = 8					--- Min bullet spread value | Studs
	,MaxSpread = 48					--- Max bullet spread value | Studs
	,AimInaccuracyStepAmount = 2.5
	,WalkMultiplier = 0				--- Bullet spread based on player speed

	,SwayBase = 0.25				--- Weapon Base Sway | Studs
	,MaxSway =	1					--- Max sway value based on player stamina | Studs
	----------------------------------------------------------------------------------------------------
	---------------------=[ DANO ]=---------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------
	,LimbsDamage = {31,36}
	,TorsoDamage = {44,54}
	,HeadDamage = {110,120}
	,BulletPenetration = 53 ---- Between 0 & 100%
	,FallOfDamage = 1.5
	----------------------------------------------------------------------------------------------------
	-------------------=[ PROJETIL ]=-------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------
	,Distance = 500
	,BDrop = .25
	,BSpeed = 680

	,SuppressMaxDistance = 25	--- Studs
	,SuppressTime = 10			--- Seconds

	,BulletWhiz = true
	,BWEmitter = 25
	,BWMaxDistance = 200

	,BulletFlare = false
	,BulletFlareColor = Color3.fromRGB(255,255,255)

	,Tracer = false
	,TracerColor = Color3.fromRGB(55,255,85)
	,TracerLightEmission = 1
	,TracerLightInfluence = 0
	,TracerLifeTime = .2
	,TracerWidth = .1
	,RandomTracer = false
	,TracerEveryXShots = 5
	,TracerChance = 100

	,BulletLight = false
	,BulletLightBrightness = 1
	,BulletLightColor = Color3.fromRGB(55,255,85)
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
	,FastReload = true				--- Automatically operates the bolt on reload if needed
	,SlideLock = true
	,MoveBolt = false
	,BoltLock = false
	,CanBreachDoor = false
	,CanBreak = false					--- Weapon can jam?
	,JamChance = 1000					--- This old piece of brick doesn't work fine >;c
	,IncludeChamberedBullet = true		--- Include the chambered bullet on next reload
	,Chambered = true					--- Start with the gun chambered?
	,LauncherReady = false				--- Start with the GL ready?
	,CanCheckMag = true					--- You can check the magazine
	,ArcadeMode = false					--- You can see the bullets left in magazine
	,RainbowMode = false				--- Operation: Party Time xD
	,ModoTreino = false					--- Surrender enemies instead of killing them
	,GunSize = 6.5
	,GunFOVReduction = 5.5

	,BoltExtend = Vector3.new(0, 0, 0.4)
	,SlideExtend = Vector3.new(0, 0, 0.4)	
----------------------------------------------------------------------------------------------------
--------------------=[ CFRAME ]=--------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
	,EnableHolster = false
	,HolsterTo = 'Torso'				 -- Put the name of the body part you wanna holster to
	,HolsterPos = CFrame.new(0,-0.2,-0.7) * CFrame.Angles(math.rad(90),math.rad(110),math.rad(-90))
	
	,RightArmPos = CFrame.new(-0.85, 0.1, -1.2) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))	--Server
	,LeftArmPos = CFrame.new(1.05,0.9,-1.4) * CFrame.Angles(math.rad(-100),math.rad(35),math.rad(-10))	--server
	
	,ServerGunPos = CFrame.new(-.2, -1, -0.4) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))
	,GunPos = CFrame.new(0.10, -0.1, 0.90) * CFrame.Angles(math.rad(90), math.rad(0), math.rad(0))

	,RightPos = CFrame.new(-.45, -0.42, -1) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(-3))	--Client
	,LeftPos = CFrame.new(1.10,-0.2,-1.4) * CFrame.Angles(math.rad(-120),math.rad(35),math.rad(-18))	--Client
}



return Config

