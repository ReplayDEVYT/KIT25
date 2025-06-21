local player = game.Players.LocalPlayer

local droplets = require(player.PlayerScripts.ScreenRain)

print("checking for rain")

if workspace.Weather.Raining.Value == true then
	print("it's raining")
	droplets:Enable()
end

workspace.Weather.Raining.Changed:Connect(function()
	if workspace.Weather.Raining.Value == true then
		print("it's raining")
		droplets:Enable()
	else
		print("it's not raining")
		droplets:Disable()
	end
end)