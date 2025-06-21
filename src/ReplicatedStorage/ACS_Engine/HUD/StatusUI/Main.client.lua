repeat
	wait()
until game.Players.LocalPlayer.Character

local Engine = game.ReplicatedStorage:WaitForChild("ACS_Engine")
local ACS_WS = workspace:WaitForChild("ACS_WorkSpace")
local Evt = Engine:WaitForChild("Eventos")
local ServerConfig = require(Engine.ServerConfigs:WaitForChild("Config"))
local ts = require(game.ReplicatedStorage.TService)
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local Char = player.Character
local Reset = Evt.MedSys.Reset
local Human = Char:WaitForChild("Humanoid")
local interactionmouse = script.Parent.InteractionMouse
local TextoOmbro = script.Parent.OmbroTexto

local RS = game:GetService("ReplicatedStorage")
local DoorEvent = Evt:WaitForChild("DoorEvent")

local Target = nil
local TratarAtivo = false 
local TratarCheck = false

local InteragirAtivo = false 
local InteragirCheck = false

local EquipeAtivo = false 

local PortaAtivo = false 

local Arrastando = false

local Yeet = false
local GUI = script.Parent 
local Sis = GUI.Sistema

local alreadycalled = false

Sgui = script.Parent.Parent
player = Sgui.Parent
mouse = player:GetMouse()
mouse.TargetFilter = workspace.CurrentCamera
IgnoreList = {Camera,Char}

local ACS_Storage = workspace:WaitForChild("ACS_WorkSpace")
local DoorsFolder = ACS_Storage:FindFirstChild("Doors")
local BreachFolder = ACS_WS:FindFirstChild("Breach")
local mDistance = 5

function getNearest()
	local nearest = nil
	local minDistance = mDistance
	local Character = player.Character or player.CharacterAdded:Wait()
	
	for I,Door in pairs (DoorsFolder:GetChildren()) do
		if Door:FindFirstChild("knob") ~= nil and Character:FindFirstChild("Torso") ~= nil then
			local distance = (Door.knob.Position - Character:FindFirstChild("Torso").Position).magnitude
		
			if distance < minDistance then
				nearest = Door
				minDistance = distance
			end
		end
	end
	return nearest
end

function getNearestBreach()
	local nearest = nil
	local minDistance = mDistance
	local Character = player.Character or player.CharacterAdded:Wait()
	
	for I,Door in pairs (BreachFolder:GetChildren()) do
		if Door:FindFirstChild("Destroyable") ~= nil and Door.Destroyable:FindFirstChild("Charge") ~= nil and Character:FindFirstChild("Torso") ~= nil then
			local distance = (Door.Destroyable.Charge.Position - Character:FindFirstChild("Torso").Position).magnitude
			if distance < minDistance then
				nearest = Door
				minDistance = distance
			end

		end
	end
	return nearest
end



local sla = Engine.HUD.DoorTag:Clone()
local slaBreach = Engine.HUD.BreachTag:Clone()

function CheckForHumanoid(L_225_arg1)
	local L_226_ = false
	local L_227_ = nil
	if L_225_arg1 then
		if (L_225_arg1.Parent:FindFirstChild("Humanoid") or L_225_arg1.Parent.Parent:FindFirstChild("Humanoid")) then
			L_226_ = true
			if L_225_arg1.Parent:FindFirstChild('Humanoid') then
				L_227_ = L_225_arg1.Parent.Humanoid
			elseif L_225_arg1.Parent.Parent:FindFirstChild('Humanoid') then
				L_227_ = L_225_arg1.Parent.Parent.Humanoid
			end
		else
			L_226_ = false
		end	
	end
	return L_226_, L_227_
end

