--By Rufus14
canattack = true
cananimate = false
equipped = false
tool = script.Parent
handle = tool.Handle
equipsound = handle.Equip
unequipsound = handle.Unequip
stabsound = handle.Stab
hitsound = handle.Hit
spraysound = handle.Spray
event = tool:WaitForChild("knifeevent")
hitmarkersound = handle.Hitmarker
swooshsound = handle.Swoosh
owner = nil
character = nil
trail = handle.Trail
skins = {"http://www.roblox.com/asset/?id=1587951817","http://www.roblox.com/asset/?id=197196512", "http://www.roblox.com/asset/?id=873992779", "http://www.roblox.com/asset/?id=255807446", "http://www.roblox.com/asset/?id=168000980", "http://www.roblox.com/asset/?id=874577611", "http://www.roblox.com/asset/?id=360376241", "http://www.roblox.com/asset/?id=1905836992", "http://www.roblox.com/asset/?id=155682302", "http://www.roblox.com/asset/?id=165164425","rbxassetid://389248139","http://www.roblox.com/asset/?id=4355817810", "rbxassetid://559676009","http://www.roblox.com/asset/?id=795156885","http://www.roblox.com/asset/?id=228691514","http://www.roblox.com/asset/?id=159953078","http://www.roblox.com/asset/?id=162822166","rbxassetid://998076663","http://www.roblox.com/asset/?id=161024169","http://www.roblox.com/asset/?id=163093131","http://www.roblox.com/asset/?id=175680432","http://www.roblox.com/asset/?id=201595653","http://www.roblox.com/asset/?id=161380326","http://www.roblox.com/asset/?id=367624667","http://www.roblox.com/asset/?id=173946596"}
skinnumber = 0
step = game:GetService("RunService").Stepped
swingnum = 0
spinning = false
canthrow = false
throwpos = nil
pressed = false
function spinanimation()
	local spinvalue = 0
	spinning = true
	swooshsound.PlaybackSpeed = 1+(math.random(-2,6)/20)
	swooshsound:Play()
	for i = 1,14 do
		if cananimate then
			tool.Grip = tool.Grip * CFrame.fromEulerAnglesXYZ(-0.5,0,0)
			step:wait()
		end
	end
	spinning = false
	trail.Enabled = false
