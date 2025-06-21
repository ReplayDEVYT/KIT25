repeat
	wait()
until game.Players.LocalPlayer.Character

local Warp = require(game:GetService("ReplicatedStorage").Warp);



-- events
local ProjectileNetcodeClient = {
	-- Firing = Warp.Client("Firing"), < REMOVED DUE TO BUFFER ERRORS
	Bullet = Warp.Client("Bullet"),
	BulletHit = Warp.Client("BulletHit")
}

local ReplicateClient = {
	AnimHandler = Warp.Client("Anim"),
	DamageClient = Warp.Client("Damage")
}

Jogador = game.Players.LocalPlayer
Personagem = Jogador.Character
CurCamera = workspace.CurrentCamera
camera = game.Workspace.CurrentCamera;
local Balinha
local Correndo
local ArmaClient
local ArmaClone
CanProne = true
CAS = game:GetService("ContextActionService")
attachanim = false
blindfire = false
inventory = false
bmode = 0
playerstance = 0
local Offset
canTween = false
BloodDecals = {"76226090"; "485303697"; "547029774"; "408320359";}
Engine = game.ReplicatedStorage:WaitForChild("ACS_Engine")
RepStorage = game:GetService("ReplicatedStorage")
Evt = Engine:WaitForChild("Eventos")
Mod = Engine:WaitForChild("Modulos")
PastaHUD = Engine:WaitForChild("HUD")
PastaFX = Engine:WaitForChild("FX")
GunMods = Engine:WaitForChild("GunMods")
GunModels = Engine:WaitForChild("GunModels")
GunModelClient = GunModels:WaitForChild("Client")
GunModelServer = GunModels:WaitForChild("Server")
Ultil = require(Mod:WaitForChild("Utilities"))
SetupMod = require(Mod:WaitForChild("SetupModule"))
Hitmarker = require(Mod:WaitForChild("Hitmarker"))
SpringMod = require(Mod:WaitForChild("Spring"))
Thread = require(Mod:WaitForChild("Thread"))
ServerConfig = require(Engine.ServerConfigs:WaitForChild("Config"))
ACS_Storage = workspace:WaitForChild("ACS_WorkSpace")
Windspeed = game.Workspace:WaitForChild("Windspeed")
local Speedo
local Var
local Settings
local Anims
local ContextAnims
Firing = false
game.Workspace.CurrentCamera.FieldOfView = 70
Player = game.Players.LocalPlayer
Character = Player.Character
Human = Character:WaitForChild("Humanoid")
Mouse = Player:GetMouse()
uis = game:GetService("UserInputService")
Camera = workspace.CurrentCamera
ToolEquip = false
Equipped = false
Nadando = false
Saude = Character:WaitForChild("Saude")
Sprinting = Saude.Stances:WaitForChild("Correndo")

local FOV = Camera.FieldOfView

local Recoil = CFrame.new()
local VRecoil,HRecoil,VPunchBase,HPunchBase,DPunchBase,RecoilPower,BSpread
local Ammo,StoredAmmo,GLAmmo
local FireRate,BurstFireRate
local Chambered,GLChambered,ModoTreino,Emperrado
local Sens,Zeroing
local LastSpreadUpdate = time()
Mouse.Icon = "rbxassetid://7229878905" -- replaces mouse icon
local Gui, CanUpdateGui = nil, true
lastSpecialShot = 0

--makeEventBullet = game.Players.LocalPlayer.PlayerScripts.HandleBullets.Make
local AimPartMode = 1
local SpeedPrecision = 0
ADSS = Engine.FX.ADS:GetChildren()
playerlist = game.Players
otherplayers = playerlist:GetPlayers()
player = game.Players.LocalPlayer
camera = workspace.CurrentCamera
character = player.Character
for i,v in pairs(otherplayers) do
	if v.Character then
		otherplayercharacter = v.Character
	end

end
rootpart = character:WaitForChild("HumanoidRootPart")
falling = false
OverHeat = false 
slideback = false
Can_Shoot = true
CanAim = true
Safe = false
AnimDebounce = false
CancelReload = false
local MouseHeld

PlaceHolder = true

ModStorageFolder = Player.PlayerGui:FindFirstChild('ModStorage') or Instance.new('Folder')
ModStorageFolder.Parent = Player.PlayerGui
ModStorageFolder.Name = 'ModStorage'


Aiming = false
Reloading = false
stance = 0

NVG = false
Bipod = false
CanPlaceBipod = false
BipodEnabled = false
local Silencer
LanternaAtiva = false
LaserAtivo = false
IRmode = false
local Laser
local Pointer
local laserglint
local LaserSP
local LaserEP
LaserDist = 999
local LanternaBeam
local LanternaSP
local LanternaEP

local Left_Weld, Right_Weld,RA,LA,RightS,LeftS,HeadBase,HeadBaseW,HW,HW2,Grip_Weld,GripNode
local AnimBase,AnimBaseW,NeckW,FakeArms,Folder,Arma,Clone,ViewHum,ViewAnim

--// Gun Parts

local SFn

local ABS, HUGE, FLOOR, CEIL = math.abs, math.huge, math.floor, math.ceil
local RAD, SIN, COS, TAN = math.rad, math.sin, math.cos, math.tan
local VEC2, V3 = Vector2.new, Vector3.new
local CF, CFANG = CFrame.new, CFrame.Angles
local INSERT = table.insert


local Walking = false

local CFn = CFrame.new
local CFa = CFrame.Angles
local asin = math.asin
local abs = math.abs
local min = math.min
local max = math.max
local random = math.random

local OldTick = tick()
local t = 0
local Reconum = SpringMod.new(V3())
local sway = SpringMod.new(V3())
local Walk = SpringMod.new(V3())
local WalkRate = 0.1
local speed = 6
local damper = 0.8

DistFunctions = {
	[Enum.FieldOfViewMode.Vertical.Name] = function()
		return camera.ViewportSize.Y, camera.FieldOfView
	end,

	[Enum.FieldOfViewMode.Diagonal.Name] = function()
		return camera.ViewportSize.Magnitude, camera.DiagonalFieldOfView
	end,

	[Enum.FieldOfViewMode.MaxAxis.Name] = function()
		local vp = camera.ViewportSize
		return math.max(vp.X, vp.Y), camera.MaxAxisFieldOfView
	end,
}

funnyrecoil = SpringMod.new(V3()) --bcws
funnyrecoil.s = 20
funnyrecoil.d = .5

CameraRecoil = require(script.Parent.spring).new(10, 400)  --mode,leftinachos
GunKickRecoil = require(script.Parent.spring).new(20, 1000)
GunPreUp = require(script.Parent.spring).new(10, 500)
GunPreSide = require(script.Parent.spring).new(10, 500)

swayOther = SpringMod.new(V3())
swayOther.s = 20 
swayOther.d = .5

swayHip = SpringMod.new(Vector2.new())
swayHip.s = 25
swayHip.d = .23


local ModTable = {

	camRecoilMod 	= {
		RecoilTilt 	= 1,
		RecoilUp 	= 0.75,
		RecoilLeft 	= 0.75,
		RecoilRight = 0.75
	}

	,gunRecoilMod	= {
		RecoilUp 	= 1,
		RecoilTilt 	= 1,
		RecoilLeft 	= 1,
		RecoilRight = 1
	}

	,ZoomValue 		= 70
	,Zoom2Value 	= 70
	,AimRM 			= 1
	,SpreadRM 		= 1
	,DamageMod 		= 1
	,minDamageMod 	= 1

	,MinRecoilPower 			= 1
	,MaxRecoilPower 			= 1
	,RecoilPowerStepAmount 		= 1

	,MinSpread 					= 1
	,MaxSpread 					= 1					
	,AimInaccuracyStepAmount 	= 1
	,AimInaccuracyDecrease 		= 1
	,WalkMult 					= 1
	,adsTime 					= 1		
	,MuzzleVelocity 			= 1
}  

--------------------mods

maincf 		= CFrame.new() --weapon offset of camera
guncf  		= CFrame.new() --weapon offset of camera
larmcf 		= CFrame.new() --left arm offset of weapon
rarmcf 		= CFrame.new() --right arm offset of weapon

gunbobcf		= CFrame.new()
recoilcf 		= CFrame.new()
aimcf 		= CFrame.new()
local AimTween 		= TweenInfo.new(
	0.2,
	Enum.EasingStyle.Back,
	Enum.EasingDirection.In,
	0,
	false,
	0
)


Walk.s = speed
Walk.d = damper
Reconum.s = speed
Reconum.d = 0.15
sway.s = speed
sway.d = damper
WVal = .75
Waval = CFn()


ts = require(game.ReplicatedStorage.TService)
RS = game:GetService("RunService")


GRDebounce 	= false
CookGrenade 	= false
Power 		= 150

--// Char Parts
local Humanoid = Personagem:WaitForChild('Humanoid')
local Head = Personagem:WaitForChild('Head')
local Torso = Personagem:WaitForChild('Torso')
local HumanoidRootPart = Personagem:WaitForChild('HumanoidRootPart')
local RootJoint = HumanoidRootPart:WaitForChild('RootJoint')
local Neck = Torso:WaitForChild('Neck')
local Right_Shoulder = Torso:WaitForChild('Right Shoulder')
local Left_Shoulder = Torso:WaitForChild('Left Shoulder')
local Right_Hip = Torso:WaitForChild('Right Hip')
local Left_Hip = Torso:WaitForChild('Left Hip')

local Connections = {}

local Debris = game:GetService("Debris")

local Ignore_Model = ACS_Storage:FindFirstChild("Server")

local BulletModel = ACS_Storage:FindFirstChild("Client")

local IgnoreList = {"Ignorable","ThatSnowRenderModel"}

local Ray_Ignore = {Character, Ignore_Model, Camera, BulletModel, IgnoreList}

local RecoilSpring = SpringMod.new(Vector3.new())
RecoilSpring.d = 3
RecoilSpring.s = 9

local cameraspring = SpringMod.new(Vector3.new())
cameraspring.d	= .8
cameraspring.s	= 20		

Camera.CameraType = Enum.CameraType.Custom
Camera.CameraSubject = Humanoid

IgnoreAccessoriesList = {
	"Top",
	"Helmet",
	"Up",
	"Down",
	"Face",
	"Olho",
	"Headset",
	"Numero",
	"Vest",
	"Chest",
	"UpperTorso",
	"Back",
	"Belt",
	"Leg1",
	"Leg2",
	"Arm1",
	"Arm2"
}

TorsoList = {
	"UpperTorso",
	"LowerTorso",
	"Torso",
}

LimbsList = {
	"LeftFoot",
	"LeftLowerLeg",
	"LeftUpperLeg",
	"RightFoot",
	"RightLowerLeg",
	"RightUpperLeg",
	"LeftHand",
	"LeftLowerArm",
	"LeftUpperArm",
	"RightHand",
	"RightLowerArm",
	"RightUpperArm",
	"Left Arm",
	"Right Arm",
	"Left Leg",
	"Right Leg",
	"Stomach",
}







SpeedOfSound = ServerConfig.SpeedOfSound

-- ricochet locals
RicochetEnabled = ServerConfig.RicochetEnabled
RicochetMaterialMaxAngles = ServerConfig.RicochetMaterialMaxAngles
RicochetLoss = ServerConfig.RicochetLoss


-- wallbang locals
BulletPenetration = nil
WallbangEnabled = ServerConfig.WallbangEnabled
WallbangDamage = ServerConfig.WallbangDamage
WallbangMaterialHardness = ServerConfig.WallbangMaterialHardness
WallbangSpecialNames = ServerConfig.WallbangSpecialNames





AttModels 	= Engine:WaitForChild("AttModels")
AttModules  	= Engine:WaitForChild("AttModules")

SightAtt	= nil

FlashHider 	= false

BarrelAtt 	= nil

UnderBarrelAtt= nil

OtherAtt 		= nil

LaserAtt 		= false

TorchAtt 		= false

BipodAtt 		= false

AttSettings = nil

SightData, BarrelData, UnderBarrelData, OtherData = nil

----------------------------------------------------------------------------------------------
--------------------------------[PROGRAMA]----------------------------------------------------
----------------------------------------------------------------------------------------------

HeadBase = Instance.new('Part')
HeadBase.Name = 'BasePart'
HeadBase.Parent = Camera
HeadBase.Anchored = true
HeadBase.CanCollide = false
HeadBase.Transparency = 1
HeadBase.Size = Vector3.new(0.1, 0.1, 0.1)

HeadBaseAtt = Instance.new('Attachment')
HeadBaseAtt.Parent = HeadBase

--game.SoundService:SetListener(Enum.ListenerType.ObjectCFrame,HeadBase)

local StatusUI = PastaHUD:WaitForChild("StatusUI")
local StatusClone = StatusUI:Clone()
local NotifUI = Jogador.PlayerGui:WaitForChild("NotificationUI")
local NotifClone = Jogador.PlayerGui:WaitForChild("NotificationUI")
StatusClone.Parent = Jogador.PlayerGui
NotificationMod = require(NotifClone.NotifModule)

-- Notification setup

spawn(function()
	NotificationMod.Notify("60 FPS recommended! Fixes are still experimental!", 120734878931824, 137408246946660, 5)
end)

spawn(function()
	NotificationMod.Notify("Also, this is a notification! You can add these now.", 120734878931824, 137408246946660, 10)
end)

-- ^^ Notifications are now in a ModuleScript, just use a coroutine when calling

if ServerConfig.EnableHunger then
	StatusClone.FomeSede.Disabled = false
end

if ServerConfig.EnableGPS then
	local StatusUI = PastaHUD:WaitForChild("GPShud")
	local StatusClone = StatusUI:Clone()
	StatusClone.Parent = Jogador.PlayerGui
	StatusClone.GPS.Disabled = false
end

function ResetWorkspace()
	Ignore_Model:ClearAllChildren()
	BulletModel:ClearAllChildren()
	for i,v in pairs(workspace.Terrain:GetChildren()) do
		if v.Name ~= "Clouds" then
			v:Destroy()
		end
	end
end

ResetWorkspace()

ProjectileNetcodeClient.BulletHit:Connect(function(Player,Position, HitPart, Normal, Material,Settings)
	if Player ~= Jogador then 
		Hitmarker.HitEffect(Ray_Ignore,ACS_Storage,Position, HitPart, Normal, Material)
	end
end)

Evt.HeadRot.OnClientEvent:Connect(function(Player, Rotacao, Offset, C1)
	if Player ~= Jogador and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") ~= nil and Player.Character.Torso:FindFirstChild("Neck") then
		local HRPCF =  Player.Character["HumanoidRootPart"].CFrame * CFrame.new(0, 1.5, 0.25) * CFrame.new(Offset)
		Player.Character.Torso:WaitForChild("Neck").C0 =  Player.Character.Torso.CFrame:toObjectSpace(HRPCF)
		Player.Character.Torso:WaitForChild("Neck").C1 =  CFrame.Angles(Rotacao, 0, 0)
	end
end)
--[[Evt.HeadRot.OnClientEvent:Connect(function(Player, CF)
	if Player ~= Jogador and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") ~= nil then
		local Waist = Player.Character.Torso:FindFirstChild("Neck")
		if Waist then
			Waist.C0 = CF
		end
	end
end)]]--

Evt.Atirar.OnClientEvent:Connect(function(Player,FireRate,Anim,Arma)

	if Player ~= Jogador and Arma ~= nil then 

		if Arma and Player.Character:FindFirstChild('S' .. Arma.Name) ~= nil and Player.Character['S' .. Arma.Name].Grip:FindFirstChild("Muzzle") ~= nil then
			local Muzzle = Player.Character['S' .. Arma.Name].Grip:FindFirstChild("Muzzle")
			if  Player.Character:FindFirstChild("AnimBase") ~= nil and Player.Character.AnimBase:FindFirstChild("AnimBaseW") then
				local AnimBase = Player.Character:WaitForChild("AnimBase"):WaitForChild("AnimBaseW")

				ts(AnimBase, TweenInfo.new(FireRate), {C1 = Anim} ):Play()
				task.wait(FireRate)
				ts(AnimBase, TweenInfo.new(.2), {C1 = CFrame.new()} ):Play()
			end
			if Player ~= nil and Player.Character ~= nil and Arma ~= nil and Player.Character:FindFirstChild('S' .. Arma.Name):FindFirstChild("Silenciador") ~= nil and Player.Character['S' .. Arma.Name].Silenciador.Transparency == 0 then
				Muzzle:FindFirstChild("FlashFX").Brightness = 0
				if Muzzle:FindFirstChild("FlashFX2") then
					Muzzle:FindFirstChild("FlashFX2").Brightness = 0
				end
				Muzzle:FindFirstChild("FlashFX[Flash]").Rate = 0
				if Muzzle:FindFirstChild("FlashFX[Lens]") then
					Muzzle:FindFirstChild("FlashFX[Lens]").Rate = 0
				end
				for i,v in pairs(Muzzle:GetChildren()) do
					if v.Name:find("Fire") and v:IsA('ParticleEmitter') then
						v.Rate = 0
					end
				end

				if Muzzle:FindFirstChild("FlashFX[Lens]1") then
					Muzzle:FindFirstChild("FlashFX[Lens]1").FaceCamera = false
				end

				if Muzzle:FindFirstChild("FlashFX[Lens]2") then
					Muzzle:FindFirstChild("FlashFX[Lens]2").FaceCamera = false
				end

				if Muzzle:FindFirstChild("FlashFX[Lens]3") then
					Muzzle:FindFirstChild("FlashFX[Lens]3").FaceCamera = false
				end

				if Muzzle:FindFirstChild("FlashFX[Lens]4") then
					Muzzle:FindFirstChild("FlashFX[Lens]4").FaceCamera = false
				end

				--Muzzle:FindFirstChild("FlashFX[Particles]").Rate = 3
			else
				Muzzle:FindFirstChild("FlashFX").Brightness = 5
				for i,v in pairs(Muzzle:GetChildren()) do
					if v.Name:find("Fire") and v:IsA('ParticleEmitter') then
						v.Rate = 50
					end
				end
				if Muzzle:FindFirstChild("FlashFX2") then
					Muzzle:FindFirstChild("FlashFX2").Brightness = 5
				end
				Muzzle:FindFirstChild("FlashFX[Flash]").Rate = 15
				if Muzzle:FindFirstChild("FlashFX[Lens]") then
					Muzzle:FindFirstChild("FlashFX[Lens]").Rate = 33
				end

				--Muzzle:FindFirstChild("FlashFX[Particles]").Rate = 0
				if Muzzle:FindFirstChild("FlashFX[Lens]1") then
					Muzzle:FindFirstChild("FlashFX[Lens]1").FaceCamera = true
				end

				--Muzzle:FindFirstChild("FlashFX[Particles]").Rate = 0
				if Muzzle:FindFirstChild("FlashFX[Lens]2") then
					Muzzle:FindFirstChild("FlashFX[Lens]2").FaceCamera = true
				end

				if Muzzle:FindFirstChild("FlashFX[Lens]3") then
					--Muzzle:FindFirstChild("FlashFX[Particles]").Rate = 0
					Muzzle:FindFirstChild("FlashFX[Lens]3").FaceCamera = true
				end

				if Muzzle:FindFirstChild("FlashFX[Lens]4") then
					Muzzle:FindFirstChild("FlashFX[Lens]4").FaceCamera = true
				end

				--Muzzle:FindFirstChild("FlashFX[Particles]").Rate = 175
			end


			for _, v in pairs(Muzzle:GetChildren()) do
				fire = math.random(1,4)
				if (v.Name:sub(1, 7) == "FlashFX" or v.Name:find("Smoke")) and not v:IsA("Motor6D") then
					--v.Enabled = false
					--v.Enabled = true
					--v.Enabled = false
					if v:GetAttribute("EmitCount") and v.Rate > 0 then
						v:Emit(v:GetAttribute("EmitCount"))
					else
						v.Enabled = true
					end

				end
				if v.Name == "Fire["..fire.."]" then
					--v.Enabled = false
					--v.Enabled = true
					--v.Enabled = false
					v.Enabled = true
				end
			end


			task.delay(0.05, function()

				for _, v in pairs(Muzzle:GetChildren()) do
					if (v.Name:sub(1, 7) == "FlashFX" or v.Name:find("Smoke")) and not v:IsA("Motor6D") and (not v:GetAttribute("EmitCount") or v.Rate <= 0) then
						v.Enabled = false
					end
					if v.Name:find('Fire') then
						v.Enabled = false
					end
				end
			end)		

		end
	end
end)


function resetMods()

	ModTable.camRecoilMod.RecoilUp 		= 1
	ModTable.camRecoilMod.RecoilLeft 	= 1
	ModTable.camRecoilMod.RecoilRight 	= 1
	ModTable.camRecoilMod.RecoilTilt 	= 1

	ModTable.gunRecoilMod.RecoilUp 		= 1
	ModTable.gunRecoilMod.RecoilTilt 	= 1
	ModTable.gunRecoilMod.RecoilLeft 	= 1
	ModTable.gunRecoilMod.RecoilRight 	= 1

	ModTable.AimRM			= 1
	ModTable.SpreadRM 		= 1
	ModTable.DamageMod 		= 1
	ModTable.minDamageMod 	= 1

	ModTable.MinRecoilPower 		= 1
	ModTable.MaxRecoilPower 		= 1
	ModTable.RecoilPowerStepAmount 	= 1

	ModTable.MinSpread 					= 1
	ModTable.MaxSpread 					= 1
	ModTable.AimInaccuracyStepAmount 	= 1
	ModTable.AimInaccuracyDecrease 		= 1
	ModTable.WalkMult 					= 1
	ModTable.MuzzleVelocity 			= 1

end

function setMods(ModData)

	ModTable.camRecoilMod.RecoilUp 		= ModTable.camRecoilMod.RecoilUp * ModData.camRecoil.RecoilUp
	ModTable.camRecoilMod.RecoilLeft 	= ModTable.camRecoilMod.RecoilLeft * ModData.camRecoil.RecoilLeft
	ModTable.camRecoilMod.RecoilRight 	= ModTable.camRecoilMod.RecoilRight * ModData.camRecoil.RecoilRight
	ModTable.camRecoilMod.RecoilTilt 	= ModTable.camRecoilMod.RecoilTilt * ModData.camRecoil.RecoilTilt

	ModTable.gunRecoilMod.RecoilUp 		= ModTable.gunRecoilMod.RecoilUp * ModData.gunRecoil.RecoilUp
	ModTable.gunRecoilMod.RecoilTilt 	= ModTable.gunRecoilMod.RecoilTilt * ModData.gunRecoil.RecoilTilt
	ModTable.gunRecoilMod.RecoilLeft 	= ModTable.gunRecoilMod.RecoilLeft * ModData.gunRecoil.RecoilLeft
	ModTable.gunRecoilMod.RecoilRight 	= ModTable.gunRecoilMod.RecoilRight * ModData.gunRecoil.RecoilRight

	ModTable.AimRM						= ModTable.AimRM * ModData.AimRecoilReduction
	ModTable.SpreadRM 					= ModTable.SpreadRM * ModData.AimSpreadReduction
	ModTable.DamageMod 					= ModTable.DamageMod * ModData.DamageMod
	ModTable.minDamageMod 				= ModTable.minDamageMod * ModData.minDamageMod

	ModTable.MinRecoilPower 			= ModTable.MinRecoilPower * ModData.MinRecoilPower
	ModTable.MaxRecoilPower 			= ModTable.MaxRecoilPower * ModData.MaxRecoilPower
	ModTable.RecoilPowerStepAmount 		= ModTable.RecoilPowerStepAmount * ModData.RecoilPowerStepAmount

	ModTable.MinSpread 					= ModTable.MinSpread * ModData.MinSpread
	ModTable.MaxSpread 					= ModTable.MaxSpread * ModData.MaxSpread
	ModTable.AimInaccuracyStepAmount 	= ModTable.AimInaccuracyStepAmount * ModData.AimInaccuracyStepAmount
	ModTable.AimInaccuracyDecrease 		= ModTable.AimInaccuracyDecrease * ModData.AimInaccuracyDecrease
	ModTable.WalkMult 					= ModTable.WalkMult * ModData.WalkMult
	ModTable.MuzzleVelocity 			= ModTable.MuzzleVelocity * ModData.MuzzleVelocityMod
end

--[[function loadAttachment(weapon)
	if weapon and weapon:FindFirstChild("Nodes") ~= nil then

		--load sight Att
		if weapon.Nodes:FindFirstChild("Sight") ~= nil and AttSettings.SightAtt ~= "" then

			SightData =  require(AttModules[AttSettings.SightAtt])

			SightAtt = AttModels[AttSettings.SightAtt]:Clone()
			SightAtt.Parent = weapon
			SightAtt:SetPrimaryPartCFrame(weapon.Nodes.Sight.CFrame)
			weapon.AimPart.CFrame = SightAtt.AimPos.CFrame

			if SightData.SightZoom > 0 then
				ModTable.ZoomValue = SightData.SightZoom
			end
			if SightData.SightZoom2 > 0 then
				ModTable.Zoom2Value = SightData.SightZoom2
			end
			setMods(SightData)


			for index, key in pairs(weapon:GetChildren()) do
				if key.Name == "IS" then
					key.Transparency = 1
				end
			end

			for index, key in pairs(SightAtt:GetChildren()) do
				if key:IsA('BasePart') then
					Ultil.Weld(key, weapon:WaitForChild('Handle'), key)
					key.Anchored = false
					key.CanCollide = false
				end
			end

		end

		--load Barrel Att
		if weapon.Nodes:FindFirstChild("Barrel") ~= nil and AttSettings.BarrelAtt ~= "" then

			BarrelData =  require(AttModules[AttSettings.BarrelAtt])

			BarrelAtt = AttModels[AttSettings.BarrelAtt]:Clone()
			BarrelAtt.Parent = weapon
			BarrelAtt:SetPrimaryPartCFrame(weapon.Nodes.Barrel.CFrame)

			Silencer.Value 		= BarrelData.IsSuppressor
			FlashHider 		= BarrelData.IsFlashHider

			setMods(BarrelData)

			for index, key in pairs(BarrelAtt:GetChildren()) do
				if key:IsA('BasePart') then
					Ultil.Weld(key, weapon:WaitForChild('Handle'), key)
					key.Anchored = false
					key.CanCollide = false
				end
			end
		end

		--load Under Barrel Att
		if weapon.Nodes:FindFirstChild("UnderBarrel") ~= nil and AttSettings.UnderBarrelAtt ~= "" then

			UnderBarrelData =  require(AttModules[AttSettings.UnderBarrelAtt])

			UnderBarrelAtt = AttModels[AttSettings.UnderBarrelAtt]:Clone()
			UnderBarrelAtt.Parent = weapon
			UnderBarrelAtt:SetPrimaryPartCFrame(weapon.Nodes.UnderBarrel.CFrame)


			setMods(UnderBarrelData)
			BipodAtt = UnderBarrelData.IsBipod

			if BipodAtt then
				CAS:BindAction("ToggleBipod", CanPlaceBipod and Bipod == not Bipod, true, Enum.KeyCode.B)
			end

			for index, key in pairs(UnderBarrelAtt:GetChildren()) do
				if key:IsA('BasePart') then
					Ultil.Weld(key, weapon:WaitForChild('Handle'), key)
					key.Anchored = false
					key.CanCollide = false
				end
			end
		end

		if weapon.Nodes:FindFirstChild("Other") ~= nil and AttSettings.OtherAtt ~= "" then

			OtherData =  require(AttModules[AttSettings.OtherAtt])

			OtherAtt = AttModels[AttSettings.OtherAtt]:Clone()
			OtherAtt.Parent = weapon
			OtherAtt:SetPrimaryPartCFrame(weapon.Nodes.Other.CFrame)


			setMods(OtherData)
			LaserAtt = OtherData.EnableLaser
			TorchAtt = OtherData.EnableFlashlight

			for index, key in pairs(OtherAtt:GetChildren()) do
				if key:IsA('BasePart') then
					Ultil.Weld(key, weapon:WaitForChild('Handle'), key)
					key.Anchored = false
					key.CanCollide = false
				end
			end
		end
	end
end]]--

function Setup(Tools)

	local Torso = Character:FindFirstChild('Torso')
	local Head = Character:FindFirstChild('Head')
	local HumanoidRootPart = Character:FindFirstChild('HumanoidRootPart')

	ArmaClient = Tools
	ArmaClone = GunModelClient:FindFirstChild(ArmaClient.Name):Clone()
	ArmaClone.PrimaryPart = ArmaClone:FindFirstChild("Handle")
	Var = Tools.ACS_Modulo.Variaveis
	Settings = require(Var:FindFirstChild("Settings"))
	--[[if Var:FindFirstChild("AttSettings") then
		AttSettings = require(Var:WaitForChild("AttSettings"))
		loadAttachment(ArmaClone)
	end]]--
	Anims = require(Var:FindFirstChild("Animations"))
	ContextAnims = require(Mod:FindFirstChild("ContextAnimations"))

	VRecoil = math.random(Settings.VRecoil[1],Settings.VRecoil[2])/1000
	HRecoil = math.random(Settings.HRecoil[1],Settings.HRecoil[2])/1000
	VPunchBase = (Settings.VPunchBase)
	HPunchBase = (Settings.HPunchBase)
	DPunchBase = (Settings.DPunchBase)
	RecoilPower = Settings.MinRecoilPower
	BSpread = Settings.MinSpread

	Silencer = Var.Suppressor
	Ammo, StoredAmmo, GLAmmo = Var.Ammo, Var.StoredAmmo, Var.LauncherAmmo
	Chambered,Emperrado,GLChambered = Var.Chambered, Var.Emperrado, Var.GLChambered
	FireRate = 1/(Settings.FireRate/60)
	BurstFireRate = 1/(Settings.BurstFireRate/60)

	ModoTreino = Settings.ModoTreino

	Sens = Var.Sens
	if Sens.Value == 50 then
		Sens.Value = 75
	end
	Zeroing = Var.Zeroing


	Evt.Equipar:FireServer(ArmaClient,Settings)

	Folder = Instance.new("Model", Camera)
	Folder.Name = Tools.Name

	AnimBase = Instance.new("Part", Folder)
	AnimBase.FormFactor = "Custom"
	AnimBase.CanCollide = false
	AnimBase.CanQuery = false
	AnimBase.CanTouch = false
	AnimBase.Transparency = 1
	AnimBase.Anchored = true
	AnimBase.Name = "AnimBase"
	AnimBase.Size = Vector3.new(0.1, 0.1, 0.1)

	AnimBaseW = Instance.new("Motor6D")
	AnimBaseW.Part1 = AnimBase
	AnimBaseW.Part0 = HeadBase
	AnimBaseW.Parent = AnimBase
	AnimBaseW.Name = "AnimBaseW"
	AnimBase.Anchored = false

	Clone = Instance.new('Motor6D')
	Clone.Name = 'Clone'
	Clone.Parent = AnimBase
	Clone.Part0 = AnimBase
	Clone.Part1 = HeadBase

	local Attach = Instance.new("Attachment")
	Attach.Parent = AnimBase

	--[[ViewHum = Instance.new('Humanoid')
	ViewHum.MaxHealth = math.huge
	ViewHum.Health = math.huge
	ViewHum.Parent = Folder
	
	AnimRoot = Instance.new("Part", Folder)
	AnimRoot.FormFactor = "Custom"
	AnimRoot.CanCollide = false
	AnimRoot.Transparency = 1
	AnimRoot.Anchored = true
	AnimRoot.Name = "HumanoidRootPart"
	AnimRoot.Size = Vector3.new(0.1, 0.1, 0.1)
	
	RootHip = Instance.new('Motor6D')
	RootHip.Name = 'Root Hip'
	RootHip.Parent = AnimRoot
	RootHip.Part0 = AnimRoot
	RootHip.Part1 = AnimBase]]--

	ViewHum = Instance.new('Humanoid')
	ViewHum.MaxHealth = math.huge
	ViewHum.Health = math.huge
	ViewHum.Parent = Folder

	ViewAnim = Instance.new("Animator")
	ViewAnim.Parent = ViewHum

	ArmaClone.Parent = Folder


	local handle = ArmaClone:WaitForChild("Handle")
	for _, Part in pairs(ArmaClone:GetChildren()) do
		if Part:IsA('BasePart') and Part.Name ~= 'Handle' then
			--local weld =Part:FindFirstChildOfClass("Motor6D")
			--if weld and (weld.Part0 == Part or weld.Part1 == Part) then
			-- do nothing, part already pre-welded
			if Part.Name == "Bolt" or Part.Name == "Slide" or Part.Name == "GL1" or Part.Name == "GL2" or Part.Name == "G" then
				if ArmaClone:FindFirstChild("BoltHinge") then
					Ultil.WeldComplex(ArmaClone:WaitForChild("BoltHinge"), Part, handle)
				else
					Ultil.WeldComplex(ArmaClone:WaitForChild("Handle"), Part, handle)
				end

			elseif Part.Name == "Lid" then
				if ArmaClone:FindFirstChild('LidHinge') then
					Ultil.Weld(Part, ArmaClone:WaitForChild("LidHinge"), Part)
				else
					Ultil.Weld(handle, Part, Part)
				end

			else
				Ultil.Weld(handle, Part, Part)
			end
		end
	end;
	for L_213_forvar1, L_214_forvar2 in pairs(ArmaClone:GetDescendants()) do
		if L_214_forvar2:IsA('BasePart') and L_214_forvar2.Name ~= 'Grip' then
			L_214_forvar2.Anchored = false
			L_214_forvar2.CanCollide = false
			L_214_forvar2.CanQuery = false
			L_214_forvar2.CanTouch = false
		end
	end;
	--LoadClientMods()
	RA, LA, Right_Weld, Left_Weld, AnimBase, AnimBaseW = SetupMod(Folder, Ultil, Character, RA, LA, Right_Weld, Left_Weld, AnimBase, AnimBaseW, Settings, ArmaClone)
	Equipped = true

	if ArmaClone:FindFirstChild('Silenciador')~= nil then
		if Silencer.Value == true then
			for i,v in pairs(ArmaClone:GetChildren()) do
				if v.Name == "Silenciador" then
					v.Transparency = 0
				end
			end
			ArmaClone.SmokePart.FlashFX.Brightness = 0
			ArmaClone.SmokePart.FlashFX2.Brightness = 0
			for i,v in pairs(ArmaClone.SmokePart:GetChildren()) do
				if v.Name:find("Fire") and v:IsA('ParticleEmitter') then
					v.Rate = 0
				end
			end
			ArmaClone.SmokePart:FindFirstChild("FlashFX[Flash]").Rate = 0
			if ArmaClone.SmokePart:FindFirstChild("FlashFX[Lens]") then
				ArmaClone.SmokePart:FindFirstChild("FlashFX[Lens]").Rate = 0
			end
			if ArmaClone.SmokePart:FindFirstChild("FlashFX[Lens]1") then
				ArmaClone.SmokePart:FindFirstChild("FlashFX[Lens]1").FaceCamera = false
			end
			if ArmaClone.SmokePart:FindFirstChild("FlashFX[Lens]2") then
				ArmaClone.SmokePart:FindFirstChild("FlashFX[Lens]2").FaceCamera = false
			end
			if ArmaClone.SmokePart:FindFirstChild("FlashFX[Lens]3") then
				ArmaClone.SmokePart:FindFirstChild("FlashFX[Lens]3").FaceCamera = false
			end
			if ArmaClone.SmokePart:FindFirstChild("FlashFX[Lens]4") then
				ArmaClone.SmokePart:FindFirstChild("FlashFX[Lens]4").FaceCamera = false
			end
			--ArmaClone.SmokePart:FindFirstChild("FlashFX[Particles]").Rate = 3
			Evt.SilencerEquip:FireServer(ArmaClient,Silencer.Value)
		else
			for i,v in pairs(ArmaClone:GetChildren()) do
				if v.Name == "Silenciador" then
					v.Transparency = 1
				end
			end
			ArmaClone.SmokePart.FlashFX.Brightness = 5
			ArmaClone.SmokePart.FlashFX2.Brightness = 5
			for i,v in pairs(ArmaClone.SmokePart:GetChildren()) do
				if v.Name:find("Fire") and v:IsA('ParticleEmitter') then
					v.Rate = 50
				end
			end
			ArmaClone.SmokePart:FindFirstChild("FlashFX[Flash]").Rate = 15
			if ArmaClone.SmokePart:FindFirstChild("FlashFX[Lens]") then
				ArmaClone.SmokePart:FindFirstChild("FlashFX[Lens]").Rate = 33
			end
			if ArmaClone.SmokePart:FindFirstChild("FlashFX[Lens]1") then
				ArmaClone.SmokePart:FindFirstChild("FlashFX[Lens]1").FaceCamera = true
			end
			if ArmaClone.SmokePart:FindFirstChild("FlashFX[Lens]2") then
				ArmaClone.SmokePart:FindFirstChild("FlashFX[Lens]2").FaceCamera = true
			end
			if ArmaClone.SmokePart:FindFirstChild("FlashFX[Lens]3") then
				ArmaClone.SmokePart:FindFirstChild("FlashFX[Lens]3").FaceCamera = true
			end
			if ArmaClone.SmokePart:FindFirstChild("FlashFX[Lens]4") then
				ArmaClone.SmokePart:FindFirstChild("FlashFX[Lens]4").FaceCamera = true
			end
			--ArmaClone.SmokePart:FindFirstChild("FlashFX[Particles]").Rate = 175
			Evt.SilencerEquip:FireServer(ArmaClient,Silencer.Value)
		end
	end
	-- setup - wallbang
	if WallbangEnabled then
		BulletPenetration = ServerConfig.WallbangBulletIndex[Settings.BulletType]
		if not BulletPenetration then
			local DamageAvg = (Settings.LimbsDamage[2] + Settings.TorsoDamage[2] + Settings.HeadDamage[2])*Settings.Bullets / 4
			-- with default values of Bullet Penetration: 50, Average Damage: 50, Bullet Speed: 2000 SPS, Bullet Penetration will = 1
			BulletPenetration = Settings.BulletPenetration/100 + ((DamageAvg/4) * Settings.BSpeed * ServerConfig.WallbangConstant) / 1000000
			print("BP is: "..BulletPenetration)
		end
	end

end

function Unset()

	-- Patrol()

	if ArmaClient then
		Evt.Desequipar:FireServer(ArmaClient,Settings)
	end
	UnloadClientMods()
	UnderBarrelAtt 	= nil
	OtherAtt 		= nil
	LaserAtt 		= false
	TorchAtt 		= false
	BipodAtt 		= false
	FlashHider 		= false
	resetMods()
	if Folder then
		Folder:Destroy()
	end
	Equipped = false
	Aiming = false
	Safe = false
	Bipod = false
	LanternaAtiva = false
	IRmode = false
	LaserAtivo = false
	--Silencer = false
	CancelReload = false
	Reloading = false
	slideback = false
	OverHeat = false
	GRDebounce 		= false
	CookGrenade 	= false

	Player.PlayerGui.clock.Adornee = nil
	Player.PlayerGui.clock.ClockMain.Enabled = false

	uis.MouseIconEnabled = false
	game:GetService('UserInputService').MouseDeltaSensitivity = 1
	Camera.CameraType = Enum.CameraType.Custom
	Player.CameraMode = Enum.CameraMode.Classic
	AimPartMode = 1
	stance = 0
	tweenfov(FOV,15)
	ts(StatusClone.Efeitos.Aim,TweenInfo.new(.3),{ImageTransparency = 1}):Play()
	Evt.SVLaser:FireServer(Vector3.new(0,0,0),2,nil,ArmaClient,IRmode)
	if Gui then
		Gui.Visible = false
	end

	for _,c in pairs(Connections) do
		c:disconnect()
	end
	Connections = {}
	Walking = false
	a = false
	d = false
