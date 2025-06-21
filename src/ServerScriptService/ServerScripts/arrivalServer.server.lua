local rs = game:GetService('ReplicatedStorage')
local evt = rs:WaitForChild('ArrivalEvents')

--PROFILESERVICE
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")


evt.RenameSpawn.OnServerEvent:connect(function(player,spawner,name,bool)
	print('renameSpawn fired')
	if spawner and name and spawner:IsA('SpawnLocation') then
		print('spawn renamed to '..name)
		spawner.Name = name
		if bool then
			spawner.Enabled = bool
		end
	end
end)

function check(player,tools)
	local boo = Instance.new('BoolValue',player.Character)
	boo.Name = "OwnTools"
	boo.Value = true
	player.Backpack:ClearAllChildren()
	print("cleared tools")
	table.find(tools)
	for i, toolName in ipairs(tools) do
		print(toolName.." given to "..player.Name.." (bc they have a cool loadout)")

		-- Find the tool in ServerStorage
		local tool = game:GetService("ServerStorage"):FindFirstChild(toolName)

		-- If the tool is found, clone it and parent it to the player's Backpack
		if tool then
			local clonedTool = tool:Clone()
			clonedTool.Parent = player.Backpack
		else
			print("Tool "..toolName.." not found in ServerStorage")
		end
	end
end


game:GetService("Players").PlayerAdded:connect(function(p)
	print(p.Name.." joined")

	if game.Players.CharacterAutoLoads then
		p.CharacterAdded:Wait()
		task.wait(2)
	end
	
	if not game.Players.CharacterAutoLoads then
		p:LoadCharacter()
	end

end)