end
--
event.OnServerEvent:connect(function(player, what, where)
	if player == owner then
		if what == "throw" and canthrow and not canattack then
			throwpos = where.p
		end
		if what == "skin" then
			spraysound:Play()
			skinnumber = skinnumber + 1
			if skinnumber > table.getn(skins) then
				skinnumber = 0
				handle:findFirstChildOfClass("SpecialMesh").TextureId = "http://www.roblox.com/asset/?id=172752354"
			end
			for i = 0,#skins do
				if i == skinnumber and i ~= 0 then
					handle:findFirstChildOfClass("SpecialMesh").TextureId = skins[i]
				end
			end
		end
	end
end)
tool.Activated:connect(function()
	pressed = true
end)
tool.Deactivated:connect(function()
	pressed = false
end)
--
function damage()
	for i,v in pairs(workspace:GetDescendants()) do
		if v.ClassName == "Model" then
			local head = v:findFirstChild("Head")
			local humanoid = v:findFirstChildOfClass("Humanoid")
			local torso = v:findFirstChild("Torso")
			local ragdolled = v:findFirstChild("ragdolledknife")
			if humanoid and head and not ragdolled then
				if (head.Position - handle.Position).magnitude < 2 and v ~= character and humanoid.Health > 0 then
					stabsound.PlaybackSpeed = 1+(math.random(-4,4)/10)
					stabsound:Play()
					hitmarkersound:Play()
					local dmg = math.random(20,50)
					if humanoid.Health <= dmg then
						humanoid.Health = 0
						ragdollkill(v)
					end
					humanoid.Health = humanoid.Health - dmg
					local ragdolledknife = Instance.new("BoolValue", v)
					ragdolledknife.Name = "ragdolledknife"
					local velocity = Instance.new("BodyVelocity", head)
					velocity.MaxForce = Vector3.new(math.huge,0,math.huge)
					velocity.Velocity = character.HumanoidRootPart.CFrame.lookVector * math.random(5,15)
					humanoid.PlatformStand = true
					coroutine.wrap(function()
						wait(1)
						humanoid.PlatformStand = false
					end)()
					game.Debris:AddItem(ragdolledknife, 1)
					game.Debris:AddItem(velocity, 0.2)
					if torso then
						coroutine.wrap(function()
							humanoid = v:WaitForChild("Humanoid")
							local ragdoll = v
							if ragdoll:findFirstChild("Right Arm") then
								local glue = Instance.new("Glue", ragdoll.Torso)
								glue.Part0 = ragdoll.Torso
								glue.Part1 = ragdoll:findFirstChild("Right Arm")
								glue.C0 = CFrame.new(1.5, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0)
								glue.C1 = CFrame.new(0, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0)
								local limbcollider = Instance.new("Part", ragdoll:findFirstChild("Right Arm"))
								limbcollider.Size = Vector3.new(1.4,1,1)
								limbcollider.Shape = "Cylinder"
								limbcollider.Transparency = 1
								limbcollider.Name = "LimbCollider"
								local limbcolliderweld = Instance.new("Weld", limbcollider)
								limbcolliderweld.Part0 = ragdoll:findFirstChild("Right Arm")
								limbcolliderweld.Part1 = limbcollider
								limbcolliderweld.C0 = CFrame.fromEulerAnglesXYZ(0,0,math.pi/2) * CFrame.new(-0.3,0,0)
								coroutine.wrap(function()
									if ragdoll.Torso:findFirstChild("Right Shoulder") then
										local limbclone = ragdoll.Torso:findFirstChild("Right Shoulder"):Clone()
										ragdoll.Torso:findFirstChild("Right Shoulder"):destroy()
										coroutine.wrap(function()
											wait(1)
											limbclone.Parent = ragdoll.Torso
											limbclone.Part0 = ragdoll.Torso
											limbclone.Part1 = ragdoll["Right Arm"]
										end)()
									end
									wait(1)
									glue:destroy()
									limbcollider:destroy()
									limbcolliderweld:destroy()
								end)()
							end
							if ragdoll:findFirstChild("Left Arm") then
								local glue = Instance.new("Glue", ragdoll.Torso)
								glue.Part0 = ragdoll.Torso
								glue.Part1 = ragdoll:findFirstChild("Left Arm")
								glue.C0 = CFrame.new(-1.5, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
								glue.C1 = CFrame.new(0, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
								local limbcollider = Instance.new("Part", ragdoll:findFirstChild("Left Arm"))
								limbcollider.Size = Vector3.new(1.4,1,1)
								limbcollider.Shape = "Cylinder"
								limbcollider.Name = "LimbCollider"
								limbcollider.Transparency = 1
								local limbcolliderweld = Instance.new("Weld", limbcollider)
								limbcolliderweld.Part0 = ragdoll:findFirstChild("Left Arm")			
								limbcolliderweld.Part1 = limbcollider
								limbcolliderweld.C0 = CFrame.fromEulerAnglesXYZ(0,0,math.pi/2) * CFrame.new(-0.3,0,0)
								coroutine.wrap(function()
									if ragdoll.Torso:findFirstChild("Left Shoulder") then
										local limbclone = ragdoll.Torso:findFirstChild("Left Shoulder"):Clone()
										ragdoll.Torso:findFirstChild("Left Shoulder"):destroy()
										coroutine.wrap(function()
											wait(1)
											limbclone.Parent = ragdoll.Torso
											limbclone.Part0 = ragdoll.Torso
											limbclone.Part1 = ragdoll["Left Arm"]
										end)()
									end
									wait(1)
									glue:destroy()
									limbcollider:destroy()
									limbcolliderweld:destroy()
								end)()
							end
							if ragdoll:findFirstChild("Left Leg") then
								local glue = Instance.new("Glue", ragdoll.Torso)
								glue.Part0 = ragdoll.Torso
								glue.Part1 = ragdoll:findFirstChild("Left Leg")
								glue.C0 = CFrame.new(-0.5, -1, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0)
								glue.C1 = CFrame.new(-0, 1, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0)
								local limbcollider = Instance.new("Part", ragdoll:findFirstChild("Left Leg"))
								limbcollider.Size = Vector3.new(1.5,1,1)
								limbcollider.Shape = "Cylinder"
								limbcollider.Name = "LimbCollider"
								limbcollider.Transparency = 1
								local limbcolliderweld = Instance.new("Weld", limbcollider)
								limbcolliderweld.Part0 = ragdoll:findFirstChild("Left Leg")
								limbcolliderweld.Part1 = limbcollider
								limbcolliderweld.C0 = CFrame.fromEulerAnglesXYZ(0,0,math.pi/2) * CFrame.new(-0.2,0,0)
								coroutine.wrap(function()
									if ragdoll.Torso:findFirstChild("Left Hip") then
										local limbclone = ragdoll.Torso:findFirstChild("Left Hip"):Clone()
										ragdoll.Torso:findFirstChild("Left Hip"):destroy()
										coroutine.wrap(function()
											wait(1)
											limbclone.Parent = ragdoll.Torso
											limbclone.Part0 = ragdoll.Torso
											limbclone.Part1 = ragdoll["Left Leg"]
										end)()
									end
									wait(1)
									glue:destroy()
									limbcollider:destroy()
									limbcolliderweld:destroy()
								end)()
							end
							if ragdoll:findFirstChild("Right Leg") then
								local glue = Instance.new("Glue", ragdoll.Torso)
								glue.Part0 = ragdoll.Torso
								glue.Part1 = ragdoll:findFirstChild("Right Leg")
								glue.C0 = CFrame.new(0.5, -1, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0)
								glue.C1 = CFrame.new(0, 1, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0)
								local limbcollider = Instance.new("Part", ragdoll:findFirstChild("Right Leg"))
								limbcollider.Size = Vector3.new(1.5,1,1)
								limbcollider.Shape = "Cylinder"
								limbcollider.Name = "LimbCollider"
								limbcollider.Transparency = 1
								local limbcolliderweld = Instance.new("Weld", limbcollider)
								limbcolliderweld.Part0 = ragdoll:findFirstChild("Right Leg")
								limbcolliderweld.Part1 = limbcollider
								limbcolliderweld.C0 = CFrame.fromEulerAnglesXYZ(0,0,math.pi/2) * CFrame.new(-0.2,0,0)
								coroutine.wrap(function()
									if ragdoll.Torso:findFirstChild("Right Hip") then
										local limbclone = ragdoll.Torso:findFirstChild("Right Hip"):Clone()
										ragdoll.Torso:findFirstChild("Right Hip"):destroy()
										coroutine.wrap(function()
											wait(1)
											limbclone.Parent = ragdoll.Torso
											limbclone.Part0 = ragdoll.Torso
											limbclone.Part1 = ragdoll["Right Leg"]
										end)()
									end
									wait(1)
									glue:destroy()
									limbcollider:destroy()
									limbcolliderweld:destroy()
								end)()
							end
						end)()
					end
				end
			end
		end
	end
end
function ragdollplr(v)
	local head = v.Head
	local torso = v:findFirstChild("Torso")
	local humanoid = v:findFirstChildOfClass("Humanoid")
	stabsound.PlaybackSpeed = 1+(math.random(-4,4)/10)
	stabsound:Play()
	hitmarkersound:Play()
	local dmg = math.random(20,50)
	if humanoid.Health <= dmg then
		humanoid.Health = 0
		ragdollkill(v)
	end
	humanoid.Health = humanoid.Health - dmg
	local ragdolledknife = Instance.new("BoolValue", v)
	ragdolledknife.Name = "ragdolledknife"
	local velocity = Instance.new("BodyVelocity", head)
	velocity.MaxForce = Vector3.new(math.huge,0,math.huge)
	velocity.Velocity = character.HumanoidRootPart.CFrame.lookVector * math.random(5,15)
	humanoid.PlatformStand = true
	coroutine.wrap(function()
		wait(1)
		humanoid.PlatformStand = false
	end)()
	game.Debris:AddItem(ragdolledknife, 1)
	game.Debris:AddItem(velocity, 0.2)
	if torso then
		coroutine.wrap(function()
			humanoid = v:WaitForChild("Humanoid")
			local ragdoll = v
			if ragdoll:findFirstChild("Right Arm") then
				local glue = Instance.new("Glue", ragdoll.Torso)
				glue.Part0 = ragdoll.Torso
				glue.Part1 = ragdoll:findFirstChild("Right Arm")
				glue.C0 = CFrame.new(1.5, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0)
				glue.C1 = CFrame.new(0, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0)
				local limbcollider = Instance.new("Part", ragdoll:findFirstChild("Right Arm"))
				limbcollider.Size = Vector3.new(1.4,1,1)
				limbcollider.Shape = "Cylinder"
				limbcollider.Transparency = 1
				limbcollider.Name = "LimbCollider"
				local limbcolliderweld = Instance.new("Weld", limbcollider)
				limbcolliderweld.Part0 = ragdoll:findFirstChild("Right Arm")
				limbcolliderweld.Part1 = limbcollider
				limbcolliderweld.C0 = CFrame.fromEulerAnglesXYZ(0,0,math.pi/2) * CFrame.new(-0.3,0,0)
				coroutine.wrap(function()
					if ragdoll.Torso:findFirstChild("Right Shoulder") then
						local limbclone = ragdoll.Torso:findFirstChild("Right Shoulder"):Clone()
						ragdoll.Torso:findFirstChild("Right Shoulder"):destroy()
						coroutine.wrap(function()
							wait(1)
							limbclone.Parent = ragdoll.Torso
							limbclone.Part0 = ragdoll.Torso
							limbclone.Part1 = ragdoll["Right Arm"]
						end)()
					end
					wait(1)
					glue:destroy()
					limbcollider:destroy()
					limbcolliderweld:destroy()
				end)()
			end
			if ragdoll:findFirstChild("Left Arm") then
				local glue = Instance.new("Glue", ragdoll.Torso)
				glue.Part0 = ragdoll.Torso
				glue.Part1 = ragdoll:findFirstChild("Left Arm")
				glue.C0 = CFrame.new(-1.5, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
				glue.C1 = CFrame.new(0, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
				local limbcollider = Instance.new("Part", ragdoll:findFirstChild("Left Arm"))
				limbcollider.Size = Vector3.new(1.4,1,1)
				limbcollider.Shape = "Cylinder"
				limbcollider.Name = "LimbCollider"
				limbcollider.Transparency = 1
				local limbcolliderweld = Instance.new("Weld", limbcollider)
				limbcolliderweld.Part0 = ragdoll:findFirstChild("Left Arm")			
				limbcolliderweld.Part1 = limbcollider
				limbcolliderweld.C0 = CFrame.fromEulerAnglesXYZ(0,0,math.pi/2) * CFrame.new(-0.3,0,0)
				coroutine.wrap(function()
					if ragdoll.Torso:findFirstChild("Left Shoulder") then
						local limbclone = ragdoll.Torso:findFirstChild("Left Shoulder"):Clone()
						ragdoll.Torso:findFirstChild("Left Shoulder"):destroy()
						coroutine.wrap(function()
							wait(1)
							limbclone.Parent = ragdoll.Torso
							limbclone.Part0 = ragdoll.Torso
							limbclone.Part1 = ragdoll["Left Arm"]
						end)()
					end
					wait(1)
					glue:destroy()
					limbcollider:destroy()
					limbcolliderweld:destroy()
				end)()
			end
			if ragdoll:findFirstChild("Left Leg") then
				local glue = Instance.new("Glue", ragdoll.Torso)
				glue.Part0 = ragdoll.Torso
				glue.Part1 = ragdoll:findFirstChild("Left Leg")
				glue.C0 = CFrame.new(-0.5, -1, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0)
				glue.C1 = CFrame.new(-0, 1, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0)
				local limbcollider = Instance.new("Part", ragdoll:findFirstChild("Left Leg"))
				limbcollider.Size = Vector3.new(1.5,1,1)
				limbcollider.Shape = "Cylinder"
				limbcollider.Name = "LimbCollider"
				limbcollider.Transparency = 1
				local limbcolliderweld = Instance.new("Weld", limbcollider)
				limbcolliderweld.Part0 = ragdoll:findFirstChild("Left Leg")
				limbcolliderweld.Part1 = limbcollider
				limbcolliderweld.C0 = CFrame.fromEulerAnglesXYZ(0,0,math.pi/2) * CFrame.new(-0.2,0,0)
				coroutine.wrap(function()
					if ragdoll.Torso:findFirstChild("Left Hip") then
						local limbclone = ragdoll.Torso:findFirstChild("Left Hip"):Clone()
						ragdoll.Torso:findFirstChild("Left Hip"):destroy()
						coroutine.wrap(function()
							wait(1)
							limbclone.Parent = ragdoll.Torso
							limbclone.Part0 = ragdoll.Torso
							limbclone.Part1 = ragdoll["Left Leg"]
						end)()
					end
					wait(1)
					glue:destroy()
					limbcollider:destroy()
					limbcolliderweld:destroy()
				end)()
			end
			if ragdoll:findFirstChild("Right Leg") then
				local glue = Instance.new("Glue", ragdoll.Torso)
				glue.Part0 = ragdoll.Torso
				glue.Part1 = ragdoll:findFirstChild("Right Leg")
				glue.C0 = CFrame.new(0.5, -1, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0)
				glue.C1 = CFrame.new(0, 1, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0)
				local limbcollider = Instance.new("Part", ragdoll:findFirstChild("Right Leg"))
				limbcollider.Size = Vector3.new(1.5,1,1)
				limbcollider.Shape = "Cylinder"
				limbcollider.Name = "LimbCollider"
				limbcollider.Transparency = 1
				local limbcolliderweld = Instance.new("Weld", limbcollider)
				limbcolliderweld.Part0 = ragdoll:findFirstChild("Right Leg")
				limbcolliderweld.Part1 = limbcollider
				limbcolliderweld.C0 = CFrame.fromEulerAnglesXYZ(0,0,math.pi/2) * CFrame.new(-0.2,0,0)
				coroutine.wrap(function()
					if ragdoll.Torso:findFirstChild("Right Hip") then
						local limbclone = ragdoll.Torso:findFirstChild("Right Hip"):Clone()
						ragdoll.Torso:findFirstChild("Right Hip"):destroy()
						coroutine.wrap(function()
							wait(1)
							limbclone.Parent = ragdoll.Torso
							limbclone.Part0 = ragdoll.Torso
							limbclone.Part1 = ragdoll["Right Leg"]
						end)()
					end
					wait(1)
					glue:destroy()
					limbcollider:destroy()
					limbcolliderweld:destroy()
				end)()
			end
		end)()
	end
end
tool.Activated:connect(function()
	if owner ~= nil and character ~= nil and canattack then
		cananimate = false
		canattack = false
		local rightarmweld = character.Torso:findFirstChild("RightArmWeldknif")
		local leftarmweld = character.Torso:findFirstChild("LeftArmWeldknif")
		local headweld = character.Torso:findFirstChild("HeadWeldknif")
		local rootweld = character.HumanoidRootPart:findFirstChild("HumanoidRootPartWeldknif")
		swooshsound:Play()
		swooshsound.PlaybackSpeed = 1+(math.random(-4,4)/20)
		trail.Enabled = true
		if swingnum == 0 then
			swingnum = 1
			for i = 1,21 do
				damage()
				headweld.C0 = headweld.C0:lerp(CFrame.new(0,1,0) * CFrame.fromEulerAnglesXYZ(0,math.sin(i/4)*2,0) * CFrame.new(0,0.5,0),0.2)
				tool.Grip = tool.Grip:lerp(CFrame.new(0,-0.85,0) * CFrame.fromEulerAnglesXYZ(math.sin(-i/4),0,0),0.2)
				rootweld.C0 = rootweld.C0:lerp(CFrame.fromEulerAnglesXYZ(math.sin(i/4)/15,math.sin(-i/4)*2,0), 0.2)
				leftarmweld.C0 = leftarmweld.C0:lerp(CFrame.new(-1.5,0.5,0) * CFrame.fromEulerAnglesXYZ(math.sin(i/4)*0.6,0,math.sin(i/4)/1.5) * CFrame.new(0,-0.5,0), 0.2)
				rightarmweld.C0 = rightarmweld.C0:lerp(CFrame.new(1.5,0.5,0) * CFrame.fromEulerAnglesXYZ(math.sin(-i/4)*1.8,0,math.rad(30)+math.sin(-i/4)) * CFrame.new(0,-0.5,0), 0.2)
				step:wait()
			end
			spawn(spinanimation)
		elseif swingnum == 1 then
			swingnum = 2
			local howup = 0
			for i = 1,21 do
				howup = howup + 1
				damage()
				headweld.C0 = headweld.C0:lerp(CFrame.new(0,1,0) * CFrame.fromEulerAnglesXYZ(0,math.sin(i/4)*2.5,0) * CFrame.new(0,0.5,0),0.2)
				tool.Grip = tool.Grip:lerp(CFrame.new(0,-0.85,0) * CFrame.fromEulerAnglesXYZ(math.sin(-i/4),0,0),0.2)
				rootweld.C0 = rootweld.C0:lerp(CFrame.fromEulerAnglesXYZ(math.sin(i/4)/15,math.sin(-i/4)*2.5,0), 0.2)
				leftarmweld.C0 = leftarmweld.C0:lerp(CFrame.new(-1.5,0.5,0) * CFrame.fromEulerAnglesXYZ(0,0,-math.pi/4) * CFrame.new(0,-0.5,0), 0.2)
				rightarmweld.C0 = rightarmweld.C0:lerp(CFrame.new(1.5-(howup/30),0.5,-(howup/15)) * CFrame.fromEulerAnglesXYZ(0,-math.pi+howup/6,-math.pi/3-(howup/30)) * CFrame.new(0,-0.5,0), 0.2)
				step:wait()
			end
			damage()
			spawn(spinanimation)
		elseif swingnum == 2 then
			swingnum = 0
			for i = 1,21 do
				damage()
				headweld.C0 = headweld.C0:lerp(CFrame.new(0,1,0) * CFrame.fromEulerAnglesXYZ(0,math.sin(i/3)/2,0) * CFrame.new(0,0.5,0),0.2)
				tool.Grip = tool.Grip:lerp(CFrame.new(0,-0.85,0) * CFrame.fromEulerAnglesXYZ(math.pi,0,0),0.2)
				rootweld.C0 = rootweld.C0:lerp(CFrame.fromEulerAnglesXYZ(math.sin(i/3)/10,math.sin(-i/3)/2,0), 0.2)
				leftarmweld.C0 = leftarmweld.C0:lerp(CFrame.new(-1.5,0.5,0) * CFrame.fromEulerAnglesXYZ(math.sin(i/3.5)*2,0,0) * CFrame.new(0,-0.7,0), 0.2)
				rightarmweld.C0 = rightarmweld.C0:lerp(CFrame.new(1.5,0.5,0) * CFrame.fromEulerAnglesXYZ(math.sin(i/3.5)*2+math.pi,0,0) * CFrame.new(0,-1,0), 0.2)
				step:wait()
			end
			trail.Enabled = false
		end
		if equipped then
			cananimate = true
		end
		if not pressed then
			canattack = true
		else
			canthrow = true
			cananimate = false
			local throwsine = 0
			while pressed and equipped and not cananimate and step:wait() do
				throwsine = throwsine + 1
				headweld.C0 = headweld.C0:lerp(CFrame.new(0,1,0) * CFrame.fromEulerAnglesXYZ(0,math.pi/3+math.sin(throwsine/20)/40,0) * CFrame.new(0,0.5,0),0.2)
				tool.Grip = tool.Grip:lerp(CFrame.new(0,-0.85,0) * CFrame.fromEulerAnglesXYZ(-math.rad(30),0,0),0.2)
				rootweld.C0 = rootweld.C0:lerp(CFrame.fromEulerAnglesXYZ(math.sin(throwsine/20)/40,-math.pi/3+math.sin(-throwsine/20)/40,0), 0.2)
				leftarmweld.C0 = leftarmweld.C0:lerp(CFrame.new(-1.5,0.5,0) * CFrame.fromEulerAnglesXYZ(math.rad(40)+math.sin(throwsine/20)/15,0,0) * CFrame.new(0,-0.5,0), 0.2)
				rightarmweld.C0 = rightarmweld.C0:lerp(CFrame.new(1.5,0.5,0) * CFrame.fromEulerAnglesXYZ(math.sin(throwsine/20)/20+math.pi,0,0) * CFrame.new(0,-0.7,0), 0.2)
			end
			if not equipped then
				handle.Transparency = 0
				throwpos = nil
				cananimate = true
				canattack = true
				return
			end
			swooshsound.PlaybackSpeed = 1+(math.random(-1,4)/10)
			swooshsound:Play()
			for i = 1,5 do
				headweld.C0 = headweld.C0:lerp(CFrame.new(0,1,0) * CFrame.fromEulerAnglesXYZ(0,-math.pi/3,0) * CFrame.new(0,0.5,0),0.2)
				tool.Grip = tool.Grip:lerp(CFrame.new(0,-0.85,0) * CFrame.fromEulerAnglesXYZ(-math.rad(30),0,0),0.2)
				rootweld.C0 = rootweld.C0:lerp(CFrame.fromEulerAnglesXYZ(-math.rad(10),math.pi/3,0), 0.2)
				leftarmweld.C0 = leftarmweld.C0:lerp(CFrame.new(-1.5,0.5,0) * CFrame.fromEulerAnglesXYZ(math.rad(-40),0,0) * CFrame.new(0,-0.5,0), 0.2)
				rightarmweld.C0 = rightarmweld.C0:lerp(CFrame.new(1.5,0.5,0) * CFrame.fromEulerAnglesXYZ(math.rad(10),0,0) * CFrame.new(0,-0.5,0), 0.2)
				step:wait()
			end
			handle.Transparency = 1
			local knifeclone = Instance.new("Part", character.Head)
			knifeclone.Size = Vector3.new(0.15, 1.9, 0.7)
			knifeclone.CanCollide = false
			knifeclone.Anchored = true
			knifeclone.Name = "ThrowKnife"
			knifeclone.CFrame = CFrame.new(handle.Position, throwpos)
			local mesh = Instance.new("SpecialMesh", knifeclone)
			mesh.TextureId = handle:findFirstChildOfClass("SpecialMesh").TextureId
			mesh.MeshId = "http://www.roblox.com/asset/?id=121944778"
			mesh.Scale = Vector3.new(0.7,0.7,0.7)
			coroutine.wrap(function()
				local rotatevalue = 0
				local rayhit = false
				local lastpos = nil
				local throwtime = 500
				local gravitypower = 0
				local lasttorsopos = character.Torso.CFrame
				while step:wait() and not rayhit do
					throwtime = throwtime - 1
					if throwtime == 0 then
						knifeclone:Destroy()
						break
					end
					if rotatevalue >= 360 then
						rotatevalue = 0
					end
					knifeclone.CFrame = knifeclone.CFrame * CFrame.fromEulerAnglesXYZ(math.rad(rotatevalue),0,0)
					rotatevalue = rotatevalue + 20
					local ignorelist = {handle, knifeclone, character}
					for q,w in pairs(workspace:GetDescendants()) do
						if w.Name == "ThrowKnife" then
							table.insert(ignorelist, w)
						end
					end
					local ray = Ray.new(knifeclone.Position, knifeclone.CFrame.lookVector*3)
					local ray1 = Ray.new(knifeclone.Position, knifeclone.CFrame.upVector*((-0.25)+(-gravitypower)))
					local hitt, pos = workspace:FindPartOnRayWithIgnoreList(ray, ignorelist)
					local hitt1, pos1 = workspace:FindPartOnRayWithIgnoreList(ray1, ignorelist)
					if hitt then
						--if hitt.Name ~= "ThrowKnife" then
							rayhit = true
							knifeclone.CFrame = CFrame.new(pos)
							if lastpos ~= nil then
								knifeclone.CFrame = CFrame.new(knifeclone.Position, lastpos.p)
							else
								knifeclone.CFrame = CFrame.new(knifeclone.Position, lasttorsopos.p)
							end
							knifeclone.CFrame = knifeclone.CFrame * CFrame.fromEulerAnglesXYZ(-math.pi/2,0,math.pi)
							local weldknife = Instance.new("Weld", knifeclone)
							weldknife.C0 = hitt.CFrame:toObjectSpace(knifeclone.CFrame)
							weldknife.Part0 = hitt
							weldknife.Name = "ouch_weld"
							weldknife.Part1 = knifeclone
							knifeclone.Anchored = false
							local hithumanoid = false
							coroutine.wrap(function()
								knifeclone.Parent = hitt
								wait()
								hitsound.Parent = knifeclone
								hitsound.PlaybackSpeed = 3.2+(math.random(-1,4)/10)
								hitsound:Play()
								wait(hitsound.TimeLength)
								hitsound.Parent = handle
							end)()
							if hitt.Parent:findFirstChildOfClass("Humanoid") then
								hithumanoid = true
								coroutine.wrap(function()
									wait()
									stabsound.Parent = knifeclone
									stabsound.PlaybackSpeed = 1+(math.random(-1,4)/10)
									stabsound:Play()
									wait(stabsound.TimeLength)
									stabsound.Parent = handle
								end)()
								hitt.Parent:findFirstChildOfClass("Humanoid").Health = hitt.Parent:findFirstChildOfClass("Humanoid").Health - math.random(50,100)
								ragdollplr(hitt.Parent)
							elseif hitt.Parent.ClassName == "Accessory" or hitt.Parent.ClassName == "Hat" then
								if hitt.Parent.Parent:findFirstChildOfClass("Humanoid") then
									hithumanoid = true
									coroutine.wrap(function()
										wait()
										stabsound.Parent = knifeclone
										stabsound.PlaybackSpeed = 1+(math.random(-1,4)/10)
										stabsound:Play()
										wait(stabsound.TimeLength)
										stabsound.Parent = handle
									end)()
									hitt.Parent.Parent:findFirstChildOfClass("Humanoid").Health = hitt.Parent.Parent:findFirstChildOfClass("Humanoid").Health - math.random(50,100)
									ragdollplr(hitt.Parent.Parent)
								end
							end
							if not hithumanoid then
								game.Debris:AddItem(knifeclone, 30)
							end
						--end
					elseif hitt1 then
						--if hitt1.Name ~= "ThrowKnife" then
							rayhit = true
							knifeclone.CFrame = CFrame.new(pos1)
							knifeclone.CFrame = CFrame.new(knifeclone.Position, lasttorsopos.p)
							knifeclone.CFrame = knifeclone.CFrame * CFrame.fromEulerAnglesXYZ(math.pi/1.5,math.pi,0)
							local weldknife = Instance.new("Weld", knifeclone)
							weldknife.C0 = hitt1.CFrame:toObjectSpace(knifeclone.CFrame)
							weldknife.Part0 = hitt1
							weldknife.Name = "ouch_weld"
							weldknife.Part1 = knifeclone
							knifeclone.Anchored = false
							local hithumanoid = false
							coroutine.wrap(function()
								knifeclone.Parent = hitt1
								wait()
								hitsound.Parent = knifeclone
								hitsound.PlaybackSpeed = 3.2+(math.random(-1,4)/10)
								hitsound:Play()
								wait(hitsound.TimeLength)
								hitsound.Parent = handle
							end)()
							if hitt1.Parent:findFirstChildOfClass("Humanoid") then
								hithumanoid = true
								coroutine.wrap(function()
									wait()
									stabsound.Parent = knifeclone
									stabsound.PlaybackSpeed = 1+(math.random(-1,4)/10)
									stabsound:Play()
									wait(stabsound.TimeLength)
									stabsound.Parent = handle
								end)()
								hitt1.Parent:findFirstChildOfClass("Humanoid").Health = hitt1.Parent:findFirstChildOfClass("Humanoid").Health - math.random(50,100)
								ragdollplr(hitt1.Parent)
							elseif hitt1.Parent.ClassName == "Accessory" or hitt1.Parent.ClassName == "Hat" then
								if hitt1.Parent.Parent:findFirstChildOfClass("Humanoid") then
									hithumanoid = true
									coroutine.wrap(function()
										wait()
										stabsound.Parent = knifeclone
										stabsound.PlaybackSpeed = 1+(math.random(-1,4)/10)
										stabsound:Play()
										wait(stabsound.TimeLength)
										stabsound.Parent = handle
									end)()
									hitt1.Parent.Parent:findFirstChildOfClass("Humanoid").Health = hitt1.Parent.Parent:findFirstChildOfClass("Humanoid").Health - math.random(50,100)
									ragdollplr(hitt1.Parent.Parent)
								end
							end
							if not hithumanoid then
								game.Debris:AddItem(knifeclone, 30)
							end
						--end
					end
					if not rayhit then
						gravitypower = gravitypower + 0.015
						knifeclone.CFrame = knifeclone.CFrame * CFrame.new(0,-gravitypower,-3)
						lastpos = knifeclone.CFrame
						knifeclone.CFrame = knifeclone.CFrame * CFrame.fromEulerAnglesXYZ(-math.rad(rotatevalue),0,0)
					end
				end
			end)()
			for i = 1,15 do
				headweld.C0 = headweld.C0:lerp(CFrame.new(0,1,0) * CFrame.fromEulerAnglesXYZ(0,-math.pi/3,0) * CFrame.new(0,0.5,0),0.2)
				tool.Grip = tool.Grip:lerp(CFrame.new(0,-0.85,0) * CFrame.fromEulerAnglesXYZ(-math.rad(30),0,0),0.2)
				rootweld.C0 = rootweld.C0:lerp(CFrame.fromEulerAnglesXYZ(-math.rad(10),math.pi/3,0), 0.2)
				leftarmweld.C0 = leftarmweld.C0:lerp(CFrame.new(-1.5,0.5,0) * CFrame.fromEulerAnglesXYZ(math.rad(-40),0,0) * CFrame.new(0,-0.5,0), 0.2)
				rightarmweld.C0 = rightarmweld.C0:lerp(CFrame.new(1.5,0.5,0) * CFrame.fromEulerAnglesXYZ(math.rad(10),0,0) * CFrame.new(0,-0.5,0), 0.2)
				step:wait()
			end
			handle.Transparency = 0
			throwpos = nil
			cananimate = true
			canattack = true
		end
	end
end)
tool.Equipped:connect(function()
	equipped = true
	owner = game:GetService("Players"):GetPlayerFromCharacter(tool.Parent)
	character = owner.Character
	cananimate = true
	local sine = 0
	equipsound:Play()
	tool.Grip = CFrame.new(0,-0.85,0)
	if character:findFirstChild("KnifeBack") then
		character:findFirstChild("KnifeBack").Transparency = 1
	end
	local rightarm = Instance.new("Weld", character.Torso)
	rightarm.Part0 = character.Torso
	rightarm.Part1 = character["Right Arm"]
	rightarm.C0 = CFrame.new(1.5,0,0)
	rightarm.Name = "RightArmWeldknif"
	local leftarm = Instance.new("Weld", character.Torso)
	leftarm.Part0 = character.Torso
	leftarm.Part1 = character["Left Arm"]
	leftarm.C0 = CFrame.new(-1.5,0,0)
	leftarm.Name = "LeftArmWeldknif"
	local head = Instance.new("Weld", character.Torso)
	head.Part0 = character.Torso
	head.Part1 = character.Head
	head.C0 = CFrame.new(0,1.5,0)
	head.Name = "HeadWeldknif"
	local humanoidrootpart = Instance.new("Weld", character.HumanoidRootPart)
	humanoidrootpart.Part0 = character.HumanoidRootPart
	humanoidrootpart.Part1 = character.Torso
	humanoidrootpart.Name = "HumanoidRootPartWeldknif"
	coroutine.wrap(function()
		while step:wait() do
			if cananimate then
				sine = sine + 1
				head.C0 = head.C0:lerp(CFrame.new(0,1.5,0),0.1)
				if not spinning then
					tool.Grip = tool.Grip:lerp(CFrame.new(0,-0.85,0),0.1)
				end
				humanoidrootpart.C0 = humanoidrootpart.C0:lerp(CFrame.new(),0.1)
				leftarm.C0 = leftarm.C0:lerp(CFrame.new(-1.5,0.5,0) * CFrame.fromEulerAnglesXYZ(math.pi/2.7 + math.rad(1.5*math.sin(sine/40)),math.pi/-3 + math.rad(1.5*-math.cos(sine/80)),0) * CFrame.new(0,-0.5,0),0.1)
				rightarm.C0 = rightarm.C0:lerp(CFrame.new(1.5,0.5,0) * CFrame.fromEulerAnglesXYZ(math.pi/2.7 + math.rad(1.5*math.sin(sine/40)),math.pi/3 + math.rad(1.5*math.cos(sine/80)),0) * CFrame.new(0,-0.5,0),0.1)
			end
		end
	end)()
end)
tool.Unequipped:connect(function()
	equipped = false
	cananimate = false
	canthrow = false
	unequipsound:Play()
	if character.Torso:findFirstChild("LeftArmWeldknif") then
		character.Torso:findFirstChild("LeftArmWeldknif"):destroy()
	end
	if character.Torso:findFirstChild("RightArmWeldknif") then
		character.Torso:findFirstChild("RightArmWeldknif"):destroy()
	end
	if character.Torso:findFirstChild("HeadWeldknif") then
		character.Torso:findFirstChild("HeadWeldknif"):destroy()
	end
	if character:findFirstChild("HumanoidRootPart") then
		if character.HumanoidRootPart:findFirstChild("HumanoidRootPartWeldknif") then
			character.HumanoidRootPart:findFirstChild("HumanoidRootPartWeldknif"):destroy()
		end
	end
	if not character:findFirstChild("KnifeBack") then
		local clone = handle:Clone()
		clone:BreakJoints()
		for i,v in pairs(clone:GetDescendants()) do
			if v.ClassName ~= "SpecialMesh" and v.ClassName ~= "TouchTransmitter" then
				v:destroy()
			end
		end
		local weld = Instance.new("Weld", clone)
		weld.Part0 = character.Torso
		weld.Part1 = clone
		weld.C0 = CFrame.new(1,-1,0)
		weld.C0 = weld.C0 * CFrame.fromEulerAnglesXYZ(math.pi-(math.pi/3),0,0)
		clone.Parent = character
		clone.Name = "KnifeBack"
	else
		character:findFirstChild("KnifeBack").Transparency = 0
	end
	character.KnifeBack:findFirstChildOfClass("SpecialMesh").TextureId = handle:findFirstChildOfClass("SpecialMesh").TextureId
end)
function ragdollkill(character)
	local victimshumanoid = character:findFirstChildOfClass("Humanoid")
	local checkragd = character:findFirstChild("ragded")
	if not checkragd then
		local boolvalue = Instance.new("BoolValue", character)
		boolvalue.Name = "ragded"
		if not character:findFirstChild("UpperTorso") then
			character.Archivable = true
			for i,v in pairs(character:GetChildren()) do
				if v.ClassName == "Sound" then
					v:remove()
				end
				for q,w in pairs(v:GetChildren()) do
					if w.ClassName == "Sound" then
						w:remove()
					end
				end
			end
			local ragdoll = character:Clone()
			for i,v in pairs(ragdoll:GetDescendants()) do
				if v.ClassName == "Motor" or v.ClassName == "Motor6D" then
					v:destroy()
				end
			end
			ragdoll:findFirstChildOfClass("Humanoid").BreakJointsOnDeath = false
			ragdoll:findFirstChildOfClass("Humanoid").Health = 0
			if ragdoll:findFirstChild("Health") then
				if ragdoll:findFirstChild("Health").ClassName == "Script" then
					ragdoll:findFirstChild("Health").Disabled = true
				end
			end
			for i,v in pairs(character:GetChildren()) do
				if v.ClassName == "Part" or v.ClassName == "ForceField" or v.ClassName == "Accessory" or v.ClassName == "Hat" then
					v:destroy()
				end
			end
			for i,v in pairs(character:GetChildren()) do
				if v.ClassName == "Accessory" then
					local attachment1 = v.Handle:findFirstChildOfClass("Attachment")
					if attachment1 then
						for q,w in pairs(character:GetChildren()) do
							if w.ClassName == "Part" then
								local attachment2 = w:findFirstChild(attachment1.Name)
								if attachment2 then
									local hinge = Instance.new("HingeConstraint", v.Handle)
									hinge.Attachment0 = attachment1
									hinge.Attachment1 = attachment2
									hinge.LimitsEnabled = true
									hinge.LowerAngle = 0
									hinge.UpperAngle = 0
								end
							end
						end
					end
				end
			end
			ragdoll.Parent = workspace
			if ragdoll:findFirstChild("Right Arm") then
				local glue = Instance.new("Glue", ragdoll.Torso)
				glue.Part0 = ragdoll.Torso
				glue.Part1 = ragdoll:findFirstChild("Right Arm")
				glue.C0 = CFrame.new(1.5, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0)
				glue.C1 = CFrame.new(0, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0)
				local limbcollider = Instance.new("Part", ragdoll:findFirstChild("Right Arm"))
				limbcollider.Size = Vector3.new(1.4,1,1)
				limbcollider.Shape = "Cylinder"
				limbcollider.Transparency = 1
				limbcollider.Name = "LimbCollider"
				local limbcolliderweld = Instance.new("Weld", limbcollider)
				limbcolliderweld.Part0 = ragdoll:findFirstChild("Right Arm")
				limbcolliderweld.Part1 = limbcollider
				limbcolliderweld.C0 = CFrame.fromEulerAnglesXYZ(0,0,math.pi/2) * CFrame.new(-0.3,0,0)
			end
			if ragdoll:findFirstChild("Left Arm") then
				local glue = Instance.new("Glue", ragdoll.Torso)
				glue.Part0 = ragdoll.Torso
				glue.Part1 = ragdoll:findFirstChild("Left Arm")
				glue.C0 = CFrame.new(-1.5, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
				glue.C1 = CFrame.new(0, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
				local limbcollider = Instance.new("Part", ragdoll:findFirstChild("Left Arm"))
				limbcollider.Size = Vector3.new(1.4,1,1)
				limbcollider.Shape = "Cylinder"
				limbcollider.Name = "LimbCollider"
				limbcollider.Transparency = 1
				local limbcolliderweld = Instance.new("Weld", limbcollider)
				limbcolliderweld.Part0 = ragdoll:findFirstChild("Left Arm")
				limbcolliderweld.Part1 = limbcollider
				limbcolliderweld.C0 = CFrame.fromEulerAnglesXYZ(0,0,math.pi/2) * CFrame.new(-0.3,0,0)
			end
			if ragdoll:findFirstChild("Left Leg") then
				local glue = Instance.new("Glue", ragdoll.Torso)
				glue.Part0 = ragdoll.Torso
				glue.Part1 = ragdoll:findFirstChild("Left Leg")
				glue.C0 = CFrame.new(-0.5, -1, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0)
				glue.C1 = CFrame.new(-0, 1, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0)
				local limbcollider = Instance.new("Part", ragdoll:findFirstChild("Left Leg"))
				limbcollider.Size = Vector3.new(1.4,1,1)
				limbcollider.Shape = "Cylinder"
				limbcollider.Name = "LimbCollider"
				limbcollider.Transparency = 1
				local limbcolliderweld = Instance.new("Weld", limbcollider)
				limbcolliderweld.Part0 = ragdoll:findFirstChild("Left Leg")
				limbcolliderweld.Part1 = limbcollider
				limbcolliderweld.C0 = CFrame.fromEulerAnglesXYZ(0,0,math.pi/2) * CFrame.new(-0.3,0,0)
			end
			if ragdoll:findFirstChild("Right Leg") then
				local glue = Instance.new("Glue", ragdoll.Torso)
				glue.Part0 = ragdoll.Torso
				glue.Part1 = ragdoll:findFirstChild("Right Leg")
				glue.C0 = CFrame.new(0.5, -1, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0)
				glue.C1 = CFrame.new(0, 1, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0)
				local limbcollider = Instance.new("Part", ragdoll:findFirstChild("Right Leg"))
				limbcollider.Size = Vector3.new(1.4,1,1)
				limbcollider.Shape = "Cylinder"
				limbcollider.Name = "LimbCollider"
				limbcollider.Transparency = 1
				local limbcolliderweld = Instance.new("Weld", limbcollider)
				limbcolliderweld.Part0 = ragdoll:findFirstChild("Right Leg")
				limbcolliderweld.Part1 = limbcollider
				limbcolliderweld.C0 = CFrame.fromEulerAnglesXYZ(0,0,math.pi/2) * CFrame.new(-0.3,0,0)
			end
			if ragdoll:findFirstChild("Head") and ragdoll.Torso:findFirstChild("NeckAttachment") then
				local HeadAttachment = Instance.new("Attachment", ragdoll["Head"])
				HeadAttachment.Position = Vector3.new(0, -0.5, 0)
				local connection = Instance.new('HingeConstraint', ragdoll["Head"])
				connection.LimitsEnabled = true
				connection.Attachment0 = ragdoll.Torso.NeckAttachment
				connection.Attachment1 = HeadAttachment
				connection.UpperAngle = 60
				connection.LowerAngle = -60
			elseif ragdoll:findFirstChild("Head") and not ragdoll.Torso:findFirstChild("NeckAttachment") then
				local hedweld = Instance.new("Weld", ragdoll.Torso)
				hedweld.Part0 = ragdoll.Torso
				hedweld.Part1 = ragdoll.Head
				hedweld.C0 = CFrame.new(0,1.5,0)
			end
			game.Debris:AddItem(ragdoll, 30)
			local function aaaalol()
				wait(0.2)
				local function searchforvelocity(wot)
					for i,v in pairs(wot:GetChildren()) do
						searchforvelocity(v)
						if v.ClassName == "BodyPosition" or v.ClassName == "BodyVelocity" then
							v:destroy()
						end
					end
				end
				searchforvelocity(ragdoll)
				wait(0.5)
				if ragdoll:findFirstChildOfClass("Humanoid") then
					ragdoll:findFirstChildOfClass("Humanoid").PlatformStand = true
				end
				if ragdoll:findFirstChild("HumanoidRootPart") then
					ragdoll:findFirstChild("HumanoidRootPart"):destroy()
				end
			end
			spawn(aaaalol)
		elseif character:findFirstChild("UpperTorso") then
			character.Archivable = true
			for i,v in pairs(character:GetChildren()) do
				if v.ClassName == "Sound" then
					v:remove()
				end
				for q,w in pairs(v:GetChildren()) do
					if w.ClassName == "Sound" then
						w:remove()
					end
				end
			end
			local ragdoll = character:Clone()
			ragdoll:findFirstChildOfClass("Humanoid").BreakJointsOnDeath = false
			for i,v in pairs(ragdoll:GetDescendants()) do
				if v.ClassName == "Motor" or v.ClassName == "Motor6D" then
					v:destroy()
				end
			end
			ragdoll:BreakJoints()
			ragdoll:findFirstChildOfClass("Humanoid").Health = 0
			if ragdoll:findFirstChild("Health") then
				if ragdoll:findFirstChild("Health").ClassName == "Script" then
					ragdoll:findFirstChild("Health").Disabled = true
				end
			end
			for i,v in pairs(character:GetChildren()) do
				if v.ClassName == "Part" or v.ClassName == "ForceField" or v.ClassName == "Accessory" or v.ClassName == "Hat" or v.ClassName == "MeshPart" then
					v:destroy()
				end
			end
			for i,v in pairs(character:GetChildren()) do
				if v.ClassName == "Accessory" then
					local attachment1 = v.Handle:findFirstChildOfClass("Attachment")
					if attachment1 then
						for q,w in pairs(character:GetChildren()) do
							if w.ClassName == "Part" or w.ClassName == "MeshPart" then
								local attachment2 = w:findFirstChild(attachment1.Name)
								if attachment2 then
									local hinge = Instance.new("HingeConstraint", v.Handle)
									hinge.Attachment0 = attachment1
									hinge.Attachment1 = attachment2
									hinge.LimitsEnabled = true
									hinge.LowerAngle = 0
									hinge.UpperAngle = 0
								end
							end
						end
					end
				end
			end
			ragdoll.Parent = workspace
			local Humanoid = ragdoll:findFirstChildOfClass("Humanoid")
			Humanoid.PlatformStand = true
			local function makeballconnections(limb, attachementone, attachmenttwo, twistlower, twistupper)
				local connection = Instance.new('BallSocketConstraint', limb)
				connection.LimitsEnabled = true
				connection.Attachment0 = attachementone
				connection.Attachment1 = attachmenttwo
				connection.TwistLimitsEnabled = true
				connection.TwistLowerAngle = twistlower
				connection.TwistUpperAngle = twistupper
				local limbcollider = Instance.new("Part", limb)
				limbcollider.Size = Vector3.new(0.1,1,1)
				limbcollider.Shape = "Cylinder"
				limbcollider.Transparency = 1
				limbcollider:BreakJoints()
				local limbcolliderweld = Instance.new("Weld", limbcollider)
				limbcolliderweld.Part0 = limb
				limbcolliderweld.Part1 = limbcollider
				limbcolliderweld.C0 = CFrame.fromEulerAnglesXYZ(0,0,math.pi/2)
			end
			local function makehingeconnections(limb, attachementone, attachmenttwo, lower, upper)
				local connection = Instance.new('HingeConstraint', limb)
				connection.LimitsEnabled = true
				connection.Attachment0 = attachementone
				connection.Attachment1 = attachmenttwo
				connection.LimitsEnabled = true
				connection.LowerAngle = lower
				connection.UpperAngle = upper
				local limbcollider = Instance.new("Part", limb)
				limbcollider.Size = Vector3.new(0.1,1,1)
				limbcollider.Shape = "Cylinder"
				limbcollider.Transparency = 1
				limbcollider:BreakJoints()
				local limbcolliderweld = Instance.new("Weld", limbcollider)
				limbcolliderweld.Part0 = limb
				limbcolliderweld.Part1 = limbcollider
				limbcolliderweld.C0 = CFrame.fromEulerAnglesXYZ(0,0,math.pi/2)
			end
			local HeadAttachment = Instance.new("Attachment", Humanoid.Parent.Head)
			HeadAttachment.Position = Vector3.new(0, -0.5, 0)
			if ragdoll.UpperTorso:findFirstChild("NeckAttachment") then
				makehingeconnections(Humanoid.Parent.Head, HeadAttachment, ragdoll.UpperTorso.NeckAttachment, -50, 50)
			end
			makehingeconnections(Humanoid.Parent.LowerTorso, Humanoid.Parent.LowerTorso.WaistRigAttachment, Humanoid.Parent.UpperTorso.WaistRigAttachment, -50, 50)
			makeballconnections(Humanoid.Parent.LeftUpperArm, Humanoid.Parent.LeftUpperArm.LeftShoulderRigAttachment, Humanoid.Parent.UpperTorso.LeftShoulderRigAttachment, -200, 200, 180)
			makehingeconnections(Humanoid.Parent.LeftLowerArm, Humanoid.Parent.LeftLowerArm.LeftElbowRigAttachment, Humanoid.Parent.LeftUpperArm.LeftElbowRigAttachment, 0, -60)
			makehingeconnections(Humanoid.Parent.LeftHand, Humanoid.Parent.LeftHand.LeftWristRigAttachment, Humanoid.Parent.LeftLowerArm.LeftWristRigAttachment, -20, 20)
			--
			makeballconnections(Humanoid.Parent.RightUpperArm, Humanoid.Parent.RightUpperArm.RightShoulderRigAttachment, Humanoid.Parent.UpperTorso.RightShoulderRigAttachment, -200, 200, 180)
			makehingeconnections(Humanoid.Parent.RightLowerArm, Humanoid.Parent.RightLowerArm.RightElbowRigAttachment, Humanoid.Parent.RightUpperArm.RightElbowRigAttachment, 0, -60)
			makehingeconnections(Humanoid.Parent.RightHand, Humanoid.Parent.RightHand.RightWristRigAttachment, Humanoid.Parent.RightLowerArm.RightWristRigAttachment, -20, 20)
			--
			makeballconnections(Humanoid.Parent.RightUpperLeg, Humanoid.Parent.RightUpperLeg.RightHipRigAttachment, Humanoid.Parent.LowerTorso.RightHipRigAttachment, -80, 80, 80)
			makehingeconnections(Humanoid.Parent.RightLowerLeg, Humanoid.Parent.RightLowerLeg.RightKneeRigAttachment, Humanoid.Parent.RightUpperLeg.RightKneeRigAttachment, 0, 60)
			makehingeconnections(Humanoid.Parent.RightFoot, Humanoid.Parent.RightFoot.RightAnkleRigAttachment, Humanoid.Parent.RightLowerLeg.RightAnkleRigAttachment, -20, 20)
			--
			makeballconnections(Humanoid.Parent.LeftUpperLeg, Humanoid.Parent.LeftUpperLeg.LeftHipRigAttachment, Humanoid.Parent.LowerTorso.LeftHipRigAttachment, -80, 80, 80)
			makehingeconnections(Humanoid.Parent.LeftLowerLeg, Humanoid.Parent.LeftLowerLeg.LeftKneeRigAttachment, Humanoid.Parent.LeftUpperLeg.LeftKneeRigAttachment, 0, 60)
			makehingeconnections(Humanoid.Parent.LeftFoot, Humanoid.Parent.LeftFoot.LeftAnkleRigAttachment, Humanoid.Parent.LeftLowerLeg.LeftAnkleRigAttachment, -20, 20)
			for i,v in pairs(Humanoid.Parent:GetChildren()) do
				if v.ClassName == "Accessory" then
					local attachment1 = v.Handle:findFirstChildOfClass("Attachment")
					if attachment1 then
						for q,w in pairs(Humanoid.Parent:GetChildren()) do
							if w.ClassName == "Part" then
								local attachment2 = w:findFirstChild(attachment1.Name)
								if attachment2 then
									local hinge = Instance.new("HingeConstraint", v.Handle)
									hinge.Attachment0 = attachment1
									hinge.Attachment1 = attachment2
									hinge.LimitsEnabled = true
									hinge.LowerAngle = 0
									hinge.UpperAngle = 0
								end
							end
						end
					end
				end
			end
			for i,v in pairs(ragdoll:GetChildren()) do
				for q,w in pairs(v:GetChildren()) do
					if w.ClassName == "Motor6D"--[[ and w.Name ~= "Neck"--]] and w.Name ~= "ouch_weld" then
						w:destroy()
					end
				end
			end
			if ragdoll:findFirstChild("HumanoidRootPart") then
				ragdoll.HumanoidRootPart:destroy()
			end
			if ragdoll:findFirstChildOfClass("Humanoid") then
				ragdoll:findFirstChildOfClass("Humanoid").PlatformStand = true
			end
			local function waitfordatmoment()
				wait(0.2)
				local function searchforvelocity(wot)
					for i,v in pairs(wot:GetChildren()) do
						searchforvelocity(v)
						if v.ClassName == "BodyPosition" or v.ClassName == "BodyVelocity" then
							v:destroy()
						end
					end
				end
				searchforvelocity(ragdoll)
			end
			spawn(waitfordatmoment)
			game.Debris:AddItem(ragdoll, 30)
		end
	end
end