end

function Update_Gui()
	if Gui and CanUpdateGui then

		if ArmaClone:FindFirstChild("BipodPoint") ~= nil then
			Gui.Bipod.Visible = true
		else
			Gui.Bipod.Visible = false
		end

		if Settings.ArcadeMode == true then
			Gui.Ammo.Visible = true
			Gui.Ammo.AText.Text = Ammo.Value.."|"..Settings.Ammo
		else
			Gui.Ammo.Visible = false
		end
		if attachanim == false then
			Gui.Parent:WaitForChild('AttachmentFrame').Visible = false
			Gui.Parent:WaitForChild('InteractionMouse').Visible = false
			Gui.Parent:WaitForChild('InteractionMouse').Icon.Visible = false
			Gui.Parent:WaitForChild('AttachmentFrame').FLM.Visible = false
		end
		if Settings.FireModes.Explosive == true and GLChambered.Value == true then
			Gui.E.ImageColor3 = Color3.fromRGB(255,255,255)
			Gui.E.Visible = true
		elseif Settings.FireModes.Explosive == true and GLChambered.Value == false then
			Gui.E.ImageColor3 = Color3.fromRGB(255,0,0)
			Gui.E.Visible = true
		elseif Settings.FireModes.Explosive == false then
			Gui.E.Visible = false
		end

		if Safe == true then
			Gui.A.Visible = true
		else
			Gui.A.Visible = false
		end

		if Chambered.Value == true and Ammo.Value > 0 and Emperrado.Value == false then
			Gui.B.Visible = true
			Gui.B.BackgroundColor3 = Color3.fromRGB(255,255,255)
			Gui.CCText.TextColor3 = Color3.fromRGB(255,255,255)
			Gui.CCText.Text = "Chambered"
		elseif Chambered.Value == true and Ammo.Value > 0 and Emperrado.Value == true then
			Gui.B.Visible = true
			Gui.B.BackgroundColor3 = Color3.fromRGB(255,0,0)
			Gui.CCText.TextColor3 = Color3.fromRGB(255,255,255)
			Gui.CCText.Text = "Needs rechamber"
		else
			Gui.B.Visible = false
			Gui.CCText.TextColor3 = Color3.fromRGB(255,255,255)
			Gui.CCText.Text = "Unchambered"
		end
		--Gui.FText.Text = Settings.Mode

		if Settings.Mode == "Semi" or Settings.Mode == "Pump-Action" or Settings.Mode == "Bolt-Action" then
			Gui.FText.Text = "Single Fire"
		elseif Settings.Mode == "Burst" then
			Gui.FText.Text = "Burst Fire"
		elseif Settings.Mode == "Auto" then
			Gui.FText.Text = "Full Auto"
		elseif Settings.Mode == "Explosive" then
			Gui.FText.Text = "Explosive"
		end



		if Settings.Mode ~= "Explosive" then
			Gui.BText.Text = Settings.BulletType
		else
			Gui.BText.Text = ""
		end
		Gui.Sens.Text = (Sens.Value/100)
		Gui.ZeText.Text = Zeroing.Value .." m"
		Gui.NText.Text = Settings.Name

		if Settings.Mode ~= "Explosive" then
			if Settings.MagCount then
				Gui.SAText.Text = math.ceil(StoredAmmo.Value/Settings.Ammo)
			else
				Gui.SAText.Text = StoredAmmo.Value
			end
		else
			Gui.SAText.Text =  GLAmmo.Value
		end

		if Silencer.Value == true then
			Gui.Silencer.Visible = true
		else
			Gui.Silencer.Visible = false
		end

		if LaserAtivo == true then
			Gui.Laser.Visible = true
			if IRmode then
				Gui.Laser.ImageColor3 = Color3.new(0,255,0)
			else
				Gui.Laser.ImageColor3 = Color3.new(255,255,255)
			end
		else
			Gui.Laser.Visible = false
		end

		if LanternaAtiva == true then
			Gui.Flash.Visible = true
		else
			Gui.Flash.Visible = false
		end

	end
end

function CheckMagFunction()
	ts(Gui.CMText,TweenInfo.new(1),{TextTransparency = 0,TextStrokeTransparency = .9, BackgroundTransparency = 0.5}):Play()
	ts(Gui.BText,TweenInfo.new(1),{TextTransparency = 0,TextStrokeTransparency = 0}):Play()
	ts(Gui.SAText,TweenInfo.new(1),{TextTransparency = 0,TextStrokeTransparency = .9, BackgroundTransparency = 0.5}):Play()
	ts(Gui.MagIcon,TweenInfo.new(1),{ImageTransparency = 0}):Play()
	ts(Gui.AmmoIcon,TweenInfo.new(1),{ImageTransparency = 0}):Play()
	local number = math.random(1,4)
	if CanUpdateGui then
		if Ammo.Value >= Settings.Ammo then
			if number <= 2 then
				Gui.CMText.Text = "Full"
			else
				Gui.CMText.Text = (Ammo.Value).." Rounds"
			end
		elseif Ammo.Value > math.floor((Settings.Ammo)*.75) and Ammo.Value < Settings.Ammo then
			if number == 1 then
				Gui.CMText.Text = "Nearly full"
			elseif number == 2 then
				Gui.CMText.Text = "About full"
			elseif number == 3 then
				Gui.CMText.Text = "Almost full"
			elseif number == 4 then
				Gui.CMText.Text = "More than half"
			end
		elseif Ammo.Value < math.floor((Settings.Ammo)*.75) and Ammo.Value > math.floor((Settings.Ammo)*.5) then
			if number == 1 then
				Gui.CMText.Text = "Almost half"
			elseif number == 2 then
				Gui.CMText.Text = "About half"
			elseif number == 3 then
				Gui.CMText.Text = "Approx. "..(Ammo.Value)
			elseif number == 4 then
				Gui.CMText.Text = "Nearly half"
			end
		elseif Ammo.Value == math.floor((Settings.Ammo)*.5) then
			if number > 2 then
				Gui.CMText.Text = "Approx. "..(Ammo.Value)
			else
				Gui.CMText.Text = "Half"
			end
		elseif Ammo.Value > math.ceil((Settings.Ammo)*.25) and Ammo.Value <  math.floor((Settings.Ammo)*.5) then
			if number > 2 then
				Gui.CMText.Text = "Approx. "..(Ammo.Value)
			else
				Gui.CMText.Text = "Less than half"
			end
		elseif Ammo.Value < math.ceil((Settings.Ammo)*.25) and Ammo.Value > 0 then
			if number > 2 then
				Gui.CMText.Text = "Nearly empty"
			else
				Gui.CMText.Text = "Almost empty"
			end
		elseif Ammo.Value == 0 then
			Gui.CMText.Text = "Empty"
		end
		delay(2,function()
			ts(Gui.CMText,TweenInfo.new(2),{TextTransparency = 1,TextStrokeTransparency = 1, BackgroundTransparency = 1}):Play()
			ts(Gui.BText,TweenInfo.new(2),{TextTransparency = 1,TextStrokeTransparency = 1}):Play()
			ts(Gui.SAText,TweenInfo.new(2),{TextTransparency = 1,TextStrokeTransparency = 1, BackgroundTransparency = 1}):Play()
			ts(Gui.MagIcon,TweenInfo.new(1),{ImageTransparency = 1}):Play()
			ts(Gui.AmmoIcon,TweenInfo.new(1),{ImageTransparency = 1}):Play()
		end)
	end
end

