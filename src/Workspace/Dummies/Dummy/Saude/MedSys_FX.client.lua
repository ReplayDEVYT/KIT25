local SKP_1 = game.ReplicatedStorage.ACS_Engine.Eventos
local SKP_2 = game.Players.LocalPlayer
local SKP_3 = game:GetService("RunService")
local MD = game.ReplicatedStorage:WaitForChild("ACS_Engine")
local SKP_4 = MD.Eventos.MedSys
local SKP_5 = {"342190005"; "342190012"; "342190017"; "342190024";} -- Bullet Whizz
local SKP_00 = require(game.ReplicatedStorage.ACS_Engine.ServerConfigs:WaitForChild("Config"))
game.Workspace.CurrentCamera:ClearAllChildren()
local PKevent = SKP_1.MedSys.PainKiller
local SKP_6 = game:GetService("StarterGui")
SKP_6:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, SKP_00.CoreGuiPlayerList)
SKP_2.PlayerGui:SetTopbarTransparency(SKP_00.TopBarTransparency)
SKP_6:SetCoreGuiEnabled(Enum.CoreGuiType.Health,SKP_00.CoreGuiHealth)
local SKP_7 = script.Parent.Parent.Humanoid
local Character = script.Parent.Parent
if game.Workspace.CurrentCamera:FindFirstChild("BS") == nil then
	local SKP_8 = Instance.new("ColorCorrectionEffect")
	local wait = task.wait -- just to have better compatibility with new task sys
	SKP_8.Parent = game.Workspace.CurrentCamera
	SKP_8.Name = "BS"
end
local deb = false

cameraShaker = require(game.ReplicatedStorage.CameraShaker)
shakeFrame = CFrame.new()
Camera = workspace.CurrentCamera

camShake = cameraShaker.new(Enum.RenderPriority.Camera.Value, function(shakeCFrame)
	Camera.CFrame = Camera.CFrame * shakeCFrame
	shakeFrame = shakeCFrame
end)

if game.Workspace.CurrentCamera:FindFirstChild("BO") == nil then
	local SKP_8 = Instance.new("ColorCorrectionEffect")
	SKP_8.Parent = game.Workspace.CurrentCamera
	SKP_8.Name = "BO"
	SKP_8.Brightness = -5
end

if game.Workspace.CurrentCamera:FindFirstChild("PKE") == nil then
	local SKP_PKE = Instance.new("ColorCorrectionEffect")
	SKP_PKE.Parent = game.Workspace.CurrentCamera
	SKP_PKE.Name = "PKE"
end

if game.Workspace.CurrentCamera:FindFirstChild("DorFX") == nil then
	local SKP_9 = Instance.new("BlurEffect")
	SKP_9.Parent = game.Workspace.CurrentCamera
	SKP_9.Name = "DorFX"
end

if game.Workspace.CurrentCamera:FindFirstChild("Flinch") == nil then
	local SKP_9 = Instance.new("BlurEffect")
	SKP_9.Parent = game.Workspace.CurrentCamera
	SKP_9.Name = "Flinch"
end

local SKP_10 = game:GetService("TweenService")
local SKP_11 = game:GetService("Debris")


local SKP_12 = game.Workspace.CurrentCamera.BS
local SKP_13 = game.Workspace.CurrentCamera.BO
local SKP_14 = game.Workspace.CurrentCamera.DorFX
local SKP_Flinch = game.Workspace.CurrentCamera.Flinch
local SKP_PK = game.Workspace.CurrentCamera.PKE

SKP_12.Saturation	= 0
local Tween = SKP_10:Create(SKP_12,TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{Contrast = 0}):Play()
local Tween = SKP_10:Create(SKP_13,TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{Brightness = 0}):Play()
SKP_13.Saturation 	= 0
SKP_Flinch.Size 	= 0
local Tween = SKP_10:Create(SKP_14,TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.In,0,false,0),{Size = 0}):Play()
SKP_12.TintColor 		= Color3.new(1,1,1)
SKP_13.TintColor 	= Color3.new(1,1,1)

