respawn_time = game.Players.RespawnTime

allow_force_respawn = false

force_respawn = "respawn"

game.Players.CharacterAutoLoads = false

function onPlayerDied(player, character)
	task.wait(respawn_time)
	if not game.Players.CharacterAutoLoads and (player.Character == nil or player.Character ~= nil and player.Character:WaitForChild("Humanoid").Health <= 0) and workspace.PermaDeath.Toggle.Value == false then
		player:LoadCharacter()
	end
end

function onPlayerSpawned(player, character)
	while not character:FindFirstChild("Humanoid") do task.wait() end
	character.Humanoid.Died:Once(function () onPlayerDied(player, character) end)
end

function onPlayerEntered(player)

	player.CharacterAdded:connect(function (char) onPlayerSpawned(player, char) end)

	if not game.Players.CharacterAutoLoads then
		player:LoadCharacter()
	end
end

game.Players.PlayerAdded:connect(onPlayerEntered)