function Sprint()
	if Equipped then
		if Correndo and SpeedPrecision > 0 then
			MouseHeld = false
			if Aiming then
				game:GetService('UserInputService').MouseDeltaSensitivity = 1
				--Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('AimUp').SoundId = ADSS[math.random(#ADSS)].SoundId
				Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('AimUp'):Play()
				ArmaClone.Handle.AimUp:Play()	
				tweenfov(FOV,120)
				Aiming = false
				ts(StatusClone.Efeitos.Aim,TweenInfo.new(.3),{ImageTransparency = 1}):Play()
			end
			if not Safe and not AnimDebounce then
				stance = 3
				Evt.Stance:FireServer(stance,Settings,Anims,ArmaClone)
				SprintAnim()
			end
		elseif not Correndo or SpeedPrecision == 0 then
			if not Safe and not AnimDebounce then
				if Aiming then
					stance = 2
					Evt.Stance:FireServer(stance,Settings,Anims,ArmaClone,false)
					IdleAnim()
				else
					stance = 0
					Evt.Stance:FireServer(stance,Settings,Anims,ArmaClone)
					IdleAnim()
				end
			end
		end
	end
end

Sprinting.Changed:connect(function(Valor)
	Correndo = Valor
	Sprint()
end)

--Ammo.Changed:connect(Update_Gui)
--StoredAmmo.Changed:connect(Update_Gui)
--GLAmmo.Changed:connect(Update_Gui)

local RAD, SIN, ATAN, COS = math.rad, math.sin, math.atan2, math.cos

--------------------[ MATH FUNCTIONS ]------------------------------------------------

function RAND(Min, Max, Accuracy)
	local Inverse = 1 / (Accuracy or 1)
	return (math.random(Min * Inverse, Max * Inverse) / Inverse)
end

---------------------[ TWEEN MODULE ]-------------------------------------------------


function tweenfov(goal, frames)
	coroutine.resume(coroutine.create(function()
		SFn = SFn and SFn + 1 or 0 
		local SFn_S = SFn
		for i = 1, frames do
			if SFn ~= SFn_S then break end
			Camera.FieldOfView = Camera.FieldOfView + (goal - Camera.FieldOfView) * (i / frames)
			game:GetService("RunService").RenderStepped:wait()
		end
	end))
end

function Lerp(n,g,t)
	return n+(g-n)*t
end
local RS = game:GetService("RunService")

function tweenJoint(Joint, newC0, newC1, Alpha, Duration)
	spawn(function()
		local newCode = math.random(-1e9, 1e9) --This creates a random code between -1000000000 and 1000000000
		local tweenIndicator = nil
		if (not Joint:findFirstChild("tweenCode")) then --If the joint isn't being tweened, then
			tweenIndicator = Instance.new("IntValue")
			tweenIndicator.Name = "tweenCode"
			tweenIndicator.Value = newCode
			tweenIndicator.Parent = Joint
		else
			tweenIndicator = Joint.tweenCode
			tweenIndicator.Value = newCode --If the joint is already being tweened, this will change the code, and the tween loop will stop
		end
		--local tweenIndicator = createTweenIndicator:InvokeServer(Joint, newCode)
		if Duration <= 0 then --If the duration is less than or equal to 0 then there's no need for a tweening loop
			if newC0 then Joint.C0 = newC0 end
			if newC1 then Joint.C1 = newC1 end
		else
			local Increment = 1.5 / Duration
			local startC0 = Joint.C0
			local startC1 = Joint.C1
			local X = 0
			while true do
				RS.RenderStepped:wait() --This makes the for loop step every 1/60th of a second
				local newX = X + Increment
				X = (newX > 90 and 90 or newX)
				if tweenIndicator.Value ~= newCode then break end --This makes sure that another tween wasn't called on the same joint
				if (not Equipped) then break end --This stops the tween if the tool is deselected
				if newC0 then Joint.C0 = startC0:lerp(newC0, Alpha(X)) end
				if newC1 then Joint.C1 = startC1:lerp(newC1, Alpha(X)) end
				if X == 90 then break end
			end
		end
		if tweenIndicator.Value == newCode then --If this tween functions was the last one called on a joint then it will remove the code
			tweenIndicator:Destroy()
		end
	end)
end


function LoadClientMods()
	for L_335_forvar1, L_336_forvar2 in pairs(GunMods:GetChildren()) do
		if L_336_forvar2:IsA('LocalScript') then
			local L_337_ = L_336_forvar2:clone()
			L_337_.Parent = ModStorageFolder
			L_337_.Disabled = false
		end
	end
end

function UnloadClientMods()
	for L_335_forvar1, L_336_forvar2 in pairs(ModStorageFolder:GetChildren()) do
		if L_336_forvar2:IsA('LocalScript') then
			L_336_forvar2:Destroy()
		end
	end
end

function CheckForHumanoid(L_225_arg1)
	local L_226_ = false
	local L_227_ = nil
	if L_225_arg1 then
		if (L_225_arg1.Parent:FindFirstChildOfClass("Humanoid") or L_225_arg1.Parent.Parent:FindFirstChildOfClass("Humanoid")) then
			L_226_ = true
			if L_225_arg1.Parent:FindFirstChildOfClass('Humanoid') then
				L_227_ = L_225_arg1.Parent:FindFirstChildOfClass('Humanoid')
			elseif L_225_arg1.Parent.Parent:FindFirstChildOfClass('Humanoid') then
				L_227_ = L_225_arg1.Parent.Parent:FindFirstChildOfClass('Humanoid')
			end
		else
			L_226_ = false
		end	
	end
	return L_226_, L_227_
end

function ShouldbeAddedtoIgnoreList(Part)
	if (Part.CanCollide == false or Part.Transparency >= .7 or Part.Name == "Glass") and Part.Name ~= "RightUpperLeg" and Part.Name ~= "RightLowerLeg" and Part.Name ~= "RightFoot" and Part.Name ~= "LeftUpperLeg" and Part.Name ~= "LeftLowerLeg" and Part.Name ~= "LeftFoot" and Part.Name ~= "RightUpperArm" and Part.Name ~= "RightLowerArm" and Part.Name ~= "RightHand" and Part.Name ~= "LeftUpperArm" and Part.Name ~= "LeftLowerArm" and Part.Name ~= "LeftHand" and Part.Name ~= "UpperTorso" and Part.Name ~= "LowerTorso" and Part.Name ~= "Torso" and Part.Name ~= "Right Arm" and Part.Name ~= "Left Arm" and Part.Name ~= "Left Leg" and Part.Name ~= "Right Leg" and Part.Name ~= "Neck" and Part.Name ~= "Head" and Part.Name ~= "Groin" and Part.Name ~= "Tree_Collision" and Part.Name ~= "BulletProtection" then
		table.insert(Ray_Ignore, Part)
		--table.insert(Ray_Ignore_2, Part)
	end
end
function EjectShells()
	local shellhit = false
	local casings = Engine.Casings:GetChildren()
	local shell
	for i,h in pairs(casings) do
		if Settings.BulletType:lower():find(h.Name:lower()) then
			shell = h:Clone()
		end
	end
	if casings then
		--if ArmaClone:FindFirstChild('Shell') ~= nil then
		local shellsounds = PastaFX.ShellSounds
		local allshell = shellsounds.All
		local shotgunshell = shellsounds.Shotgun
		if shell == nil and ArmaClone:FindFirstChild('Shell') then
			shell = ArmaClone.Shell:clone()
		end
		if shell ~= nil and shell:FindFirstChild('Shell') then
			shell.Shell:Destroy()
		end
		if shell ~= nil then
			shell.CFrame =  ArmaClone.Chamber.CFrame * CFrame.Angles(math.rad(90),math.rad(0),math.rad(0))
			shell.Velocity = (ArmaClone.Chamber.CFrame.LookVector * math.random(15,30)) + ArmaClone.Chamber.Velocity
			shell.RotVelocity = Vector3.new(0,-math.random(-25,35),0) + ArmaClone.Chamber.RotVelocity
			shell.Parent = workspace.Terrain
			shell.CanCollide = true
			shell.Anchored = false
			shell.Transparency = 0
			shell.Name = "ShellClone"
			shell.CollisionGroup = "ShellCasing"
			table.insert(Ray_Ignore,shell)
			--ts(shell,TweenInfo.new(10),{Transparency = 1}):Play()
			game:GetService("Debris"):AddItem(shell,1)
			--while shell do
			--wait(0)
			--local Hit, Pos, Norm, Mat = workspace:FindPartOnRayWithIgnoreList(Ray.new(shell.Position, Vector3.new(0,-.4,0)), {Character})
			if shellhit == false then
				--task.wait(0.5)
				shell.Touched:Connect(function(Hit)
					if Hit ~= nil and Hit.Parent ~= ArmaClone and shellhit == false then
						shellhit = true
						Mat = Hit.Material
						if Hit and Mat and Hit ~= shell and shellhit == true and Hit.Name ~= "ShellClone" and shell.Velocity.Magnitude > 10 then
							ShouldbeAddedtoIgnoreList(Hit)
							local Sound = PastaFX.ShellCasing:Clone()
							--Sound.PlaybackSpeed = math.random(90,120)/100
							Sound.SoundGroup = game.SoundService.All.Weapons
							Sound.Parent = shell
							if Settings.Bullets <= 1 then
								if Mat == Enum.Material.WoodPlanks or Mat == Enum.Material.Wood then
									local folder = allshell.Wood:GetChildren()
									Sound.SoundId = folder[math.random(#folder)].SoundId
								elseif Mat == Enum.Material.Metal or Mat == Enum.Material.CorrodedMetal or Mat == Enum.Material.DiamondPlate then
									local folder = allshell.Metal:GetChildren()
									Sound.SoundId = folder[math.random(#folder)].SoundId
								elseif Mat == Enum.Material.Mud or Mat == Enum.Material.Ground or Mat == Enum.Material.Grass or Mat == Enum.Material.LeafyGrass or Mat == Enum.Material.Snow or Mat == Enum.Material.Fabric or Mat == Enum.Material.Salt or Mat == Enum.Material.Sand then
									local folder = allshell.Soil:GetChildren()
									Sound.SoundId = folder[math.random(#folder)].SoundId
								else
									local folder = allshell.Other:GetChildren()
									Sound.SoundId = folder[math.random(#folder)].SoundId
								end
							else
								if Mat == Enum.Material.WoodPlanks or Mat == Enum.Material.Wood then
									local folder = shotgunshell.Wood:GetChildren()
									Sound.SoundId = folder[math.random(#folder)].SoundId
								elseif Mat == Enum.Material.Metal or Mat == Enum.Material.CorrodedMetal or Mat == Enum.Material.DiamondPlate then
									local folder = shotgunshell.Metal:GetChildren()
									Sound.SoundId = folder[math.random(#folder)].SoundId
								elseif Mat == Enum.Material.Mud or Mat == Enum.Material.Ground or Mat == Enum.Material.Grass or Mat == Enum.Material.LeafyGrass or Mat == Enum.Material.Snow or Mat == Enum.Material.Fabric or Mat == Enum.Material.Salt or Mat == Enum.Material.Sand then
									local folder = shotgunshell.Soil:GetChildren()
									Sound.SoundId = folder[math.random(#folder)].SoundId
									Sound.Volume = 2
								else
									local folder = shotgunshell.Other:GetChildren()
									Sound.SoundId = folder[math.random(#folder)].SoundId
								end
							end
							Sound:Play()
						end
					end
				end)
				--break
				--game:GetService("Debris"):AddItem(Sound, Sound.TimeLength-0)
			end
		end
		delay(3,function()
			shellhit = false
		end)
	end
end

local Tracers = 1
function TracerCalculation()
	local VisibleTracer
	if Settings.RandomTracer then
		if (math.random(1, 100) <= Settings.TracerChance) then	
			VisibleTracer = true
		else
			VisibleTracer = false
		end
	else
		--if Tracers >= Settings.TracerEveryXShots then
		if Tracers >= 3 then
			VisibleTracer = true
			Tracers = 1
		else
			Tracers = Tracers + 1
		end
	end
	return VisibleTracer
end

function CreateBullet(BSpread)

	local Bullet = Instance.new("Part")
	Bullet.Name = Player.Name.."_Bullet"
	Bullet.Shape = "Block"
	if Settings.BulletSize ~= nil then
		Bullet.Size = Settings.BulletSize
	else
		Bullet.Size = Vector3.new(.5,.5,.5)
	end
	if Settings.ExplosiveHit == false then
		Bullet.CanCollide = false
		--[[delay(.02, function()
			Bullet.CanCollide = true
		end)
		delay(.015, function()
			Bullet.CanCollide = false
			local rick = math.random(1,8)
			if rick == 1 then Bullet.CanCollide = false
			end
			if rick == 2 then Bullet.CanCollide = false
			end
			if rick == 3 then Bullet.CanCollide = false
			end
			if rick == 4 then Bullet.CanCollide = false
			end
			if rick == 5 then Bullet.CanCollide = false
			end
			if rick == 6 then Bullet.CanCollide = true
			end
			if rick == 7 then Bullet.CanCollide = false
			end
			if rick == 8 then Bullet.CanCollide = true
			end
		end)]]--
	end
	--if Settings.ExplosiveHit == true then
	Bullet.CanCollide = false
	--end
	Bullet.Material = "Plastic"
	Bullet.Transparency = 1
	Bullet.FormFactor = "Custom"
	local BulletMass = Bullet:GetMass()
	if Settings.NoDrop == nil then
		Force = Vector3.new(0,(BulletMass/10) - (Settings.BDrop/10), 0)
	elseif Settings.NoDrop then
		Force = Vector3.new(0,20,0)
	end
	if Settings.ExplosiveHit == false then
		local wind = Instance.new("BodyForce",Bullet)
		wind.force = Windspeed.Value
	end
	local BF = Instance.new("BodyForce")
	BF.force = Force
	BF.Parent = Bullet
	local Origin = ArmaClone.SmokePart.Position
	if Settings.NoDrop == nil then
		Direction = ArmaClone.SmokePart.CFrame.lookVector + (ArmaClone.SmokePart.CFrame.upVector * ((((Settings.BDrop/10)*Zeroing.Value/2.8)/Settings.BSpeed*3.571))/2)
	elseif Settings.NoDrop then
		Direction = ArmaClone.SmokePart.CFrame.lookVector + (ArmaClone.SmokePart.CFrame.upVector * ((((0)*Zeroing.Value/2.8)/Settings.BSpeed*3.571))/2)
	end
	if Settings.NoMove then
		delay(.5,function()
			Bullet.Anchored = true
		end)
	end
	local BulletCF = CFrame.new(Origin, Origin + Direction)
	local balaspread = CFrame.Angles(
		RAD(RAND(-BSpread - (SpeedPrecision*Settings.WalkMultiplier), BSpread + (SpeedPrecision*Settings.WalkMultiplier)) / 20),
		RAD(RAND(-BSpread - (SpeedPrecision*Settings.WalkMultiplier), BSpread + (SpeedPrecision*Settings.WalkMultiplier)) / 20),
		RAD(RAND(-BSpread - (SpeedPrecision*Settings.WalkMultiplier), BSpread + (SpeedPrecision*Settings.WalkMultiplier)) / 20)
	)
	Direction = balaspread * Direction	


	Bullet.Parent = BulletModel
	Bullet.CFrame = BulletCF + Direction
	if Settings.NoMove then
		Bullet.CFrame = BulletCF + Direction + (ArmaClone.SmokePart.CFrame.upVector*-1)
	end
	if Settings.ExplosiveHit == false then
		Bullet.Velocity = Direction * Settings.BSpeed*3.571
	end
	if Settings.ExplosiveHit == true then
		Bullet.Velocity = Direction * Settings.BSpeed*3.571
	end
	local RainbowModeCode = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))

	local Visivel = TracerCalculation()

	if Settings.BulletFlare == true and Visivel then
		local bg = Instance.new("BillboardGui", Bullet)
		bg.Adornee = Bullet
		bg.Enabled = false
		local flashsize = math.random(275, 375)/10
		bg.Size = UDim2.new(flashsize, 0, flashsize, 0)
		bg.LightInfluence = 0
		local flash = Instance.new("ImageLabel", bg)
		flash.BackgroundTransparency = 1
		flash.Size = UDim2.new(1, 0, 1, 0)
		flash.Position = UDim2.new(0, 0, 0, 0)
		flash.Image = "http://www.roblox.com/asset/?id=1047066405"

		if Settings.RainbowMode == true then
			flash.ImageColor3 = RainbowModeCode
		else
			flash.ImageColor3 = Settings.BulletFlareColor
		end
		flash.ImageTransparency = math.random(2, 5)/15
		spawn(function()
			wait(.2)
			if Bullet:FindFirstChild("BillboardGui") ~= nil then
				Bullet.BillboardGui.Enabled = true
			end
		end)
	end

	if Settings.Tracer == true and Visivel then			--and Visivel


		local At1 = Instance.new("Attachment")
		At1.Name = "At1"
		At1.Position = Vector3.new(-(.15),0,0)
		At1.Parent = Bullet

		local At2  = Instance.new("Attachment")
		At2.Name = "At2"
		At2.Position = Vector3.new((.15),0,0)
		At2.Parent = Bullet

		local Particles = Instance.new("Trail")
		Particles.Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0);
			NumberSequenceKeypoint.new(1, 1);
		}
		)
		Particles.WidthScale = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0.5);
			NumberSequenceKeypoint.new(0.25, 1);
			NumberSequenceKeypoint.new(0.75, 1);
			NumberSequenceKeypoint.new(1, 0.5);
		})

			--[[local Cylinder = Instance.new('CylinderHandleAdornment')
			Cylinder.Adornee = Bullet
			Cylinder.Height = 0
			Cylinder.Radius = 0.2
			Cylinder.Color3 = BColor
			Cylinder.Parent = Bullet]]--

		Particles.Color = ColorSequence.new(Settings.TracerColor)
		--Particles.Texture = "rbxassetid://10822615828"
		Particles.Texture = "rbxassetid://232918622"
		Particles.TextureMode = Enum.TextureMode.Stretch

		Particles.FaceCamera = true
		Particles.LightEmission = 0.25
		Particles.Brightness = 20
		Particles.LightInfluence = 0
		Particles.Lifetime = .04
		--Particles.MaxLength = 25
		Particles.Attachment0 = At1
		Particles.Attachment1 = At2
		Particles.Parent = Bullet

		--if not third or not IsFreecam() then
		local bg = Instance.new("BillboardGui", Bullet)
		bg.Adornee = Bullet
		bg.Enabled = false
		local flashsize = math.random(15, 25)/10
		bg.Size = UDim2.new(flashsize, 0, flashsize, 0)
		bg.LightInfluence = 0
		bg.Brightness = 25
		local flash = Instance.new("ImageLabel", bg)
		flash.BackgroundTransparency = 1
		flash.Size = UDim2.new(1, 0, 1, 0)
		flash.Position = UDim2.new(0, 0, 0, 0)
		--flash.Image = "http://www.roblox.com/asset/?id=1047066405"
		flash.Image = "rbxassetid://10822615828"
		flash.ImageTransparency = 0.15
		flash.ImageColor3 = Settings.TracerColor
		--end

		local TLight = Instance.new('PointLight',Bullet)
		TLight.Color = Settings.TracerColor
		TLight.Shadows = true
		TLight.Range = 9
		TLight.Brightness = 0.4

		task.defer(function()
			repeat
				RS.RenderStepped:Wait()
			until not Bullet or (Bullet.Position - camera.CFrame.Position).Magnitude > 10
			--Beam.Enabled = true
			if Bullet:FindFirstChild("BillboardGui") ~= nil then
				Bullet.BillboardGui.Enabled = true
			end
		end)





	end

	--[[if Settings.Tracer == true and Visivel then
		
		local At1 = Instance.new("Attachment")
		At1.Name = "At1"
		At1.Position = Vector3.new(-(Settings.TracerWidth),0,0)
		At1.Parent = Bullet
		
		local At2  = Instance.new("Attachment")
		At2.Name = "At2"
		At2.Position = Vector3.new((Settings.TracerWidth),0,0)
		At2.Parent = Bullet
		
		local Particles = Instance.new("Trail")
		Particles.Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0, 0);
			NumberSequenceKeypoint.new(1, 0);
		}
		)
		Particles.WidthScale = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 2, 0);
			NumberSequenceKeypoint.new(1, 1);
		}
		)
		
		if Settings.RainbowMode == true then
			Particles.Color = ColorSequence.new(RainbowModeCode)
		else
			Particles.Color = ColorSequence.new(Settings.TracerColor)
		end
		Particles.Texture = "rbxassetid://172380355"
		Particles.TextureMode = Enum.TextureMode.Stretch
		
		Particles.FaceCamera = true
		if Settings.ExplosiveHit == false then
			Particles.MaxLength = 60
		end
		Particles.LightEmission = Settings.TracerLightEmission
		Particles.LightInfluence = Settings.TracerLightInfluence 
		Particles.Lifetime = Settings.TracerLifeTime
		Particles.Attachment0 = At1
		Particles.Attachment1 = At2
		Particles.Parent = Bullet
	end]]--

	--[[if Settings.BulletLight == true and Visivel then
		local BulletLight = Instance.new("PointLight")
		BulletLight.Parent = Bullet
		BulletLight.Brightness = Settings.BulletLightBrightness
		if Settings.RainbowMode == true then
			BulletLight.Color = RainbowModeCode
		else
			BulletLight.Color = Settings.BulletLightColor
		end
		BulletLight.Range = Settings.BulletLightRange
		BulletLight.Shadows = true

	end]]--

	--[[if Settings.SpecialBullet ~= nil then
		local function fireSpecial(L_442_arg1)
			require(Engine.Modulos.handleSpecials).createSpecial(Character,Speedo,{
				Bullet,
				Player,
				Settings,
			});
		end;
		
		fireSpecial()
	end]]--

	if Visivel then
		if ServerConfig.ReplicatedBullets then
			ProjectileNetcodeClient.Bullet:Fire(BulletCF, Settings.Tracer, (Settings.BDrop), (Settings.BSpeed), Direction, Settings.TracerColor,Ray_Ignore,Settings.BulletFlare,Settings.BulletFlareColor,Settings.SpecialBullet)
		end
	end
	game.Debris:AddItem(Bullet, 30)
	return Bullet

end


function CalcularDano(DanoBase,Dist,Vitima,Type)

	local damage = 0
	local VestDamage = 0
	local HelmetDamage = 0
	local Traveleddamage = DanoBase-(math.ceil(Dist)/40)*Settings.FallOfDamage
	if Vitima.Parent:FindFirstChild("Saude") ~= nil then

		local Vest =  Vitima.Parent.Saude.Protecao.VestVida
		local Vestfactor = Vitima.Parent.Saude.Protecao.VestProtect
		local Helmet = Vitima.Parent.Saude.Protecao.HelmetVida
		local Helmetfactor = Vitima.Parent.Saude.Protecao.HelmetProtect

		if Type == "Head" then
			if Helmet.Value > 0 and (Settings.BulletPenetration) < Helmetfactor.Value  then
				damage = Traveleddamage * ((Settings.BulletPenetration)/Helmetfactor.Value)
				HelmetDamage = (Traveleddamage * ((100 - Settings.BulletPenetration)/Helmetfactor.Value))

				if HelmetDamage <= 0 then
					HelmetDamage = 0.5
				end

			elseif Helmet.Value > 0 and (Settings.BulletPenetration) >= Helmetfactor.Value then
				damage = Traveleddamage
				HelmetDamage = (Traveleddamage * ((100 - Settings.BulletPenetration)/Helmetfactor.Value))

				if HelmetDamage <= 0 then
					HelmetDamage = 1
				end				

			elseif Helmet.Value <= 0 then
				damage = Traveleddamage

			end
		else
			if Vest.Value > 0 and (Settings.BulletPenetration) < Vestfactor.Value  then
				damage = Traveleddamage * ((Settings.BulletPenetration)/Vestfactor.Value)
				VestDamage = (Traveleddamage * ((100 - Settings.BulletPenetration)/Vestfactor.Value))

				if VestDamage <= 0 then
					VestDamage = 0.5
				end

			elseif Vest.Value > 0 and (Settings.BulletPenetration) >= Vestfactor.Value then
				damage = Traveleddamage
				VestDamage = (Traveleddamage * ((100 - Settings.BulletPenetration)/Vestfactor.Value))

				if VestDamage <= 0 then
					VestDamage =  1
				end				

			elseif Vest.Value <= 0 then
				damage = Traveleddamage

			end
		end
	else
		damage = Traveleddamage
	end			
	if damage <= 0 then
		damage = 1
	end

	return damage,VestDamage,HelmetDamage
end

local WhizzSound = Engine.Cracks:GetChildren()
local Whizz = Engine.Whizz:GetChildren() -- Bullet Whizz
Evt.Whizz.OnClientEvent:connect(function()

	local Som = Instance.new('Sound')
	Som.Parent = Jogador.PlayerGui
	Som.SoundId = WhizzSound[math.random(#WhizzSound)].SoundId
	Som.Volume = 2
	Som.PlayOnRemove = true
	Som:Destroy()

	local Som2 = Instance.new('Sound')
	Som2.Parent = Jogador.PlayerGui
	Som2.SoundId = Whizz[math.random(#Whizz)].SoundId
	Som2.Volume = 2
	Som2.PlayOnRemove = true
	Som2:Destroy()

end)

suppCon = nil
suppCount = 0
suppStage = 1
wind = nil
ringy = nil

Evt.Suppression.OnClientEvent:Connect(function(Mode,Intensity,Tempo)
	if ServerConfig.EnableStatusUI and Jogador.Character and Human.Health > 0 then
		if Mode == 1 then

			ts(StatusClone.Efeitos.Suppress,TweenInfo.new(.1),{ImageTransparency = 0, Size = UDim2.fromScale(1,1)}):Play()
			delay(.1*suppStage,function()
				ts(StatusClone.Efeitos.Suppress,TweenInfo.new(0.25,Enum.EasingStyle.Exponential,Enum.EasingDirection.InOut,0,false,0.15),{ImageTransparency = 1,Size = UDim2.fromScale(2,2)}):Play()
			end)

			camShake:Start()
			camShake:ShakeOnce(2, 2, 0, 0.25)

		else
			local SKP_22 = script.FX.Dirty:clone()
			SKP_22.Parent = Jogador.PlayerGui.StatusUI.Supressao
			SKP_22.ImageTransparency = 0
			SKP_22.BackgroundTransparency = (Intensity - 1) * -1

			ts(SKP_22,TweenInfo.new(0.25 ,Enum.EasingStyle.Linear,Enum.EasingDirection.In,0,false,0),{ImageTransparency = 0}):Play()
			ts(SKP_22,TweenInfo.new(Tempo/2 ,Enum.EasingStyle.Elastic,Enum.EasingDirection.In,0,false,0),{BackgroundTransparency = 1}):Play()


			delay(Tempo/2,function()
				ts(SKP_22,TweenInfo.new(Tempo ,Enum.EasingStyle.Sine,Enum.EasingDirection.In,0,false,0),{ImageTransparency = 1}):Play()
				TS:AddItem(SKP_22, Tempo)
			end)
		end
	end

	if suppCon then
		task.cancel(suppCon)
		suppCon = nil
	end

	suppCount += 1

	local stageThreshold = 5

	local m = game.SoundService.All:FindFirstChild("SuppMuffle")

	if suppCount >= stageThreshold then
		suppCount = 0
		suppStage = math.clamp(suppStage + 1,1,5)
	end

	if suppStage >= 3 then
		ts(m,TweenInfo.new(1),{HighGain = -suppStage*4.5,LowGain = suppStage/2.5,MidGain = -suppStage*4.5}):Play()
	end

	if suppStage >= 4 then
		if not Jogador.PlayerGui:FindFirstChild("MuffleWind") then
			wind = PastaFX.MuffleWind:Clone()
			wind.Parent = Jogador.PlayerGui
			wind.SoundGroup = game.SoundService.All
			wind:Play()
			wind.Volume = 1.2
		end
		if not Jogador.PlayerGui:FindFirstChild("EarRing") then
			ringy = PastaFX.EarRing:Clone()
			ringy.Parent = Jogador.PlayerGui
			ringy:Play()
			ringy.Volume = 1.75
		end
	end

	--m.Parent = game.SoundService.All

	suppCon = task.delay(2+(suppStage*0.75),function()
		ts(m,TweenInfo.new(1),{HighGain = 0,LowGain = 0,MidGain = 0}):Play()
		if wind then
			ts(wind,TweenInfo.new(1),{Volume = 0}):Play()
			game.Debris:AddItem(wind,1)
		end
		if ringy then
			ts(ringy,TweenInfo.new(1),{Volume = 0}):Play()
			game.Debris:AddItem(ringy,1)
		end
		ts(StatusClone.Efeitos.Suppress,TweenInfo.new(1,Enum.EasingStyle.Quint,Enum.EasingDirection.Out,0,false,0.15),{ImageTransparency = 1,Size = UDim2.fromScale(2,2)}):Play()
		task.wait(1)
		suppCount = 0
		suppStage = 1
	end)

end)

local headbloods = Engine.MaterialHit.EntryBlood:GetChildren()
local otherbloods = Engine.MaterialHit.EntryBlood:GetChildren()
bloodpools = Engine.MaterialHit.BloodPool:GetChildren()
function bloodlmao(ignorepart, pos, norm, texture)
	Evt.CreateBlood:FireServer(ignorepart,pos,norm,texture,Camera)
end

--[[function CastRay(Bala)

	local Hit2, Pos2, Norm2, Mat2
	local Hit, Pos, Norm, Mat
	local L_257_ = ArmaClone.SmokePart.Position;
	local L_258_ = Bala.Position;
	local TotalDistTraveled = 0
	local L_260_ = false	
	local recast
	
	while true do
		RS.Heartbeat:wait()
		L_258_ = Bala.Position;
		TotalDistTraveled = TotalDistTraveled + (L_258_ - L_257_).magnitude
	
		Hit2, Pos2, Norm2, Mat2 = workspace:FindPartOnRayWithIgnoreList(Ray.new(L_257_, (L_258_ - L_257_)*20), Ray_Ignore, false, true);

		Hit, Pos, Norm, Mat = workspace:FindPartOnRayWithIgnoreList(Ray.new(L_257_, (L_258_ - L_257_)), Ray_Ignore, false, true);
		--old = L_265_forvar2 ~= Player
		for L_264_forvar1, L_265_forvar2 in pairs(game.Players:GetChildren()) do
			if L_265_forvar2:IsA('Player') and L_265_forvar2 ~= Player and L_265_forvar2.Character and L_265_forvar2.Character:FindFirstChild('Head') and (L_265_forvar2.Character:FindFirstChild('Head').Position - Pos).magnitude <= Settings.SuppressMaxDistance and Settings.BulletWhiz and not L_260_ then
				Evt.Whizz:FireServer(L_265_forvar2)
				Evt.Suppression:FireServer(L_265_forvar2)
				L_260_ = true
			end
		end

		if TotalDistTraveled > Settings.Distance then
			Bala:Destroy()
			L_260_ = true
			break
		end
		
		if Hit2 then
			while not recast do
				if Hit2 and (Hit2 and Hit2.Transparency >= 0.9 or Hit2.CanCollide == false or Hit2.Name == "Ignorable" or Hit2.Name == "Bush" or Hit2.Name == "Glass" or Hit2.Parent.Name == "Top" or Hit2.Parent.Name == "Accessory4" or Hit2.Parent.Name == "Helmet" or Hit2.Parent.Name == "Up" or Hit2.Parent.Name == "Down" or Hit2.Parent.Name == "Face" or Hit2.Parent.Name == "Olho" or Hit2.Parent.Name == "Headset" or Hit2.Parent.Name == "Numero" or Hit2.Parent.Name == "Vest" or Hit2.Parent.Name == "Chest" or Hit2.Parent.Name == "Waist" or Hit2.Parent.Name == "Back" or Hit2.Parent.Name == "Belt" or Hit2.Parent.Name == "Leg1" or Hit2.Parent.Name == "Leg2" or Hit2.Parent.Name == "Arm1"  or Hit2.Parent.Name == "Arm2") and Hit2.Name ~= 'Right Arm' and Hit2.Name ~= 'Left Arm' and Hit2.Name ~= 'Right Leg' and Hit2.Name ~= 'Left Leg' and Hit2.Name ~= 'Armor' and Hit2.Name ~= 'Visor' and Hit2.Name ~= 'EShield' then
					table.insert(Ray_Ignore, Hit2)
					recast = true
					end
	
				if recast then
					Hit2, Pos2, Norm2, Mat2 = workspace:FindPartOnRayWithIgnoreList(Ray.new(L_257_, (L_258_ - L_257_)*20), Ray_Ignore, false, true);
					Hit, Pos, Norm, Mat = workspace:FindPartOnRayWithIgnoreList(Ray.new(L_257_, (L_258_ - L_257_)), Ray_Ignore, false, true);
					recast = false
				else
					break
				end
			end
		end

		if Hit and not recast then
			Bala:Destroy()
			L_260_ = true
			local FoundHuman,VitimaHuman = CheckForHumanoid(Hit)
				Hitmarker.HitEffect(Ray_Ignore,ACS_Storage, Pos, Hit, Norm, Mat, Settings)
				ProjectileNetcodeClient.BulletHit:Fire(true,Pos, Hit, Norm, Mat,Settings,TotalDistTraveled)
			if FoundHuman == true and VitimaHuman.Health > 0 then
				if ServerConfig.HitmarkerSound then
					local hurtSound = PastaFX.Hitmarker:Clone()
					hurtSound.Parent = Player.PlayerGui
					hurtSound.Volume = 2
					hurtSound.PlayOnRemove = true
					Debris:AddItem(hurtSound,0)	
				end			

				if not  Settings.ModoTreino then
					Evt.CreateOwner:FireServer(VitimaHuman)
					if game.Players:FindFirstChild(VitimaHuman.Parent.Name) == nil then
						if (Character.HumanoidRootPart.Position - Hit.Position).Magnitude <= 20 then
							spawn(function()
								Gui.Parent.BloodSplatter.Image = "rbxassetid://" .. BloodDecals[math.random(1, 4)]
								local tween = game:GetService("TweenService"):Create(Gui.Parent.BloodSplatter,TweenInfo.new(0.1),{ImageTransparency = 0.5}):Play()
								wait(1.1)
								game:GetService("TweenService"):Create(Gui.Parent.BloodSplatter,TweenInfo.new(3),{ImageTransparency = 1}):Play()
							end)
							local relative
							for _,v in pairs(game.Players:GetPlayers()) do
								if v ~= Player then
									relative = v
								end
							end
							local noParticle = Hit.Parent == game.Players.LocalPlayer.Character--((HitPart:IsDescendantOf(game.Players.LocalPlayer.Character) and HitPart.Name == 'Head'))

							if noParticle then
								local pos,vis = workspace.CurrentCamera:WorldToScreenPoint((Hit.CFrame*(CFrame.new():Lerp(relative,5))).p)
								if pos.Z < 0 then
									pos = pos*-1
								end
								if not game.Players.LocalPlayer.PlayerGui:FindFirstChild('BloodVisual') then
									local sc = Instance.new('ScreenGui')
									sc.DisplayOrder = -200
									sc.Name = 'BloodVisual'
									sc.Parent = game.Players.LocalPlayer.PlayerGui
								end
								pos = Vector2.new(pos.X,pos.Y)
								--local div = pos/workspace.CurrentCamera.ViewportSize
								local ui = Instance.new('ImageLabel')
								ui.BackgroundTransparency = 1
								local rand = math.random()*2
								ui.Size = UDim2.new(rand,0,rand,0)
								ui.Position = UDim2.new(0,pos.X,0,pos.Y)
								ui.SizeConstraint = Enum.SizeConstraint.RelativeYY
								ui.AnchorPoint = Vector2.new(.5,.5)
								local decals = game.ReplicatedStorage.ACS_Engine.MaterialHit.View:GetChildren()
								local decal = decals[math.random(#decals)]
								ui.Image = decal.Texture
								ui.ImageTransparency = decal.Transparency
								ui.ImageColor3 = decal.Color3
								ui.Parent = game.Players.LocalPlayer.PlayerGui.BloodVisual
								delay(5,function()
									local timeLeft = 30
									game:GetService('TweenService'):Create(ui,TweenInfo.new(timeLeft,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut),{ImageTransparency = 1}):Play()
									game.Debris:AddItem(ui,timeLeft)
								end)
							end
						end
							if Hit.Name == "Head" then
								local DanoBase = math.random(Settings.HeadDamage[1], Settings.HeadDamage[2])
							local Dano,DanoColete,DanoCapacete = CalcularDano(DanoBase, TotalDistTraveled, VitimaHuman, "Head")
							bloodlmao(Hit, Pos, Norm, headbloods[math.random(1,#headbloods)])
							ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Head",Settings.BulletPenetration)
							elseif Hit.Name == "Torso" or Hit.Parent.Name == "UpperTorso" or Hit.Parent.Name == "LowerTorso" then
								local DanoBase = math.random(Settings.TorsoDamage[1], Settings.TorsoDamage[2])
							local Dano,DanoColete,DanoCapacete = CalcularDano(DanoBase, TotalDistTraveled, VitimaHuman, "Body")
							bloodlmao(Hit, Pos, Norm, otherbloods[math.random(1,#otherbloods)])
							ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Torso",Settings.BulletPenetration)
							else
							local DanoBase = math.random(Settings.TorsoDamage[1], Settings.TorsoDamage[2])
							local Dano,DanoColete,DanoCapacete = CalcularDano(DanoBase, TotalDistTraveled, VitimaHuman, "Body")
							bloodlmao(Hit, Pos, Norm, otherbloods[math.random(1,#otherbloods)])
							if Hit.Name == "Left Arm" then
								ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Left Arm",Settings.BulletPenetration)
							elseif Hit.Name == "Right Arm" then
								ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Right Arm",Settings.BulletPenetration)
							elseif Hit.Name == "Left Leg" then
								ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Left Leg",Settings.BulletPenetration)
								elseif Hit.Name == "Right Leg" then
								ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Right Leg",Settings.BulletPenetration)
								end
							end
				
					else
					
					if not ServerConfig.TeamKill then
						if game.Players:FindFirstChild(VitimaHuman.Parent.Name) and game.Players:FindFirstChild(VitimaHuman.Parent.Name).Team ~= Player.Team or game.Players:FindFirstChild(VitimaHuman.Parent.Name) == nil then
							if Hit.Name == "Head" or Hit.Parent.Name == "Top" or Hit.Parent.Name == "Headset" or Hit.Parent.Name == "Olho" or Hit.Parent.Name == "Face" or Hit.Parent.Name == "Numero" then
								local DanoBase = math.random(Settings.HeadDamage[1], Settings.HeadDamage[2])
									local Dano,DanoColete,DanoCapacete = CalcularDano(DanoBase, TotalDistTraveled, VitimaHuman, "Head")
									bloodlmao(Hit, Pos, Norm, headbloods[math.random(1,#headbloods)])
									ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Head",Settings.BulletPenetration)
							elseif (Hit.Parent:IsA('Accessory') or Hit.Parent:IsA('Hat')) then
								local DanoBase = math.random(Settings.HeadDamage[1], Settings.HeadDamage[2])
									local Dano,DanoColete,DanoCapacete = CalcularDano(DanoBase, TotalDistTraveled, VitimaHuman, "Head")
									bloodlmao(Hit, Pos, Norm, headbloods[math.random(1,#headbloods)])
									ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Head",Settings.BulletPenetration)
							elseif Hit.Name == "Torso" or Hit.Parent.Name == "Chest" or Hit.Parent.Name == "Waist" then
								local DanoBase = math.random(Settings.TorsoDamage[1], Settings.TorsoDamage[2])
									local Dano,DanoColete,DanoCapacete = CalcularDano(DanoBase, TotalDistTraveled, VitimaHuman, "Body")
									bloodlmao(Hit, Pos, Norm, otherbloods[math.random(1,#otherbloods)])
									ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Torso",Settings.BulletPenetration)
							else
									local DanoBase = math.random(Settings.TorsoDamage[1], Settings.TorsoDamage[2])
									local Dano,DanoColete,DanoCapacete = CalcularDano(DanoBase, TotalDistTraveled, VitimaHuman, "Body")
									bloodlmao(Hit, Pos, Norm, otherbloods[math.random(1,#otherbloods)])
									if Hit.Name == "Left Arm" then
										ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Left Arm",Settings.BulletPenetration)
									elseif Hit.Name == "Right Arm" then
										ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Right Arm",Settings.BulletPenetration)
									elseif Hit.Name == "Left Leg" then
										ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Left Leg",Settings.BulletPenetration)
									elseif Hit.Name == "Right Leg" then
										ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Right Leg",Settings.BulletPenetration)
									end
							end	
						end
					else
						if game.Players:FindFirstChild(VitimaHuman.Parent.Name) and game.Players:FindFirstChild(VitimaHuman.Parent.Name).Team ~= Player.Team or game.Players:FindFirstChild(VitimaHuman.Parent.Name) == nil  then				
								if Hit.Name == "Head" or Hit.Parent.Name == "Top" or Hit.Parent.Name == "Headset" or Hit.Parent.Name == "Olho" or Hit.Parent.Name == "Face" or Hit.Parent.Name == "Numero" then
									local DanoBase = math.random(Settings.HeadDamage[1], Settings.HeadDamage[2])
									local Dano,DanoColete,DanoCapacete = CalcularDano(DanoBase, TotalDistTraveled, VitimaHuman, "Head")
									bloodlmao(Hit, Pos, Norm, headbloods[math.random(1,#headbloods)])
									ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Head",Settings.BulletPenetration)
								elseif (Hit.Parent:IsA('Accessory') or Hit.Parent:IsA('Hat')) then
									local DanoBase = math.random(Settings.HeadDamage[1], Settings.HeadDamage[2])
									local Dano,DanoColete,DanoCapacete = CalcularDano(DanoBase, TotalDistTraveled, VitimaHuman, "Head")
									bloodlmao(Hit, Pos, Norm, headbloods[math.random(1,#headbloods)])
									ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Head",Settings.BulletPenetration)
								elseif Hit.Name == "Torso" or Hit.Parent.Name == "Chest" or Hit.Parent.Name == "Waist" then
									local DanoBase = math.random(Settings.TorsoDamage[1], Settings.TorsoDamage[2])
									local Dano,DanoColete,DanoCapacete = CalcularDano(DanoBase, TotalDistTraveled, VitimaHuman, "Body")
									bloodlmao(Hit, Pos, Norm, otherbloods[math.random(1,#otherbloods)])
									ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Torso",Settings.BulletPenetration)
								else
									local DanoBase = math.random(Settings.TorsoDamage[1], Settings.TorsoDamage[2])
									local Dano,DanoColete,DanoCapacete = CalcularDano(DanoBase, TotalDistTraveled, VitimaHuman, "Body")
									bloodlmao(Hit, Pos, Norm, otherbloods[math.random(1,#otherbloods)])
									if Hit.Name == "Left Arm" then
										ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Left Arm",Settings.BulletPenetration)
									elseif Hit.Name == "Right Arm" then
										ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Right Arm",Settings.BulletPenetration)
									elseif Hit.Name == "Left Leg" then
										ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Left Leg",Settings.BulletPenetration)
									elseif Hit.Name == "Right Leg" then
										ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Right Leg",Settings.BulletPenetration)
									end
								
							end	
						else 
								if Hit.Name == "Head" or Hit.Parent.Name == "Top" or Hit.Parent.Name == "Headset" or Hit.Parent.Name == "Olho" or Hit.Parent.Name == "Face" or Hit.Parent.Name == "Numero" then
									local DanoBase = math.random(Settings.HeadDamage[1], Settings.HeadDamage[2])
									local Dano,DanoColete,DanoCapacete = CalcularDano(DanoBase, TotalDistTraveled, VitimaHuman, "Head")
									ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Head",Settings.BulletPenetration)
								elseif (Hit.Parent:IsA('Accessory') or Hit.Parent:IsA('Hat')) then
									local DanoBase = math.random(Settings.HeadDamage[1], Settings.HeadDamage[2])
									local Dano,DanoColete,DanoCapacete = CalcularDano(DanoBase, TotalDistTraveled, VitimaHuman, "Head")
									ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Head",Settings.BulletPenetration)
								elseif Hit.Name == "Torso" or Hit.Parent.Name == "Chest" or Hit.Parent.Name == "Waist" then
									local DanoBase = math.random(Settings.TorsoDamage[1], Settings.TorsoDamage[2])
									local Dano,DanoColete,DanoCapacete = CalcularDano(DanoBase, TotalDistTraveled, VitimaHuman, "Body")
									ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Torso",Settings.BulletPenetration)
								else
									local DanoBase = math.random(Settings.TorsoDamage[1], Settings.TorsoDamage[2])
									local Dano,DanoColete,DanoCapacete = CalcularDano(DanoBase, TotalDistTraveled, VitimaHuman, "Body")
									if Hit.Name == "Left Arm" then
										ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Left Arm",Settings.BulletPenetration)
									elseif Hit.Name == "Right Arm" then
										ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Right Arm",Settings.BulletPenetration)
									elseif Hit.Name == "Left Leg" then
										ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Left Leg",Settings.BulletPenetration)
									elseif Hit.Name == "Right Leg" then
										ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Right Leg",Settings.BulletPenetration)
									end
								end		
						end
					end
				end
				else
				if Hit.Name == "Head" or Hit.Parent.Name == "Top" or Hit.Parent.Name == "Headset" or Hit.Parent.Name == "Olho" or Hit.Parent.Name == "Face" or Hit.Parent.Name == "Numero"  or (Hit.Parent:IsA('Accessory') or Hit.Parent:IsA('Hat')) or Hit.Name == "Torso" or Hit.Parent.Name == "Chest" or Hit.Parent.Name == "Waist" or Hit.Name == "Right Arm" or Hit.Name == "Left Arm" or Hit.Name == "Right Leg" or Hit.Name == "Left Leg" or Hit.Parent.Name == "Back" or Hit.Parent.Name == "Leg1" or Hit.Parent.Name == "Leg2" or Hit.Parent.Name == "Arm1" or Hit.Parent.Name == "Arm2" then
					Evt.Treino:FireServer(VitimaHuman)
				end
			end
			break
			end
		end		
		L_257_ = L_258_;
	end
end]]--
function CastRay(Bala)

	local Hit2, Pos2, Norm2, Mat2
	local Hit, Pos, Norm, Mat
	local BalaVector
	local WallbangRay
	local BulletPower = 1

	local PrevPos = ArmaClone.SmokePart.Position
	local BalaPos = Bala.Position

	--print("Bullet Created")

	local TotalDistTraveled = 0
	local recast
	local BulletStopped = false
	local WallbangParts = {}

	local RicoHappened = false
	local RicoPos = Vector3.new(0,0,0)




	local function FindMaterial(dict,mat)
		local result = dict[mat]
		if result then
			return result
		else
			return dict["default"]
		end
	end

	local function DoRico()
		if (RicoPos - Pos).Magnitude > 0.2 then
			local Angle = math.deg(math.acos(BalaVector.Unit:Dot(Norm.Unit))) - 90
			if Angle < FindMaterial(RicochetMaterialMaxAngles,Mat) then
				print("Successful Bullet Ricochet at angle: "..Angle)
				Bala.Position = Pos
				Bala.Velocity = Bala.Velocity.Magnitude * (BalaVector.Unit - 2 * BalaVector.Unit:Dot(Norm) * Norm).Unit
				BulletPower = BulletPower * (1 - RicochetLoss)
				RicoPos = Pos
				PrevPos = Bala.Position
				RicoHappened = true
			else
				Bala:Destroy()
				BulletHit(Hit, Pos, Norm, Mat, TotalDistTraveled,BulletPower)
				BulletStopped = true
			end
		else
			Bala:Destroy()
			BulletHit(Hit, Pos, Norm, Mat, TotalDistTraveled,BulletPower)
			BulletStopped = true
		end
	end

	local function RaycastAhead()
		--debug.profilebegin("Check ahead of bullet raycast")
		Hit2, Pos2, Norm2, Mat2 = workspace:FindPartOnRayWithIgnoreList(Ray.new(PrevPos, (BalaPos - PrevPos)*2), Ray_Ignore, false, true)
		--debug.profileend()
	end


	while not BulletStopped do
		RS.Heartbeat:wait()
		BalaPos = Bala.Position;
		TotalDistTraveled = TotalDistTraveled + (BalaPos - PrevPos).magnitude

		--[[if TotalDistTraveled > Settings.Distance then
			Bala:Destroy()
			break
		end]]--

		RaycastAhead()

		Hit2, Pos2, Norm2, Mat2 = workspace:FindPartOnRayWithIgnoreList(Ray.new(PrevPos, (BalaPos - PrevPos)*5), Ray_Ignore, false, true);

		Hit, Pos, Norm, Mat, BalaVector = HitRaycast(BalaPos,PrevPos,Ray_Ignore)

		local DistFromCamera = (Bala.Position-camera.CFrame.Position).Magnitude

		if Bala:FindFirstChild("Trail") then
			--Bullet.At1.Position = Vector3.new(-.2 - (DistFromCamera / 220),0,-.2 - (DistFromCamera / 220))
			--Bullet.At2.Position = Vector3.new(.2 + (DistFromCamera / 220),0,.2 + (DistFromCamera / 220))
			--Bullet.Trail.MaxLength = 25 + (DistFromCamera / 50)
			--Bullet.Trail.Lifetime = .25 + (DistFromCamera / 100)
					--[[Bullet.Trail.WidthScale = NumberSequence.new({
						NumberSequenceKeypoint.new(0, 3 + (DistFromCamera / 100), 0);
						NumberSequenceKeypoint.new(1, 3 + (DistFromCamera / 100));
					}
					)]]--

			local dist = (Bala.Position - camera.CFrame.Position).Magnitude
			local pixels, fov = DistFunctions[camera.FieldOfViewMode.Name]()
			local factor = math.tan(math.rad(fov))

			local NW = .15 + dist * factor / pixels * math.sqrt(.15 * 4) -- add extra pixel of size to tracer
			Bala.At1.Position = Vector3.new(NW, 0, 0)
			Bala.At2.Position = Vector3.new(-NW, 0, 0)

			if Bala:FindFirstChild("BillboardGui") then
				Bala.BillboardGui.Size = UDim2.new(NW*1.5,0,NW*1.5,0)
			end

		end

		for L_264_f, PlayerTarget in pairs(game.Players:GetChildren()) do
			if PlayerTarget:IsA('Player') and PlayerTarget ~= Player and PlayerTarget.Character and PlayerTarget.Character:FindFirstChild('Head') then
				if (PlayerTarget.Character.Head.Position - Pos).magnitude <= Settings.SuppressMaxDistance and Settings.BulletWhiz and not L_260_ then
					Evt.Whizz:FireServer(PlayerTarget,Bala.Velocity.Magnitude)
					Evt.Suppression:FireServer(PlayerTarget)
					L_260_ = true
				end
			end
		end

		--[[if TotalDistTraveled > Settings.Distance then
			Bala:Destroy()
			break
		end]]--

		if Hit2 then
			while not recast do
				if Hit2 and (Hit2.Transparency >= 1 or Hit2.CanCollide == false or Hit2.Name == "Ignorable" or table.find(IgnoreAccessoriesList,Hit2.Parent.Name)) and Hit2.Name ~= 'RightUpperArm' and Hit2.Name ~= 'Visor' and Hit2.Name ~= 'LeftUpperArm' and Hit2.Name ~= 'RightUpperLeg' and Hit2.Name ~= 'LeftUpperLeg' and Hit2.Name ~= 'Armor' and Hit2.Name ~= 'Visor' and Hit2.Name ~= 'Stomach'  and Hit2.Name ~= 'Collision' and Hit2.Name ~= 'EShield' and Hit2.Name ~= "LeftLowerLeg" and Hit2.Name ~= "RightLowerLeg" and Hit2.Name ~= "RightLowerArm" and Hit2.Name ~= "Left Arm" and Hit2.Name ~= "Left Leg" and Hit2.Name ~= "Right Leg" and Hit2.Name ~= "Right Arm" and Hit2.Name ~= "Torso" and Hit2.Name ~= "Head" then
					table.insert(Ray_Ignore, Hit2)
					recast = true
				--[[elseif Hit2.Name == 'Visor' then
					local hitplr = game.Players:GetPlayerFromCharacter(Hit2.Parent.Parent.Parent)
					local durb = Hit2:FindFirstChild("Durability")

					Engine.Eventos.Armor.ChangeVisorDurb:FireServer(durb, hitplr)]]--
				end


				if recast then
					Hit2, Pos2, Norm2, Mat2 = workspace:FindPartOnRayWithIgnoreList(Ray.new(PrevPos, (BalaPos - PrevPos)*20), Ray_Ignore, false, true);
					Hit, Pos, Norm, Mat, BalaVector = HitRaycast(BalaPos,PrevPos,Ray_Ignore)
					recast = false
				else
					break
				end
			end
		end

		if Hit then

			local Hardness = WallbangMaterialHardness["default"]

			if WallbangSpecialNames[Hit.Name] then
				Hardness = WallbangSpecialNames[Hit.Name]
			elseif WallbangMaterialHardness[Mat] then
				Hardness = WallbangMaterialHardness[Mat]
			else
				Hardness = WallbangMaterialHardness["default"]
			end

			if WallbangEnabled and not Hit:IsA("Terrain") and not Hit:IsDescendantOf(workspace.Terrain) and Settings.ExplosiveHit == false and BulletPenetration + (Settings.BSpeed/1000) > Hardness then
				local CastDist
				local WallbangIgnore
				if Ray_Ignore then
					WallbangIgnore = {table.unpack(Ray_Ignore)}
				else
					WallbangIgnore = {}
				end


				local RayDirection = (BalaPos - PrevPos).Unit

				-- while bullet is passing through walls continue, if all exhausted (if not below) then pass on loop to next iteration
				while not BulletStopped do


					-- down the road, once all parts to raycast are exhausted, the function will eventually return Hit as nil, so this stops the loop
					if Hit and BulletPower >= 0 then


						local WallbangParams = RaycastParams.new()
						WallbangParams.FilterDescendantsInstances = {Hit}
						WallbangParams.FilterType = Enum.RaycastFilterType.Whitelist

						if WallbangSpecialNames[Hit.Name] then
							CastDist = BulletPenetration / WallbangSpecialNames[Hit.Name]
						elseif WallbangMaterialHardness[Mat] then
							CastDist = BulletPenetration / WallbangMaterialHardness[Mat]
						else
							CastDist = BulletPenetration / WallbangMaterialHardness["default"]
						end


						local CastDist2 = CastDist * BulletPower



						local WBRayPosition = Pos + RayDirection * CastDist2
						local WBRayVector = -RayDirection * CastDist2
						WallbangRay = workspace:Raycast(WBRayPosition, WBRayVector, WallbangParams)


						if WallbangRay and ((WallbangRay.Position - Pos).Magnitude <= Hardness + (Settings.BSpeed/1000)) then
							print("Wallbang Happened ("..(WallbangRay.Position - Pos).Magnitude..")")
							local thickness = (WallbangRay.Position - Pos).Magnitude
							if not (table.find(LimbsList, Hit.Name) or table.find(TorsoList, Hit.Name) or Hit.Name == "Head") then
								BulletPower = math.max(BulletPower - thickness / CastDist2, 0)
							end


							Bala.Velocity = Bala.Velocity.Unit * math.sqrt(BulletPower) * Settings.BSpeed -- E = 1/2 * m * v^2
							print("Part Thickness: " .. thickness .. " Bullet Power reduced to: " .. BulletPower)


							table.insert(WallbangParts,WallbangRay.Instance)
							table.insert(WallbangIgnore,WallbangRay.Instance)


							if WallbangDamage then
								BulletHit(Hit, Pos, Norm, Mat, TotalDistTraveled,BulletPower)
							else
								BulletHit(Hit, Pos, Norm, Mat, TotalDistTraveled,1)
							end

							if Settings.LimbsDamage[1] > 0 then
								Hitmarker.HitEffect(Ray_Ignore,ACS_Storage, WallbangRay.Position, WallbangRay.Instance, WallbangRay.Normal, WallbangRay.Material)
							end
							ProjectileNetcodeClient.BulletHit:Fire(true,WallbangRay.Position, WallbangRay.Instance, WallbangRay.Normal, WallbangRay.Material,Settings.ExplosiveHit,Settings.ExRadius,Settings.ExPressure,Settings.DestroyJointRadiusPercent,TotalDistTraveled)

							Hit, Pos, Norm, Mat, BalaVector = HitRaycast(BalaPos,PrevPos,WallbangIgnore)

						elseif RicochetEnabled then
							--debug.profileend()
							--BulletHit(Hit, Pos, Norm, Mat, TotalDistTraveled,BulletPower)
							DoRico()
							break
						else
							--print("Bullet Stopped")
							Bala:Destroy()


							if WallbangDamage then
								BulletHit(Hit, Pos, Norm, Mat, TotalDistTraveled,BulletPower)
							else
								BulletHit(Hit, Pos, Norm, Mat, TotalDistTraveled,1)
							end


							BulletStopped = true
							break
						end
					else
						break
					end
				end
			elseif RicochetEnabled and Settings.ExplosiveHit == false then
				print("Rico")
				BulletHit(Hit, Pos, Norm, Mat, TotalDistTraveled,BulletPower)
				DoRico()
			else
				Bala:Destroy()
				BulletHit(Hit, Pos, Norm, Mat, TotalDistTraveled,BulletPower)
				BulletStopped = true
			end

		end

		if RicoHappened then
			RicoHappened = false
		else
			PrevPos = BalaPos
		end
	end
end



function HitRaycast(BalaPos,PrevPos,Ignore)
	local Hit, Pos, Norm, Mat
	local vector = BalaPos - PrevPos
	Hit, Pos, Norm, Mat = workspace:FindPartOnRayWithIgnoreList(Ray.new(PrevPos, vector), Ignore, false, true)
	return Hit, Pos, Norm, Mat, vector
end


--[[function Richochet(BulletPower, Bala, BalaVector, Norm, Pos)
	local Angle = 90 - math.deg(math.acos(BalaVector:Dot(Norm)))
	if Angle < RichochetMaxAngle then
		Bala.Position = Pos
		Bala.Velocity = Bala.Velocity.Magnitude * (BalaVector - 2 * BalaVector:Dot(Norm) * Norm).Unit
		BulletPower = BulletPower * (1 - RichochetLoss)
	end
end]]--

function BulletHit(Hit, Pos, Norm, Mat, TotalDistTraveled,BulletPower)
	local FoundHuman,VitimaHuman = CheckForHumanoid(Hit)
	if Settings.LimbsDamage[1] > 0 then
		local function ImpactAnim()
			if Anims.ImpactAnim then
				Anims.ImpactAnim(Character, 0, {
					AnimBaseW,
					RA,
					LA,
					AnimBase.GripW,
					ArmaClone,
					StoredAmmo,
					Ammo,
					Settings,
					Chambered,
					Left_Weld,
					Right_Weld,
					Hit
				});
			end
		end

		Hitmarker.HitEffect(Ray_Ignore,ACS_Storage, Pos, Hit, Norm, Mat)
		delay(.1,function()
			ImpactAnim()
		end)
	end
	ProjectileNetcodeClient.BulletHit:Fire(true,Pos, Hit, Norm, Mat,Settings.ExplosiveHit,Settings.ExRadius,Settings.ExPressure,Settings.DestroyJointRadiusPercent,TotalDistTraveled)
	local VisorHitCooldown = false
	if FoundHuman then
		if ServerConfig.HitmarkerSound and VitimaHuman.Health > 0  then
			local hurtSound = PastaFX.Hitmarker:Clone()
			hurtSound.Parent = Player.PlayerGui
			hurtSound.Volume = 2
			hurtSound.PlayOnRemove = true
			Debris:AddItem(hurtSound,0)	
		end			

		if not  Settings.ModoTreino then
			if VitimaHuman.Health > 0  then
				Evt.CreateOwner:FireServer(VitimaHuman)
			end

			if not game.Players:FindFirstChild(VitimaHuman.Parent.Name) then
				if Hit.Name == "Head" then
					local DanoBase = math.random(Settings.HeadDamage[1], Settings.HeadDamage[2])
					local Dano,DanoColete,DanoCapacete = CalcularDano(DanoBase, TotalDistTraveled, VitimaHuman, "Head")
					bloodlmao(Hit, Pos, Norm, headbloods[math.random(1,#headbloods)])
					ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Head",Settings.BulletPenetration)
				elseif Hit.Name == "Stomach" or Hit.Parent.Name == "Stomach" then
					local DanoBase = math.random(Settings.TorsoDamage[1], Settings.TorsoDamage[2])
					local Dano,DanoColete,DanoCapacete = CalcularDano(DanoBase, TotalDistTraveled, VitimaHuman, "Body")
					bloodlmao(Hit, Pos, Norm, otherbloods[math.random(1,#otherbloods)])
					ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Stomach",Settings.BulletPenetration)
				elseif Hit.Name == "Torso" or Hit.Parent.Name == "UpperTorso" or Hit.Parent.Name == "LowerTorso" then
					local DanoBase = math.random(Settings.TorsoDamage[1], Settings.TorsoDamage[2])
					local Dano,DanoColete,DanoCapacete = CalcularDano(DanoBase, TotalDistTraveled, VitimaHuman, "Body")
					bloodlmao(Hit, Pos, Norm, otherbloods[math.random(1,#otherbloods)])
					ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Torso",Settings.BulletPenetration)
				else
					local DanoBase = math.random(Settings.TorsoDamage[1], Settings.TorsoDamage[2])
					local Dano,DanoColete,DanoCapacete = CalcularDano(DanoBase, TotalDistTraveled, VitimaHuman, "Body")
					bloodlmao(Hit, Pos, Norm, otherbloods[math.random(1,#otherbloods)])
					if Hit.Name == "Left Arm" then
						ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Left Arm",Settings.BulletPenetration)
					elseif Hit.Name == "Right Arm" then
						ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Right Arm",Settings.BulletPenetration)
					elseif Hit.Name == "Left Leg" then
						ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Left Leg",Settings.BulletPenetration)
					elseif Hit.Name == "Right Leg" then
						ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Right Leg",Settings.BulletPenetration)
					end
				end

			else

				if not ServerConfig.TeamKill then
					if game.Players:FindFirstChild(VitimaHuman.Parent.Name) and game.Players:FindFirstChild(VitimaHuman.Parent.Name).Team ~= Player.Team or game.Players:FindFirstChild(VitimaHuman.Parent.Name) == nil then
						if Hit.Name == "Head" or Hit.Parent.Name == "Top" or Hit.Parent.Name == "Headset" or Hit.Parent.Name == "Olho" or Hit.Parent.Name == "Face" or Hit.Parent.Name == "Numero" then
							local DanoBase = math.random(Settings.HeadDamage[1], Settings.HeadDamage[2])
							local Dano,DanoColete,DanoCapacete = CalcularDano(DanoBase, TotalDistTraveled, VitimaHuman, "Head")
							bloodlmao(Hit, Pos, Norm, headbloods[math.random(1,#headbloods)])
							ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Head",Settings.BulletPenetration)
						elseif (Hit.Parent:IsA('Accessory') or Hit.Parent:IsA('Hat')) then
							local DanoBase = math.random(Settings.HeadDamage[1], Settings.HeadDamage[2])
							local Dano,DanoColete,DanoCapacete = CalcularDano(DanoBase, TotalDistTraveled, VitimaHuman, "Head")
							bloodlmao(Hit, Pos, Norm, headbloods[math.random(1,#headbloods)])
							ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Head",Settings.BulletPenetration)
						elseif Hit.Name == "Stomach" or Hit.Parent.Name == "Stomach" then
							local DanoBase = math.random(Settings.TorsoDamage[1], Settings.TorsoDamage[2])
							local Dano,DanoColete,DanoCapacete = CalcularDano(DanoBase, TotalDistTraveled, VitimaHuman, "Body")
							bloodlmao(Hit, Pos, Norm, otherbloods[math.random(1,#otherbloods)])
							ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Stomach",Settings.BulletPenetration)
						elseif Hit.Name == "Torso" or Hit.Parent.Name == "Chest" or Hit.Parent.Name == "Waist" then
							local DanoBase = math.random(Settings.TorsoDamage[1], Settings.TorsoDamage[2])
							local Dano,DanoColete,DanoCapacete = CalcularDano(DanoBase, TotalDistTraveled, VitimaHuman, "Body")
							bloodlmao(Hit, Pos, Norm, otherbloods[math.random(1,#otherbloods)])
							ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Torso",Settings.BulletPenetration)
						else
							local DanoBase = math.random(Settings.TorsoDamage[1], Settings.TorsoDamage[2])
							local Dano,DanoColete,DanoCapacete = CalcularDano(DanoBase, TotalDistTraveled, VitimaHuman, "Body")
							bloodlmao(Hit, Pos, Norm, otherbloods[math.random(1,#otherbloods)])
							if Hit.Name == "Left Arm" then
								ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Left Arm",Settings.BulletPenetration)
							elseif Hit.Name == "Right Arm" then
								ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Right Arm",Settings.BulletPenetration)
							elseif Hit.Name == "Left Leg" then
								ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Left Leg",Settings.BulletPenetration)
							elseif Hit.Name == "Right Leg" then
								ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Right Leg",Settings.BulletPenetration)
							end
						end	
					end
				else
					if game.Players:FindFirstChild(VitimaHuman.Parent.Name) then				
						if Hit.Name == "Head" or Hit.Parent.Name == "Top" or Hit.Parent.Name == "Headset" or Hit.Parent.Name == "Olho" or Hit.Parent.Name == "Face" or Hit.Parent.Name == "Numero" then
							local DanoBase = math.random(Settings.HeadDamage[1], Settings.HeadDamage[2])
							local Dano,DanoColete,DanoCapacete = CalcularDano(DanoBase, TotalDistTraveled, VitimaHuman, "Head")
							bloodlmao(Hit, Pos, Norm, headbloods[math.random(1,#headbloods)])
							ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Head",Settings.BulletPenetration)
						elseif (Hit.Parent:IsA('Accessory') or Hit.Parent:IsA('Hat')) then
							local DanoBase = math.random(Settings.HeadDamage[1], Settings.HeadDamage[2])
							local Dano,DanoColete,DanoCapacete = CalcularDano(DanoBase, TotalDistTraveled, VitimaHuman, "Head")
							bloodlmao(Hit, Pos, Norm, headbloods[math.random(1,#headbloods)])
							ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Head",Settings.BulletPenetration)
						elseif Hit.Name == "Stomach" or Hit.Parent.Name == "Stomach" then
							local DanoBase = math.random(Settings.TorsoDamage[1], Settings.TorsoDamage[2])
							local Dano,DanoColete,DanoCapacete = CalcularDano(DanoBase, TotalDistTraveled, VitimaHuman, "Body")
							bloodlmao(Hit, Pos, Norm, otherbloods[math.random(1,#otherbloods)])
							ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Stomach",Settings.BulletPenetration)
						elseif Hit.Name == "Torso" or Hit.Parent.Name == "Chest" or Hit.Parent.Name == "Waist" then
							local DanoBase = math.random(Settings.TorsoDamage[1], Settings.TorsoDamage[2])
							local Dano,DanoColete,DanoCapacete = CalcularDano(DanoBase, TotalDistTraveled, VitimaHuman, "Body")
							bloodlmao(Hit, Pos, Norm, otherbloods[math.random(1,#otherbloods)])
							ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Torso",Settings.BulletPenetration)
						else
							local DanoBase = math.random(Settings.TorsoDamage[1], Settings.TorsoDamage[2])
							local Dano,DanoColete,DanoCapacete = CalcularDano(DanoBase, TotalDistTraveled, VitimaHuman, "Body")
							bloodlmao(Hit, Pos, Norm, otherbloods[math.random(1,#otherbloods)])
							if Hit.Name == "Left Arm" then
								ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Left Arm",Settings.BulletPenetration)
							elseif Hit.Name == "Right Arm" then
								ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Right Arm",Settings.BulletPenetration)
							elseif Hit.Name == "Left Leg" then
								ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Left Leg",Settings.BulletPenetration)
							elseif Hit.Name == "Right Leg" then
								ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Right Leg",Settings.BulletPenetration)
							end

						end	
					else 
						if Hit.Name == "Head" or Hit.Parent.Name == "Top" or Hit.Parent.Name == "Headset" or Hit.Parent.Name == "Olho" or Hit.Parent.Name == "Face" or Hit.Parent.Name == "Numero" then
							local DanoBase = math.random(Settings.HeadDamage[1], Settings.HeadDamage[2])
							local Dano,DanoColete,DanoCapacete = CalcularDano(DanoBase, TotalDistTraveled, VitimaHuman, "Head")
							ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Head",Settings.BulletPenetration)
						elseif (Hit.Parent:IsA('Accessory') or Hit.Parent:IsA('Hat')) then
							local DanoBase = math.random(Settings.HeadDamage[1], Settings.HeadDamage[2])
							local Dano,DanoColete,DanoCapacete = CalcularDano(DanoBase, TotalDistTraveled, VitimaHuman, "Head")
							ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Head",Settings.BulletPenetration)
						elseif Hit.Name == "Torso" or Hit.Parent.Name == "Chest" or Hit.Parent.Name == "Waist" then
							local DanoBase = math.random(Settings.TorsoDamage[1], Settings.TorsoDamage[2])
							local Dano,DanoColete,DanoCapacete = CalcularDano(DanoBase, TotalDistTraveled, VitimaHuman, "Body")
							ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Torso",Settings.BulletPenetration)
						elseif Hit.Name == "Stomach" or Hit.Parent.Name == "Stomach" then
							local DanoBase = math.random(Settings.TorsoDamage[1], Settings.TorsoDamage[2])
							local Dano,DanoColete,DanoCapacete = CalcularDano(DanoBase, TotalDistTraveled, VitimaHuman, "Body")
							bloodlmao(Hit, Pos, Norm, otherbloods[math.random(1,#otherbloods)])
							ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Stomach",Settings.BulletPenetration)
						else
							local DanoBase = math.random(Settings.TorsoDamage[1], Settings.TorsoDamage[2])
							local Dano,DanoColete,DanoCapacete = CalcularDano(DanoBase, TotalDistTraveled, VitimaHuman, "Body")
							if Hit.Name == "Left Arm" then
								ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Left Arm",Settings.BulletPenetration)
							elseif Hit.Name == "Right Arm" then
								ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Right Arm",Settings.BulletPenetration)
							elseif Hit.Name == "Left Leg" then
								ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Left Leg",Settings.BulletPenetration)
							elseif Hit.Name == "Right Leg" then
								ReplicateClient.DamageClient:Fire(true,VitimaHuman,Dano,DanoColete,DanoCapacete,"Right Leg",Settings.BulletPenetration)
							end
						end		
					end
				end


			end
		else
			if Hit.Name == "Head" or Hit.Parent.Name == "Top" or Hit.Parent.Name == "Headset" or Hit.Parent.Name == "Olho" or Hit.Parent.Name == "Face" or Hit.Parent.Name == "Numero"  or (Hit.Parent:IsA('Accessory') or Hit.Parent:IsA('Hat')) or Hit.Name == "Torso" or Hit.Name == "Stomach" or Hit.Parent.Name == "Chest" or Hit.Parent.Name == "Vest" or Hit.Parent.Name == "Waist" or Hit.Name == "Right Arm" or Hit.Name == "Left Arm" or Hit.Name == "Right Leg" or Hit.Name == "Left Leg" or Hit.Parent.Name == "Back" or Hit.Parent.Name == "Leg1" or Hit.Parent.Name == "Leg2" or Hit.Parent.Name == "Arm1" or Hit.Parent.Name == "Arm2" then
				Evt.Treino:FireServer(VitimaHuman)
			end
		end
	elseif Hit.Name == "Visor" and not VisorHitCooldown then
		VisorHitCooldown = true

		local hitplr = game.Players:GetPlayerFromCharacter(Hit.Parent.Parent.Parent)
		local durb = Hit:FindFirstChild("Durability")

		Engine.Eventos.Armor.ChangeVisorDurb:FireServer(durb, hitplr)
		task.wait(0.01)
		VisorHitCooldown = false
	end
end

Human.Running:connect(function(walkin)
	if Equipped then
		SpeedPrecision = walkin
		Sprint()
		if walkin > 1 then
			Walking = true
		else
			Walking = false
		end
	end
end)


Mouse.KeyDown:connect(function(Key)
	if Equipped then
		if Key == "w" then
			if not w then
				w = true
			end
		end
		if Key == "a" then
			if not a then
				a = true
			end
		end
		if Key == "s" then
			if not s then
				s = true
			end
		end
		if Key == "d" then
			if not d then
				d = true
			end
		end
	end
end)

Mouse.KeyUp:connect(function(Key)
	if Equipped then
		if Key == "w" then
			if w then
				w = false
			end
		end
		if Key == "a" then
			if a then
				a = false
			end
		end
		if Key == "s" then
			if s then
				s = false
			end
		end
		if Key == "d" then
			if d then
				d = false
			end
		end
	end
end)



function SlideEx()
	if ArmaClone:WaitForChild("Slide"):FindFirstChild("NoMove") == nil then
		tweenJoint(ArmaClone.Handle:WaitForChild("Slide"),  CFrame.new(Settings.SlideExtend) * CFrame.Angles(0,math.rad(0),0) , nil, function(X) return math.sin(math.rad(X)) end, 1 * (FireRate/2))
	end
	if Settings.MoveBolt == true then
		tweenJoint(ArmaClone.Handle:WaitForChild("Bolt"),  CFrame.new(Settings.BoltExtend) * CFrame.Angles(0,math.rad(0),0) , nil, function(X) return math.sin(math.rad(X)) end, 1 * (FireRate/2))
	end
	delay(FireRate/2,function()
		if Ammo.Value >= 1 then
			tweenJoint(ArmaClone.Handle:WaitForChild("Slide"),  CFrame.new(0,0,0) * CFrame.Angles(0,math.rad(0),0) , nil, function(X) return math.sin(math.rad(X)) end, 1 * (FireRate/2))
			if Settings.MoveBolt == true then
				tweenJoint(ArmaClone.Handle:WaitForChild("Bolt"),  CFrame.new(0,0,0) * CFrame.Angles(0,math.rad(0),0) , nil, function(X) return math.sin(math.rad(X)) end, 1 * (FireRate/2))
			end
		elseif Ammo.Value < 1 and Settings.SlideLock == true then
			Chambered.Value = false
			if Settings.MoveBolt == true and Settings.BoltLock == false then
				tweenJoint(ArmaClone.Handle:WaitForChild("Bolt"),  CFrame.new(0,0,0) * CFrame.Angles(0,math.rad(0),0) , nil, function(X) return math.sin(math.rad(X)) end, 1 * (FireRate/2))
			end
			Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Click'):Play()	
			slideback = true
		elseif Ammo.Value < 1 and Settings.SlideLock == false then
			tweenJoint(ArmaClone.Handle:WaitForChild("Slide"),  CFrame.new(0,0,0) * CFrame.Angles(0,math.rad(0),0) , nil, function(X) return math.sin(math.rad(X)) end, 1 * (FireRate/2))
			if Settings.MoveBolt == true then
				tweenJoint(ArmaClone.Handle:WaitForChild("Bolt"),  CFrame.new(0,0,0) * CFrame.Angles(0,math.rad(0),0) , nil, function(X) return math.sin(math.rad(X)) end, 1 * (FireRate/2))
			end
			Chambered.Value = false
			Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Click'):Play()
		end
	end)
end
extrarecoil = false
viewFlash = 1

cameraShaker = require(game.ReplicatedStorage.CameraShaker)
shakeFrame = CFrame.new()

camShake = cameraShaker.new(Enum.RenderPriority.Camera.Value, function(shakeCFrame)
	Camera.CFrame = Camera.CFrame * shakeCFrame
	shakeFrame = shakeCFrame
end) -- missing was here

-- buns ketchup pickle cheese put that patty in between its BURGER

function renderCam()			
	Camera.CFrame = Camera.CFrame*CFrame.Angles(cameraspring.p.x*0.5,cameraspring.p.y*0.5,cameraspring.p.z*0.4)
	-- WHAT WHAT?
end

-- its burger

function renderGunRecoil()			
	--recoilcf = recoilcf*CFrame.Angles(RecoilSpring.p.x,RecoilSpring.p.y,RecoilSpring.p.z)
	Recoil = Recoil*CFrame.Angles(RecoilSpring.p.x*0.4,RecoilSpring.p.y*0.4,RecoilSpring.p.z *0.6)

	-- WHAT WHAT

	--Recoil = Recoil * CFrame.new(0,0,GunKickRecoil.position * 0.065) * CFrame.Angles(GunPreUp.position * 0.01,GunPreSide.position * 0.01,0)
end

function RecoilMain()


	local vr = (math.random(Settings.VRecoil[1], Settings.VRecoil[2])/2*Settings.MaxRecoilPower) * ModTable.camRecoilMod.RecoilUp
	local lr = (math.random(Settings.HRecoil[1], Settings.HRecoil[2])*Settings.MaxRecoilPower) * ModTable.camRecoilMod.RecoilLeft
	local rr = (math.random(Settings.HRecoil[1], Settings.HRecoil[2])*Settings.MaxRecoilPower) * ModTable.camRecoilMod.RecoilRight
	local hr = (math.random(-rr, lr)/4)
	local tr = (math.random(Settings.VRecoil[1], Settings.VRecoil[2])/2*Settings.MaxRecoilPower) * ModTable.camRecoilMod.RecoilTilt

	local RecoilX = math.rad(vr * RAND( 1, 1, .1))
	local RecoilY = math.rad(hr * RAND(-1, 1, .1))
	local RecoilZ = math.rad(tr * RAND(-1, 1, .1))

	local gvr = (math.random(Settings.VRecoil[1], Settings.VRecoil[2])/1) * ModTable.gunRecoilMod.RecoilUp
	local gdr = (math.random(Settings.VRecoil[1], Settings.VRecoil[2])/3) * ModTable.gunRecoilMod.RecoilTilt * math.random(-1,1)
	local glr = (math.random(Settings.HRecoil[1], Settings.HRecoil[2])/2) * ModTable.gunRecoilMod.RecoilLeft
	local grr = (math.random(Settings.HRecoil[1], Settings.HRecoil[2])/2) * ModTable.gunRecoilMod.RecoilRight

	local ghr = (math.random((grr*-1), glr))--*1.75	

	local ARR = Settings.AimRecoilReduction * ModTable.AimRM

	local rand = math.random(-100,100)/100
	CameraRecoil.position = 0.2
	GunKickRecoil.velocity = 30       --originaly 30
	GunKickRecoil.position = 0
	GunPreUp.velocity = 1 * vr
	GunPreUp.position = 0.2
	GunPreSide.velocity = 1 * rand * lr
	GunPreSide.position = 0.2 * rand

	if Bipod then
		cameraspring:accelerate(Vector3.new( RecoilX/5, RecoilY/2, 0 ))

		if not Aiming then
			RecoilSpring:accelerate(Vector3.new( math.rad(.25 * gvr * RecoilPower), math.rad(.25 * ghr * RecoilPower), math.rad(.25 * gdr)))
			--Recoil = Recoil * CFrame.new(0,0,.1) * CFrame.Angles( math.rad(.25 * gvr * RecoilPower ),math.rad(.25 * ghr * RecoilPower ),math.rad(.25 * gdr * RecoilPower ))

		else
			RecoilSpring:accelerate(Vector3.new( math.rad( .25 * gvr * RecoilPower/ARR) , math.rad(.25 * ghr * RecoilPower/ARR), math.rad(.25 * gdr/ ARR)))
			--Recoil = Recoil * CFrame.new(0,0,.1) * CFrame.Angles( math.rad(.25 * gvr * RecoilPower/ARR ),math.rad(.25 * ghr * RecoilPower/ARR ),math.rad(.25 * gdr * RecoilPower/ARR ))
		end

		local vr  = (VRecoil)/100	
		local hr = ((HRecoil) * math.random(5, 10))/1

		--Camera.CFrame = Camera.CFrame * CFrame.Angles(vr, 0, 0)
		--Camera.CFrame = Camera.CFrame*CFrame.Angles(cameraspring.p.x,cameraspring.p.y,cameraspring.p.z)
		local vP
		if Settings.GunType == 0 then
			vP = (VPunchBase)
		else
			vP = (VPunchBase*10)/100
		end
		local hP = (math.random(-HPunchBase*55, HPunchBase*55))/100
		local dP = ((DPunchBase) * math.random(-0.07, 0))
		local add
		if not Aiming then
			Recoil = Recoil:lerp(Recoil*CFrame.new(0,.015,.15 + GunKickRecoil.position/6) * CFrame.Angles(0,0,RAD(dP*RecoilPower*-0.75) + GunPreSide.position/2),1)
			add = Vector3.new(RAD(vP*RecoilPower*1.5),RAD(hP*RecoilPower),RAD(dP*RecoilPower))
			--Recoil = Recoil:lerp(Recoil*CFrame.new(0,0,(Settings.RecoilPunch)) * CFrame.Angles(RAD(vP*RecoilPower),RAD(hP*RecoilPower),RAD(dP*RecoilPower)),0.2)
			--Recoil = Recoil:lerp(CFrame*CFrame.Angles(math.random(-3,3)/360,math.random(-3,3)/360,math.random(-3,3)/360))
		else
			Recoil = Recoil:lerp(Recoil*CFrame.new(0,.015,.15 + GunKickRecoil.position/6) * CFrame.Angles(0,0,RAD(dP*RecoilPower*-0.75) + GunPreSide.position/2),1)
			add = Vector3.new(RAD(vP*RecoilPower*1.5/Settings.AimRecoilReduction),RAD(hP*RecoilPower/Settings.AimRecoilReduction),RAD(dP*RecoilPower/Settings.AimRecoilReduction))
			--Recoil = Recoil:lerp(Recoil*CFrame.new(0,0,(Settings.RecoilPunch)) * CFrame.Angles(RAD(vP*RecoilPower/Settings.AimRecoilReduction),RAD(hP*RecoilPower/Settings.AimRecoilReduction),RAD(dP*RecoilPower/Settings.AimRecoilReduction)),0.3)
			--Recoil = Recoil:lerp(CFrame*CFrame.Angles(math.random(-3,3)/360,math.random(-3,3)/360,math.random(-3,3)/360))
		end

		funnyrecoil.t = funnyrecoil.t + add       

		task.delay(0.05, function()

			funnyrecoil.t  = funnyrecoil.t - add 
			cameraspring:accelerate(Vector3.new(-RecoilX, -RecoilY/2, 0))
		end)

	else
		local mult = math.random(-10,15)/10

		local vP
		if Settings.GunType == 0 then
			vP = (VPunchBase)
		else
			vP = (math.random(-VPunchBase*-40,VPunchBase*100))/100
		end
		local hP = (math.random((-HPunchBase)*-40, (HPunchBase)*100))/100*(mult)
		local dP = ((DPunchBase) * math.random(-1, 1))
			--[[if not Aiming then
				Recoil = Recoil:lerp(Recoil*CFrame.new(-0.03,-0.03,(Settings.RecoilPunch)) * CFrame.Angles(RAD(vP*RecoilPower),RAD(hP*RecoilPower),RAD(dP*RecoilPower)),1)
			else
				--Recoil = Recoil:lerp(Recoil*CFrame.new(-0,0,(Settings.RecoilPunch/5)) * CFrame.Angles(RAD(vP*RecoilPower/Settings.AimRecoilReduction),RAD(hP*RecoilPower/Settings.AimRecoilReduction),RAD(dP*RecoilPower/Settings.AimRecoilReduction)),1)
				Recoil = Recoil:lerp(Recoil*CFrame.new(-0.03,-0.03,(Settings.RecoilPunch)) * CFrame.Angles(RAD(vP*RecoilPower),RAD(hP*RecoilPower),RAD(dP*RecoilPower)),1)
			end]]--


		local add
		--[[if not Aiming then
			Recoil = Recoil:lerp(Recoil*CFrame.new(0,0,.12 + GunKickRecoil.position/4),.5)
			add = Vector3.new(RAD(vP*RecoilPower*1.5/Settings.AimRecoilReduction),RAD(hP*RecoilPower/Settings.AimRecoilReduction),RAD(dP*RecoilPower/Settings.AimRecoilReduction))
			--Recoil = Recoil:lerp(Recoil*CFrame.new(0,0,(Settings.RecoilPunch)) * CFrame.Angles(RAD(vP*RecoilPower),RAD(hP*RecoilPower),RAD(dP*RecoilPower)),0.2)
			--Recoil = Recoil:lerp(CFrame*CFrame.Angles(math.random(-3,3)/360,math.random(-3,3)/360,math.random(-3,3)/360))
		else
			Recoil = Recoil:lerp(Recoil*CFrame.new(0,0,.12 + GunKickRecoil.position/4),.5)
			add = Vector3.new(RAD(vP*RecoilPower*1.5/Settings.AimRecoilReduction),RAD(hP*RecoilPower/Settings.AimRecoilReduction),RAD(dP*RecoilPower/Settings.AimRecoilReduction))
			--Recoil = Recoil:lerp(Recoil*CFrame.new(0,0,(Settings.RecoilPunch)) * CFrame.Angles(RAD(vP*RecoilPower/Settings.AimRecoilReduction),RAD(hP*RecoilPower/Settings.AimRecoilReduction),RAD(dP*RecoilPower/Settings.AimRecoilReduction)),0.3)
			--Recoil = Recoil:lerp(CFrame*CFrame.Angles(math.random(-3,3)/360,math.random(-3,3)/360,math.random(-3,3)/360))
		end]]--

		--Recoil = Recoil:lerp(Recoil*CFrame.new(0,0,0.8 + GunKickRecoil.position / 4),.125)
		add = Vector3.new(RAD(vP*RecoilPower*1.5/Settings.AimRecoilReduction),RAD(hP*RecoilPower/Settings.AimRecoilReduction),RAD(dP*RecoilPower/Settings.AimRecoilReduction))

		funnyrecoil.t = funnyrecoil.t + add       

		if not Aiming then
			cameraspring:accelerate(Vector3.new(math.rad(gvr * (Settings.MaxRecoilPower) + GunKickRecoil.position), math.rad(ghr * (Settings.MaxRecoilPower / 1.75) + GunPreSide.position/3 ), math.rad(gdr / 4) + GunPreSide.position / 6 ))

			RecoilSpring:accelerate(Vector3.new( math.rad(gvr * (Settings.MaxRecoilPower / 1.75) + GunKickRecoil.position/4 / 4), math.rad(ghr * (Settings.MaxRecoilPower / 1.75) + GunPreSide.position/3 ), math.rad(gdr / 4) + GunPreSide.position / 4 ))
			--Recoil = Recoil * CFrame.Angles( math.rad( gvr * RecoilPower + (GunPreUp.position / 4) ),math.rad( ghr * RecoilPower ),math.rad( gdr * RecoilPower + (GunPreUp.position / 4) ))
			Recoil = Recoil:lerp(Recoil*CFrame.new(0,-.07,0.4),.1)
		else
			cameraspring:accelerate(Vector3.new(math.rad(gvr * (Settings.MaxRecoilPower / 1) + GunKickRecoil.position/2 / 1), math.rad(ghr * (Settings.MaxRecoilPower / 1.75) + GunPreSide.position/3 ), math.rad(gdr / 4) + GunPreSide.position / 6 ))

			RecoilSpring:accelerate(Vector3.new( math.rad(gvr * (Settings.MaxRecoilPower / 1.75) + GunKickRecoil.position/4 /4) , math.rad(ghr * (Settings.MaxRecoilPower / 1.75) + GunPreSide.position/3), math.rad(gdr/ 4) + GunPreSide.position / 6 ))
			--Recoil = Recoil * CFrame.Angles( math.rad( gvr * RecoilPower/ARR ),math.rad( ghr * RecoilPower/ARR ),math.rad( gdr * RecoilPower/ARR ))
			Recoil = Recoil:lerp(Recoil*CFrame.new(0,-.07,0.4),.1)
		end

		task.delay(0.03, function()

			funnyrecoil.t  = funnyrecoil.t - add 
			--cameraspring:accelerate(Vector3.new(math.rad(-gvr * (Settings.MaxRecoilPower) + GunKickRecoil.position/6), math.rad(-ghr * (Settings.MaxRecoilPower / 4) + GunPreSide.position/3 ), math.rad(-gdr / 4) + GunPreSide.position / 9 ))

			RecoilSpring:accelerate(Vector3.new( math.rad(-gvr * (Settings.MaxRecoilPower / 1.75) + GunKickRecoil.position/6 / 6), math.rad(-ghr * (Settings.MaxRecoilPower / 2.25) + GunPreSide.position/4 ), math.rad(-gdr / 4) - GunPreSide.position / 2 ))

		end)

		--Recoil = funnyrecoil
		--Recoil = Recoil:lerp(Recoil*CFrame.new(0,(Settings.VRecoil[2]+Settings.HRecoil[2] > 16 and -(Settings.RecoilPunch/2) or 0),(Settings.RecoilPunch)) * CFrame.Angles(RAD(vP*RecoilPower),RAD((hP*RecoilPower)*1.25),RAD(dP*RecoilPower)),1)
	end
end

function recoil() --- liqldify/v_suzuki
	local raytop = Ray.new(rootpart.Position,Vector3.new(0,150,0))
	local hit,position = workspace:FindPartOnRayWithIgnoreList(raytop,{character,otherplayercharacter,camera})
	if Firing then
		RecoilMain()
	--[[spawn(function()
	
		if Bipod then
			local vr  = (VRecoil)/100	
			local hr = ((HRecoil) * math.random(5, 10))/1

			Camera.CFrame = Camera.CFrame * CFrame.Angles(vr, 0, 0)
			local c = -vr/30
			local cx = -(hr)/30
			local curId
			local EquipId = curId
			local vP
			if Settings.GunType == 0 then
				vP = (VPunchBase)
			else
				vP = (VPunchBase*10)/100
			end
			local hP = (math.random(-HPunchBase*55, HPunchBase*55))/100
			local dP = ((DPunchBase) * math.random(-0.07, 0))
			if not Aiming then
				Recoil = Recoil:lerp(Recoil*CFrame.new(0,.015,0) * CFrame.Angles(0,0,RAD(dP*RecoilPower*-0.75)),1)
			else
				Recoil = Recoil:lerp(Recoil*CFrame.new(0,.015,0) * CFrame.Angles(0,0,RAD(dP*RecoilPower*-0.75)),1)
			end
		else
			local mult = math.random(-10,15)/10
			--print(mult)
			local vr  = (VRecoil)	
			local hr = (HRecoil) * math.random(-5, 5)
			math.random((hr*-1),(hr))
			local tStep = Settings.tStep
			--Camera.CFrame = Camera.CFrame * CFrame.Angles((vr * -0.65), (hr * 0.45), (vr * 0.65))
			
			local c = -vr/30
			local cx = -(hr)/30*(mult)
			local curId
			local EquipId = curId
			local vP
			if Settings.GunType == 0 then
				vP = (VPunchBase)
			else
				vP = (math.random(-VPunchBase*-40,VPunchBase*100))/100
			end
			local hP = (math.random((-HPunchBase)*-40, (HPunchBase)*100))/100*(mult)
			local dP = ((DPunchBase) * math.random(-1, 1))
				Recoil = Recoil:lerp(Recoil*CFrame.new(0,-(Settings.RecoilPunch/2),(Settings.RecoilPunch)) * CFrame.Angles(RAD(vP*RecoilPower),RAD((hP*RecoilPower)*1.25),RAD(dP*RecoilPower)),1)
			
			--ts(Camera,TweenInfo.new(0),{CFrame = Camera.CFrame * CFrame.Angles((vr*0.25), (hr*0.15), (vr*0.25))}):Play()
			--Camera.CFrame = Camera.CFrame * CFrame.Angles((vr * 0.25), (hr * 0.15), (vr * 0.25))
			for i = 1, 3 do
				if EquipId == curId then
					Camera.CFrame = Camera.CFrame * CFrame.Angles((vr*0.25), (hr*0.15), (vr*0.25))
					wait()
				else
					break
				end
			end
			delay(3/10,function()
			for i = 1, 30*Settings.AimRecover do
				if EquipId == curId then
					Camera.CoordinateFrame = CFrame.new(Camera.Focus.p) * (Camera.CoordinateFrame - Camera.CoordinateFrame.p) * CFrame.Angles(c,  cx, 0) * CFrame.new(0, 0, (Camera.Focus.p - Camera.CoordinateFrame.p).magnitude)
					wait()
				else
					break
				end
				end
		end)
		end
	end)]]--
		local rate = math.random(1,100)
		fire = math.random(1,4)
		--local pitch = math.random(90,110)/100
		for _, v in pairs(ArmaClone.SmokePart:GetChildren()) do
			if ((v.Name:sub(1, 7) == "FlashFX" or v.Name:find("Smoke")) and not v:IsA("Motor6D")) and not v:IsA("Beam") --[[and viewFlash >= 3]] then
				if v:GetAttribute("EmitCount") and v.Rate > 0 then
					v:Emit(v:GetAttribute("EmitCount"))
				else
					v.Enabled = true
				end
				if v.Name == "Fire["..fire.."]" then
					v.Enabled = true
				end
				viewFlash = 1
			elseif ((v.Name:sub(1, 7) == "FlashFX" or v.Name:find("Smoke")) and not v:IsA("Motor6D")) and (v:IsA("Beam")) --[[and viewFlash >= 3]] then
				v.Enabled = true
			elseif viewFlash < 3 then
				viewFlash = viewFlash + 1
			end
			if v.Name == "Fire["..fire.."]" then
				v.Enabled = true
			end

			if (v:IsA("PointLight") or v:IsA("SpotLight")) and not Silencer.Value then
				v.Brightness = 0
				ts(v,TweenInfo.new(0.07,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,true,0),{Brightness = 5}):Play()
				task.delay(0.15,function()
					v.Enabled = false
				end)
			end
		end
		for _, a in pairs(ArmaClone.Chamber:GetChildren()) do
			if a.Name:sub(1, 7) == "FlashFX" or a.Name:sub(1, 7) == "Smoke" then
				a.Enabled = true
			end
		end

		task.delay(0.05, function()

			for _, v in pairs(ArmaClone.SmokePart:GetChildren()) do
				if not v:IsA("PointLight") and not v:IsA("SpotLight") then
					if (v.Name:sub(1, 7) == "FlashFX" or v.Name:find("Smoke")) and not v:IsA("Motor6D") and (not v:GetAttribute("EmitCount") or v.Rate <= 0) then
						v.Enabled = false
					end
					if v.Name:find('Fire') then
						v.Enabled = false
					end
				end
			end

			for _, a in pairs(ArmaClone.Chamber:GetChildren()) do
				if a.Name:sub(1, 7) == "FlashFX" or a.Name:sub(1, 7) == "Smoke" then
					a.Enabled = false
				end
			end

		end)
	end
	
	-- im so sorry this code is the way it is. im not touching it, please someone else fix it for the love of god
	
	if Silencer.Value == true then
		
		if Ammo.Value <  math.floor((Settings.Ammo)*.25) then
			if not Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('AutoS') and Firing then
				if hit and (hit.Transparency == 0 and hit.Material ~= Enum.Material.Grass and hit.Material ~= Enum.Material.Sand and hit.Parent.Name ~= "Treepack" or hit.Name == "IndoorPart") and Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('IndoorS') then
					Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IndoorS'):Play()
					Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Click'):Play()
				else

					Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Supressor'):Play()
					Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Click'):Play()
				end
			end
			--local ok = Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Supressor').PlaybackSpeed
			--delay(FireRate,function()
			if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('AutoS') then
				if Equipped and MouseHeld and Firing and Chambered.Value == true and --[[Ammo.Value > 0 and]] not Reloading and Emperrado.Value == false and Character.Humanoid.Health > 0 then
					if hit and (hit.Transparency == 0 and hit.Material ~= Enum.Material.Grass and hit.Material ~= Enum.Material.Sand and hit.Parent.Name ~= "Treepack" or hit.Name == "IndoorPart") and Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('IndoorAutoS') then
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('AutoS'):Stop()
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IndoorAutoS').Playing = true
					else
						if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('IndoorAutoS') then
							Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IndoorAutoS'):Stop()
						end
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('AutoS').Playing = true
					end
					Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Supressor').Playing = false
					Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Supressor').PlaybackSpeed = 0
					if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('IndoorS') then
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IndoorS').Playing = false
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IndoorS').PlaybackSpeed = 0
					end
					--end
				else

					--if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('Auto') then
					Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Supressor').PlaybackSpeed = 1
					if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('IndoorS') then
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IndoorS').PlaybackSpeed = 1
					end
					if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('AutoS').Playing == true or Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('IndoorAutoS') and Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IndoorAutoS').Playing == true then
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('AutoS'):Stop()
						--Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('AutoEcho'):Stop()
						if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('TailS') then
							if hit and (hit.Transparency == 0 and hit.Material ~= Enum.Material.Grass and hit.Material ~= Enum.Material.Sand and hit.Parent.Name ~= "Treepack" or hit.Name == "IndoorPart") and Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('IndoorTailS') then
								Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IndoorTailS'):Play()
							else
								Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('TailS'):Play()
							end
						end
						--Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('TailEcho'):Play()
						--end
					end
					if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('IndoorAutoS') then
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IndoorAutoS'):Stop()
					end
				end
			end
			--end)
		else
			if not Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('AutoS') and Firing then
				if hit and (hit.Transparency == 0 and hit.Material ~= Enum.Material.Grass and hit.Material ~= Enum.Material.Sand and hit.Parent.Name ~= "Treepack" or hit.Name == "IndoorPart") and Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('IndoorS') then
					Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IndoorS'):Play()
				else
					if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('Supressor') then
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Supressor'):Play()
					end
				end
			end
			if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('AutoS') then
				if Equipped and MouseHeld and Firing and Chambered.Value == true and --[[Ammo.Value > 0 and]] not Reloading and Emperrado.Value == false and Character.Humanoid.Health > 0 then
					if hit and (hit.Transparency == 0 and hit.Material ~= Enum.Material.Grass and hit.Material ~= Enum.Material.Sand and hit.Parent.Name ~= "Treepack" or hit.Name == "IndoorPart") and Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('IndoorAutoS') then
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('AutoS'):Stop()
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IndoorAutoS').Playing = true
					else
						if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('IndoorAutoS') then
							Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IndoorAutoS'):Stop()
						end
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('AutoS').Playing = true
					end
					if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('Supressor') then
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Supressor').Playing = false
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Supressor').PlaybackSpeed = 0
					end
					if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('IndoorS') then
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IndoorS').Playing = false
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IndoorS').PlaybackSpeed = 0
					end
					--end
				else

					--if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('Auto') then
					if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('Supressor') then
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Supressor').PlaybackSpeed = 1
					end
					if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('IndoorS') then
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IndoorS').PlaybackSpeed = 1
					end
					if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('AutoS').Playing == true or Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('IndoorAutoS') and Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IndoorAutoS').Playing == true then
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('AutoS'):Stop()
						--Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('AutoEcho'):Stop()
						if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('TailS') then
							if hit and (hit.Transparency == 0 and hit.Material ~= Enum.Material.Grass and hit.Material ~= Enum.Material.Sand and hit.Parent.Name ~= "Treepack" or hit.Name == "IndoorPart") and Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('IndoorTail') then
								Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IndoorTailS'):Play()
							else
								Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('TailS'):Play()
							end
						end
						--Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('TailEcho'):Play()
						--end
					end
					if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('IndoorAutoS') then
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IndoorAutoS'):Stop()
					end
				end
			end
			--end)
		end
	else
		if Ammo.Value <  math.floor((Settings.Ammo)*.25) then
			if not Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('Auto') and Firing then
				if hit and (hit.Transparency == 0 and hit.Material ~= Enum.Material.Grass and hit.Material ~= Enum.Material.Sand and hit.Parent.Name ~= "Treepack" or hit.Name == "IndoorPart") and Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('Indoor') then
					Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Indoor'):Play()
					Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IEcho'):Play()
					Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Click'):Play()
				else
					if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('Fire') and Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('Echo') then
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Fire'):Play()
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Click'):Play()
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Echo'):Play()
						local yea = Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Fire').PlaybackSpeed
						local yea2 = Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Echo').PlaybackSpeed
					end
				end
			end
			--delay(FireRate,function()
			if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('Auto') then
				if Equipped and MouseHeld and Firing and Chambered.Value == true and --[[Ammo.Value > 0 and]] not Reloading and Emperrado.Value == false and Equipped and MouseHeld --[[and (Ammo.Value - 1) > 0]] and Character.Humanoid.Health > 0 then
					--if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('Auto') then
					if hit and (hit.Transparency == 0 and hit.Material ~= Enum.Material.Grass and hit.Material ~= Enum.Material.Sand and hit.Parent.Name ~= "Treepack" or hit.Name == "IndoorPart") and Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('IndoorAuto') then
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Auto'):Stop()
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('AutoEcho'):Stop()
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IndoorAuto').Playing = true
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IndoorAutoEcho').Playing = true
					else
						if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('IndoorAuto') then
							Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IndoorAuto'):Stop()
							Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IndoorAutoEcho'):Stop()
						end
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Auto').Playing = true
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('AutoEcho').Playing = true
					end
					if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('Fire') and Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('Echo') then
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Fire').Playing = false
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Fire').PlaybackSpeed = 0
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Echo').Playing = false
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Echo').PlaybackSpeed = 0
					end
					if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('Indoor') then
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Indoor').Playing = false
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Indoor').PlaybackSpeed = 0
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IEcho').Playing = false
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IEcho').PlaybackSpeed = 0
					end
					--end
				else

					--if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('Auto') then
					if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('Fire') and Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('Echo') then
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Fire').PlaybackSpeed = 1
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Echo').PlaybackSpeed = 1
					end
					if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('Indoor') then
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Indoor').PlaybackSpeed = 1
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IEcho').PlaybackSpeed = 1
					end
					if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Auto').Playing == true or Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('IndoorAuto') and Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IndoorAuto').Playing == true then
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Auto'):Stop()
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('AutoEcho'):Stop()
						if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('IndoorAuto') then
							Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IndoorAuto'):Stop()
							Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IndoorAutoEcho'):Stop()
						end
						if hit and (hit.Transparency == 0 and hit.Material ~= Enum.Material.Grass and hit.Material ~= Enum.Material.Sand and hit.Parent.Name ~= "Treepack" or hit.Name == "IndoorPart") and Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('IndoorTail') then
							Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IndoorTail'):Play()
							Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IndoorTailEcho'):Play()
						else
							Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Tail'):Play()
							Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('TailEcho'):Play()
						end
						if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('Indoor') then
							Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IEcho').Playing = false
							Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Indoor').Playing = false
						end
						if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('Fire') and Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('Echo') then
							Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Echo').Playing = false
							Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Fire').Playing = false
						end
						--end
					end
				end
			end
			--end)
		else
			if not Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('Auto') and Firing then
				if hit and (hit.Transparency == 0 and hit.Material ~= Enum.Material.Grass and hit.Material ~= Enum.Material.Sand and hit.Parent.Name ~= "Treepack" or hit.Name == "IndoorPart") and Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('Indoor') then
					Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Indoor'):Play()
					Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IEcho'):Play()
				else
					if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('Fire') and Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('Echo') then
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Fire'):Play()
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Echo'):Play()
					end
				end
			end
			--delay(FireRate,function()
			if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('Auto') then
				if Equipped and MouseHeld and Firing and Chambered.Value == true and --[[Ammo.Value > 0 and]] not Reloading and Emperrado.Value == false and Character.Humanoid.Health > 0 then
					--if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('Auto') then
					if hit and (hit.Transparency == 0 and hit.Material ~= Enum.Material.Grass and hit.Material ~= Enum.Material.Sand and hit.Parent.Name ~= "Treepack" or hit.Name == "IndoorPart") and Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('IndoorAuto') then
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Auto'):Stop()
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('AutoEcho'):Stop()
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IndoorAuto').Playing = true
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IndoorAutoEcho').Playing = true
					else
						if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('IndoorAuto') then
							Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IndoorAuto'):Stop()
							Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IndoorAutoEcho'):Stop()
						end
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Auto').Playing = true
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('AutoEcho').Playing = true
					end

					if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('Fire') and Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('Echo') then
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Fire').Playing = false
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Fire').PlaybackSpeed = 0
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Echo').Playing = false
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Echo').PlaybackSpeed = 0
					end

					if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('Indoor') then
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Indoor').Playing = false
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Indoor').PlaybackSpeed = 0
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IEcho').Playing = false
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IEcho').PlaybackSpeed = 0
					end
					--end
				else

					--if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('Auto') then
					if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('Fire') and Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('Echo') then
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Fire').PlaybackSpeed = 1
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Echo').PlaybackSpeed = 1
					end
					if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('Indoor') then
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Indoor').PlaybackSpeed = 1
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IEcho').PlaybackSpeed = 1
					end
					if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Auto').Playing == true or Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('IndoorAuto') and Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IndoorAuto').Playing == true then
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Auto'):Stop()
						Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('AutoEcho'):Stop()
						if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('IndoorAuto') then
							Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IndoorAuto'):Stop()
							Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IndoorAutoEcho'):Stop()
						end
						if hit and (hit.Transparency == 0 and hit.Material ~= Enum.Material.Grass and hit.Material ~= Enum.Material.Sand and hit.Parent.Name ~= "Treepack" or hit.Name == "IndoorPart") and Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('IndoorTail') then
							Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IndoorTail'):Play()
							Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IndoorTailEcho'):Play()
						else
							Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Tail'):Play()
							Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('TailEcho'):Play()
						end
						if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('Indoor') then
							Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('IEcho').Playing = false
							Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Indoor').Playing = false
						end
						if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('Fire') and Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('Echo') then
							Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Echo').Playing = false
							Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Fire').Playing = false
						end
						--end
					end
				end
			end
			--end)

		end
	end
	if Firing then
		SlideEx()
	end
end
local jam = 0

function Grenade()
	if not GRDebounce then
		GRDebounce = true
		GrenadeReady()

		repeat
			wait()
		until not CookGrenade
		TossGrenade()
	end
end

SKP_01 = Evt.AcessId:InvokeServer(Player.UserId)


function TossGrenade()
	if ArmaClient and Settings and GRDebounce == true then
		local SKP_02 = SKP_01.."-"..Player.UserId
		GrenadeThrow()
		if ArmaClient and Settings then
			Evt.Grenade:FireServer(ArmaClient,Settings,Camera.CFrame,Camera.CFrame.LookVector,Power,SKP_02)
			Unset()
		end
	end
end

function GrenadeMode()
	if Power >= 150 then
		Power = 100
		--StatusClone.GrenadeForce.Text = "Mid Throw"
	elseif Power >= 100 then
		Power = 50
		--StatusClone.GrenadeForce.Text = "Low Throw"
	elseif Power >= 50 then
		Power = 100
		--StatusClone.GrenadeForce.Text = "High Throw"
	end
end

function Emperrar()
	if Settings.CanBreak == true and Chambered.Value == true --[[and (Ammo.Value - 1) > 0]] then
		local Jam = math.random(Settings.JamChance)
		if Jam <= 2 then
			Emperrado.Value = true
			Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Click'):Play()
			jam = jam + 1
			if ArmaClone and ArmaClone:FindFirstChild("Shell") then
				shellclone = ArmaClone.Shell:Clone()
				shellclone.CFrame = ArmaClone.Chamber.CFrame
				shellclone.Transparency = 0
				shellclone.Name = "ShellClone"
				Ultil.Weld(shellclone, ArmaClone:WaitForChild("Handle"))
			end
			StatusClone.Jammed:Play()
			Firing = false
			StatusClone.WarningGlow.ImageColor3 = Color3.fromRGB(206, 19, 22)
			ts(StatusClone.WarningGlow,TweenInfo.new(0.15,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,3,true),{ImageTransparency = 0.1}):Play()
			NotificationMod.Notify(`Malfunction: "Misfire"`, 120734878931824, 137408246946660, 5)
			--[[if Equipped and not Reloading and stance > -2 and (Emperrado.Value == true or Ammo.Value <= 0 or Settings.FastReload == false) then
	MouseHeld = false
	Can_Shoot = false
	Reloading = true
	stance = 5
	Evt.Stance:FireServer(stance,Settings,Anims,ArmaClone)

	if Safe then
		Safe = false
		IdleAnim()
		Update_Gui()
		--wait(.25)
	end

	if not slideback then
		ChamberAnim()
	else
		ChamberBKAnim()
		ChamberAnim()
	end	
	Sprint()			
	Update_Gui()		
	Can_Shoot = true
				Reloading = false
				Emperrado.Value = false
			end]]--
		end
	end
end

YOffset = RootJoint.C0.Y
Asin = math.asin

function HalfStepFunc(Rot)
	if PlaceHolder and Character and Character:FindFirstChild("Torso") and HumanoidRootPart and HeadBase and Human then
		Offset = Human.CameraOffset
		local CameraDirection = HumanoidRootPart.CFrame:toObjectSpace(Camera.CFrame).lookVector
		local HeadCF = CFn(0, YOffset, 0) * CFa(-Asin(Character.Torso.CFrame.lookVector.Y), -Asin(CameraDirection.X/1.15), 0) * CFa(Asin(CameraDirection.Y), 0, 0)
		if Equipped and Player.Character ~= nil then
			--Evt.HeadRot:FireServer(Rot, Offset, Equipped)
			if Clone then
				local x, y, z = (Camera.CFrame:Inverse() * HeadBase.CFrame):ToEulerAnglesXYZ()
				Evt.HeadRot:FireServer(HeadCF,Clone.C0 * CFrame.Angles(x,y,z),Offset,Rot, Clone.C1)
			else
				Evt.HeadRot:FireServer(HeadCF)
			end
		end
	end
	PlaceHolder = not PlaceHolder
end

oldtick = tick()
xTilt = 0
yTilt = 0
lastPitch = 0
lastYaw = 0
local TVal = 0

local L_199_ = nil
Personagem.ChildAdded:connect(function(Tool)
	if Tool:IsA('Tool') and Tool:FindFirstChild('ACS_Modulo') and Tool.ACS_Modulo:FindFirstChild('ACS_Setup') and Humanoid.Health > 0 and not ToolEquip and require(Tool.ACS_Modulo.ACS_Setup).Type == 'Gun' then
		local L_370_ = true
		if Personagem:WaitForChild('Humanoid').Sit and Personagem.Humanoid.SeatPart:IsA("VehicleSeat") or Nadando then
			L_370_ = true;
		end

		if L_370_ then
			L_199_ = Tool
			if not Equipped then
				uis.MouseIconEnabled = false
				Player.CameraMode = Enum.CameraMode.LockFirstPerson
				Setup(Tool)
				LoadClientMods()

				Ray_Ignore = {Character, Ignore_Model, Camera, BulletModel}

				Gui = StatusClone:WaitForChild("GunHUD")
				Gui.Visible = true
				CanUpdateGui = true
				Update_Gui()
				pcall(EquipAnim)
				if ArmaClone:FindFirstChild("Mount") then
					ArmaClone:FindFirstChild("Mount").Value = true
				end
				if Settings.ZoomAnim and AimPartMode == 2 then
					ZoomAnim()
				end
				Sprint()
			elseif Equipped then
				Unset()
				Setup(L_199_)
				-- LoadClientMods()
			end;
		end;
	end
end)

Human.Seated:Connect(function(isSeated, seat)
	if isSeated then
		Jogador.CameraMaxZoomDistance = ServerConfig.VehicleMaxZoom
	else
		Jogador.CameraMaxZoomDistance = game.StarterPlayer.CameraMaxZoomDistance
	end
end)

Jogador.Backpack.ChildRemoved:connect(function(L_371_arg1)
	Evt.Holster:FireServer(L_371_arg1)
end)

Personagem.ChildRemoved:connect(function(L_371_arg1)
	if L_371_arg1 == ArmaClient then
		if Equipped then
			if Balinha then
				Balinha:Destroy()
			end
			Unset()
		end
	end
end)
local Waist = Neck
local YOffset = Waist.C0.Y
local WaistYOffset = Waist.C0.Y
local CFNew, CFAng = CFrame.new, CFrame.Angles
local Asin = math.asin
local T = 0.15
bruh = CFrame.new()
otherbob = CFrame.new()
RS.Heartbeat:connect(function()

	if Character.Humanoid.Health > 0 then
		local CameraDirection = HumanoidRootPart.CFrame:toObjectSpace(Camera.CFrame).lookVector
		--Character.Humanoid.Health = (Character:WaitForChild("Head"):WaitForChild("HP").Value + Character:WaitForChild("Torso"):WaitForChild("HP").Value + Character:WaitForChild("Left Arm"):WaitForChild("HP").Value + Character:WaitForChild("Right Arm"):WaitForChild("HP").Value + Character:WaitForChild("Left Leg"):WaitForChild("HP").Value + Character:WaitForChild("Right Leg"):WaitForChild("HP").Value)
		if Neck then
			if Character.Humanoid.RigType == Enum.HumanoidRigType.R6 and Character.Humanoid.Health > 0 and Character.Humanoid.PlatformStand == false then
				--Neck.C0 = CFNew(0, YOffset, 0) * CFAng(-Asin(Character.Torso.CFrame.lookVector.Y), -Asin(CameraDirection.X/1.15), 0) * CFAng(Asin(CameraDirection.Y), 0, 0)
				--Evt.HeadRot:FireServer(CFNew(0, YOffset, 0) * CFAng(-Asin(Character.Torso.CFrame.lookVector.Y), -Asin(CameraDirection.x/1.15), 0) * CFAng(Asin(CameraDirection.Y), 0, 0))
				HalfStepFunc(-math.asin(Camera.CoordinateFrame.lookVector.y))
			end
		end
	end
end)

RS.Heartbeat:Connect(function(UpdateNetwork)
	renderGunRecoil()
	renderCam()
end)

RS.RenderStepped:connect(function(Update)

	if Equipped and ArmaClone and ArmaClone:FindFirstChild('Handle') then
		HalfStepFunc(-math.asin(Camera.CoordinateFrame.lookVector.y))

		Recoil = Recoil:lerp(CFrame.new(),0.05)		

		RA.C0 = Recoil * CFrame.new(0,0,5)
		LA.C0 = Recoil * CFrame.new(0,0,5)
	end

	--StatusClone.freelook.Visible = _G.FreeLook
	--CurCamera.CFrame *= CFrame.Angles(0, 0, math.sin(tick() * 50) * CameraRecoil.position * 0.013)
	if not Equipped then
		HeadBase.CFrame =  Camera.CFrame * CFrame.new(0, 0, -0.5)
	elseif Equipped and ArmaClone and ArmaClone:FindFirstChild('Handle') then
		Update_Gui()
		--[[HalfStepFunc(-math.asin(Camera.CoordinateFrame.lookVector.y))

		Recoil = Recoil:lerp(CFrame.new(),Settings.PunchRecover)		

		RA.C0 = Recoil
		LA.C0 = Recoil]]--
		--[[ArmaClone:FindFirstChild("SmokePart") and (ArmaClone.Handle.Position-(ArmaClone.SmokePart.Position * 0.95)).Magnitude*1.5 or ]]--
		local GunSize = ArmaClone:FindFirstChild("SmokePart") and (ArmaClone.Handle.Position-ArmaClone.SmokePart.Position).Magnitude * 1.5

		--ArmaClone:GetExtentsSize().Z * 1.3

		--local Raio = Ray.new(ArmaClone.Handle.Position, Camera.CFrame.LookVector * Settings.GunSize)
		local Raio = Ray.new(ArmaClone.Handle.Position, Camera.CFrame.LookVector * (GunSize))
		local Hit, Pos = workspace:FindPartOnRayWithIgnoreList(Raio, Ray_Ignore, false, true)

		local lk = Camera.CoordinateFrame.lookVector
		local x = lk.X
		local rise = lk.Y
		local z = lk.Z

		local lookpitch, lookyaw = math.asin(rise), -math.atan(x / z)

		local pitchChange = lastPitch - lookpitch
		local yawChange = lastYaw - lookyaw
		pitchChange = pitchChange * ((math.abs(pitchChange) < 1) and 1 or 0)
		yawChange = yawChange * ((math.abs(yawChange) < 1) and 1 or 0)
		yTilt = (yTilt * 0.2 + pitchChange)
		xTilt = (xTilt * 0.2 + yawChange)

		lastPitch = lookpitch
		lastYaw = lookyaw

		sway.t = V3(xTilt, yTilt, TVal)
		local swayVec = sway.p
		local TWAY = swayVec.z
		local XSWY = swayVec.X*(Aiming and -2 or -3)
		local YSWY = swayVec.Y*(Aiming and -2 or -3)							

		local xWalk = SIN(t*2)*(SpeedPrecision/ServerConfig.RunWalkSpeed *(WVal+1))
		local yWalk = COS(t*4)*(SpeedPrecision/ServerConfig.RunWalkSpeed *(WVal+1))
		local xWak  = SIN(t*2)*(SpeedPrecision/ServerConfig.RunWalkSpeed *(WVal+1))
		local yWak  = COS(t*4)*(SpeedPrecision/ServerConfig.RunWalkSpeed *(WVal+1))

		local zWalk = WVal	
		Walk.t = Vector3.new(xWalk,yWalk,WVal)
		local Walk2 = Walk.p
		local xWalk2 = Walk2.X/2.1
		local yWalk2 = Walk2.Y/2.1
		local zWalk2 = Walk2.Z/2.5
		local xWalk3 = Walk2.X/1.1
		local yWalk3 = Walk2.Y/1.1
		if Clone then
			if Aiming then
				zWalk = 0	
			else
				zWalk = WVal	
			end
			if Walking then
				WalkRate = (Human.WalkSpeed/3)	
				if a then
					TVal = Lerp(0,(-.20*SpeedPrecision/ServerConfig.RunWalkSpeed),10)
				elseif d then
					TVal = Lerp(0,(.20*SpeedPrecision/ServerConfig.RunWalkSpeed),10)
				else
					TVal = Lerp(0,0,10)
				end
			else
				WalkRate = (SpeedPrecision/ServerConfig.RunWalkSpeed) + .5
				WVal = Lerp(0,0,10)
			end									
			local currtick = tick()
			t = t + (((currtick - OldTick)*WalkRate)*(Human.WalkSpeed/15))

			OldTick = currtick	
			local Sway = CFa(YSWY*RAD(10),-XSWY*RAD(10),-XSWY*RAD(6.5))
			if Saude.Stances.Ferido.Value == true then
				if Aiming then
					Waval = Waval:lerp(CFn(xWalk3/220,-yWalk3/180,0)*CFn(xWak/220,-yWak/180 + math.clamp(yWalk2/2.5,-10,2),0)*CFn(0,(YSWY/2)/10,0)*CFa(0,0,yWalk3/13)*CFa(0,(-TWAY/8)/10,(TWAY/8)/12),1)
				else
					Waval = Waval:lerp(CFn(xWalk3/220,-yWalk3/180,0)*CFn(xWak/220,-yWak/180 + math.clamp(yWalk2/2.5,-10,2),0)*CFn(0,(YSWY/2)/10,0)*CFa(0,0,yWalk3/11)*CFa(0,(-TWAY/8)/10,(TWAY/8)/12),1)
				end
			else
				if Aiming then
					Waval = Waval:lerp(CFn(xWalk3/220,-yWalk3/180,0)*CFn(xWak/220,-yWak/180,0)*CFn(0,(YSWY/2)/10,0)*CFa(0,0,yWalk3/13)*CFa(0,(-TWAY/8)/10,(TWAY/8)/12),1)
				else
					Waval = Waval:lerp(CFn(xWalk3/220,-yWalk3/180,0)*CFn(xWak/220,-yWak/180,0)*CFn(0,(YSWY/2)/10,0)*CFa(0,0,yWalk3/11)*CFa(0,(-TWAY/8)/10,(TWAY/8)/12),1)
				end
			end
			if Aiming then
				bruh = bruh:Lerp(CFrame.new(-xTilt*.5,-yTilt*0.5,0),0.15)
			else
				bruh = bruh:Lerp(CFrame.new(-xTilt*0.8,-yTilt*0.8,0),0.15)
			end

			local bobspeed = (Player.Character.Torso.Velocity.Magnitude/1.5 * Player.Character.Humanoid.WalkSpeed)/1.5
			--if not Aiming then
			otherbob = otherbob:Lerp(CFrame.new(math.sin(tick()*bobspeed)*0.06,math.sin(tick()*(bobspeed*2))*0.06,0)* CFrame.Angles(0,0,math.sin(tick()*bobspeed)*0.04), Update * 10)
			--end
			--Clone.C0 = Clone.C0:lerp(Waval*Sway,1)

			--if not Aiming then
			--Clone.C0 = Clone.C0:lerp(Waval*otherbob*bruh*Waval*Sway,0.75) 
			--else
			--Clone.C0 = Clone.C0:lerp(Waval*bruh*Sway,0.35)
			Clone.C0 = Clone.C0:lerp(CFrame.new(0,0,2.525) * Waval*bruh * Sway,0.65)
			--end
		end
		if OverHeat and Can_Shoot then
			delay(5,function()
				if Can_Shoot then
					OverHeat = false
				end
			end)
		end

		if BSpread then
			local currTime = time()
			if currTime - LastSpreadUpdate > FireRate * 2 then
				LastSpreadUpdate = currTime
				BSpread = math.max(Settings.MinSpread, BSpread - (Settings.AimInaccuracyStepAmount)/5)
				--RecoilPower =  math.max(Settings.MinRecoilPower, RecoilPower - (Settings.RecoilPowerStepAmount)/4)
			end
		end

		if OverHeat then
			ArmaClone.SmokePart.OverHeat.Enabled = true
			ArmaClone.SmokePart.SmokeTrail.Enabled = true
		else
			ArmaClone.SmokePart.OverHeat.Enabled = false
			ArmaClone.SmokePart.SmokeTrail.Enabled = false
		end
		function AimAnim(L_442_arg1)
			--AnimDebounce = true
			if Anims.AimAnim then
				Anims.AimAnim(Character, nil, {
					AnimBaseW,
					RA,
					LA,
					AnimBase.GripW,
					ArmaClone,
					Settings,
					Left_Weld,
					Right_Weld,
					AimPartMode,
				});
				--AnimDebounce = false
			end
		end;
		function UnAimAnim(L_442_arg1)
			--AnimDebounce = true
			if Anims.UnAimAnim then
				Anims.UnAimAnim(Character, nil, {
					AnimBaseW,
					RA,
					LA,
					AnimBase.GripW,
					ArmaClone,
					Settings,
					Left_Weld,
					Right_Weld,
					AimPartMode,
				});
				--AnimDebounce = false
			end
		end;
		local angleoff = funnyrecoil.p
		local off = swayOther.p
		if Aiming and _G.FreeLook == false and Settings.NoADS == nil then
			orientation = HeadBase.Orientation
			yahoo = HeadBase.CFrame
			yahoo2 = HeadBase.CFrame.p
			--[[Personagem.Saude.Variaveis.ArmStamina.Value -= 3
			if Personagem.Saude.Variaveis.ArmStamina.Value <= 0 then
				Personagem.Saude.Variaveis.Stamina.Value = Personagem.Saude.Variaveis.Stamina.Value - 2
			end]]--
			Saude.Variaveis.Aiming.Value = true

			if Hit and stance ~= 1 and stance ~= -1 and Hit.Name ~= "Ignorable" and Hit.Name.Parent ~= "LaserPoint" and stance ~= -2 and Bipod == false and canTween == false then
				if (Pos-HeadBase.Position).Magnitude <= (GunSize)/1.45 and (not ArmaClient:FindFirstChild("WeaponType") or ArmaClient:FindFirstChild("WeaponType").Value == "Rifle") then
					Clone.C1 = Clone.C1:Lerp(Clone.C0:inverse() * Recoil * CFrame.new(-1,0.24,-.15 + (((ArmaClone.Handle.Position - Pos).magnitude/(GunSize)) - 1) * -Settings.GunFOVReduction) * CFrame.Angles(math.rad(-6),math.rad(83),math.rad(18)) ,0.15)
				else
					Clone.C1 = Clone.C1:Lerp(Clone.C0:inverse() * Recoil * CFrame.new(0,0,(((ArmaClone.Handle.Position - Pos).magnitude/(GunSize)) - 1) * -Settings.GunFOVReduction), 0.15)
				end

				--Clone.C1 = Clone.C1:Lerp(Clone.C1:inverse() * Recoil * CFrame.Angles(-1,1,(((ArmaClone.Handle.Position - Pos).magnitude/Settings.GunSize) - 1) * -Settings.GunFOVReduction) ,0.15)
				--Clone.C1 = Clone.C1:Lerp(Clone.C0:inverse() * Recoil * CFrame.new(0,0,((((ArmaClone.Handle.Position - Pos).magnitude/Settings.GunSize) - 1) * -Settings.GunFOVReduction)*1) * CFrame.Angles(-((((ArmaClone.Handle.Position - Pos).magnitude/Settings.GunSize) - 1) * -Settings.GunFOVReduction)*0.25,((((ArmaClone.Handle.Position - Pos).magnitude/Settings.GunSize) - 1) * -Settings.GunFOVReduction)*0.25,0) ,0.15)'
			else
				if not NVG or ArmaClone.AimPart:FindFirstChild("NVAim") == nil and not Hit then
					delay(0.25,function()
						if Anims.AimAnim and Aiming and Equipped then
							AimAnim()
						end
					end)
					for i,z in pairs(ArmaClone:GetChildren()) do
						if z.Name == "ProjectorSight" then
							z:FindFirstChildOfClass('SurfaceGui').Enabled = true
						end
					end
					if AimPartMode == 1 and ArmaClone:FindFirstChild("AimPart2") ~= nil then

						Clone.C1 = Clone.C1:Lerp(Clone.C1 --[[* Clone.C0:inverse()]] * Recoil * CFrame.new() * ArmaClone.AimPart.CFrame:toObjectSpace(HeadBase.CFrame),(0.15 * Personagem.Saude.Stances.Steadiness.Value *((Settings.ChangeFOV[1]/8)*12*Update)))
					elseif AimPartMode == 2 and ArmaClone:FindFirstChild("AimPart2") ~= nil then
						Clone.C1 = Clone.C1:Lerp(Clone.C1 --[[* Clone.C0:inverse()]] * Recoil * ArmaClone.AimPart2.CFrame:toObjectSpace(HeadBase.CFrame),(0.15* Personagem.Saude.Stances.Steadiness.Value*((Settings.ChangeFOV[1]/8)*12*Update)))
					else
						Clone.C1 = Clone.C1:Lerp(Clone.C1 --[[* Clone.C0:inverse()]] * Recoil * ArmaClone.AimPart.CFrame:toObjectSpace(HeadBase.CFrame),(0.15* Personagem.Saude.Stances.Steadiness.Value*((Settings.ChangeFOV[1]/8)*12*Update)))
					end
				else
					if not Bipod and canTween == false then
						Clone.C1 = Clone.C1:Lerp(Clone.C1 --[[* Clone.C0:inverse()]] * Recoil * CFrame.new() * (ArmaClone.AimPart.CFrame * ArmaClone.AimPart.NVAim.CFrame):toObjectSpace(HeadBase.CFrame),(0.15* Personagem.Saude.Stances.Steadiness.Value*((Settings.ChangeFOV[1]/8)*12*Update)))
					else
						Aiming = false
						stance = 0
					end
				end
			end

		else
			Saude.Variaveis.Aiming.Value = false
			Aiming = false
			if Anims.UnAimAnim and not Aiming and Equipped then
				UnAimAnim()
			end
			for i,z in pairs(ArmaClone:GetChildren()) do
				if z.Name == "ProjectorSight" then
					z:FindFirstChildOfClass('SurfaceGui').Enabled = false
				end
			end
			if Hit and stance ~= 1 and stance ~= -1 and Hit.Name ~= "Ignorable" and Hit.Name.Parent ~= "LaserPoint" and stance ~= -2 and Bipod == false and canTween == false then
				orientation = HeadBase.Orientation
				yahoo = HeadBase.CFrame
				yahoo2 = HeadBase.CFrame.p
				--Clone.C1 = Clone.C1:Lerp(Clone.C0:inverse() * Recoil * CFrame.new(0,0,(((ArmaClone.Handle.Position - Pos).magnitude/(GunSize)) - 1) * -Settings.GunFOVReduction) ,0.15)

				if (Pos-HeadBase.Position).Magnitude <= (GunSize)/1.45 and (not ArmaClient:FindFirstChild("WeaponType") or ArmaClient:FindFirstChild("WeaponType").Value == "Rifle") then
					Clone.C1 = Clone.C1:Lerp(Clone.C0:inverse() * Recoil * CFrame.new(-1,0.24,-.15 + (((ArmaClone.Handle.Position - Pos).magnitude/(GunSize)) - 1) * -Settings.GunFOVReduction) * CFrame.Angles(math.rad(-6),math.rad(83),math.rad(18)) ,0.15)
				else
					Clone.C1 = Clone.C1:Lerp(Clone.C0:inverse() * Recoil * CFrame.new(math.min(((((ArmaClone.Handle.Position - Pos).magnitude/(GunSize)) - 1) * -Settings.GunFOVReduction) / -4,0),math.min(((((ArmaClone.Handle.Position - Pos).magnitude/(GunSize)) - 1) * -Settings.GunFOVReduction) / -4.5,0),(((ArmaClone.Handle.Position - Pos).magnitude/(GunSize)) - 1) * -Settings.GunFOVReduction) * CFrame.Angles(0,0,math.min(((((ArmaClone.Handle.Position - Pos).magnitude/(GunSize)) - 1) * -Settings.GunFOVReduction) / 1.65),0), 0.15)
				end

				--Clone.C1 = Clone.C1:Lerp(Clone.C1:inverse() * Recoil * CFrame.Angles(-1,1,(((ArmaClone.Handle.Position - Pos).magnitude/Settings.GunSize) - 1) * -Settings.GunFOVReduction) ,0.15)
				--Clone.C1 = Clone.C1:Lerp(Clone.C0:inverse() * Recoil * CFrame.new(0,0,((((ArmaClone.Handle.Position - Pos).magnitude/Settings.GunSize) - 1) * -Settings.GunFOVReduction)*1) * CFrame.Angles(-((((ArmaClone.Handle.Position - Pos).magnitude/Settings.GunSize) - 1) * -Settings.GunFOVReduction)*0.25,((((ArmaClone.Handle.Position - Pos).magnitude/Settings.GunSize) - 1) * -Settings.GunFOVReduction)*0.25,0) ,0.15)'
			else
				if _G.FreeLook == false  then
					yahoo = HeadBase.CFrame
					yahoo2 = HeadBase.CFrame.p
					orientation = HeadBase.Orientation
					Clone.C1 = Clone.C1:Lerp(Clone.C0:inverse() * Recoil * CFrame.new(),0.15)
				end
			end
		end

		if ArmaClone:FindFirstChild("BipodPoint") ~= nil then

			local BipodRay = Ray.new(ArmaClone.BipodPoint.Position, ArmaClone.BipodPoint.CFrame.UpVector * -1.75)
			local BipodHit, BipodPos, BipodNorm = workspace:FindPartOnRayWithIgnoreList(BipodRay, Ray_Ignore, false, true)

			if BipodHit and (stance == 0 or stance == 2) then
				Gui.Bipod.ImageColor3 = Color3.fromRGB(255, 255, 0)
				BipodEnabled = true
				if (ArmaClone:FindFirstChild("Mount") and ArmaClone:FindFirstChild("Mount").Value == true) or BipodEnabled and Bipod and _G.FreeLook == false and canTween == false then
					orientation = HeadBase.Orientation
					yahoo = HeadBase.CFrame
					yahoo2 = HeadBase.CFrame.p
					Gui.Bipod.ImageColor3 = Color3.fromRGB(255, 255, 255)
					local StaminaValue = 0
					HeadBase.CFrame =  Camera.CFrame * CFrame.new(0, 0, -0.5) * CFrame.Angles( math.rad(StaminaValue * math.sin( tick() * 2.5 )),math.rad(StaminaValue * math.sin( tick() * 1.25 )), 0)
					local ArmStaminaValue = Settings.SwayBase + (1-(Personagem.Saude.Variaveis.ArmStamina.Value/Personagem.Saude.Variaveis.ArmStamina.MaxValue)*Personagem.Saude.Stances.Steadiness.Value)* Settings.MaxSway
					HeadBase.CFrame =  Camera.CFrame * CFrame.new(0, 0, -0.5) * CFrame.Angles( math.rad(ArmStaminaValue * math.sin( tick() * 2.5 )),math.rad(ArmStaminaValue * math.sin( tick() * 1.25 )), 0)
					if stance == 0 and not Aiming then
						Clone.C1 = Clone.C1:Lerp(Clone.C0:inverse() * Recoil * CFrame.new(0,(((ArmaClone.BipodPoint.Position - BipodPos).magnitude)-1) * (-1.5), 0) ,0.15)
					end
				else
					if _G.FreeLook == false and canTween == false then
						orientation = HeadBase.Orientation
						yahoo = HeadBase.CFrame
						yahoo2 = HeadBase.CFrame.p
						Gui.Bipod.ImageColor3 = Color3.fromRGB(255, 255, 0)
						local StaminaValue = Settings.SwayBase + (1-(Personagem.Saude.Variaveis.Stamina.Value/Personagem.Saude.Variaveis.Stamina.MaxValue)*Personagem.Saude.Stances.Steadiness.Value)* Settings.MaxSway
						HeadBase.CFrame =  Camera.CFrame * CFrame.new(0, 0, -0.5) * CFrame.Angles( math.rad(StaminaValue * math.sin( tick() * 2.5 )),math.rad(StaminaValue * math.sin( tick() * 1.25 )), 0) 
						local ArmStaminaValue = Settings.SwayBase + (1-(Personagem.Saude.Variaveis.ArmStamina.Value/Personagem.Saude.Variaveis.ArmStamina.MaxValue)*Personagem.Saude.Stances.Steadiness.Value)* Settings.MaxSway
						HeadBase.CFrame =  Camera.CFrame * CFrame.new(0, 0, -0.5) * CFrame.Angles( math.rad(ArmStaminaValue * math.sin( tick() * 2.5 )),math.rad(ArmStaminaValue * math.sin( tick() * 1.25 )), 0)
					end
				end
			else
				if _G.FreeLook == false and canTween == false then
					orientation = HeadBase.Orientation
					yahoo = HeadBase.CFrame
					yahoo2 = HeadBase.CFrame.p
					Gui.Bipod.ImageColor3 = Color3.fromRGB(255, 0, 0)
					Bipod = false
					BipodEnabled = false
					local StaminaValue = Settings.SwayBase + (1-(Personagem.Saude.Variaveis.Stamina.Value/Personagem.Saude.Variaveis.Stamina.MaxValue)*Personagem.Saude.Stances.Steadiness.Value)* Settings.MaxSway
					HeadBase.CFrame =  Camera.CFrame * CFrame.new(0, 0, -0.5) * CFrame.Angles( math.rad(StaminaValue * math.sin( tick() * 2.5 )),math.rad(StaminaValue * math.sin( tick() * 1.25 )), 0)
					local ArmStaminaValue = Settings.SwayBase + (1-((Personagem.Saude.Variaveis.ArmStamina.Value*1.5)/Personagem.Saude.Variaveis.ArmStamina.MaxValue))* Settings.MaxSway
					HeadBase.CFrame =  Camera.CFrame * CFrame.new(0, 0, -0.5) * CFrame.Angles( math.rad(ArmStaminaValue * math.sin( tick() * 2.5 )),math.rad(ArmStaminaValue * math.sin( tick() * 1.25 )), 0)
				end		
			end

		else
			if _G.FreeLook == false and canTween == false then
				orientation = HeadBase.Orientation
				yahoo = HeadBase.CFrame
				yahoo2 = HeadBase.CFrame.p
				Gui.Bipod.ImageColor3 = Color3.fromRGB(255, 0, 0)
				local StaminaValue = Settings.SwayBase + (1-(Personagem.Saude.Variaveis.Stamina.Value/Personagem.Saude.Variaveis.Stamina.MaxValue))* Settings.MaxSway
				HeadBase.CFrame =  Camera.CFrame * CFrame.new(0, 0, -0.5) * CFrame.Angles( math.rad(StaminaValue * math.sin( tick() * 2.5 )),math.rad(StaminaValue * math.sin( tick() * 1.25 )), 0)
				local ArmStaminaValue = Settings.SwayBase + (1-((Personagem.Saude.Variaveis.ArmStamina.Value*1.5)/Personagem.Saude.Variaveis.ArmStamina.MaxValue))* Settings.MaxSway
				HeadBase.CFrame =  Camera.CFrame * CFrame.new(0, 0, -0.5) * CFrame.Angles( math.rad(ArmStaminaValue * math.sin( tick() * 2.5 )),math.rad(ArmStaminaValue * math.sin( tick() * 1.25 )), 0)
			end
		end
		local x,y,z = 0,0,0
		local r = Vector3.new()
		local StaminaValue = Settings.SwayBase + (1-(Personagem.Saude.Variaveis.Stamina.Value/Personagem.Saude.Variaveis.Stamina.MaxValue))* Settings.MaxSway
		HeadBase.CFrame = (Camera.CFrame * CFrame.new(0*(Aiming and 0.02 or 0.01+y),0*(Aiming and -0.02 or -0.01)+x,0) * CFrame.new(0, 0, -.5) * CFrame.Angles( math.rad(StaminaValue * math.sin( tick() * 0.5 )),math.rad(StaminaValue * math.sin( tick() * 1.25 )), 0)*CFrame.Angles(math.rad(0),math.rad(0),0)) * CFrame.fromEulerAnglesYXZ(x,y,0) * CFrame.Angles(math.rad(off.X),math.rad(off.Y),math.rad(off.Z)) * CFrame.Angles(angleoff.X,angleoff.Y,angleoff.Z)
		local ArmStaminaValue = Settings.SwayBase + (1-((Personagem.Saude.Variaveis.ArmStamina.Value*1.5)/Personagem.Saude.Variaveis.ArmStamina.MaxValue))* Settings.MaxSway
		HeadBase.CFrame = (Camera.CFrame * CFrame.new(0*(Aiming and 0.02 or 0.01+y),0*(Aiming and -0.02 or -0.01)+x,0) * CFrame.new(0, 0, -.5) * CFrame.Angles( math.rad(ArmStaminaValue * math.sin( tick() * 0.5 )),math.rad(ArmStaminaValue * math.sin( tick() * 1.25 )), 0)*CFrame.Angles(math.rad(0),math.rad(0),0)) * CFrame.fromEulerAnglesYXZ(x,y,0) * CFrame.Angles(math.rad(off.X),math.rad(off.Y),math.rad(off.Z)) * CFrame.Angles(angleoff.X,angleoff.Y,angleoff.Z)

		if _G.LeanPart and _G.FreeLook == false and canTween == false then
			yahoo = HeadBase.CFrame
			yahoo2 = HeadBase.CFrame.p
			HeadBase.CFrame = HeadBase.CFrame * _G.LeanPart.CFrame
		end

		if Equipped and LaserAtivo then
			if NVG then
				Pointer.Transparency = 1
				laserglint.Enabled = true
				Laser.Enabled = true

			else

				if not ServerConfig.RealisticLaser then
					Laser.Enabled = true
				else
					Laser.Enabled = false
				end

				if IRmode then
					Pointer.Transparency = 1
					laserglint.Enabled = false
				else
					Pointer.Transparency = 1
					laserglint.Enabled = true
				end
			end

			local L_361_ = Ray.new(ArmaClone.LaserPoint.Position, AnimBase.CFrame.lookVector * 999)
			local Hit, Pos, Normal = workspace:FindPartOnRayWithIgnoreList(L_361_, Ray_Ignore, false, true)

			LaserEP.CFrame = CFrame.new(0, 0, -LaserDist)
			Pointer.CFrame =  CFrame.new(Pos, Pos + Normal)


			if Hit then
				LaserDist = (ArmaClone.LaserPoint.Position - Pos).magnitude
			else
				LaserDist = 999
			end
			Evt.SVLaser:FireServer(Pos,1,ArmaClone.LaserPoint.Color,ArmaClient,IRmode)
		end
		if _G.FreeLook == true then
			local oldcamera = Camera.CFrame
			if Character.HumanoidRootPart:FindFirstChild("FLAlign") == nil then
				local Alinhar = Instance.new('AlignOrientation')
				Alinhar.Parent = Character.HumanoidRootPart
				Alinhar.Name = "FLAlign"
				Alinhar.PrimaryAxisOnly = true
				Alinhar.RigidityEnabled = true
				Alinhar.Attachment1 = Character.HumanoidRootPart.RootAttachment
				Alinhar.Attachment0 = ArmaClone.Parent.AnimBase.Attachment
			end
			local XLook=math.max(math.min(((Mouse.X-(Mouse.ViewSizeX/2.5))/150)^3,1),-1)
			local YLook=math.max(math.min(((Mouse.Y-(Mouse.ViewSizeY/2.5))/200)^3,1),-1)
			--local LookOffset=player.Character.Head.CFrame:toWorldSpace(CFrame.new(0,0,-1)*CFrame.Angles(-YLook,-XLook,0))
			--Camera.CoordinateFrame=LookOffset
			local yup = Camera.CFrame
			local yup2 = yup - yup.Position
			--HeadBase.CFrame = CFrame:inverse(_G.FLPart.CFrame * CFrame.new(0, 0, -.5) * -1)
			--HeadBase.CFrame = CFrame.new(Camera.CFrame.p) * CFrame.new(0, 0, -.5)
			HeadBase.CFrame = CFrame.new(Camera.CFrame.p) * (yahoo - yahoo2) * CFrame.new(0, 0, -.5)
		end
	end
end)

Evt.SVFlash.OnClientEvent:Connect(function(Player,Mode,Arma,Angle,Bright,Color,Range)
	if Player ~= Jogador and Player.Character['S' .. Arma.Name].Grip:FindFirstChild("Flash") ~= nil then
		local Arma = Player.Character['S' .. Arma.Name]
		--local Luz = Instance.new("SpotLight")
		local bg = Instance.new("BillboardGui")


		if Mode == true then
--[[		Luz.Parent = Arma.Grip.Flash
		Luz.Angle = Angle
		Luz.Brightness = Bright
		Luz.Range = Range
		Luz.Color = Color]]--

			bg.Parent = Arma.Grip.Flash
			bg.Adornee = Arma.Grip.Flash
			bg.Size = UDim2.new(10, 0, 10, 0)

			local flash = Instance.new("ImageLabel", bg)
			flash.BackgroundTransparency = 1
			flash.Size = UDim2.new(1, 20, 1, 20)
			flash.AnchorPoint = Vector2.new(0.5,0.5)
			flash.Position = UDim2.new(0.5, 0, 0.5, 0)
			flash.Image = "http://www.roblox.com/asset/?id=1847258023"
			flash.ImageColor3 = Color3.fromRGB(222,255,253)
			flash.ImageTransparency = 1
			flash.Rotation = math.random(-45, 45)

		else
			if Arma.Grip.Flash:FindFirstChild("SpotLight") ~= nil then
				Arma.Grip.Flash:FindFirstChild("SpotLight"):Destroy()
			end
			if Arma.Grip.Flash:FindFirstChild("BillboardGui") ~= nil then
				Arma.Grip.Flash:FindFirstChild("BillboardGui"):Destroy()
			end
		end
	end
end)

Evt.SVLaser.OnClientEvent:Connect(function(Player,Position,Modo,Cor,Arma,IR)

	if Player ~= Jogador then

		if BulletModel:FindFirstChild(Player.Name.."_Laser") == nil then
			local Dot = Instance.new('Part')
			local Att0 = Instance.new('Attachment')
			Att0.Name = "Att0"
			Att0.Parent = Dot
			Dot.Name = Player.Name.."_Laser"
			Dot.Parent = BulletModel
			Dot.Transparency = 1
			Dot.CanQuery = false

			if Player.Character and Arma and Player.Character:FindFirstChild('S'.. Arma.Name) ~= nil and Player.Character:WaitForChild('S'.. Arma.Name):WaitForChild('Grip'):FindFirstChild("Laser") ~= nil then
				local Muzzle = Player.Character:WaitForChild('S'.. Arma.Name):WaitForChild('Grip'):WaitForChild("Laser") 


				local Laser = Instance.new('Beam')
				Laser.Parent = Dot
				Laser.Transparency = NumberSequence.new(0)
				Laser.LightEmission = 1
				Laser.LightInfluence = 0
				Laser.Attachment0 = Att0
				Laser.Attachment1 = Muzzle
				Laser.Color = ColorSequence.new(Cor)
				Laser.FaceCamera = true
				Laser.Width0 = 0.01
				Laser.Width1 = 0.01
				if not NVG then
					Laser.Enabled = false
				end
			end
		end

		if Modo == 1 then
			if BulletModel:FindFirstChild(Player.Name.."_Laser") ~= nil then
				local LA = BulletModel:FindFirstChild(Player.Name.."_Laser")
				LA.Shape = 'Ball'
				LA.Size = Vector3.new(0.02, 0.02, 0.02)
				LA.CanCollide = false
				LA.Anchored = true
				LA.Color = Cor
				LA.Material = Enum.Material.Neon
				LA.Position = Position	
				if NVG then

					LA.Transparency = 1

					if LA:FindFirstChild("Beam") ~= nil then
						LA.Beam.Enabled = true
					end

				else

					if Player.Character and Player.Character:FindFirstChild('S'.. Arma.Name) ~= nil and Player.Character:WaitForChild('S'.. Arma.Name):WaitForChild('Grip'):FindFirstChild("Laser") ~= nil then
						if IR then
							LA.Transparency = 1
						else
							LA.Transparency = 1
						end
					end

					if LA:FindFirstChild("Beam") ~= nil then
						LA.Beam.Enabled = false
					end			

				end

			end

		elseif Modo == 2 then
			if BulletModel:FindFirstChild(Player.Name.."_Laser") ~= nil then
				local LA = BulletModel:FindFirstChild(Player.Name.."_Laser")
				LA:Destroy()
			end
		end
	end
end)

Evt.MedSys.Energetic.OnClientEvent:Connect(function(player)
	for i,v in pairs(Human.Parent:GetChildren()) do
		--print("stage1")
		if v:IsA("BasePart") then
			--print("stage1.5")
			for i,valu in pairs (v:GetChildren()) do
				--print("stage2")
				if valu.Name == "HP" and valu.Value > 0 then
					valu.Value = valu.Value + (valu.MaxValue/3)
					print("client healed "..valu.Value.." "..valu.Parent.Name)

				end
			end
		end
	end
end)

Evt.MedSys.Surgical.OnClientEvent:Connect(function(player)
	for i,v in pairs(Human.Parent:GetChildren()) do
		--print("stage1")
		if v:IsA("BasePart") then
			--print("stage1.5")
			for i,valu in pairs (v:GetChildren()) do
				--print("stage2")
				if valu.Name == "HP" and valu.Value <= 0 then
					valu.Value = 1
					valu.MaxValue = math.ceil(valu.MaxValue - (valu.MaxValue/9))
					print("client healed "..valu.Value.." "..valu.Parent.Name)

				end
			end
		end
	end
end)

function Launcher()
	if Settings.FireModes.Explosive == true then
		Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Fire2'):Play()



		local M203 = Instance.new("Part")
		M203.Shape = 'Ball'
		M203.CanCollide = false
		M203.Size = Vector3.new(0.25,0.25,0.25)
		M203.Material = Enum.Material.Metal
		M203.Color = Color3.fromRGB(27, 42, 53)
		M203.Parent = BulletModel
		M203.CFrame = ArmaClone.SmokePart2.CFrame
		M203.Velocity = ArmaClone.SmokePart2.CFrame.lookVector*(600-196.2)


		local At1 = Instance.new("Attachment")
		--	At1.Name = "At1"
		At1.Position = Vector3.new(0,-1,-8)				--(-10,0,0)
		At1.Parent = M203

		local At2 = Instance.new("Attachment")
		--	At2.Name = "At2"
		At2.Position = Vector3.new(0,0,8)				--(10,0,0)	
		At2.Parent = M203

		local tracerBeam1 = Instance.new("Beam")
		tracerBeam1.Parent = M203
		tracerBeam1.Enabled = true
		tracerBeam1.FaceCamera = true
		tracerBeam1.Color = ColorSequence.new(Settings.TracerColor)
		tracerBeam1.Texture = "http://www.roblox.com/asset/?id=1847258023"
		tracerBeam1.LightEmission = 1
		tracerBeam1.LightInfluence = 0
		tracerBeam1.TextureLength = 1
		tracerBeam1.TextureSpeed = 0
		tracerBeam1.TextureMode = Enum.TextureMode.Stretch
		tracerBeam1.Attachment0 = At2
		tracerBeam1.Attachment1 = At1
		tracerBeam1.Segments = 2
		tracerBeam1.Width0 = 1
		tracerBeam1.Width1 = 3	
		tracerBeam1.CurveSize0 = 0
		tracerBeam1.CurveSize1 = 0	
		tracerBeam1.Transparency = NumberSequence.new(0)


		local Hit2, Pos2, Norm2, Mat2
		local Hit, Pos, Norm, Mat
		local L_257_ = ArmaClone.SmokePart2.Position;
		local L_258_ = M203.Position;
		local L_260_ = false	
		local recast

		while true do
			RS.Heartbeat:wait()
			L_258_ = M203.Position;

			Hit2, Pos2, Norm2, Mat2 = workspace:FindPartOnRayWithIgnoreList(Ray.new(L_257_, (L_258_ - L_257_)*20), Ray_Ignore, false, true);

			Hit, Pos, Norm, Mat = workspace:FindPartOnRayWithIgnoreList(Ray.new(L_257_, (L_258_ - L_257_)), Ray_Ignore, false, true);

			if Hit2 then
				while not recast do
					if Hit2 and (Hit2 and Hit2.Transparency >= 1 or Hit2.CanCollide == false or Hit2.Name == "Ignorable" or Hit2.Name == "Glass" or Hit2.Parent.Name == "Top" or Hit2.Parent.Name == "Accessory4" or Hit2.Parent.Name == "Up" or Hit2.Parent.Name == "Down" or Hit2.Parent.Name == "Face" or Hit2.Parent.Name == "Olho" or Hit2.Parent.Name == "Headset" or Hit2.Parent.Name == "Numero" or Hit2.Parent.Name == "Vest" or Hit2.Parent.Name == "Chest" or Hit2.Parent.Name == "Waist" or Hit2.Parent.Name == "Back" or Hit2.Parent.Name == "Belt" or Hit2.Parent.Name == "Leg1" or Hit2.Parent.Name == "Leg2" or Hit2.Parent.Name == "Arm1"  or Hit2.Parent.Name == "Arm2") and Hit2.Name ~= 'Right Arm' and Hit2.Name ~= 'Left Arm' and Hit2.Name ~= 'Right Leg' and Hit2.Name ~= 'Left Leg' and Hit2.Name ~= 'Armor' and Hit2.Name ~= 'Stomach' and Hit2.Name ~= 'Collision' and Hit2.Name ~= 'EShield' then
						table.insert(Ray_Ignore, Hit2)
						recast = true
					--[[elseif  Hit2.Name == "Visor" then
						local hitplr = game.Players:GetPlayerFromCharacter(Hit2.Parent.Parent.Parent)
						local durb = Hit2:FindFirstChild("Durability")

						Engine.Eventos.Armor.ChangeVisorDurb:FireServer(durb, hitplr)]]--
					end

					if recast then
						Hit2, Pos2, Norm2, Mat2 = workspace:FindPartOnRayWithIgnoreList(Ray.new(L_257_, (L_258_ - L_257_)*20), Ray_Ignore, false, true);
						Hit, Pos, Norm, Mat = workspace:FindPartOnRayWithIgnoreList(Ray.new(L_257_, (L_258_ - L_257_)), Ray_Ignore, false, true);
						recast = false
					else
						break
					end
				end
			end

			if Hit and not recast then
				Evt.LauncherHit:FireServer(Pos, Hit, Norm, Mat)
				Hitmarker.Explosion(Pos, Hit, Norm)
				M203:remove()

				local Hitmark = Instance.new("Attachment")
				Hitmark.CFrame = CFrame.new(Pos, Pos + Norm)
				Hitmark.Parent = workspace.Terrain
				Debris:AddItem(Hitmark, 5)

				local Exp = Instance.new("Explosion")
				Exp.BlastPressure = 750
				Exp.ExplosionType = "NoCraters"
				Exp.BlastRadius = 30
				Exp.DestroyJointRadiusPercent = 0
				Exp.Position = Hitmark.Position
				Exp.Parent = workspace
				Exp.Visible = false

				Exp.Hit:connect(function(hitPart, partDistance)

					local FoundHuman,VitimaHuman = CheckForHumanoid(hitPart)
					local damage = math.random(Settings.LauncherDamage[1],Settings.LauncherDamage[2])
					if FoundHuman == true and VitimaHuman.Health > 0 then
						local distance_factor = partDistance / Exp.BlastRadius    -- get the distance as a value between 0 and 1
						distance_factor = 1 - distance_factor                         -- flip the amount, so that lower == closer == more damage
						if distance_factor > 0 then
							local number = math.random(1,6)
							local number2 = math.random(1,6)
							local number3 = math.random(1,6)
							local a = nil
							if Character.Head:FindFirstChild("HP") then
								for i,v in pairs(Character:GetChildren()) do
									if v.Name == "Head" and number == 1 then
										a = v:FindFirstChild("HP")

									end
									if v.Name == "Torso" and (number == 2 or number2 == 2 or number3 == 2) then
										a = v:FindFirstChild("HP")

									end
									if v.Name == "Right Arm" and (number == 3 or number2 == 3 or number3 == 3) then
										a = v:FindFirstChild("HP")

									end
									if v.Name == "Left Arm" and (number == 4 or number2 == 4 or number3 == 4) then
										a = v:FindFirstChild("HP")

									end
									if v.Name == "Right Leg" and (number == 5 or number2 == 5 or number3 == 5) then
										a = v:FindFirstChild("HP")

									end
									if v.Name == "Left Leg" and (number == 6 or number2 == 6 or number3 == 6) then
										a = v:FindFirstChild("HP")

									end
								end

							end
							if a ~= nil then
								ReplicateClient.DamageClient:Fire(true,VitimaHuman,(damage*distance_factor),0,0,a.Parent.Name)
							end
						end
					end
				end)

				break
			end
			L_257_ = L_258_;
		end
	end		
end

Evt.LauncherHit.OnClientEvent:Connect(function(Player, Position, HitPart, Normal)
	if Player ~= Jogador then 
		Hitmarker.Explosion(Position, HitPart, Normal)
	end
end)



Evt.HalfHP.OnClientEvent:Connect(function(Player, Vitima)
	if Character.Humanoid.Health <= (Character.Humanoid.Health*0.5) and Character.Humanoid.Health > (Character.Humanoid.Health*0.25) then
		--print("half")
		number = math.random(1,3)
		if Player.Character:FindFirstChild("Head").Sound6 ~= nil then
			Player.Character:FindFirstChild("Head")["Sound"..number]:Play()
			wait(Player.Character:FindFirstChild("Head")["Sound"..number].TimeLength+1)
		end
	end
end)

Evt.QuarterHP.OnClientEvent:Connect(function(Player, Vitima)
	if Character.Humanoid.Health <= (Character.Humanoid.Health*0.25) and Character.Humanoid.Health > 0 then
		--print("quarter")
		number = math.random(4,6)
		if Player.Character:FindFirstChild("Head").Sound6 ~= nil then
			Player.Character:FindFirstChild("Head")["Sound"..number]:Play()
			wait(Player.Character:FindFirstChild("Head")["Sound"..number].TimeLength+1)
		end
	end

	if Character.Jump == true and Saude.Stances.Ferido.Value == true then
		ReplicateClient.DamageClient:Fire(true,Character.Humanoid,2,0,0,"Right Leg")
	end
end)

local OldHealth = Character.Humanoid.Health
local hurtdeb = false

Character.Humanoid.Changed:Connect(function()
	if Character.Humanoid.Health <= (OldHealth - 20) and Character.Humanoid.Health > 0 then
		--print("hurts!!")
		number = math.random(1,4)
		camShake:Start()
		camShake:ShakeOnce((Humanoid.Health/OldHealth)*2, 1, 0, 1.5, 0)
		OldHealth = Character.Humanoid.Health
		if Player.Character:FindFirstChild("Head").Hit1 ~= nil and not hurtdeb then
			hurtdeb = true
			Player.Character:FindFirstChild("Head")["Hit"..number]:Play()
			wait(Player.Character:FindFirstChild("Head")["Hit"..number].TimeLength+1)
			hurtdeb = false
		end
	end
end)

Mouse.Button1Down:connect(function()
	if Equipped then
		MouseHeld = true


		if Settings.Mode ~= "Explosive" then
			if slideback or Chambered.Value ~= true or Emperrado.Value == true then
				Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Click'):Play()	
				return
			end
		elseif Settings.Mode == "Explosive" and GLChambered.Value == false or GLAmmo.Value <= 0 then
			Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Click'):Play()	
			return	
		end


		if Can_Shoot and not Reloading and not Safe and not Correndo then
			Can_Shoot = false
			if Settings.FireDelay ~= nil then
				if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Trigger') then
					Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('Trigger'):Play()
				end
				wait(Settings.FireDelay)
			end
			if Settings.Type and Settings.Type == "Grenade" then
				CookGrenade = true
				Grenade()
				return
			end
			if Settings.Mode == "Semi" and Ammo.Value > 0 and Emperrado.Value == false then
				--Firing = true
				local swing = false
				if Anims.FireAnim ~= nil and ArmaClone:FindFirstChild("MeleeHinge") and swing == false then
					swing = true
					FireAnim()
				end
				Evt.Atirar:FireServer(FireRate,Anims.ShootPos,ArmaClient)
				for _ = 1, Settings.Bullets do
					Firing = true
					coroutine.resume(coroutine.create(function()
						Balinha = CreateBullet(BSpread)
						CastRay(Balinha)
					end))
				end
				if Anims.FireAnim ~= nil and swing == false then
					FireAnim()
				end
				recoil()
				Firing = false
				if ArmaClone:FindFirstChild("LoopEnd") then
					loopend = ArmaClone:FindFirstChild("LoopEnd").Value
				end
				task.delay((60/Settings.FireRate),function()
					recoil()
				end)
				Emperrar()
				if Emperrado.Value == false then
					delay(Settings.SlideExtend / 2, function()
						EjectShells()
					end)
				end
				Ammo.Value = Ammo.Value - 1

				if BSpread and not DecreasedAimLastShot then
					BSpread = math.min(Settings.MaxSpread, BSpread + Settings.AimInaccuracyStepAmount)
					--RecoilPower =  math.min(Settings.MaxRecoilPower, RecoilPower + Settings.RecoilPowerStepAmount)
				end
				DecreasedAimLastShot = not DecreasedAimLastShot
				if BSpread >= Settings.MaxSpread then
					OverHeat = true
				end

				task.wait(FireRate)
				Firing = false
			elseif Settings.Mode == "Auto" then
				while MouseHeld and Equipped and not Can_Shoot and Emperrado.Value == false and Ammo.Value > 0 do
					Firing = true
					Evt.Atirar:FireServer(FireRate,Anims.ShootPos,ArmaClient)
					for _ = 1, Settings.Bullets do
						coroutine.resume(coroutine.create(function()
							Balinha = CreateBullet(BSpread)
							CastRay(Balinha)
						end))
					end
					if Anims.FireAnim ~= nil then
						FireAnim()
					end
					recoil()
					extrarecoil = true
					delay(1,function()
						extrarecoil = false
					end)
					Emperrar()
					if Emperrado.Value == false then
						delay(Settings.SlideExtend / 2, function()
							EjectShells()
						end)
					end
					Ammo.Value = Ammo.Value - 1

					if BSpread and not DecreasedAimLastShot then
						BSpread = math.min(Settings.MaxSpread, BSpread + Settings.AimInaccuracyStepAmount)
						--RecoilPower =  math.min(Settings.MaxRecoilPower, RecoilPower + Settings.RecoilPowerStepAmount)
					end
					DecreasedAimLastShot = not DecreasedAimLastShot
					if BSpread >= Settings.MaxSpread then
						OverHeat = true
					end

					task.wait(FireRate)
					Firing = false
				end
				Firing = false
				recoil()
			elseif Settings.Mode == "Burst" and Ammo.Value > 0 then
				for i = 1, Settings.BurstShot do
					Firing = true
					for _ = 1, Settings.Bullets do
						if MouseHeld and Ammo.Value > 0 and Emperrado.Value == false then
							Evt.Atirar:FireServer(FireRate,Anims.ShootPos,ArmaClient)
							coroutine.resume(coroutine.create(function()
								Balinha = CreateBullet(BSpread)
								CastRay(Balinha)
							end))
							if Anims.FireAnim ~= nil then
								FireAnim()
							end
							recoil()
							Emperrar()
							if Emperrado.Value == false then
								delay(Settings.SlideExtend / 2, function()
									EjectShells()
								end)
							end
							Ammo.Value = Ammo.Value - 1
						end
					end	

					if BSpread and not DecreasedAimLastShot then
						BSpread = math.min(Settings.MaxSpread, BSpread + Settings.AimInaccuracyStepAmount)
						--RecoilPower =  math.min(Settings.MaxRecoilPower, RecoilPower + Settings.RecoilPowerStepAmount)
					end
					DecreasedAimLastShot = not DecreasedAimLastShot
					if BSpread >= Settings.MaxSpread then
						OverHeat = true
					end

					wait(BurstFireRate)
					Firing = false
				end
			elseif Settings.Mode == "Bolt-Action" or Settings.Mode == "Pump-Action" and Ammo.Value > 0 and Emperrado.Value == false then
				Evt.Atirar:FireServer(FireRate,Anims.ShootPos,ArmaClient)
				Firing = true
				for _ = 1, Settings.Bullets do


					coroutine.resume(coroutine.create(function()
						Balinha = CreateBullet(BSpread)
						CastRay(Balinha)
					end))
				end	
				if Anims.FireAnim ~= nil then
					FireAnim()
				end
				recoil()
				if (Ammo.Value - 1) > 0 then
					Emperrado.Value = true
				end
				if Emperrado == false then
					delay(Settings.SlideExtend/2,function()
						--EjectShells()
					end)
				end
				Ammo.Value = Ammo.Value - 1
				if BSpread and not DecreasedAimLastShot then
					BSpread = math.min(Settings.MaxSpread, BSpread + Settings.AimInaccuracyStepAmount)
					--RecoilPower =  math.min(Settings.MaxRecoilPower, RecoilPower + Settings.RecoilPowerStepAmount)
				end
				DecreasedAimLastShot = not DecreasedAimLastShot
				if BSpread >= Settings.MaxSpread then
					OverHeat = true
				end
				wait(0.25)
				repeat wait() until not MouseHeld
				if (Settings.AutoChamber) then
					if Aiming and (Settings.ChamberWhileAim) then
						MouseHeld = false
						Can_Shoot = false
						Reloading = true
						--wait(0.5)
						stance = 5
						Evt.Stance:FireServer(stance,Settings,Anims,ArmaClone)
						ChamberAnim()
						
						Sprint()
						Can_Shoot = true
						Reloading = false
					elseif not Aiming then
						MouseHeld = false
						Can_Shoot = false
						Reloading = true
						--wait(0.5)
						stance = 5
						Evt.Stance:FireServer(stance,Settings,Anims,ArmaClone)
						ChamberAnim()

						Sprint()
						Can_Shoot = true
						Reloading = false
					end
				end
				task.wait(FireRate)
				Firing = false


			elseif Settings.Mode == "Explosive" and GLAmmo.Value > 0 and GLChambered.Value == true and not Correndo then
				GLChambered.Value = false
				GLAmmo.Value = GLAmmo.Value - 1	
				coroutine.resume(coroutine.create(function()

					Launcher()
					recoil()

					if not DecreasedAimLastShot then
						--RecoilPower =  math.min(Settings.MaxRecoilPower, RecoilPower + Settings.RecoilPowerStepAmount)
					end
					DecreasedAimLastShot = not DecreasedAimLastShot
				end))
			end
			Can_Shoot = true
			Update_Gui()
		end
	end
end)

local DeltaTimeHB = game:GetService("RunService").Heartbeat:Wait()
local DeltaTimeRS = game:GetService("RunService").RenderStepped:Wait()

Mouse.Button1Up:connect(function()
	if Equipped then
		MouseHeld = false
		if Settings.Type and Settings.Type == "Grenade" then
			CookGrenade = false
		end
	end
	Firing = false
end)

Mouse.WheelForward:connect(function()
	if Equipped and Aiming and Sens.Value < 100 then
		Gui.Sens.TextTransparency = 0
		Gui.Sens.TextStrokeTransparency = .9
		Sens.Value = Sens.Value + 5
		Update_Gui()
		delay(1,function()
			ts(Gui.Sens,TweenInfo.new(2),{TextTransparency = 1,TextStrokeTransparency = 1}):Play()
		end)
		game:GetService('UserInputService').MouseDeltaSensitivity = (Sens.Value/100)
	end

end)

Mouse.WheelBackward:connect(function()
	if Equipped and Aiming and Sens.Value > 5 then
		Gui.Sens.TextTransparency = 0
		Gui.Sens.TextStrokeTransparency = .9
		Sens.Value = Sens.Value - 5
		Update_Gui()
		ts(Gui.Sens,TweenInfo.new(10),{TextTransparency = 1,TextStrokeTransparency = 1}):Play()
		game:GetService('UserInputService').MouseDeltaSensitivity = (Sens.Value/100)
	end

end)

Mouse.Button2Down:connect(function()
	if Equipped and not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftAlt) and stance > -2 and not Aiming and (Camera.Focus.p - Camera.CFrame.p).magnitude < 1 and not Correndo and (Settings.Type and Settings.Type ~= "Grenade" or Settings.Type == nil) and CanAim then
		if NVG and ArmaClone.AimPart:FindFirstChild("NVAim") ~= nil and Bipod then
			-- idk why this is here but it apparently is vital
		else
			if Safe then
				Safe = false
				IdleAnim()
				Update_Gui()
			end
			-- stance = 2
			-- Evt.Stance:FireServer(stance,Settings,Anims,ArmaClone)
			Aiming = true
			game:GetService('UserInputService').MouseDeltaSensitivity = (Sens.Value/100)
			--Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('AimDown').SoundId = ADSS[math.random(#ADSS)].SoundId
			Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('AimDown'):Play()

			if not NVG or ArmaClone.AimPart:FindFirstChild("NVAim") == nil then
				if ArmaClone:FindFirstChild('AimPart2') ~= nil then
					if AimPartMode == 1 then
						if Settings.ChangeFOV[1] == 70 then
							tweenfov(FOV,120)
						else
							tweenfov(Settings.ChangeFOV[1],120)
						end
						if Settings.FocusOnSight then
							ts(StatusClone.Efeitos.Aim,TweenInfo.new(.75),{ImageTransparency = 0}):Play()
						else
							ts(StatusClone.Efeitos.Aim,TweenInfo.new(.3),{ImageTransparency = 1}):Play()
						end
					elseif AimPartMode == 2 then
						if Settings.ChangeFOV[2] == 70 then
							tweenfov(FOV,120)
						else
							tweenfov(Settings.ChangeFOV[2],120)
						end
						if Settings.FocusOnSight2 then
							ts(StatusClone.Efeitos.Aim,TweenInfo.new(.75),{ImageTransparency = 0}):Play()
						else
							ts(StatusClone.Efeitos.Aim,TweenInfo.new(.3),{ImageTransparency = 1}):Play()
						end
					end
				else
					if AimPartMode == 1 then
						if Settings.ChangeFOV[1] == 70 then
							tweenfov(FOV,120)
						else
							tweenfov(Settings.ChangeFOV[1],120)
						end
						if Settings.FocusOnSight then
							ts(StatusClone.Efeitos.Aim,TweenInfo.new(.75),{ImageTransparency = 0}):Play()
						else
							ts(StatusClone.Efeitos.Aim,TweenInfo.new(.3),{ImageTransparency = 1}):Play()
						end
					elseif AimPartMode == 2 then
						if Settings.ChangeFOV[2] == 70 then
							tweenfov(FOV,120)
						else
							tweenfov(Settings.ChangeFOV[2],120)
						end
						if Settings.FocusOnSight2 then
							ts(StatusClone.Efeitos.Aim,TweenInfo.new(.75),{ImageTransparency = 0}):Play()
						else
							ts(StatusClone.Efeitos.Aim,TweenInfo.new(.3),{ImageTransparency = 1}):Play()
						end
					end
				end
			else
				tweenfov(FOV,120)
				ts(StatusClone.Efeitos.Aim,TweenInfo.new(.3),{ImageTransparency = 1}):Play()
			end
		end
		--[[elseif Aiming and Equipped  then
			stance = 0
			Evt.Stance:FireServer(stance,Settings,Anims)
		game:GetService('UserInputService').MouseDeltaSensitivity = 1
			Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('AimUp'):Play()	
			tweenfov(FOV,120)
			Aiming = false
			ts(StatusClone.Efeitos.Aim,TweenInfo.new(.3),{ImageTransparency = 1}):Play()]]--
	elseif Equipped and Aiming and CanAim and not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftAlt) and stance > -2 then
		stance = 0
		Evt.Stance:FireServer(stance,Settings,Anims,ArmaClone)
		game:GetService('UserInputService').MouseDeltaSensitivity = 1
		--Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('AimUp').SoundId = ADSS[math.random(#ADSS)].SoundId
		Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('AimUp'):Play()	
		tweenfov(FOV,120)
		Aiming = false
		ts(StatusClone.Efeitos.Aim,TweenInfo.new(.3),{ImageTransparency = 1}):Play()
	elseif Equipped and Aiming and game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftAlt) and stance > -2 then
		if Aiming then
			if ArmaClone:FindFirstChild("AimPart2") ~= nil then
				if AimPartMode == 1 then
					AimPartMode = 2
					if Settings.ChangeFOV[2] == 70 then
						tweenfov(FOV,120)
					else
						tweenfov(Settings.ChangeFOV[2],120)
					end
					if Settings.FocusOnSight2 and Aiming then
						ts(StatusClone.Efeitos.Aim,TweenInfo.new(.75),{ImageTransparency = 0}):Play()
					else
						ts(StatusClone.Efeitos.Aim,TweenInfo.new(.3),{ImageTransparency = 1}):Play()
					end
					if Settings.ZoomAnim then
						ZoomAnim()
						Sprint()
					end
				elseif AimPartMode == 2 then
					AimPartMode = 1
					if Settings.ChangeFOV[1] == 70 then
						tweenfov(FOV,120)
					else
						tweenfov(Settings.ChangeFOV[1],120)
					end
					if Settings.FocusOnSight and Aiming then
						ts(StatusClone.Efeitos.Aim,TweenInfo.new(.75),{ImageTransparency = 0}):Play()
					else
						ts(StatusClone.Efeitos.Aim,TweenInfo.new(.3),{ImageTransparency = 1}):Play()
					end
					if Settings.ZoomAnim then
						UnZoomAnim()
						Sprint()
					end
				end
			else
				if AimPartMode == 1 then
					AimPartMode = 2
					if Settings.ChangeFOV[2] == 70 then
						tweenfov(FOV,120)
					else
						tweenfov(Settings.ChangeFOV[2],120)
					end
					if Settings.FocusOnSight2 and Aiming then
						ts(StatusClone.Efeitos.Aim,TweenInfo.new(.75),{ImageTransparency = 0}):Play()
					else
						ts(StatusClone.Efeitos.Aim,TweenInfo.new(.3),{ImageTransparency = 1}):Play()
					end
					if Settings.ZoomAnim then
						ZoomAnim()
						Sprint()
					end
				elseif AimPartMode == 2 then
					AimPartMode = 1
					if Settings.ChangeFOV[1] == 70 then
						tweenfov(FOV,120)
					else
						tweenfov(Settings.ChangeFOV[1],120)
					end
					if Settings.FocusOnSight and Aiming then
						ts(StatusClone.Efeitos.Aim,TweenInfo.new(.75),{ImageTransparency = 0}):Play()
					else
						ts(StatusClone.Efeitos.Aim,TweenInfo.new(.3),{ImageTransparency = 1}):Play()
					end
					if Settings.ZoomAnim then
						UnZoomAnim()
						Sprint()
					end
				end
			end
		else
			if AimPartMode == 1 then
				AimPartMode = 2
				if Settings.FocusOnSight2 and Aiming then
					ts(StatusClone.Efeitos.Aim,TweenInfo.new(.75),{ImageTransparency = 0}):Play()
				else
					ts(StatusClone.Efeitos.Aim,TweenInfo.new(.3),{ImageTransparency = 1}):Play()
				end
				if Settings.ZoomAnim then
					ZoomAnim()
					Sprint()
				end
			elseif AimPartMode == 2 then
				AimPartMode = 1
				if Settings.FocusOnSight and Aiming then
					ts(StatusClone.Efeitos.Aim,TweenInfo.new(.75),{ImageTransparency = 0}):Play()
				else
					ts(StatusClone.Efeitos.Aim,TweenInfo.new(.3),{ImageTransparency = 1}):Play()
				end
				if Settings.ZoomAnim then
					UnZoomAnim()
					Sprint()
				end
			end
		end
	elseif Equipped and Settings.Type and Settings.Type == "Grenade" then
		GrenadeMode()
	end
end)

Human.Died:connect(function()
	ResetWorkspace()
	
	-- Human:UnequipTools()
	
	-- ^^ BAD!!! BADDD!!!!
	-- DO NOT UNEQUIP TOOLS!!!
	-- THIS MAKES IT SO YOU DONT DROP THEM!!
	
	-- Evt.Rappel.CutEvent:FireServer()
	--ts(game:GetService("Lighting"), TweenInfo.new(1), {ExposureCompensation = 0.5}):Play()
	if game:GetService("Lighting"):FindFirstChild("NVGColor") then
		ts(game:GetService("Lighting"):FindFirstChild("NVGColor"), TweenInfo.new(1), {Brightness = 0,Contrast = 0, Saturation = 0, TintColor = Color3.fromRGB(255, 255, 255)}):Play()
		Player.PlayerGui:WaitForChild("NVG").NVG.Value = false
	end
	
	-- Unset()
	
	-- ^^ same with this, makes you not drop weapons
end)


function onStateChanged(_,state)
	if state == Enum.HumanoidStateType.Swimming then
		Nadando = true
		if Equipped then
			Unset()
			Humanoid:UnequipTools()
		end
	else
		Nadando = false
	end

	if ServerConfig.EnableFallDamage then
		if state == Enum.HumanoidStateType.Freefall and not falling then
			falling = true
			local curVel = 0
			local peak = 0

			while falling do
				curVel = HumanoidRootPart.Velocity.magnitude
				peak = peak + 1
				wait()
			end
			local damage = (curVel - (ServerConfig.MaxVelocity)) * ServerConfig.DamageMult
			if damage > 5 and peak > 20 then
				local hurtSound = PastaFX.FallDamage:Clone()
				hurtSound.Parent = Player.PlayerGui
				hurtSound.Volume = damage/Human.MaxHealth
				hurtSound:Play()
				Debris:AddItem(hurtSound,hurtSound.TimeLength)
				ReplicateClient.DamageClient:Fire(true,Human,damage,0,0,"Right Leg")
				ReplicateClient.DamageClient:Fire(true,Human,damage,0,0,"Left Leg")
			end
		elseif state == Enum.HumanoidStateType.Landed or state == Enum.HumanoidStateType.Dead then
			falling = false
		end
	end
end

--[[Evt.ServerBullet.OnClientEvent:Connect(function(SKP_arg1,SKP_arg2,SKP_arg3,SKP_arg4,SKP_arg5,SKP_arg6,SKP_arg7,SKP_arg8,SKP_arg9,SKP_arg10,SKP_arg11,SKP_arg12)
	print("event got")
	if Jogador == SKP_arg2 then
		print("bullet work")
		local SKP_01 = SKP_arg3
		local SKP_02 = Instance.new("Part")
		SKP_02.Parent = workspace.ACS_WorkSpace.Server
		SKP_02.Name = SKP_arg1.Name..'_Bullet'
		SKP_02.Shape = "Block"
		SKP_02.Material = "Plastic"
		SKP_02.Size = Vector3.new(.5,.5,.5)
		SKP_02.CanCollide = true
		if Settings.ExplosiveHit == false then
			SKP_02.CanCollide = false
		end
		if Settings.ExplosiveHit == true then
			SKP_02.CanCollide = false
		end
		SKP_02.CFrame = SKP_01
		SKP_02.Transparency = 1
		if Settings.ExplosiveHit == false then
			local wind = Instance.new("BodyForce",SKP_02)
			wind.force = Windspeed.Value
		end
		local SKP_03 = SKP_02:GetMass()
		local SKP_04 = Instance.new('BodyForce', SKP_02)
		
		SKP_04.Force = Vector3.new(0,SKP_03 * (196.2) - SKP_arg5 * (196.2), 0)
		if Settings.ExplosiveHit == false then
			SKP_02.Velocity = SKP_arg7 * SKP_arg6
		end
		if Settings.ExplosiveHit == true then
			SKP_02.Velocity = SKP_arg7 * SKP_arg6
		end
		local SKP_05 = Instance.new('Attachment', SKP_02)
		SKP_05.Position = Vector3.new(0.1, 0, 0)
		local SKP_06 = Instance.new('Attachment', SKP_02)
		SKP_06.Position = Vector3.new(-0.1, 0, 0)
		
		
		if SKP_arg4 then
			local SKP_07 = Instance.new('Trail', SKP_02)
			SKP_07.Attachment0 = SKP_05
			SKP_07.Attachment1 = SKP_06
			SKP_07.Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 0, 0);
				NumberSequenceKeypoint.new(1, 1);
			}
			)
			SKP_07.WidthScale = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 2, 0);
				NumberSequenceKeypoint.new(1, 0);
			}
			)
			SKP_07.Texture = "rbxassetid://200182847"
			SKP_07.TextureMode = Enum.TextureMode.Stretch
			if Settings.ExplosiveHit == false then
				SKP_07.MaxLength = 60
			end
			SKP_07.LightEmission = 1
			SKP_07.Lifetime = 0.2
			SKP_07.FaceCamera = true
			SKP_07.Color = ColorSequence.new(SKP_arg8)
		end
		
		if SKP_arg10 then
			local SKP_08 = Instance.new("BillboardGui", SKP_02)
			SKP_08.Adornee = SKP_02
			SKP_08.Enabled = false
			local SKP_09 = math.random(275, 375)/10
			SKP_08.Size = UDim2.new(SKP_09, 0, SKP_09, 0)
			SKP_08.LightInfluence = 0
			local SKP_010 = Instance.new("ImageLabel", SKP_08)
			SKP_010.BackgroundTransparency = 1
			SKP_010.Size = UDim2.new(1, 0, 1, 0)
			SKP_010.Position = UDim2.new(0, 0, 0, 0)
			SKP_010.Image = "http://www.roblox.com/asset/?id=1047066405"
			SKP_010.ImageColor3 = SKP_arg11
			
			SKP_010.ImageTransparency = math.random(2, 5)/15
			spawn(function()
				wait(.2)
				if SKP_02:FindFirstChild("BillboardGui") ~= nil then
					SKP_02.BillboardGui.Enabled = true
				end
			end)
		end
		
		local SKP_011 = {SKP_arg2.Character,SKP_arg1.Character,SKP_02,workspace.ACS_WorkSpace}
		while SKP_02 do
			RS.RenderStepped:wait()
			local SKP_012 = Ray.new(SKP_02.Position, SKP_02.CFrame.LookVector*50)
			local SKP_013, SKP_014 = workspace:FindPartOnRayWithIgnoreList(SKP_012, SKP_011, false, true)
			if SKP_013 then
				SKP_02:Destroy()
				return SKP_02
			end
		end
		return SKP_02
	end
end)]]--
ProjectileNetcodeClient.Bullet:Connect(function(Player,BulletCF,Tracer,BDrop,BSpeed,Direction,TracerColor,Ray_Ignore,BulletFlare,BulletFlareColor,Player2,Setting)
	--print("bulletgot")
	if Player ~= Jogador and Player.Character then 
		--	print("serverbullet")
		local BulletCF2 = BulletCF
		local ServerBullet = Instance.new("Part")
		ServerBullet.Parent = ACS_Storage.Server
		ServerBullet.Name = Player.Name..'_Bullet'
		Debris:AddItem(ServerBullet, 5)
		ServerBullet.Shape = "Ball"
		ServerBullet.Size = Vector3.new(1, 1, 1)
		ServerBullet.CanCollide = false
		ServerBullet.CFrame = BulletCF2
		ServerBullet.Transparency = 1

		local BulletMass = ServerBullet:GetMass()
		local BulletForce = Instance.new('BodyForce', ServerBullet)

		BulletForce.Force = Vector3.new(0,BulletMass/10 * (196.2) - BDrop/10 * (196.2), 0)
		ServerBullet.Velocity = Direction * BSpeed*3.571

		local SKP_05 = Instance.new('Attachment', ServerBullet)
		SKP_05.Position = Vector3.new(0.1, 0, 0)
		local SKP_06 = Instance.new('Attachment', ServerBullet)
		SKP_06.Position = Vector3.new(-0.1, 0, 0)


		if Tracer then			--and Visivel

			local At1 = Instance.new("Attachment")
			At1.Name = "At1"
			At1.Position = Vector3.new(-(.15),0,0)
			At1.Parent = ServerBullet

			local At2  = Instance.new("Attachment")
			At2.Name = "At2"
			At2.Position = Vector3.new((.15),0,0)
			At2.Parent = ServerBullet

			local Particles = Instance.new("Trail")
			Particles.Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 0);
				NumberSequenceKeypoint.new(1, 1);
			}
			)
			Particles.WidthScale = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 0.5);
				NumberSequenceKeypoint.new(0.25, 1);
				NumberSequenceKeypoint.new(0.75, 1);
				NumberSequenceKeypoint.new(1, 0.5);
			})

			Particles.Color = ColorSequence.new(TracerColor)
			Particles.Texture = "rbxassetid://232918622"
			Particles.TextureMode = Enum.TextureMode.Stretch

			Particles.FaceCamera = true
			Particles.LightEmission = .25
			Particles.Brightness = 20
			Particles.LightInfluence = 0
			Particles.Lifetime = .04
			--Particles.MaxLength = 25
			Particles.Attachment0 = At1
			Particles.Attachment1 = At2
			Particles.Parent = ServerBullet

			--if not third or not IsFreecam() then
			local bg = Instance.new("BillboardGui", ServerBullet)
			bg.Adornee = ServerBullet
			bg.Enabled = false
			local flashsize = math.random(15, 25)/10
			bg.Size = UDim2.new(flashsize, 0, flashsize, 0)
			bg.LightInfluence = 0
			bg.Brightness = 25
			local flash = Instance.new("ImageLabel", bg)
			flash.BackgroundTransparency = 1
			flash.Size = UDim2.new(1, 0, 1, 0)
			flash.Position = UDim2.new(0, 0, 0, 0)
			--flash.Image = "rbxassetid://18912813001"
			flash.Image = "rbxassetid://10822615828"
			flash.ImageTransparency = 0.15
			flash.ImageColor3 = TracerColor
			--end

			local TLight = Instance.new('PointLight',ServerBullet)
			TLight.Color = TracerColor
			TLight.Shadows = true
			TLight.Range = 9
			TLight.Brightness = 0.4

			task.defer(function()
				repeat
					RS.RenderStepped:Wait()
				until not ServerBullet or (ServerBullet.Position - camera.CFrame.Position).Magnitude > 10
				--Beam.Enabled = true
				ServerBullet.BillboardGui.Enabled = true
			end)

			if Settings.SpecialBullet ~= nil then
				local function fireSpecial(L_442_arg1)
					require(Engine.Modulos.handleSpecials).createSpecial(Character,Speedo,{
						ServerBullet,
						Player,
						Settings,
					});
				end;

				fireSpecial()
			end


			--	print("tracer ran")	

--[[local Particles = Instance.new("Trail")
	Particles.Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 0, 0);
				NumberSequenceKeypoint.new(1, 1);
			}
		)
	Particles.WidthScale = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 2, 0);
				NumberSequenceKeypoint.new(1, 1);
			}
		)

	if Settings.RainbowMode == true then
		Particles.Color = ColorSequence.new(RainbowModeCode)
	else
		Particles.Color = ColorSequence.new(Settings.TracerColor)
	end
	Particles.Texture = "rbxassetid://232918622"
	Particles.TextureMode = Enum.TextureMode.Stretch
	
	Particles.FaceCamera = true
	Particles.LightEmission = Settings.TracerLightEmission
	Particles.LightInfluence = Settings.TracerLightInfluence 
	Particles.Lifetime = Settings.TracerLifeTime
	Particles.Attachment0 = At1
	Particles.Attachment1 = At2
	Particles.Parent = Bullet
		]]

		end

		if BulletFlare then
			local SKP_08 = Instance.new("BillboardGui", ServerBullet)
			SKP_08.Adornee = ServerBullet
			local SKP_09 = math.random(375, 475)/10
			SKP_08.Size = UDim2.new(SKP_09, 0, SKP_09, 0)
			SKP_08.LightInfluence = 0
			local SKP_010 = Instance.new("ImageLabel", SKP_08)
			SKP_010.BackgroundTransparency = 1
			SKP_010.Size = UDim2.new(1, 0, 1, 0)
			SKP_010.Position = UDim2.new(0, 0, 0, 0)
			SKP_010.Image = "http://www.roblox.com/asset/?id=1047066405"
			SKP_010.ImageColor3 = BulletFlareColor

			SKP_010.ImageTransparency = math.random(2, 5)/15

			if ServerBullet:FindFirstChild("BillboardGui") ~= nil then
				ServerBullet.BillboardGui.Enabled = true
			end
		end

		local SKP_011 = {Player.Character,ServerBullet,ACS_Storage}
		while true do
			RS.Heartbeat:wait()
			local SKP_012 = Ray.new(ServerBullet.Position, ServerBullet.CFrame.LookVector*25)
			local SKP_013, SKP_014 = workspace:FindPartOnRayWithIgnoreList(SKP_012, SKP_011, false, true)
			if SKP_013 then
				game.Debris:AddItem(ServerBullet,0)
				break
			end
		end
		game.Debris:AddItem(ServerBullet,0)
		return ServerBullet
	end
end)

Human.StateChanged:connect(onStateChanged)

Evt.ACS_AI.AIBullet.OnClientEvent:Connect(function(SKP_arg1,SKP_arg3,SKP_arg4,SKP_arg5,SKP_arg6,SKP_arg7,SKP_arg8,SKP_arg9,SKP_arg10,SKP_arg11,SKP_arg12)
	if SKP_arg1 ~= Jogador then 
		local SKP_01 = SKP_arg3
		local SKP_02 = Instance.new("Part")
		SKP_02.Parent = workspace.ACS_WorkSpace.Server
		SKP_02.Name = "AI_Bullet"
		Debris:AddItem(SKP_02, 5)
		SKP_02.Shape = "Ball"
		SKP_02.Size = Vector3.new(1, 1, 1)
		SKP_02.CanCollide = false
		SKP_02.CFrame = SKP_01
		SKP_02.Transparency = 1

		local SKP_03 = SKP_02:GetMass()
		local SKP_04 = Instance.new('BodyForce', SKP_02)

		SKP_04.Force = Vector3.new(0,SKP_03 * (196.2) - SKP_arg5 * (196.2), 0)
		SKP_02.Velocity = SKP_arg7 * SKP_arg6

		local SKP_05 = Instance.new('Attachment', SKP_02)
		SKP_05.Position = Vector3.new(0.1, 0, 0)
		local SKP_06 = Instance.new('Attachment', SKP_02)
		SKP_06.Position = Vector3.new(-0.1, 0, 0)


		if SKP_arg4 then
			local SKP_07 = Instance.new('Trail', SKP_02)
			SKP_07.Attachment0 = SKP_05
			SKP_07.Attachment1 = SKP_06
			SKP_07.Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 0, 0);
				NumberSequenceKeypoint.new(1, 1);
			}
			)
			SKP_07.WidthScale = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 2, 0);
				NumberSequenceKeypoint.new(1, 0);
			}
			)
			SKP_07.Texture = "rbxassetid://232918622"
			SKP_07.TextureMode = Enum.TextureMode.Stretch
			SKP_07.LightEmission = 1
			SKP_07.Lifetime = 0.2
			SKP_07.FaceCamera = true
			SKP_07.Color = ColorSequence.new(SKP_arg8)
		end

		if SKP_arg10 then
			local SKP_08 = Instance.new("BillboardGui", SKP_02)
			SKP_08.Adornee = SKP_02
			local SKP_09 = math.random(375, 475)/10
			SKP_08.Size = UDim2.new(SKP_09, 0, SKP_09, 0)
			SKP_08.LightInfluence = 0
			local SKP_010 = Instance.new("ImageLabel", SKP_08)
			SKP_010.BackgroundTransparency = 1
			SKP_010.Size = UDim2.new(1, 0, 1, 0)
			SKP_010.Position = UDim2.new(0, 0, 0, 0)
			SKP_010.Image = "http://www.roblox.com/asset/?id=1047066405"
			SKP_010.ImageColor3 = SKP_arg11

			SKP_010.ImageTransparency = math.random(2, 5)/15

			if SKP_02:FindFirstChild("BillboardGui") ~= nil then
				SKP_02.BillboardGui.Enabled = true
			end
		end

		local SKP_011 = {SKP_02,workspace.ACS_WorkSpace}
		while true do
			RS.Heartbeat:wait()
			local SKP_012 = Ray.new(SKP_02.Position, SKP_02.CFrame.LookVector*25)
			local SKP_013, SKP_014 = workspace:FindPartOnRayWithIgnoreList(SKP_012, SKP_011, false, true)
			if SKP_013 then
				game.Debris:AddItem(SKP_02,0)
				break
			end
		end
		game.Debris:AddItem(SKP_02,0)
		return SKP_02
	end
end)

Evt.ACS_AI.AIShoot.OnClientEvent:Connect(function(Gun)

	for _, v in pairs(Gun.Muzzle:GetChildren()) do
		if (v.Name:sub(1, 7) == "FlashFX" or v.Name:find("Smoke")) and not v:IsA("Motor6D") then
			v.Enabled = true
		end
	end

	delay(1 / 30, function()

		for _, v in pairs(Gun.Muzzle:GetChildren()) do
			if (v.Name:sub(1, 7) == "FlashFX" or v.Name:find("Smoke")) and not v:IsA("Motor6D") then
				v.Enabled = false
			end
		end
	end)		

end)

----------------------------------------------------------------------------------------------
------------------------------------[TECLAS]--------------------------------------------------
----------------------------------------------------------------------------------------------

local Laserdebounce = false
local UIS = game:GetService("UserInputService")
guion = true
Mouse.KeyDown:connect(function(key)
	if (key == Enum.KeyCode.LeftAlt and UIS:IsKeyDown(Enum.KeyCode.V))  and Equipped and not Reloading or (key == "v" and UIS:IsKeyDown(Enum.KeyCode.LeftAlt)) and Equipped and not Reloading  then
		ts(Gui.FText,TweenInfo.new(1),{TextTransparency = 0,TextStrokeTransparency = .9, BackgroundTransparency = 0.5}):Play()
		delay(1,function()
			ts(Gui.FText,TweenInfo.new(1),{TextTransparency = 1,TextStrokeTransparency = 1, BackgroundTransparency = 1}):Play()
		end)
	elseif (key == Enum.KeyCode.LeftAlt and UIS:IsKeyDown(Enum.KeyCode.L)) or (key == "l" and UIS:IsKeyDown(Enum.KeyCode.LeftAlt)) then
		guion = not guion
		StatusClone.Enabled = guion
		--print("Main UI "..guion.."; press LeftAlt and ; to toggle")
	elseif (key == "v") and Equipped and Settings.FireModes.ChangeFiremode and not Reloading  then
		Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('SafetyClick'):Play()
		---Semi Settings---	
		ts(Gui.FText,TweenInfo.new(1),{TextTransparency = 0,TextStrokeTransparency = .9, BackgroundTransparency = 0.5}):Play()
		if Settings.Mode == "Semi" and Settings.FireModes.Burst == true then
			Gui.FText.Text = "Burst"
			Settings.Mode = "Burst"
		elseif Settings.Mode == "Semi" and Settings.FireModes.Burst == false and Settings.FireModes.Auto == true then
			Gui.FText.Text = "Full Auto"
			Settings.Mode = "Auto"
		elseif Settings.Mode == "Semi" and Settings.FireModes.Burst == false and Settings.FireModes.Auto == false and Settings.FireModes.Explosive == true then
			Gui.FText.Text = "Explosive"
			Settings.Mode = "Explosive"
			---Burst Settings---
		elseif Settings.Mode == "Burst" and Settings.FireModes.Auto == true then
			Gui.FText.Text = "Full Auto"
			Settings.Mode = "Auto"
		elseif Settings.Mode == "Burst" and Settings.FireModes.Explosive == true and Settings.FireModes.Auto == false then
			Gui.FText.Text = "Explosive"
			Settings.Mode = "Explosive"
		elseif Settings.Mode == "Burst" and Settings.FireModes.Semi == true and Settings.FireModes.Auto == false and Settings.FireModes.Explosive == false then
			Gui.FText.Text = "Single"
			Settings.Mode = "Semi"
			---Auto Settings---
		elseif Settings.Mode == "Auto" and Settings.FireModes.Explosive == true then
			Gui.FText.Text = "Explosive"
			Settings.Mode = "Explosive"
		elseif Settings.Mode == "Auto" and Settings.FireModes.Semi == true and Settings.FireModes.Explosive == false then
			Gui.FText.Text = "Single"
			Settings.Mode = "Semi"
		elseif Settings.Mode == "Auto" and Settings.FireModes.Semi == false and Settings.FireModes.Burst == true and Settings.FireModes.Explosive == false then
			Gui.FText.Text = "Burst"
			Settings.Mode = "Burst"
			---Explosive Settings---
		elseif Settings.Mode == "Explosive" and Settings.FireModes.Semi == true then
			Gui.FText.Text = "Single"
			Settings.Mode = "Semi"
		elseif Settings.Mode == "Explosive" and Settings.FireModes.Semi == false and Settings.FireModes.Burst == true  then
			Gui.FText.Text = "Burst"
			Settings.Mode = "Burst"
		elseif Settings.Mode == "Explosive" and Settings.FireModes.Semi == false and Settings.FireModes.Burst == false and Settings.FireModes.Auto == true then
			Gui.FText.Text = "Full Auto"
			Settings.Mode = "Auto"
		end
		Update_Gui()
		delay(2,function()
			ts(Gui.FText,TweenInfo.new(1),{TextTransparency = 1,TextStrokeTransparency = 1, BackgroundTransparency = 1}):Play()
		end)
		FiremodeAnim()
		Sprint()
	elseif (key == Enum.KeyCode.LeftAlt and UIS:IsKeyDown(Enum.KeyCode.T)) and Equipped and Settings.CanCheckMag and not Reloading and stance > -2 or (key == "t" and UIS:IsKeyDown(Enum.KeyCode.LeftAlt)) and Equipped and Settings.CanCheckMag and not Reloading and stance > -2 then
		MouseHeld = false
		Can_Shoot = false
		Reloading = true
		if Aiming == true then
			Aiming = false
		end
		CanAim = false
		if Safe then
			Safe = false
			stance = 0
			Evt.Stance:FireServer(stance,Settings,Anims,ArmaClone)
			IdleAnim()
			Update_Gui()
			--wait(.25)
		end
		CheckAnim()
		Sprint()			
		Update_Gui()		
		Can_Shoot = true
		CanAim = true
		Reloading = false
	elseif (key == "[") and Equipped then
		Gui.ZeText.TextTransparency = 0
		Gui.ZeText.TextStrokeTransparency = .9
		delay(1,function()
			ts(Gui.ZeText,TweenInfo.new(2),{TextTransparency = 1,TextStrokeTransparency = 1,BackgroundTransparency = 1}):Play()
		end)
		if Zeroing.Value > Zeroing.MinValue then
			Zeroing.Value = Zeroing.Value - 50
			--ArmaClone.Handle.Click:play()
			Update_Gui()
			--ts(Gui.ZeText,TweenInfo.new(2),{TextTransparency = 1,TextStrokeTransparency = 1}):Play()
		end

	elseif (key == "]" ) and Equipped then
		Gui.ZeText.TextTransparency = 0
		Gui.ZeText.TextStrokeTransparency = .9
		delay(1,function()
			ts(Gui.ZeText,TweenInfo.new(2),{TextTransparency = 1,TextStrokeTransparency = 1,BackgroundTransparency = 1}):Play()
		end)
		if Zeroing.Value < Zeroing.MaxValue then
			Zeroing.Value = Zeroing.Value + 50
			--ArmaClone.Handle.Click:play()
			Update_Gui()
			--ts(Gui.ZeText,TweenInfo.new(10),{TextTransparency = 1,TextStrokeTransparency = 1}):Play()
		end

	elseif (key == "r") and Equipped and stance > -2 then
		CancelReload = false
		if StoredAmmo.Value > 0  and Settings.Mode ~= "Explosive" and not Reloading and Settings.ReloadType == 1 then
			if Settings.IncludeChamberedBullet and Ammo.Value == Settings.Ammo + 1 or not Settings.IncludeChamberedBullet and Ammo.Value == Settings.Ammo and Chambered.Value == true then
				return
			end
			MouseHeld = false
			Can_Shoot = false
			Reloading = true
			if Aiming == true then
				Aiming = false
			end
			CanAim = false
			stance = 4
			Evt.Stance:FireServer(stance,Settings,Anims,ArmaClone)
			if Safe then
				Safe = false
				IdleAnim()
				Update_Gui()
				wait(.25)
			end
			tweenfov(FOV, 120)
			pcall(ReloadAnim)
			if Chambered.Value == false and slideback == true and Settings.FastReload == true then
				ChamberBKAnim()
			elseif Chambered.Value == false and slideback == false and Settings.FastReload == true then
				stance = 5
				Evt.Stance:FireServer(stance,Settings,Anims,ArmaClone)
				ChamberAnim()

			end
			Sprint()		
			Update_Gui()
			Can_Shoot = true
			CanAim = true
			Reloading = false

		elseif StoredAmmo.Value > 0  and Settings.Mode ~= "Explosive" and not Reloading and Settings.ReloadType == 2 then
			if Settings.IncludeChamberedBullet and Ammo.Value == Settings.Ammo + 1 or not Settings.IncludeChamberedBullet and Ammo.Value == Settings.Ammo and Chambered.Value == true or CancelReload then
				Sprint()
				Update_Gui()
				return
			end
			MouseHeld = false
			Can_Shoot = false
			Reloading = true	
			if Aiming == true then
				Aiming = false
			end
			CanAim = false
			if Safe then
				Safe = false
				stance = 0
				Evt.Stance:FireServer(stance)
				Sprint()
				Update_Gui()
				wait(.25)
			end
			for i = 1,Settings.Ammo - Ammo.Value do
				if StoredAmmo.Value > 0 and not CancelReload and Ammo.Value < Settings.Ammo and not AnimDebounce then
					pcall(ShellInsertAnim)
					wait(0.5)
				end
			end
			if Chambered.Value == false and slideback == true and Settings.FastReload == true then
				ChamberBKAnim()
			elseif Chambered.Value == false and slideback == false and Settings.FastReload == true then
				stance = 5
				Evt.Stance:FireServer(stance,Settings,Anims,ArmaClone)
				ChamberAnim()

			end
			Update_Gui()
			Sprint()
			CancelReload = false
			CanAim = true
			Can_Shoot = true
			Reloading = false

		elseif StoredAmmo.Value > 0  and Settings.Mode ~= "Explosive" and Reloading and Settings.ReloadType == 2 and AnimDebounce then
			if not CancelReload then
				CancelReload = true
				Sprint()
				Update_Gui()
				wait(.25)
			end
		elseif not Reloading and GLAmmo.Value > 0 and Settings.Mode == "Explosive"  and GLChambered.Value == false then
			MouseHeld = false
			Can_Shoot = false
			Reloading = true
			if Aiming == true then
				Aiming = false
			end
			CanAim = false
			tweenfov(FOV, 120)
			pcall(GLReloadAnim)
			GLChambered.Value = true
			Sprint()
			Update_Gui()
			Can_Shoot = true
			CanAim = true
			Reloading = false
		end

	elseif (key == Enum.KeyCode.LeftShift and UIS:IsKeyDown(Enum.KeyCode.T)) and Equipped and not Reloading and stance > -2  or (key == "f" and UIS:IsKeyDown(Enum.KeyCode.LeftAlt)) and Equipped and not Reloading and stance > -2 then
		MouseHeld = false
		Can_Shoot = false
		Reloading = true
		if Aiming == true then
			Aiming = false
		end
		CanAim = false
		if Safe then
			Safe = false
			stance = 0
			Evt.Stance:FireServer(stance,Settings,Anims,ArmaClone)
			IdleAnim()	
			Update_Gui()
		end
		Gui.CCText.TextTransparency = 0
		ChamberCheckAnim()
		ts(Gui.CCText,TweenInfo.new(2),{TextTransparency = 1}):Play()
		Sprint()
		Update_Gui()
		Can_Shoot = true
		CanAim = true
		Reloading = false

	elseif (key == "f") and Equipped and not Reloading and stance > -2 and (Emperrado.Value == true or Ammo.Value <= 0 or Settings.FastReload == false) then
		MouseHeld = false
		Can_Shoot = false
		Reloading = true
		if Aiming == true then
			Aiming = false
		end
		CanAim = false
		stance = 5
		Evt.Stance:FireServer(stance,Settings,Anims,ArmaClone)

		if Safe then
			Safe = false
			IdleAnim()
			Update_Gui()
			--wait(.25)
		end

		if not slideback then
			ChamberAnim()
		else
			ChamberBKAnim()
		end	
		Sprint()			
		Update_Gui()		
		Can_Shoot = true
		CanAim = true
		Reloading = false

	elseif (key == "h") and not UIS:IsKeyDown(Enum.KeyCode.LeftAlt) and Equipped and ArmaClone:FindFirstChild("LaserPoint") and not Reloading then


		if ServerConfig.RealisticLaser and ArmaClone.LaserPoint:FindFirstChild("IR") ~= nil then
			if not LaserAtivo and not IRmode then
				LaserAtivo = not LaserAtivo
				IRmode = not IRmode

				if LaserAtivo then
					for i,v in pairs(ArmaClone:GetChildren()) do
						if v.Name == "LaserPoint" then
							Evt.SVLaser:FireServer(Vector3.new(0,0,0),1,v.Color,ArmaClient)
							Pointer = Instance.new('Part')
							Pointer.Shape = 'Ball'
							Pointer.Size = Vector3.new(0.02, 0.02, 0.02)
							Pointer.Parent = v
							Pointer.CanCollide = false
							Pointer.CanTouch = false
							Pointer.CanQuery = false
							Pointer.Color = v.Color
							Pointer.Name = "Ignorable"
							Pointer.Material = Enum.Material.Neon
							laserglint = Instance.new("BillboardGui", Pointer)
							laserglint.Adornee = Pointer
							laserglint.Enabled = false
							laserglint.AlwaysOnTop = false
							laserglint.Size = UDim2.new(2, 0, 3, 0)
							laserglint.LightInfluence = 0
							local flash = Instance.new("ImageLabel", laserglint)
							flash.BackgroundTransparency = 1
							flash.ImageTransparency = 1
							flash.Size = UDim2.new(1, 0, 1, 0)
							flash.Position = UDim2.new(0, 0, 0, 0)
							flash.Image = "http://www.roblox.com/asset/?id=1047066405"
							flash.ImageColor3 = v.Color

							if v:FindFirstChild("IR") ~= nil then
								Pointer.Transparency = 1
								laserglint.Enabled = false
							end


							LaserSP = Instance.new('Attachment')
							LaserSP.Parent = v			

							LaserEP = Instance.new('Attachment')
							LaserEP.Parent = v

							Laser = Instance.new('Beam')
							Laser.Parent = ArmaClone.LaserPoint
							Laser.Transparency = NumberSequence.new(0)
							Laser.LightEmission = 1
							Laser.LightInfluence = 0
							Laser.Attachment0 = LaserSP
							Laser.Attachment1 = LaserEP
							Laser.Color = ColorSequence.new(v.Color,IRmode)
							Laser.FaceCamera = true
							Laser.Width0 = 0.01
							Laser.Width1 = 0.01

							if ServerConfig.RealisticLaser then
								Laser.Enabled = false
							end
						end
					end
				end


				if ArmaClone.LaserPoint:FindFirstChild("IR") ~= nil then
					Pointer.Transparency = 1
					laserglint.Enabled = false
				end

				LaserSP = Instance.new('Attachment')
				LaserSP.Parent = ArmaClone.LaserPoint				

				LaserEP = Instance.new('Attachment')
				LaserEP.Parent = ArmaClone.LaserPoint

				Laser = Instance.new('Beam')
				Laser.Parent = ArmaClone.LaserPoint
				Laser.Transparency = NumberSequence.new(0)
				Laser.LightEmission = 1
				Laser.LightInfluence = 0
				Laser.Attachment0 = LaserSP
				Laser.Attachment1 = LaserEP
				Laser.Color = ColorSequence.new(ArmaClone.LaserPoint.Color,IRmode)
				Laser.FaceCamera = true
				Laser.Width0 = 0.01
				Laser.Width1 = 0.01

				if ServerConfig.RealisticLaser then
					Laser.Enabled = false
				end


			else
				Evt.SVLaser:FireServer(Vector3.new(0,0,0),2,nil,ArmaClient,IRmode)
				Pointer:Destroy()
				LaserSP:Destroy()
				LaserEP:Destroy()
				Laser:Destroy()
			end

		elseif LaserAtivo and IRmode then
			IRmode = not IRmode
		elseif LaserAtivo and not IRmode then
			LaserAtivo = not LaserAtivo

			if LaserAtivo then
				for i,v in pairs(ArmaClone:GetChildren()) do
					if v.Name == "LaserPoint" then
						Evt.SVLaser:FireServer(Vector3.new(0,0,0),1,v.Color,ArmaClient)
						Pointer = Instance.new('Part')
						Pointer.Shape = 'Ball'
						Pointer.Size = Vector3.new(0.02, 0.02, 0.02)
						Pointer.Parent = v
						Pointer.CanCollide = false
						Pointer.CanTouch = false
						Pointer.CanQuery = false
						Pointer.Name = "Ignorable"
						Pointer.Color = v.Color
						Pointer.Material = Enum.Material.Neon
						laserglint = Instance.new("BillboardGui", Pointer)
						laserglint.Adornee = Pointer
						laserglint.Enabled = false
						laserglint.AlwaysOnTop = false
						laserglint.Size = UDim2.new(2, 0, 3, 0)
						laserglint.LightInfluence = 0
						local flash = Instance.new("ImageLabel", laserglint)
						flash.BackgroundTransparency = 1
						flash.ImageTransparency = 1
						flash.Size = UDim2.new(1, 0, 1, 0)
						flash.Position = UDim2.new(0, 0, 0, 0)
						flash.Image = "http://www.roblox.com/asset/?id=1047066405"
						flash.ImageColor3 = v.Color

						if v:FindFirstChild("IR") ~= nil then
							Pointer.Transparency = 1
							laserglint.Enabled = false
						end


						LaserSP = Instance.new('Attachment')
						LaserSP.Parent = v			

						LaserEP = Instance.new('Attachment')
						LaserEP.Parent = v

						Laser = Instance.new('Beam')
						Laser.Parent = ArmaClone.LaserPoint
						Laser.Transparency = NumberSequence.new(0)
						Laser.LightEmission = 1
						Laser.LightInfluence = 0
						Laser.Attachment0 = LaserSP
						Laser.Attachment1 = LaserEP
						Laser.Color = ColorSequence.new(v.Color,IRmode)
						Laser.FaceCamera = true
						Laser.Width0 = 0.01
						Laser.Width1 = 0.01

						if ServerConfig.RealisticLaser then
							Laser.Enabled = false
						end
					end
				end
			else
				Evt.SVLaser:FireServer(Vector3.new(0,0,0),2,nil,ArmaClient,IRmode)
				Pointer:Destroy()
				LaserSP:Destroy()
				LaserEP:Destroy()
				Laser:Destroy()
			end




		else
			LaserAtivo = not LaserAtivo

			if LaserAtivo then
				for i,v in pairs(ArmaClone:GetChildren()) do
					if v.Name == "LaserPoint" then
						Evt.SVLaser:FireServer(Vector3.new(0,0,0),1,v.Color,ArmaClient)
						Pointer = Instance.new('Part')
						Pointer.Shape = 'Ball'
						Pointer.Size = Vector3.new(0.02, 0.02, 0.02)
						Pointer.Parent = v
						Pointer.CanCollide = false
						Pointer.CanTouch = false
						Pointer.CanQuery = false
						Pointer.Color = v.Color
						Pointer.Name = "Ignorable"
						Pointer.Material = Enum.Material.Neon
						laserglint = Instance.new("BillboardGui", Pointer)
						laserglint.Adornee = Pointer
						laserglint.Enabled = false
						laserglint.AlwaysOnTop = false
						laserglint.Size = UDim2.new(2, 0, 3, 0)
						laserglint.LightInfluence = 0
						local flash = Instance.new("ImageLabel", laserglint)
						flash.BackgroundTransparency = 1
						flash.ImageTransparency = 1
						flash.Size = UDim2.new(1, 0, 1, 0)
						flash.Position = UDim2.new(0, 0, 0, 0)
						flash.Image = "http://www.roblox.com/asset/?id=1047066405"
						flash.ImageColor3 = v.Color

						if v:FindFirstChild("IR") ~= nil then
							Pointer.Transparency = 1
							laserglint.Enabled = false
						end


						LaserSP = Instance.new('Attachment')
						LaserSP.Parent = v			

						LaserEP = Instance.new('Attachment')
						LaserEP.Parent = v

						Laser = Instance.new('Beam')
						Laser.Parent = ArmaClone.LaserPoint
						Laser.Transparency = NumberSequence.new(0)
						Laser.LightEmission = 1
						Laser.LightInfluence = 0
						Laser.Attachment0 = LaserSP
						Laser.Attachment1 = LaserEP
						Laser.Color = ColorSequence.new(v.Color,IRmode)
						Laser.FaceCamera = true
						Laser.Width0 = 0.01
						Laser.Width1 = 0.01

						if ServerConfig.RealisticLaser then
							Laser.Enabled = false
						end
					end
				end
			else
				Evt.SVLaser:FireServer(Vector3.new(0,0,0),2,nil,ArmaClient,IRmode)
				Pointer:Destroy()
				LaserSP:Destroy()
				LaserEP:Destroy()
				Laser:Destroy()
			end

		end

		for _,v in pairs(ArmaClone:GetDescendants()) do
			if v:IsA("BasePart") and v.Name == 'GLaser' and key == (v:FindFirstChild('Key') and (v.Key.Value or "h")) and not Reloading and not AnimDebounce then
				v.Enabled.Value = not v.Enabled.Value
				for _,g in pairs(v:GetDescendants()) do
					if g:IsA('SpotLight') or v:IsA('PointLight') or v:IsA('SurfaceLight') then
						g.Enabled = v.Enabled.Value
					end
				end
				game.ReplicatedStorage:WaitForChild('ACS_Engine'):WaitForChild('Eventos'):WaitForChild('SetLight'):FireServer(ArmaClone.Name,key,v.Enabled.Value)
			end
		end
		Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('LaserOn'):Play()
		FiremodeAnim()



	elseif (key == "w" and UIS:IsKeyDown(Enum.KeyCode.LeftAlt) or (key == Enum.KeyCode.LeftAlt and UIS:IsKeyDown(Enum.KeyCode.W))) and Equipped and not Reloading and stance > -2 then
		blindfire = not blindfire
		--Character.Humanoid.WalkSpeed = 0
		if blindfire then
			Safe = false
			bmode = 1
			stance = 8
			Evt.Stance:FireServer(stance,Settings,Anims,ArmaClone)
			BlindFireOver()
			--Character.Humanoid.WalkSpeed = 14
			Update_Gui()
		else
			bmode = 0
			stance = 0
			Evt.Stance:FireServer(stance,Settings,Anims,ArmaClone)
			IdleAnim()
			--Character.Humanoid.WalkSpeed = 14
			Update_Gui()
		end

	elseif (key == "s" and UIS:IsKeyDown(Enum.KeyCode.LeftAlt) or (key == Enum.KeyCode.LeftAlt and UIS:IsKeyDown(Enum.KeyCode.s))) and Equipped and not Reloading and stance > -2 then
		blindfire = not blindfire
		--Character.Humanoid.WalkSpeed = 0
		if blindfire then
			Safe = false
			bmode = 2
			stance = 9
			Evt.Stance:FireServer(stance,Settings,Anims,ArmaClone)
			BlindFireRight()
			--Character.Humanoid.WalkSpeed = 14
			Update_Gui()
		else
			bmode = 0
			stance = 0
			Evt.Stance:FireServer(stance,Settings,Anims,ArmaClone)
			IdleAnim()
			--Character.Humanoid.WalkSpeed = 14
			Update_Gui()
		end

	--[[elseif UIS:IsKeyDown(Enum.KeyCode.Backquote) and Equipped and stance > -2 then
		inventory = not inventory
		--Character.Humanoid.WalkSpeed = 0
		if inventory then
			MouseHeld = false
			Can_Shoot = false
			Reloading = true
			if Aiming == true then
				Aiming = false
			end
			CanAim = false
			Safe = false
			bmode = 1
			stance = 12
			Evt.Stance:FireServer(stance,Settings,Anims,ArmaClone)
			Inventory()
			-- oldwalkspeed = Character.Saude.Stances.Mobility.Value
			-- Character.Saude.Stances.Mobility.Value = 0
			--Character.Humanoid.WalkSpeed = 14
			Update_Gui()
		else
			CanAim = true
			Can_Shoot = true
			Reloading = false
			bmode = 0
			stance = 0
			Evt.Stance:FireServer(stance,Settings,Anims,ArmaClone)
			IdleAnim()
			-- Character.Saude.Stances.Mobility.Value = oldwalkspeed
			--Character.Humanoid.WalkSpeed = 14
			Update_Gui()
		end--]]
	elseif (key == "b" and UIS:IsKeyDown(Enum.KeyCode.LeftAlt) or (key == Enum.KeyCode.LeftAlt and UIS:IsKeyDown(Enum.KeyCode.b))) and Equipped and not Reloading and stance > -2 then
		blindfire = not blindfire
		--Character.Humanoid.WalkSpeed = 0
		if blindfire then
			Safe = false
			bmode = 3
			stance = 11
			Evt.Stance:FireServer(stance,Settings,Anims,ArmaClone)
			LeftHandShoulder()
			--Character.Humanoid.WalkSpeed = 14
			Update_Gui()
		else
			bmode = 0
			stance = 0
			Evt.Stance:FireServer(stance,Settings,Anims,ArmaClone)
			IdleAnim()
			--Character.Humanoid.WalkSpeed = 14
			Update_Gui()
		end
	elseif (key == "y") and Equipped and not Reloading and stance > -2 then
		MouseHeld = false
		Can_Shoot = false
		Reloading = true
		if Aiming == true then
			Aiming = false
		end
		CanAim = false
		if Safe then
			Safe = false
			stance = 7
			Evt.Stance:FireServer(stance,Settings,ContextAnims,ArmaClone)
			IdleAnim()	
			Update_Gui()
		end
		stance = 7
		Evt.Stance:FireServer(stance,Settings,ContextAnims,ArmaClone)
		CheckWatch()
		Sprint()
		Update_Gui()
		Can_Shoot = true
		CanAim = true
		Reloading = false
		stance = 0
		Evt.Stance:FireServer(stance,Settings,Anims,ArmaClone)




	elseif (key == "x") and Equipped and not Reloading and stance > -2 and playerstance < 2 and CanProne then
		MouseHeld = false
		Can_Shoot = false
		Reloading = true
		playerstance = 2
		if Safe then
			Safe = false
			stance = 0
			Evt.Stance:FireServer(stance,Settings,Anims,ArmaClone,false)
			IdleAnim()	
			Update_Gui()
		end
		ProneDownAnim()
		Sprint()
		Update_Gui()
		Can_Shoot = true
		Reloading = false

	elseif (key == "x") and Equipped and not Reloading and stance > -2 and playerstance == 2 and CanProne then
		MouseHeld = false
		Can_Shoot = false
		Reloading = true
		playerstance = 0
		if Safe then
			Safe = false
			stance = 0
			Evt.Stance:FireServer(stance,Settings,Anims,ArmaClone)
			IdleAnim()	
			Update_Gui()
		end
		ProneUpAnim()
		Sprint()
		Update_Gui()
		Can_Shoot = true
		Reloading = false

	elseif (key == "l") and Equipped and not Reloading and stance > -2 then
		MouseHeld = false
		Can_Shoot = false
		Reloading = true
		if Aiming == true then
			Aiming = false
		end
		CanAim = false
		if Safe then
			Safe = false
			stance = 0
			Evt.Stance:FireServer(stance,Settings,ContextAnims,ArmaClone)
			IdleAnim()	
			Update_Gui()
		end
		stance = 0
		Evt.Stance:FireServer(stance,Settings,ContextAnims,ArmaClone)
		ts(game.Lighting.DOF,TweenInfo.new(.3),{FocusDistance = 0}):Play()
		ts(game.Lighting.DOF,TweenInfo.new(.3),{InFocusRadius = 2}):Play()
		InspectAnim()
		Sprint()
		ts(game.Lighting.DOF,TweenInfo.new(.3),{FocusDistance = 200}):Play()
		ts(game.Lighting.DOF,TweenInfo.new(.3),{InFocusRadius = 8}):Play()
		Update_Gui()
		Can_Shoot = true
		CanAim = true
		Reloading = false
		stance = 0
		Evt.Stance:FireServer(stance,Settings,Anims,ArmaClone)


	elseif (key == "j") and not UIS:IsKeyDown(Enum.KeyCode.LeftAlt) and Equipped and ArmaClone:FindFirstChild("FlashPoint") and not Reloading then

		LanternaAtiva = not LanternaAtiva
		if LanternaAtiva then
			Evt.SVFlash:FireServer(true,ArmaClient,ArmaClone.FlashPoint.Light.Angle,ArmaClone.FlashPoint.Light.Brightness,ArmaClone.FlashPoint.Light.Color,ArmaClone.FlashPoint.Light.Range)
			--ArmaClone.FlashPoint.Light.Enabled = true
		else
			Evt.SVFlash:FireServer(false,ArmaClient,ArmaClone.FlashPoint.Light.Angle,ArmaClone.FlashPoint.Light.Brightness,ArmaClone.FlashPoint.Light.Color,ArmaClone.FlashPoint.Light.Range)
			-- ArmaClone.FlashPoint.Light.Enabled = false
		end
		for _,v in pairs(ArmaClone:GetChildren()) do
			if v.Name == 'GLaser' and key == (v:FindFirstChild('Key') and v.Key.Value or "j") and not Reloading and not AnimDebounce then
				v.Enabled.Value = not v.Enabled.Value
				game.ReplicatedStorage:WaitForChild('ACS_Engine'):WaitForChild('Eventos'):WaitForChild('SetLight'):FireServer(ArmaClone.Name,key,v.Enabled.Value)
				for _,g in pairs(v:GetDescendants()) do
					if g:IsA('SpotLight') or v:IsA('PointLight') or v:IsA('SurfaceLight') then
						g.Enabled = v.Enabled.Value
						if v:FindFirstChild("Strobe") then
							while wait(0.1) do
								--wait(0.1)
								v.Enabled.Value = not v.Enabled.Value
								ArmaClone.FlashPoint.Beam.Enabled = v.Enabled.Value
								--wait(0.1)
							end
						end
					end
				end
				--game.ReplicatedStorage:WaitForChild('ACS_Engine'):WaitForChild('Eventos'):WaitForChild('SetLight'):FireServer(ArmaClone.Name,key,v.Enabled.Value)
			end
		end
		Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('FlashOn'):Play()
		FiremodeAnim()
	--[[elseif (key == "u") and Equipped and ArmaClone:FindFirstChild("Silenciador") then
		Silencer.Value = not Silencer.Value
		ArmaClone.Handle.Click:play()
		if Silencer.Value == true then
			for i,v in pairs(ArmaClone:GetChildren()) do
				if v.Name == "Silenciador" then
					v.Transparency = 0
				end
			end
			ArmaClone.SmokePart.FlashFX.Brightness = 0
			ArmaClone.SmokePart.FlashFX2.Brightness = 0
			ArmaClone.SmokePart:FindFirstChild("FlashFX[Flash]").Rate = 0
			if ArmaClone.SmokePart:FindFirstChild("FlashFX[Lens]") then
				ArmaClone.SmokePart:FindFirstChild("FlashFX[Lens]").Rate = 0
			end
			if ArmaClone.SmokePart:FindFirstChild("FlashFX[Lens]1") then
				ArmaClone.SmokePart:FindFirstChild("FlashFX[Lens]1").FaceCamera = false
			end
			if ArmaClone.SmokePart:FindFirstChild("FlashFX[Lens]2") then
				ArmaClone.SmokePart:FindFirstChild("FlashFX[Lens]2").FaceCamera = false
			end
			if ArmaClone.SmokePart:FindFirstChild("FlashFX[Lens]3") then
				ArmaClone.SmokePart:FindFirstChild("FlashFX[Lens]3").FaceCamera = false
			end
			if ArmaClone.SmokePart:FindFirstChild("FlashFX[Lens]4") then
				ArmaClone.SmokePart:FindFirstChild("FlashFX[Lens]4").FaceCamera = false
			end
			ArmaClone.SmokePart:FindFirstChild("FlashFX[Particles]").Rate = 3

			for i,v in pairs(ArmaClone.SmokePart:GetChildren()) do
				if v.Name:find("Fire") and v:IsA('ParticleEmitter') then
					v.Rate = 0
				end
			end

			Evt.SilencerEquip:FireServer(ArmaClient,Silencer.Value)

		else
			for i,v in pairs(ArmaClone:GetChildren()) do
				if v.Name == "Silenciador" then
					v.Transparency = 1
				end
			end
			ArmaClone.SmokePart.FlashFX.Brightness = 5
			ArmaClone.SmokePart.FlashFX2.Brightness = 5
			ArmaClone.SmokePart:FindFirstChild("FlashFX[Flash]").Rate = 10
			if ArmaClone.SmokePart:FindFirstChild("FlashFX[Lens]") then
				ArmaClone.SmokePart:FindFirstChild("FlashFX[Lens]").Rate = 33
			end
			if ArmaClone.SmokePart:FindFirstChild("FlashFX[Lens]1") then
				ArmaClone.SmokePart:FindFirstChild("FlashFX[Lens]1").FaceCamera = true
			end
			if ArmaClone.SmokePart:FindFirstChild("FlashFX[Lens]2") then
				ArmaClone.SmokePart:FindFirstChild("FlashFX[Lens]2").FaceCamera = false
			end
			if ArmaClone.SmokePart:FindFirstChild("FlashFX[Lens]3") then
				ArmaClone.SmokePart:FindFirstChild("FlashFX[Lens]3").FaceCamera = true
			end
			if ArmaClone.SmokePart:FindFirstChild("FlashFX[Lens]4") then
				ArmaClone.SmokePart:FindFirstChild("FlashFX[Lens]4").FaceCamera = false
			end
			ArmaClone.SmokePart:FindFirstChild("FlashFX[Particles]").Rate = 175
			for i,v in pairs(ArmaClone.SmokePart:GetChildren()) do
				if v.Name:find("Fire") and v:IsA('ParticleEmitter') then
					v.Rate = 50
				end
			end
			Evt.SilencerEquip:FireServer(ArmaClient,Silencer.Value)

		end ]]--

		--REMOVED DUE TO MODDING SYSTEM

	elseif (key == "b") and Equipped and BipodEnabled and ArmaClone:FindFirstChild("BipodPoint") and not Reloading and not AnimDebounce  then
		Bipod = not Bipod
		if Bipod == true then
			if ArmaClone.BipodPoint:FindFirstChild("BipodDeploy") ~= nil then
				Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('BipodDeploy'):Play()
				BipodAnimUnFold()
			end
		else
			if ArmaClone.BipodPoint:FindFirstChild("BipodRetract") ~= nil then
				Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):WaitForChild('BipodRetract'):Play()
				BipodAnimFold()
			end
		end

	elseif (key == "n") and Laserdebounce == false then
		local sound1
		local sound2
		if Player.Character then
			local helmet = Player.Character:FindFirstChild("Helmet")
			local helmet2 = Player.Character:FindFirstChild("Accessory4")
			if Player.PlayerGui:FindFirstChild("NVG") then
				local sounds = Player.PlayerGui.NVG.Sounds
				sound1 = sounds.On
				sound2 = sounds.Off
				if Player.Character:WaitForChild("Head") and Player.Character:WaitForChild("Head"):FindFirstChild(sound1) == nil and Player.Character:WaitForChild("Head"):FindFirstChild(sound2) == nil then
					sound1:Clone().Parent = Player.Character:WaitForChild("Head")
					sound2:Clone().Parent = Player.Character:WaitForChild("Head")
				end
			else
				sound1 = Player.Character:WaitForChild("Head"):WaitForChild("On")
				sound1 = Player.Character:WaitForChild("Head"):WaitForChild("Off")
			end
			local nvg
			if helmet or helmet2 then
				nvg = helmet:FindFirstChild("Up")
			elseif Player.PlayerGui:FindFirstChild("NVG") then
				nvg = nil
			end
			if nvg ~= nil or Player.PlayerGui:FindFirstChild("NVG") then
				Laserdebounce = true
				if Equipped and not Reloading and stance > -2 then
					MouseHeld = false
					Can_Shoot = false
					Reloading = true
					if Safe then
						Safe = false
						stance = 0
						Evt.Stance:FireServer(stance,Settings,Anims,ArmaClone)
						IdleAnim()	
						Update_Gui()
					end
					if Player.PlayerGui:FindFirstChild("NVG") then
						if Player.PlayerGui.NVG.NVG.Value == false then
							NVGAnim()
							if sound1 ~= nil then
								sound1:Play()
							end
						elseif Player.PlayerGui.NVG.NVG.Value == true then
							NVGAnim2()
							if sound2 ~= nil then
								sound2:Play()
							end
						end
					else
						if NVG == false then
							NVGAnim()
							if sound1 ~= nil then
								sound1:Play()
							end
						elseif NVG == true then
							NVGAnim2()
							if sound2 ~= nil then
								sound2:Play()
							end
						end

					end
					Sprint()
					Update_Gui()
					Can_Shoot = true
					Reloading = false
				end
				delay(.8,function()
					NVG = not NVG 

					if Aiming and ArmaClone.AimPart:FindFirstChild("NVAim") ~= nil then
						if NVG then
							tweenfov(FOV,120)
							ts(StatusClone.Efeitos.Aim,TweenInfo.new(.3),{ImageTransparency = 1}):Play()
						else
							if AimPartMode == 1 then
								tweenfov(Settings.ChangeFOV[1],120)
								if Settings.FocusOnSight then
									ts(StatusClone.Efeitos.Aim,TweenInfo.new(.75),{ImageTransparency = 0}):Play()
								else
									ts(StatusClone.Efeitos.Aim,TweenInfo.new(.3),{ImageTransparency = 1}):Play()
								end
							elseif AimPartMode == 2 then
								tweenfov(Settings.ChangeFOV[2],120)
								if Settings.FocusOnSight2 then
									ts(StatusClone.Efeitos.Aim,TweenInfo.new(.75),{ImageTransparency = 0}):Play()
								else
									ts(StatusClone.Efeitos.Aim,TweenInfo.new(.3),{ImageTransparency = 1}):Play()
								end
							end
						end
					end	
					Laserdebounce = false		
				end)

			end
			--end
		end
	elseif (key == "u") and Equipped and stance > -2 and ArmaClone:FindFirstChild("Nodes") then
		MouseHeld = false
		Can_Shoot = false
		Reloading = true
		attachanim = not attachanim
		if attachanim then
			Safe = true
			stance = 6
			Evt.Stance:FireServer(stance,Settings,Anims,ArmaClone)
			ts(game.Lighting.DOF,TweenInfo.new(.3),{FocusDistance = 0}):Play()
			ts(game.Lighting.DOF,TweenInfo.new(.3),{InFocusRadius = 2}):Play()
			AttachAnim()	
			Update_Gui()
			for L_380_forvar1, L_381_forvar2 in pairs(ArmaClone.Nodes:GetChildren()) do
				if L_381_forvar2 then
					local L_382_ = Engine.FX.NodeyNode:Clone()
					L_382_.Title.Text = string.upper(L_381_forvar2.Name)
					L_382_.Parent = L_381_forvar2
				end
			end

			if Engine:FindFirstChild('Attachments') then
				Gui.Parent:WaitForChild('AttachmentFrame').Visible = true
				Gui.Parent:WaitForChild('AttachmentFrame').FLM.Visible = true
				Gui.Parent:WaitForChild('InteractionMouse').Visible = true
				Gui.Parent:WaitForChild('InteractionMouse').Icon.Visible = true

				for L_384_forvar1, L_385_forvar2 in pairs(Gui.Parent:WaitForChild('AttachmentFrame'):GetChildren()) do
					if L_385_forvar2:IsA('TextButton') and L_385_forvar2.Name ~= "FLM" then
						L_385_forvar2:Destroy()
					end
				end

				for L_386_forvar1, L_387_forvar2 in pairs(Engine.Attachments:GetChildren()) do
					if L_387_forvar2:IsA('Model') and L_387_forvar2.PrimaryPart then
						local L_388_ = Gui.Parent:WaitForChild('Template'):WaitForChild('TextButton'):clone()
						L_388_.Parent = Gui.Parent:WaitForChild('AttachmentFrame')
						L_388_.Visible = true
						L_388_.Text = L_387_forvar2.Name
						L_388_.Name = L_387_forvar2.Name

						L_388_.MouseButton1Click:connect(function()
							local L_389_ = L_387_forvar2:clone()
							local L_390_ = ArmaClone.Nodes:FindFirstChild(L_387_forvar2.PrimaryPart.Name)

							if L_390_:WaitForChild('Cur').Value then
								L_390_.Cur.Value:Destroy()
							end


							L_389_:SetPrimaryPartCFrame(L_390_.CFrame)

							L_390_:WaitForChild('Cur').Value = L_389_
							for L_391_forvar1, L_392_forvar2 in pairs(L_389_:GetChildren()) do
								Ultil.Weld(L_392_forvar2, ArmaClone:WaitForChild("Handle"))
							end		

							for L_393_forvar1, L_394_forvar2 in pairs(L_389_:GetChildren()) do
								L_394_forvar2.Anchored = false
								L_394_forvar2.CanCollide = false
							end	

							L_389_.Parent = ArmaClone
							if L_389_:FindFirstChild("AimPart") then
								ArmaClone:WaitForChild("AimPart"):Destroy()
								L_389_:FindFirstChild("AimPart").Parent = ArmaClone
							end
							if L_389_:FindFirstChild("GLaser") then
								L_389_:FindFirstChild("GLaser").Parent = ArmaClone
							end
							if L_389_:FindFirstChild("LaserPoint") then
								L_389_:FindFirstChild("LaserPoint").Parent = ArmaClone
							end
							if L_389_:FindFirstChild("FlashPoint") then
								L_389_:FindFirstChild("FlashPoint").Parent = ArmaClone
							end
						end)
					end
				end;
			end
		else
			for L_395_forvar1, L_396_forvar2 in pairs(ArmaClone:WaitForChild('Nodes'):GetDescendants()) do
				if L_396_forvar2:IsA('BillboardGui') and L_396_forvar2.Name == 'NodeyNode' then
					L_396_forvar2:Destroy()
				end
			end

			for L_397_forvar1, L_398_forvar2 in pairs(Gui.Parent:WaitForChild('AttachmentFrame'):GetChildren()) do
				if L_398_forvar2:IsA('TextButton') and L_398_forvar2.Name ~= "FLM" then
					L_398_forvar2:Destroy()
				end
			end

			Gui.Parent:WaitForChild('AttachmentFrame').Visible = false
			Gui.Parent:WaitForChild('InteractionMouse').Visible = false
			Gui.Parent:WaitForChild('InteractionMouse').Icon.Visible = false
			Gui.Parent:WaitForChild('AttachmentFrame').FLM.Visible = false
			Safe = false
			stance = 0
			Evt.Stance:FireServer(stance,Settings,Anims,ArmaClone)
			ts(game.Lighting.DOF,TweenInfo.new(.3),{FocusDistance = 200}):Play()
			ts(game.Lighting.DOF,TweenInfo.new(.3),{InFocusRadius = 8}):Play()
			IdleAnim()
			Update_Gui()
			Can_Shoot = true
			Reloading = false
		end
	end
end)


-- Agony Code

function ForceProne()
	if Equipped then
		MouseHeld = false
		Can_Shoot = false
		Reloading = true
		playerstance = 2
		if Safe then
			Safe = false
			stance = 0
			Evt.Stance:FireServer(stance,Settings,Anims,ArmaClone)
			IdleAnim()	
			Update_Gui()
		end
		ProneDownAnim()
		Sprint()
		Update_Gui()
	else
		MouseHeld = false
		Can_Shoot = false
		Reloading = true
		playerstance = 2
		if Safe then
			Safe = false
			stance = 0
			Evt.Stance:FireServer(stance,Settings,Anims,ArmaClone)
			Update_Gui()
		end
		Sprint()
		Update_Gui()
	end
end

Engine.Eventos.GrenadeAgony.OnClientEvent:Connect(function()
	local AgonyBlur = game.Lighting.AgonyBlur
	local AgonyColor = game.Lighting.AgonyColor
	AgonyBlur.Enabled = true
	AgonyBlur.Size = 0
	AgonyColor.Enabled = true

	CanProne = false

	ForceProne()

	Saude.Variaveis.Stamina.Value = 0
	Saude.Variaveis.ArmStamina.Value = 0

	Engine.Eventos.AgonyVoiceline:FireServer()

	ts(AgonyBlur,TweenInfo.new(1,Enum.EasingStyle.Sine,Enum.EasingDirection.Out,0,false,0),{Size = 56}):Play()
	ts(AgonyColor,TweenInfo.new(0.4,Enum.EasingStyle.Sine,Enum.EasingDirection.Out,0,false,0),{Brightness = -0.3, Contrast = -0.4, Saturation = -1}):Play()
	task.wait(2)
	ts(AgonyBlur,TweenInfo.new(1,Enum.EasingStyle.Sine,Enum.EasingDirection.Out,0,false,0),{Size = 24}):Play()
end)

--//Client Anims
--local Speedo

function IdleAnim(L_442_arg1)
	if blindfire then
		if bmode == 1 then
			stance = 8
			Evt.Stance:FireServer(stance,Settings,Anims,ArmaClone)
			ContextAnims.BlindFireOver(Character, Speedo, {
				AnimBaseW,
				RA,
				LA,
				AnimBase.GripW,
				ArmaClone,
				Settings,
				Left_Weld,
				Right_Weld,
			});
		elseif bmode == 2 then
			stance = 9
			Evt.Stance:FireServer(stance,Settings,Anims,ArmaClone)
			ContextAnims.BlindFireRight(Character, Speedo, {
				AnimBaseW,
				RA,
				LA,
				AnimBase.GripW,
				ArmaClone,
				Settings,
				Left_Weld,
				Right_Weld,
			});
		elseif bmode == 3 then
			stance = 11
			Evt.Stance:FireServer(stance,Settings,Anims,ArmaClone)
			ContextAnims.LeftHandShoulder(Character, Speedo, {
				AnimBaseW,
				RA,
				LA,
				AnimBase.GripW,
				ArmaClone,
				Settings,
				Left_Weld,
				Right_Weld,
			});
		elseif bmode == 4 then
			stance = 12
			Evt.Stance:FireServer(stance,Settings,Anims,ArmaClone)
			ContextAnims.Inventory(Character, Speedo, {
				AnimBaseW,
				RA,
				LA,
				AnimBase.GripW,
				ArmaClone,
				Settings,
				Left_Weld,
				Right_Weld,
			});
		end
	else
		stance = 0
		Evt.Stance:FireServer(stance,Settings,Anims,ArmaClone)
		Anims.IdleAnim(Character, Speedo, {
			AnimBaseW,
			RA,
			LA,
			AnimBase.GripW,
			ArmaClone,
			Left_Weld,
			Right_Weld,
		});
	end
end;

function StanceDown(L_442_arg1)
	Anims.StanceDown(Character, Speedo, {
		AnimBaseW,
		RA,
		LA,
		AnimBase.GripW,
		ArmaClone,
		Left_Weld,
		Right_Weld,
	});
end;

function StanceUp(L_442_arg1)
	Anims.StanceUp(Character, Speedo, {
		AnimBaseW,
		RA,
		LA,
		AnimBase.GripW,
		ArmaClone,
		Left_Weld,
		Right_Weld,
	});
end;

function Patrol(L_442_arg1)
	Anims.Patrol(Character, Speedo, {
		AnimBaseW,
		RA,
		LA,
		AnimBase.GripW,
		ArmaClone,
		Left_Weld,
		Right_Weld,
	});
end;

function SprintAnim(L_442_arg1)
	Anims.SprintAnim(Character, Speedo, {
		AnimBaseW,
		RA,
		LA,
		AnimBase.GripW,
		ArmaClone,
		Left_Weld,
		Right_Weld,
	});
end;

function EquipAnim(L_442_arg1)
	AnimDebounce = true
	Can_Shoot = false
	CanAim = false
	Reloading = true
	Anims.EquipAnim(Character, Speedo, {
		AnimBaseW,
		RA,
		LA,
		AnimBase.GripW,
		ArmaClone,
		Left_Weld,
		Right_Weld,
	});
	if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild("Draw") then
		Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild("Draw"):Play()
	end
	Reloading = false
	Can_Shoot = true
	CanAim = true
	AnimDebounce = false
end;

function FireAnim()
	if Anims.FireAnim then
		AnimDebounce = true
		Anims.FireAnim(Character, 0, {
			AnimBaseW,
			RA,
			LA,
			AnimBase.GripW,
			ArmaClone,
			StoredAmmo,
			Ammo,
			Settings,
			Chambered,
			Left_Weld,
			Right_Weld,
		});
		if Anims.ServerFireAnim then
			stance = 10
			Evt.Stance:FireServer(stance,Settings,Anims)
			stance = 0
		end
		AnimDebounce = false
	end
end

function ChamberAnim(L_442_arg1)
	AnimDebounce = true
	if Var:FindFirstChild("ServerAnimations") then
		ReplicateClient.AnimHandler:Fire(true,"ChamberAnim",L_199_,"S"..ArmaClone.Name)
	end
	Anims.ChamberAnim(Character, Speedo, {
		AnimBaseW,
		RA,
		LA,
		AnimBase.GripW,
		ArmaClone,
		Settings,
		Right_Weld,
		Left_Weld,
	});
	if Emperrado.Value == true then
		--StatusClone.WarningGlow.ImageColor3 = Color3.fromRGB(190, 231, 19)
		--ts(StatusClone.WarningGlow,TweenInfo.new(0.45,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,3,true),{ImageTransparency = 0.5}):Play()
	end
	if Ammo.Value > 0 and Chambered.Value ==true and Emperrado.Value == true then
		Emperrado.Value = false
		if ArmaClone and ArmaClone:FindFirstChild("ShellClone") then
			ArmaClone:FindFirstChild("ShellClone"):Destroy()
		end
		EjectShells()
	elseif Ammo.Value > 0 and Chambered.Value == true and Emperrado.Value == false then
		Ammo.Value = Ammo.Value - 1
		EjectShells()
	end
	slideback = false
	if Ammo.Value > 0 then
		Chambered.Value = true
	end
	delay(0.01, function()
		if Ammo.Value > 0 and Chambered.Value ==true and Emperrado.Value == true then
			if ArmaClone and ArmaClone:FindFirstChild("ShellClone") then
				ArmaClone:FindFirstChild("ShellClone"):Destroy()
			end
			EjectShells()
			delay(0.01, function()
				Emperrado.Value = false
			end)
		end
		slideback = false
		if Ammo.Value > 0 then
			Chambered.Value = true
		end
	end)
	AnimDebounce = false
end;

function ZoomAnim(L_442_arg1)
	if Var:FindFirstChild("ServerAnimations") then
		ReplicateClient.AnimHandler:Fire(true,"ZoomAnim",L_199_,"S"..ArmaClone.Name)
	end
	Anims.ZoomAnim(Character, Speedo, {
		AnimBaseW,
		RA,
		LA,
		AnimBase.GripW,
		ArmaClone,
		Settings,
		Left_Weld,
		Right_Weld,
	});
end;

function UnZoomAnim(L_442_arg1)
	if Var:FindFirstChild("ServerAnimations") then
		ReplicateClient.AnimHandler:Fire(true,"UnZoomAnim",L_199_,"S"..ArmaClone.Name)
	end
	Anims.UnZoomAnim(Character, Speedo, {
		AnimBaseW,
		RA,
		LA,
		AnimBase.GripW,
		ArmaClone,
		Settings,
		Left_Weld,
		Right_Weld,
	});
end;

function FiremodeAnim(L_442_arg1)
	AnimDebounce = true
	Anims.FiremodeAnim(Character, Speedo, {
		AnimBaseW,
		RA,
		LA,
		AnimBase.GripW,
		ArmaClone,
		Settings,
		Left_Weld,
		Right_Weld,
	});
	AnimDebounce = false
end;

function ChamberCheckAnim(L_442_arg1)
	AnimDebounce = true
	if Var:FindFirstChild("ServerAnimations") then
		ReplicateClient.AnimHandler:Fire(true,"ChamberCheckAnim",L_199_,"S"..ArmaClone.Name)
	end
	Anims.ChamberCheckAnim(Character, Speedo, {
		AnimBaseW,
		RA,
		LA,
		AnimBase.GripW,
		ArmaClone,
		Settings,
		Left_Weld,
		Right_Weld,
	});
	AnimDebounce = false
end;

function DoorAnim(L_442_arg1)
	AnimDebounce = true
	ContextAnims.DoorAnim(Character, Speedo, {
		AnimBaseW,
		RA,
		LA,
		AnimBase.GripW,
		ArmaClone,
		Settings,
		Left_Weld,
		Right_Weld,
	});
	AnimDebounce = false
end;


function DoorAnim3(L_442_arg1)
	AnimDebounce = true
	ContextAnims.DoorAnim3(Character, Speedo, {
		AnimBaseW,
		RA,
		LA,
		AnimBase.GripW,
		ArmaClone,
		Settings,
		Left_Weld,
		Right_Weld,
	});
	AnimDebounce = false
end;

function NVGAnim(L_442_arg1)
	AnimDebounce = true
	ContextAnims.NVGAnim(Character, Speedo, {
		AnimBaseW,
		RA,
		LA,
		AnimBase.GripW,
		ArmaClone,
		Settings,
		Left_Weld,
		Right_Weld,
	});
	AnimDebounce = false
end;

function PointAnim(L_442_arg1)
	AnimDebounce = true
	ContextAnims.PointAnim(Character, Speedo, {
		AnimBaseW,
		RA,
		LA,
		AnimBase.GripW,
		ArmaClone,
		Settings,
		Left_Weld,
		Right_Weld,
	});
	AnimDebounce = false
end;

function NVGAnim2(L_442_arg1)
	AnimDebounce = true
	ContextAnims.NVGAnim2(Character, Speedo, {
		AnimBaseW,
		RA,
		LA,
		AnimBase.GripW,
		ArmaClone,
		Settings,
		Left_Weld,
		Right_Weld,
	});
	AnimDebounce = false
end;

function BipodAnimUnFold(L_442_arg1)
	AnimDebounce = true
	if Var:FindFirstChild("ServerAnimations") then
		ReplicateClient.AnimHandler:Fire(true,"BipodAnimUnFold",L_199_,"S"..ArmaClone.Name)
	end
	if Anims.BipodAnimUnFold then
		Anims.BipodAnimUnFold(Character, Speedo, {
			AnimBaseW,
			RA,
			LA,
			AnimBase.GripW,
			ArmaClone,
			Settings,
			Left_Weld,
			Right_Weld,
		});
	end
	AnimDebounce = false
end;

function BipodAnimFold(L_442_arg1)
	AnimDebounce = true
	if Var:FindFirstChild("ServerAnimations") then
		ReplicateClient.AnimHandler:Fire(true,"BipodAnimFold",L_199_,"S"..ArmaClone.Name)
	end
	if Anims.BipodAnimFold then
		Anims.BipodAnimFold(Character, Speedo, {
			AnimBaseW,
			RA,
			LA,
			AnimBase.GripW,
			ArmaClone,
			Settings,
			Left_Weld,
			Right_Weld,
		});
	end
	AnimDebounce = false
end;

function InspectAnim(L_442_arg1)
	AnimDebounce = true
	if Var:FindFirstChild("ServerAnimations") then
		ReplicateClient.AnimHandler:Fire(true,"InspectAnim",L_199_,"S"..ArmaClone.Name)
	end
	if Anims.InspectAnim == nil then
		ContextAnims.InspectAnim(Character, Speedo, {
			AnimBaseW,
			RA,
			LA,
			AnimBase.GripW,
			ArmaClone,
			Settings,
			Left_Weld,
			Right_Weld,
		});
	elseif Anims.InspectAnim ~= nil then
		Anims.InspectAnim(Character, Speedo, {
			AnimBaseW,
			RA,
			LA,
			AnimBase.GripW,
			ArmaClone,
			Settings,
			Left_Weld,
			Right_Weld,
		});
	end
	AnimDebounce = false
end;

function GrenadeReady()
	AnimDebounce = true
	Anims.GrenadeReady(Character, Speedo, {
		AnimBaseW,
		RA,
		LA,
		AnimBase.GripW,
		ArmaClone,
		Settings,
		Left_Weld,
		Right_Weld,
	});
	AnimDebounce = false
end

function GrenadeThrow()
	AnimDebounce = true
	Anims.GrenadeThrow(Character, Speedo, {
		AnimBaseW,
		RA,
		LA,
		AnimBase.GripW,
		ArmaClone,
		Settings,
		Left_Weld,
		Right_Weld,
	});
	AnimDebounce = false
end

function AttachAnim(L_442_arg1)
	AnimDebounce = true
	if Anims.AttachAnim == nil then
		ContextAnims.AttachAnim(Character, Speedo, {
			AnimBaseW,
			RA,
			LA,
			AnimBase.GripW,
			ArmaClone,
			Settings,
			Left_Weld,
			Right_Weld,
		});
	elseif Anims.AttachAnim ~= nil then
		Anims.AttachAnim(Character, Speedo, {
			AnimBaseW,
			RA,
			LA,
			AnimBase.GripW,
			ArmaClone,
			Settings,
			Left_Weld,
			Right_Weld,
		});
	end
	AnimDebounce = false
end;

function CheckWatch(L_442_arg1)
	AnimDebounce = true
	ContextAnims.CheckWatch(Character, Speedo, {
		AnimBaseW,
		RA,
		LA,
		AnimBase.GripW,
		ArmaClone,
		Settings,
		Left_Weld,
		Right_Weld,
	});
	AnimDebounce = false
end;

function BlindFireRight(L_442_arg1)
	AnimDebounce = true
	ContextAnims.BlindFireRight(Character, Speedo, {
		AnimBaseW,
		RA,
		LA,
		AnimBase.GripW,
		ArmaClone,
		Settings,
		Left_Weld,
		Right_Weld,
	});
	AnimDebounce = false
end;

function BlindFireOver(L_442_arg1)
	AnimDebounce = true
	ContextAnims.BlindFireOver(Character, Speedo, {
		AnimBaseW,
		RA,
		LA,
		AnimBase.GripW,
		ArmaClone,
		Settings,
		Left_Weld,
		Right_Weld,
	});
	AnimDebounce = false
end;

function LeftHandShoulder(L_442_arg1)
	AnimDebounce = true
	ContextAnims.LeftHandShoulder(Character, Speedo, {
		AnimBaseW,
		RA,
		LA,
		AnimBase.GripW,
		ArmaClone,
		Settings,
		Left_Weld,
		Right_Weld,
	});
	AnimDebounce = false
end;

function Inventory(L_442_arg1)
	AnimDebounce = true
	ContextAnims.Inventory(Character, Speedo, {
		AnimBaseW,
		RA,
		LA,
		AnimBase.GripW,
		ArmaClone,
		Settings,
		Left_Weld,
		Right_Weld,
	});
	AnimDebounce = false
end;

function ProneDownAnim(L_442_arg1)
	AnimDebounce = true
	ContextAnims.ProneDownAnim(Character, Speedo, {
		AnimBaseW,
		RA,
		LA,
		AnimBase.GripW,
		ArmaClone,
		Settings,
		Left_Weld,
		Right_Weld,
	});
	AnimDebounce = false
end;

function ProneUpAnim(L_442_arg1)
	AnimDebounce = true
	ContextAnims.ProneUpAnim(Character, Speedo, {
		AnimBaseW,
		RA,
		LA,
		AnimBase.GripW,
		ArmaClone,
		Settings,
		Left_Weld,
		Right_Weld,
	});
	AnimDebounce = false
end;


function UnequipAnim(L_442_arg1)
	AnimDebounce = true
	ContextAnims.UnequipAnim(Character, Speedo, {
		AnimBaseW,
		RA,
		LA,
		AnimBase.GripW,
		ArmaClone,
		Settings,
		Left_Weld,
		Right_Weld,
	});
	AnimDebounce = false
end;

function ChamberBKAnim(L_442_arg1)
	AnimDebounce = true
	if Var:FindFirstChild("ServerAnimations") then
		ReplicateClient.AnimHandler:Fire(true,"ChamberBKAnim",L_199_,"S"..ArmaClone.Name)
	end
	Anims.ChamberBKAnim(Character, Speedo, {
		AnimBaseW,
		RA,
		LA,
		AnimBase.GripW,
		ArmaClone,
		Settings,
		Left_Weld,
		Right_Weld,
	});
	slideback = false
	if Ammo.Value > 0 then
		Chambered.Value = true
	end
	AnimDebounce = false
end;

function CheckAnim(L_442_arg1)
	AnimDebounce = true
	if Var:FindFirstChild("ServerAnimations") then
		ReplicateClient.AnimHandler:Fire(true,"CheckAnim",L_199_,"S"..ArmaClone.Name)
	end
	CheckMagFunction()
	Anims.CheckAnim(Character, Speedo, {
		AnimBaseW,
		RA,
		LA,
		AnimBase.GripW,
		ArmaClone,
		StoredAmmo,
		Ammo,
		Settings,
		Chambered,
		Left_Weld,
		Right_Weld,
	});
	AnimDebounce = false
end;

function ShellInsertAnim(L_442_arg1)
	shellsound =  PastaFX.ShellInsert:GetChildren()
	Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild('ShellInsert').SoundId = shellsound[math.random(#shellsound)].SoundId
	AnimDebounce = true
	if Var:FindFirstChild("ServerAnimations") then
		ReplicateClient.AnimHandler:Fire(true,"ShellInsertAnim",L_199_,"S"..ArmaClone.Name)
	end
	Anims.ShellInsertAnim(Character, Speedo, {
		AnimBaseW,
		RA,
		LA,
		AnimBase.GripW,
		ArmaClone,
		StoredAmmo,
		Ammo,
		Settings,
		Chambered,
		Left_Weld,
		Right_Weld,
	});
	Evt.Recarregar:FireServer(StoredAmmo.Value,ArmaClient)
	AnimDebounce = false
end;

function ReloadAnim(L_442_arg1)
	AnimDebounce = true
	Can_Shoot = false
	CanAim = false
	Reloading = true
	Anims.ReloadAnim(Character, Speedo, {
		AnimBaseW,
		RA,
		LA,
		AnimBase.GripW,
		ArmaClone,
		StoredAmmo,
		Ammo,
		Settings,
		Chambered,
		Left_Weld,
		Right_Weld,
	});

	if Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild("Draw") then
		Character:WaitForChild('S'.. ArmaClone.Name):WaitForChild('Grip'):FindFirstChild("Draw"):Play()
	end
	Reloading = false
	Can_Shoot = true
	CanAim = true
	AnimDebounce = false
end;

function GLReloadAnim(L_442_arg1)
	AnimDebounce = true
	if Var:FindFirstChild("ServerAnimations") then
		ReplicateClient.AnimHandler:Fire(true,"GLReloadAnim",L_199_,"S"..ArmaClone.Name)
	end
	Anims.GLReloadAnim(Character, Speedo, {
		AnimBaseW,
		RA,
		LA,
		AnimBase.GripW,
		ArmaClone,
		StoredAmmo,
		Ammo,
		Settings,
		Chambered,
		Left_Weld,
		Right_Weld,
	});
	Evt.Recarregar:FireServer(StoredAmmo.Value,ArmaClient)
	AnimDebounce = false
end;

------------------------------------------------------------
--\Doors Update
------------------------------------------------------------
local DoorsFolder = ACS_Storage:FindFirstChild("Doors")
local DoorHeld = false
local mDistance = 5
local Key = nil

function getNearest()
	local nearest = nil
	local minDistance = mDistance
	local Character = Player.Character or Player.CharacterAdded:Wait()

	for I,Door in pairs (DoorsFolder:GetChildren()) do
		if Door:FindFirstChild("knob") ~= nil and Character:FindFirstChild("Torso") ~= nil then
			local distance = (Door.knob.Position - Character:FindFirstChild("Torso").Position).magnitude

			if distance < minDistance then
				nearest = Door
				minDistance = distance
			end
		end
	end
	--print(nearest)
	return nearest
end

--[[function Interact(actionName, inputState, inputObj)
	if inputState ~= Enum.UserInputState.Begin then return end
	
	local nearestDoor = getNearest()
	local Character = Player.Character or Player.CharacterAdded:Wait()
	
	if nearestDoor == nil then return end
	
	if Character:FindFirstChild("Torso") ~= nil and (nearestDoor.knob.Position - Character:FindFirstChild("Torso").Position).magnitude <= mDistance then
		if nearestDoor ~= nil then
			if nearestDoor:FindFirstChild("RequiresKey") then
				Key = nearestDoor.RequiresKey.Value
				
			else
				Key = nil
			end
			Evt.DoorEvent:FireServer(nearestDoor,1,Key)
			
			
		end
	end
end]]--

function Open1(actionName, inputState, inputObj)
	--	if inputState ~= Enum.UserInputState.Begin then return end

	local nearestDoor = getNearest()
	local Character = Player.Character or Player.CharacterAdded:Wait()

	if nearestDoor == nil then return end
	function DoorAnim2(L_442_arg1)
		AnimDebounce = true
		ContextAnims.DoorAnim2(Character, Speedo, {
			AnimBaseW,
			RA,
			LA,
			AnimBase.GripW,
			ArmaClone,
			Settings,
			Left_Weld,
			Right_Weld,
			nearestDoor,
		});
		AnimDebounce = false
	end;
	function DoorAnim4(L_442_arg1)
		AnimDebounce = true
		ContextAnims.DoorAnim4(Character, Speedo, {
			AnimBaseW,
			RA,
			LA,
			AnimBase.GripW,
			ArmaClone,
			Settings,
			Left_Weld,
			Right_Weld,
			nearestDoor,
		});
		AnimDebounce = false
	end;
	if (nearestDoor.knob.Position - Character.Torso.Position).magnitude <= mDistance then
		if nearestDoor:FindFirstChild("RequiresKey") then
			Key = nearestDoor.RequiresKey.Value
		else
			Key = nil
		end


		if inputState == Enum.UserInputState.Begin then
			print("interact held")
			DoorHeld = true
			print(DoorHeld)
		elseif inputState ~= Enum.UserInputState.Begin then
			print("interact released")
			DoorHeld = false
			print(DoorHeld)

			local Anim = Instance.new('Animation')
			Anim.AnimationId = 'rbxassetid://80611260663198' --5102959774
			local PlayAnim = Character.Humanoid:LoadAnimation(Anim)

			if Equipped and not Reloading and stance > -2 and nearestDoor:FindFirstChild("Locked").Value == false then
				MouseHeld = false
				Can_Shoot = false
				Reloading = true
				if Aiming == true then
					Aiming = false
				end
				if Safe then
					Safe = false
					stance = 0
					Evt.Stance:FireServer(stance,Settings,Anims,ArmaClone)
					IdleAnim()	
					Update_Gui()
				end
				DoorAnim()
				Sprint()
				Update_Gui()
				Can_Shoot = true
				Reloading = false
			elseif Equipped and not Reloading and stance > -2 and nearestDoor:FindFirstChild("Locked").Value == true and nearestDoor:FindFirstChild("KeycardDoor") == nil and Character:FindFirstChild(Key) ~= nil or Player.Backpack:FindFirstChild(Key) ~= nil then
				MouseHeld = false
				Can_Shoot = false
				Reloading = true
				if Aiming == true then
					Aiming = false
				end
				CanAim = false
				Character.Humanoid.WalkSpeed = 0
				if Safe then
					Safe = false
					stance = 0
					Evt.Stance:FireServer(stance,Settings,Anims,ArmaClone)
					IdleAnim()	
					Update_Gui()
				end
				DoorAnim2()
				Sprint()
				Update_Gui()
				Can_Shoot = true
				CanAim = true
				Reloading = false
				Character.Humanoid.WalkSpeed = 14
			elseif Equipped and not Reloading and stance > -2 and nearestDoor:FindFirstChild("Locked").Value == true and nearestDoor:FindFirstChild("KeycardDoor").Value == true and Character:FindFirstChild(Key) ~= nil or Player.Backpack:FindFirstChild(Key) ~= nil then
				MouseHeld = false
				Can_Shoot = false
				Reloading = true
				if Aiming == true then
					Aiming = false
				end
				CanAim = false
				Character.Humanoid.WalkSpeed = 0
				if Safe then
					Safe = false
					stance = 0
					Evt.Stance:FireServer(stance,Settings,Anims,ArmaClone)
					IdleAnim()	
					Update_Gui()
				end
				DoorAnim4()
				Sprint()
				Update_Gui()
				Can_Shoot = true
				Reloading = false
				CanAim = true
				Character.Humanoid.WalkSpeed = 14
			end
			nearestDoor:FindFirstChild("knob").InteractSound:Play()
			Evt.DoorEvent:FireServer(nearestDoor,1,Key)
		end
	end
end



Mouse.WheelForward:connect(function(actionName, inputState, inputObj)
	local nearestDoor = getNearest()
	local Character = Player.Character or Player.CharacterAdded:Wait()

	if DoorHeld and nearestDoor:FindFirstChild("Locked").Value == false then
		print("mouse forward")
		if Equipped and not Reloading and stance > -2 then
			MouseHeld = false
			Can_Shoot = false
			Reloading = true
			if Aiming == true then
				Aiming = false
			end
			CanAim = false
			if Safe then
				Safe = false
				stance = 0
				Evt.Stance:FireServer(stance,Settings,Anims,ArmaClone)
				IdleAnim()	
				Update_Gui()
			end
			DoorAnim()
			Sprint()
			Update_Gui()
			Can_Shoot = true
			CanAim = true
			Reloading = false
		end
		Evt.DoorEvent:FireServer(nearestDoor,5,Key)
	end
end)

Mouse.WheelBackward:connect(function(actionName, inputState, inputObj)
	local nearestDoor = getNearest()
	local Character = Player.Character or Player.CharacterAdded:Wait()

	if DoorHeld and nearestDoor:FindFirstChild("Locked").Value == false then
		print("mouse backward")
		if Equipped and not Reloading and stance > -2 then
			MouseHeld = false
			Can_Shoot = false
			Reloading = true
			if Aiming == true then
				Aiming = false
			end
			CanAim = false
			if Safe then
				Safe = false
				stance = 0
				Evt.Stance:FireServer(stance,Settings,Anims,ArmaClone)
				IdleAnim()	
				Update_Gui()
			end
			DoorAnim()
			Sprint()
			Update_Gui()
			Can_Shoot = true
			CanAim = true
			Reloading = false
		end
		Evt.DoorEvent:FireServer(nearestDoor,6,Key)
	end
end)

function Open2(actionName, inputState, inputObj)
	if inputState ~= Enum.UserInputState.Begin then return end

	local nearestDoor = getNearest()
	--	local Character = Player.Character or Player.CharacterAdded:Wait()

	if nearestDoor == nil then return end

	if (nearestDoor.knob.Position - Character.Torso.Position).magnitude <= mDistance then
		if nearestDoor ~= nil then
			if nearestDoor:FindFirstChild("RequiresKey") then
				Key = nearestDoor.RequiresKey.Value
			else
				Key = nil
			end
			Character.Humanoid.WalkSpeed = 0
			local Anim = Instance.new('Animation')
			Anim.AnimationId = 'rbxassetid://80611260663198' --5102959774
			local PlayAnim = Character.Humanoid:LoadAnimation(Anim)
			--			local PlayAnim = Character.Humanoid:LoadAnimation(Anim)

			PlayAnim:GetMarkerReachedSignal("hitdoor"):Connect(function()
				print("reached keyframe, kicking...")
				Evt.DoorEvent:FireServer(nearestDoor,2,Key)
			end)

			Character.Humanoid.WalkSpeed = 0
			PlayAnim:Play()
			if Equipped and not Reloading and stance > -2 then
				MouseHeld = false
				Can_Shoot = false
				Reloading = true
				if Aiming == true then
					Aiming = false
				end
				CanAim = false
				--if Safe then
				--Safe = false
				stance = -2
				Evt.Stance:FireServer(stance,Settings,Anims,ArmaClone)
				--IdleAnim()	
				Update_Gui()
				--end
				DoorAnim3()
				Sprint()
				if Safe then
					Safe = false
					IdleAnim()
				end
				stance = 0
				Evt.Stance:FireServer(stance,Settings,Anims,ArmaClone)
				Update_Gui()
				Can_Shoot = true
				CanAim = true
				Reloading = false
			end
			-- PlayAnim:Stop()	
			Character.Humanoid.WalkSpeed = 14
		end
	end
end
function GetNearest(parts, maxDistance,Part)
	local closestPart
	local minDistance = maxDistance
	for _, partToFace in ipairs(parts) do
		local distance = (Part.Position - partToFace.Position).magnitude
		if distance < minDistance then
			closestPart = partToFace
			minDistance = distance
		end
	end
	return closestPart
end
local found = false
local cooldown = 5
local canThrow = true
function QuickGrenade()
	--[[local nearestDoor = getNearest()
	if nearestDoor ~= nil then return end]]--
	if ((Equipped and not Reloading and stance > -2) or (not Equipped)) and canThrow then
		--canThrow = false
		for i,v in pairs(Player.Backpack:GetChildren()) do
			if found == false and v:IsA("Tool") and v:FindFirstChild("IsGrenade") and canThrow then
				canThrow = false
				found = true
				Character.Humanoid:UnequipTools()
				--Unset()
				if Character:FindFirstChildOfClass("Tool") == nil then
					Character.Humanoid:EquipTool(v)
					--v.Config.Velocity.Value = 200
				end
				wait(1)
				found = false
			--[[if v:FindFirstChild("Remote") then
				local lp = game.Players.LocalPlayer
				local ms = lp:GetMouse()
				v.Remote:FireServer(ms.Hit)
			end]]--
			end
		end
		wait(cooldown)
		canThrow = true
	end
end

--CAS:BindAction("Interact", Interact, false, Enum.KeyCode.G)
--CAS:BindAction("Open1", Open1, false, Enum.KeyCode.G)
--CAS:BindAction("Open2", Open2, false, Enum.KeyCode.K)
CAS:BindActionAtPriority("QuickGrenade", QuickGrenade,false,50,Enum.KeyCode.G)
CAS:BindActionAtPriority("Open1", Open1,false,49,Enum.KeyCode.M)
CAS:BindActionAtPriority("Open2", Open2,false,49,Enum.KeyCode.K)

print("Thank you <3")
print("-mizmii")

-- This is the 2025 version of Kitsune Engine made by v_suzuki/mizmii for Dark Horizon

-- Thank you to everyone who contributed in our time of using this engine, and thank you to all of our
-- community members for supporting DH for the past 4 years <3

-- After this release, Kitsune will be retired from DH for an indefinite time and replaced with a completely
-- new and custom engine.



--[[ I've really learned a lot throughout my time working on this engine. I think a lot of the reason
	I'm actually successful right now is really because of Kitsune and DH.

	I know the code is sloppy, rushed, old, buggy, etc. but I put passion into it. I wasn't expecting to have
	such a big community nor was I expecting to be able to accomplish as much as I have, but I'm grateful for it.
	
	Even without being the lead developer (probably almost owner now) of this engine & game, this engine always
	had some sort of influence on my development over the past.. I dunno, 4 years?
	
	My first real project, EXFIL, literally started out as one of those free model dump ACS games.
	I've definitely come a long way. A long, long way.
	
	I love this game. I love my community, my friends, the developers I work alongside or lead. It's hard to put
	into words what I feel, honestly.
	
	A good way to put it is that I feel grateful.
	
	Anyways, sorry for putting another 15 lines into your already massive clientside handling script.
	
	
	
	Thank you, everyone. Thank you for supporting me and my journey throughout these year(s).
	- Mizmii
]]

-- also we put dev comments on stuff a lot LMAO, go find them