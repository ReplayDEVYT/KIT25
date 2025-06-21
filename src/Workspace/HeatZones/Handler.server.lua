local Zone = require(game:GetService("ReplicatedStorage").Zone)
local container = script.Parent
local zone = Zone.new(container)

zone.playerEntered:Connect(function(player)
	print(("%s entered heat zone"):format(player.Name))
	player.Character.WeatherHandling.InHeatZone.Value = true
end)

zone.playerExited:Connect(function(player)
	print(("%s exited heat zone"):format(player.Name))
	player.Character.WeatherHandling.InHeatZone.Value = false
end)