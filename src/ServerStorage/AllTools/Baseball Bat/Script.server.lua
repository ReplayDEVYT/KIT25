--By Rufus14
canattack = true
cananimate = false
equipped = false
tool = script.Parent
handle = tool.Handle
equipsound = handle.Equip
swishsound = handle.Swoosh
hitsound = handle.Hit
goresound = handle.Ouch
hitsound2 = handle.Hit2
goresound2 = handle.Ouch2
owner = nil
character = nil
mouseclick = false
attacknumber = 1
attacktype = 0
count = 0
trail = handle.Trail
runservice = game:GetService("RunService")
--
tool.Activated:connect(function()
	mouseclick = true
end)
tool.Deactivated:connect(function()
	mouseclick = false
end)
--
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
function damage(action, force, maxforce, t)
	for i,v in pairs(workspace:GetDescendants()) do
		if v.ClassName == "Model" then
			local head = v:findFirstChild("Head")
			local humanoid = v:findFirstChildOfClass("Humanoid")
			local torso = v:findFirstChild("Torso")
			local ragdolled = v:findFirstChild("ragdolledbat")
			if humanoid and head then
				if (head.Position - handle.Position).magnitude < 3 and v ~= character and humanoid.Health > 0 then
					if action ~= "vibe check" then
						if ragdolled then
							return
						end
					end
					local rightarmweld = character.Torso:findFirstChild("RightArmWeldbat")
					local leftarmweld = character.Torso:findFirstChild("LeftArmWeldbat")
					local headweld = character.Torso:findFirstChild("HeadWeldbat")
					local rootweld = character.HumanoidRootPart:findFirstChild("HumanoidRootPartWeldbat")
					hitsound.PlaybackSpeed = 1+(math.random(-4,4)/20)
					hitsound:Play()
					hitsound2.PlaybackSpeed = 1+(math.random(-4,4)/20)
					hitsound2:Play()
					local velocity = Instance.new("BodyVelocity", head)
					velocity.MaxForce = Vector3.new(math.huge,0,math.huge)
					velocity.Velocity = character.HumanoidRootPart.CFrame.lookVector * math.random(force,maxforce)
					if action == "normal" then
						local dmg = math.random(30,80)
						if humanoid.Health <= dmg then
							humanoid.Health = 0
							humanoid.Parent:BreakJoints()
							ragdollkill(v)
						else
							humanoid.Health = humanoid.Health - dmg
						end
					elseif action == "critical" then
						local dmg = math.random(70,90)
						if humanoid.Health <= dmg then
							humanoid.Health = 0
							humanoid.Parent:BreakJoints()
							ragdollkill(v)
						else
							humanoid.Health = humanoid.Health - dmg
						end
					elseif action == "vibe check" then
						goresound.PlaybackSpeed = 1+(math.random(-4,4)/20)
						goresound:Play()
						goresound2.PlaybackSpeed = 1+(math.random(-4,4)/20)
						goresound2:Play()
						head.Transparency = 1
						for i = 1,math.random(25,30) do
							local hedd = Instance.new("Part", workspace)
							hedd.Size = Vector3.new(0.25,0.25,0.25)
							hedd.CFrame = head.CFrame * CFrame.new(math.random(-10,10)/20,math.random(-10,10)/20,math.random(-10,10)/20)
							game.Debris:AddItem(hedd, 7)
							if math.random(1,3) == 1 then
								hedd.BrickColor = head.BrickColor
								hedd.Material = head.Material
							else
								hedd.BrickColor = BrickColor.new("Maroon")
								hedd.Material = "Granite"
							end
						end
						for q,w in pairs(v:GetChildren()) do
							if w.ClassName == "Accessory" or w.ClassName == "Hat" then
								w:destroy()
							end
						end
						for q,w in pairs(head:GetChildren()) do
							if w.ClassName == "Weld" then
								if w.Part1 ~= nil then
									if w.Part1 ~= head then
										w.Part1:destroy()
									end
								end
							end
							if w.ClassName == "Decal"then
								w:destroy()
							end
						end
						humanoid.Health = 0
						humanoid.Parent:BreakJoints()
						ragdollkill(v)
					end
					local ragdolledknife = Instance.new("BoolValue", v)
					ragdolledknife.Name = "ragdolledbat"
					humanoid.PlatformStand = true
					coroutine.wrap(function()
						wait(t)
						humanoid.PlatformStand = false
					end)()
					game.Debris:AddItem(ragdolledknife, t)
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
											wait(t)
											limbclone.Parent = ragdoll.Torso
											limbclone.Part0 = ragdoll.Torso
											limbclone.Part1 = ragdoll["Right Arm"]
										end)()
									end
									wait(t)
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
											wait(t)
											limbclone.Parent = ragdoll.Torso
											limbclone.Part0 = ragdoll.Torso
											limbclone.Part1 = ragdoll["Left Arm"]
										end)()
									end
									wait(t)
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
											wait(t)
											limbclone.Parent = ragdoll.Torso
											limbclone.Part0 = ragdoll.Torso
											limbclone.Part1 = ragdoll["Left Leg"]
										end)()
									end
									wait(t)
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
											wait(t)
											limbclone.Parent = ragdoll.Torso
											limbclone.Part0 = ragdoll.Torso
											limbclone.Part1 = ragdoll["Right Leg"]
										end)()
									end
									wait(t)
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
tool.Deactivated:connect(function()
	if mouseclick and not cananimate then
		if count < 30 then
			cananimate = true
			canattack = true
			return
		end
		local rightarmweld = character.Torso:findFirstChild("RightArmWeldbat")
		local leftarmweld = character.Torso:findFirstChild("LeftArmWeldbat")
		local headweld = character.Torso:findFirstChild("HeadWeldbat")
		local rootweld = character.HumanoidRootPart:findFirstChild("HumanoidRootPartWeldbat")
		if attacknumber == 1 then
			trail.Enabled = true
			swishsound.PlaybackSpeed = 1+(math.random(-4,4)/20)
			swishsound:Play()
			for i = 0,1 , 0.1 do
				if attacktype == 0 then
					damage("normal", 10,20, 2)
				elseif attacktype == 1 then
					damage("critical", 20,30, 2.5)
				elseif attacktype == 2 then
					damage("vibe check", 30,40, 1)
				end
				tool.Grip = tool.Grip:lerp(CFrame.new(0, 0, -1.70000005, 0, 0, 1, 1, 0, 0, 0, 1, 0) * CFrame.fromEulerAnglesXYZ(math.pi/2,-(math.pi/3),0),0.1)
				headweld.C0 = headweld.C0:lerp(CFrame.new(9.53674316e-07, 1.49999952, 9.53674316e-07, 0.499999791, -1.49011612e-08, -0.866025269, -3.14321369e-09, 0.999999881, -1.49011612e-08, 0.866025388, -7.4505806e-09, 0.499999821),i)
				rightarmweld.C0 = rightarmweld.C0:lerp(CFrame.new(0.27244854, 0.123777866, -0.741029739, 0.642787457, 0.719846129, 0.262002736, 1.49011612e-08, 0.342020303, -0.939692438, -0.766044378, 0.604022741, 0.219846398),i)
				leftarmweld.C0 = leftarmweld.C0:lerp(CFrame.new(-0.993065834, 0.0928759575, -0.543260574, 0.981225848, -0.183488816, 0.0593911558, 0.116977744, 0.321393728, -0.939692438, 0.153335154, 0.928998232, 0.336824),i)
				rootweld.C0 = rootweld.C0:lerp(CFrame.new(0, 0, 0, 0.492403746, 0.0868240669, 0.866025448, -0.173648179, 0.98480773, 0, -0.852868557, -0.150383741, 0.499999881),i)
				runservice.Stepped:wait()
			end
			trail.Enabled = false
			attacknumber = 2
		elseif attacknumber == 2 then
			trail.Enabled = true
			swishsound.PlaybackSpeed = 1+(math.random(-4,4)/20)
			swishsound:Play()
			for i = 0,1 , 0.1 do
				if attacktype == 0 then
					damage("normal", 10,20, 2)
				elseif attacktype == 1 then
					damage("critical", 20,30, 2.5)
				elseif attacktype == 2 then
					damage("vibe check", 30,40, 1)
				end
				tool.Grip = tool.Grip:lerp(CFrame.new(0, 0, -1.70000005, 0, 0, 1, 1, 0, 0, 0, 1, 0) * CFrame.fromEulerAnglesXYZ(math.pi/2,(math.pi/2),0),0.1)
				headweld.C0 = headweld.C0:lerp(CFrame.new(0, 1.5, 1.90734863e-06, 0.642787576, 7.4505806e-09, 0.766044378, -1.0477379e-09, 0.99999994, 1.49011612e-08, -0.766044378, 0, 0.642787576),i)
				rightarmweld.C0 = rightarmweld.C0:lerp(CFrame.new(1.50000191, 0.328989983, -0.469844818, 0.99999994, 2.98023224e-08, -2.98023224e-08, 7.4505806e-09, 0.342020035, -0.939692438, 0, 0.939692378, 0.342020065),i)
				leftarmweld.C0 = leftarmweld.C0:lerp(CFrame.new(0.314659119, 0.191040754, -1.2273407, 0.344304681, -0.926735461, -0.150383726, 0.0301536545, 0.171010002, -0.984807611, 0.938373566, 0.334539324, 0.0868240297),i)
				rootweld.C0 = rootweld.C0:lerp(CFrame.new(0, 0, 0, 0.633022368, -0.111618921, -0.766044259, 0.173648179, 0.98480773, 0, 0.754406333, -0.133022189, 0.642787755) * CFrame.fromEulerAnglesXYZ(0,math.rad(20),0),i)
				runservice.Stepped:wait()
			end
			trail.Enabled = false
			attacknumber = 1
		end
		cananimate = true
		canattack = true
	end
end)
tool.Activated:connect(function()
	if owner ~= nil and character ~= nil and canattack then
		cananimate = false
		canattack = false
		attacktype = 0
		count = 0
		local rightarmweld = character.Torso:findFirstChild("RightArmWeldbat")
		local leftarmweld = character.Torso:findFirstChild("LeftArmWeldbat")
		local headweld = character.Torso:findFirstChild("HeadWeldbat")
		local rootweld = character.HumanoidRootPart:findFirstChild("HumanoidRootPartWeldbat")
		if handle:findFirstChild("AIDS") then
			handle.AIDS:destroy()
			local grip = character["Right Arm"]:WaitForChild("RightGrip")
			grip.Part1 = handle
		end
		for i,v in pairs(workspace:GetDescendants()) do
			if v.ClassName == "Model" and v ~= character then
				local humanoid = v:findFirstChildOfClass("Humanoid")
				local headepic = v:findFirstChild("Head")
				if humanoid and headepic then
					if (headepic.Position - character.HumanoidRootPart.Position).magnitude < 6 and humanoid.PlatformStand and humanoid.Health > 0 then
						local rightlegweld = Instance.new("Weld", character.Torso)
						rightlegweld.Part0 = character.Torso
						rightlegweld.Part1 = character["Right Leg"]
						rightlegweld.C0 = CFrame.new(0.5,-2,0)
						rightlegweld.Name = "RightLegWeldbat"
						local leftlegweld = Instance.new("Weld", character.Torso)
						leftlegweld.Part0 = character.Torso
						leftlegweld.Part1 = character["Left Leg"]
						leftlegweld.C0 = CFrame.new(-0.5,-2,0)
						leftlegweld.Name = "LeftLegWeldbat"
						character:findFirstChildOfClass("Humanoid").WalkSpeed = 0
						for i = 0,1 , 0.05 do
							cananimate = false
							canattack = false
							character.HumanoidRootPart.CFrame = CFrame.new(character.HumanoidRootPart.Position, Vector3.new(headepic.Position.x,character.HumanoidRootPart.Position.y,headepic.Position.z))
							tool.Grip = tool.Grip:lerp(CFrame.new(0, 0, -1.70000005, 0, 0, 1, 1, 0, 0, 0, 1, 0) * CFrame.fromEulerAnglesXYZ(math.pi/2,(math.pi/2)+math.rad(25),0),i)
							rightlegweld.C0 = rightlegweld.C0:lerp(CFrame.new(0.681245327, -2.07163143, 0, 0.98480773, -0.173648179, -2.98023224e-08, 0.173648164, 0.984807611, 7.4505806e-09, -2.98023224e-08, 1.14149561e-08, 1),i)
							leftlegweld.C0 = leftlegweld.C0:lerp(CFrame.new(-0.499999046, -1.39999986, -0.399999619, 0.99999994, -7.4505806e-09, -2.98023224e-08, 1.49011612e-08, 0.999999881, 7.4505806e-09, -2.98023224e-08, 0, 1),i)
							rightarmweld.C0 = rightarmweld.C0:lerp(CFrame.new(1.57790804, 0.75, 0.321748734, 0.342020154, -0.813797712, 0.469846278, -1.49011612e-08, -0.49999994, -0.866025209, 0.939692616, 0.29619813, -0.171010107),i)
							leftarmweld.C0 = leftarmweld.C0:lerp(CFrame.new(1.41171503, 0.67853117, -0.785638809, -0.468489617, -0.76629442, 0.439670324, -0.134425014, -0.430039823, -0.892745972, 0.873182297, -0.47734493, 0.0984600335),i)
							rootweld.C0 = rootweld.C0:lerp(CFrame.new(0, 0, 0, 0.633021891, 0.111618839, -0.766044736, -0.173648179, 0.98480773, 0, 0.75440675, 0.133022279, 0.642787278),i)
							headweld.C0 = headweld.C0:lerp(CFrame.new(-0.131000042, 1.46984625, -0.109922409, 0.642787337, -0.262002826, 0.719846427, -6.98491931e-10, 0.939692497, 0.342020392, -0.766044617, -0.219846383, 0.604022503),i)
							runservice.Stepped:wait()
						end
						trail.Enabled = true
						for i = 0,1 , 0.12 do
							damage("vibe check", 0, 0, 1)
							tool.Grip = tool.Grip:lerp(CFrame.new(0, 0, -1.70000005, 0, 0, 1, 1, 0, 0, 0, 1, 0) * CFrame.fromEulerAnglesXYZ(math.pi/2,0,0),i)
							rightlegweld.C0 = rightlegweld.C0:lerp(CFrame.new(0.499998093, -1.49999964, 0.866025925, 0.99999994, -2.98023224e-08, -3.7252903e-09, -7.4505806e-09, 0.499999911, 0.866025269, 0, -0.866025448, 0.49999994),i)
							leftlegweld.C0 = leftlegweld.C0:lerp(CFrame.new(-0.500001907, -0.739692211, -0.657979965, 0.99999994, 0, 2.98023224e-08, -7.4505806e-09, 0.939692378, 0.342020035, 0, -0.342020184, 0.939692616),i)
							rightarmweld.C0 = rightarmweld.C0:lerp(CFrame.new(0.569936752, 0.318357229, -1.03014803, 0.939692497, 0.342020154, 1.49011612e-08, -0.0593912005, 0.163175836, -0.984807611, -0.336824059, 0.92541647, 0.173648238),i)
							leftarmweld.C0 = leftarmweld.C0:lerp(CFrame.new(-0.429023743, 0.324180841, -0.997120857, 0.98480767, -0.173648149, 1.49011612e-08, 0.0301536694, 0.171010017, -0.984807611, 0.171010062, 0.969846368, 0.173648238),i)
							rootweld.C0 = rootweld.C0:lerp(CFrame.new(0, -1.19999969, 0, 0.950535476, -0.055632934, 0.305593252, -0.0479752049, 0.945729434, 0.321393996, -0.30688861, -0.320157319, 0.896280468),i)
							headweld.C0 = headweld.C0:lerp(CFrame.new(-1.90734863e-06, 1.5, 0, 0.98480773, -7.4505806e-09, -0.173648179, -1.49011612e-08, 0.999999881, 0, 0.173648253, -2.98023224e-08, 0.98480773),i)
							runservice.Stepped:wait()
						end
						coroutine.wrap(function()
							for i = 0,1 ,0.07 do
								leftlegweld.C0 = leftlegweld.C0:lerp(CFrame.new(-0.5,-2,0),i)
								rightlegweld.C0 = rightlegweld.C0:lerp(CFrame.new(0.5,-2,0),i)
								runservice.Stepped:wait()
							end
							leftlegweld:destroy()
							rightlegweld:destroy()
							character:findFirstChildOfClass("Humanoid").WalkSpeed = 16
						end)()
						trail.Enabled = false
						cananimate = true
						canattack = true
						return
					end
				end
			end
		end
		if attacknumber == 1 then
			coroutine.wrap(function()
				while runservice.Stepped:wait() and mouseclick do
					count = count + 1
					if count == 50 then
						attacktype = 1
						local effect = Instance.new("Part", workspace)
						effect.Material = "ForceField"
						effect.BrickColor = BrickColor.new("Institutional white")
						effect.Anchored = true
						effect.CanCollide = false
						effect.CFrame = handle.CFrame
						effect.Size = handle.Size
						coroutine.wrap(function()
							for i = 1,40 do
								effect.Transparency = effect.Transparency + 0.025
								effect.Size = effect.Size + Vector3.new(0.02,0.02,0.02)
								runservice.Stepped:wait()
							end
							effect:destroy()
						end)()
					end
					if count == 90 then
						attacktype = 2
						local effect = Instance.new("Part", workspace)
						effect.Material = "ForceField"
						effect.BrickColor = BrickColor.new("Really red")
						effect.Anchored = true
						effect.CanCollide = false
						effect.CFrame = handle.CFrame
						effect.Size = handle.Size
						coroutine.wrap(function()
							for i = 1,40 do
								effect.Transparency = effect.Transparency + 0.025
								effect.Size = effect.Size + Vector3.new(0.02,0.02,0.02)
								runservice.Stepped:wait()
							end
							effect:destroy()
						end)()
					end
					tool.Grip = tool.Grip:lerp(CFrame.new(0, 0, -1.70000005, 0, 0, 1, 1, 0, 0, 0, 1, 0) * CFrame.fromEulerAnglesXYZ(math.pi/2,(math.pi/2)+math.rad(25),0),0.1)
					headweld.C0 = headweld.C0:lerp(CFrame.new(-0.0815873146, 1.49240327, -0.0296955109, 0.342020094, -0.163175672, 0.925416231, 1.00699253e-08, 0.984807491, 0.173647955, -0.939692616, -0.0593911149, 0.336824059),0.1)
					rootweld.C0 = rootweld.C0:lerp(CFrame.new(0, 0, 0, 0.336824089, 0.0593911782, -0.939692616, -0.173648149, 0.984807611, 0, 0.92541641, 0.163175896, 0.342020154) * CFrame.fromEulerAnglesXYZ(math.sin(tick())/20,0,0),0.1)
					leftarmweld.C0 = leftarmweld.C0:lerp(CFrame.new(1.3505621, 0.950000048, -0.634313583, -0.342020035, -0.813797235, 0.469846278, -4.87780198e-08, -0.49999997, -0.866025031, 0.939692616, -0.29619804, 0.171010047) * CFrame.new(0,math.cos(tick())/20,0),0.1)
					rightarmweld.C0 = rightarmweld.C0:lerp(CFrame.new(1.58705735, 0.872320414, 0.129386902, 0.607604206, -0.566511154, 0.556670189, 0.111618847, -0.633021832, -0.766044259, 0.786357343, 0.527587116, -0.321393698) * CFrame.new(0,math.cos(tick())/20,0),0.1)
				end
			end)()
		elseif attacknumber == 2 then
			coroutine.wrap(function()
				while runservice.Stepped:wait() and mouseclick do
					count = count + 1
					if count == 50 then
						attacktype = 1
						local effect = Instance.new("Part", workspace)
						effect.Material = "ForceField"
						effect.BrickColor = BrickColor.new("Institutional white")
						effect.Anchored = true
						effect.CanCollide = false
						effect.CFrame = handle.CFrame
						effect.Size = handle.Size
						coroutine.wrap(function()
							for i = 1,40 do
								effect.Transparency = effect.Transparency + 0.025
								effect.Size = effect.Size + Vector3.new(0.02,0.02,0.02)
								runservice.Stepped:wait()
							end
							effect:destroy()
						end)()
					end
					if count == 90 then
						attacktype = 2
						local effect = Instance.new("Part", workspace)
						effect.Material = "ForceField"
						effect.BrickColor = BrickColor.new("Really red")
						effect.Anchored = true
						effect.CanCollide = false
						effect.CFrame = handle.CFrame
						effect.Size = handle.Size
						coroutine.wrap(function()
							for i = 1,40 do
								effect.Transparency = effect.Transparency + 0.025
								effect.Size = effect.Size + Vector3.new(0.02,0.02,0.02)
								runservice.Stepped:wait()
							end
							effect:destroy()
						end)()
					end
					tool.Grip = tool.Grip:lerp(CFrame.new(0, 0, -1.70000005, 0, 0, 1, 1, 0, 0, 0, 1, 0) * CFrame.fromEulerAnglesXYZ(math.pi/2,(-math.pi/2)+math.rad(25),0),0.1)
					headweld.C0 = headweld.C0:lerp(CFrame.new(0, 1.5, 0, 0.342020035, 0, -0.939692378, -1.64301071e-07, 1, -5.98006906e-08, 0.939692378, 1.74845525e-07, 0.342020035),0.1)
					rootweld.C0 = rootweld.C0:lerp(CFrame.new(0, 0, 0, 0.173648119, 0, 0.98480767, 0, 1, 0, -0.98480767, 0, 0.173648119) * CFrame.fromEulerAnglesXYZ(math.sin(tick())/20,0,0.1),0.1)
					leftarmweld.C0 = leftarmweld.C0:lerp(CFrame.new(-1.69218636, 0.638716698, -0.0404472351, 0.771280289, 0.613091826, -0.171010137, 0.0593912005, -0.336824268, -0.939692497, -0.633718252, 0.714609921, -0.296198249) * CFrame.new(0,math.cos(tick())/20,0),0.1)
					rightarmweld.C0 = rightarmweld.C0:lerp(CFrame.new(-1.2802496, 0.725742579, -0.5, -4.47034836e-08, 0.984807432, -0.173648149, 4.37113847e-08, -0.173648149, -0.984807551, -0.999999762, -2.98023224e-08, -3.35276127e-08) * CFrame.new(0,math.cos(tick())/20,0),0.1)
				end
			end)()
		end
	end
end)
--
tool.Equipped:connect(function()
	equipped = true
	trail.Enabled = false
	cananimate = true
	canattack = false
	handle.Transparency = 1
	owner = game:GetService("Players"):GetPlayerFromCharacter(tool.Parent)
	character = owner.Character
	local rightarm = Instance.new("Weld", character.Torso)
	rightarm.Part0 = character.Torso
	rightarm.Part1 = character["Right Arm"]
	rightarm.C0 = CFrame.new(1.5,0,0)
	rightarm.Name = "RightArmWeldbat"
	local leftarm = Instance.new("Weld", character.Torso)
	leftarm.Part0 = character.Torso
	leftarm.Part1 = character["Left Arm"]
	leftarm.C0 = CFrame.new(-1.5,0,0)
	leftarm.Name = "LeftArmWeldbat"
	local head = Instance.new("Weld", character.Torso)
	head.Part0 = character.Torso
	head.Part1 = character.Head
	head.C0 = CFrame.new(0,1.5,0)
	head.Name = "HeadWeldbat"
	local humanoidrootpart = Instance.new("Weld", character.HumanoidRootPart)
	humanoidrootpart.Part0 = character.HumanoidRootPart
	humanoidrootpart.Part1 = character.Torso
	humanoidrootpart.Name = "HumanoidRootPartWeldbat"
	for i = 0,1 , 0.05 do
		humanoidrootpart.C0 = humanoidrootpart.C0:lerp(CFrame.fromEulerAnglesXYZ(0,math.rad(25),0),i)
		leftarm.C0 = leftarm.C0:lerp(CFrame.new(-1.5,0.5,0) * CFrame.fromEulerAnglesXYZ(math.pi+math.rad(10),math.rad(75),math.rad(-10)) * CFrame.new(0,-0.5,0),i)
		rightarm.C0 = rightarm.C0:lerp(CFrame.new(1.5,0.5,0) * CFrame.fromEulerAnglesXYZ(0,0,math.rad(10)) * CFrame.new(0,-0.5,0),i)
		runservice.Stepped:wait()
	end
	local grip = character["Right Arm"]:WaitForChild("RightGrip")
	grip.Part1 = nil
	local weldd = Instance.new("Weld", handle)
	weldd.Part0 = character["Left Arm"]
	weldd.Part1 = handle
	weldd.Name = "AIDS"
	weldd.C0 = CFrame.new(0, 0, -1.70000005, 0, 0, 1, 1, 0, 0, 0, 1, 0) * CFrame.fromEulerAnglesXYZ((math.pi/2),math.rad(15),0) * CFrame.new(-0.7,0,-0.1)
	cananimate = true
	if character:findFirstChild("BatBack") then
		character:findFirstChild("BatBack").Transparency = 1
	end
	handle.Transparency = 0
	equipsound:Play()
	local WHEN = 0
	coroutine.wrap(function()
		while runservice.Stepped:wait() and equipped do
			if cananimate then
				if WHEN < 40 then
					WHEN = WHEN + 1
				elseif WHEN == 40 then
					WHEN = 41
					grip.Part1 = handle
					canattack = true
					weldd:destroy()
				end
				tool.Grip = tool.Grip:lerp(CFrame.new(0, 0, -1.70000005, 0, 0, 1, 1, 0, 0, 0, 1, 0),0.1)
				head.C0 = head.C0:lerp(CFrame.new(0,1.5,0),0.1)
				humanoidrootpart.C0 = humanoidrootpart.C0:lerp(CFrame.new(),0.1)
				leftarm.C0 = leftarm.C0:lerp(CFrame.new(-1.4,0.5,0) * CFrame.fromEulerAnglesXYZ((math.pi/2)-math.rad(50)+math.sin(tick())/15,0,math.rad(50)) * CFrame.new(0,-0.8,0),0.1)
				rightarm.C0 = rightarm.C0:lerp(CFrame.new(1.5,0.5,0) * CFrame.fromEulerAnglesXYZ((math.pi/2)-math.rad(35)+math.sin(tick())/15,math.rad(20),math.rad(-40)) * CFrame.new(0,-0.8,0),0.1)
			end
		end
	end)()
end)
tool.Unequipped:connect(function()
	equipped = false
	mouseclick = false
	cananimate = false
	if character.Torso:findFirstChild("LeftArmWeldbat") then
		character.Torso:findFirstChild("LeftArmWeldbat"):destroy()
	end
	if character.Torso:findFirstChild("RightArmWeldbat") then
		character.Torso:findFirstChild("RightArmWeldbat"):destroy()
	end
	if character.Torso:findFirstChild("HeadWeldbat") then
		character.Torso:findFirstChild("HeadWeldbat"):destroy()
	end
	if character:findFirstChild("HumanoidRootPart") then
		if character.HumanoidRootPart:findFirstChild("HumanoidRootPartWeldbat") then
			character.HumanoidRootPart:findFirstChild("HumanoidRootPartWeldbat"):destroy()
		end
	end
	if not character:findFirstChild("BatBack") then
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
		weld.C0 = CFrame.new(0,0,0.55)
		weld.C0 = weld.C0 * CFrame.fromEulerAnglesXYZ(0,math.pi/2,math.pi/2)
		weld.C0 = weld.C0 * CFrame.fromEulerAnglesXYZ(math.pi,math.rad(60)+math.pi,0)
		clone.Parent = character
		clone.Name = "BatBack"
	else
		character:findFirstChild("BatBack").Transparency = 0
	end
	handle.Transparency = 1
	character.BatBack:findFirstChildOfClass("SpecialMesh").TextureId = handle:findFirstChildOfClass("SpecialMesh").TextureId
end)