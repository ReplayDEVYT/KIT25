

game:GetService('UserInputService').MouseIconEnabled = true

if _G.All then
	for _,v in pairs(_G.All:GetDescendants()) do
		if v:IsA('BasePart') then
			v.LocalTransparencyModifier = 0
		end
	end
end

_G.All = nil

script.Parent.OnClientEvent:Connect(function(char)
	_G.All = char
	local head = char:WaitForChild('Head')
	repeat game:GetService('RunService').RenderStepped:Wait()
		workspace.CurrentCamera.CFrame = head.CFrame*CFrame.new(0,0,-.4)
		game:GetService('UserInputService').MouseIconEnabled = false
		for _,v in pairs(char:GetDescendants()) do
			if v:IsA('BasePart') and v.Name == 'Handle' and v:FindFirstChild('AccessoryWeld') then
				if v.AccessoryWeld.Part1 == head then
					v.LocalTransparencyModifier = 1
				end
			end
		end
	until
		false
end)