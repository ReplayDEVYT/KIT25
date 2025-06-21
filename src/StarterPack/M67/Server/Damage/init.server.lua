local Object = script.Parent
local Used = false
local SplashDamage = 150
local Radius = 75
local Damage = script:WaitForChild("Damage").Value
local FriendlyFire = script:WaitForChild("FriendlyFire").Value
local Tag = Object:WaitForChild("creator")
local Debris = game:GetService("Debris")
local Beps = Object.Grenade
local rootpart = Object

function OnExplosionHit(Character, hitDistance, blastCenter)
	local Humanoid = Character:FindFirstChild("Humanoid")
	if hitDistance and blastCenter then
		local DistanceFactor = hitDistance/Radius
		DistanceFactor = 1-DistanceFactor
		if Humanoid then
			if Humanoid.Health > 0 then
				local HitDamage = DistanceFactor*SplashDamage
				print(HitDamage)
				
				local number = math.random(1,7)
				local number2 = math.random(1,7)
				local number3 = math.random(1,7)
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
						if v.Name == "Stomach" and (number == 7 or number2 == 7 or number3 == 7) then
							local a = v:FindFirstChild("HP")
							a.Value = a.Value - HitDamage
						end
					end

				end
				
				
				
			end
		end
	end
end

fpor = game.Workspace.FindPartOnRay
seen_dist = 100
local function canSee(from,to,ignore)
	local intIgnore = {}
	for i,v in pairs(ignore) do
		intIgnore[i] = v
	end

	local ray = Ray.new(from,to-from)
	local blocked = false
	local finished = false
	local count = 0
	repeat
		count += 1
		local f = workspace:FindPartOnRayWithIgnoreList(ray,intIgnore)
		if f then
			if f.Transparency > 0 or f.Parent:FindFirstChild('Humanoid') or (f.Parent.Parent and f.Parent.Parent:FindFirstChild('Humanoid')) then
				intIgnore[#intIgnore+1] = f
			else
				finished = true
				blocked = true
			end
		else
			finished = true
		end
	until finished or count > 100

	if count > 100 then
		error('SOMETHING HAS GONE HORRIBLY WRONG\nmore than 100 rays for a single flashbang lol what die pls?')
	end

	return not blocked

	--if (not subject) or (not viewer) then return false end
	--local sh = subject
	--local vh = viewer:findFirstChild("Head")
	--if (not sh) or (not vh) then return false end
	--local vec = sh.Position - vh.Position
	--local isInFOV = (vec:Dot(vh.CFrame.lookVector) > 0)
	--if (isInFOV) and (vec.Magnitude < seen_dist) then
	--	local ray = Ray.new(vh.Position,vec.unit*200)
	--	local por = fpor(workspace,ray,viewer,false)
	--	return (por == nil) or (por:IsDescendantOf(subject))
	--end
	--return false
end

function Explode()
	local Orange = Color3.fromRGB(255, 193, 105)
	local Gray = Color3.fromRGB(193, 178, 172)
	local Bibi = Color3.fromRGB(53, 46, 45)
	Object.Explosion.LightEmission = 1
	Object.Explosion.LightInfluence = 0
	Object.Explosion.Color = ColorSequence.new(Orange,Orange)
	local Light = Instance.new("PointLight")
	Light.Color = Color3.fromRGB(255, 233, 187)
	Light.Brightness = 1
	Light.Range = 6
	Light.Shadows = true
	Light.Parent = Object
	local Explosion = Instance.new("Explosion")
	Explosion.Name = 'GrenExplosion'
	Explosion.BlastRadius = Radius*.875
	Explosion.BlastPressure = 0
	Explosion.Position = Object.Position
	Explosion.Parent = Object
	Explosion.Visible = false
	Explosion.Hit:Connect(function(hit, distance)
		local explodePos = Explosion.Position
		for _,v in pairs(game.Players:GetPlayers()) do
			if v.Character and v.Character:FindFirstChild('Humanoid') and v.Character.Humanoid.Health > 0 then
				local hm = v.Character:FindFirstChild('HumanoidRootPart')
				local dist = (hm.Position-explodePos).Magnitude
				if hm and dist <= Radius then
					if canSee(explodePos,v.Character.Head.Position,{v.Character,script.Parent}) then
						--print('Can see!')
						if hit.Name == "HumanoidRootPart" and hit.Parent:FindFirstChild("Humanoid") then
							OnExplosionHit(hit.Parent, distance, Object.Position)
						end
					end
					
					if hit.Name == "HumanoidRootPart" and hit.Parent:FindFirstChild("Humanoid") then
						if hit.Parent:FindFirstChild("Humanoid").Health > 0 and distance <= Radius * 0.80 and hit.Parent.Saude.Variaveis:FindFirstChild("HeadsetOn").Value == false then
							
							local DistanceFactor = distance/Radius
							DistanceFactor = 1-DistanceFactor
							
							local guiMain = script.Bangson:Clone()
							guiMain.Time.Value = 15 * DistanceFactor
							guiMain.Dist.Value = distance
							guiMain.Blur.Value = 15 * DistanceFactor
							guiMain.Stun.Disabled = false
							guiMain.Parent = hit.Parent
							print('Humanoid stunned!')
						end
					end
					
				end
			end
		end
	end)
	wait(0.1)
	Light:Destroy()
	Object.Transparency = 1
	Beps.Transparency = 1
	wait(7.5)
    Object:Destroy()
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

function boom()
	wait(3)
	local raytop = Ray.new(rootpart.CFrame.p,Vector3.new(0,90,0))
	local hit,position = workspace:FindPartOnRay(raytop,rootpart)
	Used = true
	Object.Anchored = true
	Object.CanCollide = false
	Object.Sparks.Enabled = false
	Object.Orientation = Vector3.new(0,0,0)
	Object.Transparency = 1
	Object.Fuse:Stop()
	Object.Explode.PlaybackSpeed = Object.Explode.PlaybackSpeed*(math.random(0.9,1.1))
	Object.Dist.PlaybackSpeed = Object.Explode.PlaybackSpeed*(math.random(0.9,1.1))
	Object.Dist2.PlaybackSpeed = Object.Explode.PlaybackSpeed*(math.random(0.9,1.1))
	Object.Dist3.PlaybackSpeed = Object.Explode.PlaybackSpeed*(math.random(0.9,1.1))
	local outdoor = Object.Outdoor
	local indoor = Object.Indoor
	if hit and hit:IsA("BasePart") and hit.Material ~= Enum.Material.Grass then
		local indoorclose = indoor.Close:GetChildren()
		local indoorCchosen = indoorclose[math.random(#indoorclose)].SoundId
		Object.Explode.SoundId = indoorCchosen
		local indoordist = indoor.Distant:GetChildren()
		local indoorDchosen = indoorclose[math.random(#indoorclose)].SoundId
		Object.Dist2.SoundId = indoorDchosen
		Object.Dist.SoundId = ""
		Object.Dist3.SoundId = ""
	else
		local outdoorclose = outdoor.Close:GetChildren()
		local outdoorCchosen = outdoorclose[math.random(#outdoorclose)].SoundId
		Object.Explode.SoundId = outdoorCchosen
		local outdoordist = outdoor.Distant:GetChildren()
		local outdoorDchosen = outdoordist[math.random(#outdoordist)].SoundId
		Object.Dist2.SoundId = outdoorDchosen
		local outdoorfar = outdoor.Far:GetChildren()
		local outdoorFchosen = outdoorfar[math.random(#outdoorfar)].SoundId
		Object.Dist3.SoundId = outdoorFchosen
		Object.Dist.SoundId = ""
	end
	task.wait(.05); Object:AddTag("3DSoundEmitter"); Object.Explode:Play()
	Object.Dist:Play()
	Object.Dist2:Play()
	Object.Dist3:Play()
	ran = math.random(1,3)
	c = 1
	for i,sfx in pairs(Object:GetChildren()) do
		c = c + 1
		if c <= 3 then
			delay(.1,function()
				Object["Hit"..ran]:Play()
				ran = math.random(1,3)
			end)
		end
	end
	for i,x in pairs(Object:GetChildren()) do
		if x:IsA("ParticleEmitter") and x.Name ~= "Sparks" then
			x.Enabled = true
			delay(0.2,function()
				x.Enabled = false
			end)
		end
	end
	Explode()
end

Object.Touched:Connect(function(part)
	if Used == true or part.Name == "Handle" then return end
	if part:IsDescendantOf(Tag.Value.Character) then return end
	if part.Parent then
		Used = true
		local SSS = game:GetService("ServerScriptService")
		local BreakModule = require(SSS:WaitForChild("PartFractureModule"))
		local HitPart = part
		local shattersfx = game.ReplicatedStorage.ACS_Engine.Shatter:GetChildren()
		local PhysicsService = game:GetService("PhysicsService")
		if HitPart ~= nil and HitPart.Name == "BreakableObj" or HitPart.Material == Enum.Material.Glass and HitPart.Parent.Name ~= "Top" or (HitPart.Transparency >= 0.15 and HitPart.Transparency < 1 and HitPart.Parent.Name ~= "Top" and HitPart.Name ~= "Ignorable" and (HitPart.Material == Enum.Material.Glass)) then --Name of the part that's breakable.
			if HitPart ~= nil then
				local BreakingPoint = HitPart:FindFirstChild("BreakingPoint") --Finds the BReaking Point Attachment.
				if BreakingPoint and BreakingPoint:IsA("Attachment") then
					BreakingPoint.WorldPosition = BreakingPoint.WorldPosition * Vector3.new(0,Object.Position.Y,Object.Position.Z) -- Break position = bullet hit posisiton. 
					BreakingPoint.Position = Vector3.new(0, BreakingPoint.Position.Y, BreakingPoint.Position.Z) 
					PhysicsService:SetPartCollisionGroup(HitPart, "GlassParts")
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
						BreakingPoint2.WorldPosition = Object.Position -- Break position = bullet hit posisiton. 
						BreakingPoint2.Position = Vector3.new(0, BreakingPoint2.Position.Y, BreakingPoint2.Position.Z) 
						BreakingPoint2.WorldOrientation = HitPart.Orientation
						BreakModule.FracturePart(HitPart) -- Calls the module that will be given on the bottom of this message.
					end
				end
			end
		end
		local list = Object.ImpactSound:GetChildren()
		local chosen = list[math.random(#list)].SoundId
		Object.Impact.SoundId = chosen
		Object.Impact:Play()
		for i,x in pairs(Object:GetChildren()) do
			if x:IsA("BasePart") then
				PhysicsService:SetPartCollisionGroup(x, "GlassParts")
			end
		end
		Object.Velocity = Vector3.new(Object.Velocity.x/10,Object.Velocity.y/10,Object.Velocity.z/10)
		Object.RotVelocity = Vector3.new(Object.RotVelocity.x/10,Object.RotVelocity.y/10,Object.RotVelocity.z/10)
		game:GetService("Debris"):AddItem(Object, 10)
	end
end)

for i,v in pairs(Object:GetDescendants()) do
	if v:IsA("Sound") then
		v.SoundGroup = game.SoundService.All.Throwables
	end
end

boom()