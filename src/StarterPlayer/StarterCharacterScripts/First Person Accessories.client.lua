local Player = game.Players.LocalPlayer
local character = Player.Character
local cam = game.Workspace.CurrentCamera
local ts = require(game.ReplicatedStorage.TService)
local UserInputService = game:GetService("UserInputService")
local equip = false
local mouse = game.Players.LocalPlayer:GetMouse()

game:GetService("RunService").RenderStepped:connect(function()
	
	character.ChildAdded:Connect(function(tool)
		if tool:IsA("Tool") and tool:FindFirstChild("ACS_Modulo") ~= nil then
			equip = true
		end
	end)
	
	character.ChildRemoved:Connect(function(tool)
		if tool:IsA("Tool") then
			equip = false
		end
	end)	
	
	if (cam.Focus.p-cam.CoordinateFrame.p).magnitude < 0.8 then			
		
		if (character:FindFirstChild("Right Leg") and character:FindFirstChild("Left Leg") and character:FindFirstChild("Torso")) then
			character:FindFirstChild("Right Leg").LocalTransparencyModifier = 0
			character:FindFirstChild("Left Leg").LocalTransparencyModifier = 0
			-- character:FindFirstChild("Torso").LocalTransparencyModifier = 0
			if not equip and (character:FindFirstChild("Right Leg") and character:FindFirstChild("Left Leg") and character:FindFirstChild("Torso")) then
				character:FindFirstChild("Right Arm").LocalTransparencyModifier = 0
				character:FindFirstChild("Left Arm").LocalTransparencyModifier = 0
			elseif equip and (character:FindFirstChild("Right Leg") and character:FindFirstChild("Left Leg") and character:FindFirstChild("Torso")) then
				character:FindFirstChild("Right Arm").LocalTransparencyModifier = 1
				character:FindFirstChild("Left Arm").LocalTransparencyModifier = 1	
			end
			
			for _,v in pairs(character:GetDescendants()) do
				if v:IsA('Model') and (v.Name == "Rig" or v.Name == "Chest" --[[or v:FindFirstChild("Visor") ~= nil and v:FindFirstChild("Visor").Transparency > 0]]) then
						for _,v in pairs(v:GetDescendants()) do
							if v:IsA('MeshPart') or v:IsA('Part') or v:IsA('UnionOperation') then
								v.LocalTransparencyModifier = 0
								for _,v in pairs(v:GetDescendants()) do
									if v:IsA('Texture') or v:IsA('Decal') then	
										v.LocalTransparencyModifier = 0
								end
							end
						end
					end
				end
			end
			
		elseif (character:WaitForChild("Right Leg") or character:WaitForChild("Left Leg")) then
			(character:WaitForChildChild("Right Leg") --[[or character:WaitForChild("Torso")]] or character:WaitForChild("Left Leg")).LocalTransparencyModifier = 0
		end
		--	else
		--	character:FindFirstChild("Humanoid").CameraOffset = Vector3.new(nil,nil,0)	
	end
end)