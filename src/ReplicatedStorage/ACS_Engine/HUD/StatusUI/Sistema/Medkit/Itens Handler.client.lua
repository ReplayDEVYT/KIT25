repeat
	wait()
until game.Players.LocalPlayer.Character
wait(0.5)


local Players = game:GetService("Players")
local player = Players.LocalPlayer
local Char = player.Character

local Aspirina = Char.Saude.Kit.Aspirina
local Bandagem = Char.Saude.Kit.Bandagem
local Splint = Char.Saude.Kit.Splint
local Tourniquet = Char.Saude.Kit.Tourniquet
local Energetico = Char.Saude.Kit.Energetico
local Epinefrina = Char.Saude.Kit.Epinefrina

local Morfina = Char.Saude.Kit.Morfina
local SacoDeSangue = Char.Saude.Kit.SacoDeSangue


local AspirinaQuantidade = script.Parent.Painkiller.Quantidade
local BandagemQuantidade = script.Parent.Bandage.Quantidade
local SplintQuantidade = script.Parent.Splint.Quantidade
local TourniquetQuantidade = script.Parent.Tourniquet.Quantidade
local EnergeticoQuantidade = script.Parent.Energy.Quantidade
local EpinefrinaQuantidade = script.Parent.Epinefrina.Quantidade

local MorfinaQuantidade = script.Parent.Morfina.Quantidade
local SacoDeSangueQuantidade = script.Parent.BloodBag.Quantidade

AspirinaQuantidade.Text = Aspirina.Value
BandagemQuantidade.Text = Bandagem.Value
EnergeticoQuantidade.Text = Energetico.Value
EpinefrinaQuantidade.Text = Epinefrina.Value

MorfinaQuantidade.Text = Morfina.Value
SplintQuantidade.Text = Splint.Value
SacoDeSangueQuantidade.Text = SacoDeSangue.Value
TourniquetQuantidade.Text = Tourniquet.Value


Aspirina.Changed:Connect(function()
	AspirinaQuantidade.Text = Aspirina.Value
end)

Bandagem.Changed:Connect(function()
	BandagemQuantidade.Text = Bandagem.Value
end)

Splint.Changed:Connect(function()
	SplintQuantidade.Text = Splint.Value
end)

Tourniquet.Changed:Connect(function()
	TourniquetQuantidade.Text = Tourniquet.Value
end)

Energetico.Changed:Connect(function()
	EnergeticoQuantidade.Text = Energetico.Value
end)

Epinefrina.Changed:Connect(function()
	EpinefrinaQuantidade.Text = Epinefrina.Value
end)

Morfina.Changed:Connect(function()
	MorfinaQuantidade.Text = Morfina.Value
end)

SacoDeSangue.Changed:Connect(function()
	SacoDeSangueQuantidade.Text = SacoDeSangue.Value
end)

