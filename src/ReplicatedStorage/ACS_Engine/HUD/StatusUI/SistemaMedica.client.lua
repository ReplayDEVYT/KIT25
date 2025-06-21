repeat
	wait()
until game.Players.LocalPlayer.Character
wait(0.5)

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local Char = player.Character

while wait() do
	
	local target = Char.Saude.Variaveis.PlayerSelecionado
	
	 -- This is Health Humanoid use "/" Health 100/100 or another number
	if target.Value ~= "N/A" then
		local player = game.Players:FindFirstChild(target.Value)
		local PlHuman = player.Character.Humanoid	

		local Sang = PlHuman.Parent.Saude.Variaveis.Sangue
		local Dor = PlHuman.Parent.Saude.Variaveis.Dor
	
		local pie = (PlHuman.Health / PlHuman.MaxHealth)
		script.Parent.VidaBar.Sangue.Size = UDim2.new(1, 0, -pie, 0)

		local Pizza = (Sang.Value / Sang.MaxValue)
		script.Parent.SangueBar.Sangue.Size = UDim2.new(1, 0, -Pizza, 0)

		local Mob = PlHuman.Parent.Saude.Stances.Sangrando
		local MLS = PlHuman.Parent.Saude.Variaveis.MLs
		local imagem = script.Parent.SangBar.ImageLabel

		if Mob.Value == true and MLS.Value < 25 then
		imagem.Visible = true
		imagem.ImageColor3 = Color3.new(255,255,255)

		elseif Mob.Value == true and MLS.Value >= 25 and MLS.Value < 100 then
		imagem.Visible = true
		imagem.ImageColor3 = Color3.new(255,255,0)
	
		elseif Mob.Value == true and MLS.Value >= 100 then
		imagem.Visible = true
		imagem.ImageColor3 = Color3.new(255,0,0)
	
		elseif Mob.Value == false then
		imagem.Visible = false
		end

	else
		
		local Sang = Char.Saude.Variaveis.Sangue
		local Dor = Char.Saude.Variaveis.Dor

		local pie = (Char.Humanoid.Health / Char.Humanoid.MaxHealth)
		script.Parent.VidaBar.Sangue.Size = UDim2.new(1, 0, -pie, 0)

		local Pizza = (Sang.Value / Sang.MaxValue)
		script.Parent.SangueBar.Sangue.Size = UDim2.new(1, 0, -Pizza, 0)

		local Mob = Char.Saude.Stances.Sangrando
		local MLS = Char.Saude.Variaveis.MLs
		local imagem = script.Parent.SangBar.ImageLabel

		if Mob.Value == true and MLS.Value < 25 then
		imagem.Visible = true
		imagem.ImageColor3 = Color3.new(255,255,255)

		elseif Mob.Value == true and MLS.Value >= 25 and MLS.Value < 100 then
		imagem.Visible = true
		imagem.ImageColor3 = Color3.new(255,255,0)
	
		elseif Mob.Value == true and MLS.Value >= 100 then
		imagem.Visible = true
		imagem.ImageColor3 = Color3.new(255,0,0)
	
		elseif Mob.Value == false then
		imagem.Visible = false
		end
	end
end