SKP_6:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack,true)
--SKP_6:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList,true)
local SKP_15 = script.Parent
local stances = SKP_15:WaitForChild("Stances")
local SKP_16 = stances.Caido
local SKP_17 = SKP_15.Variaveis.Sangue
local SKP_18 = SKP_15.Variaveis.Dor
local Morto = false
local soundDeb = false

if SKP_2.PlayerGui:FindFirstChild("stun1") then
	SKP_2.PlayerGui:FindFirstChild("stun1"):Destroy()
end


local SKP_19 = true
local SKP_20 = SKP_7.Health
local SKP_21 = 0
--SKP_7:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
local effects = SKP_2.PlayerGui:WaitForChild("StatusUI").Efeitos
effects.Blackout.ImageTransparency = 1

PKevent.OnClientEvent:connect(function(val)
	if SKP_7.Health > 0 then
		if val == true then
			SKP_10:Create(SKP_PK,TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{Contrast = 0.25,Saturation = 0.25}):Play()
			SKP_15.Stances.PK.Value = true
		else
			SKP_10:Create(SKP_PK,TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{Contrast = 0,Saturation = 0}):Play()
			SKP_15.Stances.PK.Value = false
		end
	end
end)

SKP_7.Changed:Connect(function(Health)
	local Valor = SKP_15.Variaveis.Sangue
	if SKP_7.Health <= (SKP_7.MaxHealth*0.5) and SKP_7.Health > (SKP_7.MaxHealth*0.25) then
		SKP_1.HalfHP:FireServer(SKP_2,SKP_7)
		--local number2 = math.random(1,3)
		--if SKP_7.Character:FindFirstChild("Head").Sound6 ~= nil then
		--SKP_7.Parent:FindFirstChild("Head")["Sound"..number2]:Play()
		--wait(SKP_7.Parent:FindFirstChild("Head")["Sound"..number2].TimeLength+1)
	end
	if SKP_7.Health <= (SKP_7.MaxHealth*0.25) and SKP_7.Health > 0 then
		SKP_1.QuarterHP:FireServer(SKP_2,SKP_7)
		--local number2 = math.random(4,6)
		--if SKP_7.Character:FindFirstChild("Head").Sound6 ~= nil then
		--SKP_7.Parent:FindFirstChild("Head")["Sound"..number2]:Play()
		--wait(SKP_7.Parent:FindFirstChild("Head")["Sound"..number2].TimeLength+1)
	end
	if Valor.Value <= 0 and SKP_15.Stances.Sangrando.Value == true and deb == false then
		deb = true
		local saude = SKP_15
		local Evt = SKP_1
		local Human = SKP_7
		task.wait(math.random(50,100)/10)
		Evt.Damage:FireServer(Human,0.5,0,0,"Right Leg")
		Evt.Damage:FireServer(Human,0.5,0,0,"Left Leg")
		Evt.Damage:FireServer(Human,0.5,0,0,"Right Arm")
		Evt.Damage:FireServer(Human,0.5,0,0,"Left Arm")
		Evt.Damage:FireServer(Human,0.5,0,0,"Torso")
		Evt.Damage:FireServer(Human,0.5,0,0,"Head")
		task.wait(math.random(50,100)/10)
		deb = false
	end
	if SKP_7.Health < SKP_20 and SKP_7.Health > 0 and SKP_7.Health <= (SKP_20 - 20) then

		local Hurt = ((SKP_7.Health/SKP_20) - 1) * -1
		--[[local rand = math.random(1,4)
		if script.Parent.Parent:FindFirstChild('Head') and soundDeb == false then
			soundDeb = true
			script.Parent.Parent:WaitForChild("Head")["Hit"..rand].PlaybackSpeed = (math.random(95,105)/100)
			script.Parent.Parent:WaitForChild("Head")["Hit"..rand]:Play()
			wait(script.Parent.Parent:WaitForChild("Head")["Hit"..rand].TimeLength + 0.5)
			soundDeb = false
		end]]--

		local SKP_23 = script.FX.ColorCorrection:clone()
		SKP_23.Parent = game.Workspace.CurrentCamera

		--SKP_23.TintColor 	= Color3.new(1,(math.ceil(SKP_7.Health/2)/math.ceil(SKP_20)),(math.ceil(SKP_7.Health/2)/math.ceil(SKP_20)))
		local number = math.random(4)
		--SKP_12.Contrast	= SKP_12.Contrast + 0.5 * Hurt
		--SKP_12.Brightness = SKP_12.Brightness - 0.1 * Hurt
		SKP_Flinch.Size	= SKP_Flinch.Size + 5 * Hurt
		--effects["impact"..number]:Play()
		--effects.EarRing:Play()
		--SKP_10:Create(SKP_12,TweenInfo.new(1,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut,0,false,0),{Contrast = 0}):Play()
		--SKP_10:Create(SKP_12,TweenInfo.new(1,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut,0,false,0),{Brightness = 0}):Play()
		SKP_10:Create(SKP_Flinch,TweenInfo.new(1,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut,0,false,0),{Size = 0}):Play()
		--SKP_10:Create(SKP_23,TweenInfo.new(2.5 * Hurt,Enum.EasingStyle.Sine,Enum.EasingDirection.In,0,false,0),{TintColor = Color3.new(1,1,1)}):Play()

		--local BloodDecals = {"76226090";"547029774";}
		--[[if script.Parent.Parent.Humanoid.Health < SKP_20 - (SKP_00.BleedDamage) or script.Parent.Stances.Sangrado.Value == true then
			local bloodnumb = math.random(1,3)
			wait(bloodnumb)
			if SKP_2.PlayerGui:findFirstChild("StatusUI").Efeitos["Blood"..bloodnumb].ImageTransparency == 1 then
			SKP_2.PlayerGui:findFirstChild("StatusUI").Efeitos["Blood"..bloodnumb].ImageTransparency = 0
			SKP_2.PlayerGui:findFirstChild("StatusUI").Efeitos["Blood"..bloodnumb].Size = UDim2.new(0.4,0,1,0)
			SKP_10:Create(SKP_2.PlayerGui:findFirstChild("StatusUI").Efeitos["Blood"..bloodnumb],TweenInfo.new(0.35,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut,0,false,0),{ImageTransparency = 1,Size = UDim2.new(0.4,0,2,0)}):Play()
				wait(1)
			end
			end]]--
		SKP_11:AddItem(SKP_23, 2.5 * Hurt)
	end

	SKP_20 = SKP_7.Health
end)

