local sound = script.Parent.Parent["button press"]
local button = script.Parent.Parent.Parent.Button
local pressed = script.Parent.Parent.Parent.ButtonPressed

script.Parent.Triggered:Connect(function()
	sound:Play()
	button.Transparency = 1
	script.Enabled = false
	script.Parent.Enabled = false
	wait(0.5)
	button.Transparency = 0
	wait(1.5)
	script.Enabled = true
	script.Parent.Enabled = true
end)