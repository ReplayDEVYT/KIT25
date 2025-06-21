while true do
	script.Parent.Light.Enabled = true
	script.Parent.Neon.Color = Color3.fromRGB(255,0,0)
	wait(0.15)
	script.Parent.Light.Enabled = false
	script.Parent.Neon.Color = Color3.fromRGB(0,0,0)
	wait(0.15)
end