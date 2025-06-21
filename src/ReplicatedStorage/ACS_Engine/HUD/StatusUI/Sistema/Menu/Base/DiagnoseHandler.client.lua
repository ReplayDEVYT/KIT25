repeat
	wait()
until game.Players.LocalPlayer.Character
wait(0.5)

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local Char = player.Character



while true do
	wait()
	local target = Char.Saude.Variaveis.PlayerSelecionado
	
	 -- This is Health Humanoid use "/" Health 100/100 or another number
	if target.Value ~= "N/A" then
		local player = game.Players:FindFirstChild(target.Value)
		local PlHuman = player.Character.Humanoid	

		local Sang = PlHuman.Parent.Saude.Variaveis.Sangue
	
		local pie = (PlHuman.Health / PlHuman.MaxHealth)
		script.Parent.VidaBar.Sangue.Size = UDim2.new(1, 0, -pie, 0)

		local Pizza = (Sang.Value / Sang.MaxValue)
		script.Parent.SangueBar.Sangue.Size = UDim2.new(1, 0, -Pizza, 0)


	else
		
		local Sang = Char.Saude.Variaveis.Sangue

		local pie = (Char.Humanoid.Health / Char.Humanoid.MaxHealth)
		script.Parent.VidaBar.Sangue.Size = UDim2.new(1, 0, -pie, 0)

		local Pizza = (Sang.Value / Sang.MaxValue)
		script.Parent.SangueBar.Sangue.Size = UDim2.new(1, 0, -Pizza, 0)

	end
end
