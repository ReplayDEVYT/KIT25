--By Rufus14
canattack = true
cananimate = false
equipped = false
tool = script.Parent
handle = tool.Handle
equipsound = handle.Equip
swishsound = handle.Swoosh
blocksound = handle.Clang
stabsound = handle.Stab
owner = nil
character = nil
mouseclick = false
attacknumber = 1
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
function damage()
	for i,v in pairs(workspace:GetDescendants()) do
		if v.ClassName == "Model" then
			local head = v:findFirstChild("Head")
			local humanoid = v:findFirstChildOfClass("Humanoid")
			local torso = v:findFirstChild("Torso")
			local ragdolled = v:findFirstChild("ragdolledknife")
			if humanoid and head and not ragdolled then
				if (head.Position - handle.Position).magnitude < 2.5 and v ~= character and humanoid.Health > 0 then
					stabsound.PlaybackSpeed = 1+(math.random(-4,4)/20)
					stabsound:Play()
					local dmg = math.random(45,70)
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
function swooshh()
	if owner ~= nil and character ~= nil and canattack then
		cananimate = false
		canattack = false
		local rightarmweld = character.Torso:findFirstChild("RightArmWeldkata")
		local leftarmweld = character.Torso:findFirstChild("LeftArmWeldkata")
		local headweld = character.Torso:findFirstChild("HeadWeldkata")
		local rootweld = character.HumanoidRootPart:findFirstChild("HumanoidRootPartWeldkata")
		if attacknumber == 1 then
			for i = 0,1 , 0.15 do
				tool.Grip = tool.Grip * CFrame.fromEulerAnglesXYZ(math.rad(-5),0,0)
				headweld.C0 = headweld.C0:lerp(CFrame.new(0, 1.5, 0, 0.866025388, 0, 0.5, 0, 1, 0, -0.5, 0, 0.866025388),i)
				rightarmweld.C0 = rightarmweld.C0:lerp(CFrame.new(1.64085674, 0.312389612, -0.122621536, 0.939692497, -0.342020065, 0, -0.29619807, -0.813797593, -0.5, 0.171010077, 0.469846338, -0.866025388),i)
				leftarmweld.C0 = leftarmweld.C0:lerp(CFrame.new(1.02380371, 0.612811089, -0.671613693, 0.440969527, -0.84082067, 0.313952357, -0.813797534, -0.522099257, -0.255236179, 0.378522247, -0.14294228, -0.914487958),i)
				rootweld.C0 = rootweld.C0:lerp(CFrame.new(0, 0, 0, 0.866025388, 0, -0.5, 0, 1, 0, 0.5, 0, 0.866025388) * CFrame.fromEulerAnglesXYZ(math.rad(10),0,0),i)
				runservice.Stepped:wait()
			end
			trail.Enabled = true
			swishsound.PlaybackSpeed = 1+(math.random(-4,4)/20)
			swishsound:Play()
			for i = 0,1 , 0.15 do
				damage()
				tool.Grip = tool.Grip * CFrame.fromEulerAnglesXYZ(math.rad(15),0,0)
				headweld.C0 = headweld.C0:lerp(CFrame.new(0, 1.5, 0, 0.766044259, 0, -0.642787516, 0, 1, 0, 0.642787516, 0, 0.766044259),i)
				rightarmweld.C0 = rightarmweld.C0:lerp(CFrame.new(0.683202744, -0.20174861, -0.846788406, 0.485379666, 0.55736959, -0.673606277, -0.785861969, 0.615793824, -0.056734439, 0.383180559, 0.556899309, 0.736909389),i)
				leftarmweld.C0 = leftarmweld.C0:lerp(CFrame.new(-0.429347992, -0.274533272, -0.938881874, -0.164195985, -0.2279284, -0.959733248, -0.713444591, 0.699326932, -0.0440245233, 0.681201816, 0.677488148, -0.277441025),i)
				rootweld.C0 = rootweld.C0:lerp(CFrame.new(0, 0, 0, 0.766044378, 0, 0.642787576, 0, 1, 0, -0.642787576, 0, 0.766044378) * CFrame.fromEulerAnglesXYZ(-math.rad(10),math.rad(20),0),i)
				runservice.Stepped:wait()
			end
			trail.Enabled = false
			attacknumber = 2
		elseif attacknumber == 2 then
			for i = 0,1 , 0.15 do
				tool.Grip = tool.Grip * CFrame.fromEulerAnglesXYZ(math.rad(-5),0,0)
				headweld.C0 = headweld.C0:lerp(CFrame.new(0.0751914978, 1.49240375, -0.0434103012, 0.640502989, 0.150383756, -0.753087461, -0.0301536862, 0.98480773, 0.171010047, 0.767363608, -0.0868240893, 0.635306776),i)
				rightarmweld.C0 = rightarmweld.C0:lerp(CFrame.new(-0.66223526, 0.676017523, -1.025383, 0.49999997, 0.866025388, -2.98023224e-08, 0.749999762, -0.433012694, -0.5, -0.433012754, 0.25000006, -0.866025448),i)
				leftarmweld.C0 = leftarmweld.C0:lerp(CFrame.new(-1.26498032, 0.448050499, -0.739653587, 0.939692616, 0.342020124, 0, 0.262002617, -0.719846368, -0.642787337, -0.219846219, 0.604022563, -0.766044617),i)
				rootweld.C0 = rootweld.C0:lerp(CFrame.new(0, 0, 0, 0.642787635, 0, 0.766044438, 0.133022219, 0.98480773, -0.111618899, -0.754406512, 0.173648179, 0.633022249),i)
				runservice.Stepped:wait()
			end
			trail.Enabled = true
			swishsound.PlaybackSpeed = 1+(math.random(-4,4)/20)
			swishsound:Play()
			for i = 0,1 , 0.15 do
				damage()
				tool.Grip = tool.Grip * CFrame.fromEulerAnglesXYZ(math.rad(15),0,0)
				headweld.C0 = headweld.C0:lerp(CFrame.new(0.0641422272, 1.48955965, 0.0788440704, 0.767760158, 0.128285766, 0.627763689, 0.00259800092, 0.979120135, -0.203264251, -0.640731931, 0.15768908, 0.751396239),i)
				rightarmweld.C0 = rightarmweld.C0:lerp(CFrame.new(1.37565041, -0.222093105, -0.689687729, 0.5, -0.296198189, 0.813797593, 0.749999642, 0.617945373, -0.235888779, -0.433012664, 0.728292406, 0.531121194),i)
				leftarmweld.C0 = leftarmweld.C0:lerp(CFrame.new(0.835933685, -0.400773525, -1.04433632, 0.649519086, -0.755761325, 0.083365947, 0.557579219, 0.39889279, -0.72800374, 0.516942859, 0.519335449, 0.680485249),i)
				rootweld.C0 = rootweld.C0:lerp(CFrame.new(0, 0, 0, 0.773788929, 0.0871748775, -0.627416253, 0.0624999851, 0.975144863, 0.212570071, 0.630352676, -0.20369792, 0.749107838),i)
				runservice.Stepped:wait()
			end
			trail.Enabled = false
			attacknumber = 3
		elseif attacknumber == 3 then
			trail.Enabled = true
			local rota = 0
			tool.Grip = CFrame.new(0, 0, -1.70000005, 0, 0, 1, 1, 0, 0, 0, 1, 0) * CFrame.fromEulerAnglesXYZ(math.rad(85),0,math.pi/2)
			swishsound:Play()
			for i = 1,25 do
				damage()
				if i == 10 or i == 20 then
					swishsound.PlaybackSpeed = 1+(math.random(-4,4)/20)
					swishsound:Play()
				end
				rota = rota + 1
				headweld.C0 = CFrame.new(0,1.5,0)
				rightarmweld.C0 = CFrame.new(-0.694223404, 0.5, -1.11978149, 2.98023188e-08, 0.99999994, 0, -1.19248798e-08, -4.44089183e-16, -0.99999994, -0.99999994, 2.98023188e-08, 1.19248806e-08)
				leftarmweld.C0 = CFrame.new(-1.57922745, 0.5, -0.405579567, 0.984807611, 0.173648179, 0, 7.59040208e-09, -4.30473079e-08, -0.99999994, -0.173648208, 0.98480773, -4.37113883e-08)
				rootweld.C0 = CFrame.new() * CFrame.fromEulerAnglesXYZ(0,-math.rad(rota*30),0)
				runservice.Stepped:wait()
			end
			trail.Enabled = false
			attacknumber = 1
		end
		if mouseclick then
			coroutine.wrap(function()
				local humhp = character:findFirstChildOfClass("Humanoid").Health
				local canblockanim = true
				while runservice.Stepped:wait() and mouseclick do
					if character:findFirstChildOfClass("Humanoid").Health < humhp then
						local thedamage = humhp - character:findFirstChildOfClass("Humanoid").Health
						character:findFirstChildOfClass("Humanoid").Health = character:findFirstChildOfClass("Humanoid").Health + thedamage/1.3
						blocksound.PlaybackSpeed = 1+(math.random(-4,4)/20)
						blocksound.TimePosition = 0.05
						blocksound:Play()
						if canblockanim then
							canblockanim = false
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
							end
							character:findFirstChildOfClass("Humanoid").PlatformStand = false
							local velocity = Instance.new("BodyVelocity", character.Head)
							velocity.MaxForce = Vector3.new(math.huge,0,math.huge)
							velocity.Velocity = character.Head.CFrame.lookVector * -math.random(10,25)
							game.Debris:AddItem(velocity, 0.2)
							coroutine.wrap(function()
								wait(0.2)
								canblockanim = true
							end)()
						end
					end
					rootweld.C0 = rootweld.C0:lerp(CFrame.new(),0.3)
					headweld.C0 = headweld.C0:lerp(CFrame.new(0,1.5,0),0.3)
					rightarmweld.C0 = rightarmweld.C0:lerp(CFrame.new(1.5,0.5,0) * CFrame.fromEulerAnglesXYZ(math.pi-math.rad(40),0,0) * CFrame.new(0,-0.5,0),0.3) 
					leftarmweld.C0 = leftarmweld.C0:lerp(CFrame.new(-1.5,0.5,0) * CFrame.fromEulerAnglesXYZ((math.pi/2)-math.rad(10),0,0) * CFrame.new(0,-0.5,0),0.3) 
					tool.Grip = tool.Grip:lerp(CFrame.new(0, 0, -1.70000005, 0, 0, 1, 1, 0, 0, 0, 1, 0) * CFrame.fromEulerAnglesXYZ((math.pi/2),(-math.pi/2)-math.rad(15),math.rad(-25)),0.3)
					humhp = character:findFirstChildOfClass("Humanoid").Health
				end
				cananimate = true
				canattack = true
			end)()
		else
			cananimate = true
			canattack = true
		end
	end
