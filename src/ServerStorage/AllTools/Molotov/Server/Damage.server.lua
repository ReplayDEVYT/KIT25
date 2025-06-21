local Object = script.Parent
local Used = false
local DPS = 25
local Time = 16
local Radius = 32
local Damage = script:WaitForChild("Damage").Value
local FriendlyFire = script:WaitForChild("FriendlyFire").Value
local Tag = Object:WaitForChild("creator")

function Explode()
	Object.Flames.Enabled = false
	Object.Sparks.Enabled = false
	local part = Instance.new("Part")
	part.Name = "FlameArea"
	local Pos = Object.Position
	Pos=Pos
	local Point1 = Pos+Vector3.new(-Radius/2,-Radius/8,-Radius/2)
	local Point2 = Pos+Vector3.new(Radius/2,Radius/8,Radius/2)
	local FireRegion = Region3.new(Point1,Point2)
	part.Anchored = true
	part.CanCollide = false
	part.Size = Vector3.new(Radius,Radius/5,Radius)
	part.CFrame = Object.CFrame
	part.Orientation = Vector3.new(0,0,0)
	part.Transparency = 1
	local Light = Instance.new("PointLight")
	Light.Brightness = 1
	Light.Range = Radius*1.5
	Light.Shadows = true
	Light.Color = Color3.fromRGB(255, 137, 3)
	Light.Parent = part
	local Particles = script.Particles:GetChildren()
	for i=1,#Particles do
		Particles[i].Parent = part
		Particles[i].Enabled = true
	end
	part.Parent = workspace
	local BurningSound = Instance.new("Sound")
	BurningSound.SoundId = "rbxassetid://491229510"
	BurningSound.Parent = part
	BurningSound.Looped = true
	BurningSound:Play()
	for i=1, Time*30 do
		wait(1/60)
		for _,Part in pairs(game.Workspace:FindPartsInRegion3(FireRegion,nil,math.huge)) do
			if Part.Name == ("HumanoidRootPart"or"Head") and Part.Parent:FindFirstChild("Humanoid") then
				local Humanoid = Part.Parent.Humanoid
				Humanoid:TakeDamage(Humanoid.MaxHealth*(DPS*.0005))
				local HitDamage = (Humanoid.MaxHealth*(DPS*.0005))
				local Character = Humanoid.Parent
				print(HitDamage)
				local number = math.random(1,6)
				local number2 = math.random(1,6)
				local number3 = math.random(1,6)
				Humanoid:TakeDamage(HitDamage)
				print("rng1: "..number)
				print("rng2: "..number2)
				print("rng3: "..number3)
				if Character.Head:FindFirstChild("HP") then
					for i,v in pairs(Character:GetChildren()) do
						if v.Name == "Head" and (number == 1 or number2 == 1 or number3 == 1) then
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
	end
	BurningSound:Stop()
	Light:Destroy()
	local Children = part:GetChildren()
	for i=1,#Children do
		if Children[i]:IsA("ParticleEmitter") then
			Children[i].Enabled = false
		end
	end
	wait(10)
	part:Destroy()
	Object:Destroy()
end

--helpfully checks a table for a specific value
function contains(t, v)
	for _, val in pairs(t) do
		if val == v then
			return true
		end
	end
	return false
end

--used by checkTeams
function sameTeam(otherHuman)
	local player = Tag.Value
	local otherPlayer = game:GetService("Players"):GetPlayerFromCharacter(otherHuman.Parent)
	if player and otherPlayer then
		if player == otherPlayer then
			return true
		end
		if otherPlayer.Neutral then
			return false
		end
		return player.TeamColor == otherPlayer.TeamColor
	end
	return false
end

function tagHuman(human)
	local tag = Tag:Clone()
	tag.Parent = human
	game:GetService("Debris"):AddItem(tag)
end

--use this to determine if you want this human to be harmed or not, returns boolean
function checkTeams(otherHuman)
	return not (sameTeam(otherHuman) and not FriendlyFire==true)
end

function burn()
	Used = true
	Object.Impact:Play()
	Object.Orientation = Vector3.new(0,0,0)
	Object.Velocity = Vector3.new(0,0,0)
	Object.RotVelocity = Vector3.new(0,0,0)
	Object.Anchored = true
	Object.CanCollide = false
	Object:AddTag("3DSoundEmitter"); Object.Explode:Play()
	Object.Transparency = 1
	Object.Explosion:Emit(375)
	wait(.25)
	Explode()
end

Object.Touched:Connect(function(part)
	if Used == true or part.Name == "Handle" then return end
	if part:IsDescendantOf(Tag.Value.Character) then return end
	if part.Parent then
		if part.Parent:FindFirstChild("Humanoid") then
			local human = part.Parent.Humanoid
			if checkTeams(human) then
				tagHuman(human)
				human:TakeDamage(Damage)
			end
			burn()
		else
			burn()
		end
		game:GetService("Debris"):AddItem(Object, 10)
	end
end)