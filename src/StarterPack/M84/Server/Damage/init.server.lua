local Object = script.Parent
local Used = false

local SplashDamage = 5
local Radius = 100
local GrenadeArmorFactor = 0

local Tag = Object:WaitForChild("killer")
local Debris = game:GetService("Debris")

local function OnExplosionHit(Character, hitDistance, blastCenter)
	local Humanoid = Character:FindFirstChild("Humanoid")
	if hitDistance and blastCenter then
		local DistanceFactor = hitDistance/Radius
		DistanceFactor = 1-DistanceFactor

		if Humanoid then
			if Humanoid.Health > 0 then
				local guiMain = script.Bangson:Clone()
				guiMain.Time.Value = .1 * DistanceFactor
				guiMain.Dist.Value = hitDistance
				guiMain.Brightness.Value = -5 * DistanceFactor
				guiMain.Stun.Disabled = false
				guiMain.Parent = Character
				print('Humanoid stunned!')
			end
		end
	--elseif hitDistance then
	--	print('hitDistance provided, blastCenter nil')
	--elseif blastCenter then
	--	print('hitDistance nil, blastCenter provided')
	--else
	--	print('hitDistance nil, blastCenter nil')
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


local function Explode()

	local Light = Instance.new("PointLight")
	Light.Color = Color3.fromRGB(255, 255, 255)
	Light.Brightness = 1750
	Light.Range = 5
	Light.Shadows = true
	Light.Parent = Object

	local Explosion = Instance.new("Explosion")
	Explosion.BlastRadius = Radius*.875
	Explosion.BlastPressure = 0
	Explosion.Position = Object.Position
	Explosion.Parent = Object
	Explosion.Visible = false

	--Explosion.Hit:Connect(function(hit, distance)
	--	if hit.Name == "HumanoidRootPart" and hit.Parent:FindFirstChild("Humanoid") then
	--		print('Root part hit! running OnExplosionHit.')
	--		OnExplosionHit(hit.Parent, distance, Object.Position)
	--	end
	--end)

	
	local explodePos = Explosion.Position
	for _,v in pairs(game.Players:GetPlayers()) do
		if v.Character and v.Character:FindFirstChild('Humanoid') and v.Character.Humanoid.Health > 0 then
			local hm = v.Character:FindFirstChild('HumanoidRootPart')
			local dist = (hm.Position-explodePos).Magnitude
			if hm and dist <= Radius then
				if canSee(explodePos,v.Character.Head.Position,{v.Character,script.Parent}) then
					--print('Can see!')
					local ui = script.Bangson:Clone()
					ui.Time.Value = (1-(dist/Radius))*40
					ui.Dist.Value = dist
					ui.Brightness.Value = (1-(dist/Radius))*-5
					ui.Stun.Disabled = false
					ui.Parent = v.Character
				end
			end
		end
	end
	
	--for i,v in pairs(game.Players:GetPlayers())do
	--	if v.Character then
	--		if v.Character:FindFirstChild("HumanoidRootPart") then
	--			local HM = v.Character:FindFirstChild("HumanoidRootPart")
	--			if (HM.Position - Explosion.Position).Magnitude <= Radius then
	--				local ray = Ray.new(Explosion.Position, (HM.CFrame.p - Explosion.Position).unit * 1000)
	--				local part, position = workspace:FindPartOnRay(ray, Object, false, true)
	--				if part.Parent.Name == v.Name and part.Parent:FindFirstChild("Humanoid") ~= nil then
	--					if canSee(script.Parent, v.Character) then
	--						print("Olhou")
	--						if part.Parent:FindFirstChild("Humanoid") then
	--							if part.Parent:FindFirstChild("Humanoid").Health > 0 then
	--								local guiMain = script.Bangson:Clone()
	--								print(10 * (((((HM.CFrame.p - Explosion.Position).Magnitude)/Radius) - 1) *-1))
	--								guiMain.Time.Value = 10 * (((((HM.CFrame.p - Explosion.Position).Magnitude)/Radius) - 1) *-1)
	--								guiMain.Brightness.Value = 5 * (((((HM.CFrame.p - Explosion.Position).Magnitude)/Radius) - 1) *-1)
	--								guiMain.Parent = part.Parent
	--								guiMain.Bang.Disabled = false
	--							end
	--						end

	--					else
	--						print("Nope")
	--						if part.Parent:FindFirstChild("Humanoid") then
	--							if part.Parent:FindFirstChild("Humanoid").Health > 0 then
	--								local guiMain = script.Bangson:Clone()
	--								print(5 * (((((HM.CFrame.p - Explosion.Position).Magnitude)/Radius) - 1) *-1))
	--								guiMain.Time.Value = 5 * (((((HM.CFrame.p - Explosion.Position).Magnitude)/Radius) - 1) *-1)
	--								guiMain.Brightness.Value = 5 * (((((HM.CFrame.p - Explosion.Position).Magnitude)/Radius) - 1) *-1)
	--								guiMain.Parent = part.Parent
	--								guiMain.Bang.Disabled = false
	--							end
	--						end
	--					end
	--				end
	--			end
	--		end
	--	end
	--end



	wait(.2)
	Light:Destroy()
	wait(7)
	Object:Destroy()
end

--helpfully checks a table for a specific value
local function contains(t, v)
	for _, val in pairs(t) do
		if val == v then
			return true
		end
	end
	return false
end

--used by checkTeams

local function tagHuman(human)
	local tag = Tag:Clone()
	tag.Parent = human
	game:GetService("Debris"):AddItem(tag)
end

--use this to determine if you want this human to be harmed or not, returns boolean

local function boom()
	wait(2)
	Used = true
	Object.Anchored = false
	Object.Transparency = 1
	Object.CanCollide = true
	Object.Sparks.Enabled = false
	Object.Orientation = Vector3.new(0,0,0)
	Object.Fuse:Stop()
	local raytop = Ray.new(Object.CFrame.p,Vector3.new(0,90,0))
	local hit,position = workspace:FindPartOnRay(raytop,Object)
	
	local outdoor = Object.Outdoor
	local indoor = Object.Indoor
	if hit and hit:IsA("BasePart") and hit.Material ~= Enum.Material.Grass then
		local indoorclose = indoor.Close:GetChildren()
		local indoorCchosen = indoorclose[math.random(#indoorclose)].SoundId
		Object.Explode.SoundId = indoorCchosen
		local indoordist = indoor.Distant:GetChildren()
		local indoorDchosen = indoorclose[math.random(#indoorclose)].SoundId
		Object.Dist.SoundId = indoorDchosen
	else
		local outdoorclose = outdoor.Close:GetChildren()
		local outdoorCchosen = outdoorclose[math.random(#outdoorclose)].SoundId
		Object.Explode.SoundId = outdoorCchosen
		local outdoordist = outdoor.Distant:GetChildren()
		local outdoorDchosen = outdoordist[math.random(#outdoordist)].SoundId
		Object.Dist.SoundId = outdoorDchosen
	end
	
	task.wait(.05); Object:AddTag("3DSoundEmitter"); Object.Explode:Play()
	Object.Dist:Play()
	Object.Explosion:Emit(100)
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