function ResetGui()
	TratarAtivo = false 
 	TratarCheck = false

	InteragirAtivo = false 
 	InteragirCheck = false

	EquipeAtivo = false
	PortaAtivo = false

	--Arrastando = false

	GUI.InteractionMenu.Tratar.SeTratar.Visible = false
	GUI.InteractionMenu.Tratar.OutroTratar.Visible = false

	GUI.InteractionMenu.Interagir.Liberar.Visible = false
	GUI.InteractionMenu.Interagir.SeRender.Visible = false
	GUI.InteractionMenu.Interagir.Revistar.Visible = false

	GUI.InteractionMenu.Equipes.Sair.Visible = false
	GUI.InteractionMenu.Equipes.Vermelho.Visible = false
	GUI.InteractionMenu.Equipes.Verde.Visible = false
	GUI.InteractionMenu.Equipes.Azul.Visible = false
	GUI.InteractionMenu.Equipes.Amarelo.Visible = false

	GUI.InteractionMenu.Porta.Abrir.Visible = false
	GUI.InteractionMenu.Porta.Lock.Visible = false
	GUI.InteractionMenu.Porta.Lockpick.Visible = false

	GUI.Sistema.Circulation.Visible = false
	GUI.Sistema.Resuscitation.Visible = false
	GUI.Sistema.Analgesic.Visible = false
	game.Lighting.MedSysBlur.Enabled = false
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	
	if input.KeyCode == ServerConfig.InteractionMenuKey then
		 Yeet = not Yeet
		if Yeet then
			if UserInputService.MouseIconEnabled == false then
			interactionmouse.Icon.Visible = true
			end
			GUI.InteractionMenu.FLM.Modal = true
			script.Parent.InteractionMenu.Visible = true
			if ServerConfig.EnableMedSys then
				script.Parent.InteractionMenu.Tratar.Visible = true
				game.Lighting.MedSysBlur.Enabled = false
			else
				script.Parent.InteractionMenu.Tratar.Visible = false
				game.Lighting.MedSysBlur.Enabled = false
			end
		else
			interactionmouse.Icon.Visible = false
			GUI.InteractionMenu.FLM.Modal = false
			script.Parent.InteractionMenu.Visible = false
			
			 ResetGui()

			Sis.Visible = false
			game.Lighting.MedSysBlur.Enabled = false
			Sis.FLM.Modal = false
			--Reset:FireServer()
		end
	elseif input.KeyCode == Enum.KeyCode.F1 then
		
		local Player = player
		local voip1 = GUI.MainFrame.voip1
		local voip2 = GUI.MainFrame.voip2
		local voip3 = GUI.MainFrame.voip3
		if alreadycalled == false then
			alreadycalled = true
			Evt.SayVoiceline:FireServer(false)
			ts(voip1,TweenInfo.new(0.3),{ImageTransparency = 0.5}):Play()
			task.wait(0.1)
			ts(voip3,TweenInfo.new(0.3),{ImageTransparency = 0.5}):Play()
			task.wait(0.1)
			ts(voip2,TweenInfo.new(0.3),{ImageTransparency = 0.5}):Play()
			
			task.wait(1)
			
			ts(voip1,TweenInfo.new(0.3),{ImageTransparency = 1}):Play()
			task.wait(0.1)
			ts(voip3,TweenInfo.new(0.3),{ImageTransparency = 1}):Play()
			task.wait(0.1)
			ts(voip2,TweenInfo.new(0.3),{ImageTransparency = 1}):Play()
			task.wait(3)
			alreadycalled = false
		elseif alreadycalled == true then
			print("voiceline cooldown")
			return false
		end
	elseif input.KeyCode == Enum.KeyCode.F2 then

		local Player = player
		local voip1 = GUI.MainFrame.voip1
		local voip2 = GUI.MainFrame.voip2
		local voip3 = GUI.MainFrame.voip3
		if alreadycalled == false then
			alreadycalled = true
			Evt.SayVoiceline:FireServer(true)
			ts(voip1,TweenInfo.new(0.3),{ImageTransparency = 0.5}):Play()
			task.wait(0.1)
			ts(voip3,TweenInfo.new(0.3),{ImageTransparency = 0.5}):Play()
			task.wait(0.1)
			ts(voip2,TweenInfo.new(0.3),{ImageTransparency = 0.5}):Play()

			task.wait(1)

			ts(voip1,TweenInfo.new(0.3),{ImageTransparency = 1}):Play()
			task.wait(0.1)
			ts(voip3,TweenInfo.new(0.3),{ImageTransparency = 1}):Play()
			task.wait(0.1)
			ts(voip2,TweenInfo.new(0.3),{ImageTransparency = 1}):Play()
			task.wait(3)
			alreadycalled = false
		elseif alreadycalled == true then
			print("voiceline cooldown")
			return false
		end
	end
