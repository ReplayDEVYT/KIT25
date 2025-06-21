-- place this LocalScript into your thirst ScreenGui
local Engine = game.ReplicatedStorage:WaitForChild("ACS_Engine")
local ServerConfig = require(Engine.ServerConfigs:WaitForChild("Config"))

local thirstGui = script.Parent
local MedicSys = game.ReplicatedStorage.ACS_Engine.Eventos.MedSys
--local Text = thirstGui:WaitForChild("Back"):WaitForchild("Text")
local plr = game.Players.LocalPlayer

repeat wait() until plr.Character -- waiting for player to load

local UIS = game:GetService("UserInputService")
local hum = plr.Character:WaitForChild("Humanoid")

local hungerValue = plr:WaitForChild("HungerVal")
local thirstValue = plr:WaitForChild("ThirstVal")
local Frame = thirstGui.Frame

local Warp = require(game:GetService("ReplicatedStorage").Warp);

local ReplicateClient = {
	DamageClient = Warp.Client("Damage")
}

local ts = require(game.ReplicatedStorage.TService)

thirstValue.Changed:connect(function()
	if thirstValue.Value > 60 then
		ts(Frame.Sede,TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{ImageColor3 = Color3.fromRGB(255,255,255),ImageTransparency = 1}):Play()
	elseif thirstValue.Value <= 0 then
		MedicSys.Fome:FireServer()
		print("pls drink")
	elseif thirstValue.Value <= 30 then
		ts(Frame.Sede,TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{ImageColor3 = Color3.fromRGB(255,((thirstValue.Value/30)*255),((thirstValue.Value/60)*255)),ImageTransparency = 0.5}):Play()
	elseif thirstValue.Value <= 60 then
		ts(Frame.Sede,TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{ImageColor3 = Color3.fromRGB(255,255,((thirstValue.Value/60)*255)),ImageTransparency = 0.5}):Play()
	end
end)


hungerValue.Changed:connect(function()

	if hungerValue.Value > 60 then
		ts(Frame.Fome,TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{ImageColor3 = Color3.fromRGB(255,255,255),ImageTransparency = 1}):Play()
	elseif hungerValue.Value <= 0 then
		MedicSys.Fome:FireServer()
		print("pls food")
	elseif hungerValue.Value <= 30 then
		ts(Frame.Fome,TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{ImageColor3 = Color3.fromRGB(255,((hungerValue.Value/30)*255),((hungerValue.Value/60)*255)),ImageTransparency = 0.5}):Play()
	elseif hungerValue.Value <= 60 then
		ts(Frame.Fome,TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{ImageColor3 = Color3.fromRGB(255,255,((hungerValue.Value/60)*255)),ImageTransparency = 0.5}):Play()
	end
end)

-- actual effect handling
local Evt = game.ReplicatedStorage.ACS_Engine.Eventos
local Human = plr.Character.Humanoid

thirstValue.Changed:connect(function()
	if thirstValue.Value <= 0 then
		task.delay(50, function()
			if thirstValue.Value <= 0 then
				plr.PlayerGui.bodyPart.Limbs.Status.Dehydrated.Visible = true
				plr.Character.Saude.Variaveis.Dor.Value += 50
				repeat
					ReplicateClient.DamageClient:Fire(true,Human,1,0,0,"Right Leg")
					ReplicateClient.DamageClient:Fire(true,Human,1,0,0,"Left Leg")
					ReplicateClient.DamageClient:Fire(true,Human,1,0,0,"Right Arm")
					ReplicateClient.DamageClient:Fire(true,Human,1,0,0,"Left Arm")
					ReplicateClient.DamageClient:Fire(true,Human,1,0,0,"Torso")
					ReplicateClient.DamageClient:Fire(true,Human,1,0,0,"Stomach")
					ReplicateClient.DamageClient:Fire(true,Human,1,0,0,"Head")
					task.wait(15)
				until thirstValue.Value > 0
				print("no longer dehydrated")
				plr.Character.Saude.Variaveis.Dor.Value -= 50
				plr.PlayerGui.bodyPart.Limbs.Status.Dehydrated.Visible = false
			else
				print("player isnt dehydrated after 2nd check, so nvm")
			end
		end)
	end
end)


hungerValue.Changed:connect(function()
	if hungerValue.Value <= 0 then
		task.delay(30, function()
			if hungerValue.Value <= 0 then
				plr.PlayerGui.bodyPart.Limbs.Status.Exhausted.Visible = true
				local tween = TweenInfo.new(
					5,
					Enum.EasingStyle.Sine,
					Enum.EasingDirection.InOut,
					-1,
					true
				)
				
				local exhaustionfade = game:GetService("TweenService"):Create(plr.PlayerGui.Vignette.Exhaustion, tween, { ImageTransparency = 0 })
				exhaustionfade:Play()
				
				repeat
					ReplicateClient.DamageClient:Fire(true,Human,1,0,0,"Right Leg")
					ReplicateClient.DamageClient:Fire(true,Human,1,0,0,"Left Leg")
					ReplicateClient.DamageClient:Fire(true,Human,1,0,0,"Right Arm")
					ReplicateClient.DamageClient:Fire(true,Human,1,0,0,"Left Arm")
					ReplicateClient.DamageClient:Fire(true,Human,1,0,0,"Torso")
					ReplicateClient.DamageClient:Fire(true,Human,1,0,0,"Stomach")
					ReplicateClient.DamageClient:Fire(true,Human,1,0,0,"Head")
					task.wait(5)
				until hungerValue.Value > 0
				print("no longer hungry")
				plr.PlayerGui.bodyPart.Limbs.Status.Exhausted.Visible = false
				exhaustionfade:Pause()
				
				tween = TweenInfo.new(
					5,
					Enum.EasingStyle.Sine,
					Enum.EasingDirection.InOut,
					0,
					false
				)
				
				game:GetService("TweenService"):Create(plr.PlayerGui.Vignette.Exhaustion, tween, { ImageTransparency = 1 }):Play()
			else
				print("player isnt hungry after 2nd check, so nvm")
			end
		end)
	end
end)