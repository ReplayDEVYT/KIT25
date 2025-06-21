local Debris = game:GetService("Debris")
local Engine = game.ReplicatedStorage:WaitForChild("ACS_Engine")
local Holes = Engine.Holes
local ts = require(game.ReplicatedStorage.TService)
local RS = game:GetService("RunService")

local ExplosionClose = {"72770486153791"; "132845970429904";}
local ExplosionDist = {"110812282861082"; "110812282861082";}
local ExplosionFar = {"131334853786055"; "95101028698469";}

local ExplosionIndoor = {"78305035726046"; "103011426300984"; "103011426300984";}
local ExplosionIndoorDist = {"72767232339228"; "129978857813907"; "103011426300984";}
local Hitmarker = {}

local ACS_Storage= workspace:WaitForChild("ACS_WorkSpace")
local BulletModel =  ACS_Storage.Server

playerlist = game.Players
otherplayers = playerlist:GetPlayers()
camera = workspace.CurrentCamera
for i,v in pairs(otherplayers) do
	if v.Character then
		otherplayercharacter = v.Character
	end

end

local holescopy = {
	WoodPlanks = "Wood",
	LeafyGrass = "Grass",
	Mud = "Ground",
	DiamondPlate = "Metal",
}

for v1, v2 in pairs(holescopy) do
	if not Holes:FindFirstChild(v1) then
		local folder = Holes:FindFirstChild(v2)
		if folder then
			local newFolder = folder:Clone()
			newFolder.Name = v1
			newFolder.Parent = Holes
		end
	end
end

local RGB = Color3.fromRGB
local NSn = NumberSequence.new
local NRn = NumberRange.new
local V3n = Vector3.new

local BodyParts = {
	"Head",
	"UpperTorso",
	"LowerTorso",
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
	"HumanoidRootPart",
	"Torso",
	"Left Arm",
	"Right Arm",
	"Left Leg",
	"Right Leg",
}

