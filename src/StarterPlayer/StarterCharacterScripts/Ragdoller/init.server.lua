--print("Ragdoll script activated")
Gibs = game.Workspace

function getKillerOfHumanoidIfStillInGame(humanoid)
	local tag = humanoid:findFirstChild("creator")
	if tag ~= nil then
		local killer = tag.Value
		if killer ~= nil then 
			return killer
		end
	end
	return nil
end

local function Tween(part,Time,properties,style,direction,de) 
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

local faces = {
	"rbxassetid://1477688751",
	"rbxassetid://1972707642",
	"rbxassetid://7236243692",
	"rbxassetid://1972707642",
	"rbxassetid://476060645",
	"rbxassetid://11114775913",
	"rbxassetid://5292753692",
	"rbxassetid://3182272412"
}
local Deadfaces = {
	"rbxassetid://5292753692",
	"rbxassetid://2013344698",
	"rbxassetid://3182272412"
}

local DieTime = 4

local function bindMove(part,vl)
	spawn(function()
		local dir22 = Vector3.new(math.random(-1, 1),math.random(-2, 2),math.random(-2.4, 2))
		local bf = Instance.new('BodyAngularVelocity', part)
		bf.AngularVelocity = dir22
		if not part.Parent:FindFirstChild('FastDeath') then
			wait((math.random(0,2)))
			--bf.MaxTorque = Vector3.new(500,500,500)
			bf.MaxTorque = Vector3.new(0,0,0)
			bf.P = 0
			--bf.P = 1000
			--bf.AngularVelocity = Vector3.new()
			game.Debris:AddItem(bf,game.Players.RespawnTime)
			if part.Name == 'Head' then
				delay(game.Players.RespawnTime,function()
					part.face.Texture = 'rbxassetid://2013344698'
					for i, v in pairs(part:GetChildren()) do
						if v.Name == "Spraying" then
							v:Destroy()
						end
					end
				end)
			end
			vl.Event:Connect(function()
				if part.Name == 'Head' then
					part.face.Texture = 'rbxassetid://2013344698'
				end
				if bf then
					bf:Destroy()
				end
			end)
			repeat
				local dir = Vector3.new((math.random()-.5)*15,(math.random()-.5)*15,(math.random()-.5)*15)*.25
				local dir2 = Vector3.new(2,0,0)

				local max = 5
				local allwait = 0
				for i = 1,max do
					--bf.AngularVelocity = bf.AngularVelocity+((dir-bf.AngularVelocity)/max)
					--bf.AngularVelocity = dir2
					wait()
				end
				--bf.AngularVelocity = ("500,20,0")
				wait(math.random(1,5))
			until
			not bf 
		elseif part.Parent:FindFirstChild("FastDeath") then
			bf:Destroy()
		end


	end)
end

local function euphoria(part,el)
	spawn(function()
		local dir22 = Vector3.new(math.random(-20, 20),math.random(-20, 20),math.random(-40, 40))
		local bf = Instance.new('BodyAngularVelocity', part)
		bf.AngularVelocity = dir22
		if not part.Parent:FindFirstChild('FastDeath') then
			wait((math.random(0,4)))
			--bf.MaxTorque = Vector3.new(500,500,500)
			bf.MaxTorque = Vector3.new(0,0,0)
			bf.P = 0
			--bf.P = 1000
			--bf.AngularVelocity = Vector3.new()
			game.Debris:AddItem(bf,game.Players.RespawnTime)
			if part.Name == 'Head' then
				delay(game.Players.RespawnTime,function()
					part.face.Texture = 'rbxassetid://2013344698'
				end)
			end
			el.Event:Connect(function()
				if part.Name == 'Head' then
					part.face.Texture = 'rbxassetid://2013344698'
				end
				if bf then
					bf:Destroy()
				end
			end)
			repeat
				local dir = Vector3.new((math.random()-.5)*15,(math.random()-.5)*15,(math.random()-.5)*15)*.25
				local dir2 = Vector3.new(2,0,0)

				local max = 5
				local allwait = 0
				for i = 1,max do
					--bf.AngularVelocity = bf.AngularVelocity+((dir-bf.AngularVelocity)/max)
					--bf.AngularVelocity = dir2
					wait()
				end
				--bf.AngularVelocity = ("500,20,0")
				wait(math.random(0.3,5))
			until
			not bf 
		elseif part.Parent:FindFirstChild("FastDeath") then
			bf:Destroy()
		end


	end)
