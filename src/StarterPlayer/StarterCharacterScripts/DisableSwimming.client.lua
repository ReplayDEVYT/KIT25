local function onCharacterAdded(character)
	-- get the humanoid from the player's character
	local humanoid = character:WaitForChild("Humanoid")

	-- disable swimming state
	humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, false)
	print("Disabled swimming")
end

game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(onCharacterAdded)
end)