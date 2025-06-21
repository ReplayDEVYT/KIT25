local Warp = require(game:GetService("ReplicatedStorage").Warp);


-- events
local ProjectileNetcode = {
	ServerBullet = Warp.Server("Bullet"),
	BulletHit = Warp.Server("BulletHit"),  
	-- FiringServer = Warp.Server("Firing") < REMOVED DUE TO BUFFER ERRORS
}

local ReplicationNetcode = {
	AnimHandler = Warp.Server("Anim"),
	Damage = Warp.Server("Damage")
}

local EffectsReplication = {
	Metabolism = Warp.Server("Metabolism")
}

EffectsReplication.Metabolism:Connect(function(p, hydration, energy)
	print("player ate/drank something, adding values")
	if p:FindFirstChild("hungerVal") ~= nil and p:FindFirstChild("thirstVal") ~= nil then
		p.thirstVal.Value += hydration
		p.hungerVal.Value += energy
	end
end)

local Engine = game.ReplicatedStorage:WaitForChild("ACS_Engine")
local Evt = Engine:WaitForChild("Eventos")
local Mod = Engine:WaitForChild("Modulos")
local GunModels = Engine:WaitForChild("GunModels")
local GunModelClient = GunModels:WaitForChild("Client")
local GunModelServer = GunModels:WaitForChild("Server")
local Ultil = require(Mod:WaitForChild("Utilities"))
local ServerConfig = require(Engine.ServerConfigs:WaitForChild("Config"))
local SSS = game:GetService("ServerScriptService")
local BreakModule = require(SSS:WaitForChild("PartFractureModule"))
local Players = game.Players
local ACS_Storage = workspace:WaitForChild("ACS_WorkSpace")
local Armah
local laststance = 0
local Debris = game:GetService("Debris")
deb = false
yah = true
local Left_Weld, Right_Weld,RA,LA,RightS,LeftS,HeadBase,HW,HW2
local AnimBase,AnimBaseW,NeckWlocal RS2 = game:GetService("ReplicatedStorage")
local Voicelines = RS2.Voicelines
local RS = game:GetService("RunService")
--local list = require(game.ServerScriptService.Nametags.List)
local Explosion = Engine.FX.Explosions
local close = Explosion.Close:GetChildren()
local distant = Explosion.Distant:GetChildren()
local far = Explosion.Far:GetChildren()
shattersfx = Engine.Shatter:GetChildren()
--add ur own bullet holes id or if your experienced enough you can add material detecting stuff
local ServerStorage = game:GetService("ServerStorage")
local DoorsFolder = ACS_Storage:FindFirstChild("Doors")
local DoorsFolderClone = DoorsFolder:Clone()
local LightClone = ACS_Storage.Lights:Clone()
local MinesClone = ACS_Storage.Mines:Clone()
local BreachClone = ACS_Storage.Breach:Clone()
local breaches = {6891729500}
BreachClone.Parent = ServerStorage
DoorsFolderClone.Parent = ServerStorage
LightClone.Parent = ServerStorage
MinesClone.Parent = ServerStorage
CAnims = require(Engine.Modulos.ContextAnimations)

HttpService 	= game:GetService("HttpService")
ACS_0 	= HttpService:GenerateGUID(true)

local PhysicsService = game:GetService("PhysicsService")

PhysicsService:CreateCollisionGroup("GlassParts")
PhysicsService:CollisionGroupSetCollidable("GlassParts", "GlassParts", false)
PhysicsService:CollisionGroupsAreCollidable("GlassParts", "GlassParts", false)
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

local yes = workspace.PermaDeath.Toggle.Value
local yes2 = workspace.ExtractSystem.MainConfig.Values.RaidTimer.Value
deb1 = false
deb2 = false
local BulletModel =  ACS_Storage.Server
local DataStore = game:GetService("DataStoreService")



