--By Rufus14
canattack = true
cananimate = false
equipped = false
tool = script.Parent
swishsound = script.Swoosh
blocksound = script.Block
punchsound = script.Punch
kicksound = script.Kick
goresound = script.Ouch
basssound = script.Bass
owner = nil
character = nil
mouseclick = false
attacknumber = 1
instancewhitelist = {}
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
function damage(what, action, t, range)
	for i,v in pairs(workspace:GetDescendants()) do
		if v.ClassName == "Model" then
			local head = v:findFirstChild("Head")
			local humanoid = v:findFirstChildOfClass("Humanoid")
			local torso = v:findFirstChild("Torso")
			local ragdolled = v:findFirstChild("ragdolledpunch")
			if humanoid and head then
				if (head.Position - what.Position).magnitude < range and v ~= character and humanoid.Health > 0 then
					if action ~= "stomp" then
						if ragdolled then
							return
						end
					end
					local ragdolledpunch = Instance.new("BoolValue", v)
					ragdolledpunch.Name = "ragdolledpunch"
					game.Debris:AddItem(ragdolledpunch, t)
					if action == "punch" then
						local velocity = Instance.new("BodyVelocity", head)
						velocity.MaxForce = Vector3.new(math.huge,0,math.huge)
						velocity.Velocity = character.HumanoidRootPart.CFrame.lookVector * math.random(5,15)
						punchsound.PlaybackSpeed = 1+(math.random(-5,5)/15)
						punchsound:Play()
						game.Debris:AddItem(velocity, 0.2)
					elseif action == "uppercut" then
						local velocity = Instance.new("BodyVelocity", head)
						velocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
						velocity.Velocity = (character.HumanoidRootPart.CFrame.upVector * math.random(5,15)) + (character.HumanoidRootPart.CFrame.lookVector * math.random(5,15))
						kicksound.PlaybackSpeed = 1+(math.random(-5,5)/15)
						kicksound:Play()
						game.Debris:AddItem(velocity, 0.2)
					elseif action == "kick" then
						local velocity = Instance.new("BodyVelocity", head)
						velocity.MaxForce = Vector3.new(math.huge,0,math.huge)
						velocity.Velocity = character.HumanoidRootPart.CFrame.lookVector * 20
						goresound.PlaybackSpeed = 1+(math.random(-5,5)/15)
						goresound:Play()
						game.Debris:AddItem(velocity, 0.2)
					elseif action == "dropkick" then
						local velocity = Instance.new("BodyVelocity", head)
						velocity.MaxForce = Vector3.new(math.huge,0,math.huge)
						velocity.Velocity = character.HumanoidRootPart.CFrame.lookVector * 30
						kicksound.PlaybackSpeed = 1+(math.random(-5,5)/15)
						kicksound:Play()
						goresound.PlaybackSpeed = 1+(math.random(-5,5)/15)
						goresound:Play()
						game.Debris:AddItem(velocity, 0.2)
					elseif action == "stomp" then
						punchsound.PlaybackSpeed = 1+(math.random(-5,5)/15)
						punchsound:Play()
					end
					if action ~= "blocked" then
						local dmg = math.random(30,50)
						if action == "uppercut" then
							dmg = dmg + math.random(20,30)
						elseif action == "kick" then
							dmg = dmg + math.random(40,50)
						elseif action == "dropkick" then
							dmg = dmg + math.random(50,90)
						end
						if humanoid.Health <= dmg then
							humanoid.Health = 0
							ragdollkill(v)
						end
						humanoid.Health = humanoid.Health - dmg
					end
					if action ~= "blocked" and action ~= "uppercut" and action ~= "kick" and action ~= "dropkick" then
						if math.random(1,5) ~= 1 then
							return
						end
					end
					if action == "stomp" then
						return
					end
					humanoid.PlatformStand = true
					coroutine.wrap(function()
						wait(t)
						humanoid.PlatformStand = false
					end)()
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
--
tool.Activated:connect(function()
	if owner ~= nil and character ~= nil and canattack then
		local rightarmweld = character.Torso:findFirstChild("RightArmWeldpunch")
		local leftarmweld = character.Torso:findFirstChild("LeftArmWeldpunch")
		local headweld = character.Torso:findFirstChild("HeadWeldpunch")
		local rootweld = character.HumanoidRootPart:findFirstChild("HumanoidRootPartWeldpunch")
		for i,v in pairs(workspace:GetDescendants()) do
			if v.ClassName == "Model" and v ~= character then
				local humanoid = v:findFirstChildOfClass("Humanoid")
				local headepic = v:findFirstChild("Head")
				if humanoid and headepic then
					if (headepic.Position - character.HumanoidRootPart.Position).magnitude < 5 and humanoid.PlatformStand and humanoid.Health > 0 then
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
						for i = 0,1 , 0.1 do
							cananimate = false
							canattack = false
							character.HumanoidRootPart.CFrame = CFrame.new(character.HumanoidRootPart.Position, Vector3.new(headepic.Position.x,character.HumanoidRootPart.Position.y,headepic.Position.z))
							rightlegweld.C0 = rightlegweld.C0:lerp(CFrame.new(0.5, -0.75804615, -1.03058243, 1, 0, 0, 0, 1, 5.96046448e-08, 0, -5.96046448e-08, 1),i)
							leftlegweld.C0 = leftlegweld.C0:lerp(CFrame.new(-0.5, -1.93969202, 0.342020512, 1, 0, 0, 0, 0.939692557, 0.342020333, 0, -0.342020392, 0.939692557),i)
							rightarmweld.C0 = rightarmweld.C0:lerp(CFrame.new(1.5,0,0),i)
							leftarmweld.C0 = leftarmweld.C0:lerp(CFrame.new(-1.5,0,0),i)
							rootweld.C0 = rootweld.C0:lerp(CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.939692557, -0.342020363, 0, 0.342020363, 0.939692557),i)
							headweld.C0 = headweld.C0:lerp(CFrame.new(0, 1.38302135, -0.32139349, 1, 0, 0, 0, 0.766044259, 0.642787755, 0, -0.642787755, 0.766044259),i)
							runservice.Stepped:wait()
						end
						for i = 0,1 , 0.15 do
							rightlegweld.C0 = rightlegweld.C0:lerp(CFrame.new(0.5, -1.93246841, -1.17564046, 1, 0, 0, 0, 0.939692557, -0.342019618, 0, 0.342019647, 0.939692676),i)
							leftlegweld.C0 = leftlegweld.C0:lerp(CFrame.new(-0.5, -1.98480701, 0.173648238, 1, 0, 0, 0, 0.984807491, 0.173648387, 0, -0.173648402, 0.984807551),i)
							rightarmweld.C0 = rightarmweld.C0:lerp(CFrame.new(1.64085674, 0.201163769, -2.38418579e-07, 0.939692616, -0.342020124, 0, 0.342020094, 0.939692497, 0, 0, 0, 0.99999994),i)
							leftarmweld.C0 = leftarmweld.C0:lerp(CFrame.new(-1.64085674, 0.201163769, -2.38418579e-07, 0.939692616, 0.342020124, 0, -0.342020094, 0.939692497, 0, 0, 0, 0.99999994),i)
							rootweld.C0 = rootweld.C0:lerp(CFrame.new(0, -0.0347294807, -0.396961689, 1, 0, 0, 0, 0.98480773, 0.173648179, 0, -0.173648179, 0.98480773),i)
							headweld.C0 = headweld.C0:lerp(CFrame.new(0, 1.38302231, -0.321393967, 1, 0, 0, 0, 0.766044259, 0.642787695, 0, -0.642787695, 0.766044259),i)
							runservice.Stepped:wait()
						end
						damage(character["Right Leg"], "stomp", 1, 3.5)
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
						cananimate = true
						canattack = true
						return
					end
				end
			end
		end
		if character:findFirstChildOfClass("Humanoid").Jump then
			canattack = false
			cananimate = false
			character:findFirstChildOfClass("Humanoid").PlatformStand = true
			local rightlegweld = Instance.new("Weld", character.Torso)
			rightlegweld.Part0 = character.Torso
			rightlegweld.Part1 = character["Right Leg"]
			rightlegweld.C0 = CFrame.new(0.5,-2,0)
			rightlegweld.Name = "RightLegWeldpunch"
			local leftlegweld = Instance.new("Weld", character.Torso)
			leftlegweld.Part0 = character.Torso
			leftlegweld.Part1 = character["Left Leg"]
			leftlegweld.C0 = CFrame.new(-0.5,-2,0)
			leftlegweld.Name = "LeftLegWeldpunch"
			local vel = Instance.new("BodyVelocity", character.HumanoidRootPart)
			vel.MaxForce = Vector3.new(math.huge,600,math.huge)
			vel.Velocity = character.HumanoidRootPart.CFrame.lookVector * 20
			for i = 0,1 , 0.13 do
				damage(character["Left Leg"], "dropkick", 3.5, 3)
				damage(character["Right Leg"], "dropkick", 3.5, 3)
				rightlegweld.C0 = rightlegweld.C0:lerp(CFrame.new(0.5, -1, -0.400000095, 0.999999881, 0, 0, 0, 0.999999881, 0, 0, -1.49011612e-08, 0.99999994),i)
				leftlegweld.C0 = leftlegweld.C0:lerp(CFrame.new(-0.5, -1, -0.400000095, 0.999999881, 0, 0, 0, 0.999999881, 0, 0, -1.49011612e-08, 0.99999994),i)
				rightarmweld.C0 = rightarmweld.C0:lerp(CFrame.new(1.64085579, 0.201163769, 0, 0.939692438, -0.342020065, 0, 0.342020094, 0.939692438, 0, 0, 0, 0.99999994),i)
				leftarmweld.C0 = leftarmweld.C0:lerp(CFrame.new(-1.64085579, 0.201163769, 0, 0.939692438, 0.342020065, 0, -0.342020094, 0.939692438, 0, 0, 0, 0.99999994),i)
				rootweld.C0 = rootweld.C0:lerp(CFrame.fromEulerAnglesXYZ(math.pi/2,0,0),i)
				headweld.C0 = headweld.C0:lerp(CFrame.new(0, 1.24999976, -0.433012486, 0.999999881, 0, 0, 0, 0.5, 0.866025448, 0, -0.866025448, 0.5),i)
				runservice.Stepped:wait()
			end
			swishsound.PlaybackSpeed = 1+(math.random(-2,5)/12)
			swishsound:Play()
			for i = 0,1 , 0.13 do
				damage(character["Left Leg"], "dropkick", 3.5, 3)
				damage(character["Right Leg"], "dropkick", 3.5, 3)
				rightlegweld.C0 = rightlegweld.C0:lerp(CFrame.new(0.5, -2, 0, 1, 0, 0, 0, 0.999999881, 0, 0, 1.49011612e-08, 0.99999994),i)
				leftlegweld.C0 = leftlegweld.C0:lerp(CFrame.new(-0.5, -2, 0, 1, 0, 0, 0, 0.999999881, 0, 0, 1.49011612e-08, 0.99999994),i)
				rightarmweld.C0 = rightarmweld.C0:lerp(CFrame.new(1.57922745, 0.094420433, 4.76837158e-07, 0.98480773, -0.173648179, 0, 0.173648149, 0.984807611, 0, -1.86264515e-09, 0, 0.99999994),i)
				leftarmweld.C0 = leftarmweld.C0:lerp(CFrame.new(-1.57922745, 0.094420433, 4.76837158e-07, 0.98480773, 0.173648179, 0, -0.173648149, 0.984807611, 0, 1.86264515e-09, 0, 0.99999994),i)
				rootweld.C0 = rootweld.C0:lerp(CFrame.fromEulerAnglesXYZ((math.pi/2)-math.rad(30),0,0),i)
				headweld.C0 = headweld.C0:lerp(CFrame.new(0, 1.32139361, -0.383021832, 1, 0, 0, 0, 0.642787635, 0.766044438, 0, -0.766044438, 0.642787635),i)
				runservice.Stepped:wait()
			end
			for i = 1,20 do
				damage(character["Left Leg"], "dropkick", 3.5, 3)
				damage(character["Right Leg"], "dropkick", 3.5, 3)
				runservice.Stepped:wait()
			end
			vel:destroy()
			rightlegweld:destroy()
			leftlegweld:destroy()
			coroutine.wrap(function()
				wait(0.8)
				character:findFirstChildOfClass("Humanoid").PlatformStand = false
			end)()
			canattack = true
			cananimate = true
		else
			canattack = false
			cananimate = false
			if attacknumber == 1 then
				local sine = 0
				local tiltval = 0
				for i = 1,20 do --17 and sine 3 
					sine = sine + 1
					damage(character["Right Arm"], "punch", 1, 2)
					headweld.C0 = headweld.C0:lerp(CFrame.new(0,1.5,0) * CFrame.fromEulerAnglesXYZ(0,math.sin(sine/3.25),0),0.3)
					leftarmweld.C0 = leftarmweld.C0:lerp(CFrame.new(-1.5,0.5,0) * CFrame.fromEulerAnglesXYZ(math.pi/2,0,-math.sin(sine/3.25)*2) * CFrame.new(0,-0.5,0),0.3)
					rightarmweld.C0 = rightarmweld.C0:lerp(CFrame.new(1.5,0.5,0) * CFrame.fromEulerAnglesXYZ(math.pi/2,0,(-math.sin(sine/3.25)*1.5)-math.rad(10)+(math.cos(sine/11.25))) * CFrame.new(0,-0.5,0),0.3) 
					if i == 3 then
						swishsound.PlaybackSpeed = 1+(math.random(-2,5)/12)
						swishsound:Play()
					end
					if i > 10 then
						if i < 17 then
							tiltval = tiltval + 0.048
						end
						rightarmweld.C0 = rightarmweld.C0 * CFrame.new(-tiltval/2,0,0) * CFrame.fromEulerAnglesXYZ(0,0,-tiltval)
					end
					rootweld.C0 = rootweld.C0:lerp(CFrame.fromEulerAnglesXYZ(math.sin(sine/3.25)/8,-math.sin(sine/3.25)*2.3,0), 0.3)
					runservice.Stepped:wait()
				end
				attacknumber = 2
			elseif attacknumber == 2 then
				local sine = 0
				local tiltval = 0
				for i = 1,20 do --17 and sine 3 
					sine = sine + 1
					damage(character["Left Arm"], "punch", 1, 2)
					headweld.C0 = headweld.C0:lerp(CFrame.new(0,1.5,0) * CFrame.fromEulerAnglesXYZ(0,-math.sin(sine/3.25),0),0.3)
					leftarmweld.C0 = leftarmweld.C0:lerp(CFrame.new(-1.5,0.5,0) * CFrame.fromEulerAnglesXYZ(math.pi/2,0,(math.sin(sine/3.25)*1.5)+math.rad(10)-(math.cos(sine/11.25))) * CFrame.new(0,-0.5,0),0.3)
					rightarmweld.C0 = rightarmweld.C0:lerp(CFrame.new(1.5,0.5,0) * CFrame.fromEulerAnglesXYZ(math.pi/2,0,math.sin(sine/3.25)*2) * CFrame.new(0,-0.5,0),0.3) 
					if i == 3 then
						swishsound.PlaybackSpeed = 1+(math.random(-2,5)/12)
						swishsound:Play()
					end
					if i > 10 then
						if i < 17 then
							tiltval = tiltval + 0.048
						end
						leftarmweld.C0 = leftarmweld.C0 * CFrame.new(tiltval/2,0,0) * CFrame.fromEulerAnglesXYZ(0,0,tiltval)
					end
					rootweld.C0 = rootweld.C0:lerp(CFrame.fromEulerAnglesXYZ(math.sin(sine/3.25)/8,math.sin(sine/3.25)*2.3,0), 0.3)
					runservice.Stepped:wait()
				end
				attacknumber = 3
			elseif attacknumber == 3 then
				for i = 0,1 , 0.06 do
					rightarmweld.C0 = rightarmweld.C0:lerp(CFrame.new(1.52833557, 0.510312557, 0.469846129, 0.939692497, -0.116977774, -0.321393788, 0.342020124, 0.321393818, 0.88302213, 1.49011612e-08, -0.939692616, 0.342020124),i)
					leftarmweld.C0 = leftarmweld.C0:lerp(CFrame.new(-1.64085674, 0.307911873, -0.228921652, 0.939692557, 0.342020094, 0, -0.219846308, 0.604022801, -0.766044378, -0.262002587, 0.719846249, 0.642787576),i)
					rootweld.C0 = rootweld.C0:lerp(CFrame.new(0, 0, 0, 0.98480773, 0, -0.173648179, 0.0593911819, 0.939692616, 0.336824119, 0.163175911, -0.342020184, 0.925416529),i)
					headweld.C0 = headweld.C0:lerp(CFrame.new(0, 1.49240446, 0.0868239403, 0.999999881, -1.86264515e-09, 0, 3.7252903e-09, 0.984807789, -0.17364797, 0, 0.17364794, 0.98480773),i)
					runservice.Stepped:wait()
				end
				swishsound.PlaybackSpeed = 1+(math.random(-2,5)/12)
				swishsound:Play()
				for i = 0.35,0.65 , 0.1 do
					rightarmweld.C0 = rightarmweld.C0:lerp(CFrame.new(1.64085674, 0.201164246, 2.38418579e-07, 0.939692497, -0.342020154, 2.7474016e-08, 0.342020005, 0.939692378, -8.94069672e-08, -1.49011612e-08, 1.1920929e-07, 0.999999762) * CFrame.fromEulerAnglesXYZ(0.2,0,0),i)
					leftarmweld.C0 = leftarmweld.C0:lerp(CFrame.new(-1.60084724, 0.132367611, 0.0618722439, 0.939692557, 0.262002587, 0.219846293, -0.219846219, 0.955111742, -0.198565692, -0.262002587, 0.138258308, 0.955111921),i)
					rootweld.C0 = rootweld.C0:lerp(CFrame.new(0.0180921555, -0.590343475, 0.105676413, 0.999541819, -0.0301466491, -0.00267778337, 0.0292237774, 0.938346207, 0.344459206, -0.0078715831, -0.344379693, 0.938797355),i)
					headweld.C0 = headweld.C0:lerp(CFrame.new(9.53674316e-07, 1.49240351, 0.0868239403, 0.999999881, 2.32830644e-09, 2.09547579e-08, -2.09547579e-09, 0.984807611, -0.173648, 2.14204192e-08, 0.173647881, 0.984807551),i)
					runservice.Stepped:wait()
				end
				for i = 0,1 , 0.1 do
					damage(character["Right Arm"], "uppercut", 1.5, 2)
					rightarmweld.C0 = rightarmweld.C0:lerp(CFrame.new(1.50000012, 1.00000048, -9.53674316e-07, 0.999999881, -1.1920929e-07, 9.12696123e-08, 1.1920929e-07, -0.999999702, -8.80099833e-08, -5.21540642e-08, 6.0768798e-08, -0.999999523),i)
					leftarmweld.C0 = leftarmweld.C0:lerp(CFrame.new(-1.68977165, 0.475360394, 0.153648376, 0.682796299, 0.696747243, 0.219846189, -0.667948365, 0.717228174, -0.198565692, -0.296030015, -0.0112660835, 0.955111802),i)
					rootweld.C0 = rootweld.C0:lerp(CFrame.new(0, 0, 0, 0.00488264859, 0.0593911037, 0.998222649, -0.184096873, 0.981225967, -0.0574793406, -0.98289597, -0.183489174, 0.0157247484),i)
					headweld.C0 = headweld.C0:lerp(CFrame.new(-0.0558092594, 1.49647284, 0.0200033188, 0.63302207, -0.11161878, -0.766044497, 0.0400089845, 0.992945373, -0.111618832, 0.773098826, 0.0400085226, 0.633021951),i)
					runservice.Stepped:wait()
				end
				attacknumber = 4
			elseif attacknumber == 4 then
				local rightlegweld = Instance.new("Weld", character.Torso)
				rightlegweld.Part0 = character.Torso
				rightlegweld.Part1 = character["Right Leg"]
				rightlegweld.C0 = CFrame.new(0.5,-2,0)
				rightlegweld.Name = "RightLegWeldpunch"
				local leftlegweld = Instance.new("Weld", character.Torso)
				leftlegweld.Part0 = character.Torso
				leftlegweld.Part1 = character["Left Leg"]
				leftlegweld.C0 = CFrame.new(-0.5,-2,0)
				leftlegweld.Name = "LeftLegWeldpunch"
				character:findFirstChildOfClass("Humanoid").WalkSpeed = character:findFirstChildOfClass("Humanoid").WalkSpeed - 10
				for i = 0,1 , 0.06 do
					rightlegweld.C0 = rightlegweld.C0:lerp(CFrame.new(0.500000954, -1.86602545, -0.499999046, 1, -1.49011665e-08, 2.98023224e-08, -2.98023224e-08, 0.866025329, -0.5, 2.98023224e-08, 0.5, 0.866025448),i)
					leftlegweld.C0 = leftlegweld.C0:lerp(CFrame.new(-0.5, -0.999999523, 1, 1, -2.98023224e-08, -4.47034836e-08, -2.98023224e-08, -5.96046448e-08, 0.999999881, 2.98023224e-08, -1, -1.78813934e-07),i)
					rightarmweld.C0 = rightarmweld.C0:lerp(CFrame.new(1.50000095, 0.250000477, 0.433013439, 1, -5.96046448e-08, -1.09083995e-08, -2.98023224e-08, 0.5, 0.866025388, 2.98023224e-08, -0.866025567, 0.49999997),i)
					leftarmweld.C0 = leftarmweld.C0:lerp(CFrame.new(-1.49999905, 0.75, -0.433012009, 1, 5.96046448e-08, 3.99276701e-09, -4.47034836e-08, -0.50000006, -0.866025388, 2.98023224e-08, 0.866025507, -0.50000006),i)
					rootweld.C0 = rootweld.C0:lerp(CFrame.new(0, 0, 0, 0.866025329, -0.250000119, 0.433012873, 0, 0.866025388, 0.5, -0.500000179, -0.433012664, 0.74999994),i)
					headweld.C0 = headweld.C0:lerp(CFrame.new(-0.0434112549, 1.49240398, 0.0751919746, 0.866025329, -0.0868241489, -0.492404073, -4.47034836e-08, 0.98480767, -0.173648179, 0.500000179, 0.150383696, 0.852868497),i)
					runservice.Stepped:wait()
				end
				swishsound.PlaybackSpeed = 1+(math.random(-3,5)/12)
				swishsound:Play()
				for i = 0,1 , 0.15 do
					damage(character["Left Leg"], "kick", 1.5, 3.5)
					rightlegweld.C0 = rightlegweld.C0:lerp(CFrame.new(0.5, -1.93969274, 0.342020035, 1.00000024, -2.98023224e-08, 0, -1.49011612e-08, 0.939692557, 0.342019916, 0, -0.342019945, 0.939692676),i)
					leftlegweld.C0 = leftlegweld.C0:lerp(CFrame.new(-0.500000477, -0.826352119, -0.984807968, 1.00000024, 2.98023224e-08, 1.49011612e-08, -1.49011612e-08, -0.173648193, -0.984807611, 0, 0.98480767, -0.173648223),i)
					rightarmweld.C0 = rightarmweld.C0:lerp(CFrame.new(1.50000095, 0.116978168, 0.321393967, 1.00000024, -1.49011612e-08, 2.98023224e-08, 2.98023224e-08, 0.766044378, 0.642787695, 0, -0.642787814, 0.766044557),i)
					leftarmweld.C0 = leftarmweld.C0:lerp(CFrame.new(-1.50000048, 0.116977692, 0.321393013, 1.00000024, -1.49011612e-08, 0, -1.49011612e-08, 0.766044438, 0.642787576, 0, -0.642787576, 0.766044497),i)
					rootweld.C0 = rootweld.C0:lerp(CFrame.new(0, 0, 0, 0.766044676, -0.111618795, -0.63302207, -1.68030141e-07, 0.98480773, -0.173648238, 0.642787516, 0.133022398, 0.754406631),i)
					headweld.C0 = headweld.C0:lerp(CFrame.new(-0.0525569916, 1.49498224, -0.0472278595, 0.663642108, -0.105113029, 0.74062866, -0.000909253955, 0.989964247, 0.141314477, -0.748049736, -0.0944556296, 0.656886339),i)
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
					character:findFirstChildOfClass("Humanoid").WalkSpeed = character:findFirstChildOfClass("Humanoid").WalkSpeed + 10
				end)()
				attacknumber = 1
			end
			if mouseclick then
				coroutine.wrap(function()
					local humhp = character:findFirstChildOfClass("Humanoid").Health
					while runservice.Stepped:wait() and mouseclick do
						cananimate = false
						if character:findFirstChildOfClass("Humanoid").Health < humhp then
							character:findFirstChildOfClass("Humanoid").PlatformStand = false
							character:findFirstChildOfClass("Humanoid").Health = character:findFirstChildOfClass("Humanoid").Health + (humhp-character:findFirstChildOfClass("Humanoid").Health)
							character:findFirstChildOfClass("Humanoid").WalkSpeed = 16
							basssound.TimePosition = 1.525
							blocksound:Play()
							basssound:Play()
							coroutine.wrap(function()
								local thehpp = character:findFirstChildOfClass("Humanoid").Health
								for i = 1,20 do
									character:findFirstChildOfClass("Humanoid").Health = thehpp
									runservice.Stepped:wait()
								end
							end)()
							local nearestdistance = math.huge
							local nearestplr = nil
							for i,v in pairs(workspace:GetDescendants()) do
								if v.ClassName == "Model" and v ~= character then
									local headdw = v:findFirstChild("Head")
									local humanoiddw = v:findFirstChildOfClass("Humanoid")
									if humanoiddw and headdw then
										if (headdw.Position - character.Head.Position).magnitude < 10 and (headdw.Position - character.Head.Position).magnitude < nearestdistance then
											nearestdistance = (headdw.Position - character.Head.Position).magnitude
											nearestplr = v
										end
									end
								end
							end
							if nearestplr ~= nil then
								character.Head.CFrame = CFrame.new(character.Head.Position, nearestplr.Head.Position)
								nearestplr.Head.CFrame = CFrame.new(nearestplr.Head.Position, character.Head.Position)
								local noon = Instance.new("BodyVelocity", nearestplr.Head)
								noon.MaxForce = Vector3.new(math.huge,0,math.huge)
								noon.Velocity = nearestplr.Head.CFrame.lookVector * -math.random(15,25)
								game.Debris:AddItem(noon, 0.2)
								damage(nearestplr.Head, "blocked", 3, 0.5)
							end
							local velocity = Instance.new("BodyVelocity", character.Head)
							velocity.MaxForce = Vector3.new(math.huge,0,math.huge)
							velocity.Velocity = character.Head.CFrame.lookVector * -math.random(10,15)
							game.Debris:AddItem(velocity, 0.2)
							break
						end
						rootweld.C0 = rootweld.C0:lerp(CFrame.new(0, 0, 0, 0.999663353, 0.0246764347, 0.00799234211, -0.0226141848, 0.980059326, -0.19741419, -0.0127044618, 0.197166979, 0.980287552) * CFrame.fromEulerAnglesXYZ(math.sin(tick())/20,0,0),0.3)
						leftarmweld.C0 = leftarmweld.C0:lerp(CFrame.new(-0.0263385773, 0.920211315, -1.15523124, 0.76604414, -0.642787278, 7.17118382e-08, -0.604022741, -0.719846249, -0.342020154, 0.219846427, 0.262002707, -0.939692557) * CFrame.new(0,math.cos(tick())/20,0),0.3)
						headweld.C0 = headweld.C0:lerp(CFrame.new(-9.53674316e-07, 1.49240446, -0.0868245959, 0.999999642, -1.33004505e-08, -1.58324838e-08, -1.51339918e-08, 0.98480773, 0.173648581, -1.3038516e-08, -0.1736487, 0.984807611) * CFrame.fromEulerAnglesXYZ(-math.sin(tick())/20,0,0),0.3)
						rightarmweld.C0 = rightarmweld.C0:lerp(CFrame.new(0.0363903046, 0.923784733, -1.1914165, 0.721851647, 0.684478879, -0.102069058, 0.613821924, -0.701371074, -0.362355202, -0.319613039, 0.198914632, -0.926434338) * CFrame.new(0,math.cos(tick())/20,0),0.3)
						humhp = character:findFirstChildOfClass("Humanoid").Health
					end
					cananimate = true
					canattack = true
				end)()
			else
				canattack = true
				cananimate = true
			end
		end
	end