end)

GUI.InteractionMenu.Fechar.MouseButton1Click:connect(function()
			Yeet = false
			interactionmouse.Icon.Visible = false
			GUI.InteractionMenu.FLM.Modal = false
			script.Parent.InteractionMenu.Visible = false
			Arrastando = false
			
			 ResetGui()

	Sis.Visible = false
	game.Lighting.MedSysBlur.Enabled = false
			Sis.FLM.Modal = false
			Reset:FireServer()
end)

GUI.InteractionMenu.Equipes:WaitForChild('Amarelo').MouseButton1Click:connect(function()
	local SquadName = "Delta"
	local SquadColor = Color3.fromRGB(245, 205, 48)
	Evt.Squad:FireServer(SquadName,SquadColor)
end)

GUI.InteractionMenu.Equipes:WaitForChild('Azul').MouseButton1Click:connect(function()
	local SquadName = "Charlie"
	local SquadColor = Color3.fromRGB(0, 143, 156)
	Evt.Squad:FireServer(SquadName,SquadColor)
end)

GUI.InteractionMenu.Equipes:WaitForChild('Verde').MouseButton1Click:connect(function()
	local SquadName = "Bravo"
	local SquadColor = Color3.fromRGB(75, 151, 75)
	Evt.Squad:FireServer(SquadName,SquadColor)
end)

GUI.InteractionMenu.Equipes:WaitForChild('Vermelho').MouseButton1Click:connect(function()
	local SquadName = "Alpha"
	local SquadColor = Color3.fromRGB(255, 89, 89)
	Evt.Squad:FireServer(SquadName,SquadColor)
end)

GUI.InteractionMenu.Equipes:WaitForChild('Sair').MouseButton1Click:connect(function()
	local SquadName = ""
	local SquadColor = Color3.fromRGB(255, 255, 255)
	Evt.Squad:FireServer(SquadName,SquadColor)
end)

GUI.InteractionMenu.Equipes:WaitForChild('Botao').MouseButton1Click:connect(function()
	ResetGui()
	EquipeAtivo = not EquipeAtivo
	if EquipeAtivo then
		GUI.InteractionMenu.Equipes.Sair.Visible = true
		GUI.InteractionMenu.Equipes.Vermelho.Visible = true
		GUI.InteractionMenu.Equipes.Verde.Visible = true
		GUI.InteractionMenu.Equipes.Azul.Visible = true
		GUI.InteractionMenu.Equipes.Amarelo.Visible = true
		InteragirCheck = true
	else
		GUI.InteractionMenu.Equipes.Sair.Visible = false
		GUI.InteractionMenu.Equipes.Vermelho.Visible = false
		GUI.InteractionMenu.Equipes.Verde.Visible = false
		GUI.InteractionMenu.Equipes.Azul.Visible = false
		GUI.InteractionMenu.Equipes.Amarelo.Visible = false
		InteragirCheck = false
	end
end)

GUI.InteractionMenu.Interagir:WaitForChild('SeRender').MouseButton1Click:connect(function()
	Evt.Render:FireServer(true,"N/A")
			Yeet = false
			interactionmouse.Icon.Visible = false
			GUI.InteractionMenu.FLM.Modal = false
			script.Parent.InteractionMenu.Visible = false
			Arrastando = false
			
			 ResetGui()

	Sis.Visible = false
	game.Lighting.MedSysBlur.Enabled = false
			Sis.FLM.Modal = false
			Reset:FireServer()
end)

GUI.InteractionMenu.Interagir:WaitForChild('Liberar').MouseButton1Click:connect(function()
	Evt.Render:FireServer(false,Target)
end)

GUI.InteractionMenu.Interagir:WaitForChild('Botao').MouseButton1Click:connect(function()
	ResetGui()
	InteragirAtivo = not InteragirAtivo
	if InteragirAtivo then
		GUI.InteractionMenu.Interagir.SeRender.Visible = true
		InteragirCheck = true
	else
		GUI.InteractionMenu.Interagir.SeRender.Visible = false
		InteragirCheck = false
	end
end)