function rlist(Table)
	return Table[math.random(1,#Table)]
end

function randf(low,top)
	local diff = math.random()*(top - low)
	return low + diff
end

function colorseq(r,g,b)
	return ColorSequence.new(Color3.new(r,g,b))
end

function CreatePO(att,color,brightness,rangemin,rangemax,Time)
	local Po = Instance.new("PointLight", att)
	Po.Color = color
	Po.Brightness = brightness
	Po.Shadows = true
	Po.Range = math.random(rangemin, rangemax)
	Debris:AddItem(Po, Time)
end






function Hitmarker.HitEffect(Ray_Ignore,ACS_Storage,Pos,Hitpart,Norm,Mat)
	local Attachment = Instance.new("Attachment")
	Attachment.CFrame = CFrame.new(Pos, Pos + Norm)
	Attachment.Parent = workspace.Terrain

	-- materials folder selection process
	local MatFolder
	if Holes:FindFirstChild("Name:"..Hitpart.Name) then
		MatFolder = Holes["Name:"..Hitpart.Name]
	elseif table.find(BodyParts,Hitpart.Name) then
		MatFolder = Holes.Human
	elseif Holes:FindFirstChild(Mat.Name) then
		MatFolder = Holes:FindFirstChild(Mat.Name)
	end

	if not MatFolder then
		MatFolder = Holes.Default
	end



	-- hole decal and part
	if not Hitpart:IsA("Terrain") and not Hitpart:IsDescendantOf(workspace.Terrain) and MatFolder:FindFirstChild("Holes") then
		--[[if MatFolder:FindFirstChild('PBR') and MatFolder:FindFirstChild('PBR').Value == true then
			part = Instance.new("MeshPart")
			part.Transparency = 0
			part.CanCollide = false
		else]]--
		part = Instance.new("Part")
		part.FormFactor = "Custom"
		part.TopSurface = 0
		part.BottomSurface = 0
		part.Transparency = 1
		part.CanCollide = false
		--end
		local hs = MatFolder.HoleSize
		local size = randf(hs.MinValue,hs.MaxValue)
		part.Size = Vector3.new(size,0,size)
		if part:IsA('MeshPart') then
			part.CFrame = CFrame.new(Pos,Pos-Norm)* CFrame.Angles(math.pi/2,randf(0,2)*math.pi,0) + part.CFrame.upVector*0.022
		else
			part.CFrame = CFrame.new(Pos,Pos-Norm)* CFrame.Angles(math.pi/2,randf(0,2)*math.pi,0)
		end

		local Dec = rlist(MatFolder.Holes:GetChildren()):Clone()
		if Dec:IsA('Decal') then
			Dec.Face = "Top"
		end
		if not MatFolder:FindFirstChild("DontRecolor") and Dec:IsA('Decal') then
			Dec.Color3 = Hitpart.Color
		end
		Dec.Parent = part
		
		local b = Instance.new("WeldConstraint")
		b.Parent = part
		b.Part0 = part
		b.Part1 = Hitpart

		part.Parent = BulletModel
	end


	-- particles
	if MatFolder:FindFirstChild("Particles") then
		local Particles = MatFolder.Particles.Used:GetChildren()
		for _, Particle in pairs(Particles) do
			local NewParticle = Particle:Clone()
			NewParticle.Enabled = true
			NewParticle.Parent = Attachment
			local dur = .05
			if NewParticle:FindFirstChild("Duration") then
				dur = NewParticle.Duration.Value
			end
			if NewParticle:FindFirstChild("HitpartColor") then
				NewParticle.Color = ColorSequence.new(Hitpart.Color)
			end
			delay(dur,function()
				NewParticle.Enabled = false
				Debris:AddItem(NewParticle, NewParticle.Lifetime.Max)
			end)
		end
	end

	-- flash
	if MatFolder:FindFirstChild("Flash") then
		local po = MatFolder.Flash:Clone()
		po.Shadows = true
		po.Range = po.Range * randf(1/1.35,1.35)
		po.Enabled = true
		po.Parent = Attachment
		if MatFolder.Flash:FindFirstChild("Duration") then
			Debris:AddItem(po,MatFolder.Flash.Duration.Value)
		else
			Debris:AddItem(po,0.05)
		end
	end

	-- flash decal
	if MatFolder:FindFirstChild("FlashDecals") then
		local bg = Instance.new("BillboardGui")
		bg.Adornee = Attachment
		bg.Parent = Attachment
		
		local flash = rlist(MatFolder.FlashDecals:GetChildren()):Clone()
		local sot = flash:FindFirstChild('StayOnTop')
		if sot then
			bg.AlwaysOnTop = sot.Value
		else
			bg.AlwaysOnTop = false
		end
		local size = flash:FindFirstChild("Size")
		local flashsize
		if size then
			flashsize = randf(size.MinValue,size.MaxValue)
		else
			flashsize = randf(0.8,1.25)
		end
		if flash:FindFirstChild('AltSize') and flash.AltSize.Value == true then
			bg.Size = UDim2.new(0,flashsize,0,flashsize)
		else
			bg.Size = UDim2.new(flashsize,0,flashsize,0)
		end

		local trans = flash:FindFirstChild("Trans")
		if trans then
			flash.ImageTransparency = randf(trans.MinValue,trans.MaxValue)
		end

		flash.Visible = true
		flash.Rotation = (flash:FindFirstChild('NoRotate') == nil and math.random(0,360) or flash:FindFirstChild('NoRotate') and flash:FindFirstChild('NoRotate').Value == true and 0)
		flash.Size = flash:FindFirstChild('KeepSize') == nil and UDim2.new(.05,0,.05,0) or flash:FindFirstChild('KeepSize') and flash:FindFirstChild('KeepSize').Value == true and flash.Size
		local dur = .07
		if flash:FindFirstChild("Duration") then
			dur = flash.Duration.Value
		end
		flash.Parent = bg
		flash:TweenSize(UDim2.new(1,0,1,0),"Out","Quad",dur*2)
		Debris:AddItem(bg,dur)

	end

	-- sound
	--Attachment:AddTag("3DSoundEmitter")
	local Sound = rlist(MatFolder.Sounds:GetChildren()):Clone()
	Sound.PlaybackSpeed = randf(.8,1.25)
	Sound.Parent = Attachment
	Sound.SoundGroup = game.SoundService.All.Impacts
	Sound:Play()
	Debris:AddItem(Sound,Sound.TimeLength/Sound.PlaybackSpeed+5)
	local BulletCracks = Holes["Cracks"]
	if Hitpart.Name ~= "Visor" and Hitpart.Transparency <0.1 and (Pos-workspace.CurrentCamera.CFrame.Position).Magnitude > 125 then
		if table.find(BodyParts,Hitpart.Name) then
			local Sound2 = rlist(BulletCracks.Human:GetChildren()):Clone()
			--Sound2.PlaybackSpeed = randf(.9,1.1)
			Sound2.Parent = Attachment
			Sound2.SoundGroup = game.SoundService.All.Impacts
			Sound2:Play()
			Debris:AddItem(Sound2,Sound2.TimeLength/Sound2.PlaybackSpeed+5)
		elseif BulletCracks:FindFirstChild(Hitpart.Name) then
			local Sound2 = rlist(BulletCracks:FindFirstChild(Hitpart.Name):GetChildren()):Clone()
			--Sound2.PlaybackSpeed = randf(.9,1.1)
			Sound2.Parent = Attachment
			Sound2.SoundGroup = game.SoundService.All.Impacts
			Sound2:Play()
			Debris:AddItem(Sound2,Sound2.TimeLength/Sound2.PlaybackSpeed+5)
		elseif Mat == Enum.Material.Plastic or Mat == Enum.Material.SmoothPlastic then
			local Sound2 = rlist(BulletCracks.Wood:GetChildren()):Clone()
			--Sound2.PlaybackSpeed = randf(.9,1.1)
			Sound2.Parent = Attachment
			Sound2:Play()
			Debris:AddItem(Sound2,Sound2.TimeLength/Sound2.PlaybackSpeed+5)
		elseif Mat == Enum.Material.Metal or Mat == Enum.Material.DiamondPlate or Mat == Enum.Material.CorrodedMetal then
			local Sound2 = rlist(BulletCracks.Metal:GetChildren()):Clone()
			--Sound2.PlaybackSpeed = randf(.9,1.1)
			Sound2.Parent = Attachment
			Sound2.SoundGroup = game.SoundService.All.Impacts
			Sound2:Play()
			Debris:AddItem(Sound2,Sound2.TimeLength/Sound2.PlaybackSpeed+5)
		elseif Mat == Enum.Material.Wood or Mat == Enum.Material.WoodPlanks then
			local Sound2 = rlist(BulletCracks.Wood:GetChildren()):Clone()
			--Sound2.PlaybackSpeed = randf(.9,1.1)
			Sound2.Parent = Attachment
			Sound2:Play()
			Debris:AddItem(Sound2,Sound2.TimeLength/Sound2.PlaybackSpeed+5)
		elseif Mat == Enum.Material.Glass or Mat == Enum.Material.Ice then
			local Sound2 = rlist(BulletCracks.Glass:GetChildren()):Clone()
			--Sound2.PlaybackSpeed = randf(.9,1.1)
			Sound2.Parent = Attachment
			Sound2:Play()
			Debris:AddItem(Sound2,Sound2.TimeLength/Sound2.PlaybackSpeed+5)
		elseif Mat == Enum.Material.Ground or Mat == Enum.Material.Grass or Mat == Enum.Material.LeafyGrass or Mat == Enum.Material.Mud or Mat == Enum.Material.Sand or Mat == Enum.Material.Snow then
			local Sound2 = rlist(BulletCracks.Soil:GetChildren()):Clone()
			--Sound2.PlaybackSpeed = randf(.9,1.1)
			Sound2.Parent = Attachment
			Sound2.SoundGroup = game.SoundService.All.Impacts
			Sound2:Play()
			Debris:AddItem(Sound2,Sound2.TimeLength/Sound2.PlaybackSpeed+5)
		else
			local Sound2 = rlist(BulletCracks.Sounds:GetChildren()):Clone()
			--Sound2.PlaybackSpeed = randf(.9,1.1)
			Sound2.Parent = Attachment
			Sound2.SoundGroup = game.SoundService.All.Impacts
			Sound2:Play()
			Debris:AddItem(Sound2,Sound2.TimeLength/Sound2.PlaybackSpeed+5)
		end
		
	
	end
	
	if Hitpart.Name == "Hitmaker" then
		local Marca = Instance.new("Part")
		Marca.Material = Enum.Material.Neon
		Marca.Anchored = true
		Marca.CanCollide = false
		Marca.Color = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))
		Marca.Size = Vector3.new(0.1,0.1,0.01)
		Marca.Parent = ACS_Storage.Server
		Marca.CFrame = CFrame.new(Pos, Pos + Norm)
		table.insert(Ray_Ignore, Marca)
		Debris:AddItem(Attachment, 5)
		game.Debris:AddItem(Marca, 20)

	elseif  Hitpart.Name == "alvo" then
		--local BulletWhizz = Instance.new("Sound")
		--BulletWhizz.Parent = Attachment
		--BulletWhizz.Volume = math.random(20,30)/10
		--BulletWhizz.MaxDistance = 500
		--BulletWhizz.EmitterSize = 25
		--BulletWhizz.PlaybackSpeed = math.random(38, 58)/40
		--BulletWhizz.SoundId = "rbxassetid://" .. rlist(Metal)
		--BulletWhizz:Play()

		local Marca = Instance.new("Part")
		Marca.Anchored = true
		Marca.CanCollide = false
		Marca.Transparency = 1
		Marca.Size = Vector3.new(0.2,0.2,0.01)
		Marca.Parent = ACS_Storage.Server
		Marca.CFrame = CFrame.new(Pos, Pos + Norm)
		Debris:AddItem(Attachment, 5)
		game.Debris:AddItem(Marca, 20)
		table.insert(Ray_Ignore, Marca)
		local Dec = Instance.new("Decal")
		Dec.Texture = "rbxassetid://359667865"
		Dec.Parent = Marca
	elseif  Hitpart.Material == Enum.Material.Glass or Hitpart.Material == Enum.Material.Neon then
		
		if Hitpart:FindFirstChildOfClass("PointLight") or Hitpart:FindFirstChildOfClass("SpotLight") or Hitpart:FindFirstChildOfClass("SurfaceLight") then
			Hitpart:ClearAllChildren()
			Hitpart.Color = Color3.new(0,0,0)
			Hitpart.Material = Enum.Material.Plastic
			Hitpart.CanCollide = false
			Hitpart.CanTouch = false
		else
			if Hitpart.Material ~= Enum.Material.Neon then
				Hitpart:Destroy()
			end
		end
	elseif (Hitpart.Name == "Knob" or Hitpart.Name == "knob") then
		local DoorModel = Hitpart.Parent
		if DoorModel:FindFirstChild("Hinge") then
			DoorModel.Hinge.HingeConstraint.ActuatorType = Enum.ActuatorType.Motor
		end
		Hitpart:Destroy()
	elseif (Hitpart.Name == "DoorHinge" or Hitpart.Name == "eixo1" or Hitpart.Name == "eixo2") then
		local DoorModel = Hitpart.Parent
		if (DoorModel:FindFirstChild("DoorHinge") == nil or DoorModel:FindFirstChild("eixo1") == nil or DoorModel:FindFirstChild("eixo2") == nil) and DoorModel:FindFirstChild("Hinge") then
			DoorModel.Hinge:Destroy()
		end
		Hitpart:Destroy()
	end
	
	coroutine.wrap(function()
		repeat RS.Heartbeat:Wait() until #Attachment:GetChildren() == 0
		Attachment:Destroy()
	end)()

