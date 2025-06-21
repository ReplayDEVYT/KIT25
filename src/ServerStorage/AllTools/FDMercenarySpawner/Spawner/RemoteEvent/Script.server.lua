local ThisModel = "FDMercenary"

script.Parent.OnServerEvent:connect(function(Player, pos)
	local Find = game:GetService("ServerStorage")["MercenariesFolder"]:FindFirstChild(ThisModel)
	if Find then
		local Clone = Find:Clone()
		Clone.Parent = game:GetService("Workspace")
		Clone:MakeJoints()
		Clone:MoveTo(pos)
	end
end)