GUI.InteractionMenu.Tratar:WaitForChild('Botao').MouseButton1Click:connect(function()
	ResetGui()
	TratarAtivo = not TratarAtivo
	if TratarAtivo then
		GUI.InteractionMenu.Tratar.SeTratar.Visible = true
		TratarCheck = true
	else
		GUI.InteractionMenu.Tratar.SeTratar.Visible = false
		TratarCheck = false
	end
end)

GUI.InteractionMenu.Tratar:WaitForChild('SeTratar').MouseButton1Click:connect(function()
			Reset:FireServer()
			interactionmouse.Icon.Visible = false
			GUI.InteractionMenu.FLM.Modal = false
			script.Parent.InteractionMenu.Visible = false
			
			ResetGui()

			Human:UnequipTools()
	Sis.Visible = true
	game.Lighting.MedSysBlur.Enabled = true
			Sis.FLM.Modal = true
end)

GUI.InteractionMenu.Tratar:WaitForChild('OutroTratar').MouseButton1Click:connect(function()
			interactionmouse.Icon.Visible = false
			GUI.InteractionMenu.FLM.Modal = false
			script.Parent.InteractionMenu.Visible = false
			
			ResetGui()

			Evt.Target:FireServer(Target)
			Human:UnequipTools()
	Sis.Visible = true
	game.Lighting.MedSysBlur.Enabled = true
			Sis.FLM.Modal = true
end)

GUI.InteractionMenu.Ombro:WaitForChild('Botao').MouseButton1Click:connect(function()
	ResetGui()

	Evt.Ombro:FireServer(Target)
	Yeet = false
	interactionmouse.Icon.Visible = false
	GUI.InteractionMenu.FLM.Modal = false
	script.Parent.InteractionMenu.Visible = false
end)

GUI.InteractionMenu.Porta:WaitForChild('Botao').MouseButton1Click:connect(function()
	ResetGui()
	PortaAtivo = not PortaAtivo
	if PortaAtivo then
		GUI.InteractionMenu.Porta.Abrir.Visible = true
		InteragirCheck = true
	else
		GUI.InteractionMenu.Porta.Abrir.Visible = true
		InteragirCheck = false
	end
end)

GUI.InteractionMenu.Porta:WaitForChild('Abrir').MouseButton1Click:connect(function()
	local nearestDoor = getNearest()
	local Key
	DoorEvent:FireServer(nearestDoor,1,Key)
end)

GUI.InteractionMenu.Porta:WaitForChild('Lock').MouseButton1Click:connect(function()
	local nearestDoor = getNearest()
	local Key
	DoorEvent:FireServer(nearestDoor,3,Key)
end)

GUI.InteractionMenu.Porta:WaitForChild('Lockpick').MouseButton1Click:connect(function()
	local nearestDoor = getNearest()
	local Key
	DoorEvent:FireServer(nearestDoor,4,Key)
end)

GUI.InteractionMenu.Porta:WaitForChild('Breach').MouseButton1Click:connect(function()
	ResetGui()
	Yeet = false
	interactionmouse.Icon.Visible = false
	GUI.InteractionMenu.FLM.Modal = false
	script.Parent.InteractionMenu.Visible = false
	local nearestDoor = getNearest()
	local Raio2 = Ray.new(Camera.CFrame.Position, Camera.CFrame.LookVector * 5)
	local Hit, Pos, Norm = workspace:FindPartOnRayWithIgnoreList(Raio2, IgnoreList, false, true)

	Evt.Breach:FireServer(2,nearestDoor,Pos,Norm,Hit)
end)

GUI.InteractionMenu.Fortify:WaitForChild('Botao').MouseButton1Click:connect(function()
	ResetGui()
	Yeet = false
	interactionmouse.Icon.Visible = false
	GUI.InteractionMenu.FLM.Modal = false
	script.Parent.InteractionMenu.Visible = false
	local nearestDoor = getNearestBreach()
	local Raio2 = Ray.new(Camera.CFrame.Position, Camera.CFrame.LookVector * 5)
	local Hit, Pos, Norm = workspace:FindPartOnRayWithIgnoreList(Raio2, IgnoreList, false, true)

	Evt.Breach:FireServer(3,nearestDoor,Pos,Norm,Hit)
end)