end


function Hitmarker.Explosion(Position, HitPart, Normal)
	
	

	local Hitmark = Instance.new("Attachment")
	Hitmark.CFrame = CFrame.new(Position, Position + Normal)
	Hitmark.Parent = workspace.Terrain
	
	raytop = Ray.new(Hitmark.WorldPosition,Vector3.new(0,150,0))
	local hit,position = workspace:FindPartOnRayWithIgnoreList(raytop,{otherplayercharacter,camera})
	
	if hit and (hit.Transparency == 0 and hit.Material ~= Enum.Material.Grass and hit.Material ~= Enum.Material.Sand or hit.Name == "IndoorPart") then
		local S = Instance.new("Sound")
		S.EmitterSize = 15
		S.MaxDistance = 100
		S.SoundId = "rbxassetid://".. rlist(ExplosionIndoor)
		S.PlaybackSpeed = math.random(30,55)/40
		S.Volume = 3
		S.Parent = Hitmark
		S.PlayOnRemove = false
		S:Play()

		local S2 = Instance.new("Sound")
		S2.EmitterSize = 400
		S2.MaxDistance = 900
		S2.SoundId = "rbxassetid://".. rlist(ExplosionIndoorDist)
		S2.PlaybackSpeed = math.random(30,55)/40
		S2.Volume = 1.75
		S2.Parent = Hitmark
		S2.PlayOnRemove = false
		S2:Play()

	else

	local S = Instance.new("Sound")
	S.EmitterSize = 20
	S.MaxDistance = 500
	S.SoundId = "rbxassetid://".. rlist(ExplosionClose)
	S.PlaybackSpeed = math.random(30,55)/40
	S.Volume = 7.5
	S.Parent = Hitmark
	S.PlayOnRemove = false
	S:Play()
	
	local S2 = Instance.new("Sound")
	S2.EmitterSize = 40
	S2.MaxDistance = 850
	S2.SoundId = "rbxassetid://".. rlist(ExplosionDist)
	S2.PlaybackSpeed = math.random(30,55)/40
	S2.Volume = 3
	S2.Parent = Hitmark
	S2.PlayOnRemove = false
	S2:Play()
	
	local S3 = Instance.new("Sound")
	S3.EmitterSize = 400
	S3.MaxDistance = 4500
	S3.SoundId = "rbxassetid://".. rlist(ExplosionFar)
	S3.PlaybackSpeed = math.random(30,55)/40
	S3.Volume = 2
	S3.Parent = Hitmark
	S3.PlayOnRemove = false
		S3:Play()
		end


	--local Exp = Instance.new("Explosion")
	--Exp.BlastPressure = 0
	--Exp.BlastRadius = 0
	--Exp.DestroyJointRadiusPercent = 0
	--Exp.Position = Hitmark.Position
	--Exp.Parent = Hitmark

	Debris:AddItem(Hitmark, 5)

end

return Hitmarker