end)
--
tool.Equipped:connect(function()
	equipped = true
	owner = game:GetService("Players"):GetPlayerFromCharacter(tool.Parent)
	character = owner.Character
	local rightarm = Instance.new("Weld", character.Torso)
	rightarm.Part0 = character.Torso
	rightarm.Part1 = character["Right Arm"]
	rightarm.C0 = CFrame.new(1.5,0,0)
	rightarm.Name = "RightArmWeldpunch"
	local leftarm = Instance.new("Weld", character.Torso)
	leftarm.Part0 = character.Torso
	leftarm.Part1 = character["Left Arm"]
	leftarm.C0 = CFrame.new(-1.5,0,0)
	leftarm.Name = "LeftArmWeldpunch"
	local head = Instance.new("Weld", character.Torso)
	head.Part0 = character.Torso
	head.Part1 = character.Head
	head.C0 = CFrame.new(0,1.5,0)
	head.Name = "HeadWeldpunch"
	local humanoidrootpart = Instance.new("Weld", character.HumanoidRootPart)
	humanoidrootpart.Part0 = character.HumanoidRootPart
	humanoidrootpart.Part1 = character.Torso
	humanoidrootpart.Name = "HumanoidRootPartWeldpunch"
	for i,v in pairs(script:GetChildren()) do
		if v.ClassName == "Sound" then
			v.Parent = character.HumanoidRootPart
		end
	end
	cananimate = true
	local savedchar = character
	local lasthp = character:findFirstChildOfClass("Humanoid").Health
	coroutine.wrap(function()
		local humhp = character:findFirstChildOfClass("Humanoid").Health
		while runservice.Stepped:wait() and equipped do
			if character:findFirstChildOfClass("Humanoid").Health < humhp then
				local thedamage = humhp - character:findFirstChildOfClass("Humanoid").Health
				character:findFirstChildOfClass("Humanoid").Health = character:findFirstChildOfClass("Humanoid").Health + thedamage/2.5
			end
			if cananimate then
				head.C0 = head.C0:lerp(CFrame.new(0,1.5,0),0.1)
				humanoidrootpart.C0 = humanoidrootpart.C0:lerp(CFrame.new(),0.2)
				leftarm.C0 = leftarm.C0:lerp(CFrame.new(-0.8,0.15,-0.5) * CFrame.fromEulerAnglesXYZ(math.pi-(math.rad(20)),0,math.rad(15)) * CFrame.new(0,-0.5,0),0.2)
				rightarm.C0 = rightarm.C0:lerp(CFrame.new(0.8,0.15,-0.5) * CFrame.fromEulerAnglesXYZ(math.pi-(math.rad(20)),0,math.rad(-15)) * CFrame.new(0,-0.5,0),0.2)
			end
			humhp = character:findFirstChildOfClass("Humanoid").Health
		end
	end)()
end)
tool.Unequipped:connect(function()
	equipped = false
	instancewhitelist = {}
	mouseclick = false
	cananimate = false
	for i,v in pairs(character.HumanoidRootPart:GetChildren()) do
		if v.ClassName == "Sound" then
			v.Parent = script
		end
	end
	if character.Torso:findFirstChild("LeftArmWeldpunch") then
		character.Torso:findFirstChild("LeftArmWeldpunch"):destroy()
	end
	if character.Torso:findFirstChild("RightArmWeldpunch") then
		character.Torso:findFirstChild("RightArmWeldpunch"):destroy()
	end
	if character.Torso:findFirstChild("HeadWeldpunch") then
		character.Torso:findFirstChild("HeadWeldpunch"):destroy()
	end
	if character:findFirstChild("HumanoidRootPart") then
		if character.HumanoidRootPart:findFirstChild("HumanoidRootPartWeldpunch") then
			character.HumanoidRootPart:findFirstChild("HumanoidRootPartWeldpunch"):destroy()
		end
	end
end)