GUI.InteractionMenu.Breach:WaitForChild('Botao').MouseButton1Click:connect(function()
	ResetGui()
	Yeet = false
	interactionmouse.Icon.Visible = false
	GUI.InteractionMenu.FLM.Modal = false
	script.Parent.InteractionMenu.Visible = false
	local nearestDoor = getNearestBreach()
	local Raio2 = Ray.new(Camera.CFrame.Position, Camera.CFrame.LookVector * 5)
	local Hit, Pos, Norm = workspace:FindPartOnRayWithIgnoreList(Raio2, IgnoreList, false, true)

	Evt.Breach:FireServer(1,nearestDoor,Pos,Norm,Hit)
end)

GUI.InteractionMenu.Rappel:WaitForChild('Botao').MouseButton1Click:connect(function()
	ResetGui()
	Yeet = false
	interactionmouse.Icon.Visible = false
	GUI.InteractionMenu.FLM.Modal = false
	script.Parent.InteractionMenu.Visible = false

	if Char.Saude.Stances.Rappeling.Value == false then
		local Raio = Ray.new(Camera.CFrame.Position, Camera.CFrame.LookVector * 12)
		local Hit, Pos = workspace:FindPartOnRayWithIgnoreList(Raio, IgnoreList, false, true)

		if player.Character ~= nil and Char.Humanoid.Health > 0 then
			Evt.Rappel.PlaceEvent:FireServer(Pos,Hit)
			Char.Saude.Stances.Rappeling.Value = true
			GUI.InteractionMenu.Rappel.Botao.Text = "Cut Rappel"
		end
	else
		if player.Character ~= nil and Char.Humanoid.Health > 0 then
			Evt.Rappel.CutEvent:FireServer()
			Char.Saude.Stances.Rappeling.Value = false
			GUI.InteractionMenu.Rappel.Botao.Text = "Attach Rappel"
		end
	end
end)


