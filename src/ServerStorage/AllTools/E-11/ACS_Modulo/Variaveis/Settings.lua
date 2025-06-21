local Tool = script.Parent.Parent.Parent
local ACS = Tool:WaitForChild("ACS_Modulo")
local Var = ACS:WaitForChild("Variaveis")

local Config = {

----------------------------------------------------------------------------------------------------
---------------------=[ GERAL ]=--------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
	 Name = "E-11 Blaster Rifle"
	,BulletType = "Plasma Power Cells"
	,Ammo = Var.Ammo.Value
	,ChangeFOV = {55, 55}
	,ZoomAnim = false
	,FocusOnSight = false
	,FocusOnSight2 = false
	,MagCount = true
	,Bullets = 1
	,FireRate = 700
	,BurstFireRate = 900
	,BurstShot = 3
	,GunType = 0				--- 1 - Rifle, 2 - Shotgun
	,ReloadType = 1				--- 1 - Magazine, 2 - Shell inserting
	,Mode = "Semi"				--- Semi, Burst, Auto, Explosive || Bolt-Action, Pump-Action
	,FireModes = {
		ChangeFiremode = true;		
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
	,VRecoil = {2,5}				--- Vertical Recoil
	,HRecoil = {2,5}				--- Horizontal Recoil
	,AimRecover = 1					---- Between 0 & 1

	,RecoilPunch = .35
	,VPunchBase = 4					--- Vertical Punch
	,HPunchBase = 1.75				--- Horizontal Punch
	,DPunchBase = 1 				--- Tilt Punch | useless

	,AimRecoilReduction = 1 		--- Recoil Reduction Factor While Aiming (Do not set to 0)
	,PunchRecover = 0.4
	,MinRecoilPower = 1
	,MaxRecoilPower = 3
	,RecoilPowerStepAmount = .5

	,MinSpread = 0					--- Min bullet spread value | Studs
	,MaxSpread = 0					--- Max bullet spread value | Studs
	,AimInaccuracyStepAmount = 2.5
	,WalkMultiplier = 0				--- Bullet spread based on player speed

	,SwayBase = 0.25				--- Weapon Base Sway | Studs
	,MaxSway =	1					--- Max sway value based on player stamina | Studs
	----------------------------------------------------------------------------------------------------
	---------------------=[ DANO ]=---------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------
	,LimbsDamage = {250,300}
	,TorsoDamage = {400,600}
	,HeadDamage = {999,999}
	,BulletPenetration = 40 ---- Between 0 & 100%
	,FallOfDamage = 2
	----------------------------------------------------------------------------------------------------
	-------------------=[ PROJETIL ]=-------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------
	,Distance = 500
	,BDrop = .25
	,BSpeed = 350

	,SuppressMaxDistance = 25	--- Studs
	,SuppressTime = 10			--- Seconds

	,BulletWhiz = true
	,BWEmitter = 25
	,BWMaxDistance = 200

	,BulletFlare = true
	,BulletFlareColor = Color3.fromRGB(255,55,25)

	,Tracer = true
	,TracerColor = Color3.fromRGB(255,55,45)
	,TracerLightEmission = 1
	,TracerLightInfluence = 0
	,TracerLifeTime = 999
	,TracerWidth = .3
	,RandomTracer = true
	,TracerEveryXShots = 1
	,TracerChance = 100

	,BulletLight = true
	,BulletLightBrightness = 1
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
	,SlideLock = false
	,MoveBolt = false
	,BoltLock = false
	,CanBreachDoor = false
	,CanBreak = true					--- Weapon can jam?
	,JamChance = 1000					--- This old piece of brick doesn't work fine >;c
	,IncludeChamberedBullet = true		--- Include the chambered bullet on next reload
	,Chambered = true					--- Start with the gun chambered?
	,LauncherReady = false				--- Start with the GL ready?
	,CanCheckMag = true					--- You can check the magazine
	,ArcadeMode = false					--- You can see the bullets left in magazine
	,RainbowMode = false				--- Operation: Party Time xD
	,ModoTreino = false					--- Surrender enemies instead of killing them
	,GunSize = 2
	,GunFOVReduction = 5

	,BoltExtend = Vector3.new(0, 0, 0.225)
	,SlideExtend = Vector3.new(0, 0, 0.225)
----------------------------------------------------------------------------------------------------
--------------------=[ CFRAME ]=--------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
	,EnableHolster = true
	,HolsterTo = 'Torso'				 -- Put the name of the body part you wanna holster to
	,HolsterPos = CFrame.new(0,0,-0.95) * CFrame.Angles(math.rad(-90),math.rad(35),math.rad(90))
	
	,RightArmPos = CFrame.new(-0.575, 0.65, -1.185) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))	--Server
	,LeftArmPos = CFrame.new(1.15,0.3,-1.65) * CFrame.Angles(math.rad(-120),math.rad(20),math.rad(-25))	--server

	,ServerGunPos = CFrame.new(-.3, -1, -0.4) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))
	,GunPos = CFrame.new(0.15, -0.15, 1) * CFrame.Angles(math.rad(90), math.rad(0), math.rad(0))

	,RightPos = CFrame.new(-0.4, 0.65, -1) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))	--Client
	,LeftPos = CFrame.new(1.3, 0.05, -1.6) * CFrame.Angles(math.rad(-120),math.rad(35),math.rad(-20))	--Client
}

return Config