local SKP_24 = false

SKP_15.Variaveis.Dor.Changed:Connect(function(Valor)

end)

SKP_15.Variaveis.Stamina.Changed:Connect(function()
	local saude = SKP_15
	local Evt = SKP_1
	if saude.Variaveis.Stamina.Value <= (saude.Variaveis.Stamina.MaxValue/4) then
		Evt.Stamina:FireServer(saude.Variaveis.Stamina,Character)
	end
end)
local ra = Random.new()

local function GetRandomPosition()
	return UDim2.new(ra:NextNumber(0,1),0,ra:NextNumber(0,1),0)
end

function GenerateBlood()
	print('blud')
	local num = math.random(3,4)
	for i = 1,num do
		ra = Random.new()
		num = num - 1
		local bloodnumb = math.random(2,3)
		--if SKP_15.Stances.Sangrando.Value == true then
		local gui = SKP_2.PlayerGui:findFirstChild("StatusUI").Efeitos
		local drop = gui:FindFirstChild('Drop'):Clone()
		drop.Name = "usedDrop"
		drop.Parent = gui
		local pos = GetRandomPosition()
		local mult = math.random(1,1.2)
		local mult2 = math.random(1,1.2)
		--if pos then
		drop.Position = pos
		drop.Size = UDim2.new(0.1*mult,0,0.2*mult2,0)
		drop.Visible = true
		SKP_10:Create(drop,TweenInfo.new(bloodnumb*1.5,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut,0,false,0),{ImageTransparency = 1}):Play()

		--end

		--end
		game:GetService('Debris'):AddItem(drop,bloodnumb*1.5)
		wait(bloodnumb*0.8)
	end
	print('done')