game:GetService("RunService").RenderStepped:connect(function()
	local Jogadors = game.Players:GetChildren()
	


	local Breachs = getNearestBreach()
	if Breachs ~= nil and Char.Humanoid.Health > 0 and Breachs.Destroyed.Value == false then
		if (Breachs:FindFirstChild("Destroyable") ~= nil) and Breachs.Destroyable:FindFirstChild("Charge") ~= nil then
			local Raio2 = Ray.new(Camera.CFrame.Position, Camera.CFrame.LookVector * 5)
			local Hit2, Pos2 = workspace:FindPartOnRayWithIgnoreList(Raio2, IgnoreList, false, true)
			


			if Char.Saude.Kit.Fortifications.Value > 0 then
				if Breachs.Fortified.Value == false then
					slaBreach.Parent = Breachs
					slaBreach.Adornee = Breachs.Destroyable.Charge
					slaBreach.Frame.Frame.ImageColor3 = Color3.fromRGB(255,255,255)

					if Hit2 ~= nil and Hit2.Parent == Breachs.Destroyable then
						GUI.InteractionMenu.Fortify.Visible = true
					else
						GUI.InteractionMenu.Fortify.Visible = false
					end
				else
					GUI.InteractionMenu.Fortify.Visible = false
					slaBreach.Parent = Breachs
					slaBreach.Adornee = Breachs.Destroyable.Charge
					slaBreach.Frame.Frame.ImageColor3 = Color3.fromRGB(255,0,0)
				end
			else
				GUI.InteractionMenu.Fortify.Visible = false
			end


			if Char.Saude.Kit.BreachCharges.Value > 0 then

				if Breachs.Fortified.Value == true then
					slaBreach.Parent = Breachs
					slaBreach.Adornee = Breachs.Destroyable.Charge
					slaBreach.Frame.Frame.ImageColor3 = Color3.fromRGB(255,0,0)
					GUI.InteractionMenu.Breach.Visible = false
				else
					slaBreach.Parent = Breachs
					slaBreach.Adornee = Breachs.Destroyable.Charge
					slaBreach.Frame.Frame.ImageColor3 = Color3.fromRGB(255,255,255)
					if Hit2 ~= nil and Hit2.Parent == Breachs.Destroyable then
						GUI.InteractionMenu.Breach.Visible = true
					else
						GUI.InteractionMenu.Breach.Visible = false
					end
				end
			end

		else
			GUI.InteractionMenu.Breach.Visible = false
		end
	else
		slaBreach.Parent = nil
		GUI.InteractionMenu.Breach.Visible = false
		GUI.InteractionMenu.Fortify.Visible = false
	end
	--print(Breachs)


	local Porta = getNearest()
	if Porta ~= nil and Char.Humanoid.Health > 0 then
		GUI.InteractionMenu.Porta.Visible = true
		
		if Porta.Destroyed.Value == false and Char.Saude.Kit.BreachCharges.Value > 0  then
			local Raio2 = Ray.new(Camera.CFrame.Position, Camera.CFrame.LookVector * 5)
			local Hit2, Pos2 = workspace:FindPartOnRayWithIgnoreList(Raio2, IgnoreList, false, true)
			if PortaAtivo == true and Hit2 ~= nil and string.find(Hit2.Parent.Name,"Door") then
				GUI.InteractionMenu.Porta.Breach.Visible = true
			else
				GUI.InteractionMenu.Porta.Breach.Visible = false
			end
		end

		if Porta.Locked.Value == true then
			sla.Frame.Frame.ImageColor3 = Color3.fromRGB(255,0,0)
			sla.Frame.open.TextColor3 = Color3.fromRGB(255,0,0)
			sla.Frame.open.TextTransparency = 0.5
			sla.Frame.scroll.TextColor3 = Color3.fromRGB(255,0,0)
			sla.Frame.scroll.TextTransparency = 0.5
			if Porta:FindFirstChild("nokick") ~= nil then
				sla.Frame.kick.TextColor3 = Color3.fromRGB(255,0,0)
				sla.Frame.kick.TextTransparency = 0.5
			else
				sla.Frame.kick.TextColor3 = Color3.fromRGB(255,255,255)
				sla.Frame.kick.TextTransparency = 0
			end
			GUI.InteractionMenu.Porta.Abrir.Imagem.ImageColor3 = Color3.fromRGB(255,0,0)
			GUI.InteractionMenu.Porta.Lock.Text = "Unlock door"
		else
			sla.Frame.Frame.ImageColor3 = Color3.fromRGB(255,255,255)
			GUI.InteractionMenu.Porta.Abrir.Imagem.ImageColor3 = Color3.fromRGB(255,255,255)
			GUI.InteractionMenu.Porta.Lock.Text = "Lock door"
			sla.Frame.open.TextColor3 = Color3.fromRGB(255,255,255)
			sla.Frame.open.TextTransparency = 0
			sla.Frame.scroll.TextColor3 = Color3.fromRGB(255,255,255)
			sla.Frame.scroll.TextTransparency = 0
			if Porta:FindFirstChild("nokick") ~= nil then
				sla.Frame.kick.TextColor3 = Color3.fromRGB(255,0,0)
				sla.Frame.kick.TextTransparency = 0.5
			else
				sla.Frame.kick.TextColor3 = Color3.fromRGB(255,255,255)
				sla.Frame.kick.TextTransparency = 0
			end
		end

		sla.Parent = Porta

		if (Porta:FindFirstChild("knob") ~= nil) and (Porta:FindFirstChild("DoorHinge") ~= nil) or (Porta:FindFirstChild("eixo1") ~= nil) or (Porta:FindFirstChild("eixo2") ~= nil) then
			sla.Adornee = Porta.knob
		else
			GUI.InteractionMenu.Porta.Visible = false
			PortaAtivo = false
			GUI.InteractionMenu.Porta.Abrir.Visible = false
			GUI.InteractionMenu.Porta.Lock.Visible = false
			GUI.InteractionMenu.Porta.Lockpick.Visible = false
			GUI.InteractionMenu.Porta.Breach.Visible = false
			sla.Parent = nil
		end

	if PortaAtivo == true then
		if Porta:FindFirstChild("RequiresKey") then
			if Char:FindFirstChild(Porta.RequiresKey.Value) or player.Backpack:FindFirstChild(Porta.RequiresKey.Value) then
				GUI.InteractionMenu.Porta.Lock.Visible = true
			end
		end
	end

	else
		GUI.InteractionMenu.Porta.Visible = false
		PortaAtivo = false
		GUI.InteractionMenu.Porta.Abrir.Visible = false
		GUI.InteractionMenu.Porta.Lock.Visible = false
		GUI.InteractionMenu.Porta.Lockpick.Visible = false
		GUI.InteractionMenu.Porta.Breach.Visible = false
		sla.Parent = nil
	end

if Yeet then

		local Raio = Ray.new(Camera.CFrame.Position, Camera.CFrame.LookVector * 6)
		local Hit, Pos = workspace:FindPartOnRayWithIgnoreList(Raio, IgnoreList, false, true)

		if not Arrastando then
			GUI.InteractionMenu.Arrastar.Botao.Text = "Drag"
		else
			GUI.InteractionMenu.Arrastar.Botao.Text = "Release"
		end

		if Hit then
			local FoundHuman,VitimaHuman = CheckForHumanoid(Hit)
			if FoundHuman == true and VitimaHuman.Health > 0 and game.Players:FindFirstChild(VitimaHuman.Parent.Name) then
				GUI.InteractionMenu.Ombro.Visible = true
				Target = VitimaHuman.Parent.Name
				if TratarCheck then
					GUI.InteractionMenu.Tratar.OutroTratar.Visible = true
					GUI.InteractionMenu.Tratar.OutroTratar.Text = VitimaHuman.Parent.Name
				end
				if InteragirCheck and VitimaHuman.Parent.Saude.Stances.Rendido.Value == true then
					GUI.InteractionMenu.Interagir.Liberar.Visible = true
					GUI.InteractionMenu.Interagir.Revistar.Visible = true
				end
			if VitimaHuman.Parent.Saude.Stances.Caido.Value == true or VitimaHuman.Parent.Saude.Stances.Algemado.Value == true and not Arrastando then
				GUI.InteractionMenu.Arrastar.Visible = true
			end
			else
				GUI.InteractionMenu.Tratar.OutroTratar.Visible = false
				GUI.InteractionMenu.Ombro.Visible = false
				GUI.InteractionMenu.Interagir.Liberar.Visible = false
				GUI.InteractionMenu.Interagir.Revistar.Visible = false
				if not Arrastando then
				GUI.InteractionMenu.Arrastar.Visible = false
				end
				Target = nil
			end
		else
			GUI.InteractionMenu.Tratar.OutroTratar.Visible = false
		 	GUI.InteractionMenu.Ombro.Visible = false
			GUI.InteractionMenu.Interagir.Liberar.Visible = false
			GUI.InteractionMenu.Interagir.Revistar.Visible = false
			if not Arrastando then
			GUI.InteractionMenu.Arrastar.Visible = false
			end
			Target = nil
		end
	end

	if Yeet and (Char.Saude.Stances.Can_Rappel.Value == true or Char.Saude.Stances.Rappeling.Value == true) then

	if Char.Saude.Stances.Rappeling.Value == true then
		GUI.InteractionMenu.Rappel.Visible = true
	else
		local Raio = Ray.new(Camera.CFrame.Position, Camera.CFrame.LookVector * 12)
			local Hit, Pos = workspace:FindPartOnRayWithIgnoreList(Raio, IgnoreList, false, true)

			if Hit then
				GUI.InteractionMenu.Rappel.Visible = true
			else
				GUI.InteractionMenu.Rappel.Visible = false	
			end
		end
	else
		GUI.InteractionMenu.Rappel.Visible = false	
	end

end)

local function onMouseMove()
	local positionX = mouse.X
	local positionY = mouse.Y
	interactionmouse.Position =UDim2.new(0,positionX,0,positionY)
end
mouse.Move:Connect(onMouseMove)

Evt.Ombro.OnClientEvent:Connect(function(Nome)
	TextoOmbro.Text = Nome .." tapped your shoulder"
	TextoOmbro.TextTransparency = 0
	TextoOmbro.TextStrokeTransparency = 0
	ts(TextoOmbro, TweenInfo.new(5), {TextTransparency = 1,TextStrokeTransparency = 1} ):Play()
end)