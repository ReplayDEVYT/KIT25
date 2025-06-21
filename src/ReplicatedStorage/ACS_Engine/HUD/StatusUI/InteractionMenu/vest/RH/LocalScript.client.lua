local player = game.Players.LocalPlayer
script.Parent.Parent.Parent.Player.Value = player
local clickEvent = script.Parent:WaitForChild("VestEvent")
script.Parent.MouseButton1Click:Connect(function()
	clickEvent:FireServer(player.Character)
end)
print(clickEvent)
-- exxtremestuffs 2019