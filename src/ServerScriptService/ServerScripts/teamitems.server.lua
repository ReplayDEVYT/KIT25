

game.Players.PlayerAdded:connect(function(plr)
	plr.CharacterAdded:connect(function(char)
		for _,v in pairs(game:GetService("Teams"):GetChildren()) do
			if v.TeamColor == plr.TeamColor then
				for _,v in pairs(v:GetChildren()) do
					--if v:IsA("Tool") then
						v:Clone().Parent = plr:WaitForChild("Backpack")
					--end
				end
			end
		end
	end)
end)