end

function GenerateBloodGroup()
	print('blud')
	local num = math.random(3,4)
	for i = 1,num do
		ra = Random.new()
		num = num - 1
		local bloodnumb = math.random(2,3)
		--if SKP_15.Stances.Sangrando.Value == true then
		local gui = SKP_2.PlayerGui:findFirstChild("StatusUI").Efeitos
		local drop = gui:FindFirstChild('Drop'):Clone()
		drop.Name = "usedDrop"
		drop.Parent = gui
		local pos = GetRandomPosition()
		local mult = math.random(1,1.2)
		local mult2 = math.random(1,1.2)
		--if pos then
		drop.Position = pos
		drop.Size = UDim2.new(0.1*mult,0,0.2*mult2,0)
		drop.Visible = true
		SKP_10:Create(drop,TweenInfo.new(bloodnumb*1.5,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut,0,false,0),{ImageTransparency = 1}):Play()

		--end

		--end
		game:GetService('Debris'):AddItem(drop,bloodnumb*1.5)
		wait(bloodnumb*0.03)
	end
	print('done')
end

function GenerateVisorCrack()
	print('cracked')
	ra = Random.new()
	--if SKP_15.Stances.Sangrando.Value == true then

	local gui = SKP_2.PlayerGui:findFirstChild("VisorUI").CrackParent
	local crack = gui:FindFirstChild('Crack'):Clone()

	crack.Name = "visorCrack"
	crack.Parent = gui

	local pos = GetRandomPosition()
	local mult = math.random(1,1.2)
	local mult2 = math.random(1,1.2)
	--if pos then

	crack.Position = pos
	crack.Size = UDim2.new(0.7*mult,0,0.9*mult2,0)
	crack.Rotation = math.random(-180,180)
	crack.ImageTransparency = 0.2
	crack.Visible = true

	--end
	--end
	print('done')
	-- local random = math.random(1,4)
	-- Character.Head.VisorSounds["VisorHitFP"..random]:Play()
end

SKP_1.Armor.ChangeVisorDurb.OnClientEvent:Connect(function()
	GenerateVisorCrack()
	camShake:Start()
	camShake:ShakeOnce(3, 1, 0, 1)
end)


