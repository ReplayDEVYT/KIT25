local frame = script.Parent.Compass
local hotkey = Enum.KeyCode.Semicolon
local UIS = game:GetService("UserInputService")
local open = false
local sound1 = script.Parent.On1
local sound2 = script.Parent.Off1

UIS.InputBegan:Connect(function(key, gp)
	if key.KeyCode == hotkey then
		if open == false then
			open = true
			frame.Visible = open
			sound1:Play()
		elseif open == true then
			open = false
			frame.Visible = open
			sound2:Play()
		end
	end
end)