end
tool.Activated:connect(swooshh)
--
tool.Equipped:connect(function()
	equipped = true
	trail.Enabled = false
	handle.Transparency = 1
	owner = game:GetService("Players"):GetPlayerFromCharacter(tool.Parent)
	character = owner.Character
	local rightarm = Instance.new("Weld", character.Torso)
	rightarm.Part0 = character.Torso
	rightarm.Part1 = character["Right Arm"]
	rightarm.C0 = CFrame.new(1.5,0,0)
	rightarm.Name = "RightArmWeldkata"
	local leftarm = Instance.new("Weld", character.Torso)
	leftarm.Part0 = character.Torso
	leftarm.Part1 = character["Left Arm"]
	leftarm.C0 = CFrame.new(-1.5,0,0)
	leftarm.Name = "LeftArmWeldkata"
	local head = Instance.new("Weld", character.Torso)
	head.Part0 = character.Torso
	head.Part1 = character.Head
	head.C0 = CFrame.new(0,1.5,0)
	head.Name = "HeadWeldkata"
	local humanoidrootpart = Instance.new("Weld", character.HumanoidRootPart)
	humanoidrootpart.Part0 = character.HumanoidRootPart
	humanoidrootpart.Part1 = character.Torso
	humanoidrootpart.Name = "HumanoidRootPartWeldkata"
	for i = 0,1 , 0.05 do
		humanoidrootpart.C0 = humanoidrootpart.C0:lerp(CFrame.fromEulerAnglesXYZ(0,math.rad(-25),0),i)
		leftarm.C0 = leftarm.C0:lerp(CFrame.new(-1.5,0.5,0) * CFrame.fromEulerAnglesXYZ(0,0,math.rad(-10)) * CFrame.new(0,-0.5,0),i)
		rightarm.C0 = rightarm.C0:lerp(CFrame.new(1.5,0.5,0) * CFrame.fromEulerAnglesXYZ(math.pi+math.rad(10),math.rad(75),0) * CFrame.new(0,-0.5,0),i)
		runservice.Stepped:wait()
	end
	cananimate = true
	if character:findFirstChild("KatanaBack") then
		character:findFirstChild("KatanaBack").Transparency = 1
	end
	handle.Transparency = 0
	equipsound:Play()
	coroutine.wrap(function()
		while runservice.Stepped:wait() and equipped do
			if cananimate then
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
	if character.Torso:findFirstChild("LeftArmWeldkata") then
		character.Torso:findFirstChild("LeftArmWeldkata"):destroy()
	end
	if character.Torso:findFirstChild("RightArmWeldkata") then
		character.Torso:findFirstChild("RightArmWeldkata"):destroy()
	end
	if character.Torso:findFirstChild("HeadWeldkata") then
		character.Torso:findFirstChild("HeadWeldkata"):destroy()
	end
	if character:findFirstChild("HumanoidRootPart") then
		if character.HumanoidRootPart:findFirstChild("HumanoidRootPartWeldkata") then
			character.HumanoidRootPart:findFirstChild("HumanoidRootPartWeldkata"):destroy()
		end
	end
	if not character:findFirstChild("KatanaBack") then
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
		weld.C0 = weld.C0 * CFrame.fromEulerAnglesXYZ(math.pi,math.rad(-60),0)
		clone.Parent = character
		clone.Name = "KatanaBack"
	else
		character:findFirstChild("KatanaBack").Transparency = 0
	end
	handle.Transparency = 1
	character.KatanaBack:findFirstChildOfClass("SpecialMesh").TextureId = handle:findFirstChildOfClass("SpecialMesh").TextureId
end)
