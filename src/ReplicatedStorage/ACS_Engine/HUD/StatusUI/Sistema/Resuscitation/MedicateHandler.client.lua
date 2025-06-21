repeat
	wait()
until game.Players.LocalPlayer.Character
wait(0.5)

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local Char = player.Character
local Human = Char.Humanoid
local Saude = Char.Saude

local MedicSystem = game.ReplicatedStorage.ACS_Engine
local Functions = MedicSystem.Eventos.MedSys
local FunctionsMulti = Functions.Multi

local Target = Char.Saude.Variaveis.PlayerSelecionado

local Timer = script.Parent.Parent.Timer
local ts = require(game.ReplicatedStorage.TService)

Target.Changed:Connect(function()
	if Target.Value == "N/A" then
		script.Parent.TratarFeridasAberto.Comprimir.Style = Enum.ButtonStyle.RobloxButtonDefault
	else
		script.Parent.TratarFeridasAberto.Comprimir.Style = Enum.ButtonStyle.RobloxButton
	
	end
end)




script.Parent.TratarFeridasAberto.Comprimir.MouseButton1Down:Connect(function()
	if Saude.Variaveis.Doer.Value == false then
	if Target.Value == "N/A" then
		--Functions.Compress:FireServer()
		--Timer.Barra.Size = UDim2.new(0,0,1,0)
		--ts(Timer.Barra, TweenInfo.new(0.6), {Size =  UDim2.new(1,0,1,0)}):Play()
	else
		FunctionsMulti.Compress:FireServer()
		Timer.Barra.Size = UDim2.new(0,0,1,0)
		ts(Timer.Barra, TweenInfo.new(0.6), {Size =  UDim2.new(1,0,1,0)}):Play()
	end
	end
end)





