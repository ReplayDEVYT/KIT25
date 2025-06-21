game.Players.PlayerAdded:connect(function(p)
	p.CharacterAdded:connect(function(c) 
		repeat task.wait() until p:FindFirstChild("Backpack")
		task.wait(.1)
		repeat task.wait() until p.Team ~= nil
		if p.Character:FindFirstChild('OwnTools') == nil then
			if p.Team.Name == "SCAV" then

				game.ReplicatedStorage.ScavPrimaries:GetChildren()[math.random(1, #game.ReplicatedStorage.ScavPrimaries:GetChildren())]:clone().Parent = p.Backpack
				--wait(.51)
				game.ReplicatedStorage.emptySpace:clone().Parent = p.Backpack
				game.ReplicatedStorage.ScavSidearm:GetChildren()[math.random(1, #game.ReplicatedStorage.ScavSidearm:GetChildren())]:clone().Parent = p.Backpack 
				--wait(.51)
				--wait(.51)
				for i,v in pairs (game.ReplicatedStorage.OthersScav:GetChildren()) do
					--wait(.51)
					v:Clone().Parent = p.Backpack
				end
				--[[game.ReplicatedStorage.Primaries:GetChildren()[math.random(1, #game.ReplicatedStorage.Primaries:GetChildren())]:clone().Parent = p.Backpack
				--wait(.51)
				game.ReplicatedStorage.emptySpace:clone().Parent = p.Backpack
				game.ReplicatedStorage.Sidearm:GetChildren()[math.random(1, #game.ReplicatedStorage.Sidearm:GetChildren())]:clone().Parent = p.Backpack 
				--wait(.51)
				--wait(.51)
				for i,v in pairs (game.ReplicatedStorage.Others:GetChildren()) do
					--wait(.51)
					v:Clone().Parent = p.Backpack
				end
				game.ReplicatedStorage.Extra:GetChildren()[math.random(1, #game.ReplicatedStorage.Extra:GetChildren())]:clone().Parent = p.Backpack]]--

			elseif p.Team.Name == "USEC" then 

				game.ReplicatedStorage.UsecPrimaries:GetChildren()[math.random(1, #game.ReplicatedStorage.UsecPrimaries:GetChildren())]:clone().Parent = p.Backpack
				--wait(.51)
				game.ReplicatedStorage.emptySpace:clone().Parent = p.Backpack
				game.ReplicatedStorage.UsecSidearms:GetChildren()[math.random(1, #game.ReplicatedStorage.UsecSidearms:GetChildren())]:clone().Parent = p.Backpack
				--wait(.51)
				--wait(.51)
				for i,v in pairs (game.ReplicatedStorage.OthersNew:GetChildren()) do
					--wait(.51)
					v:Clone().Parent = p.Backpack
				end
			elseif p.Team.Name == "BEAR" then 

				game.ReplicatedStorage.BearPrimaries:GetChildren()[math.random(1, #game.ReplicatedStorage.BearPrimaries:GetChildren())]:clone().Parent = p.Backpack
				--wait(.51)
				game.ReplicatedStorage.emptySpace:clone().Parent = p.Backpack
				game.ReplicatedStorage.BearSecondaries:GetChildren()[math.random(1, #game.ReplicatedStorage.BearSecondaries:GetChildren())]:clone().Parent = p.Backpack
				--wait(.51)
				--wait(.51)
				for i,v in pairs (game.ReplicatedStorage.OthersNew:GetChildren()) do
					--wait(.51)
					v:Clone().Parent = p.Backpack
				end
			elseif p.Team.Name == "CULT" then

				game.ReplicatedStorage.CultPrimaries:GetChildren()[math.random(1, #game.ReplicatedStorage.CultPrimaries:GetChildren())]:clone().Parent = p.Backpack
				--wait(.51)
				game.ReplicatedStorage.emptySpace:clone().Parent = p.Backpack
				game.ReplicatedStorage.CultSidearm:GetChildren()[math.random(1, #game.ReplicatedStorage.CultSidearm:GetChildren())]:clone().Parent = p.Backpack 
				--wait(.51)

				--wait(.51)
				for i,v in pairs (game.ReplicatedStorage.Others:GetChildren()) do
					--wait(.51)
					v:Clone().Parent = p.Backpack
				end
			else
				--wait(.51)
				game.ReplicatedStorage.Primaries:GetChildren()[math.random(1, #game.ReplicatedStorage.Primaries:GetChildren())]:clone().Parent = p.Backpack
				--wait(.51)
				game.ReplicatedStorage.emptySpace:clone().Parent = p.Backpack
				game.ReplicatedStorage.Sidearm:GetChildren()[math.random(1, #game.ReplicatedStorage.Sidearm:GetChildren())]:clone().Parent = p.Backpack 
				--wait(.51)
				--wait(.51)
				for i,v in pairs (game.ReplicatedStorage.Others:GetChildren()) do
					--wait(.51)
					v:Clone().Parent = p.Backpack
				end
			end
		end
	end) 
	--wait(3)
end) 