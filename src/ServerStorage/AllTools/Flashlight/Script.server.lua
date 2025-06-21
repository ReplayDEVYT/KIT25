--By Rufus14
tool = script.Parent
handle = tool.Handle
unequipsound = handle.unequip
equipsound = handle.equip
swingsound = handle.swing
hitsound = handle.hit

players = game:GetService("Players")
runservice = game:GetService("RunService")

local owner
local character

equipped = false
cananimate = true
pose = "idle"
canattack = false

tool.Activated:connect(function()
	if equipped and canattack then
		canattack = false
		pose = "attack1"
		wait(0.3)
		swingsound:Play()
		pose = "attack2"
		local hitdat = false
		for i = 1,20 do
			if not hitdat then
				local ray = Ray.new(handle.Position, handle.CFrame.lookVector*1.5)
				local hit, position = workspace:FindPartOnRayWithIgnoreList(ray, {handle})
				if hit then
					hitdat = true
					hitsound:Play()
					local h = hit.Parent:findFirstChildOfClass("Humanoid")
					local ve = Instance.new("BodyVelocity", hit)
					ve.MaxForce = Vector3.new(math.huge,0,math.huge)
					ve.Velocity = character.HumanoidRootPart.CFrame.lookVector * math.random(20,30)
					game.Debris:AddItem(ve, 0.2)
					if h then
						h.PlatformStand = true
						h.Health = h.Health - math.random(10,20)
						coroutine.wrap(function()
							wait(1.5)
							h.PlatformStand = false
						end)()
					end
				end
			end
			runservice.Stepped:wait()
		end
		pose = "idle"
		canattack = true
	end
end)

tool.Equipped:connect(function()
	equipped = true
	equipsound:Play()
	owner = players:GetPlayerFromCharacter(tool.Parent)
	character = owner.Character
	pose = "idle"
	local rightgrip = character["Right Arm"]:WaitForChild("RightGrip")
	rightgrip.C0 = rightgrip.C0 * CFrame.fromEulerAnglesXYZ(-math.pi/2,0,0)
	local rightarm = Instance.new("Weld", character.Torso)
	rightarm.Part0 = character.Torso
	rightarm.Part1 = character["Right Arm"]
	rightarm.C0 = CFrame.new(1.5,0,0)
	rightarm.Name = "RightArmWeldflashlight"
	local head = Instance.new("Weld", character.Torso)
	head.Part0 = character.Torso
	head.Part1 = character.Head
	head.C0 = CFrame.new(0,1.5,0)
	head.Name = "HeadWeldflashlight"
	coroutine.wrap(function()
		while runservice.Stepped:wait() and equipped do
			if cananimate then
				if pose == "idle" then
					rightgrip.C0 = rightgrip.C0:lerp(CFrame.new(0, -1, 0, 1, 0, 0, 0, -1, -4.37113883e-08, 0, 4.37113883e-08, -1),0.2)
					head.C0 = head.C0:lerp(CFrame.new(0,1,0) * CFrame.fromEulerAnglesXYZ(math.sin(tick()/2)/15,-math.sin(tick()/4)/8,0) * CFrame.new(0,0.5,0),0.15)
					rightarm.C0 = rightarm.C0:lerp(CFrame.new(1.5,0.5,0) * CFrame.fromEulerAnglesXYZ(math.pi+math.sin(tick()/2)/13,math.sin(tick()/4)/8,0) * CFrame.new(0,-0.5,0),0.15)
				elseif pose == "attack1" then
					rightgrip.C0 = rightgrip.C0:lerp(CFrame.new(-0.00951004028, -1.25718498, -0.124379158, 0.167635769, -0.984956741, 0.0419336855, -0.309152097, -0.0121311247, 0.950935185, -0.936121345, -0.172374621, -0.306535006) * CFrame.fromEulerAnglesXYZ(-0.5,0,0),0.3)
					head.C0 = head.C0:lerp(CFrame.new(0, 1.5, 0, 0.984807789, 0, -0.17364797, 0, 0.99999994, 0, 0.173647955, 0, 0.98480773),0.3)
					rightarm.C0 = rightarm.C0:lerp(CFrame.new(1.9797554, 1.20706654, 0.0116883516, 0.5, -0.663413584, 0.556670725, 1.03272484e-08, -0.642787933, -0.766044021, 0.866025388, 0.38302204, -0.321393996),0.3)
				elseif pose == "attack2" then
					rightgrip.C0 = rightgrip.C0:lerp(CFrame.new(-0.267139435, -1.78174591, -0.0363783836, 0.172777861, -0.952141047, 0.252141535, -0.052498728, 0.246725321, 0.967662334, -0.983560741, -0.180427715, -0.00735751539),0.25)
					head.C0 = head.C0:lerp(CFrame.new(0, 1.49240398, -0.0868241787, 0.984807789, 0, 0.17364797, -0.0301536489, 0.98480773, 0.171010047, -0.171009868, -0.173648149, 0.969846308),0.4)
					rightarm.C0 = rightarm.C0:lerp(CFrame.new(0.495670319, 0.192181587, -1.33696675, 0.642787576, 0.719846249, 0.262002587, 3.34848629e-08, 0.342020065, -0.939692557, -0.766044438, 0.604022801, 0.219846264),0.4)
				end
			end
		end
		head:destroy()
		rightarm:destroy()
	end)()
end)

tool.Unequipped:connect(function()
	equipped = false
	unequipsound:Play()
end)