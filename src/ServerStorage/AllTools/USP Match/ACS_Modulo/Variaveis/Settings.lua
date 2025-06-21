local Tool = script.Parent.Parent.Parent
local ACS = Tool:WaitForChild("ACS_Modulo")
local Var = ACS:WaitForChild("Variaveis")

local Config = {

----------------------------------------------------------------------------------------------------
---------------------=[ GERAL ]=--------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
	 Name = "Glock 17"
	,BulletType = "9x19 Parabellum"
	,Ammo = Var.Ammo.Value
	,ChangeFOV = {70, 50}
	,ZoomAnim = false
	,Bullets = 1
	,FireRate = 800
	,BurstFireRate = 900
	,BurstShot = 3
	,GunType = 1			--- 1 - Rifle, 2 - Shotgun
	,ReloadType = 1 --- 1 - Magazine, 2 - Shell inserting
	,Mode = "Semi"	--- Semi, Burst, Auto, Explosive || Bolt-Action, Pump-Action
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
	,VRecoil = {4,8}				--- Vertical Recoil
	,HRecoil = {4,8}				--- Horizontal Recoil
	,AimRecover = .7				---- Between 0 & 1
	
	,RecoilPunch = .2
	,VPunchBase = 3					--- Vertical Punch
	,HPunchBase = 2					--- Horizontal Punch
	,DPunchBase = 1 				--- Tilt Punch | useless
	
	,AimRecoilReduction = 1 		--- Recoil Reduction Factor While Aiming (Do not set to 0)
	,PunchRecover = 0.03
	,MinRecoilPower = 1
	,MaxRecoilPower = 6
	,RecoilPowerStepAmount = .15
	
	,MinSpread = 4					--- Min bullet spread value | Studs
	,MaxSpread = 40					--- Max bullet spread value | Studs
	,AimInaccuracyStepAmount = 2.5
	,WalkMultiplier = 0				--- Bullet spread based on player speed

	,SwayBase = 0				--- Weapon Base Sway | Studs
	,MaxSway =	0					--- Max sway value based on player stamina | Studs
----------------------------------------------------------------------------------------------------
---------------------=[ DANO ]=---------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
	,LimbsDamage = {30,45}
	,TorsoDamage = {42,57}
	,HeadDamage = {90,140}
	,BulletPenetration = 60			 ---- Between 0 & 100%
	,FallOfDamage = .5
----------------------------------------------------------------------------------------------------
-------------------=[ PROJETIL ]=-------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
	,Distance = 500
	,BDrop = .25
	,BSpeed = 2000

	,SuppressMaxDistance = 25	--- Studs
	,SuppressTime = 10			--- Seconds

	,BulletWhiz = true
	,BWEmitter = 25
	,BWMaxDistance = 200
	
	,BulletFlare = false
	,BulletFlareColor = Color3.fromRGB(255,255,255)

	,Tracer = true
	,TracerColor = Color3.fromRGB(255,255,255)
	,TracerLightEmission = 1
	,TracerLightInfluence = 0
	,TracerLifeTime = .2
	,TracerWidth = .1
	,RandomTracer = false
	,TracerEveryXShots = 5
	,TracerChance = 100
	
	,BulletLight = false
	,BulletLightBrightness = 1
	,BulletLightColor = Color3.fromRGB(255,255,255)
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
	,FastReload = false					--- Automatically operates the bolt on reload if needed
	,SlideLock = true
	,MoveBolt = true
	,BoltLock = true
	,CanBreak = true					--- Weapon can jam?
	,JamChance = 1000					--- This old piece of brick doesn't work fine >;c
	,IncludeChamberedBullet = true		--- Include the chambered bullet on next reload
	,Chambered = false					--- Start with the gun chambered?
	,LauncherReady = false				--- Start with the GL ready?
	,CanCheckMag = true					--- You can check the magazine
	,ArcadeMode = false					--- You can see the bullets left in magazine
	,RainbowMode = false				--- Operation: Party Time xD
	,ModoTreino = false					--- Surrender enemies instead of killing them
	,GunSize = 3.5
	,GunFOVReduction = 5

	,BoltExtend = Vector3.new(0, 0, 0.225)
	,SlideExtend = Vector3.new(0, 0, 0.225)
----------------------------------------------------------------------------------------------------
--------------------=[ CFRAME ]=--------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
	,EnableHolster = true
	,HolsterTo = 'Right Leg'				 -- Put the name of the body part you wanna holster to
	,HolsterPos = CFrame.new(0.55,0.6,0.0) * CFrame.Angles(math.rad(-88),math.rad(-180),math.rad(0))
	
,RightArmPos = CFrame.new(-0.575, 0.65, -1.185) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))    --Server
    ,LeftArmPos = CFrame.new(1.15,-0.1,-1.65) * CFrame.Angles(math.rad(-120),math.rad(20),math.rad(-25))	--server

	,ServerGunPos = CFrame.new(-.3, -1, -0.4) * CFrame.Angles(math.rad(-90), math.rad(-180), math.rad(0))
	,GunPos = CFrame.new(0.15, -0.15, 1) * CFrame.Angles(math.rad(90), math.rad(0), math.rad(0))

	,RightPos = CFrame.new(-0.8, 0.7, -1) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))
    ,LeftPos = CFrame.new(.85,-0.15,-5) * CFrame.Angles(math.rad(-120),math.rad(20),math.rad(-25))	--Client
}

return Config

