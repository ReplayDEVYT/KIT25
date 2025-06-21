local ts = require(game.ReplicatedStorage.TService)
function deathSound()
	wait(2)
	script.Normal:Play()
end
game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Died:connect(deathSound)