SKP_17.Changed:Connect(function(Valor)
	if Valor >= SKP_17.MaxValue/2 then
		--SKP_12.Saturation	= ((Valor*2)/SKP_17.MaxValue) - 2
		--SKP_2.PlayerGui:findFirstChild("StatusUI").Efeitos.Blackout.ImageTransparency = ((Valor*2)/SKP_17.MaxValue) - 1
		--[[local bloodnumb = math.random(1,3)
		wait(bloodnumb*1.5)
		if SKP_2.PlayerGui:findFirstChild("StatusUI").Efeitos["Blood"..bloodnumb].ImageTransparency == 1 then
			SKP_2.PlayerGui:findFirstChild("StatusUI").Efeitos["Blood"..bloodnumb].ImageTransparency = 0.73
			SKP_2.PlayerGui:findFirstChild("StatusUI").Efeitos["Blood"..bloodnumb].Size = UDim2.new(0.4,0,1,0)
			SKP_10:Create(SKP_2.PlayerGui:findFirstChild("StatusUI").Efeitos["Blood"..bloodnumb],TweenInfo.new(1,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut,0,false,0),{ImageTransparency = 1,Size = UDim2.new(0.4,0,2,0)}):Play()
			wait(2)
		end]]--
		if Valor <= 0 and SKP_15.Stances.Sangrando.Value == true and deb == false then

			if SKP_15.Variaveis.HeavyBleed.Value == false then
				deb = true

				local saude = SKP_15
				local Evt = SKP_1
				local Human = SKP_7
				wait(math.random(50,100)/10)
				Evt.Damage:FireServer(Human,0.25,0,0,"Right Leg")
				Evt.Damage:FireServer(Human,0.25,0,0,"Left Leg")
				Evt.Damage:FireServer(Human,0.25,0,0,"Right Arm")
				Evt.Damage:FireServer(Human,0.25,0,0,"Left Arm")
				Evt.Damage:FireServer(Human,0.25,0,0,"Torso")
				Evt.Damage:FireServer(Human,0.25,0,0,"Stomach")
				Evt.Damage:FireServer(Human,0.25,0,0,"Head")
				GenerateBlood()
				wait(math.random(50,100)/10)
				deb = false
			else
				deb = true
				local saude = SKP_15
				local Evt = SKP_1
				local Human = SKP_7
				wait(math.random(20,50)/20)
				Evt.Damage:FireServer(Human,0.75,0,0,"Right Leg")
				Evt.Damage:FireServer(Human,0.75,0,0,"Left Leg")
				Evt.Damage:FireServer(Human,0.75,0,0,"Right Arm")
				Evt.Damage:FireServer(Human,0.75,0,0,"Left Arm")
				Evt.Damage:FireServer(Human,0.75,0,0,"Torso")
				Evt.Damage:FireServer(Human,0.75,0,0,"Stomach")
				Evt.Damage:FireServer(Human,0.75,0,0,"Head")
				GenerateBloodGroup()
				wait(math.random(20,50)/20)
				deb = false
			end

		end

		wait(10)
	elseif Valor < SKP_17.MaxValue/2 then
		--SKP_12.Saturation = -1
		--SKP_2.PlayerGui:findFirstChild("StatusUI").Efeitos.Blackout.ImageTransparency = 0
		--[[local bloodnumb = math.random(1,3)
		wait(bloodnumb*1.5)
		if SKP_2.PlayerGui:findFirstChild("StatusUI").Efeitos["Blood"..bloodnumb].ImageTransparency == 1 then
			SKP_2.PlayerGui:findFirstChild("StatusUI").Efeitos["Blood"..bloodnumb].ImageTransparency = 0.73
			SKP_2.PlayerGui:findFirstChild("StatusUI").Efeitos["Blood"..bloodnumb].Size = UDim2.new(0.4,0,1,0)
			SKP_10:Create(SKP_2.PlayerGui:findFirstChild("StatusUI").Efeitos["Blood"..bloodnumb],TweenInfo.new(1,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut,0,false,0),{ImageTransparency = 1,Size = UDim2.new(0.4,0,2,0)}):Play()
			wait(2)
		end]]--
		if Valor <= 0 and SKP_15.Stances.Sangrando.Value == true and deb == false then
			deb = true
			local saude = SKP_15
			local Evt = SKP_1
			local Human = SKP_7
			wait(math.random(50,100)/10)
			Evt.Damage:FireServer(Human,0.25,0,0,"Right Leg")
			Evt.Damage:FireServer(Human,0.25,0,0,"Left Leg")
			Evt.Damage:FireServer(Human,0.25,0,0,"Right Arm")
			Evt.Damage:FireServer(Human,0.25,0,0,"Left Arm")
			Evt.Damage:FireServer(Human,0.25,0,0,"Torso")
			Evt.Damage:FireServer(Human,0.25,0,0,"Stomach")
			Evt.Damage:FireServer(Human,0.25,0,0,"Head")
			GenerateBlood()
			wait(math.random(50,100)/10)
			deb = false
		end
		wait(10)
	elseif Valor <= 0 then
		SKP_12.Saturation = -1
		--SKP_2.PlayerGui:findFirstChild("StatusUI").Efeitos.Blackout.ImageTransparency = 0
		--[[local bloodnumb = math.random(1,3)
		wait(bloodnumb*1.5)
		if SKP_2.PlayerGui:findFirstChild("StatusUI").Efeitos["Blood"..bloodnumb].ImageTransparency == 1 then
			SKP_2.PlayerGui:findFirstChild("StatusUI").Efeitos["Blood"..bloodnumb].ImageTransparency = 0.73
			SKP_2.PlayerGui:findFirstChild("StatusUI").Efeitos["Blood"..bloodnumb].Size = UDim2.new(0.4,0,1,0)
			SKP_10:Create(SKP_2.PlayerGui:findFirstChild("StatusUI").Efeitos["Blood"..bloodnumb],TweenInfo.new(1,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut,0,false,0),{ImageTransparency = 1,Size = UDim2.new(0.4,0,2,0)}):Play()
			wait(2)
		end]]--
		if Valor <= 0 and SKP_15.Stances.Sangrando.Value == true and deb == false then
			deb = true
			local saude = SKP_15
			local Evt = SKP_1
			local Human = SKP_7
			wait(math.random(50,100)/10)
			Evt.Damage:FireServer(Human,0.25,0,0,"Right Leg")
			Evt.Damage:FireServer(Human,0.25,0,0,"Left Leg")
			Evt.Damage:FireServer(Human,0.25,0,0,"Right Arm")
			Evt.Damage:FireServer(Human,0.25,0,0,"Left Arm")
			Evt.Damage:FireServer(Human,0.25,0,0,"Torso")
			Evt.Damage:FireServer(Human,0.25,0,0,"Stomach")
			Evt.Damage:FireServer(Human,0.25,0,0,"Head")
			GenerateBlood()
			wait(math.random(50,100)/10)
			deb = false
		end
		wait(10)
		if SKP_7.Health <= 0 then
			SKP_2.PlayerGui:findFirstChild("StatusUI").Efeitos.Blackout.ImageTransparency = 1
			SKP_2.PlayerGui:findFirstChild("StatusUI").Efeitos.Blackout.Visible = false
		end
	end
	if SKP_7.Health <= 0 then
		SKP_2.PlayerGui:findFirstChild("StatusUI").Efeitos.Blackout.ImageTransparency = 1
		SKP_2.PlayerGui:findFirstChild("StatusUI").Efeitos.Blackout.Visible = false
	end
end)