end

function OnDeath(Character)
	wait()
	Character:FindFirstChildOfClass('Humanoid').Health = 0
	
	local hum = Character:findFirstChild("Humanoid")
	local find = Character:FindFirstChild('Humanoid') and Character.Humanoid:FindFirstChild('Inc')
	local random = math.random(1,2)
	if Character:FindFirstChild('FastDeath') then
		script.Parent.Head.face.Texture = "rbxassetid://2013344698"
	else
		script.Parent.Head.face.Texture = faces[math.random(#faces)]
	end
	Character.Head:FindFirstChild('Cough1'):Destroy()
	Character.Head:FindFirstChild('Cough2'):Destroy()
	hum.BreakJointsOnDeath = false
	local getkiller = getKillerOfHumanoidIfStillInGame(hum)
	Character.Archivable = true
	local chrclone = Character:Clone()
	chrclone.Name = chrclone.Name .. "'s dead body"
	local sclone = script:Clone()
	sclone.Parent = chrclone
	for i, v in pairs(chrclone:GetDescendants()) do
		v.Archivable = true
	end
	local ch = chrclone:GetChildren()
	local i
	for i = 1,#ch do
		if ch[i].Name == "THandle1" or ch[i].Name == "THandle2" or ch[i].ClassName == "Script" then
			ch[i]:Destroy()
		end
	end
	for i,scripts in pairs(chrclone:GetDescendants()) do
		if scripts:IsA("Script") or scripts:IsA("LocalScript") then
			if scripts.Name == "MedSys_Client" or scripts.Name == "MedSys_FX" then
				scripts.Disabled = true
			end
		end
	end
	for i,scripts in pairs(chrclone:GetChildren()) do
		if scripts:IsA("Script") or scripts:IsA("LocalScript") then
			if scripts.Name == "First Person Accessories" then
				scripts.Disabled = false
			end
		end
	end
	local function Scan(ch)
		local e
		for e = 1,#ch do
			Scan(ch[e]:GetChildren())
			if ch[e].ClassName == "Motor6D" then
				ch[e]:Destroy()
			end
		end
	end
	Scan(chrclone:GetChildren())

	local hum2 = chrclone:findFirstChild("Humanoid")
	if hum2 ~= nil then
		hum2.DisplayDistanceType = "None"
		hum2.Name = "Humanoid"
		hum2.PlatformStand = true
		hum2.Sit = true 
		hum2.MaxHealth = 4400
		hum2.Health = 4400
	end
	if chrclone:FindFirstChild("HumanoidRootPart") then
		chrclone.HumanoidRootPart:Destroy()
	end

	local ch = Character:GetChildren()
	local i
	for i = 1,#ch do
		if ch[i].Name == "THandle1" or ch[i].Name == "THandle2" then
			ch[i]:Destroy()
		end
	end
	local Decals = {}
	local plr = game.Players:GetPlayerFromCharacter(Character)
	Character = chrclone
	--[[for _,v in pairs(Character:GetChildren()) do
		if v:FindFirstChild('KeepOnDeath') then
			local wl = Instance.new('WeldConstraint')
			wl.Part1 = Character['Right Arm']
			wl.Part0 = v.Grip
			wl.Parent = v.Grip
			local ran_num = math.random(100,200) / 100
			game.Debris:AddItem(wl,ran_num) --default is 1
			local ps = game:GetService('PhysicsService')
			local id = ps:GetCollisionGroupId('RagdollCorpse')
			for _,v2 in pairs(v:GetDescendants()) do
				if v2:IsA('BasePart') then
					if v2:FindFirstChild("NoWeld") == nil then
						local wl = Instance.new('WeldConstraint')
						wl.Part1 = v2
						wl.Part0 = v.Grip
						wl.Parent = v.Grip
					end
					v2.CanCollide = true
					v2:GetPropertyChangedSignal('CanCollide'):Connect(function()
						v2.CanCollide = true
					end)
					v2.CollisionGroupId = id
				end
			end
		end
	end]]-- 		
	for i = 1,#ch do
		if ch[i].ClassName == "Part" or ch[i].ClassName == "Hat" or ch[i].ClassName == "Accessory" or ch[i].Name == "THandle1" or ch[i].Name == "THandle2" then
			--			print('a')
			if ch[i]:IsA('Accessory') then
				--				print('b')
				if ch[i]:FindFirstChild("Handle") and ch[i].Handle:FindFirstChildOfClass('Decal') then
					for _,v in pairs(ch[i].Handle:GetChildren()) do
						--						print('c')
						if v:IsA('Decal') then
							--							print('que')
							Decals[ch[i].Name] = v:Clone()
							--							print('added | ' .. ch[i].Name)
						end
					end	
				end	
			end
			ch[i]:Destroy()
		end
	end
	local Torso = Character:FindFirstChild("Torso")
	local Head = Character:FindFirstChild("Head")
	local rarm = Character:FindFirstChild("Right Arm")
	local larm = Character:FindFirstChild("Left Arm")
	local rleg = Character:FindFirstChild("Right Leg")
	local lleg = Character:FindFirstChild("Left Leg")
	local movevector = Vector3.new()
	chrclone.PrimaryPart = Character:FindFirstChild("Torso")
	local impact1 = script.torso_impact:Clone()
	impact1.Parent = Torso
	impact1.Disabled = false
	--[[
	local impact2 = script.limb_impact:Clone()--.Parent == Head
	impact2.Parent = Head
	impact2.Disabled = false
	local impact3 = script.limb_impact:Clone()--.Parent == rarm
	impact3.Parent = rarm
	impact3.Disabled = false
	local impact4 = script.limb_impact:Clone()--.Parent == larm
	impact4.Parent = larm
	impact4.Disabled = false
	local impact5 = script.limb_impact:Clone()--.Parent == rleg
	impact5.Parent = rleg
	impact5.Disabled = false
	local impact6 = script.limb_impact:Clone()--.Parent == lleg
	impact6.Parent = lleg
	impact6.Disabled = false
	]]--

	local HeadA = Instance.new("Attachment")
	HeadA.Name = "HeadA"
	HeadA.Parent = Head
	HeadA.Position = Vector3.new(0, -0.5, 0)
	HeadA.Axis = Vector3.new(1, 0, 0)
	HeadA.SecondaryAxis = Vector3.new(0, 1, 0)

	local LeftArmA = Instance.new("Attachment")
	LeftArmA.Name = "LeftArmA"
	LeftArmA.Parent = larm
	LeftArmA.Position = Vector3.new(0, 0.5, 0)
	LeftArmA.Axis = Vector3.new(1, 0, 0)
	LeftArmA.SecondaryAxis = Vector3.new(0, 1, 0)

	local LeftLegA = Instance.new("Attachment")
	LeftLegA.Name = "LeftLegA"
	LeftLegA.Parent = lleg
	LeftLegA.Position = Vector3.new(0, 1, 0)
	LeftLegA.Axis = Vector3.new(1, 0, 0)
	LeftLegA.SecondaryAxis = Vector3.new(1, 0, 0)

	local RightArmA = Instance.new("Attachment")
	RightArmA.Name = "RightArmA"
	RightArmA.Parent = rarm
	RightArmA.Position = Vector3.new(0, 0.5, 0)
	RightArmA.Axis = Vector3.new(1, 0, 0)
	RightArmA.SecondaryAxis = Vector3.new(0, 1, 0)

	local RightLegA = Instance.new("Attachment")
	RightLegA.Name = "RightLegA"
	RightLegA.Parent = rleg
	RightLegA.Position = Vector3.new(0, 1, 0)
	RightLegA.Axis = Vector3.new(1, 0, 0)
	RightLegA.SecondaryAxis = Vector3.new(0, 1, 0)

	local TorsoA = Instance.new("Attachment")
	TorsoA.Name = "TorsoA"
	TorsoA.Parent = Torso
	TorsoA.Position = Vector3.new(0, 1, 0)
	TorsoA.Axis = Vector3.new(1, 0, 0)
	TorsoA.SecondaryAxis = Vector3.new(0, 1, 0)

	local TorsoA1 = Instance.new("Attachment")
	TorsoA1.Name = "TorsoA1"
	TorsoA1.Parent = Torso
	TorsoA1.Position = Vector3.new(-0.5, -1, 0)
	TorsoA1.Axis = Vector3.new(1, 0, 0)
	TorsoA1.SecondaryAxis = Vector3.new(0, 1, 0)

	local TorsoA2 = Instance.new("Attachment")
	TorsoA2.Name = "TorsoA2"
	TorsoA2.Parent = Torso
	TorsoA2.Position = Vector3.new(-1.5, 0.5, 0)
	TorsoA2.Axis = Vector3.new(1, 0, 0)
	TorsoA2.SecondaryAxis = Vector3.new(0, 1, 0)

	local TorsoA3 = Instance.new("Attachment")
	TorsoA3.Name = "TorsoA3"
	TorsoA3.Parent = Torso
	TorsoA3.Position = Vector3.new(1.5, 0.5, 0)
	TorsoA3.Axis = Vector3.new(1, 0, 0)
	TorsoA3.SecondaryAxis = Vector3.new(0, 1, 0)

	local TorsoA4 = Instance.new("Attachment")
	TorsoA4.Name = "TorsoA4"
	TorsoA4.Parent = Torso
	TorsoA4.Position = Vector3.new(0, 1, 0)
	TorsoA4.Axis = Vector3.new(1, 0, 0)
	TorsoA4.SecondaryAxis = Vector3.new(0, 1, 0)

	local TorsoA5 = Instance.new("Attachment")
	TorsoA5.Name = "TorsoA5"
	TorsoA5.Parent = Torso
	TorsoA5.Position = Vector3.new(0.5, -1, 0)
	TorsoA5.Axis = Vector3.new(1, 0, 0)
	TorsoA5.SecondaryAxis = Vector3.new(0, 1, 0)

	local HA = Instance.new("BallSocketConstraint")
	HA.Parent = Head
	HA.Attachment0 = HeadA
	HA.Attachment1 = TorsoA4
	HA.Enabled = true
	HA.LimitsEnabled = true
	HA.TwistLimitsEnabled = false
	HA.Restitution = 0
	HA.UpperAngle = 20

	local LAT = Instance.new("BallSocketConstraint")
	LAT.Parent = larm
	LAT.Attachment0 = LeftArmA
	LAT.Attachment1 = TorsoA2
	LAT.Enabled = true
	LAT.LimitsEnabled = true
	LAT.TwistLimitsEnabled = false
	LAT.Restitution = 0
	LAT.UpperAngle = 90


	local RAT = Instance.new("BallSocketConstraint")
	RAT.Parent = rarm
	RAT.Attachment0 = RightArmA
	RAT.Attachment1 = TorsoA3
	RAT.Enabled = true
	RAT.LimitsEnabled = true
	RAT.TwistLimitsEnabled = false
	RAT.Restitution = 0
	RAT.UpperAngle = 90

	local TLL = Instance.new("BallSocketConstraint")
	TLL.Parent = Torso
	TLL.Attachment0 = TorsoA1
	TLL.Attachment1 = LeftLegA
	TLL.Enabled = false
	TLL.LimitsEnabled = true
	TLL.TwistLimitsEnabled = false
	TLL.Restitution = 0
	TLL.UpperAngle = 90

	local TRL = Instance.new("BallSocketConstraint")
	TRL.Parent = Torso
	TRL.Attachment0 = TorsoA5
	TRL.Attachment1 = RightLegA
	TRL.Enabled = false
	TRL.LimitsEnabled = true
	TRL.TwistLimitsEnabled = false
	TRL.Restitution = 0
	TRL.UpperAngle = 90	
	if Torso then
		if getkiller ~= nil then
			if getkiller.Character ~= nil then
				local killtors = getkiller.Character:findFirstChild("Torso")
				if killtors ~= nil then
					movevector = CFrame.new(killtors.Position,Torso.Position).lookVector
				end
			end
		end

		--		for i,v in pairs(chrclone:GetChildren()) do

		--			if v:FindFirstChild("BulletHole") then

		--				print(v.Name)
		--				local g = v["BulletHole"]
		--				print(g.Name)
		--					local W = Instance.new("Weld")
		--					W.Part0 = v
		--					W.Part1 = g
		--					local CJ = CFrame.new(v.Position)
		--					local C0 = g.Middle.CFrame:inverse()*CJ
		--					local C1 = g.CFrame:inverse()*CJ
		--					W.C0 = C0
		--					W.C1 = C1
		--					W.Parent = g
		--			end
		--		end

		if chrclone:FindFirstChild("MorphHead") then	
			local g = chrclone["MorphHead"]
			local C = g:GetChildren()
			for i=1, #C do
				if C[i].Name == "Part" or "UnionOperation" or "MeshPart" then
					local W = Instance.new("Weld")
					W.Part0 = g.Middle
					W.Part1 = C[i]
					local CJ = CFrame.new(g.Middle.Position)
					local C0 = g.Middle.CFrame:inverse()*CJ
					local C1 = C[i].CFrame:inverse()*CJ
					W.C0 = C0
					W.C1 = C1
					W.Parent = g.Middle
					g.Middle.Transparency = 1
					local Y = Instance.new("Weld")
					Y.Part0 = Character:FindFirstChild("Head")
					Y.Part1 = g.Middle
					Y.C0 = CFrame.new(0, 0, 0)
					Y.Parent = Y.Part0
				end
			end
		end

		if chrclone:FindFirstChild("MorphTorso") then
			local g = chrclone["MorphTorso"]
			local C = g:GetChildren()
			for i=1, #C do
				if C[i]:IsA("Part") or C[i]:IsA("UnionOperation") or C[i]:IsA("MeshPart") then
					local W = Instance.new("Weld")
					W.Part0 = g.Middle
					W.Part1 = C[i]
					local CJ = CFrame.new(g.Middle.Position)
					local C0 = g.Middle.CFrame:inverse()*CJ
					local C1 = C[i].CFrame:inverse()*CJ
					W.C0 = C0
					W.C1 = C1
					W.Parent = g.Middle
					g.Middle.Transparency = 1
					local Y = Instance.new("Weld")
					Y.Part0 = Character:FindFirstChild("Torso")
					Y.Part1 = g.Middle
					Y.C0 = CFrame.new(0, 0, 0)
					Y.Parent = Y.Part0
				end
			end
		end
		if chrclone:FindFirstChild("MorphLArm") then
			local g = chrclone["MorphLArm"]
			local C = g:GetChildren()
			for i=1, #C do
				if C[i]:IsA("Part") or C[i]:IsA("UnionOperation") or C[i]:IsA("MeshPart") then
					local W = Instance.new("Weld")
					W.Part0 = g.Middle
					W.Part1 = C[i]
					local CJ = CFrame.new(g.Middle.Position)
					local C0 = g.Middle.CFrame:inverse()*CJ
					local C1 = C[i].CFrame:inverse()*CJ
					W.C0 = C0
					W.C1 = C1
					W.Parent = g.Middle
					g.Middle.Transparency = 1
					local Y = Instance.new("Weld")
					Y.Part0 = Character:FindFirstChild("Left Arm")
					Y.Part1 = g.Middle
					Y.C0 = CFrame.new(0, 0, 0)
					Y.Parent = Y.Part0
				end
			end
		end
		if chrclone:FindFirstChild("MorphLLeg") then
			local g = chrclone["MorphLLeg"]
			local C = g:GetChildren()
			for i=1, #C do
				if C[i]:IsA("Part") or C[i]:IsA("UnionOperation") or C[i]:IsA("MeshPart") then
					local W = Instance.new("Weld")
					W.Part0 = g.Middle
					W.Part1 = C[i]
					local CJ = CFrame.new(g.Middle.Position)
					local C0 = g.Middle.CFrame:inverse()*CJ
					local C1 = C[i].CFrame:inverse()*CJ
					W.C0 = C0
					W.C1 = C1
					W.Parent = g.Middle
					g.Middle.Transparency = 1
					local Y = Instance.new("Weld")
					Y.Part0 = Character:FindFirstChild("Left Leg")
					Y.Part1 = g.Middle
					Y.C0 = CFrame.new(0, 0, 0)
					Y.Parent = Y.Part0
				end
			end
		end
		if chrclone:FindFirstChild("MorphRArm") then
			local g = chrclone["MorphRArm"]
			local C = g:GetChildren()
			for i=1, #C do
				if C[i]:IsA("Part") or C[i]:IsA("UnionOperation") or C[i]:IsA("MeshPart") then
					local W = Instance.new("Weld")
					W.Part0 = g.Middle
					W.Part1 = C[i]
					local CJ = CFrame.new(g.Middle.Position)
					local C0 = g.Middle.CFrame:inverse()*CJ
					local C1 = C[i].CFrame:inverse()*CJ
					W.C0 = C0
					W.C1 = C1
					W.Parent = g.Middle
					g.Middle.Transparency = 1
					local Y = Instance.new("Weld")
					Y.Part0 = Character:FindFirstChild("Right Arm")
					Y.Part1 = g.Middle
					Y.C0 = CFrame.new(0, 0, 0)
					Y.Parent = Y.Part0
				end
			end
		end
		if chrclone:FindFirstChild("MorphRLeg") then
			local g = chrclone["MorphRLeg"]
			local C = g:GetChildren()
			for i=1, #C do
				if C[i]:IsA("Part") or C[i]:IsA("UnionOperation") or C[i]:IsA("MeshPart") then
					local W = Instance.new("Weld")
					W.Part0 = g.Middle
					W.Part1 = C[i]
					local CJ = CFrame.new(g.Middle.Position)
					local C0 = g.Middle.CFrame:inverse()*CJ
					local C1 = C[i].CFrame:inverse()*CJ
					W.C0 = C0
					W.C1 = C1
					W.Parent = g.Middle
					g.Middle.Transparency = 1
					local Y = Instance.new("Weld")
					Y.Part0 = Character:FindFirstChild("Right Leg")
					Y.Part1 = g.Middle
					Y.C0 = CFrame.new(0, 0, 0)
					Y.Parent = Y.Part0
				end
			end
		end
		
		chrclone.LeftKnee.CanCollide = false
		chrclone.RightKnee.CanCollide = false 

		for _,v in pairs(Character:GetChildren()) do
			if v:IsA('Accessory') and Decals[v.Name] then
				Decals[v.Name].Parent = v.Handle
			end
		end
		if find then
			for _,v in pairs(Character:GetChildren()) do
				if v:IsA('BodyColors') then
					v:Destroy()
				end
				if v:IsA('BasePart') then
					spawn(function()
						local s = game.ReplicatedStorage:WaitForChild('ACS_Engine'):WaitForChild('ServerCustom'):WaitForChild('Vaporize'):Clone()
						s.Parent = v
						delay(0.1,function()
							s.Enabled = false
							game.Debris:AddItem(s,s.Lifetime.Max)
						end)
					end)
				end
			end
			for _,v in pairs(Character:GetDescendants()) do
				if v:IsA('SpecialMesh') then
					Tween(v,1.5,{VertexColor = Vector3.new(0,0,0)})
				end
				if v:IsA('Shirt') or v:IsA('ShirtGraphic') or v:IsA('Pants') then
					Tween(v,1.5,{Color3 = Color3.new()})
				end
				if v:IsA('Decal') then
					spawn(function()
						Tween(v,1.5,{Color3 = Color3.new()})
						delay(3,function()
							Tween(v,.5,{Transparency = 1})
						end)
					end)
				end
				if v:IsA('BasePart') then

					if v.Name == 'Torso' then
						v.Massless = false
						local anti = v:GetMass()
						local up = Instance.new('BodyForce')
						--up.Force = Vector3.new(0,anti*workspace.Gravity*math.pi*1.314*2,0)
						up.Force = Vector3.new(0,-10,0)
						local nv = Instance.new('NumberValue')
						nv.Parent = up
						Tween(nv,2.5,{Value = 0.005})
						local id

						id = game:GetService('RunService').Heartbeat:Connect(function()
							v.Velocity = v.Velocity:Lerp(Vector3.new(),1)
							up.Force = up.Force:Lerp(Vector3.new(),nv.Value)
						end)

						v.AncestryChanged:Connect(function()
							if not v:IsDescendantOf(workspace) then
								id:Disconnect()
							end
						end)
						--Tween(up)
						up.Parent = v
					else
						--v.Massless = true
					end
					spawn(function()
						Tween(v,1.5,{Color = Color3.new()})
						delay(0.1,function()
							Tween(v,.5,{Transparency = 1})
							delay(0.04,function()
								v.Anchored = true
								v.CollisionGroupId = 'char'
								--v.CFrame = CFrame.new()
							end)
							game.Debris:AddItem(v,4.5)
						end)
					end)
				end
			end
		end
		--[
		local Force = game.ServerStorage.TF:clone()
		Force.Parent = Torso
	end
	local Head = Character:FindFirstChild("Head")
	if Head then
		local Force = game.ServerStorage.LF:clone()
		Force.Parent = Head
		local Bar = game.ServerStorage.Neck:clone()
		Bar.Parent = Character
		local Weld = Instance.new("Weld")
		Weld.Part0 = Head
		Weld.Part1 = Bar
		Weld.C0 = CFrame.new()
		Weld.Parent = Head

		local nsc = script.CamAttach:clone()
		nsc.CamPart.Value = hum2.Parent.Head
		nsc.Disabled = false
		nsc.Parent = chrclone
	end
	local rarm = Character:FindFirstChild("Right Arm")
	if rarm then
		local Force = game.ServerStorage.HF:clone()
		Force.Parent = rarm
		local B = game.ServerStorage.RHand:clone()
		B.Parent = Character
		local W = Instance.new("Weld")
		W.Part0 = rarm
		W.Part1 = B
		W.C0 = CFrame.new()
		W.Parent = rarm
	end
	local larm = Character:FindFirstChild("Left Arm")
	if larm then
		local Force = game.ServerStorage.HF:clone()
		Force.Parent = larm
		local B = game.ServerStorage.LHand:clone()
		B.Parent = Character
		local W = Instance.new("Weld")
		W.Part0 = larm
		W.Part1 = B
		W.C0 = CFrame.new()
		W.Parent = larm
	end
	local rleg = Character:FindFirstChild("Right Leg")
	if rleg then
		local B = game.ServerStorage.RFoot:clone()
		B.Parent = Character
		local W = Instance.new("Weld")
		W.Part0 = rleg
		W.Part1 = B
		W.C0 = CFrame.new()
		W.Parent = rleg

	end
	local lleg = Character:FindFirstChild("Left Leg")
	if lleg then
		local B = game.ServerStorage.LFoot:clone()
		B.Parent = Character
		local W = Instance.new("Weld")
		W.Part0 = lleg
		W.Part1 = B
		W.C0 = CFrame.new()
		W.Parent = lleg

	end		
	--]]
	local val = Instance.new('ObjectValue')
	val.Value = script.Parent
	val.Name = 'RagdollValue'
	val.Parent = Character
	Character.Parent = Gibs
	game.Debris:AddItem(Character, 30000000)
	if movevector ~= Vector3.new() then
		for i = 1,10 do
			Head.Velocity = movevector * 100
			lleg.Velocity = movevector * 20
			rleg.Velocity = movevector * 20
			Torso.Velocity = movevector * 40
		end
	end
	local vl = Instance.new('BindableEvent')
	vl.Name = 'Die'
	vl.Parent = Character
	-- bindMove(Character['Torso'],vl)
	local el = Instance.new('BindableEvent')
	el.Name = 'Diel'
	el.Parent = Character
	if Character.Saude:WaitForChild('Variaveis').ShotLimb.Value ~= "Head" then
		bindMove(Character['Head'],el)
		bindMove(Character['Left Leg'],el)
		bindMove(Character['Right Leg'],el)
		-- bindMove(Character['Left Arm'],el)
		-- bindMove(Character['Right Arm'],el)
	else
		bindMove(Character['Head'],el)
	end
	if plr then
		script.rv:FireClient(plr,Character)
	end
end

script.Parent.Humanoid.Died:connect(function()
	if script.CanRagdoll.Value == true then
		OnDeath(script.Parent)
	end
end)

