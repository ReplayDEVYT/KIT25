local frame = script.Parent.Map
local hotkey = Enum.KeyCode.Equals
local UIS = game:GetService("UserInputService")
local open = false
local sound1 = script.Parent.On2
local sound2 = script.Parent.Off2

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