SKP_15.Variaveis.HitCount.Changed:Connect(function(Valor)
	if Valor >= 3 then
		SKP_4.Render:FireServer(true,"N/A")
	end
end)

SKP_16.Changed:Connect(function(Valor)
	if Valor == true then
		SKP_13.Brightness = 0
	else
		SKP_13.Brightness = 0
		SKP_17.Value = SKP_17.Value + 1
	end
end)

SKP_7.Died:Connect(function()

	Morto = true

	SKP_7.AutoRotate = false

	SKP_13.TintColor = Color3.new(1,1,1)

	--SKP_13.Brightness = 0

	SKP_12.Saturation = 0

	SKP_12.Contrast = 0

	SKP_14.Size = 0

	SKP_12.Saturation = 0

	SKP_12.Contrast = 0

	SKP_15.Variaveis.Dor.Value = 0

	SKP_Flinch.Size = 12
	SKP_2.PlayerGui:findFirstChild("StatusUI").Efeitos.Blackout.ImageTransparency = 1
	SKP_2.PlayerGui:findFirstChild("StatusUI").Efeitos.Blackout.Visible = false
	SKP_2.PlayerGui:findFirstChild("StatusUI").Enabled = false
	if SKP_2.PlayerGui:findFirstChild("Inventory") then
		SKP_2.PlayerGui:findFirstChild("Inventory").Enabled = false
	end
	SKP_10:Create(SKP_PK,TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{Contrast = 0,Saturation = 0}):Play()
	SKP_10:Create(SKP_Flinch,TweenInfo.new(4,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut,0,false,0),{Size = 24}):Play()
	SKP_15.Stances.PK.Value = false
	SKP_6:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack,false)
	SKP_6:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList,false)
	if SKP_19 == true then
		delay(3.5,function()
			if SKP_2.PlayerGui:FindFirstChild("Vignette") then
				SKP_10:Create(SKP_2.PlayerGui:FindFirstChild("Vignette").Death,TweenInfo.new(game.Players.RespawnTime/12,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut,0,false,0),{ImageTransparency = 0}):Play()
			end
			Tween = SKP_10:Create(SKP_13,TweenInfo.new(game.Players.RespawnTime/8,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut,0,false,0),{Brightness = 0, Contrast = 0,TintColor = Color3.new(0,0,0)}):Play()
		end)
	end	

