local lighting = game:GetService("Lighting")
--local default = lighting.Technology
local toggle = false
local button = script.Parent
--lighting.Technology = default
button.MouseButton1Down:connect(function()
	toggle = not toggle
	if toggle == true then
		button.Text = "low"
		lighting.GlobalShadows = false
		--lighting.Technology = "ShadowMap"
	else
		button.Text = "high"
		lighting.GlobalShadows = true
		--lighting.Technology = "Future"
	end
end)