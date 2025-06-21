local ThisModel = "Leopard 2A5 (REUNION)"

script.Parent.OnServerEvent:connect(function(Player, pos)
	local Find = game:GetService("ReplicatedStorage")["VehicleContainer"]:FindFirstChild(ThisModel)
	if Find then
		local Clone = Find:Clone()
		Clone.Parent = game:GetService("Workspace")
		Clone:MakeJoints()
		Clone:MoveTo(pos)
	end
	script.Parent.Parent.Parent:Destroy()
end)