end)


local SKP_25 = script.Parent.Parent.Humanoid
local SKP_26 = game.ReplicatedStorage.ACS_Engine.Eventos.MedSys.Collapse

function onChanged()
	SKP_26:FireServer()
	if (SKP_17.Value <= 3500) or (SKP_18.Value >= 200)  or (SKP_16.Value == true) then

	elseif (SKP_17.Value > 3500) and (SKP_18.Value < 200) and SKP_15.Stances.Rendido.Value == false then -- YAY A MEDIC ARRIVED! =D
		--SKP_6:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack,true)
		SKP_16.Value = false
	end
end

onChanged()

SKP_17.Changed:Connect(onChanged)
SKP_18.Changed:Connect(onChanged)
SKP_16.Changed:Connect(onChanged)

SKP_15.Stances.Rendido.Changed:Connect(function(Valor)
	if Valor == true then
		SKP_25:UnequipTools()
		SKP_6:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack,false)
	else
		--SKP_6:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack,true)
	end
end)

local RS = game:GetService("RunService")
RS.RenderStepped:connect(function(Update)
	if Character.Name ~= "lootBag" and Character.Name ~= SKP_2.Name.."'s dead body" and Character:FindFirstChild("Humanoid") and Character:FindFirstChild("Torso") and Character:FindFirstChild("Head") then
		if Character.Humanoid.Health > 0 and Character:WaitForChild("Head"):WaitForChild("HP").Value > 0 and Character:WaitForChild("Torso"):WaitForChild("HP").Value > 0 then
			Character.Humanoid.Health = (Character:WaitForChild("Head"):WaitForChild("HP").Value + Character:WaitForChild("Torso"):WaitForChild("HP").Value + Character:WaitForChild("Stomach"):WaitForChild("HP").Value + Character:WaitForChild("Left Arm"):WaitForChild("HP").Value + Character:WaitForChild("Right Arm"):WaitForChild("HP").Value + Character:WaitForChild("Left Leg"):WaitForChild("HP").Value + Character:WaitForChild("Right Leg"):WaitForChild("HP").Value)
		elseif Character:FindFirstChild("Head") ~= nil and Character:WaitForChild("Head"):WaitForChild("HP").Value <= 0 or Character:FindFirstChild("Torso") ~= nil and Character:WaitForChild("Torso"):WaitForChild("HP").Value <= 0 then
			Character.Humanoid.Health = 0
		end
		if Morto then
			if SKP_2.Character:FindFirstChild("Torso") ~= nil then
				SKP_2.Character:FindFirstChild("Right Arm").LocalTransparencyModifier = 0

				SKP_2.Character:FindFirstChild("Left Arm").LocalTransparencyModifier = 0

				SKP_2.Character:FindFirstChild("Right Leg").LocalTransparencyModifier = 0

				SKP_2.Character:FindFirstChild("Left Leg").LocalTransparencyModifier = 0

				SKP_2.Character:FindFirstChild("Torso").LocalTransparencyModifier = 0	

				game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
				game.Workspace.CurrentCamera.CFrame = SKP_15.Parent:WaitForChild('Head').CFrame
			end
		end
	end
end)

while true do
	SKP_10:Create(SKP_14,TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{Size = 0}):Play()
	task.wait(3)
	if SKP_15.Stances.PK.Value == false and SKP_7.Health > 0 and SKP_7.Health < 330 then
		SKP_10:Create(SKP_14,TweenInfo.new(1,Enum.EasingStyle.Elastic,Enum.EasingDirection.InOut,0,false,0),{Size = (SKP_15.Variaveis.Dor.Value/SKP_15.Variaveis.Dor.MaxValue) * 25}):Play()
	else
		SKP_10:Create(SKP_14,TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{Size = 0}):Play()
	end
	task.wait(1)

end