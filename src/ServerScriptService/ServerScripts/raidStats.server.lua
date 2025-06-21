local Players = game.Players

local Template = Instance.new 'BoolValue'
Template.Name = 'raidStatistics'

Instance.new('IntValue', Template).Name = "Kills"



Players.PlayerAdded:connect(function(Player)
	local Statss = Template:Clone()
	Statss.Parent = Player
	Player.CharacterAdded:connect(function(Character)
		local Humanoid = Character:FindFirstChild "Humanoid"
		if Humanoid then
			Humanoid.Died:connect(function()
				for i, Child in pairs(Humanoid:GetChildren()) do
					if Child:IsA('ObjectValue') and Child.Value and Child.Value:IsA('Player') then
						local Killer = Child.Value
						if Killer:FindFirstChild 'raidStatistics' and Killer.raidStatistics:FindFirstChild "Kills" then
							local Kills = Killer.raidStatistics.Kills
							Kills.Value = Kills.Value + 1
						end
						return -- Only one player can get a KO for killing a player. Not 2, not 3. Only one.
					end
				end
			end)
		end
	end)
end)