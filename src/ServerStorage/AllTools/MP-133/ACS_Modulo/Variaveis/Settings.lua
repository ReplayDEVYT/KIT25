local Tool = script.Parent.Parent.Parent
local ACS = Tool:WaitForChild("ACS_Modulo")
local Var = ACS:WaitForChild("Variaveis")

local Config = {

----------------------------------------------------------------------------------------------------
---------------------=[ GERAL ]=--------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
	 Name = "SPAS-12"
	,BulletType = "12/70 5.25mm Buckshot"
	,Ammo = Var.Ammo.Value
	,ChangeFOV = {55, 55}
	,ZoomAnim = false
	,FocusOnSight = false
	,FocusOnSight2 = false
	,MagCount = false
	,Bullets = 7
	,FireRate = 500
	,BurstFireRate = 900
	,BurstShot = 3
	,GunType = 2				--- 1 - Rifle, 2 - Shotgun
	,ReloadType = 2				--- 1 - Magazine, 2 - Shell inserting
	,Mode = "Pump-Action"				--- Semi, Burst, Auto, Explosive || Bolt-Action, Pump-Action
	,FireModes = {
		ChangeFiremode = false;		
		Semi = true;
		Burst = false;
		Auto = true;
		Explosive = false;}
----------------------------------------------------------------------------------------------------
-----------------------=[ PUMP-ACTION ]=------------------------------------------------------------
----------------------------------------------------------------------------------------------------
	,AutoChamber = true
	,ChamberWhileAim = true
----------------------------------------------------------------------------------------------------
-----------------=[ RECOIL & PRECISAO ]=------------------------------------------------------------
----------------------------------------------------------------------------------------------------
	,VRecoil = {20,27}				--- Vertical Recoil
	,HRecoil = {5,13}				--- Horizontal Recoil
	,AimRecover = 1				---- Between 0 & 1
	,rMain = 0.12					--dont even change this
	,hStep = {-.85,.85}				--horizontalStep, horizontal spread of the weapon
	,tStep = 0.2					--timeStep, might not wanna change this
	,vStep = {2.35,3.75}					--verticalStep, ok you probably shouldnt change any of these
	,RecoilPunch = 1
	,VPunchBase = 5.75				--- Vertical Punch
	,HPunchBase = 3.25				--- Horizontal Punch
	,DPunchBase = 1 				--- Tilt Punch | useless
	
	,AimRecoilReduction = 5 		--- Recoil Reduction Factor While Aiming (Do not set to 0)
	,PunchRecover = 0.2
	,MinRecoilPower = 1.4
	,MaxRecoilPower = 3
	,RecoilPowerStepAmount = .2
	
	,MinSpread = 60				--- Min bullet spread value | Studs
	,MaxSpread = 80					--- Max bullet spread value | Studs
	,AimInaccuracyStepAmount = 15
	,WalkMultiplier = 0				--- Bullet spread based on player speed

	,SwayBase = 0.25				--- Weapon Base Sway | Studs
	,MaxSway =	1					--- Max sway value based on player stamina | Studs
----------------------------------------------------------------------------------------------------
---------------------=[ DANO ]=---------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
	,LimbsDamage = {22,37}
	,TorsoDamage = {22,37}
	,HeadDamage = {95,135}
	,BulletPenetration = 15 ---- Between 0 & 100%
	,FallOfDamage = 2
----------------------------------------------------------------------------------------------------
-------------------=[ PROJETIL ]=-------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
	,Distance = 10000
	,BDrop = .25
	,BSpeed = 2000

	,SuppressMaxDistance = 25	--- Studs
	,SuppressTime = 10			--- Seconds

	,BulletWhiz = true
	,BWEmitter = 25
	,BWMaxDistance = 200
	
	,BulletFlare = false
	,BulletFlareColor = Color3.fromRGB(255,162,69)

	,Tracer = false
	,TracerColor = Color3.fromRGB(55,255,85)
	,TracerLightEmission = 5
	,TracerLightInfluence = 0
	,TracerLifeTime = .5
	,TracerWidth = .06
	,RandomTracer = false
	,TracerEveryXShots = 5
	,TracerChance = 1000
	
	,BulletLight = false
	,BulletLightBrightness = 4
	,BulletLightColor = Color3.fromRGB(55,255,85)
	,BulletLightRange = 5

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
	,CanCheckMag = true					--- You can check the magazine
	,ArcadeMode = false					--- You can see the bullets left in magazine
	,RainbowMode = false				--- Operation: Party Time xD
	,ModoTreino = false					--- Surrender enemies instead of killing them
	,GunSize = 5
	,GunFOVReduction = 5

	,BoltExtend = Vector3.new(0, 0, 0.375)
	,SlideExtend = Vector3.new(0, 0, 0.4)	
----------------------------------------------------------------------------------------------------
--------------------=[ CFRAME ]=--------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
	,EnableHolster = false
	,HolsterTo = 'Torso'				 -- Put the name of the body part you wanna holster to
	,HolsterPos = CFrame.new(0,0,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
	
	,RightArmPos = CFrame.new(-0.85, 0.15, -1.2) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))	--Server
	,LeftArmPos = CFrame.new(1.05,0.9,-1.4) * CFrame.Angles(math.rad(-100),math.rad(25),math.rad(-20))	--server

	,ServerGunPos = CFrame.new(-.3, -1, -0.4) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))
	,GunPos = CFrame.new(0.15, -0.15, 1) * CFrame.Angles(math.rad(90), math.rad(0), math.rad(0))

	,RightPos = CFrame.new(-.65, -0.6, -1) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))	--Client
	,LeftPos = CFrame.new(1.2,0.2,-1.6) * CFrame.Angles(math.rad(-120),math.rad(35),math.rad(-20))	--Client
}

return Config