game.Players.PlayerAdded:connect(function(SKP_001)
	local Player = SKP_001
	SKP_001.CharacterAppearanceLoaded:Connect(function(SKP_002)

		for SKP_003, SKP_004 in pairs(Engine.Essential:GetChildren()) do
			if SKP_004 then
				local SKP_005 = SKP_004:clone()
				SKP_005.Parent = SKP_001.PlayerGui
				SKP_005.Disabled = false
			end
		end

		if SKP_001.Character:FindFirstChild('Head') then
			Evt.TeamTag:FireAllClients(SKP_001, SKP_002)
		end
		SKP_002.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
		if SKP_002:FindFirstChild("Health") and SKP_002:FindFirstChild("Health"):IsA("Script") then
			SKP_002.Health:Destroy()
		end
	end)

	SKP_001.Changed:connect(function()
		Evt.TeamTag:FireAllClients(SKP_001)
	end)
	SKP_001.Chatted:Connect(function(msg)
		if SKP_001.Team.Name == "REUNION" then
			sounds = script.ReunionSounds[math.random(#script.ReunionSounds:GetChildren())]
		else
			sounds = script.Sounds[math.random(#script.Sounds:GetChildren())]
		end
		id=sounds.SoundId --Sound ID
		if not deb then
			--deb=true
			local sound=Instance.new("Sound")
			sound.Parent = SKP_001.Character:WaitForChild("Head")
			sound.SoundId=id
			sound.Pitch=1
			sound.Volume=0.2
			sound.RollOffMaxDistance = 150
			SKP_001.Character:WaitForChild("Head"):AddTag("3DSoundEmitter")
			sound:Play()
			game.Debris:AddItem(sound,sound.TimeLength+1)
			deb=false
		end
		if Player.Name == "00scorpion00" or Player.Name == "v_suzuki" or Player.Name == "Whatwasnixie" or Player.Name == "RabbIe_rouser" or Player.Name == "doot_theskeleton" or Player.Name == "centralcommandguy" or Player.Name == "missinginaction_yt" then
			if string.lower(msg) == "regenstuff" then
				DoorsFolder:ClearAllChildren()
				ACS_Storage.Breach:ClearAllChildren()
				ACS_Storage.Lights:ClearAllChildren()
				ACS_Storage.Mines:ClearAllChildren()

				local Doors = DoorsFolderClone:Clone()
				local Breaches = BreachClone:Clone()
				local Lights = LightClone:Clone()
				local Mines = MinesClone:Clone()

				for Index,Door in pairs (Doors:GetChildren()) do
					Door.Parent = DoorsFolder
				end

				for Index,Door in pairs (Breaches:GetChildren()) do
					Door.Parent = ACS_Storage.Breach
				end
				for Index,Door in pairs (Lights:GetChildren()) do
					Door.Parent = ACS_Storage.Lights
				end
				for Index,Door in pairs (Mines:GetChildren()) do
					Door.Parent = ACS_Storage.Mines
				end

				Breaches:Destroy()
				Doors:Destroy()
				Lights:Destroy()
				Mines:Destroy()
			end
		end
		local char = SKP_001.Character or SKP_001.CharacterAdded:Wait()
		local humanoid = char:WaitForChild("Humanoid")
		if char and humanoid and humanoid:GetState() ~= Enum.HumanoidStateType.Dead then
			for i,v in pairs(Voicelines:GetChildren()) do
				--[V][O][I][C][E][L][I][N][E]--
				if msg:lower():find(v.Name:lower()) and char.PrimaryPart:FindFirstChild("Voice") == nil then
					local line = v:Clone()
					line.Parent = char.PrimaryPart
					line.Name = "Voice"
					char.PrimaryPart:AddTag("3DSoundEmitter")
					line:Play()
					game:GetService("Debris"):AddItem(line, line.TimeLength+1)
				elseif msg:lower():find("cancel") and char.PrimaryPart:FindFirstChild("Voice") then
					char.PrimaryPart:FindFirstChild("Voice"):Destroy()
				elseif msg:lower():find("toggledeath") and (SKP_001.Name == "v_suzuki" or SKP_001.Name == "Whatwasnixie" or SKP_001.Name == "anija") and deb2 == false  then
					deb2 = true
					yes = not yes
					print("PERMADEATH: "..tostring(yes))
					workspace.PermaDeath.Toggle.Value = yes
					delay(1,function()
						deb2 = false
					end)
				elseif msg:lower():find("toggletimer") and (SKP_001.Name == "v_suzuki" or SKP_001.Name == "Whatwasnixie" or SKP_001.Name == "anija") and deb2 == false  then
					deb2 = true
					yes2 = not yes2
					print("Time Limit: "..tostring(yes2))
					workspace.ExtractSystem.MainConfig.Values.RaidTimer.Value = yes2
					delay(1,function()
						deb2 = false
					end)
					--[M][U][S][I][C]--
				elseif msg:lower():find("togglemusic") and (SKP_001.Name == "v_suzuki" or SKP_001.Name == "Whatwasnixie") and deb1 == false then
					deb1 = true
					yah = not yah
					print("MUSIC: "..tostring(yah))
					workspace.scripts.ambience.music.Playing = yah
					delay(1,function()
						deb1 = false
					end)
				elseif msg:lower():find("music rebelpath") and (SKP_001.Name == "v_suzuki" or SKP_001.Name == "Whatwasnixie") then
					workspace.scripts.ambience.music.SoundId = "rbxassetid://6198390708"
					workspace.scripts.ambience.music.TimePosition = 0
				elseif msg:lower():find("music metro") and (SKP_001.Name == "v_suzuki" or SKP_001.Name == "Whatwasnixie") then
					workspace.scripts.ambience.music.SoundId = "rbxassetid://4616306408"
					workspace.scripts.ambience.music.TimePosition = 0
				elseif msg:lower():find("music darkrage") and (SKP_001.Name == "v_suzuki" or SKP_001.Name == "Whatwasnixie") then
					workspace.scripts.ambience.music.SoundId = "rbxassetid://6218934257"
					workspace.scripts.ambience.music.TimePosition = 0
				elseif msg:lower():find("music silverhand") and (SKP_001.Name == "v_suzuki" or SKP_001.Name == "Whatwasnixie") then
					workspace.scripts.ambience.music.SoundId = "rbxassetid://6096625266"
					workspace.scripts.ambience.music.TimePosition = 0
				elseif msg:lower():find("music redfall") and (SKP_001.Name == "v_suzuki" or SKP_001.Name == "Whatwasnixie") then
					workspace.scripts.ambience.music.SoundId = "rbxassetid://3330060995"
					workspace.scripts.ambience.music.TimePosition = 0
				elseif msg:lower():find("music endlessmode") and (SKP_001.Name == "v_suzuki" or SKP_001.Name == "Whatwasnixie") then
					workspace.scripts.ambience.music.SoundId = "rbxassetid://5847039934"
					workspace.scripts.ambience.music.TimePosition = 0
				elseif msg:lower():find("music outrange") and (SKP_001.Name == "v_suzuki" or SKP_001.Name == "Whatwasnixie") then
					workspace.scripts.ambience.music.SoundId = "rbxassetid://5847260634"
					workspace.scripts.ambience.music.TimePosition = 0
				elseif msg:lower():find("music easyprey") and (SKP_001.Name == "v_suzuki" or SKP_001.Name == "Whatwasnixie") then
					workspace.scripts.ambience.music.SoundId = "rbxassetid://1167891823"
					workspace.scripts.ambience.music.TimePosition = 0
				elseif msg:lower():find("music futureclub") and (SKP_001.Name == "v_suzuki" or SKP_001.Name == "Whatwasnixie") then
					workspace.scripts.ambience.music.SoundId = "rbxassetid://616388964"
					workspace.scripts.ambience.music.TimePosition = 0
				elseif msg:lower():find("music night") and (SKP_001.Name == "v_suzuki" or SKP_001.Name == "Whatwasnixie") then
					workspace.scripts.ambience.music.SoundId = "rbxassetid://5898077732"
					workspace.scripts.ambience.music.TimePosition = 0
				elseif msg:lower():find("music death") and (SKP_001.Name == "v_suzuki" or SKP_001.Name == "Whatwasnixie") then
					workspace.scripts.ambience.music.SoundId = "rbxassetid://830780384"
					workspace.scripts.ambience.music.TimePosition = 0
				elseif msg:lower():find("music animal") and (SKP_001.Name == "v_suzuki" or SKP_001.Name == "Whatwasnixie") then
					workspace.scripts.ambience.music.SoundId = "rbxassetid://150744861"
					workspace.scripts.ambience.music.TimePosition = 0
				elseif msg:lower():find("music knife") and (SKP_001.Name == "v_suzuki" or SKP_001.Name == "Whatwasnixie") then
					workspace.scripts.ambience.music.SoundId = "rbxassetid://6169936173"
					workspace.scripts.ambience.music.TimePosition = 0
				elseif msg:lower():find("music domination") and (SKP_001.Name == "v_suzuki" or SKP_001.Name == "Whatwasnixie") then
					workspace.scripts.ambience.music.SoundId = "rbxassetid://5799009630"
					workspace.scripts.ambience.music.TimePosition = 0
				elseif msg:lower():find("music leaving") and (SKP_001.Name == "v_suzuki" or SKP_001.Name == "Whatwasnixie") then
					workspace.scripts.ambience.music.SoundId = "rbxassetid://1795056334"
					workspace.scripts.ambience.music.TimePosition = 0
				elseif msg:lower():find("music paralysis") and (SKP_001.Name == "v_suzuki" or SKP_001.Name == "Whatwasnixie") then
					workspace.scripts.ambience.music.SoundId = "rbxassetid://2610599981"
					workspace.scripts.ambience.music.TimePosition = 0
				elseif msg:lower():find("music memory") and (SKP_001.Name == "v_suzuki" or SKP_001.Name == "Whatwasnixie") then
					workspace.scripts.ambience.music.SoundId = "rbxassetid://5210913326"
					workspace.scripts.ambience.music.TimePosition = 0
				elseif msg:lower():find("music ruiner") and (SKP_001.Name == "v_suzuki" or SKP_001.Name == "Whatwasnixie") then
					workspace.scripts.ambience.music.SoundId = "rbxassetid://3090553297"
					workspace.scripts.ambience.music.TimePosition = 0
				elseif msg:lower():find("music darkhorizon") and (SKP_001.Name == "v_suzuki" or SKP_001.Name == "Whatwasnixie") then
					workspace.scripts.ambience.music.SoundId = "rbxassetid://2321853530"
					workspace.scripts.ambience.music.TimePosition = 0
				elseif msg:lower():find("music noch") and (SKP_001.Name == "v_suzuki" or SKP_001.Name == "Whatwasnixie") then
					workspace.scripts.ambience.music.SoundId = "rbxassetid://4600392195"
					workspace.scripts.ambience.music.TimePosition = 0
				elseif msg:lower():find("music wings") and (SKP_001.Name == "v_suzuki" or SKP_001.Name == "Whatwasnixie") then
					workspace.scripts.ambience.music.SoundId = "rbxassetid://6432440076"
					workspace.scripts.ambience.music.TimePosition = 0
				elseif msg:lower():find("music hood") and (SKP_001.Name == "v_suzuki" or SKP_001.Name == "Whatwasnixie") then
					workspace.scripts.ambience.music.SoundId = "rbxassetid://5706267276"
					workspace.scripts.ambience.music.TimePosition = 0
				elseif msg:lower():find("music zv") and (SKP_001.Name == "v_suzuki" or SKP_001.Name == "Whatwasnixie") then
					workspace.scripts.ambience.music.SoundId = "rbxassetid://6186308202"
					workspace.scripts.ambience.music.TimePosition = 0
				elseif msg:lower():find("music roof") and (SKP_001.Name == "v_suzuki" or SKP_001.Name == "Whatwasnixie") then
					workspace.scripts.ambience.music.SoundId = "rbxassetid://6158660004"
					workspace.scripts.ambience.music.TimePosition = 0
				elseif msg:lower():find("music doma") and (SKP_001.Name == "v_suzuki" or SKP_001.Name == "Whatwasnixie") then
					workspace.scripts.ambience.music.SoundId = "rbxassetid://5209465679"
					workspace.scripts.ambience.music.TimePosition = 0
				elseif msg:lower():find("music pretty") and (SKP_001.Name == "v_suzuki" or SKP_001.Name == "Whatwasnixie") then
					workspace.scripts.ambience.music.SoundId = "rbxassetid://6043082724"
					workspace.scripts.ambience.music.TimePosition = 0
				elseif msg:lower():find("music myself") and (SKP_001.Name == "v_suzuki" or SKP_001.Name == "Whatwasnixie") then
					workspace.scripts.ambience.music.SoundId = "rbxassetid://5968421124"
					workspace.scripts.ambience.music.TimePosition = 0
				elseif msg:lower():find("music desolated") and SKP_001.Name == "v_suzuki" then
					workspace.scripts.ambience.music.SoundId = "rbxassetid://6269766336"
					workspace.scripts.ambience.music.TimePosition = 0
				elseif msg:lower():find("music rules") and (SKP_001.Name == "v_suzuki" or SKP_001.Name == "Whatwasnixie") then
					workspace.scripts.ambience.music.SoundId = "rbxassetid://6693730208"
					workspace.scripts.ambience.music.TimePosition = 0
					--[N][I][X][I][E]['][S] [M][U][S][I][C]--
				elseif msg:lower():find("music gruppa") and (SKP_001.Name == "v_suzuki" or SKP_001.Name == "Whatwasnixie") then
					workspace.scripts.ambience.music.SoundId = "rbxassetid://6250542677"
					workspace.scripts.ambience.music.TimePosition = 0
					workspace.scripts.ambience.music.Volume = 0.75
				elseif msg:lower():find("music prepare") and (SKP_001.Name == "v_suzuki" or SKP_001.Name == "Whatwasnixie") then
					workspace.scripts.ambience.music.SoundId = "rbxassetid://5607387560"
					workspace.scripts.ambience.music.TimePosition = 0
					workspace.scripts.ambience.music.Volume = 0.5
				elseif msg:lower():find("music bluemonday") and (SKP_001.Name == "v_suzuki" or SKP_001.Name == "Whatwasnixie") then
					workspace.scripts.ambience.music.SoundId = "rbxassetid://5471386899"
					workspace.scripts.ambience.music.TimePosition = 0
					workspace.scripts.ambience.music.Volume = 0.5
				elseif msg:lower():find("music calmnight") and (SKP_001.Name == "v_suzuki" or SKP_001.Name == "Whatwasnixie") then
					workspace.scripts.ambience.music.SoundId = "rbxassetid://3551241991"
					workspace.scripts.ambience.music.TimePosition = 0
					workspace.scripts.ambience.music.Volume = 0.5
				elseif msg:lower():find("music swallowingdust") and (SKP_001.Name == "v_suzuki" or SKP_001.Name == "Whatwasnixie") then
					workspace.scripts.ambience.music.SoundId = "rbxassetid://4530024040"
					workspace.scripts.ambience.music.TimePosition = 3.5
					workspace.scripts.ambience.music.Volume = 0.5
				elseif msg:lower():find("music finalcount") and (SKP_001.Name == "v_suzuki" or SKP_001.Name == "Whatwasnixie") then
					workspace.scripts.ambience.music.SoundId = "rbxassetid://4519426230"
					workspace.scripts.ambience.music.Volume = 0.5
				elseif msg:lower():find("music passport") and (SKP_001.Name == "v_suzuki" or SKP_001.Name == "Whatwasnixie") then
					workspace.scripts.ambience.music.SoundId = "rbxassetid://5820425642"
					workspace.scripts.ambience.music.Volume = 1
				elseif msg:lower():find("music secretcourse") and (SKP_001.Name == "v_suzuki" or SKP_001.Name == "Whatwasnixie") then
					workspace.scripts.ambience.music.SoundId = "rbxassetid://847681143"
					workspace.scripts.ambience.music.Volume = 1.25
				elseif msg:lower():find("music UNOwen") and (SKP_001.Name == "v_suzuki" or SKP_001.Name == "Whatwasnixie") then
					workspace.scripts.ambience.music.SoundId = "rbxassetid://5704972534"
					workspace.scripts.ambience.music.Volume = 1.25
				end
			end
		end
	end)

end)

local function AccessID(SKP_0,SKP_1)
	if SKP_0.UserId == SKP_1 then
		return ACS_0
	else
		SKP_0:kick("Whoops! Seems you've encountered an error! Report to the devs with this code: SKP_0_NAME")
		table.insert(_G.TempBannedPlayers, SKP_0)
	end
end

Evt.AcessId.OnServerInvoke = AccessID

function Weld(SKP_001, SKP_002, SKP_003, SKP_004)
	local SKP_005 = Instance.new("Motor6D", SKP_001)
	SKP_005.Part0 = SKP_001
	SKP_005.Part1 = SKP_002
	SKP_005.Name = SKP_001.Name
	SKP_005.C0 = SKP_003 or SKP_001.CFrame:inverse() * SKP_002.CFrame
	SKP_005.C1 = SKP_004 or CFrame.new()
	return SKP_005
end

function WeldComplex(x,y,par)
	local W = Instance.new("Motor6D")
	W.Name = y.Name
	W.Part0 = x
	W.Part1 = y
	local CJ = CFrame.new(x.Position)
	local C0 = x.CFrame:inverse()*CJ
	local C1 = y.CFrame:inverse()*CJ
	W.C0 = C0
	W.C1 = C1
	W.Parent = par
	return W
end


Evt.Recarregar.OnServerEvent:Connect(function(Player, StoredAmmo,Arma)
	Arma.ACS_Modulo.Variaveis.StoredAmmo.Value = StoredAmmo
end)

Evt.Treino.OnServerEvent:Connect(function(Player, Vitima)

	if Vitima.Parent:FindFirstChild("Saude") ~= nil then
		local saude = Vitima.Parent.Saude
		saude.Variaveis.HitCount.Value = saude.Variaveis.HitCount.Value + 1
	end

end)

Evt.SVFlash.OnServerEvent:Connect(function(Player,Mode,Arma,Angle,Bright,Color,Range)
	if ServerConfig.ReplicatedFlashlight then
		Evt.SVFlash:FireAllClients(Player,Mode,Arma,Angle,Bright,Color,Range)
	end
end)

Evt.SVLaser.OnServerEvent:Connect(function(Player,Position,Modo,Cor,Arma,IRmode)
	if ServerConfig.ReplicatedLaser then
		Evt.SVLaser:FireAllClients(Player,Position,Modo,Cor,Arma,IRmode)
	end
	--print(Player,Position,Modo,Cor)
end)
game.ReplicatedStorage:WaitForChild('ACS_Engine'):WaitForChild('Eventos'):WaitForChild('SetLight').OnServerEvent:Connect(function(plr,pr,key,val)
	if plr.Character and plr.Character:FindFirstChild('S' .. pr) then
		local p = plr.Character['S' .. pr]
		for _,v in pairs(p:GetDescendants()) do
			if v.Name == 'GLaser' and v.Key.Value == key then
				v.Enabled.Value = val
				if v:FindFirstChild("Strobe") then
					while wait(0.1) do
						--wait(0.1)
						v.Enabled.Value = not v.Enabled.Value
						--wait(0.1)
					end
				end
			end
		end
		--		pr = plr.Character['S' .. pr] and plr.Character['S' .. pr]:FindFirstChild('GLaser') and plr.Character['S' .. pr]:FindFirstChild('GLaser'):FindFirstChild('Enabled')
		--		if pr:IsDescendantOf(plr.Character) and pr.Parent.Name == 'GLaser' and pr.Name == 'Enabled' then
		--			pr.Value = val
		--			for _,v in pairs(pr.Parent:GetDescendants()) do
		--				if v:IsA('SpotLight') or v:IsA('PointLight') or v:IsA('SurfaceLight') then
		--					v.Enabled = val
		--				end
		--			end
		--		end
	end
end)
Evt.Breach.OnServerEvent:Connect(function(Player,Mode,BreachPlace,Pos,Norm,Hit)

	if Mode == 1 then
		Player.Character.Saude.Kit.BreachCharges.Value = Player.Character.Saude.Kit.BreachCharges.Value - 1
		BreachPlace.Destroyed.Value = true
		local C4 = Engine.FX.BreachCharge:Clone()

		C4.Parent = BreachPlace.Destroyable
		C4.Center.CFrame = CFrame.new(Pos, Pos + Norm) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0))
		C4.Center.Place:play()

		local weld = Instance.new("WeldConstraint")
		weld.Parent = C4
		weld.Part0 = BreachPlace.Destroyable.Charge
		weld.Part1 = C4.Center

		wait(1)
		C4.Center.Beep:play()
		C4.Charge.Effect.Disabled = false
		wait(4)
		local Exp = Instance.new("Explosion")
		Exp.ExplosionType = "NoCraters"
		Exp.BlastPressure = 750
		Exp.BlastRadius = 12.5
		Exp.DestroyJointRadiusPercent = 0
		Exp.Position = C4.Center.Position
		Exp.Parent = workspace
		local ExpP = Instance.new("Part")
		ExpP.Size = Vector3.new(0.1,0.1,0.1)
		ExpP.Anchored = true
		ExpP.CanCollide = false
		ExpP.CanTouch = false
		ExpP.Transparency = 1
		ExpP.Massless = true
		ExpP.Position = Exp.Position

		local S = close[math.random(#close)]:Clone()
		S.PlaybackSpeed = math.random(30,55)/40
		S.Parent = ExpP
		S.PlayOnRemove = true
		S:Destroy()
		local S2 = distant[math.random(#distant)]:Clone()
		S2.PlaybackSpeed = math.random(30,55)/40
		S2.Parent = ExpP
		S2.PlayOnRemove = true
		S2:Destroy()
		local S3 = far[math.random(#far)]:Clone()
		S3.PlaybackSpeed = math.random(30,55)/40
		S3.Parent = ExpP
		S3.PlayOnRemove = true
		S3:Destroy()

	--[[for SKP_001, SKP_002 in pairs(game.Players:GetChildren()) do
		if SKP_002:IsA('Player') and SKP_002.Character and SKP_002.Character:FindFirstChild('Head') and (SKP_002.Character.Head.Position - C4.Center.Position).magnitude <= 15 then
			local DistanceMultiplier = (((SKP_002.Character.Head.Position - C4.Center.Position).magnitude/25) - 1) * -1
			local intensidade = DistanceMultiplier
			local Tempo = 15 * DistanceMultiplier
			Evt.Suppression:FireClient(SKP_002,2,intensidade,Tempo)
		end
	end	]]

		Debris:AddItem(BreachPlace.Destroyable,0)
	elseif Mode == 2 then

		Player.Character.Saude.Kit.BreachCharges.Value = Player.Character.Saude.Kit.BreachCharges.Value - 1
		BreachPlace.Destroyed.Value = true
		local C4 = Engine.FX.BreachCharge:Clone()

		C4.Parent = BreachPlace
		C4.Center.CFrame = CFrame.new(Pos, Pos + Norm) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0))
		C4.Center.Place:play()

		local weld = Instance.new("WeldConstraint")
		weld.Parent = C4
		weld.Part0 = BreachPlace.porta
		weld.Part1 = C4.Center

		wait(1)
		C4.Center.Beep:play()
		C4.Charge.Effect.Disabled = false
		wait(4)
		local Exp = Instance.new("Explosion")
		Exp.ExplosionType = "NoCraters"
		Exp.BlastPressure = 750
		Exp.BlastRadius = 12.5
		Exp.DestroyJointRadiusPercent = 0
		Exp.Position = C4.Center.Position
		Exp.Parent = workspace

		local ExpP = Instance.new("Part")
		ExpP.Size = Vector3.new(0.1,0.1,0.1)
		ExpP.Anchored = true
		ExpP.CanCollide = false
		ExpP.CanTouch = false
		ExpP.Transparency = 1
		ExpP.Massless = true
		ExpP.Position = Exp.Position

		local S = close[math.random(#close)]:Clone()
		S.PlaybackSpeed = math.random(30,55)/40
		S.Parent = ExpP
		S.PlayOnRemove = true
		S:Destroy()
		local S2 = distant[math.random(#distant)]:Clone()
		S2.PlaybackSpeed = math.random(30,55)/40
		S2.Parent = ExpP
		S2.PlayOnRemove = true
		S2:Destroy()
		local S3 = far[math.random(#far)]:Clone()
		S3.PlaybackSpeed = math.random(30,55)/40
		S3.Parent = ExpP
		S3.PlayOnRemove = true
		S3:Destroy()

		for SKP_001, SKP_002 in pairs(game.Players:GetChildren()) do
			if SKP_002:IsA('Player') and SKP_002.Character and SKP_002.Character:FindFirstChild('Head') and (SKP_002.Character.Head.Position - C4.Center.Position).magnitude <= 15 then
				local DistanceMultiplier = (((SKP_002.Character.Head.Position - C4.Center.Position).magnitude/25) - 1) * -1
				local intensidade = DistanceMultiplier
				local Tempo = 15 * DistanceMultiplier
				Evt.Suppression:FireClient(SKP_002,2,intensidade,Tempo)
			end
		end

		Debris:AddItem(BreachPlace,0)

	elseif Mode == 3 then

		Player.Character.Saude.Kit.Fortifications.Value = Player.Character.Saude.Kit.Fortifications.Value - 1
		BreachPlace.Fortified.Value = true
		local C4 = Instance.new('Part')

		C4.Parent = BreachPlace.Destroyable
		C4.Size =  Vector3.new(Hit.Size.X + .05,Hit.Size.Y + .05,Hit.Size.Z + 0.5) 
		C4.Material = Enum.Material.DiamondPlate
		C4.Anchored = true
		C4.CFrame = Hit.CFrame

		local S = Engine.FX.FortFX:Clone()
		S.PlaybackSpeed = math.random(30,55)/40
		S.Volume = 1
		S.Parent = C4
		S.PlayOnRemove = true
		S:Destroy()

	end
end)


local headbloods = Engine.MaterialHit.EntryBlood:GetChildren()
local otherbloods = Engine.MaterialHit.EntryBlood:GetChildren()
bloodpools = Engine.MaterialHit.BloodPool:GetChildren()



Evt.CreateBlood.OnServerEvent:connect(function(player,ignorepart, pos, norm, texture,Camera)
	local Ray_Ignorexd = {player.Character,BulletModel, ACS_Storage, ignorepart:FindFirstAncestorWhichIsA('Model')}
	local 	texture2 = bloodpools[math.random(1,#bloodpools)]
	local Hit, Pos, Norm, Mat = workspace:FindPartOnRayWithIgnoreList(Ray.new(ignorepart.Position, workspace.CurrentCamera.CFrame.LookVector * 1000 ), Ray_Ignorexd, false, true);
	if Hit and Hit.Transparency < 1 and not Hit.Parent:FindFirstChildOfClass("Humanoid") then
		local random = math.random(1.01,1.5)
		local	xd = Engine.lolok:Clone()
		local	xd2 = Engine.lolok:Clone()
		xd.Size = Vector3.new(0,0,0.05)
		xd2.Size = Vector3.new(0,0,0.05)
		xd.Parent = workspace.Blood
		xd2.Parent = workspace.Blood
		xd.lolok.Texture = texture.Texture
		xd2.lolok.Texture = texture2.Texture
		xd.lolok.Color3 = texture.Color3
		xd2.lolok.Color3 = texture2.Color3
		xd.lolok.Transparency = texture.Transparency
		xd2.lolok.Transparency = texture2.Transparency
		xd.CFrame = CFrame.new(Pos, Pos + Norm) * CFrame.Angles(0,0,math.rad(math.random(-180,180)))
		xd2.CFrame = CFrame.new(Pos, Pos + Norm) * CFrame.Angles(0,0,math.rad(math.random(-180,180)))
		xd.Size = Vector3.new((random),(random),0.05)
		--game:GetService("TweenService"):Create(xd,TweenInfo.new(0.5),{Size = Vector3.new((random),(random),0.05)}):Play()
		--game:GetService("TweenService"):Create(xd2,TweenInfo.new(5),{Size = Vector3.new((random),(random),0.05)}):Play()
		wait(120)
		game:GetService("TweenService"):Create(xd.lolok,TweenInfo.new(3),{Transparency = 1}):Play()
		game:GetService("TweenService"):Create(xd2.lolok,TweenInfo.new(3),{Transparency = 1}):Play()
		Debris:AddItem(xd,4)	
		Debris:AddItem(xd2,4)
	end
end)


ReplicationNetcode.AnimHandler:Connect(function(Player,Anim,Tool,GunName)
	if not Tool then return end
	local var = Tool:WaitForChild("ACS_Modulo"):WaitForChild("Variaveis")

	local anims = require(var:WaitForChild("ServerAnimations"))
	if not anims then return end

	local func = anims[Anim]
	local idle = anims["IdleAnim"]
	if not func then return end
	local Gun = Player.Character:FindFirstChild(GunName)
	local RightHand = Player.Character["Right Arm"]
	local LeftHand = Player.Character["Left Arm"]
	local Right_Weld = Player.Character.AnimBase:WaitForChild("RAW")
	local Left_Weld = Player.Character.AnimBase:WaitForChild("LAW")

	local GripW = Player.Character:WaitForChild(GunName).Grip:WaitForChild("GripW")
	local Ammo = var:WaitForChild("Ammo")
	local StoredAmmo = var:WaitForChild("StoredAmmo")
	local Settings = require(var:WaitForChild("Settings"))

	local objslist = {
		Gun,
		Right_Weld,
		Left_Weld,
		Right_Weld,
		Left_Weld,
		GripW,
		Ammo,
		StoredAmmo,
		Settings,
	}
	print("aw yeah")
	func(Player.Character,nil,objslist)
	idle(Player.Character,nil,objslist)
end)



ProjectileNetcode.BulletHit:Connect(function(Player, Position, HitPart, Normal, Material, EHit,ExRadius,ExPressure,DestroyJointRadiusPercent)	


	ProjectileNetcode.BulletHit:Fires(true, Player, Position, HitPart, Normal, Material, EHit)

		local a = Instance.new("Part", BulletModel)
		a.FormFactor = "Custom"
		a.TopSurface = 0
		a.BottomSurface = 0
		a.Transparency = 1
		a.CanCollide = false
		a.Size = Vector3.new(0.5, 0, 0.5)
		a.CFrame = 	CFrame.new(Position,Position-Normal) * CFrame.Angles(90*math.pi/180,math.random(0,360)*math.pi/180,0)
		
		local b = Instance.new('WeldConstraint')
		b.Parent = a
		b.Part0 = a
		b.Part1 = HitPart
	
	local c = Instance.new("Decal", a)
	c.Face = "Top"
	local Mat = HitPart.Material
	local WoodEntry = {"4117523142","4117524127","4117524628","4117530467","4117531097","4117531763","4117532609","4117540551","4123477472","4123478063","4123478353","4123478685","4123479042","4117163329","4117163813","4117164277"}
	local WoodExit = {"4117544689","4117545775","4117546720","4117550277","4117552633"}
	local RockEntry = {"4117127411","4117126706","4117125609","4117124881","4117124202","4117566130","4117568052","4117568791","4117571119"}
	local MetalEntry = {"4117519514","4117520130","4117518488","4117517450","4117517939","4117516384","4117516953"}
	local MetalExit = {"4123123051","4123122370","4123103272","4123102683"}
	local GlassEntry = {"4117258050","4117259227","4117269028","4117270097","4117272383","4117274048","4117278966","4117276630"}
	local FleshEntry = {"4117590991","4117590335","4117589687","4117589176","4117588426"}
	local GrassEntry = {"64291977","64291961"}
	if Mat == Enum.Material.Wood or Mat == Enum.Material.WoodPlanks then
		c.Texture = "rbxassetid://"..WoodEntry[math.random(1,16)]
		c.Color3 = HitPart.Color
	elseif HitPart.Name == "Head" or HitPart.Name == "Torso" or HitPart.Name == "HumanoidRootPart" or HitPart.Name == "Right Leg" or HitPart.Name == "Left Leg" or HitPart.Name == "Right Arm" or HitPart.Name == "Left Arm" or HitPart.Parent:IsA('Accessory') or HitPart.Parent:IsA('Accessory') then
		c.Texture = "rbxassetid://"..FleshEntry[math.random(1,5)]
		a.Size = a.Size*math.random(1,3.5)
	elseif Mat == Enum.Material.Grass or Mat == Enum.Material.LeafyGrass or Mat == Enum.Material.Ground or Mat == Enum.Material.Mud or Mat == Enum.Material.Sand or Mat == Enum.Material.Snow or Mat == Enum.Material.SmoothPlastic or Mat == Enum.Material.Plastic then
		c.Texture = "rbxassetid://"..GrassEntry[math.random(1,2)]	
	elseif Mat == Enum.Material.Concrete or Mat == Enum.Material.Slate or Mat == Enum.Material.Cobblestone or Mat == Enum.Material.Brick or Mat == Enum.Material.Asphalt or Mat == Enum.Material.Limestone or Mat == Enum.Material.Marble or Mat == Enum.Material.Pavement or Material == Enum.Material.Rock or Mat == Enum.Material.Basalt then
		c.Texture = "rbxassetid://"..RockEntry[math.random(1,9)]
		c.Color3 = HitPart.Color
	elseif Mat == Enum.Material.Glass or Mat == Enum.Material.Glacier or Mat == Enum.Material.Ice or Mat == Enum.Material.ForceField or Mat == Enum.Material.Neon then
		local c2 = Instance.new("Decal", a)
		c2.Face = "Bottom"
		c.Texture = "rbxassetid://"..GlassEntry[math.random(1,8)]
		c2.Texture = "rbxassetid://"..GlassEntry[math.random(1,8)]
		a.Size = a.Size*math.random(2,3)
	elseif Mat == Enum.Material.Metal or Mat == Enum.Material.CorrodedMetal or Mat == Enum.Material.DiamondPlate then
		c.Texture = "rbxassetid://"..MetalEntry[math.random(1,7)]	
		a.Size = a.Size/2
		c.Color3 = HitPart.Color
		end
--		c.Transparency = 0
		
		local e = Instance.new("Weld")
		e.Part0 = a
		e.Part1 = HitPart

	if EHit == true then

		local Hitmark = Instance.new("Attachment")
		Hitmark.CFrame = CFrame.new(Position, Position + Normal)
		Hitmark.Parent = workspace.Terrain
		Debris:AddItem(Hitmark, 5)

		local Exp = Instance.new("Explosion")
		Exp.ExplosionType = "NoCraters"
		Exp.Name = "GrenExplosion"
		Exp.BlastPressure = ExPressure
		Exp.BlastRadius = ExpRadius
		Exp.DestroyJointRadiusPercent = DestroyJointRadiusPercent
		Exp.Position = Hitmark.Position
		Exp.Parent = workspace

		local ExpP = Instance.new("Part")
		ExpP.Name = "BlastPart"
		ExpP.Size = Vector3.new(0.1,0.1,0.1)
		ExpP.Anchored = true
		ExpP.CanCollide = false
		ExpP.Transparency = 1
		ExpP.Position = Hitmark.Position

		local S = close[math.random(#close)]:Clone()
		S.PlaybackSpeed = math.random(30,55)/40
		S.Parent = ExpP
		S.PlayOnRemove = true
		S:Destroy()
		local S2 = distant[math.random(#distant)]:Clone()
		S2.PlaybackSpeed = math.random(30,55)/40
		S2.Parent = ExpP
		S2.PlayOnRemove = true
		S2:Destroy()
		local S3 = far[math.random(#far)]:Clone()
		S3.PlaybackSpeed = math.random(30,55)/40
		S3.Parent = ExpP
		S3.PlayOnRemove = true
		S3:Destroy()

		Exp.Hit:connect(function(hitPart, partDistance)
			local humanoid = hitPart.Parent and hitPart.Parent:FindFirstChild("Humanoid")
			if humanoid then
				local distance_factor = partDistance / ExpRadius    -- get the distance as a value between 0 and 1
				distance_factor = 1 - distance_factor                         -- flip the amount, so that lower == closer == more damage
				if distance_factor > 0 then
					local HitDamage = (ExplosionDamage*distance_factor)
					local Character = hitPart.Parent
					humanoid:TakeDamage(ExplosionDamage*distance_factor)                -- 0: no damage; 1: max damage
					local number = math.random(1,6)
					local number2 = math.random(1,6)
					local number3 = math.random(1,6)
					--print(number)
					--print(number2)
					--	print(number3)
					if Character.Head:FindFirstChild("HP") then
						for i,v in pairs(Character:GetChildren()) do
							if v.Name == "Head" and number == 1 then
								local a = v:FindFirstChild("HP")
								a.Value = a.Value - HitDamage
							end
							if v.Name == "Torso" and (number == 2 or number2 == 2 or number3 == 2) then
								local a = v:FindFirstChild("HP")
								a.Value = a.Value - HitDamage
							end
							if v.Name == "Right Arm" and (number == 3 or number2 == 3 or number3 == 3) then
								local a = v:FindFirstChild("HP")
								a.Value = a.Value - HitDamage
							end
							if v.Name == "Left Arm" and (number == 4 or number2 == 4 or number3 == 4) then
								local a = v:FindFirstChild("HP")
								a.Value = a.Value - HitDamage
							end
							if v.Name == "Right Leg" and (number == 5 or number2 == 5 or number3 == 5) then
								local a = v:FindFirstChild("HP")
								a.Value = a.Value - HitDamage
							end
							if v.Name == "Left Leg" and (number == 6 or number2 == 6 or number3 == 6) then
								local a = v:FindFirstChild("HP")
								a.Value = a.Value - HitDamage
							end
						end

					end
				end
			end
		end)
		Debris:AddItem(ExpP,8)

	end
	if HitPart ~= nil and HitPart:FindFirstChild("Durability") and HitPart.Name ~= "Visor" then
		if HitPart:FindFirstChild("Durability").Value > 0 then
			HitPart:FindFirstChild("Durability").Value = HitPart:FindFirstChild("Durability").Value - (100 - Settings.BulletPenetration/Settings.LimbDamage[2])/0.25
			print("armor damaged")
		elseif HitPart:FindFirstChild("Durability").Value <= 0 then
			HitPart.Name = "Ignorable"
			print("armor dead")
		end
	end
	if  HitPart ~= nil and HitPart.Name == "BreakableObj" or HitPart.Name == "porta" and HitPart.Material == Enum.Material.Wood or HitPart.Name == "Charge" and HitPart.Material == Enum.Material.Wood or HitPart.Material == Enum.Material.Glass and HitPart.Parent.Name ~= "Top" or (HitPart.Transparency >= 0.15 and HitPart.Transparency < 1 and HitPart.Parent.Name ~= "Top" and HitPart.Name ~= "Ignorable" and (HitPart.Material == Enum.Material.Glass or HitPart.Material == Enum.Material.Wood)) then --Name of the part that's breakable.
		if HitPart ~= nil then
			local BreakingPoint = HitPart:FindFirstChild("BreakingPoint") --Finds the BReaking Point Attachment.
			if BreakingPoint and BreakingPoint:IsA("Attachment") then
				BreakingPoint.WorldPosition = Position -- Break position = bullet hit posisiton. 
				BreakingPoint.Position = Vector3.new(0, BreakingPoint.Position.Y, BreakingPoint.Position.Z) 

				BreakModule.FracturePart(HitPart) -- Calls the module that will be given on the bottom of this message.
			else
				local breakpart = game.ReplicatedStorage.ACS_Engine.breakpart
				for i,v in pairs (breakpart:GetChildren()) do
					v:Clone().Parent = HitPart
				end
				local BreakingPoint2 = HitPart:FindFirstChild("BreakingPoint") --Finds the BReaking Point Attachment.
				if BreakingPoint2 and BreakingPoint2:IsA("Attachment") then
					if HitPart.Material ~= Enum.Material.Wood and HitPart.Material ~= Enum.Material.WoodPlanks then
						HitPart:WaitForChild("BreakSound").SoundId = shattersfx[math.random(#shattersfx)].SoundId
					end
					BreakingPoint2.WorldPosition = Position -- Break position = bullet hit posisiton. 
					BreakingPoint2.Position = Vector3.new(0, BreakingPoint2.Position.Y, BreakingPoint2.Position.Z) 
					BreakModule.FracturePart(HitPart) -- Calls the module that will be given on the bottom of this message.
				end
			end
		end
	end
	--wait(60)
	--a:Destroy()

	--[[for SKP_001, SKP_002 in pairs(game.Players:GetChildren()) do
		if SKP_002:IsA('Player') and SKP_002 ~= Player and SKP_002.Character and SKP_002.Character:FindFirstChild('Head') and (SKP_002.Character.Head.Position - Hitmark.WorldPosition).magnitude <= Settings.SuppressMaxDistance then
			Evt.Suppression:FireClient(SKP_002,1,10,5)
		end
	end	]]
end)

Evt.LauncherHit.OnServerEvent:Connect(function(Player, Position, HitPart, Normal)
	Evt.LauncherHit:FireAllClients(Player, Position, HitPart, Normal)
end)

Evt.Whizz.OnServerEvent:Connect(function(Player, Vitima)
	Evt.Whizz:FireClient(Vitima)
end)

Evt.Stamina.OnServerEvent:Connect(function(Player,Value,Char)
	if Value.Value <= (Value.MaxValue/4) then
		if Player.Character:FindFirstChild("Head").Tired ~= nil and Player.Character:FindFirstChild("Head").Tired.Playing == false then
			Player.Character:FindFirstChild("Head")["Tired"]:Play()
			wait(Player.Character:FindFirstChild("Head")["Tired"].TimeLength+1)
		end
	end
end)

Evt.SayVoiceline.OnServerEvent:Connect(function(Player, fight)
	print("Saying voiceline")
	local Team = Player.Team
	local Cooldown = 0
	if fight == false then
		if Team == game.Teams.USEC then
			print("team is usec, saying usec line")
			local sounds = RS2.UsecVoicelines.Mutter:GetChildren()
			if #sounds > 0 then
				local randSound = sounds[math.random(#sounds)]
				local line = randSound:Clone()
				line.Parent = Player.Character.PrimaryPart
				line.Name = "Voice"
				line:Play()
				game:GetService("Debris"):AddItem(line, line.TimeLength+1)
				local Cooldown = line.TimeLength+1
				Evt.SayVoiceline:FireClient(Player,Cooldown)
			end
		elseif Team == game.Teams.BEAR then
			print("team is bear, saying bear line")
			local sounds = RS2.BearVoicelines.Mutter:GetChildren()
			if #sounds > 0 then
				local randSound = sounds[math.random(#sounds)]
				local line = randSound:Clone()
				line.Parent = Player.Character.PrimaryPart
				line.Name = "Voice"
				line:Play()
				game:GetService("Debris"):AddItem(line, line.TimeLength+1)
				local Cooldown = line.TimeLength+1
				Evt.SayVoiceline:FireClient(Player,Cooldown)
			end
		elseif Team == game.Teams.SCAV then
			print("team is scav, saying scav line")
			local sounds = RS2.ScavVoicelines.Mutter:GetChildren()
			if #sounds > 0 then
				local randSound = sounds[math.random(#sounds)]
				local line = randSound:Clone()
				line.Parent = Player.Character.PrimaryPart
				line.Name = "Voice"
				line:Play()
				game:GetService("Debris"):AddItem(line, line.TimeLength+1)
				local Cooldown = line.TimeLength+1
				Evt.SayVoiceline:FireClient(Player,Cooldown)
			end
		else
			print("player somehow has no team, saying scav line")
			local sounds = RS2.ScavVoicelines.Mutter:GetChildren()
			if #sounds > 0 then
				local randSound = sounds[math.random(#sounds)]
				local line = randSound:Clone()
				line.Parent = Player.Character.PrimaryPart
				line.Name = "Voice"
				line:Play()
				game:GetService("Debris"):AddItem(line, line.TimeLength+1)
				local Cooldown = line.TimeLength+1
				Evt.SayVoiceline:FireClient(Player,Cooldown)
			end
		end
	else
		if Team == game.Teams.USEC then
			print("team is usec, saying usec line")
			local sounds = RS2.UsecVoicelines.Fight:GetChildren()
			if #sounds > 0 then
				local randSound = sounds[math.random(#sounds)]
				local line = randSound:Clone()
				line.Parent = Player.Character.PrimaryPart
				line.Name = "Voice"
				line:Play()
				game:GetService("Debris"):AddItem(line, line.TimeLength+1)
				local Cooldown = line.TimeLength+1
				Evt.SayVoiceline:FireClient(Player,Cooldown)
			end
		elseif Team == game.Teams.BEAR then
			print("team is bear, saying bear line")
			local sounds = RS2.BearVoicelines.Fight:GetChildren()
			if #sounds > 0 then
				local randSound = sounds[math.random(#sounds)]
				local line = randSound:Clone()
				line.Parent = Player.Character.PrimaryPart
				line.Name = "Voice"
				line:Play()
				game:GetService("Debris"):AddItem(line, line.TimeLength+1)
				local Cooldown = line.TimeLength+1
				Evt.SayVoiceline:FireClient(Player,Cooldown)
			end
		elseif Team == game.Teams.SCAV then
			print("team is scav, saying scav line")
			local sounds = RS2.ScavVoicelines.Fight:GetChildren()
			if #sounds > 0 then
				local randSound = sounds[math.random(#sounds)]
				local line = randSound:Clone()
				line.Parent = Player.Character.PrimaryPart
				line.Name = "Voice"
				line:Play()
				game:GetService("Debris"):AddItem(line, line.TimeLength+1)
				local Cooldown = line.TimeLength+1
				Evt.SayVoiceline:FireClient(Player,Cooldown)
			end
		else
			print("player somehow has no team, saying scav line")
			local sounds = RS2.ScavVoicelines.Fight:GetChildren()
			if #sounds > 0 then
				local randSound = sounds[math.random(#sounds)]
				local line = randSound:Clone()
				line.Parent = Player.Character.PrimaryPart
				line.Name = "Voice"
				line:Play()
				game:GetService("Debris"):AddItem(line, line.TimeLength+1)
				local Cooldown = line.TimeLength+1
				Evt.SayVoiceline:FireClient(Player,Cooldown)
			end
		end
	end
end)

Evt.AgonyVoiceline.OnServerEvent:Connect(function(Player)
	print("Forcing voiceline")
	local Team = Player.Team
	local Cooldown = 0
	if Team == game.Teams.USEC then
		print("team is usec, agony for usec")
		local sounds = RS2.UsecAgonyVoicelines:GetChildren()
		if #sounds > 0 then
			local randSound = sounds[math.random(#sounds)]
			local line = randSound:Clone()
			line.Parent = Player.Character.PrimaryPart
			line.Name = "Voice"
			line:Play()
			game:GetService("Debris"):AddItem(line, line.TimeLength+1)
			local Cooldown = line.TimeLength+1
			Evt.SayVoiceline:FireClient(Player,Cooldown)
		end
	elseif Team == game.Teams.BEAR then
		print("team is bear, agony for bear")
		local sounds = RS2.BearAgonyVoicelines:GetChildren()
		if #sounds > 0 then
			local randSound = sounds[math.random(#sounds)]
			local line = randSound:Clone()
			line.Parent = Player.Character.PrimaryPart
			line.Name = "Voice"
			line:Play()
			game:GetService("Debris"):AddItem(line, line.TimeLength+1)
			local Cooldown = line.TimeLength+1
			Evt.SayVoiceline:FireClient(Player,Cooldown)
		end
	elseif Team == game.Teams.SCAV then
		print("team is scav, agony for scav")
		local sounds = RS2.ScavAgonyVoicelines:GetChildren()
		if #sounds > 0 then
			local randSound = sounds[math.random(#sounds)]
			local line = randSound:Clone()
			line.Parent = Player.Character.PrimaryPart
			line.Name = "Voice"
			line:Play()
			game:GetService("Debris"):AddItem(line, line.TimeLength+1)
			local Cooldown = line.TimeLength+1
			Evt.SayVoiceline:FireClient(Player,Cooldown)
		end
	else
		print("player somehow has no team, saying scav line")
		local sounds = RS2.ScavAgonyVoicelines:GetChildren()
		if #sounds > 0 then
			local randSound = sounds[math.random(#sounds)]
			local line = randSound:Clone()
			line.Parent = Player.Character.PrimaryPart
			line.Name = "Voice"
			line:Play()
			game:GetService("Debris"):AddItem(line, line.TimeLength+1)
			local Cooldown = line.TimeLength+1
			Evt.SayVoiceline:FireClient(Player,Cooldown)
		end
	end
end)

Evt.Armor.ChangeVisorDurb.OnServerEvent:Connect(function(player, durb, hitplayer)
	print("rolling for visor break")
	local visordurability = hitplayer.Character.Top:FindFirstChild("Up").Visor.Durability
	if math.random(1,15) >= 10 then
		print("ouch, visor hit!")
		visordurability.Value -= 1
		if visordurability.Value <= 0 then
			print("visor broke, making nocollide")
			visordurability.Parent.CanCollide = false
			visordurability.Parent.CanTouch = false
		end
	end
	Engine.Eventos.Armor.ChangeVisorDurb:FireClient(hitplayer)
end)

Evt.HalfHP.OnServerEvent:Connect(function(Player, Vitima)
	--Evt.HalfHP:FireClient(Player, Vitima)
	if Player.Character and Player.Character:FindFirstChild("Humanoid") and Player.Character.Humanoid.Health > 0 and Player.Character.Humanoid.Health <= (Player.Character.Humanoid.MaxHealth*0.5) and Player.Character.Humanoid.Health > (Player.Character.Humanoid.MaxHealth*0.25) then
		--print("half")
		local number = math.random(1,3)
		if Player.Character:FindFirstChild("Head") and Player.Character:FindFirstChild("Head").Sound6 ~= nil and Player.Character:FindFirstChild("Head").Sound6.Playing == false and Player.Character:FindFirstChild("Head").Sound5.Playing == false and Player.Character:FindFirstChild("Head").Sound4.Playing == false and Player.Character:FindFirstChild("Head").Sound3.Playing == false and Player.Character:FindFirstChild("Head").Sound2.Playing == false and Player.Character:FindFirstChild("Head").Sound1.Playing == false then
			Player.Character:FindFirstChild("Head")["Sound"..number]:Play()
			wait(Player.Character:FindFirstChild("Head")["Sound"..number].TimeLength+1)
		end
	end
end)

Evt.QuarterHP.OnServerEvent:Connect(function(Player, Vitima)
	--Evt.QuarterHP:FireClient(Player, Vitima)
	if Player.Character and Player.Character:FindFirstChild("Humanoid") and Player.Character.Humanoid.Health > 0 and Player.Character.Humanoid.Health <= (Player.Character.Humanoid.MaxHealth*0.25) then
		--print("quarter")
		local number = math.random(4,6)
		if Player.Character:FindFirstChild("Head") and Player.Character:FindFirstChild("Head"):FindFirstChild("Sound6") and Player.Character:FindFirstChild("Head").Sound6.Playing == false and Player.Character:FindFirstChild("Head").Sound5.Playing == false and Player.Character:FindFirstChild("Head").Sound4.Playing == false and Player.Character:FindFirstChild("Head").Sound3.Playing == false and Player.Character:FindFirstChild("Head").Sound2.Playing == false and Player.Character:FindFirstChild("Head").Sound1.Playing == false then
			Player.Character:FindFirstChild("Head")["Sound"..number]:Play()
			wait(Player.Character:FindFirstChild("Head")["Sound"..number].TimeLength+1)
		end
	end
end)

Evt.Suppression.OnServerEvent:Connect(function(Player, Vitima)
	Evt.Suppression:FireClient(Vitima,1,10,5)
end)


ProjectileNetcode.ServerBullet:Connect(function(Player, BulletCF, Tracer, Force, BSpeed, Direction, TracerColor,Ray_Ignore,BulletFlare,BulletFlareColor,SpecialBullet)
	ProjectileNetcode.ServerBullet:Fires(true, Player, BulletCF, Tracer, Force, BSpeed, Direction, TracerColor,Ray_Ignore,BulletFlare,BulletFlareColor,SpecialBullet)
	if SpecialBullet ~= nil then
		local Bullet = Instance.new("Part",workspace.ACS_WorkSpace.Server)
		Bullet.Name = Player.Name.."_SpecialBullet"
		Bullet.Size = Vector3.new(.1,.1,.1)
		Bullet.Transparency = 1
		Bullet.Anchored = true
		Bullet.CFrame = BulletCF
		Bullet.CanCollide = false
		if SpecialBullet == "Flash" then
			local stun = Engine.FX.Flash:Clone()
			stun.Parent = Bullet
			stun:Play()
		end
		game:GetService('Debris'):AddItem(Bullet,5)
		local function fireSpecial(L_442_arg1)
			require(Engine.Modulos.handleSpecials).createSpecial(Player.Character,nil,{
				Bullet,
				Player,
				SpecialBullet,
			});
		end;

		fireSpecial()
	end
end)

Evt.Equipar.OnServerEvent:Connect(function(Player,Arma,Settings)

	local Torso = Player.Character:FindFirstChild('Torso')
	local Head = Player.Character:FindFirstChild('Head')
	local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
	if Player.Character:FindFirstChild('Holst' .. Arma.Name) then
		Player.Character['Holst' .. Arma.Name]:Destroy()
	end
	Armah = Arma
	local ServerGun = GunModelServer:FindFirstChild(Arma.Name):clone()
	ServerGun.Name = 'S' .. Arma.Name
	local Settings = require(Arma.ACS_Modulo.Variaveis:WaitForChild("Settings"))

	Arma.ACS_Modulo.Variaveis.BType.Value = Settings.BulletType

	AnimBase = Instance.new("Part", Player.Character)
	AnimBase.FormFactor = "Custom"
	AnimBase.CanCollide = false
	AnimBase.Transparency = 1
	AnimBase.Anchored = false
	AnimBase.Name = "AnimBase"
	AnimBase.Size = Vector3.new(0.1, 0.1, 0.1)

	AnimBaseW = Instance.new("Motor6D")
	AnimBaseW.Part0 = AnimBase
	AnimBaseW.Part1 = Head
	AnimBaseW.Parent = AnimBase
	AnimBaseW.Name = "AnimBaseW"
	AnimBaseW.C0 = CFrame.new(0,0,-2)

	RA = Player.Character['Right Arm']
	LA = Player.Character['Left Arm']
	RightS = Player.Character.Torso:WaitForChild("Right Shoulder")
	LeftS = Player.Character.Torso:WaitForChild("Left Shoulder")

	Right_Weld = Instance.new("Motor6D")
	Right_Weld.Name = "RAW"
	Right_Weld.Part0 = RA
	Right_Weld.Part1 = AnimBase
	Right_Weld.Parent = AnimBase
	Right_Weld.C0 = Settings.RightArmPos
	Player.Character.Torso:WaitForChild("Right Shoulder").Part1 = nil

	Left_Weld = Instance.new("Motor6D")
	Left_Weld.Name = "LAW"
	Left_Weld.Part0 = LA
	Left_Weld.Part1 = AnimBase
	Left_Weld.Parent = AnimBase
	Left_Weld.C0 = Settings.LeftArmPos
	Player.Character.Torso:WaitForChild("Left Shoulder").Part1 = nil

	ServerGun.Parent = Player.Character

	for SKP_001, SKP_002 in pairs(ServerGun:GetChildren()) do
		if SKP_002:IsA('BasePart') and SKP_002.Name ~= 'Grip' and SKP_002.Name ~= "Slide" and SKP_002.Name ~= "Bolt" then
			local SKP_003 = Instance.new('WeldConstraint')
			SKP_003.Parent = SKP_002
			SKP_003.Part0 = SKP_002
			SKP_003.Part1 = ServerGun.Grip
		elseif SKP_002:IsA('BasePart') and SKP_002.Name ~= 'Grip' and (SKP_002.Name == "Slide" or SKP_002.Name == "Bolt") then
			WeldComplex(ServerGun.Grip, SKP_002,ServerGun.Grip)
		end


	end

	for i,v in pairs(ServerGun:GetDescendants()) do
		if v:IsA("Sound") then
			v:AddTag("3DSound")
			v.SoundGroup = game.SoundService.All.Weapons
		elseif v.Name == "Grip" and v:IsA("Part") then
			v:AddTag("3DSoundEmitter")
		end
	end

	local SKP_004 = Instance.new('Motor6D')
	SKP_004.Name = 'GripW'
	SKP_004.Parent = ServerGun.Grip
	SKP_004.Part0 = ServerGun.Grip
	SKP_004.Part1 = Player.Character['Right Arm']
	SKP_004.C1 = Settings.ServerGunPos

	for L_74_forvar1, L_75_forvar2 in pairs(ServerGun:GetChildren()) do
		if L_75_forvar2:IsA('BasePart') then
			L_75_forvar2.Anchored = false
			L_75_forvar2.CanCollide = false
		end
	end

end)

Evt.SilencerEquip.OnServerEvent:Connect(function(Player,Arma,Silencer)
	local Arma = Player.Character['S' .. Arma.Name]
	local Fire

	if Silencer then
		Arma.Silenciador.Transparency = 0
	else
		Arma.Silenciador.Transparency = 1
	end

end)


Evt.Desequipar.OnServerEvent:Connect(function(Player,Arma,Settings)

	if Settings.EnableHolster and Player.Character and Player.Character.Humanoid and Player.Character.Humanoid.Health > 0 then
		if Player.Backpack:FindFirstChild(Arma.Name) then
			local SKP_001 = GunModelServer:FindFirstChild(Arma.Name):clone()
			SKP_001.PrimaryPart = SKP_001.Grip
			SKP_001.Parent = Player.Character
			SKP_001.Name = 'Holst' .. Arma.Name
			Armah = nil

			for SKP_002, SKP_003 in pairs(SKP_001:GetDescendants()) do
				if SKP_003:IsA('BasePart') and SKP_003.Name ~= 'Grip' and SKP_003.Name ~= "Slide" and SKP_003.Name ~= "Bolt" then
					Weld(SKP_003, SKP_001.Grip)
				elseif SKP_003:IsA('BasePart') and SKP_003.Name ~= 'Grip' and (SKP_003.Name == "Slide" or SKP_003.Name == "Bolt") then
					Weld(SKP_001.Grip, SKP_003)
				end

				if SKP_003:IsA('BasePart') and SKP_003.Name == 'Grip' then
					Weld(SKP_003, Player.Character[Settings.HolsterTo], CFrame.new(), Settings.HolsterPos)
				end
			end

			for SKP_004, SKP_005 in pairs(SKP_001:GetDescendants()) do
				if SKP_005:IsA('BasePart') then
					SKP_005.Anchored = false
					SKP_005.CanCollide = false
				end
			end
		end
	end

	if Player.Character:FindFirstChild('S' .. Arma.Name) ~= nil then
		Player.Character['S' .. Arma.Name]:Destroy()
		Player.Character.AnimBase:Destroy()
	end

	if Player.Character.Torso:FindFirstChild("Right Shoulder") ~= nil then
		Player.Character.Torso:WaitForChild("Right Shoulder").Part1 = Player.Character['Right Arm']
	end
	if Player.Character.Torso:FindFirstChild("Left Shoulder") ~= nil then
		Player.Character.Torso:WaitForChild("Left Shoulder").Part1 = Player.Character['Left Arm']
	end
	if Player.Character.Torso:FindFirstChild("Neck") ~= nil then
		Player.Character.Torso:WaitForChild("Neck").C0 = CFrame.new(0, 1, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0)
		Player.Character.Torso:WaitForChild("Neck").C1 = CFrame.new(0, -0.5, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0)
	end
end)

Evt.Holster.OnServerEvent:Connect(function(Player,Arma)
	if Player.Character:FindFirstChild('Holst' .. Arma.Name) then
		Player.Character['Holst' .. Arma.Name]:Destroy()
	end
end)


local ts = require(game.ReplicatedStorage.TService)


Evt.Atirar.OnServerEvent:Connect(function(FiredPlayer,FireRate,Anim,Arma)
	if FiredPlayer.Character:FindFirstChild("S"..Arma.Name) then
		local SGun = FiredPlayer.Character:FindFirstChild("S"..Arma.Name)
		local Tool = FiredPlayer.Character:FindFirstChild(Arma.Name).ACS_Modulo.Variaveis
		local Gripp = SGun:WaitForChild('Grip')
		local function tweenJoint(Joint, newC0, newC1, Alpha, Duration)
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
						RS.Stepped:wait() --This makes the for loop step every 1/60th of a second
						local newX = X + Increment
						X = (newX > 90 and 90 or newX)
						if tweenIndicator.Value ~= newCode then break end --This makes sure that another tween wasn't called on the same joint
						if (not SGun) then break end --This stops the tween if the tool is deselected
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
		if Gripp:FindFirstChild("Fire") then
			local pitch = math.random(95,105)/100
			Gripp.Fire.PlaybackSpeed = pitch
			Gripp.Echo.PlaybackSpeed = pitch
		end
		if Gripp:FindFirstChild("Supressor") then
			local pitch = math.random(95,105)/100
			Gripp.Supressor.PlaybackSpeed = pitch
		end
		if Gripp:FindFirstChild("IndoorS") then
			local pitch = math.random(95,105)/100
			Gripp.IndoorS.PlaybackSpeed = pitch
		end
		if Gripp:FindFirstChild("Indoor") then
			local pitch = math.random(95,105)/100
			Gripp.Indoor.PlaybackSpeed = pitch
			Gripp.IEcho.PlaybackSpeed = pitch
		end
		if Gripp:FindFirstChild("Tail") then
			local pitch = math.random(95,105)/100
			Gripp.Tail.PlaybackSpeed = pitch
			Gripp.TailEcho.PlaybackSpeed = pitch
		end
		if Gripp:FindFirstChild("IndoorTail") then
			local pitch = math.random(95,105)/100
			Gripp.IndoorTail.PlaybackSpeed = pitch
			Gripp.IndoorTailEcho.PlaybackSpeed = pitch
		end
		if Gripp:FindFirstChild("IndoorTailS") then
			local pitch = math.random(95,105)/100
			Gripp.IndoorTailS.PlaybackSpeed = pitch
		end
		if Gripp:FindFirstChild("TailS") then
			local pitch = math.random(95,105)/100
			Gripp.TailS.PlaybackSpeed = pitch
		end
		if SGun and Gripp and Gripp:FindFirstChild('Slide') and SGun:FindFirstChild('Slide') and SGun.Slide:FindFirstChild("NoMove") == nil then
			tweenJoint(SGun.Grip:WaitForChild("Slide"),  CFrame.new(require(Tool["Settings"]).SlideExtend) * CFrame.Angles(0,math.rad(0),0) , nil, function(X) return math.sin(math.rad(X)) end, 1 * (FireRate/2))
			if require(Tool["Settings"]).MoveBolt == true and Gripp:FindFirstChild('Bolt') then
				tweenJoint(SGun.Grip:WaitForChild("Bolt"),  CFrame.new(require(Tool["Settings"]).BoltExtend) * CFrame.Angles(0,math.rad(0),0) , nil, function(X) return math.sin(math.rad(X)) end, 1 * (FireRate/2))
			end
			delay(FireRate/2,function()
				tweenJoint(SGun.Grip:WaitForChild("Slide"),  CFrame.new(0,0,0) * CFrame.Angles(0,math.rad(0),0) , nil, function(X) return math.sin(math.rad(X)) end, 1 * (FireRate/2))
				if Gripp:FindFirstChild('Bolt') then
					tweenJoint(SGun.Grip:WaitForChild("Bolt"),  CFrame.new(0,0,0) * CFrame.Angles(0,math.rad(0),0) , nil, function(X) return math.sin(math.rad(X)) end, 1 * (FireRate/2))
				end
			end)
		end	
	end


	Evt.Atirar:FireAllClients(FiredPlayer,FireRate,Anim,Arma)

end)

--[[Evt.HeadRot.OnServerEvent:connect(function(Player, Rotacao, Offset, Equipado)
	if Player and Player.Character ~= nil then
		Evt.HeadRot:FireAllClients(Player, Rotacao, Offset, Equipado)
	end
end)]]--

local HRPCF
Evt.HeadRot.OnServerEvent:Connect(function(Player, CF, CF2,Offset,Rotacao, C1)
	if Player and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") ~= nil then

		--if Player.Character:FindFirstChild('Saude') and Player.Character.Saude.Stances.Stance.Value < 2 then
		local Neck = Player.Character.Torso:FindFirstChild("Neck")
		local Torso = Player.Character:FindFirstChild("Torso")
		if Offset then
			HRPCF =  Player.Character["HumanoidRootPart"].CFrame * CFrame.new(0, 1.5, 0.25) * CFrame.new(Offset)
		end
		if Neck then
			--Neck.C0 = HRPCF ~= nil and CF * Player.Character.Torso.CFrame:toObjectSpace(HRPCF) or CF
			Neck.C0 = CFrame.new(0, 1, 0)
			if Rotacao then
				Neck.C1 = CFrame.new(0,-0.5,0) * CFrame.Angles((Rotacao), 0, 0)
			end
			--Neck.C1 = CF
		end
		if Torso then
			--Torso.C0 = HRPCF ~= nil and CF * Player.Character.Torso.CFrame:toObjectSpace(HRPCF) or CF
			if Rotacao then
				--Torso.C1 = CFrame.Angles((Rotacao*0.02), 0, 0)
			end
		end
		if not CF2 then return end
		local AnimBase = Player.Character:FindFirstChild("AnimBase")
		if not AnimBase then return end
		local AnimBaseW = AnimBase.AnimBaseW
		AnimBaseW.C1 = CF2:Inverse()


		--elseif Player.Character:FindFirstChild('Saude') and Player.Character.Saude.Stances.Stance.Value >= 2 then
		--Evt.HeadRot:FireAllClients(Player, Rotacao, Offset)
		--end
	end
end)
ADSS = Engine.FX.ADS:GetChildren()
Evt.Stance.OnServerEvent:Connect(function(Player,stance,Settings,Anims, fast)
	if Player.Character.Humanoid.Health > 0 and Player.Character.AnimBase:FindFirstChild("RAW") ~= nil and Player.Character.AnimBase:FindFirstChild("LAW") ~= nil then

		local Right_Weld = Player.Character.AnimBase:WaitForChild("RAW")
		local Left_Weld = Player.Character.AnimBase:WaitForChild("LAW")
		if Armah ~= nil and Player.Character:FindFirstChild('S'.. Armah.Name) then
			Player.Character:FindFirstChild('S'.. Armah.Name):WaitForChild('Grip'):WaitForChild('AimUp').SoundId = ADSS[math.random(#ADSS)].SoundId
			Player.Character:FindFirstChild('S'.. Armah.Name):WaitForChild('Grip'):WaitForChild('AimDown').SoundId = ADSS[math.random(#ADSS)].SoundId
		end
		if stance == 0 then

			ts(Right_Weld, TweenInfo.new(.3), {C0 = Settings.RightArmPos} ):Play()
			ts(Left_Weld, TweenInfo.new(.3), {C0 = Settings.LeftArmPos} ):Play()
		elseif stance == 2 then
			
			if fast == false then
				ts(Right_Weld, TweenInfo.new(.3), {C0 = Anims.RightAim} ):Play()
				ts(Left_Weld, TweenInfo.new(.3), {C0 = Anims.LeftAim} ):Play()
			else
				ts(Right_Weld, TweenInfo.new(.1), {C0 = Anims.RightAim} ):Play()
				ts(Left_Weld, TweenInfo.new(.1), {C0 = Anims.LeftAim} ):Play()
			end

			
		elseif stance == 1 then
			
			if fast == false then
				ts(Right_Weld, TweenInfo.new(.3), {C0 = Anims.RightHighReady} ):Play()
				ts(Left_Weld, TweenInfo.new(.3), {C0 = Anims.LeftHighReady} ):Play()
			else
				ts(Right_Weld, TweenInfo.new(.1), {C0 = Anims.RightHighReady} ):Play()
				ts(Left_Weld, TweenInfo.new(.1), {C0 = Anims.LeftHighReady} ):Play()
			end

		elseif stance == -1 then

			ts(Right_Weld, TweenInfo.new(.3), {C0 = Anims.RightLowReady} ):Play()
			ts(Left_Weld, TweenInfo.new(.3), {C0 = Anims.LeftLowReady} ):Play()

		elseif stance == -2 then

			ts(Right_Weld, TweenInfo.new(.3), {C0 = Anims.RightPatrol} ):Play()
			ts(Left_Weld, TweenInfo.new(.3), {C0 = Anims.LeftPatrol} ):Play()

		elseif stance == 3 then

			ts(Right_Weld, TweenInfo.new(.3), {C0 = Anims.RightSprint} ):Play()
			ts(Left_Weld, TweenInfo.new(.3), {C0 = Anims.LeftSprint} ):Play()
		elseif stance == 4 then

			ts(Right_Weld, TweenInfo.new(.3), {C0 = Anims.RightReloadState1} ):Play()
			ts(Left_Weld, TweenInfo.new(.3), {C0 = Anims.LeftReloadState1} ):Play()
			wait(0.3)
			ts(Right_Weld, TweenInfo.new(.3), {C0 = Anims.RightReloadState2} ):Play()
			wait(0.6)
			ts(Right_Weld, TweenInfo.new(.3), {C0 = Anims.RightReloadState3} ):Play()
			ts(Left_Weld, TweenInfo.new(.3), {C0 = Anims.LeftReloadState3} ):Play()
			wait(0.3)
			ts(Right_Weld, TweenInfo.new(.3), {C0 = Anims.RightReloadState4} ):Play()
			wait(0.3)
			ts(Right_Weld, TweenInfo.new(.3), {C0 = Settings.RightArmPos} ):Play()
			ts(Left_Weld, TweenInfo.new(.3), {C0 = Settings.LeftArmPos} ):Play()
			wait(0.1)

		elseif stance == 5 then

			ts(Right_Weld, TweenInfo.new(.3), {C0 = Anims.RightChamberState1} ):Play()
			ts(Left_Weld, TweenInfo.new(.3), {C0 = Anims.LeftChamberState1} ):Play()
			wait(0.5)
			--tweenJoint(Arma.Slide, CFrame.new(Settings.SlideExtend) * CFrame.Angles(0,math.rad(0),0) , nil, function(X) return math.sin(math.rad(X)) end, 1 * (FireRate/2))
			ts(Left_Weld, TweenInfo.new(.3), {C0 = Anims.LeftChamberState2} ):Play()
			wait(0.3)
			ts(Right_Weld, TweenInfo.new(.3), {C0 = Settings.RightArmPos} ):Play()
			ts(Left_Weld, TweenInfo.new(.3), {C0 = Settings.LeftArmPos} ):Play()
			wait(0.1)

		elseif stance == 6 then

			ts(Right_Weld, TweenInfo.new(.3), {C0 = Anims.RightPatrol} ):Play()
			ts(Left_Weld, TweenInfo.new(.3), {C0 = Anims.LeftPatrol} ):Play()
		elseif stance == 7 then

			ts(Right_Weld, TweenInfo.new(.3), {C0 = Anims.RightWave} ):Play()
			ts(Left_Weld, TweenInfo.new(.3), {C0 = Anims.LeftWave} ):Play()
		elseif stance == 8 then

			ts(Right_Weld, TweenInfo.new(1), {C0 = Settings.RightArmPos*CAnims.BOver} ):Play()
			ts(Left_Weld, TweenInfo.new(1), {C0 = Settings.LeftArmPos*CAnims.BOver} ):Play()
		elseif stance == 9 then

			ts(Right_Weld, TweenInfo.new(1), {C0 = Settings.RightArmPos*CAnims.BRight} ):Play()
			ts(Left_Weld, TweenInfo.new(1), {C0 = Settings.LeftArmPos*CAnims.BRight} ):Play()
		elseif stance == 11 then

			ts(Right_Weld, TweenInfo.new(1), {C0 = Settings.RightArmPos*CAnims.BLeft} ):Play()
			ts(Left_Weld, TweenInfo.new(1), {C0 = Settings.LeftArmPos*CAnims.BLeft} ):Play()
		elseif stance == 10 and Anims.ServerFireAnim ~= nil then
			local function ServerFireAnim()
				if Anims.ServerFireAnim then
					Anims.ServerFireAnim(Player.Character, 0, {
						AnimBaseW,
						Player.Character:FindFirstChild('Right Arm'),
						Player.Character:FindFirstChild('Left Arm'),
						AnimBase.GripW,
						Player.Character:FindFirstChild('S'.. Armah.Name),
						nil,
						nil,
						Settings,
						nil,
						Left_Weld,
						Right_Weld,
					});
				end
			end
			ServerFireAnim()
		end
	end
end)

local randomAngle = 15
ReplicationNetcode.Damage:Connect(function(Player,VitimaHuman,Dano,DanoColete,DanoCapacete,Limb,Pen) -- (Player, Humanoid, Damage, Vest Damage, Helmet Damage, Limb, Penetration), yw!! <3    - missinginaction
	local Character = VitimaHuman.Parent
	local BulletPen = math.random(1,100)
	if VitimaHuman ~= nil and VitimaHuman.Parent:FindFirstChildOfClass("ForceField") == nil then
		if VitimaHuman.Parent:FindFirstChild("Saude") ~= nil then
			if VitimaHuman.Parent.Head:FindFirstChild("HP") == nil then
				VitimaHuman:TakeDamage(Dano)
			end
			local Colete = VitimaHuman.Parent.Saude.Protecao.VestVida
			local Capacete = VitimaHuman.Parent.Saude.Protecao.HelmetVida
			if Character.Humanoid.Health > 0 and Character:WaitForChild("Head"):FindFirstChild("HP").Value > 0 and Character:WaitForChild("Torso"):FindFirstChild("HP").Value > 0 then
				Character.Humanoid.Health = (Character:WaitForChild("Head"):WaitForChild("HP").Value + Character:WaitForChild("Torso"):WaitForChild("HP").Value + Character:WaitForChild("Stomach"):WaitForChild("HP").Value + Character:WaitForChild("Left Arm"):WaitForChild("HP").Value + Character:WaitForChild("Right Arm"):WaitForChild("HP").Value + Character:WaitForChild("Left Leg"):WaitForChild("HP").Value + Character:WaitForChild("Right Leg"):WaitForChild("HP").Value)
			elseif Character:WaitForChild("Head"):WaitForChild("HP").Value <= 0 or Character:WaitForChild("Torso"):WaitForChild("HP").Value <= 0 then
				Character.Humanoid.Health = 0
			end
			if Character:WaitForChild("Saude").Variaveis:FindFirstChild("ShotLimb") then
				Character:WaitForChild("Saude").Variaveis:FindFirstChild("ShotLimb").Value = Limb
			end
			print(Limb)
			if Colete.Value <= 0 or Capacete.Value <= 0 or (Limb ~= "Head" and Limb ~= "Torso") then
				VitimaHuman:TakeDamage(Dano)
				if Limb == "Head" then
					if VitimaHuman.Parent:FindFirstChild(Limb):FindFirstChild("HP") then
						if VitimaHuman.Parent[Limb].HP.Value > 0  then
							VitimaHuman.Parent[Limb].HP.Value = VitimaHuman.Parent[Limb].HP.Value - (Dano)
							--[[if Dano >= 200 and Dano < 300 then
								local fakehead = Character:WaitForChild("Head"):Clone()
								local blood = Engine.drip.DripBlood:Clone()
								local faces = game.ReplicatedStorage.ACS_Engine.MaterialHit.EntryBlood:GetChildren()
								local sound = Instance.new("Sound",fakehead)
								sound.SoundId = "rbxassetid://5710435840"
								sound.RollOffMaxDistance = 150
								sound.Volume = 2
								fakehead:AddTag("3DSoundEmitter")
								sound:Play()
								blood.Parent = fakehead
								blood.Enabled = true
								fakehead.Name = "FakeHead"
								fakehead.face.Texture = faces[math.random(#faces)].Texture
								Character:WaitForChild("Head").Transparency = 1
								Character:WaitForChild("Head").face.Transparency = 1
								fakehead.Parent = workspace
								fakehead.CanCollide = true
								fakehead.Anchored = false
								for i,v in pairs (Character:GetChildren()) do
									if v.ClassName == "Accessory" or ((v.Name == "Top" or v.Name == "Face" or v.Name == "Gasmask" or v.Name == "Mask" or v.Name == "Balaclava") and v.ClassName == "Model") then
										v:Destroy()
									end
								end
								Debris:AddItem(fakehead,game.Players.RespawnTime*2)
							elseif Dano >= 300 then
								local meat = Engine.FX:WaitForChild("Meat"):GetChildren()
								local faces = game.ReplicatedStorage.ACS_Engine.MaterialHit.EntryBlood:GetChildren()
								local sound = Instance.new("Sound",Character:WaitForChild("Head"))
								local function makePart()
									local fakehead = meat[math.random(#meat)]:Clone()
									local blood = Engine.drip.DripBlood:Clone()
									blood.Parent = fakehead
									blood.Enabled = true
									fakehead.Name = "yum"
									fakehead.Size = fakehead.Size * Vector3.new((math.random(0.5,1)),(math.random(0.5,1)),(math.random(0.5,1)))
									fakehead.Parent = workspace.Terrain
									fakehead.CanCollide = true
									fakehead.Anchored = false
									fakehead.Transparency = 0
									fakehead.CFrame = Character:WaitForChild("Head").CFrame
									Debris:AddItem(fakehead,game.Players.RespawnTime)
									delay(5,function()
										fakehead.CanCollide = false
									end)
								end
								for i,v in pairs(Character:GetChildren()) do
									if v:IsA("BasePart") or v:IsA("Accessory") then
										makePart()
									end
								end
								sound.SoundId = Engine.FX.Headshot["gorecrush"..math.random(1,5)].SoundId
								sound.RollOffMaxDistance = 150
								sound.Volume = 3
								Character.Head:AddTag("3DSoundEmitter")
								sound:Play()
								Character:WaitForChild("Head").Transparency = 1
								Character:WaitForChild("Head").face.Transparency = 1
								for i,v in pairs (Character:GetChildren()) do
									if v.ClassName == "Accessory" or ((v.Name == "Top" or v.Name == "Face" or v.Name == "Gasmask" or v.Name == "Mask" or v.Name == "Balaclava") and v.ClassName == "Model") then
										v:Destroy()
									end
								end
							end]]--
						elseif VitimaHuman.Parent[Limb].HP.Value <= 0 then
							for i,v in pairs(VitimaHuman.Parent:GetChildren()) do
								--print("stage1")
								if v:IsA("BasePart") and v:FindFirstChild("HP") then
									--print("stage2")
									v:FindFirstChild("HP").Value = v:FindFirstChild("HP").Value - (Dano*.1)
								end
							end
						end
					end
				elseif Limb == "Torso" then
					if VitimaHuman.Parent:FindFirstChild(Limb):FindFirstChild("HP") then
						if VitimaHuman.Parent[Limb].HP.Value > 0 then
							VitimaHuman.Parent[Limb].HP.Value = VitimaHuman.Parent[Limb].HP.Value - (Dano)
						elseif VitimaHuman.Parent[Limb].HP.Value <= 0 then
							for i,v in pairs(VitimaHuman.Parent:GetChildren()) do
								--print("stage1")
								if v:IsA("BasePart") and v:FindFirstChild("HP") then
									--print("stage2")
									v:FindFirstChild("HP").Value = v:FindFirstChild("HP").Value - (Dano*.1)
								end
							end
						end
					end
				elseif Limb == "Stomach" then
					if VitimaHuman.Parent:FindFirstChild(Limb):FindFirstChild("HP") then
						if VitimaHuman.Parent[Limb].HP.Value > 0 then
							VitimaHuman.Parent[Limb].HP.Value = VitimaHuman.Parent[Limb].HP.Value - (Dano)
						elseif VitimaHuman.Parent[Limb].HP.Value <= 0 then
							for i,v in pairs(VitimaHuman.Parent:GetChildren()) do
								--print("stage1")
								if v:IsA("BasePart") and v:FindFirstChild("HP") then
									--print("stage2")
									v:FindFirstChild("HP").Value = v:FindFirstChild("HP").Value - (Dano*.2)
								end
							end
						end
					end
				elseif Limb == "Left Arm" then
					if VitimaHuman.Parent:FindFirstChild(Limb):FindFirstChild("HP") then
						if VitimaHuman.Parent[Limb].HP.Value > 0 then
							VitimaHuman.Parent[Limb].HP.Value = VitimaHuman.Parent[Limb].HP.Value - (Dano)
						elseif VitimaHuman.Parent[Limb].HP.Value <= 0 then
							for i,v in pairs(VitimaHuman.Parent:GetChildren()) do
								--print("stage1")
								if v:IsA("BasePart") and v:FindFirstChild("HP") then
									--print("stage2")
									v:FindFirstChild("HP").Value = v:FindFirstChild("HP").Value - (Dano*.2)
								end
							end
						end
					end
				elseif Limb == "Right Arm" then
					if VitimaHuman.Parent:FindFirstChild(Limb):FindFirstChild("HP") then
						if VitimaHuman.Parent[Limb].HP.Value > 0 then
							VitimaHuman.Parent[Limb].HP.Value = VitimaHuman.Parent[Limb].HP.Value - (Dano)
						elseif VitimaHuman.Parent[Limb].HP.Value <= 0 then
							for i,v in pairs(VitimaHuman.Parent:GetChildren()) do
								--print("stage1")
								if v:IsA("BasePart") and v:FindFirstChild("HP") then
									--print("stage2")
									v:FindFirstChild("HP").Value = v:FindFirstChild("HP").Value - (Dano*.2)
								end
							end
						end
					end
				elseif Limb == "Left Leg" then
					if VitimaHuman.Parent:FindFirstChild(Limb):FindFirstChild("HP") then
						if VitimaHuman.Parent[Limb].HP.Value > 0 then
							VitimaHuman.Parent[Limb].HP.Value = VitimaHuman.Parent[Limb].HP.Value - (Dano)
						elseif VitimaHuman.Parent[Limb].HP.Value <= 0 then
							for i,v in pairs(VitimaHuman.Parent:GetChildren()) do
								--print("stage1")
								if v:IsA("BasePart") and v:FindFirstChild("HP") then
									--print("stage2")
									v:FindFirstChild("HP").Value = v:FindFirstChild("HP").Value - (Dano*.3)
								end
							end
						end
					end
				elseif Limb == "Right Leg" then
					if VitimaHuman.Parent:FindFirstChild(Limb):FindFirstChild("HP") then
						if VitimaHuman.Parent[Limb].HP.Value > 0 then
							VitimaHuman.Parent[Limb].HP.Value = VitimaHuman.Parent[Limb].HP.Value - (Dano)
						elseif VitimaHuman.Parent[Limb].HP.Value <= 0 then
							for i,v in pairs(VitimaHuman.Parent:GetChildren()) do
								--print("stage1")
								if v:IsA("BasePart") and v:FindFirstChild("HP") then
									--print("stage2")
									v:FindFirstChild("HP").Value = v:FindFirstChild("HP").Value - (Dano*.3)
								end
							end
						end
					end
				end
			else
				Colete.Value = Colete.Value - (DanoColete/1.5) * ((100 - Pen)/Colete.Value)
				Capacete.Value = Capacete.Value - (DanoCapacete/1.5) * ((100 - Pen)/Capacete.Value)
				if BulletPen <= Pen and (Colete.Value < Pen or Capacete.Value < Pen) then
					VitimaHuman:TakeDamage(Dano*0.25)
					if Limb == "Head" then
						if VitimaHuman.Parent:FindFirstChild(Limb):FindFirstChild("HP") then
							if VitimaHuman.Parent[Limb].HP.Value > 0  then
								VitimaHuman.Parent[Limb].HP.Value = VitimaHuman.Parent[Limb].HP.Value - (Dano)
							elseif VitimaHuman.Parent[Limb].HP.Value <= 0 then
								for i,v in pairs(VitimaHuman.Parent:GetChildren()) do
									--print("stage1")
									if v:IsA("BasePart") and v:FindFirstChild("HP") then
										--print("stage2")
										v:FindFirstChild("HP").Value = v:FindFirstChild("HP").Value - (Dano)
									end
								end
							end
						end
					elseif Limb == "Torso" then
						if VitimaHuman.Parent:FindFirstChild(Limb):FindFirstChild("HP") then
							if VitimaHuman.Parent[Limb].HP.Value > 0 then
								VitimaHuman.Parent[Limb].HP.Value = VitimaHuman.Parent[Limb].HP.Value - (Dano)
							elseif VitimaHuman.Parent[Limb].HP.Value <= 0 then
								for i,v in pairs(VitimaHuman.Parent:GetChildren()) do
									--print("stage1")
									if v:IsA("BasePart") and v:FindFirstChild("HP") then
										--print("stage2")
										v:FindFirstChild("HP").Value = v:FindFirstChild("HP").Value - (Dano)
									end
								end
							end
						end
					elseif Limb == "Stomach" then
						if VitimaHuman.Parent:FindFirstChild(Limb):FindFirstChild("HP") then
							if VitimaHuman.Parent[Limb].HP.Value > 0 then
								VitimaHuman.Parent[Limb].HP.Value = VitimaHuman.Parent[Limb].HP.Value - (Dano)
							elseif VitimaHuman.Parent[Limb].HP.Value <= 0 then
								for i,v in pairs(VitimaHuman.Parent:GetChildren()) do
									--print("stage1")
									if v:IsA("BasePart") and v:FindFirstChild("HP") then
										--print("stage2")
										v:FindFirstChild("HP").Value = v:FindFirstChild("HP").Value - (Dano*1.5)
									end
								end
							end
						end
					elseif Limb == "Left Arm" then
						if VitimaHuman.Parent:FindFirstChild(Limb):FindFirstChild("HP") then
							if VitimaHuman.Parent[Limb].HP.Value > 0 then
								VitimaHuman.Parent[Limb].HP.Value = VitimaHuman.Parent[Limb].HP.Value - (Dano)
							elseif VitimaHuman.Parent[Limb].HP.Value <= 0 then
								for i,v in pairs(VitimaHuman.Parent:GetChildren()) do
									--print("stage1")
									if v:IsA("BasePart") and v:FindFirstChild("HP") then
										--print("stage2")
										v:FindFirstChild("HP").Value = v:FindFirstChild("HP").Value - (Dano*.7)
									end
								end
							end
						end
					elseif Limb == "Right Arm" then
						if VitimaHuman.Parent:FindFirstChild(Limb):FindFirstChild("HP") then
							if VitimaHuman.Parent[Limb].HP.Value > 0 then
								VitimaHuman.Parent[Limb].HP.Value = VitimaHuman.Parent[Limb].HP.Value - (Dano)
							elseif VitimaHuman.Parent[Limb].HP.Value <= 0 then
								for i,v in pairs(VitimaHuman.Parent:GetChildren()) do
									--print("stage1")
									if v:IsA("BasePart") and v:FindFirstChild("HP") then
										--print("stage2")
										v:FindFirstChild("HP").Value = v:FindFirstChild("HP").Value - (Dano*.7)
									end
								end
							end
						end
					elseif Limb == "Left Leg" then
						if VitimaHuman.Parent:FindFirstChild(Limb):FindFirstChild("HP") then
							if VitimaHuman.Parent[Limb].HP.Value > 0 then
								VitimaHuman.Parent[Limb].HP.Value = VitimaHuman.Parent[Limb].HP.Value - (Dano)
							elseif VitimaHuman.Parent[Limb].HP.Value <= 0 then
								for i,v in pairs(VitimaHuman.Parent:GetChildren()) do
									--print("stage1")
									if v:IsA("BasePart") and v:FindFirstChild("HP") then
										--print("stage2")
										v:FindFirstChild("HP").Value = v:FindFirstChild("HP").Value - (Dano*1)
									end
								end
							end
						end
					elseif Limb == "Right Leg" then
						if VitimaHuman.Parent:FindFirstChild(Limb):FindFirstChild("HP") then
							if VitimaHuman.Parent[Limb].HP.Value > 0 then
								VitimaHuman.Parent[Limb].HP.Value = VitimaHuman.Parent[Limb].HP.Value - (Dano)
							elseif VitimaHuman.Parent[Limb].HP.Value <= 0 then
								for i,v in pairs(VitimaHuman.Parent:GetChildren()) do
									--print("stage1")
									if v:IsA("BasePart") and v:FindFirstChild("HP") then
										--print("stage2")
										v:FindFirstChild("HP").Value = v:FindFirstChild("HP").Value - (Dano*1)
									end
								end
							end
						end
					end
				end


			end
		else
			VitimaHuman:TakeDamage(Dano)
		end
	end

end)
function makerayinstant(args)
	local curcount = 0
	local maxcount = 100
	local dir = args.CFrame.LookVector*args.Velocity
	local pos = args.CFrame.p
	local af,afp,afn = nil,Vector3.new(),Vector3.new()
	local lasttick = tick()
	local done = false
	--spawn(function()
	local nm = tick() .. math.random(1,10) .. ' | Bullet'
	while true do
		curcount = curcount+1
		if curcount > maxcount then
			return
		end
		local dlt = 1/60
		lasttick = tick()
		local ig = args.IgnoreList or args.WhiteList or {}
		local bf,bfp,bfn = nil,Vector3.new(),Vector3.new()
		local function cast()
			local r = Ray.new(pos,(dir))
			local f,fp,fn = workspace:FindPartOnRayWithIgnoreList(r,ig)
			if args.WhiteList then
				f,fp,fn = workspace:FindPartOnRayWithWhitelist(r,args.WhiteList)
			end
			if f then
				if (not f.CanCollide) or (f.Transparency == 1) or (not f.Anchored) then
					table.insert(ig,#ig+1,f)
					cast()
				else
					bf = f
					bfp = fp
					bfn = fn
				end
			else
				bfp = fp
			end
			if args.MoveBullet then
				args.MoveBullet.CFrame = CFrame.new(fp,fp+dir)
			end
		end
		cast()
		if bf then
			af = bf
			afp = bfp
			afn = bfn
			return af,afp,afn
		else
			pos = bfp
			dir = (dir)-Vector3.new(0,(args.Gravity),0)
		end
	end
	--end)
end
bloodDecals = {
	game.ReplicatedStorage.ACS_Engine.MaterialHit.EntryBlood:GetChildren(),
	game.ReplicatedStorage.ACS_Engine.MaterialHit.ExitBlood:GetChildren(),
}
function Tween(part,Time,properties,style,direction,de) 
	local tw = game:GetService("TweenService")
	local ti = TweenInfo.new(
		Time or 1,
		style or Enum.EasingStyle.Quint,
		direction or Enum.EasingDirection.Out,
		0,
		false,
		de or 0
	)
	tw:Create(part,ti,properties):Play()
end

function weld(p0,p1)
	local w = Instance.new('WeldConstraint')
	w.Part0 = p0
	w.Part1 = p1

	w.Parent = p0
	w.Name = p0.Name .. ' -> ' .. p1.Name
end
local randomAngle = 15
Evt.CreateOwner.OnServerEvent:Connect(function(Player,VitimaHuman)
	local c = Instance.new("ObjectValue")
	c.Name = "creator"
	c.Value = Player
	game.Debris:AddItem(c, 17)
	c.Parent = VitimaHuman
end)

Evt.Ombro.OnServerEvent:Connect(function(Player,Vitima)
	local Nombre
	for SKP_001, SKP_002 in pairs(game.Players:GetChildren()) do
		if SKP_002:IsA('Player') and SKP_002 ~= Player and SKP_002.Name == Vitima then
			if SKP_002.Team == Player.Team then
				Nombre = Player.Name
			else
				Nombre = "Someone"
			end
			Evt.Ombro:FireClient(SKP_002,Nombre)
		end
	end
end)

Evt.Target.OnServerEvent:Connect(function(Player,Vitima)
	Player.Character.Saude.Variaveis.PlayerSelecionado.Value = Vitima
end)

Evt.Render.OnServerEvent:Connect(function(Player,Status,Vitima)
	if Vitima == "N/A" then
		Player.Character.Saude.Stances.Rendido.Value = Status
	else

		local VitimaTop = game.Players:FindFirstChild(Vitima)
		if VitimaTop.Character.Saude.Stances.Algemado.Value == false then
			VitimaTop.Character.Saude.Stances.Rendido.Value = Status
			VitimaTop.Character.Saude.Variaveis.HitCount.Value = 0
		end
	end
end)

Evt.Drag.OnServerEvent:Connect(function(player)
	local Human = player.Character.Humanoid
	local enabled = Human.Parent.Saude.Variaveis.Doer
	local MLs = Human.Parent.Saude.Variaveis.MLs
	local Caido = Human.Parent.Saude.Stances.Caido
	local Item = Human.Parent.Saude.Kit.Epinefrina


	local target = Human.Parent.Saude.Variaveis.PlayerSelecionado

	if Caido.Value == false and target.Value ~= "N/A" then

		local player2 = game.Players:FindFirstChild(target.Value)
		local PlHuman = player2.Character.Humanoid

		local Sangrando = PlHuman.Parent.Saude.Stances.Sangrando
		local MLs = PlHuman.Parent.Saude.Variaveis.MLs
		local Dor = PlHuman.Parent.Saude.Variaveis.Dor
		local Ferido = PlHuman.Parent.Saude.Stances.Ferido
		local PlCaido = PlHuman.Parent.Saude.Stances.Caido
		local Sang = PlHuman.Parent.Saude.Variaveis.Sangue

		if enabled.Value == false then

			if PlCaido.Value == true or PlCaido.Parent.Algemado.Value == true then 
				enabled.Value = true	

				coroutine.wrap(function()
					while target.Value ~= "N/A" and PlCaido.Value == true and PlHuman.Health > 0 and Human.Health > 0 and Human.Parent.Saude.Stances.Caido.Value == false or target.Value ~= "N/A" and PlCaido.Parent.Algemado.Value == true do wait() pcall(function()
							player2.Character.Torso.Anchored ,player2.Character.Torso.CFrame = true,Human.Parent.Torso.CFrame*CFrame.new(0,0.75,1.5)*CFrame.Angles(math.rad(0), math.rad(0), math.rad(90))
							enabled.Value = true
						end) end
					pcall(function() player2.Character.Torso.Anchored=false
						enabled.Value = false
					end)
				end)()

				enabled.Value = false
			end	
		end	
	end
end)

Evt.Squad.OnServerEvent:Connect(function(Player,SquadName,SquadColor)
	Player.Character.Saude.FireTeam.SquadName.Value = SquadName
	Player.Character.Saude.FireTeam.SquadColor.Value = SquadColor
end)

Evt.Afogar.OnServerEvent:Connect(function(Player)
	Player.Character.Humanoid.Health = 0
end)

------------------------------------------------------------------------
------------------------------------------------------------------------
------------------------------------------------------------------------

local Functions = Evt.MedSys
local FunctionsMulti = Evt.MedSys.Multi

local Compress = Functions.Compress
local Bandage = Functions.Bandage
local AltBandage = Functions.AltBandage
local Antidote = Functions.Antidote
local Splint = Functions.Splint
local PainKiller = Functions.PainKiller
local Energetic = Functions.Energetic
local Surgical = Functions.Surgical
local Tourniquet = Functions.Tourniquet

local Compress_Multi = FunctionsMulti.Compress
local Bandage_Multi = FunctionsMulti.Bandage
local Splint_Multi = FunctionsMulti.Splint
local Epinephrine_Multi = FunctionsMulti.Epinephrine
local Morphine_Multi = FunctionsMulti.Morphine
local BloodBag_Multi = FunctionsMulti.BloodBag
local Tourniquet_Multi = FunctionsMulti.Tourniquet

local Algemar = Functions.Algemar
local Fome = Functions.Fome
local Stance = Evt.MedSys.Stance
local Collapse = Functions.Collapse
local Reset = Functions.Reset
local ts = require(game.ReplicatedStorage.TService)

Compress.OnServerEvent:Connect(function(player)


	local Human = player.Character.Humanoid
	local enabled = Human.Parent.Saude.Variaveis.Doer
	local MLs = Human.Parent.Saude.Variaveis.MLs
	local Caido = Human.Parent.Saude.Stances.Caido

	if enabled.Value == false then

		if MLs.Value >= 2 then 
			enabled.Value = true

			wait(.3)		

			MLs.Value = 1

			wait(5)
			enabled.Value = false

		end	
	end
end)

Bandage.OnServerEvent:Connect(function(player)


	local Human = player.Character.Humanoid
	local enabled = Human.Parent.Saude.Variaveis.Doer
	local HeavyBleed = Human.Parent.Saude.Variaveis.HeavyBleed
	local Sangrando = Human.Parent.Saude.Stances.Sangrando
	local MLs = Human.Parent.Saude.Variaveis.MLs
	local Caido = Human.Parent.Saude.Stances.Caido
	local Ferido = Human.Parent.Saude.Stances.Ferido

	local Bandagens = Human.Parent.Saude.Kit.Bandagem

	if enabled.Value == false then

		if Bandagens.Value >= 1 and Sangrando.Value == true and HeavyBleed.Value == false then 
			enabled.Value = true

			wait(.3)		

			Sangrando.Value = false
			Bandagens.Value = Bandagens.Value - 1 


			wait(2)
			enabled.Value = false

		end	
	end	
end)

AltBandage.OnServerEvent:Connect(function(player)


	local Human = player.Character.Humanoid
	local enabled = Human.Parent.Saude.Variaveis.Doer
	local HeavyBleed = Human.Parent.Saude.Variaveis.HeavyBleed
	local Sangrando = Human.Parent.Saude.Stances.Sangrando
	local MLs = Human.Parent.Saude.Variaveis.MLs
	local Caido = Human.Parent.Saude.Stances.Caido
	local Ferido = Human.Parent.Saude.Stances.Ferido

	local Bandagens = Human.Parent.Saude.Kit.Bandagem2

	if enabled.Value == false then

		if Bandagens.Value >= 1 and Sangrando.Value == true and HeavyBleed.Value == true then 
			enabled.Value = true

			wait(.3)		

			Sangrando.Value = false
			HeavyBleed.Value = false
			Bandagens.Value = Bandagens.Value - 1 


			wait(2)
			enabled.Value = false

		end	
	end	
end)

Splint.OnServerEvent:Connect(function(player)


	local Human = player.Character.Humanoid
	local enabled = Human.Parent.Saude.Variaveis.Doer
	local Sangrando = Human.Parent.Saude.Stances.Sangrando
	local MLs = Human.Parent.Saude.Variaveis.MLs
	local Caido = Human.Parent.Saude.Stances.Caido
	local Ferido = Human.Parent.Saude.Stances.Ferido

	local Bandagens = Human.Parent.Saude.Kit.Splint

	if enabled.Value == false then

		if Bandagens.Value >= 1 and Ferido.Value == true  then 
			enabled.Value = true

			wait(.3)		
			for i,v in pairs(Human.Parent:GetChildren()) do
				--print("stage1")
				if v:IsA("BasePart") and v.Name == "Left Leg" or v.Name == "Right Leg" then
					--print("stage1.5")
					for i,valu in pairs (v:GetChildren()) do
						--print("stage2")
						if valu.Name == "HP" and valu.Value > 0 then
							Ferido.Value = false
							print("healed "..valu.Parent.Name)
						elseif valu.Name == "HP" and valu.Value <= 0 then
							print("failed bc legs are dead")
						end
					end
				end
			end
			--Ferido.Value = false 


			Bandagens.Value = Bandagens.Value - 1 


			wait(2)
			enabled.Value = false

		end	
	end	
end)

PainKiller.OnServerEvent:Connect(function(player)


	local Human = player.Character.Humanoid
	local enabled = Human.Parent.Saude.Variaveis.Doer
	local Sangrando = Human.Parent.Saude.Stances.Sangrando
	local MLs = Human.Parent.Saude.Variaveis.MLs
	local Dor = Human.Parent.Saude.Variaveis.Dor
	local Caido = Human.Parent.Saude.Stances.Caido
	local Ferido = Human.Parent.Saude.Stances.Ferido
	local Steady = Human.Parent.Saude.Stances.Steadiness

	local Bandagens = Human.Parent.Saude.Kit.Aspirina

	if enabled.Value == false then

		if Bandagens.Value >= 1  and Dor.Value >= 1  then
			enabled.Value = true

			wait(.3)		

			Dor.Value = Dor.Value - math.random(160,275)
			local time2 = math.random(120,300)
			local on = false
			if Ferido.Value == true or Steady.Value < 1 then
				Ferido.Value = false
				on = true
				PainKiller:FireClient(player,on)
				delay(time2,function()
					Ferido.Value = true
					on = false
					PainKiller:FireClient(player,on)
				end)
			end

			Bandagens.Value = Bandagens.Value - 1 


			wait(2)
			enabled.Value = false

		end	
	end	
end)

Antidote.OnServerEvent:Connect(function(player,tool)


	local Human = player.Character.Humanoid
	local enabled = Human.Parent.Saude.Variaveis.Doer
	local Sangrando = Human.Parent.Saude.Stances.Sangrando
	local MLs = Human.Parent.Saude.Variaveis.MLs
	local Dor = Human.Parent.Saude.Variaveis.Dor
	local Caido = Human.Parent.Saude.Stances.Caido
	local Ferido = Human.Parent.Saude.Stances.Ferido
	local Steady = Human.Parent.Saude.Stances.Steadiness

	local Bandagens = Human.Parent.Saude.Kit.Aspirina

	if enabled.Value == false then

		if Bandagens.Value >= 1  and Dor.Value >= 1  then
			enabled.Value = true

			wait(.3)		

			Dor.Value = Dor.Value - math.random(160,275)
			local time2 = math.random(120,300)
			local on = false
			for i,ok in pairs(player.Character:GetDescendants()) do
				if ok:IsA('Script') and ok:FindFirstChild("Antidote") and ok.Antidote.Value == tool.Name then
					ok:Destroy()
					print("Antidote cured "..ok.Name)
				end
			end
			if Ferido.Value == true or Steady.Value < 1 then
				Ferido.Value = false
				on = true
				PainKiller:FireClient(player,on)
				delay(time2,function()
					Ferido.Value = true
					on = false
					PainKiller:FireClient(player,on)
				end)
			end

			Bandagens.Value = Bandagens.Value - 1 


			wait(2)
			enabled.Value = false

		end	
	end	
end)
--local values = {}
Energetic.OnServerEvent:Connect(function(player)


	local Human = player.Character.Humanoid
	local enabled = Human.Parent.Saude.Variaveis.Doer
	local Sangrando = Human.Parent.Saude.Stances.Sangrando
	local MLs = Human.Parent.Saude.Variaveis.MLs
	local Dor = Human.Parent.Saude.Variaveis.Dor
	local Caido = Human.Parent.Saude.Stances.Caido
	local Ferido = Human.Parent.Saude.Stances.Ferido
	--local values = {}
	local Bandagens = Human.Parent.Saude.Kit.Energetico
	local Character = player.Character
	--local Energia = Human.Parent.Saude.Variaveis.Energia
	--[[for i,v in pairs(Human.Parent:GetDescendants()) do
		if v.Name == "HP" and v:IsA("DoubleConstrainedValue") then
			table.insert(values,v.Value)
		end
	end]]--
	--local min = (math.min(table.unpack(values)))
	if enabled.Value == false then

		if (Human.Health) < Human.MaxHealth  then
			enabled.Value = true

			wait(.3)		

			--Human.Health = Human.Health + (Human.MaxHealth/3)
			for i,v in pairs(Human.Parent:GetChildren()) do
				--print("stage1")
				if v:IsA("BasePart") then
					--print("stage1.5")
					for i,valu in pairs (v:GetChildren()) do
						--print("stage2")
						if valu.Name == "HP" and valu.Value > 0 then
							valu.Value = valu.Value + (valu.MaxValue/3)
							print("healed "..valu.Value.." "..valu.Parent.Name)

						end
					end
				end
			end
			Energetic:FireClient(player)
			--Energia.Value = Energia.Value + (Energia.MaxValue/3)
			Bandagens.Value = Bandagens.Value - 1
			if Character.Humanoid.Health > 0 and Character:WaitForChild("Head"):WaitForChild("HP").Value > 0 then
				Character.Humanoid.Health = (Character:WaitForChild("Head"):WaitForChild("HP").Value + Character:WaitForChild("Torso"):WaitForChild("HP").Value + Character:WaitForChild("Stomach"):WaitForChild("HP").Value  + Character:WaitForChild("Left Arm"):WaitForChild("HP").Value + Character:WaitForChild("Right Arm"):WaitForChild("HP").Value + Character:WaitForChild("Left Leg"):WaitForChild("HP").Value + Character:WaitForChild("Right Leg"):WaitForChild("HP").Value)
			elseif Character:WaitForChild("Head"):WaitForChild("HP").Value <= 0 then
				Character.Humanoid.Health = 0
			end

			wait(2)
			enabled.Value = false

		end	
	end	
end)

Surgical.OnServerEvent:Connect(function(player)


	local Human = player.Character.Humanoid
	local enabled = Human.Parent.Saude.Variaveis.Doer
	local Sangrando = Human.Parent.Saude.Stances.Sangrando
	local MLs = Human.Parent.Saude.Variaveis.MLs
	local Dor = Human.Parent.Saude.Variaveis.Dor
	local Caido = Human.Parent.Saude.Stances.Caido
	local Ferido = Human.Parent.Saude.Stances.Ferido
	--local values = {}
	local Bandagens = Human.Parent.Saude.Kit.Surgical
	local Character = player.Character
	--local Energia = Human.Parent.Saude.Variaveis.Energia
	--[[for i,v in pairs(Human.Parent:GetDescendants()) do
		if v.Name == "HP" and v:IsA("DoubleConstrainedValue") then
			table.insert(values,v.Value)
		end
	end]]--
	--local min = (math.min(table.unpack(values)))
	if enabled.Value == false then

		if (Human.Health) < Human.MaxHealth  then
			enabled.Value = true

			wait(.3)		

			--Human.Health = Human.Health + (Human.MaxHealth/3)
			for i,v in pairs(Human.Parent:GetChildren()) do
				--print("stage1")
				if v:IsA("BasePart") then
					--print("stage1.5")
					for i,valu in pairs (v:GetChildren()) do
						--print("stage2")
						if valu.Name == "HP" and valu.Value <= 0 then
							Bandagens.Value = Bandagens.Value - 1
							valu.Value = 1
							valu.MaxValue = math.ceil(valu.MaxValue - (valu.MaxValue/9))
							print("healed "..valu.Value.." "..valu.Parent.Name)

						end
					end
				end
			end
			Surgical:FireClient(player)
			print("uses left: "..Bandagens.Value)
			--Energia.Value = Energia.Value + (Energia.MaxValue/3)
			if Character.Humanoid.Health > 0 and Character:WaitForChild("Head"):WaitForChild("HP").Value > 0 then
				Character.Humanoid.Health = (Character:WaitForChild("Head"):WaitForChild("HP").Value + Character:WaitForChild("Torso"):WaitForChild("HP").Value + Character:WaitForChild("Left Arm"):WaitForChild("HP").Value + Character:WaitForChild("Right Arm"):WaitForChild("HP").Value + Character:WaitForChild("Left Leg"):WaitForChild("HP").Value + Character:WaitForChild("Right Leg"):WaitForChild("HP").Value)
			elseif Character:WaitForChild("Head"):WaitForChild("HP").Value <= 0 then
				Character.Humanoid.Health = 0
			end

			wait(2)
			enabled.Value = false

		end	
	end	
end)

Tourniquet.OnServerEvent:Connect(function(player)


	local Human = player.Character.Humanoid
	local enabled = Human.Parent.Saude.Variaveis.Doer
	local Sangrando = Human.Parent.Saude.Stances.Sangrando
	local MLs = Human.Parent.Saude.Variaveis.MLs
	local Dor = Human.Parent.Saude.Variaveis.Dor
	local Caido = Human.Parent.Saude.Stances.Caido
	local Ferido = Human.Parent.Saude.Stances.Ferido

	local Bandagens = Human.Parent.Saude.Kit.Tourniquet

	if Human.Parent.Saude.Stances.Tourniquet.Value == false then
		if enabled.Value == false and Sangrando.Value == true and Bandagens.Value > 0 then
			enabled.Value = true

			wait(.3)		

			Human.Parent.Saude.Stances.Tourniquet.Value = true
			Bandagens.Value = Bandagens.Value - 1


			wait(2)
			enabled.Value = false

		end	
	else
		if enabled.Value == false then
			enabled.Value = true

			wait(.3)		

			Human.Parent.Saude.Stances.Tourniquet.Value = false
			Bandagens.Value = Bandagens.Value + 1


			wait(2)
			enabled.Value = false
		end
	end
end)

------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------


Compress_Multi.OnServerEvent:Connect(function(player)

	local Human = player.Character.Humanoid
	local enabled = Human.Parent.Saude.Variaveis.Doer
	local MLs = Human.Parent.Saude.Variaveis.MLs
	local Caido = Human.Parent.Saude.Stances.Caido

	local target = Human.Parent.Saude.Variaveis.PlayerSelecionado

	if Caido.Value == false and target.Value ~= "N/A" then

		local player2 = game.Players:FindFirstChild(target.Value)
		local PlHuman = player2.Character.Humanoid


		local Sangrando = PlHuman.Parent.Saude.Stances.Sangrando
		local MLs = PlHuman.Parent.Saude.Variaveis.MLs
		local Dor = PlHuman.Parent.Saude.Variaveis.Dor

		if enabled.Value == false then

			if MLs.Value > 1 then 
				enabled.Value = true

				wait(.3)		

				MLs.Value = MLs.Value - math.random(50,75)

				wait(5)
				enabled.Value = false
			end	

		end	
	end
end)

Bandage_Multi.OnServerEvent:Connect(function(player)

	local Human = player.Character.Humanoid
	local enabled = Human.Parent.Saude.Variaveis.Doer
	local MLs = Human.Parent.Saude.Variaveis.MLs
	local Caido = Human.Parent.Saude.Stances.Caido
	local Item = Human.Parent.Saude.Kit.Bandagem

	local target = Human.Parent.Saude.Variaveis.PlayerSelecionado

	if Caido.Value == false and target.Value ~= "N/A" then

		local player2 = game.Players:FindFirstChild(target.Value)
		local PlHuman = player2.Character.Humanoid


		local Sangrando = PlHuman.Parent.Saude.Stances.Sangrando
		local MLs = PlHuman.Parent.Saude.Variaveis.MLs
		local Dor = PlHuman.Parent.Saude.Variaveis.Dor
		local Ferido = PlHuman.Parent.Saude.Stances.Ferido

		if enabled.Value == false then

			if Item.Value >= 1 and Sangrando.Value == true then 
				enabled.Value = true

				wait(.3)		

				Sangrando.Value = false	
				Item.Value = Item.Value - 1 


				wait(2)
				enabled.Value = false
			end	

		end	
	end
end)

Splint_Multi.OnServerEvent:Connect(function(player)

	local Human = player.Character.Humanoid
	local enabled = Human.Parent.Saude.Variaveis.Doer
	local MLs = Human.Parent.Saude.Variaveis.MLs
	local Caido = Human.Parent.Saude.Stances.Caido
	local Item = Human.Parent.Saude.Kit.Splint

	local target = Human.Parent.Saude.Variaveis.PlayerSelecionado

	if Caido.Value == false and target.Value ~= "N/A" then

		local player2 = game.Players:FindFirstChild(target.Value)
		local PlHuman = player2.Character.Humanoid


		local Sangrando = PlHuman.Parent.Saude.Stances.Sangrando
		local MLs = PlHuman.Parent.Saude.Variaveis.MLs
		local Dor = PlHuman.Parent.Saude.Variaveis.Dor
		local Ferido = PlHuman.Parent.Saude.Stances.Ferido

		if enabled.Value == false then

			if Item.Value >= 1 and Ferido.Value == true  then 
				enabled.Value = true

				wait(.3)		

				Ferido.Value = false		

				Item.Value = Item.Value - 1 


				wait(2)
				enabled.Value = false
			end	

		end	
	end
end)

Tourniquet_Multi.OnServerEvent:Connect(function(player)

	local Human = player.Character.Humanoid
	local enabled = Human.Parent.Saude.Variaveis.Doer
	local MLs = Human.Parent.Saude.Variaveis.MLs
	local Caido = Human.Parent.Saude.Stances.Caido
	local Item = Human.Parent.Saude.Kit.Tourniquet

	local target = Human.Parent.Saude.Variaveis.PlayerSelecionado

	if Caido.Value == false and target.Value ~= "N/A" then

		local player2 = game.Players:FindFirstChild(target.Value)
		local PlHuman = player2.Character.Humanoid


		local Sangrando = PlHuman.Parent.Saude.Stances.Sangrando
		local MLs = PlHuman.Parent.Saude.Variaveis.MLs
		local Dor = PlHuman.Parent.Saude.Variaveis.Dor
		local Ferido = PlHuman.Parent.Saude.Stances.Ferido


		if PlHuman.Parent.Saude.Stances.Tourniquet.Value == false then

			if enabled.Value == false then
				if Item.Value > 0 and Sangrando.Value == true then 
					enabled.Value = true

					wait(.3)		

					PlHuman.Parent.Saude.Stances.Tourniquet.Value = true		

					Item.Value = Item.Value - 1 


					wait(2)
					enabled.Value = false
				end
			end	
		else
			if enabled.Value == false then
				if PlHuman.Parent.Saude.Stances.Tourniquet.Value == true then 
					enabled.Value = true

					wait(.3)		

					PlHuman.Parent.Saude.Stances.Tourniquet.Value = false		

					Item.Value = Item.Value + 1 


					wait(2)
					enabled.Value = false
				end
			end	
		end
	end
end)

Epinephrine_Multi.OnServerEvent:Connect(function(player)

	local Human = player.Character.Humanoid
	local enabled = Human.Parent.Saude.Variaveis.Doer
	local MLs = Human.Parent.Saude.Variaveis.MLs
	local Caido = Human.Parent.Saude.Stances.Caido
	local Item = Human.Parent.Saude.Kit.Epinefrina

	local target = Human.Parent.Saude.Variaveis.PlayerSelecionado

	if Caido.Value == false and target.Value ~= "N/A" then

		local player2 = game.Players:FindFirstChild(target.Value)
		local PlHuman = player2.Character.Humanoid


		local Sangrando = PlHuman.Parent.Saude.Stances.Sangrando
		local MLs = PlHuman.Parent.Saude.Variaveis.MLs
		local Dor = PlHuman.Parent.Saude.Variaveis.Dor
		local Ferido = PlHuman.Parent.Saude.Stances.Ferido
		local PlCaido = PlHuman.Parent.Saude.Stances.Caido

		if enabled.Value == false then

			if Item.Value >= 1 and PlCaido.Value == true then 
				enabled.Value = true


				wait(.3)		

				if Dor.Value > 0 then
					Dor.Value = Dor.Value + math.random(10,20)
				end

				if Sangrando.Value == true then
					MLs.Value = MLs.Value + math.random(10,35)
				end

				PlCaido.Value = false		

				Item.Value = Item.Value - 1 


				wait(2)
				enabled.Value = false
			end	

		end	
	end
end)


Morphine_Multi.OnServerEvent:Connect(function(player)

	local Human = player.Character.Humanoid
	local enabled = Human.Parent.Saude.Variaveis.Doer
	local MLs = Human.Parent.Saude.Variaveis.MLs
	local Caido = Human.Parent.Saude.Stances.Caido
	local Item = Human.Parent.Saude.Kit.Morfina

	local target = Human.Parent.Saude.Variaveis.PlayerSelecionado

	if Caido.Value == false and target.Value ~= "N/A" then

		local player2 = game.Players:FindFirstChild(target.Value)
		local PlHuman = player2.Character.Humanoid


		local Sangrando = PlHuman.Parent.Saude.Stances.Sangrando
		local MLs = PlHuman.Parent.Saude.Variaveis.MLs
		local Dor = PlHuman.Parent.Saude.Variaveis.Dor
		local Ferido = PlHuman.Parent.Saude.Stances.Ferido
		local PlCaido = PlHuman.Parent.Saude.Stances.Caido

		if enabled.Value == false then

			if Item.Value >= 1 and Dor.Value >= 1 then 
				enabled.Value = true

				wait(.3)		

				Dor.Value = Dor.Value - math.random(100,150)

				Item.Value = Item.Value - 1 


				wait(2)
				enabled.Value = false
			end	

		end	
	end
end)


BloodBag_Multi.OnServerEvent:Connect(function(player)

	local Human = player.Character.Humanoid
	local enabled = Human.Parent.Saude.Variaveis.Doer
	local MLs = Human.Parent.Saude.Variaveis.MLs
	local Caido = Human.Parent.Saude.Stances.Caido
	local Item = Human.Parent.Saude.Kit.SacoDeSangue

	local target = Human.Parent.Saude.Variaveis.PlayerSelecionado

	if Caido.Value == false and target.Value ~= "N/A" then

		local player2 = game.Players:FindFirstChild(target.Value)
		local PlHuman = player2.Character.Humanoid


		local Sangrando = PlHuman.Parent.Saude.Stances.Sangrando
		local MLs = PlHuman.Parent.Saude.Variaveis.MLs
		local Dor = PlHuman.Parent.Saude.Variaveis.Dor
		local Ferido = PlHuman.Parent.Saude.Stances.Ferido
		local PlCaido = PlHuman.Parent.Saude.Stances.Caido
		local Sang = PlHuman.Parent.Saude.Variaveis.Sangue

		if enabled.Value == false then

			if Item.Value >= 1 and Sangrando.Value == false and Sang.Value < 7000 then 
				enabled.Value = true

				wait(.3)		

				Sang.Value = Sang.MaxValue

				Item.Value = Item.Value - 1 


				wait(2)
				enabled.Value = false
			end	

		end	
	end
end)


------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------

Collapse.OnServerEvent:Connect(function(player)

	local Human = player.Character.Humanoid
	local Dor = Human.Parent.Saude.Variaveis.Dor
	local Sangue = Human.Parent.Saude.Variaveis.Sangue
	local IsWounded = Human.Parent.Saude.Stances.Caido


	if (Sangue.Value <= 3500) or (Dor.Value >= 200)  or (IsWounded.Value == true) then -- Man this Guy's Really wounded,
		IsWounded.Value = true	
	elseif (Sangue.Value > 3500) and (Dor.Value < 200) and (IsWounded.Value == true) then -- YAY A MEDIC ARRIVED! =D
		IsWounded.Value = false

	end
end)

Reset.OnServerEvent:Connect(function(player)

	local Human = player.Character.Humanoid
	local target = Human.Parent.Saude.Variaveis.PlayerSelecionado

	target.Value = "N/A"
end)

------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------

Stance.OnServerEvent:connect(function(Player, L_97_arg2, Virar, Rendido, fast)

	local char		= Player.Character
	if char:FindFirstChild('Humanoid') and char.Humanoid.Health > 0 then
		local Torso		= char:WaitForChild("Torso")
		local Saude 	= char:WaitForChild("Saude")

		local RootPart 	= char:WaitForChild("HumanoidRootPart")
		local RootJoint = RootPart:WaitForChild("RootJoint")
		local Neck 		= char["Torso"]:WaitForChild("Neck")
		local RS 		= char["Torso"]:WaitForChild("Right Shoulder")
		local LS 		= char["Torso"]:WaitForChild("Left Shoulder")
		local RH 		= char["Torso"]:WaitForChild("Right Hip")
		local LH 		= char["Torso"]:WaitForChild("Left Hip")
		local LeftLeg 	= char["Left Leg"]
		local RightLeg 	= char["Right Leg"]
		local num = math.random(1,6)

		--RootJoint.C1 	= CFrame.new(math.rad(-90),math.rad(-180),math.rad(0))
		Saude.Stances.Stance.Value = L_97_arg2
		if L_97_arg2 == 2 and char then

			if fast == false then
				--ts(RootJoint, TweenInfo.new(.4,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut), {C0 = CFrame.new(0,-2.5,1.35)* CFrame.Angles(math.rad(-90),0,math.rad(0))} ):Play()
				ts(RootJoint, TweenInfo.new(.4,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut), {C0 = CFrame.new(0,-2.5,0.75)* CFrame.Angles(math.rad(0),math.rad(180),math.rad(0))} ):Play()
				ts(RH, TweenInfo.new(.6,Enum.EasingStyle.Back,Enum.EasingDirection.Out), {C0 = CFrame.new(1,-1,0)* CFrame.Angles(math.rad(-0),math.rad(90),math.rad(0))} ):Play()
				ts(LH, TweenInfo.new(.6,Enum.EasingStyle.Back,Enum.EasingDirection.Out), {C0 = CFrame.new(-1,-1,0)* CFrame.Angles(math.rad(-0),math.rad(-90),math.rad(0))} ):Play()
				ts(RS, TweenInfo.new(.4,Enum.EasingStyle.Back,Enum.EasingDirection.In), {C0 = CFrame.new(0.9,1.1,0)* CFrame.Angles(math.rad(-180),math.rad(90),math.rad(0))} ):Play()
				ts(LS, TweenInfo.new(.4,Enum.EasingStyle.Back,Enum.EasingDirection.In), {C0 = CFrame.new(-0.9,1.1,0)* CFrame.Angles(math.rad(-180),math.rad(-90),math.rad(0))} ):Play()
				-- ts(Neck,	TweenInfo.new(.3), {C0 = CFrame.new(0,1.25,0.2)* CFrame.Angles(math.rad(0),math.rad(0),math.rad(180))} ):Play()
				if laststance ~= 2 then
					char.Torso["P"..num]:Play()
					laststance = 2
					--Evt.ProneToggle:Fire(L_97_arg2,"ProneDown")
					--print("boop")
				end
			--[[else
				ts(RootJoint, TweenInfo.new(.1), {C0 = CFrame.new(0,-2.5,1.35)* CFrame.Angles(math.rad(-90),0,math.rad(0))} ):Play()
				ts(RH, TweenInfo.new(.1), {C0 = CFrame.new(1,-1,0)* CFrame.Angles(math.rad(-0),math.rad(90),math.rad(0))} ):Play()
				ts(LH, TweenInfo.new(.1), {C0 = CFrame.new(-1,-1,0)* CFrame.Angles(math.rad(-0),math.rad(-90),math.rad(0))} ):Play()
				ts(RS, TweenInfo.new(.1), {C0 = CFrame.new(0.9,1.1,0)* CFrame.Angles(math.rad(-180),math.rad(90),math.rad(0))} ):Play()
				ts(LS, TweenInfo.new(.1), {C0 = CFrame.new(-0.9,1.1,0)* CFrame.Angles(math.rad(-180),math.rad(-90),math.rad(0))} ):Play()
				-- ts(Neck,	TweenInfo.new(.3), {C0 = CFrame.new(0,1.25,0.2)* CFrame.Angles(math.rad(0),math.rad(0),math.rad(180))} ):Play()
				if laststance ~= 2 then
					char.Torso:WaitForChild("DiveSFX"):Play()
					laststance = 2
					--Evt.ProneToggle:Fire(L_97_arg2,"ProneDown")
					--print("boop")
				end]]--
			end


		elseif L_97_arg2 == 1 and char then

			if fast == false then
				--ts(RootJoint, TweenInfo.new(.3,Enum.EasingStyle.Back,Enum.EasingDirection.InOut), {C0 = CFrame.new(0,-1,0.25)* CFrame.Angles(math.rad(-10),0,math.rad(0))} ):Play()
				ts(RootJoint, TweenInfo.new(2,Enum.EasingStyle.Back,Enum.EasingDirection.InOut), {C0 = CFrame.new(0,-1,0.25)* CFrame.Angles(math.rad(0),math.rad(180),math.rad(0))} ):Play()
				ts(RH, TweenInfo.new(2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out), {C0 = CFrame.new(1,-0.35,-0.65)* CFrame.Angles(math.rad(-20),math.rad(90),math.rad(0))} ):Play()
				ts(LH, TweenInfo.new(2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out), {C0 = CFrame.new(-1,-1.25,-0.625)* CFrame.Angles(math.rad(-60),math.rad(-90),math.rad(0))} ):Play()
				ts(RS, TweenInfo.new(2,Enum.EasingStyle.Back,Enum.EasingDirection.In), {C0 = CFrame.new(1,0.5,0)* CFrame.Angles(math.rad(0),math.rad(90),math.rad(0))} ):Play()
				ts(LS, TweenInfo.new(2,Enum.EasingStyle.Back,Enum.EasingDirection.In), {C0 = CFrame.new(-1,0.5,0)* CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0))} ):Play()
				-- ts(Neck,	TweenInfo.new(.3), {C0 = CFrame.new(0,1,0)* CFrame.Angles(math.rad(-80),math.rad(0),math.rad(180))} ):Play()
				if laststance ~= 1 then
					char.Torso:WaitForChild("CrouchSFX"):Play()
					if laststance == 2 then
						--Evt.ProneToggle:Fire(L_97_arg2,"ProneUp")
						--print("boop")
					end
					laststance = 1

				end
			else
				--ts(RootJoint, TweenInfo.new(.1), {C0 = CFrame.new(0,-1,0.25)* CFrame.Angles(math.rad(-10),0,math.rad(0))} ):Play()
				ts(RootJoint, TweenInfo.new(2), {C0 = CFrame.new(0,-1,0.25)* CFrame.Angles(math.rad(80),math.rad(180),math.rad(0))} ):Play()
				ts(RH, TweenInfo.new(2), {C0 = CFrame.new(1,-0.35,-0.65)* CFrame.Angles(math.rad(-20),math.rad(90),math.rad(0))} ):Play()
				ts(LH, TweenInfo.new(2), {C0 = CFrame.new(-1,-1.25,-0.625)* CFrame.Angles(math.rad(-60),math.rad(-90),math.rad(0))} ):Play()
				ts(RS, TweenInfo.new(2), {C0 = CFrame.new(1,0.5,0)* CFrame.Angles(math.rad(0),math.rad(90),math.rad(0))} ):Play()
				ts(LS, TweenInfo.new(2), {C0 = CFrame.new(-1,0.5,0)* CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0))} ):Play()
				-- ts(Neck,	TweenInfo.new(.3), {C0 = CFrame.new(0,1,0)* CFrame.Angles(math.rad(-80),math.rad(0),math.rad(180))} ):Play()
				if laststance ~= 1 then
					char.Torso:WaitForChild("CrouchSFX"):Play()
					if laststance == 2 then
						--Evt.ProneToggle:Fire(L_97_arg2,"ProneUp")
						--print("boop")
					end
					laststance = 1

				end
			end
			

		elseif L_97_arg2 == 0 and char then	

			--ts(RootJoint, TweenInfo.new(.3), {C0 = CFrame.new(0,0,0)* CFrame.Angles(math.rad(-0),0,math.rad(0))} ):Play()
			ts(RootJoint, TweenInfo.new(.5), {C0 = CFrame.new(0,0,0)* CFrame.Angles(math.rad(90),math.rad(180),math.rad(0))} ):Play()
			ts(RH, TweenInfo.new(.5), {C0 = CFrame.new(1,-1,0)* CFrame.Angles(math.rad(-0),math.rad(90),math.rad(0))} ):Play()
			ts(LH, TweenInfo.new(.5), {C0 = CFrame.new(-1,-1,0)* CFrame.Angles(math.rad(-0),math.rad(-90),math.rad(0))} ):Play()
			ts(RS, TweenInfo.new(.5), {C0 = CFrame.new(1,0.5,0)* CFrame.Angles(math.rad(0),math.rad(90),math.rad(0))} ):Play()
			ts(LS, TweenInfo.new(.5), {C0 = CFrame.new(-1,0.5,0)* CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0))} ):Play()
			-- ts(Neck,	TweenInfo.new(.3), {C0 = CFrame.new(0,1,0)* CFrame.Angles(math.rad(-90),math.rad(0),math.rad(180))} ):Play()
			if laststance ~= 0 then
				char.Torso:WaitForChild("StandSFX"):Play()
				if laststance == 2 then
					--Evt.ProneToggle:Fire(L_97_arg2,"ProneUp")
					--print("boop")
				end
				laststance = 0

			end
		end
		if Virar == 1 then
			if L_97_arg2 == 0 then
				--ts(RootJoint, TweenInfo.new(.3), {C0 = CFrame.new(1,0,0) * CFrame.Angles(math.rad(0),0,math.rad(-30))} ):Play()
				ts(RootJoint, TweenInfo.new(.3), {C0 = CFrame.new(1,0,0) * CFrame.Angles(math.rad(90),math.rad(150),math.rad(0))} ):Play()
				ts(RH, TweenInfo.new(.3), {C0 = CFrame.new(1,-1,0)* CFrame.Angles(math.rad(0),math.rad(90),math.rad(0))} ):Play()
				ts(LH, TweenInfo.new(.3), {C0 = CFrame.new(-1,-1,0)* CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0))} ):Play()
				ts(RS, TweenInfo.new(.3), {C0 = CFrame.new(1,0.5,0)* CFrame.Angles(math.rad(0),math.rad(90),math.rad(0))} ):Play()
				ts(LS, TweenInfo.new(.3), {C0 = CFrame.new(-1,0.5,0)* CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0))} ):Play()
				--ts(Neck,	TweenInfo.new(.3), {C0 = CFrame.new(0,1,0)* CFrame.Angles(math.rad(-90),math.rad(0),math.rad(180))} ):Play()
				char.Torso:WaitForChild("LeanSFX1"):Play()
			elseif L_97_arg2 == 1 then
				--ts(RootJoint, TweenInfo.new(.3), {C0 = CFrame.new(1,-1,0.25)* CFrame.Angles(math.rad(-10),0,math.rad(-30))} ):Play()
				ts(RootJoint, TweenInfo.new(.3), {C0 = CFrame.new(1,-1,0.25)* CFrame.Angles(math.rad(80),math.rad(150),math.rad(0))} ):Play()
				ts(RH, TweenInfo.new(.3), {C0 = CFrame.new(1,-0.35,-0.65)* CFrame.Angles(math.rad(-20),math.rad(90),math.rad(0))} ):Play()
				ts(LH, TweenInfo.new(.3), {C0 = CFrame.new(-1,-1.25,-0.625)* CFrame.Angles(math.rad(-60),math.rad(-90),math.rad(0))} ):Play()
				ts(RS, TweenInfo.new(.3), {C0 = CFrame.new(1,0.5,0)* CFrame.Angles(math.rad(0),math.rad(90),math.rad(0))} ):Play()
				ts(LS, TweenInfo.new(.3), {C0 = CFrame.new(-1,0.5,0)* CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0))} ):Play()
				--ts(Neck,	TweenInfo.new(.3), {C0 = CFrame.new(0,1,0)* CFrame.Angles(math.rad(-80),math.rad(0),math.rad(180))} ):Play()
				char.Torso:WaitForChild("LeanSFX1"):Play()
			elseif L_97_arg2 == 2 then
				--ts(RootJoint, TweenInfo.new(.3), {C0 = CFrame.new(1,-2.5,1.35)* CFrame.Angles(math.rad(-90),0,math.rad(-30))} ):Play()
				ts(RootJoint, TweenInfo.new(.3), {C0 = CFrame.new(1,-2.5,-0.15)* CFrame.Angles(math.rad(-0),math.rad(-180),math.rad(30))} ):Play()
				ts(RH, TweenInfo.new(.3), {C0 = CFrame.new(1,-1,0)* CFrame.Angles(math.rad(-0),math.rad(90),math.rad(0))} ):Play()
				ts(LH, TweenInfo.new(.3), {C0 = CFrame.new(-1,-1,0)* CFrame.Angles(math.rad(-0),math.rad(-90),math.rad(0))} ):Play()
				ts(RS, TweenInfo.new(.3), {C0 = CFrame.new(0.9,1.1,0)* CFrame.Angles(math.rad(-180),math.rad(90),math.rad(0))} ):Play()
				ts(LS, TweenInfo.new(.3), {C0 = CFrame.new(-0.9,1.1,0)* CFrame.Angles(math.rad(-180),math.rad(-90),math.rad(0))} ):Play()
				--ts(Neck,	TweenInfo.new(.3), {C0 = CFrame.new(0,1.25,0)* CFrame.Angles(math.rad(0),math.rad(0),math.rad(180))} ):Play()
				char.Torso:WaitForChild("LeanSFX1"):Play()
			end
		elseif Virar == -1 then
			if L_97_arg2 == 0 then
				--ts(RootJoint, TweenInfo.new(.3), {C0 = CFrame.new(-1,0,0) * CFrame.Angles(math.rad(0),0,math.rad(30))} ):Play()
				ts(RootJoint, TweenInfo.new(.3), {C0 = CFrame.new(-1,0,0) * CFrame.Angles(math.rad(90),math.rad(-150),math.rad(0))} ):Play()
				ts(RH, TweenInfo.new(.3), {C0 = CFrame.new(1,-1,0)* CFrame.Angles(math.rad(-0),math.rad(90),math.rad(0))} ):Play()
				ts(LH, TweenInfo.new(.3), {C0 = CFrame.new(-1,-1,0)* CFrame.Angles(math.rad(-0),math.rad(-90),math.rad(0))} ):Play()
				ts(RS, TweenInfo.new(.3), {C0 = CFrame.new(1,0.5,0)* CFrame.Angles(math.rad(0),math.rad(90),math.rad(0))} ):Play()
				ts(LS, TweenInfo.new(.3), {C0 = CFrame.new(-1,0.5,0)* CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0))} ):Play()
				--ts(Neck,	TweenInfo.new(.3), {C0 = CFrame.new(0,1,0)* CFrame.Angles(math.rad(-90),math.rad(0),math.rad(180))} ):Play()
				char.Torso:WaitForChild("LeanSFX2"):Play()
			elseif L_97_arg2 == 1 then
				--ts(RootJoint, TweenInfo.new(.3), {C0 = CFrame.new(-1,-1,0.25)* CFrame.Angles(math.rad(-10),0,math.rad(30))} ):Play()
				ts(RootJoint, TweenInfo.new(.3), {C0 = CFrame.new(-1,-1,0.25)* CFrame.Angles(math.rad(80),math.rad(-150),math.rad(0))} ):Play()
				ts(RH, TweenInfo.new(.3), {C0 = CFrame.new(1,-0.35,-0.65)* CFrame.Angles(math.rad(-20),math.rad(90),math.rad(0))} ):Play()
				ts(LH, TweenInfo.new(.3), {C0 = CFrame.new(-1,-1.25,-0.625)* CFrame.Angles(math.rad(-60),math.rad(-90),math.rad(0))} ):Play()
				ts(RS, TweenInfo.new(.3), {C0 = CFrame.new(1,0.5,0)* CFrame.Angles(math.rad(0),math.rad(90),math.rad(0))} ):Play()
				ts(LS, TweenInfo.new(.3), {C0 = CFrame.new(-1,0.5,0)* CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0))} ):Play()
				--ts(Neck,	TweenInfo.new(.3), {C0 = CFrame.new(0,1,0)* CFrame.Angles(math.rad(-80),math.rad(0),math.rad(180))} ):Play()
				char.Torso:WaitForChild("LeanSFX2"):Play()
			elseif L_97_arg2 == 2 then
				--ts(RootJoint, TweenInfo.new(.3), {C0 = CFrame.new(-1,-2.5,1.35)* CFrame.Angles(math.rad(-90),0,math.rad(30))} ):Play()
				ts(RootJoint, TweenInfo.new(.3), {C0 = CFrame.new(-1,-2.5,-0.15)* CFrame.Angles(math.rad(-0),math.rad(-180),math.rad(-30))} ):Play()
				ts(RH, TweenInfo.new(.3), {C0 = CFrame.new(1,-1,0)* CFrame.Angles(math.rad(-0),math.rad(90),math.rad(0))} ):Play()
				ts(LH, TweenInfo.new(.3), {C0 = CFrame.new(-1,-1,0)* CFrame.Angles(math.rad(-0),math.rad(-90),math.rad(0))} ):Play()
				ts(RS, TweenInfo.new(.3), {C0 = CFrame.new(0.9,1.1,0)* CFrame.Angles(math.rad(-180),math.rad(90),math.rad(0))} ):Play()
				ts(LS, TweenInfo.new(.3), {C0 = CFrame.new(-0.9,1.1,0)* CFrame.Angles(math.rad(-180),math.rad(-90),math.rad(0))} ):Play()
				--ts(Neck,	TweenInfo.new(.3), {C0 = CFrame.new(0,1.25,0)* CFrame.Angles(math.rad(0),math.rad(0),math.rad(180))} ):Play()
				char.Torso:WaitForChild("LeanSFX2"):Play()
			end
		elseif Virar == 0 then
			if L_97_arg2 == 0 then
				--ts(RootJoint, TweenInfo.new(.3), {C0 = CFrame.new(0,0,0)* CFrame.Angles(math.rad(-0),0,math.rad(0))} ):Play()
				ts(RootJoint, TweenInfo.new(.5), {C0 = CFrame.new(0,0,0)* CFrame.Angles(math.rad(90),math.rad(180),math.rad(0))} ):Play()
				ts(RH, TweenInfo.new(.5), {C0 = CFrame.new(1,-1,0)* CFrame.Angles(math.rad(-0),math.rad(90),math.rad(0))} ):Play()
				ts(LH, TweenInfo.new(.5), {C0 = CFrame.new(-1,-1,0)* CFrame.Angles(math.rad(-0),math.rad(-90),math.rad(0))} ):Play()
				ts(RS, TweenInfo.new(.5), {C0 = CFrame.new(1,0.5,0)* CFrame.Angles(math.rad(0),math.rad(90),math.rad(0))} ):Play()
				ts(LS, TweenInfo.new(.5), {C0 = CFrame.new(-1,0.5,0)* CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0))} ):Play()
				--ts(Neck,	TweenInfo.new(.3), {C0 = CFrame.new(0,1,0)* CFrame.Angles(math.rad(-90),math.rad(0),math.rad(180))} ):Play()
				if laststance ~= 0 then
					char.Torso:WaitForChild("StandSFX"):Play()
					if laststance == 2 then
						--	Evt.ProneToggle:Fire(L_97_arg2,"ProneUp")
						--print("boop")
					end
					laststance = 0

				end
			elseif L_97_arg2 == 1 then
				ts(RootJoint, TweenInfo.new(0.8,Enum.EasingStyle.Back,Enum.EasingDirection.Out), {C0 = CFrame.new(0,-1,0.25)* CFrame.Angles(math.rad(80),math.rad(180),math.rad(0))} ):Play()
				ts(RH, TweenInfo.new(0.8,Enum.EasingStyle.Back,Enum.EasingDirection.Out), {C0 = CFrame.new(1,-0.35,-0.65)* CFrame.Angles(math.rad(-20),math.rad(90),math.rad(0))} ):Play()
				ts(LH, TweenInfo.new(0.8,Enum.EasingStyle.Back,Enum.EasingDirection.Out), {C0 = CFrame.new(-1,-1.25,-0.625)* CFrame.Angles(math.rad(-60),math.rad(-90),math.rad(0))} ):Play()
				ts(RS, TweenInfo.new(0.8,Enum.EasingStyle.Back,Enum.EasingDirection.Out), {C0 = CFrame.new(1,0.5,0)* CFrame.Angles(math.rad(0),math.rad(90),math.rad(0))} ):Play()
				ts(LS, TweenInfo.new(0.8,Enum.EasingStyle.Back,Enum.EasingDirection.Out), {C0 = CFrame.new(-1,0.5,0)* CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0))} ):Play()
				--ts(Neck,	TweenInfo.new(.3), {C0 = CFrame.new(0,1,0)* CFrame.Angles(math.rad(-80),math.rad(0),math.rad(180))} ):Play()
				if laststance ~= 1 then
					char.Torso:WaitForChild("CrouchSFX"):Play()
					if laststance == 2 then
						--Evt.ProneToggle:Fire(L_97_arg2,"ProneUp")
						--print("boop")
					end
					laststance = 1

				end
			elseif L_97_arg2 == 2 then
				ts(RootJoint, TweenInfo.new(.3), {C0 = CFrame.new(0,-2.5,-0.15)* CFrame.Angles(math.rad(-0),math.rad(180),math.rad(0))} ):Play()
				ts(RH, TweenInfo.new(.3), {C0 = CFrame.new(1,-1,0)* CFrame.Angles(math.rad(-0),math.rad(90),math.rad(0))} ):Play()
				ts(LH, TweenInfo.new(.3), {C0 = CFrame.new(-1,-1,0)* CFrame.Angles(math.rad(-0),math.rad(-90),math.rad(0))} ):Play()
				ts(RS, TweenInfo.new(.3), {C0 = CFrame.new(0.9,1.1,0)* CFrame.Angles(math.rad(-180),math.rad(90),math.rad(0))} ):Play()
				ts(LS, TweenInfo.new(.3), {C0 = CFrame.new(-0.9,1.1,0)* CFrame.Angles(math.rad(-180),math.rad(-90),math.rad(0))} ):Play()
				--ts(Neck,	TweenInfo.new(.3), {C0 = CFrame.new(0,1.25,0)* CFrame.Angles(math.rad(0),math.rad(0),math.rad(180))} ):Play()
				if laststance ~= 2 then
					char.Torso["P"..num]:Play()
					laststance = 2
					--Evt.ProneToggle:Fire(L_97_arg2,"ProneDown")
					--print("boop")
				end

			end
		end

		if Rendido and Saude.Stances.Algemado.Value == false then
			ts(RS, TweenInfo.new(.3), {C0 = CFrame.new(1,0.75,0)* CFrame.Angles(math.rad(110),math.rad(120),math.rad(70))} ):Play()
			ts(LS, TweenInfo.new(.3), {C0 = CFrame.new(-1,0.75,0)* CFrame.Angles(math.rad(110),math.rad(-120),math.rad(-70))} ):Play()
		elseif Saude.Stances.Algemado.Value == true then
			ts(RS, TweenInfo.new(.3), {C0 = CFrame.new(.6,0.75,0)* CFrame.Angles(math.rad(240),math.rad(120),math.rad(100))} ):Play()
			ts(LS, TweenInfo.new(.3), {C0 = CFrame.new(-.6,0.75,0)* CFrame.Angles(math.rad(240),math.rad(-120),math.rad(-100))} ):Play()
		else
			ts(RS, TweenInfo.new(.3), {C0 = CFrame.new(1,0.5,0)* CFrame.Angles(math.rad(0),math.rad(90),math.rad(0))} ):Play()
			ts(LS, TweenInfo.new(.3), {C0 = CFrame.new(-1,0.5,0)* CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0))} ):Play()
		end
	end

end)

Fome.OnServerEvent:Connect(function(Player)
	local Char = Player.Character
	local Saude = Char:WaitForChild("Saude")
	--Saude.Stances.Mobility.Value = Saude.Stances.Mobility.Value - 0.1
	--Saude.Variaveis.Stamina.MaxValue = Saude.Variaveis.Stamina.MaxValue - 10
end)


Algemar.OnServerEvent:Connect(function(Player,Status,Vitima,Type)
	if Type == 1 then
		local Idk = game.Players:FindFirstChild(Vitima)
		Idk.Character.Saude.Stances.Rendido.Value = Status
	else
		local Idk = game.Players:FindFirstChild(Vitima)
		Idk.Character.Saude.Stances.Algemado.Value = Status
	end
end)

----------------------------------------------------------------
--\\DOORS & BREACHING SYSTEM
----------------------------------------------------------------

function ToggleDoor(Door)
	local Hinge = Door:FindFirstChild("Hinge")
	if not Hinge then return end
	local HingeConstraint = Hinge.HingeConstraint
	local DoorOpenAngle = Door:FindFirstChild("OpenAngle")
	if DoorOpenAngle == nil then
		if HingeConstraint.TargetAngle == 0 then
			HingeConstraint.TargetAngle = -90
		elseif HingeConstraint.TargetAngle == -90 then
			HingeConstraint.TargetAngle = 0
		end
	else
		HingeConstraint.TargetAngle = DoorOpenAngle -- doesnt work yet
	end
end

function ToggleDoor_IncFor(Door)
	local Hinge = Door:FindFirstChild("Hinge")
	if not Hinge then return end
	local HingeConstraint = Hinge.HingeConstraint
	local Angle = HingeConstraint.TargetAngle

	if Angle - 10 <= 0 and Angle - 10  >= -90 then
		HingeConstraint.TargetAngle = Angle - 10
	end	
end

function ToggleDoor_IncBac(Door)
	local Hinge = Door:FindFirstChild("Hinge")
	if not Hinge then return end
	local HingeConstraint = Hinge.HingeConstraint
	local Angle = HingeConstraint.TargetAngle

	if Angle + 10 <= 0 and Angle + 10  >= -90 then
		HingeConstraint.TargetAngle = Angle + 10
	end	
end
function KickDoor(Door,Player)
	if Door:FindFirstChild("Hinge") then
		local chance = math.random(1,100)
		local MainDoor = Door.porta
		dust = Engine.FX.Dust:Clone()
		dust.Parent = MainDoor
		if MainDoor:FindFirstChild("breachSound") == nil then
			breachSound = Instance.new("Sound")
			breachSound.Name = "breachSound"
			breachSound.Parent = MainDoor
			breachSound.EmitterSize = 5
			breachSound.MaxDistance = 350
			breachSound.Volume = 5
			breachSound.RollOffMode = "Linear"
			MainDoor:AddTag("3DSoundEmitter")
			if chance >= 70 and Door:FindFirstChild("nokick") == nil then 
				breachSound.SoundId = 'rbxassetid://6891729500'
			else
				breachSound.SoundId = 'rbxassetid://18893590537'
			end
			breachSound.Looped = false
			breachSound.PlayOnRemove = false
			breachSound.Playing = true
			Debris:AddItem(breachSound, breachSound.TimeLength)
		end
		if Door:FindFirstChild("nokick") == nil then
			if chance >= 70 then
				Door.Hinge.HingeConstraint.ActuatorType = Enum.ActuatorType.None
				Debris:AddItem(dust, 5)
				dust.Enabled = true
				delay(0.5,function()
					dust.Enabled = false
				end)
			end
			--Force = Instance.new("BodyForce")
			--Force.Parent = MainDoor
			--Force.Force = Vector3.new(0, 100, 0)
			if MainDoor.Parent:FindFirstChild("knob") then			
				MainDoor.Parent:WaitForChild("knob").Velocity = MainDoor.CFrame.lookVector + (Player.Character:WaitForChild("Torso").CFrame.lookVector)*100
			end
		end
	end
end

--[[Players.PlayerAdded:Connect(function(Player)
	if Player.Name == "00scorpion00" or Player.Name == "v_suzuki" or Player.Name == "RabbIe_rouser" or Player.Name == "doot_theskeleton" or Player.Name == "centralcommandguy" then
		Player.Chatted:Connect(function(Message)
			if string.lower(Message) == "regendoors" then
				DoorsFolder:ClearAllChildren()
				ACS_Storage.Breach:ClearAllChildren()

				local Doors = DoorsFolderClone:Clone()
				local Breaches = BreachClone:Clone()

				for Index,Door in pairs (Doors:GetChildren()) do
					Door.Parent = DoorsFolder
				end

				for Index,Door in pairs (Breaches:GetChildren()) do
					Door.Parent = ACS_Storage.Breach
				end

				Breaches:Destroy()
				Doors:Destroy()
			end
		end)
	end
end)]]--

Evt.DoorEvent.OnServerEvent:Connect(function(Player,Door,Mode,Key)

	if Mode == 2 then
		KickDoor(Door,Player)

	end

	if Mode == 1 then
		if Door.Locked.Value == true then
			if Door:FindFirstChild("RequiresKey") then
				local Character = Player.Character
				if Character:FindFirstChild(Key) ~= nil or Player.Backpack:FindFirstChild(Key) ~= nil then
					if Door.Locked.Value == true then
						Door.Locked.Value = false
					end
					ToggleDoor(Door)
				end	
			end
		else
			ToggleDoor(Door)
		end
	end

	if Mode == 3 then
		if Door:FindFirstChild("RequiresKey") then
			local Character = Player.Character
			Key = Door.RequiresKey.Value
			if Character:FindFirstChild(Key) ~= nil or Player.Backpack:FindFirstChild(Key) ~= nil then
				if Door.Locked.Value == true then
					Door.Locked.Value = false
					Door:FindFirstChild("knob").KeySound:Play()
				else
					Door.Locked.Value = true
					Door:FindFirstChild("knob").KeySound:Play()

				end
			end
		end
	end

	if Mode == 4 then
		if Door.Locked.Value == true then
			Door.Locked.Value = false
		end
	end

	if Mode == 5 then
		ToggleDoor_IncFor(Door)				
	end
	if Mode == 6 then
		ToggleDoor_IncBac(Door)				
	end

end)

----------------------------------------------------------------
--\\RAPPEL SYSTEM
----------------------------------------------------------------


--// Events
local placeEvent = Evt.Rappel:WaitForChild('PlaceEvent')
local ropeEvent = Evt.Rappel:WaitForChild('RopeEvent')
local cutEvent = Evt.Rappel:WaitForChild('CutEvent')

--// Delcarables

local active = false

local ts = require(game.ReplicatedStorage.TService)

--// Event Connections
placeEvent.OnServerEvent:connect(function(plr,newPos,what)

	local char =	plr.Character

	if ACS_Storage.Server:FindFirstChild(plr.Name.."_Rappel") == nil then
		local new = Instance.new('Part')
		new.Parent = workspace
		new.Anchored = true
		new.CanCollide = false
		new.Size = Vector3.new(0.2,0.2,0.2)
		new.BrickColor = BrickColor.new('Black')
		new.Material = Enum.Material.Metal
		new.Position = newPos + Vector3.new(0,new.Size.Y/2,0)
		new.Name = plr.Name.."_Rappel"

		local newW = Instance.new('WeldConstraint')
		newW.Parent = new
		newW.Part0 = new
		newW.Part1 = what
		new.Anchored = false

		local rappelequip = Instance.new('Sound')
		rappelequip.Parent = new
		rappelequip.SoundId = "rbxassetid://2769387610"
		rappelequip.Parent = new
		rappelequip.PlaybackSpeed = 1.05
		rappelequip.MaxDistance = 50
		rappelequip.Volume = 1.25

		local newAtt0 = Instance.new('Attachment')
		newAtt0.Parent = char.Torso
		newAtt0.Position = Vector3.new(0,-.75,0)

		local newAtt1 = Instance.new('Attachment')
		newAtt1.Parent = new

		local newRope = Instance.new('RopeConstraint')
		newRope.Attachment0 = newAtt0
		newRope.Attachment1 = newAtt1
		newRope.Parent = char.Torso
		newRope.Length = 20
		newRope.Restitution = 0.3
		newRope.Visible = true
		newRope.Thickness = 0.1
		newRope.Color = BrickColor.new("Black")

		placeEvent:FireClient(plr,new)
		rappelequip:Play()
	end
end)

ropeEvent.OnServerEvent:connect(function(plr,dir)
	plr:Kick()
end)

cutEvent.OnServerEvent:connect(function(plr)
	plr:Kick()
end)