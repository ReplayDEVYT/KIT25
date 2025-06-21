local Tool = script.Parent.Parent.Parent
local ACS = Tool:WaitForChild("ACS_Modulo")
local Var = ACS:WaitForChild("Variaveis")

local Config = {

----------------------------------------------------------------------------------------------------
---------------------=[ GERAL ]=--------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
	 Name = "R700"
	,BulletType = "7.62x51mm M61"
	,Ammo = Var.Ammo.Value
	,ChangeFOV = {8, 8}
	,ZoomAnim = false
	,FocusOnSight = true
	,FocusOnSight2 = true
	,MagCount = true
	,Bullets = 1
	,FireRate = 400
	,BurstFireRate = 900
	,BurstShot = 3
	,GunType = 1				--- 1 - Rifle, 2 - Shotgun
	,ReloadType = 1				--- 1 - Magazine, 2 - Shell inserting
	,Mode = "Bolt-Action"				--- Semi, Burst, Auto, Explosive || Bolt-Action, Pump-Action
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
	,VRecoil = {34,39}				--- Vertical Recoil
	,HRecoil = {13,16}				--- Horizontal Recoil
	,AimRecover = 0.3				---- Between 0 & 1
	,rMain = 0.14					--dont even change this
	,hStep = {-.75,.75}				--horizontalStep, horizontal spread of the weapon
	,tStep = 0.25					--timeStep, might not wanna change this
	,vStep = {3,4}					--verticalStep, ok you probably shouldnt change any of these
	,RecoilPunch = 0.55
	,VPunchBase = 2.6				--- Vertical Punch
	,HPunchBase = 1.25				--- Horizontal Punch
	,DPunchBase = 1 				--- Tilt Punch | useless

	,AimRecoilReduction = 2.5 		--- Recoil Reduction Factor While Aiming (Do not set to 0)
	,PunchRecover = 0.15
	,MinRecoilPower =1.5
	,MaxRecoilPower = 9
	,RecoilPowerStepAmount = .25

	,MinSpread = 0.6				--- Min bullet spread value | Studs
	,MaxSpread = 1.25					--- Max bullet spread value | Studs
	,AimInaccuracyStepAmount = .25
	,WalkMultiplier = 0				--- Bullet spread based on player speed

	,SwayBase = 0.05				--- Weapon Base Sway | Studs
	,MaxSway =	2.5					--- Max sway value based on player stamina | Studs
	----------------------------------------------------------------------------------------------------
	---------------------=[ DANO ]=---------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------
	,LimbsDamage = {58,65}
	,TorsoDamage = {77,95}
	,HeadDamage = {280,305}
	,BulletPenetration = 83			 ---- Between 0 & 100%
	,FallOfDamage = 1
	----------------------------------------------------------------------------------------------------
	-------------------=[ PROJETIL ]=-------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------
	,Distance = 10000
	,BDrop = 0.52
	,BSpeed = 849

	,SuppressMaxDistance = 17	--- Studs
	,SuppressTime = 6			--- Seconds

	,BulletWhiz = true
	,BWEmitter = 25
	,BWMaxDistance = 200

	,BulletFlare = false
	,BulletFlareColor = Color3.fromRGB(255,255,255)

	,Tracer = false
	,TracerColor = Color3.fromRGB(255,55,45)
	,TracerLightEmission = 20
	,TracerLightInfluence = 0
	,TracerLifeTime = 0.2
	,TracerWidth = 0.15
	,RandomTracer = false
	,TracerEveryXShots = 5
	,TracerChance = 100

	,BulletLight = false
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
	,CanBreak = false					--- Weapon can jam?
	,JamChance = 1000					--- This old piece of brick doesn't work fine >;c
	,IncludeChamberedBullet = true		--- Include the chambered bullet on next reload
	,Chambered = true					--- Start with the gun chambered?
	,LauncherReady = false				--- Start with the GL ready?
	,CanCheckMag = true					--- You can check the magazine
	,ArcadeMode = false					--- You can see the bullets left in magazine
	,RainbowMode = false				--- Operation: Party Time xD
	,ModoTreino = false					--- Surrender enemies instead of killing them
	,GunSize = 11.5
	,GunFOVReduction = 5

	,BoltExtend = Vector3.new(0, 0, 0.5)
	,SlideExtend = Vector3.new(0, 0, 0.5)	
----------------------------------------------------------------------------------------------------
--------------------=[ CFRAME ]=--------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
	,EnableHolster = false
	,HolsterTo = 'Torso'				 -- Put the name of the body part you wanna holster to
	,HolsterPos = CFrame.new(0.25,-0.1,-0.8) * CFrame.Angles(math.rad(5),math.rad(-5),math.rad(50))
	
	,RightArmPos = CFrame.new(-0.85, 0.25, -1.2) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))	--Server
	,LeftArmPos = CFrame.new(1.05,1,-1.4) * CFrame.Angles(math.rad(-100),math.rad(25),math.rad(-20))	--server
	
	,ServerGunPos = CFrame.new(-.3, -0.9, -0.4) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))
	,GunPos = CFrame.new(0.15, -0.15, 1) * CFrame.Angles(math.rad(90), math.rad(0), math.rad(0))

	,RightPos = CFrame.new(-.65, -0.2, -1) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))	--Client
	,LeftPos = CFrame.new(1.2,0.1,-1.6) * CFrame.Angles(math.rad(-120),math.rad(35),math.rad(-20))	--Client
}

return Config

