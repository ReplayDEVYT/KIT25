local Tool = script.Parent.Parent.Parent
local ACS = Tool:WaitForChild("ACS_Modulo")
local Var = ACS:WaitForChild("Variaveis")

local Config = {

----------------------------------------------------------------------------------------------------
---------------------=[ GERAL ]=--------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
	 Name = "Knife"
	,BulletType = " "
	,SpecialBullet = "Poison"
	,Charges = 2
	,SpecialBulletPart = true
	,SpecialBulletLife = 1
	,Ammo = Var.Ammo.Value
	,ChangeFOV = {55, 55}
	,ZoomAnim = false
	,NoADS = true
	,FocusOnSight = false
	,FocusOnSight2 = false
	,MagCount = true
	,Bullets = 1
	,FireRate = 100
	,BurstFireRate = 900
	,BurstShot = 3
	,GunType = 0				--- 1 - Rifle, 2 - Shotgun
	,ReloadType = 1				--- 1 - Magazine, 2 - Shell inserting
	,Mode = "Semi"				--- Semi, Burst, Auto, Explosive || Bolt-Action, Pump-Action
	,FireModes = {
		ChangeFiremode = false;		
		Semi = true;
		Burst = false;
		Auto = false;
		Explosive = false;}
----------------------------------------------------------------------------------------------------
-----------------------=[ PUMP-ACTION ]=------------------------------------------------------------
----------------------------------------------------------------------------------------------------
	,AutoChamber = false
	,ChamberWhileAim = false
----------------------------------------------------------------------------------------------------
-----------------=[ RECOIL & PRECISAO ]=------------------------------------------------------------
----------------------------------------------------------------------------------------------------
	,VRecoil = {0,0}				--- Vertical Recoil
	,HRecoil = {0,0}				--- Horizontal Recoil
	,AimRecover = 0					---- Between 0 & 1
	,rMain = 0.1					--dont even change this
	,hStep = {-.5,.5}				--horizontalStep, horizontal spread of the weapon
	,tStep = 0.15					--timeStep, might not wanna change this
	,vStep = {1,1.75}					--verticalStep, ok you probably shouldnt change any of these
	,RecoilPunch = 0
	,VPunchBase = 0				--- Vertical Punch
	,HPunchBase = 4.25				--- Horizontal Punch
	,DPunchBase = 1 				--- Tilt Punch | useless

	,AimRecoilReduction = 5 		--- Recoil Reduction Factor While Aiming (Do not set to 0)
	,PunchRecover = 1
	,MinRecoilPower = 0
	,MaxRecoilPower = 0
	,RecoilPowerStepAmount = 0

	,MinSpread = 0					--- Min bullet spread value | Studs
	,MaxSpread = 0					--- Max bullet spread value | Studs
	,AimInaccuracyStepAmount = 0
	,WalkMultiplier = 0				--- Bullet spread based on player speed

	,SwayBase = 0.25				--- Weapon Base Sway | Studs
	,MaxSway =	1					--- Max sway value based on player stamina | Studs
	----------------------------------------------------------------------------------------------------
	---------------------=[ DANO ]=---------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------
	,LimbsDamage = {18,23}
	,TorsoDamage = {18,23}
	,HeadDamage = {18,23}
	,BulletPenetration = 15 ---- Between 0 & 100%
	,FallOfDamage = 0
	----------------------------------------------------------------------------------------------------
	-------------------=[ PROJETIL ]=-------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------
	,Distance = 150
	,BDrop = -2
	,BSpeed = 5
	,NoMove = true
	--,BulletLife = .52
	,NoDrop = true

	,SuppressMaxDistance = 25	--- Studs
	,SuppressTime = 10			--- Seconds

	,BulletWhiz = false
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
	,CanCheckMag = false					--- You can check the magazine
	,ArcadeMode = false					--- You can see the bullets left in magazine
	,RainbowMode = false				--- Operation: Party Time xD
	,ModoTreino = false					--- Surrender enemies instead of killing them
	,GunSize = 0
	,GunFOVReduction = 5

	,BoltExtend = Vector3.new(0, 0, 0)
	,SlideExtend = Vector3.new(0, 0, 0)
----------------------------------------------------------------------------------------------------
--------------------=[ CFRAME ]=--------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
	,EnableHolster = false
	,HolsterTo = 'Right Leg'				 -- Put the name of the body part you wanna holster to
	,HolsterPos = CFrame.new(0.80,0.7,0.2) * CFrame.Angles(math.rad(-88),math.rad(-180),math.rad(0))
	
	,RightArmPos = CFrame.new(-.45, 0.15, -1) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(-3))	--Server
	,LeftArmPos = CFrame.new(0.5,-0.15,-1.35) * CFrame.Angles(math.rad(-100),math.rad(80),math.rad(7.5))			--Server

	,ServerGunPos = CFrame.new(-.3, -1, -0.4) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))
	,GunPos = CFrame.new(0.15, -0.15, 1) * CFrame.Angles(math.rad(90), math.rad(0), math.rad(0))

	,RightPos = CFrame.new(-.45, -0.42, -1) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(-3))	--Client
	,LeftPos = CFrame.new(0,-0.15,-1.25) * CFrame.Angles(math.rad(-100),math.rad(80),math.rad(7.5))
}

return Config

