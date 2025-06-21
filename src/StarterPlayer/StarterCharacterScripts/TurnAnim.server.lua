local Character = script.Parent
local HRT = Character:WaitForChild("HumanoidRootPart")
local Run = game:GetService("RunService")
local PreviousValue = HRT.CFrame
local MaxAngle = 45
local deb = false

local selected
local soundsFolder = script.Sounds
local gearsoundsFolder = script.GearSounds

Run.Heartbeat:Connect(function(time, deltatime)
	local mat = Character.Humanoid.FloorMaterial
	local Angle = math.deg(math.acos(HRT.CFrame.LookVector:Dot(PreviousValue.LookVector)))
	if Angle >= MaxAngle and Character.Humanoid.MoveDirection == Vector3.zero and not deb then
		if mat ~= Enum.Material.Air then
			PreviousValue = HRT.CFrame
			
			deb = true
			print("turn")
			
			
			if soundsFolder:FindFirstChild(mat.Name) then
				selected = soundsFolder[mat.Name]:GetChildren()
			else
				selected = soundsFolder.Default:GetChildren()
			end
			
			local s = selected[math.random(#selected)]
			
			s = s:Clone()
			s.Parent = Character["Left Leg"]
			s:Play()
			
			s.Ended:Wait()
			
			s:Destroy()
			s = nil
			
			task.delay(0.4, function()
				deb = false
			end)
		end
	end
end)

Character.Humanoid.Running:Connect(function(speed: number)
	if speed > 0 then
		PreviousValue = HRT.CFrame
	end
end)