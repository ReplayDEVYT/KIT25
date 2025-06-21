repeat wait() until game.Players.LocalPlayer.Character:IsDescendantOf(game.Workspace)
local cam = game.Workspace.CurrentCamera
local lp = _G.LeanPart
if not lp then
	lp = Instance.new('Part')
	_G.LeanPart = lp
end
lp.CFrame = CFrame.new()
local Player = game.Players.LocalPlayer
local player = game.Players.LocalPlayer
local Character = Player.Character
local char = Player.Character
local Humanoid = Character:WaitForChild("Humanoid")
local Mouse = Player:GetMouse()
local mouse = Player:GetMouse()
local cam = game.Workspace.CurrentCamera
local equip = false
local gun
local anim
local lp2 = _G.FLPart
local speedMult = game:GetService('UserInputService').MouseDeltaSensitivity
local Engine = game.ReplicatedStorage:WaitForChild("ACS_Engine")
local PastaFX = Engine:WaitForChild("FX")
local Evt = Engine:WaitForChild("Eventos")
local Mod = Engine:WaitForChild("Modulos")
local Ultil = require(Mod:WaitForChild("Utilities"))
local SpringMod = require(Mod:WaitForChild("Spring"))
local ServerConfig = require(Engine.ServerConfigs:WaitForChild("Config"))
local RunService = game:GetService("RunService")
local ts = require(game.ReplicatedStorage.TService)
local moe = player:GetMouse()
local tor = char:WaitForChild("Torso")
local hum = char:WaitForChild("Humanoid")
local Debris = game:GetService("Debris")
local lastStance = 0
local Camera = game.Workspace.CurrentCamera
local UserInputService = game:GetService("UserInputService")
local ts = require(game.ReplicatedStorage.TService)
local loadedAnimation
local animation
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

local Torso = Character:WaitForChild("Torso")
local Neck = Torso:WaitForChild("Neck")

local Poses = script.Parent.MainFrame.Poses
local Main = script.Parent.MainFrame

local saude = char:WaitForChild("Saude")
local StancesPasta = saude:WaitForChild("Stances")
local Protecao = saude:WaitForChild("Protecao")
local Sangrando = StancesPasta.Sangrando
local Ferido = StancesPasta.Ferido
local Caido = StancesPasta.Caido
local Correndo = StancesPasta.Correndo
local Rendido = StancesPasta.Rendido
local Algemado = StancesPasta.Algemado
local Rappeling = StancesPasta.Rappeling

local Stance = Evt.MedSys.Stance
local Stances = 0
local Virar = 0
local CameraX = 0
local CameraY = 0
local Velocidade = 0
maxAir = 100
air = maxAir
lastHealth = 100
lastHealth2 = 100
CanSprint = true
local Sentado = false
local CanLean = true
local ChangeStance = true
local cansado = false
local Steady = false

_G.SteadyStance = false
_G.LeanR = 0
_G.LeanL = 0
_G.FreeLook = false
local RAW
local LAW


vestPenalty = math.ceil(Protecao.VestVida.Value) * .002
helmPenalty = math.ceil(Protecao.HelmetVida.Value) * .002
----------------
local RootPart = char:WaitForChild("HumanoidRootPart")
local RootJoint = RootPart.RootJoint
--RootJoint.C0 = CFrame.new()
--RootJoint.C1 = CFrame.new()

local Aiming = false

local ZoomDistance = 40

local NV

local L_150_ = {}

local L_153_ = {}
L_153_.cornerPeek = SpringMod.new(0)
L_153_.cornerPeek.d = 0.9
L_153_.cornerPeek.s = 12
L_153_.peekFactor = math.rad(-0.75)
L_153_.dirPeek = 0


----------------

---------------------------------------------------------------------------------------
---------------- [ Tween Module ] --------------------------------------------------------
---------------------------------------------------------------------------------------


--[[
	
	tweenJoint Function Parameters:
	
	Object Joint - This has to be a weld with a C0 and C1 property
	
	CFrame newC0 - This is what the new C0 of the weld will be. You can put nil if you don't want to effect the C0
	
	CFrame newC1 - This is what the new C1 of the weld will be. You can put nil if you don't want to effect the C1
	
	function Alpha - This is an alpha function that takes an input parameter of a number between 0 and 90 and returns a number between 0 and 1.
		For example, function(X) return math.sin(math.rad(X)) end
		
	float Duration - This is how long the tweening takes to complete
	
--]]
local RS = game:GetService("RunService")

local Proned2

Rendido.Changed:Connect(function()
	Stance:FireServer(Stances,Virar,Rendido.Value)
end)

Algemado.Changed:Connect(function()
	Stance:FireServer(Stances,Virar,Rendido.Value)
end)

function TweenWalkSpeed(newvalue)
	vestPenalty = math.ceil(Protecao.VestVida.Value) * .002
	helmPenalty = math.ceil(Protecao.HelmetVida.Value) * .002
	ts(Humanoid,TweenInfo.new(0,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{WalkSpeed = (newvalue - vestPenalty - helmPenalty)}):Play()
end


function Stand()
	speedMult = game:GetService('UserInputService').MouseDeltaSensitivity
	vestPenalty = math.ceil(Protecao.VestVida.Value) * .002
	helmPenalty = math.ceil(Protecao.HelmetVida.Value) * .002


	Stance:FireServer(Stances,Virar,Rendido.Value)	
	if (workspace.CurrentCamera.CFrame.p-workspace.CurrentCamera.Focus.p).Magnitude < 0.8 then
		--		character:FindFirstChild("Humanoid").CameraOffset = Vector3.new(nil,nil,-1)
		ts(Character.Humanoid, TweenInfo.new(.2), {CameraOffset = Vector3.new(CameraX,0,-1)} ):Play()
	else
		--		character:FindFirstChild("Humanoid").CameraOffset = Vector3.new(nil,nil,0)	
		ts(Character.Humanoid, TweenInfo.new(.2), {CameraOffset = Vector3.new(CameraX,0,0)} ):Play()
	end

	if Steady then
		TweenWalkSpeed(ServerConfig.SlowPaceWalkSpeed * StancesPasta.Mobility.Value * speedMult)
		Humanoid.JumpPower = ServerConfig.JumpPower - vestPenalty - helmPenalty
	else
		if  Ferido.Value == false then
			TweenWalkSpeed(ServerConfig.NormalWalkSpeed * StancesPasta.Mobility.Value * speedMult)
			Humanoid.JumpPower = ServerConfig.JumpPower - vestPenalty - helmPenalty
		else
			TweenWalkSpeed(ServerConfig.SlowPaceWalkSpeed * StancesPasta.Mobility.Value * speedMult)
			Humanoid.JumpPower = ServerConfig.JumpPower / 3 - vestPenalty - helmPenalty
		end
	end


	IsStanced = false	
	Proned2 = Vector3.new(0,0,0)
	Main.Poses.StandSFX:Play()

end





function Crouch()
	speedMult = game:GetService('UserInputService').MouseDeltaSensitivity
	vestPenalty = math.ceil(Protecao.VestVida.Value) * .002
	helmPenalty = math.ceil(Protecao.HelmetVida.Value) * .002


	Stance:FireServer(Stances,Virar,Rendido.Value,false)
	if (workspace.CurrentCamera.CFrame.p-workspace.CurrentCamera.Focus.p).Magnitude < 0.8 then
		--		ts(character.Humanoid, TweenInfo.new(.3), {CameraOffset = Vector3.new(CameraX,CameraY+CameraYLean,val)} ):Play()
		ts(Character.Humanoid, TweenInfo.new(.4,Enum.EasingStyle.Back,Enum.EasingDirection.InOut), {CameraOffset = Vector3.new(CameraX,CameraY,-1)} ):Play()
	else
		--		ts(character.Humanoid, TweenInfo.new(.3), {CameraOffset = Vector3.new(CameraX,CameraY+CameraYLean,0)} ):Play()
		ts(Character.Humanoid, TweenInfo.new(.4,Enum.EasingStyle.Back,Enum.EasingDirection.InOut), {CameraOffset = Vector3.new(CameraX,CameraY,0)} ):Play()
	end
	if Steady then
		TweenWalkSpeed(ServerConfig.ProneWalkSpeed * StancesPasta.Mobility.Value * speedMult)
		Humanoid.JumpPower = 0
	elseif not Steady then
		if  Ferido.Value == false then
			TweenWalkSpeed(ServerConfig.CrouchWalkSpeed * StancesPasta.Mobility.Value * speedMult)
			Humanoid.JumpPower = 0
		else
			TweenWalkSpeed(ServerConfig.ProneWalkSpeed * StancesPasta.Mobility.Value * speedMult)
			Humanoid.JumpPower = 0
		end
	end
	IsStanced = true	
	Proned2 = Vector3.new(0,0,0)
	Main.Poses.CrouchSFX:Play()
end

function Prone()
	speedMult = game:GetService('UserInputService').MouseDeltaSensitivity
	vestPenalty = math.ceil(Protecao.VestVida.Value) * .002
	helmPenalty = math.ceil(Protecao.HelmetVida.Value) * .002



	Stance:FireServer(Stances,Virar,Rendido.Value,false)
	ts(char.Humanoid, TweenInfo.new(.3,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut), {CameraOffset = Vector3.new(CameraX,CameraY,0)} ):Play()
	if Rendido.Value == true then
		Humanoid.WalkSpeed = 0
		--		ts(character.Humanoid, TweenInfo.new(.7), {CameraOffset = Vector3.new(CameraX,CameraY+CameraYLean,0)} ):Play()
		ts(Character.Humanoid, TweenInfo.new(.5), {CameraOffset = Vector3.new(CameraX,-3.5,-1)} ):Play()
	else
		--Humanoid.WalkSpeed = ServerConfig.ProneWalkSpeed * StancesPasta.Mobility.Value
		TweenWalkSpeed(ServerConfig.ProneWalkSpeed * StancesPasta.Mobility.Value * speedMult)
		--		ts(character.Humanoid, TweenInfo.new(.7,Enum.EasingStyle.Quint,Enum.EasingDirection.Out), {CameraOffset = Vector3.new(CameraX,CameraY+CameraYLean,0)} ):Play()
		ts(Character.Humanoid, TweenInfo.new(.5), {CameraOffset = Vector3.new(CameraX,-3.5,-1)} ):Play()
	end
	Humanoid.JumpPower = 0 
	IsStanced = true
	Proned2 = Vector3.new(0,0.5,0.5)
	Main.Poses.ProneSFX:Play()
end

function Slide()
	speedMult = game:GetService('UserInputService').MouseDeltaSensitivity
	vestPenalty = math.ceil(Protecao.VestVida.Value) * .002
	helmPenalty = math.ceil(Protecao.HelmetVida.Value) * .002
	local Controls = require(Player.PlayerScripts.PlayerModule):GetControls()


	Stance:FireServer(Stances,Virar,Rendido.Value,true)
	Controls:Disable()
	task.delay(0.1, function()
		Controls:Enable()
	end)
	if (workspace.CurrentCamera.CFrame.p-workspace.CurrentCamera.Focus.p).Magnitude < 0.8 then
		--		ts(character.Humanoid, TweenInfo.new(.3), {CameraOffset = Vector3.new(CameraX,CameraY+CameraYLean,val)} ):Play()
		ts(Character.Humanoid, TweenInfo.new(.1), {CameraOffset = Vector3.new(CameraX,CameraY,-1)} ):Play()
	else
		--		ts(character.Humanoid, TweenInfo.new(.3), {CameraOffset = Vector3.new(CameraX,CameraY+CameraYLean,0)} ):Play()
		ts(Character.Humanoid, TweenInfo.new(.1), {CameraOffset = Vector3.new(CameraX,CameraY,0)} ):Play()
	end
	if Steady then
		TweenWalkSpeed(ServerConfig.ProneWalkSpeed * StancesPasta.Mobility.Value * speedMult)
		Humanoid.JumpPower = 0
	elseif not Steady then
		if  Ferido.Value == false then
			TweenWalkSpeed(ServerConfig.CrouchWalkSpeed * StancesPasta.Mobility.Value * speedMult)
			Humanoid.JumpPower = 0
		else
			TweenWalkSpeed(ServerConfig.ProneWalkSpeed * StancesPasta.Mobility.Value * speedMult)
			Humanoid.JumpPower = 0
		end
	end
	IsStanced = true	
	Proned2 = Vector3.new(0,0,0)
	Main.Poses.CrouchSFX:Play()
end

function Dive()
	speedMult = game:GetService('UserInputService').MouseDeltaSensitivity
	vestPenalty = math.ceil(Protecao.VestVida.Value) * .002
	helmPenalty = math.ceil(Protecao.HelmetVida.Value) * .002
	local Controls = require(Player.PlayerScripts.PlayerModule):GetControls()



	Stance:FireServer(Stances,Virar,Rendido.Value,true)
	local camoffset = ts(char.Humanoid, TweenInfo.new(.1), {CameraOffset = Vector3.new(CameraX,CameraY,0)} )
	camoffset:Play()
	Controls:Disable()
	if Rendido.Value == true then
		Humanoid.WalkSpeed = 0
		--		ts(character.Humanoid, TweenInfo.new(.7), {CameraOffset = Vector3.new(CameraX,CameraY+CameraYLean,0)} ):Play()
		ts(Character.Humanoid, TweenInfo.new(.1), {CameraOffset = Vector3.new(CameraX,-3.5,-1)} ):Play()
	else
		--Humanoid.WalkSpeed = ServerConfig.ProneWalkSpeed * StancesPasta.Mobility.Value
		TweenWalkSpeed(ServerConfig.ProneWalkSpeed * StancesPasta.Mobility.Value * speedMult)
		--		ts(character.Humanoid, TweenInfo.new(.7,Enum.EasingStyle.Quint,Enum.EasingDirection.Out), {CameraOffset = Vector3.new(CameraX,CameraY+CameraYLean,0)} ):Play()
		ts(Character.Humanoid, TweenInfo.new(.1), {CameraOffset = Vector3.new(CameraX,-3.5,0)} ):Play()
	end
	Humanoid.JumpPower = 0 
	IsStanced = true
	Proned2 = Vector3.new(0,0.5,0.5)
	Main.Poses.ProneSFX:Play()
	camoffset.Completed:Wait()
	Controls:Enable()
end

Engine.Eventos.GrenadeAgony.OnClientEvent:Connect(function()
	Prone()
end)

local function Tween(part,Time,properties,style,direction,de)
	local tw = game:GetService("TweenService")
	local ti = TweenInfo.new(
		Time or 1,
		style or Enum.EasingStyle.Quint,
		direction or Enum.EasingDirection.Out,
		0,
		false,
		de or 0
	)
	tw:Create(part,ti,properties):Play()
end

function Lean()
	speedMult = game:GetService('UserInputService').MouseDeltaSensitivity
	if (workspace.CurrentCamera.CFrame.p-workspace.CurrentCamera.Focus.p).Magnitude < 1 then
		--		ts(character.Humanoid, TweenInfo.new(.7), {CameraOffset = Vector3.new(CameraX,CameraY+CameraYLean,val)} ):Play()
		ts(Character.Humanoid, TweenInfo.new(.5), {CameraOffset = Vector3.new(CameraX,CameraY+CameraYLean,-1)} ):Play()
	else
		--		ts(character.Humanoid, TweenInfo.new(.7), {CameraOffset = Vector3.new(CameraX,CameraY+CameraYLean,0)} ):Play()
		ts(Character.Humanoid, TweenInfo.new(.5), {CameraOffset = Vector3.new(CameraX,CameraY+CameraYLean,0)} ):Play()
	end

	if not _G.LeanPart then
		_G.LeanPart = Instance.new('Part')
	end

	Tween(_G.LeanPart,0.75,{CFrame = CFrame.new()*CFrame.Angles(0,0,-math.rad(CameraX*7))})
	Stance:FireServer(Stances,Virar,Rendido.Value)
end

CameraYLean = 0

local yAdd = .2

game:GetService('UserInputService').Changed:connect(function()
	if Stances == 0 then
		Stand()
		lastStance = 0
	elseif Stances == 1 then
		Crouch()
		lastStance = 1
	elseif Stances == 2 then
		Prone()
		lastStance = 2
	end
end)

function CheckStamina()
	print("Checking Player Stamina")
	if saude.Variaveis.Stamina.Value <= 0 then
		Correndo.Value = false
		Steady = false
		ChangeStance = true
	end 
end

local Staminaxd = saude:WaitForChild("Variaveis").Stamina
local RunAbility = true

Staminaxd.Changed:Connect(function()
	if Staminaxd.Value <= 0 then
		Correndo.Value = false
		Steady = false
		ChangeStance = true
		TweenWalkSpeed(ServerConfig.NormalWalkSpeed * StancesPasta.Mobility.Value * speedMult)
	end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	UIS = game:GetService("UserInputService")
	speedMult = game:GetService('UserInputService').MouseDeltaSensitivity
	if not gameProcessed then
		if input.KeyCode == Enum.KeyCode.C and Stances == 0 and ChangeStance and Correndo.Value == false and Rappeling.Value == false and not _G.Lean and not Sentado then
			Stances = 1
			--CameraX = 0
			CameraY = -1
			lastStance = 1
			ts(Poses.Levantado, TweenInfo.new(.25), {ImageTransparency =  1} ):Play()
			ts(Poses.Agaixado, TweenInfo.new(.25), {ImageTransparency =  0} ):Play()
			ts(Poses.Deitado, TweenInfo.new(.25), {ImageTransparency =  1} ):Play()
			Poses.Levantado.Visible = false
			Poses.Agaixado.Visible = true
			Poses.Deitado.Visible = false
			Crouch()


			_G.Crouched = true
		elseif input.KeyCode == Enum.KeyCode.C and Stances == 1 and ChangeStance and Correndo.Value == false and Rappeling.Value == false and not _G.Lean and not Sentado then	
			Stances = 0
			--CameraX = 0
			CameraY = 0
			Virar = 0
			lastStance = 0
			ts(Poses.Levantado, TweenInfo.new(.25), {ImageTransparency =  0} ):Play()
			ts(Poses.Agaixado, TweenInfo.new(.25), {ImageTransparency =  1} ):Play()
			ts(Poses.Deitado, TweenInfo.new(.25), {ImageTransparency =  1} ):Play()
			--Poses.Esg_Right.Visible = false
			--Poses.Esg_Left.Visible = false
			Poses.Levantado.Visible = true
			Poses.Agaixado.Visible = false
			Poses.Deitado.Visible = false
			--Lean()
			Stand()

			_G.Crouched = false
			--_G.Proned = false

		elseif input.KeyCode == Enum.KeyCode.X and Stances == 2 and lastStance == 1 and ChangeStance and Correndo.Value == false and Rappeling.Value == false and not _G.Lean and not Sentado  then
			_G.Crouched = true
			_G.Proned = false
			Stances = 1
			--CameraX = 0
			CameraY = -1
			ts(Poses.Levantado, TweenInfo.new(.25), {ImageTransparency =  1} ):Play()
			ts(Poses.Agaixado, TweenInfo.new(.25), {ImageTransparency =  0} ):Play()
			ts(Poses.Deitado, TweenInfo.new(.25), {ImageTransparency =  1} ):Play()
			Poses.Levantado.Visible = false
			Poses.Agaixado.Visible = true
			Poses.Deitado.Visible = false
			Crouch()
		elseif input.KeyCode == Enum.KeyCode.X and Stances == 2 and lastStance == 0 and ChangeStance and Correndo.Value == false and Rappeling.Value == false and not _G.Lean and not Sentado  then
			_G.Crouched = false
			_G.Proned = false
			Stances = 0
			--CameraX = 0
			CameraY = 0
			ts(Poses.Levantado, TweenInfo.new(.25), {ImageTransparency =  0} ):Play()
			ts(Poses.Agaixado, TweenInfo.new(.25), {ImageTransparency =  1} ):Play()
			ts(Poses.Deitado, TweenInfo.new(.25), {ImageTransparency =  1} ):Play()
			Poses.Levantado.Visible = true
			Poses.Agaixado.Visible = false
			Poses.Deitado.Visible = false
			Stand()
		elseif input.KeyCode == Enum.KeyCode.X and Stances == 2 and lastStance == 2 and ChangeStance and Correndo.Value == false and Rappeling.Value == false and not _G.Lean and not Sentado  then
			_G.Crouched = true
			_G.Proned = false
			Stances = 1
			--CameraX = 0
			CameraY = -1
			ts(Poses.Levantado, TweenInfo.new(.25), {ImageTransparency =  1} ):Play()
			ts(Poses.Agaixado, TweenInfo.new(.25), {ImageTransparency =  0} ):Play()
			ts(Poses.Deitado, TweenInfo.new(.25), {ImageTransparency =  1} ):Play()
			Poses.Levantado.Visible = false
			Poses.Agaixado.Visible = true
			Poses.Deitado.Visible = false
			Crouch()

		elseif input.KeyCode == Enum.KeyCode.X and Stances == 1 and ChangeStance and Correndo.Value == false and Rappeling.Value == false and not _G.Lean and not Sentado  then		
			_G.Crouched = false
			_G.Proned = true
			Stances = 2
			lastStance = 1
			--CameraX = 0
			CameraY = -3.25
			ts(Poses.Levantado, TweenInfo.new(.25), {ImageTransparency =  1} ):Play()
			ts(Poses.Agaixado, TweenInfo.new(.25), {ImageTransparency =  1} ):Play()
			ts(Poses.Deitado, TweenInfo.new(.25), {ImageTransparency =  0} ):Play()
			Poses.Levantado.Visible = false
			Poses.Agaixado.Visible = false
			Poses.Deitado.Visible = true
			Lean()
			Prone()
		elseif input.KeyCode == Enum.KeyCode.X and Stances == 0 and ChangeStance and Correndo.Value == false and Rappeling.Value == false and not _G.Lean and not Sentado  then		
			_G.Crouched = false
			_G.Proned = true
			Stances = 2
			lastStance = 0
			--CameraX = 0
			CameraY = -3.25
			ts(Poses.Levantado, TweenInfo.new(.25), {ImageTransparency =  1} ):Play()
			ts(Poses.Agaixado, TweenInfo.new(.25), {ImageTransparency =  1} ):Play()
			ts(Poses.Deitado, TweenInfo.new(.25), {ImageTransparency =  0} ):Play()
			Poses.Levantado.Visible = false
			Poses.Agaixado.Visible = false
			Poses.Deitado.Visible = true
			Lean()
			Prone()

		elseif input.KeyCode == Enum.KeyCode.CapsLock and ChangeStance and Correndo.Value == false then
			if not Steady then
				Steady = true
				Poses.Steady.Visible = true							
				if Stances == 0 then
					Stand()
					TweenWalkSpeed(ServerConfig.SlowPaceWalkSpeed * StancesPasta.Mobility.Value * speedMult)
				elseif Stances == 1 then
					Crouch()
					TweenWalkSpeed(ServerConfig.ProneWalkSpeed * StancesPasta.Mobility.Value * speedMult)
				end
			else
				Steady = false
				Poses.Steady.Visible = false
				if Stances == 0 and Ferido.Value == false then
					Stand()
					TweenWalkSpeed(ServerConfig.NormalWalkSpeed * StancesPasta.Mobility.Value * speedMult)
				elseif Stances == 1 then
					Crouch()
					TweenWalkSpeed(ServerConfig.CrouchWalkSpeed * StancesPasta.Mobility.Value * speedMult)
				end
			end
		elseif (input.KeyCode == Enum.KeyCode.E and UIS:IsKeyDown(Enum.KeyCode.LeftAlt))  and ChangeStance and Correndo.Value == false and not _G.Lean and CanLean and CameraX < 1.5 and CameraX >= 0  or (input.KeyCode == Enum.KeyCode.LeftAlt and UIS:IsKeyDown(Enum.KeyCode.E)) and ChangeStance and Correndo.Value == false and not _G.Lean and CanLean and CameraX < 1.5 and CameraX >= 0 then		
			if Virar <= 0 or Virar >= -1 and Stances ~= 2 then
				Virar = Virar + 0.25
				CameraYLean = -yAdd * -0.25
				CameraX = CameraX + 0.25
				Poses.Esg_Right.Visible = true
				Poses.Esg_Left.Visible = false
				Main.Poses.LeanSFX1:Play()
			elseif Virar <= 0 or Virar >= -1 and Stances == 2 then
				Virar = Virar + 0.25
				CameraX = CameraX + 0.25
				CameraYLean = -yAdd * -0.25
				Poses.Esg_Right.Visible = true
				Poses.Esg_Left.Visible = false
				Main.Poses.LeanSFX1:Play()
			else
				Virar = 0
				CameraX = 0
				Poses.Esg_Right.Visible = false
				Poses.Esg_Left.Visible = false
			end
			Lean()
		elseif (input.KeyCode == Enum.KeyCode.Q and UIS:IsKeyDown(Enum.KeyCode.LeftAlt))  and ChangeStance and Correndo.Value == false and not _G.Lean and CanLean and CameraX > -1.5 and CameraX <= 0  or (input.KeyCode == Enum.KeyCode.LeftAlt and UIS:IsKeyDown(Enum.KeyCode.Q)) and ChangeStance and Correndo.Value == false and not _G.Lean and CanLean and CameraX > -1.5 and CameraX <= 0 then		
			if Virar <= 0 or Virar <= 1 and Stances ~= 2 then
				Virar = Virar - 0.25
				CameraYLean = -yAdd * -0.25
				CameraX = CameraX - 0.25
				Poses.Esg_Right.Visible = true
				Poses.Esg_Left.Visible = false
				Main.Poses.LeanSFX2:Play()
			elseif Virar <= 0 or Virar <= 1 and Stances == 2 then
				Virar = Virar - 0.25
				CameraX = CameraX - 0.25
				CameraYLean = -yAdd * -0.25
				Poses.Esg_Right.Visible = true
				Poses.Esg_Left.Visible = false
				Main.Poses.LeanSFX2:Play()
			else
				Virar = 0
				CameraX = 0
				Poses.Esg_Right.Visible = false
				Poses.Esg_Left.Visible = false
			end
			Lean()
		elseif input.KeyCode == Enum.KeyCode.E and ChangeStance and Correndo.Value == false and not _G.Lean and CanLean then		
			if Virar == 0 or Virar == -1 and Stances ~= 2 then
				Virar = 1
				CameraYLean = -yAdd 
				CameraX = 1.5
				L_153_.peekFactor = math.rad(-0.75)
				Poses.Esg_Right.Visible = true
				Poses.Esg_Left.Visible = false
				Main.Poses.LeanSFX1:Play()
			elseif Virar == 0 or Virar == -1 and Stances == 2 then
				Virar = 1
				CameraX = 1.5
				L_153_.peekFactor = math.rad(-1)
				CameraYLean = -yAdd - 0.1
				Poses.Esg_Right.Visible = true
				Poses.Esg_Left.Visible = false
				Main.Poses.LeanSFX1:Play()
			else
				Virar = 0
				L_153_.peekFactor = math.rad(-0.75)
				CameraX = 0
				Poses.Esg_Right.Visible = false
				Poses.Esg_Left.Visible = false
			end
			Lean()
		elseif input.KeyCode == Enum.KeyCode.Q and ChangeStance and Correndo.Value == false and not _G.Lean and CanLean  then
			if Virar == 0 or Virar == 1 and Stances ~= 2 then
				Virar = -1
				CameraYLean = -yAdd
				CameraX = -1.5
				L_153_.peekFactor = math.rad(-0.75)
				Poses.Esg_Right.Visible = false
				Poses.Esg_Left.Visible = true
				Main.Poses.LeanSFX2:Play()
			elseif Virar == 0 or Virar == 1 and Stances == 2 then
				Virar = -1
				CameraX = -1.5
				L_153_.peekFactor = math.rad(-1)
				CameraYLean = -yAdd - 0.1
				Poses.Esg_Right.Visible = false
				Poses.Esg_Left.Visible = true
				Main.Poses.LeanSFX2:Play()
			else
				Virar = 0
				L_153_.peekFactor = math.rad(-0.75)
				CameraX = 0
				Poses.Esg_Right.Visible = false
				Poses.Esg_Left.Visible = false
			end
			Lean()
		elseif input.KeyCode == Enum.KeyCode.LeftShift and game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) and not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) and Correndo.Value == false and Ferido.Value == false and Rappeling.Value == false and not _G.Lean and not Sentado and not cansado and Stances < 2 and saude.Variaveis.Stamina.Value > 0 then	
			if Velocidade > 0 and saude.Variaveis.Stamina.Value > saude.Variaveis.Stamina.MaxValue / 3 and CanSprint == true then
				ChangeStance = false
				Correndo.Value = true
				Steady = false
				Aiming = false
				Stand()
				
				
				-- Character.Animate.walk.WalkAnim.AnimationId = "rbxassetid://71576530476836"

				-- animation = Instance.new("Animation")
				-- animation.AnimationId = "rbxassetid://0" -- experimental ID 124487205346835
				-- animation.Parent = Humanoid

				-- loadedAnimation = Humanoid:LoadAnimation(animation)
				-- loadedAnimation:Play()

				-- removed animation because it was buggy

				--loadedAnimation:AdjustSpeed(0.9)
				Stances = 0
				Virar = 0
				CameraX = 0
				CameraY = 0
				CheckStamina()
				Lean()
				ts(Poses.Levantado, TweenInfo.new(.25), {ImageTransparency =  0} ):Play()
				ts(Poses.Agaixado, TweenInfo.new(.25), {ImageTransparency =  1} ):Play()
				ts(Poses.Deitado, TweenInfo.new(.25), {ImageTransparency =  1} ):Play()
				Poses.Levantado.Visible = true
				Poses.Agaixado.Visible = false
				Poses.Deitado.Visible = false
				Poses.Esg_Right.Visible = false
				Poses.Esg_Left.Visible = false
				TweenWalkSpeed(ServerConfig.RunWalkSpeed * StancesPasta.Mobility.Value * speedMult)
			end
		elseif input.KeyCode == Enum.KeyCode.LeftShift and game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) and not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) and Correndo.Value == true and Ferido.Value == false and Rappeling.Value == false and not _G.Lean and not Sentado and not cansado and Stances < 2 and saude.Variaveis.Stamina.Value > 0 then
			ChangeStance = true
			Correndo.Value = false
			-- Character.Animate.walk.WalkAnim.AnimationId = "rbxassetid://106176393738249"
			if Steady then
				TweenWalkSpeed(ServerConfig.SlowPaceWalkSpeed * StancesPasta.Mobility.Value * speedMult)
				Poses.Steady.Visible = true	
			else
				TweenWalkSpeed(ServerConfig.NormalWalkSpeed * StancesPasta.Mobility.Value * speedMult)
				Poses.Steady.Visible = false
			end
		elseif input.KeyCode == Enum.KeyCode.S and Correndo.Value == true and Ferido.Value == false and Rappeling.Value == false and not _G.Lean and not Sentado and not cansado and Stances < 2 and saude.Variaveis.Stamina.Value > 0 then
			ChangeStance = true
			Correndo.Value = false
			if Steady then
				TweenWalkSpeed(ServerConfig.SlowPaceWalkSpeed * StancesPasta.Mobility.Value * speedMult)
				Poses.Steady.Visible = true	
			else
				TweenWalkSpeed(ServerConfig.NormalWalkSpeed * StancesPasta.Mobility.Value * speedMult)
				Poses.Steady.Visible = false
			end
		--[[elseif input.KeyCode == Enum.KeyCode.C and game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) and Correndo.Value == true and Ferido.Value == false and Rappeling.Value == false and not _G.Lean and not Sentado and not cansado and Stances < 2 and saude.Variaveis.Stamina.Value > 0 then
			ChangeStance = true
			Correndo.Value = false
			Stances = 1
			lastStance = 0
			Slide()
			_G.Crouched = true
		elseif input.KeyCode == Enum.KeyCode.X and game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) and Correndo.Value == true and Ferido.Value == false and Rappeling.Value == false and not _G.Lean and not Sentado and not cansado and Stances < 2 and saude.Variaveis.Stamina.Value > 0 then
			ChangeStance = true
			Correndo.Value = false
			Stances = 2
			lastStance = 0
			Dive()
			_G.Crouched = true]]--
		end
		
	end
	if not lp2 then
		lp2 = Instance.new('Part')
		_G.FLPart = lp2
	end
	game.Workspace.CurrentCamera.ChildAdded:connect(function()
		if game.Workspace.CurrentCamera:FindFirstChildOfClass("Model") then
			gun = game.Workspace.CurrentCamera:FindFirstChildOfClass("Model")
			anim = gun.Parent:FindFirstChild("BasePart")
			if script.Parent:FindFirstChild(gun.Name) then
				equip = true
			end
		else
			equip = false
		end
	end)
	local _, oldY, _ = cam.CFrame:ToEulerAnglesXYZ()
	local rX, rY, rZ = cam.CFrame:ToEulerAnglesXYZ()
	if (cam.Focus.p-cam.CoordinateFrame.p).magnitude < 0.8 then	
		if input.UserInputType == Enum.UserInputType.MouseButton3 and not gameProcessed then
			_G.FreeLook = true
			hum.AutoRotate = false

			local rX, rY, rZ = cam.CFrame:ToOrientation()
			local limX = math.clamp(math.deg(rX), -45, 45)
			local limY = math.clamp(math.deg(rY), -70, 70)
			--cam.CFrame = CFrame.new(cam.CFrame.p) * CFrame.fromOrientation(math.rad(limX), math.rad(limY), rZ)
				--[[if equip then
					
					if anim ~= nil then
						anim.CFrame = anim.CFrame * lp.CFrame
					end
				end]]--

				--[[if game.Workspace.CurrentCamera:FindFirstChildOfClass("Model") then
					gun = game.Workspace.CurrentCamera:FindFirstChildOfClass("Model")
					if script.Parent:FindFirstChild(gun.Name) then
						equip = true
					end
				else
					equip = false
				end
				if equip then
					local anim = gun:FindFirstChild("AnimBase")
					if anim then
						local animpos = anim.CFrame
						anim.CFrame = animpos
					end
				end]]--
			--					local limY = math.clamp(rY, oldY - math.pi / 2, oldY + math.pi / 2)-- a full 180 degrees
			--					cam.CFrame = CFrame.new(cam.CFrame.Position) * CFrame.Angles(rX, limY, rZ)
			--[[elseif input.UserInputType ~= Enum.UserInputType.MouseButton3 then
				hum.AutoRotate = true
				_G.FreeLook = false
				if char.HumanoidRootPart and char.HumanoidRootPart:FindFirstChild("FLAlign") then
					char.HumanoidRootPart.FLAlign:Destroy()
				end]]--


			--				cam.CFrame = CFrame.new(cam.CFrame.Position) * CFrame.Angles(rX, rY, rZ)
			--				CURRENTLY NEED TO USE MOUSE.HIT VECTOR3 FOR TORSO ROTATION, CFRAME TWEEN DOES NOT WORK
			--				need to convert to UIS.inputbegan
		end
	else
		hum.AutoRotate = true
		_G.FreeLook = false
		if char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("HumanoidRootPart"):FindFirstChild("FLAlign") then
			char:FindFirstChild("HumanoidRootPart").FLAlign:Destroy()
		end
	end
end)

local playerScripts = player:WaitForChild("PlayerScripts")

local playerController = playerScripts:WaitForChild("PlayerModule")

local controlModule = require(playerController:WaitForChild("ControlModule"))

-- functions
local function disableMovement()
	controlModule:Disable()
end

local function enableMovement()
	controlModule:Enable()
end

UserInputService.InputEnded:Connect(function(input, gameProcessed)
	if not gameProcessed then
		if input.KeyCode == Enum.KeyCode.E and ChangeStance and Correndo.Value == false and not _G.Lean and CanLean and (not UIS:IsKeyDown(Enum.KeyCode.LeftAlt)) then		
			Virar = 0
			CameraX = 0
			Poses.Esg_Right.Visible = false
			Poses.Esg_Left.Visible = false
			Lean()
		elseif input.KeyCode == Enum.KeyCode.Q and ChangeStance and Correndo.Value == false and not _G.Lean and CanLean and (not UIS:IsKeyDown(Enum.KeyCode.LeftAlt)) then
			Virar = 0
			CameraX = 0
			Poses.Esg_Right.Visible = false
			Poses.Esg_Left.Visible = false
			Lean()
		elseif input.KeyCode == Enum.KeyCode.W and Correndo.Value == true then
			ChangeStance = true
			Correndo.Value = false
			if Steady then
				TweenWalkSpeed(ServerConfig.SlowPaceWalkSpeed * StancesPasta.Mobility.Value * speedMult)
				Poses.Steady.Visible = true	
			else
				TweenWalkSpeed(ServerConfig.NormalWalkSpeed * StancesPasta.Mobility.Value * speedMult)
				Poses.Steady.Visible = false
			end
		end
		if input.UserInputType == Enum.UserInputType.MouseButton3 then
			hum.AutoRotate = true
			_G.FreeLook = false
			if char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("HumanoidRootPart"):FindFirstChild("FLAlign") then
				char:FindFirstChild("HumanoidRootPart").FLAlign:Destroy()
			end
		end
	end
end)



Stand()

Humanoid.Died:Connect(function()
	ts(char.Humanoid, TweenInfo.new(1), {CameraOffset = Vector3.new(0,0,0)} ):Play()
	ChangeStance = false
	Main.Visible = false
end)

Humanoid.Seated:Connect(function(IsSeated, Seat)

	if IsSeated  then
		Sentado = true
		Stand()
		Stances = 0
		Virar = 0
		CameraX = 0
		CameraY = 0
		Lean()
		Poses.Esg_Right.Visible = false
		Poses.Esg_Left.Visible = false
		ts(Poses.Levantado, TweenInfo.new(.25), {ImageTransparency =  0.7} ):Play()
		ts(Poses.Agaixado, TweenInfo.new(.25), {ImageTransparency =  1} ):Play()
		ts(Poses.Deitado, TweenInfo.new(.25), {ImageTransparency =  1} ):Play()
		Poses.Levantado.Visible = true
		Poses.Agaixado.Visible = false
		Poses.Deitado.Visible = false

		--if Seat:IsA("VehicleSeat") then
		--CanLean = false
		--end

	else
		Sentado = false
		CanLean = true
	end
end)

Humanoid.Running:Connect(function(Speed)
	--print(Speed)
	Velocidade = Speed
	ts(Main.Poses.Status.Barra.Stamina, TweenInfo.new(0), {Size =  UDim2.new(Humanoid.WalkSpeed/(ServerConfig.RunWalkSpeed * StancesPasta.Mobility.Value),0,0.75,0)} ):Play()
	Main.Poses.Status.Barra.arrow.Position = UDim2.new((Humanoid.WalkSpeed/(ServerConfig.RunWalkSpeed * StancesPasta.Mobility.Value)-0.1),0,-1.3,0)
end)

Humanoid.Changed:Connect(function(Health)
	--[[if Humanoid.Health > 0 then
		if Humanoid.Health > (Humanoid.Health/2) then
			script.Parent.Efeitos.Health.ImageTransparency = 1
		end
	elseif Humanoid.Health <= (Humanoid.Health/2) then
		script.Parent.Efeitos.Health.ImageTransparency = ((Humanoid.Health - (Humanoid.MaxHealth/2))/(Humanoid.MaxHealth/2))--]]
	if Humanoid.Health <= (Humanoid.MaxHealth/3) or Character.Head.HP.Value <= 10 or Character.Torso.HP.Value <= 30 then
		ts(script.Parent.Efeitos.Health,TweenInfo.new(3),{ImageTransparency = 0}):Play()
		--script.Parent.Efeitos.Health.ImageColor3 = Color3.fromRGB((170 * (Humanoid.Health)/(Humanoid.MaxHealth/2)) , 0, 0)
	else
		--script.Parent.Efeitos.Health.ImageColor3 = Color3.fromRGB(170, 0, 0)
		ts(script.Parent.Efeitos.Health,TweenInfo.new(3),{ImageTransparency = 1}):Play()
	end
end)


Ferido.Changed:Connect(function(Valor)
	--print(Valor)
	if Valor == true then
		if Correndo.Value == true then
			ChangeStance = true
			Correndo.Value = false
			Stand()
			Stances = 0
		end
		if Stances == 0 then
			Stand()
		end

		ts(Poses.Levantado, TweenInfo.new(.25), {ImageColor3 =  Color3.fromRGB(150,0,0)} ):Play()
		ts(Poses.Agaixado, TweenInfo.new(.25), {ImageColor3 =  Color3.fromRGB(150,0,0)} ):Play()
		ts(Poses.Deitado, TweenInfo.new(.25), {ImageColor3 =  Color3.fromRGB(150,0,0)} ):Play()

		--Poses.Levantado.ImageColor3 = Color3.fromRGB(100,0,0)
		--Poses.Agaixado.ImageColor3 = Color3.fromRGB(100,0,0)
		--Poses.Deitado.ImageColor3 = Color3.fromRGB(100,0,0)
		--Main.Status.Barra.Stamina.BackgroundColor3 = Color3.fromRGB(170,0,0)
	else
		if Stances == 0 then
			Stand()
		end

		ts(Poses.Levantado, TweenInfo.new(.25), {ImageColor3 =  Color3.fromRGB(255,255,255)} ):Play()
		ts(Poses.Agaixado, TweenInfo.new(.25), {ImageColor3 =  Color3.fromRGB(255,255,255)} ):Play()
		ts(Poses.Deitado, TweenInfo.new(.25), {ImageColor3 =  Color3.fromRGB(255,255,255)} ):Play()

		--Poses.Levantado.ImageColor3 = Color3.fromRGB(0,0,0)
		--Poses.Agaixado.ImageColor3 = Color3.fromRGB(0,0,0)
		--Poses.Deitado.ImageColor3 = Color3.fromRGB(0,0,0)
		--Main.Status.Barra.Stamina.BackgroundColor3 = Color3.fromRGB(125,125,125)
	end
end)

local BleedTween = ts(Main.Poses.Bleeding, TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,-1,true), {ImageColor3 =  Color3.fromRGB(150, 0, 0)} )

Sangrando.Changed:Connect(function(Valor)
	if Valor == true then
		Main.Poses.Bleeding.ImageColor3 = Color3.fromRGB(255,255,255)
		Main.Poses.Bleeding.Visible = true
		BleedTween:Play()
	else
		Main.Poses.Bleeding.Visible = false
		BleedTween:Cancel()
	end
end)


local a = Main.Vest.TextBox
local b = Main.Helm.TextBox
local Ener = Main.Poses.Energy
local AEner = Main.Poses.ArmEnergy

function Vest()
	a.Text = math.ceil(Protecao.VestVida.Value)
	a.Parent.ImageColor3 = Color3.fromRGB(255,0,0)
	ts(a.Parent, TweenInfo.new(2), {ImageColor3 =  Color3.fromRGB(255, 255, 255)} ):Play()
	if Protecao.VestVida.Value <= 0 then
		a.Parent.Visible = false
	else
		a.Parent.Visible = true
	end
end

function Helmet()
	b.Text = math.ceil(Protecao.HelmetVida.Value)
	b.Parent.ImageColor3 = Color3.fromRGB(255,0,0)
	ts(b.Parent, TweenInfo.new(2), {ImageColor3 =  Color3.fromRGB(255, 255, 255)} ):Play()

	if Protecao.HelmetVida.Value <= 0 then
		b.Parent.Visible = false
	else
		b.Parent.Visible = true
	end
end

function Stamina()
	if ServerConfig.EnableStamina then
		if saude.Variaveis.Stamina.Value <= (saude.Variaveis.Stamina.MaxValue/3) then
			ts(Ener.Barra.Stamina, TweenInfo.new(.25), {Size =  UDim2.new((saude.Variaveis.Stamina.Value/saude.Variaveis.Stamina.MaxValue),0,0.75,0)} ):Play()
			if saude.Variaveis.Stamina.Value <= (saude.Variaveis.Stamina.MaxValue/4) then
				ts(Ener.Barra.Stamina, TweenInfo.new(0.25), {BackgroundColor3 =  Color3.fromRGB(200, 0, 0)} ):Play()
				Evt.Stamina:FireServer(saude.Variaveis.Stamina,Character)
			else
				ts(Ener.Barra.Stamina, TweenInfo.new(0.25), {BackgroundColor3 =  Color3.fromRGB(0, 255, 200)} ):Play()
			end
			--Ener.Barra.Stamina.BackgroundColor3 = Color3.new(1,saude.Variaveis.Stamina.Value/(saude.Variaveis.Stamina.MaxValue/2),saude.Variaveis.Stamina.Value/saude.Variaveis.Stamina.MaxValue)
			Ener.Visible = true
		elseif saude.Variaveis.Stamina.Value < saude.Variaveis.Stamina.MaxValue then
			ts(Ener.Barra.Stamina, TweenInfo.new(.25), {Size =  UDim2.new((saude.Variaveis.Stamina.Value/saude.Variaveis.Stamina.MaxValue),0,0.75,0)} ):Play()
			if saude.Variaveis.Stamina.Value <= (saude.Variaveis.Stamina.MaxValue/4) then
				ts(Ener.Barra.Stamina, TweenInfo.new(0.25), {BackgroundColor3 =  Color3.fromRGB(200, 0, 0)} ):Play()
				Evt.Stamina:FireServer(saude.Variaveis.Stamina,Character)
			else
				ts(Ener.Barra.Stamina, TweenInfo.new(0.25), {BackgroundColor3 =  Color3.fromRGB(0, 255, 200)} ):Play()
			end
			Ener.Visible = true
		elseif saude.Variaveis.Stamina.Value >= saude.Variaveis.Stamina.MaxValue then
			ts(Ener.Barra.Stamina, TweenInfo.new(.25), {Size =  UDim2.new((saude.Variaveis.Stamina.Value/saude.Variaveis.Stamina.MaxValue),0,0.75,0)} ):Play()
			Ener.Visible = true
			ts(Ener.Barra.Stamina, TweenInfo.new(0.25), {BackgroundColor3 =  Color3.fromRGB(0, 255, 200)} ):Play()
		end
	else
		saude.Variaveis.Stamina.Value = saude.Variaveis.Stamina.MaxValue
		ts(Ener.Barra.Stamina, TweenInfo.new(.25), {Size =  UDim2.new((saude.Variaveis.Stamina.Value/saude.Variaveis.Stamina.MaxValue),0,0.75,0)} ):Play()
		Ener.Visible = true
		--print("no stamina fail :C")
	end
end

function ArmStamina()
	if ServerConfig.EnableStamina then
		if saude.Variaveis.ArmStamina.Value <= (saude.Variaveis.ArmStamina.MaxValue/3) then
			ts(AEner.Barra.AStamina, TweenInfo.new(.25), {Size =  UDim2.new((saude.Variaveis.ArmStamina.Value/saude.Variaveis.ArmStamina.MaxValue),0,0.75,0)} ):Play()
			if saude.Variaveis.ArmStamina.Value <= (saude.Variaveis.ArmStamina.MaxValue/4) then
				ts(AEner.Barra.AStamina, TweenInfo.new(0.25), {BackgroundColor3 =  Color3.fromRGB(200, 0, 0)} ):Play()
			else
				ts(AEner.Barra.AStamina, TweenInfo.new(0.25), {BackgroundColor3 =  Color3.fromRGB(0, 255, 200)} ):Play()
			end
			--Ener.Barra.Stamina.BackgroundColor3 = Color3.new(1,saude.Variaveis.Stamina.Value/(saude.Variaveis.Stamina.MaxValue/2),saude.Variaveis.Stamina.Value/saude.Variaveis.Stamina.MaxValue)
			AEner.Visible = true
		elseif saude.Variaveis.ArmStamina.Value < saude.Variaveis.ArmStamina.MaxValue then
			ts(AEner.Barra.AStamina, TweenInfo.new(.25), {Size =  UDim2.new((saude.Variaveis.ArmStamina.Value/saude.Variaveis.ArmStamina.MaxValue),0,0.75,0)} ):Play()
			if saude.Variaveis.ArmStamina.Value <= (saude.Variaveis.ArmStamina.MaxValue/4) then
				ts(Ener.Barra.AStamina, TweenInfo.new(0.25), {BackgroundColor3 =  Color3.fromRGB(200, 0, 0)} ):Play()
			else
				ts(AEner.Barra.AStamina, TweenInfo.new(0.25), {BackgroundColor3 =  Color3.fromRGB(0, 255, 200)} ):Play()
			end
			AEner.Visible = true
		elseif saude.Variaveis.ArmStamina.Value >= saude.Variaveis.ArmStamina.MaxValue then
			ts(AEner.Barra.AStamina, TweenInfo.new(.25), {Size =  UDim2.new((saude.Variaveis.ArmStamina.Value/saude.Variaveis.ArmStamina.MaxValue),0,0.75,0)} ):Play()
			AEner.Visible = true
			ts(AEner.Barra.AStamina, TweenInfo.new(0.25), {BackgroundColor3 =  Color3.fromRGB(0, 255, 200)} ):Play()
		end
	else
		saude.Variaveis.ArmStamina.Value = saude.Variaveis.ArmStamina.MaxValue
		ts(AEner.Barra.AStamina, TweenInfo.new(.25), {Size =  UDim2.new((saude.Variaveis.ArmStamina.Value/saude.Variaveis.ArmStamina.MaxValue),0,0.75,0)} ):Play()
		AEner.Visible = true
		--print("no stamina fail :C")
	end
end

Vest()
Helmet()
Stamina()
ArmStamina()

Protecao.VestVida.Changed:Connect(Vest)
Protecao.HelmetVida.Changed:Connect(Helmet)
saude.Variaveis.Stamina.Changed:Connect(Stamina)
saude.Variaveis.ArmStamina.Changed:Connect(ArmStamina)

Character.Humanoid.Changed:connect(function(Property)
	if ServerConfig.AntiBunnyHop then
		if Property == "Jump" and Character.Humanoid.Sit == true and Character.Humanoid.SeatPart ~= nil then
			Character.Humanoid.Sit = false
		elseif Property == "Jump" and Character.Humanoid.Sit == false then
			if JumpDelay or saude.Variaveis.Stamina.Value <= saude.Variaveis.Stamina.MaxValue / 3 + 50 then
				Character.Humanoid.Jump = false
				return false
			end
			saude.Variaveis.Stamina.Value = saude.Variaveis.Stamina.Value - 200
			JumpDelay = true
			delay(0, function()
				wait(ServerConfig.JumpCoolDown)
				JumpDelay = false
			end)
		end
	end
end)



local uis = game:GetService('UserInputService')
local Evt = Engine:WaitForChild("Eventos")
local placeEvent = Evt.Rappel:WaitForChild('PlaceEvent')
local ropeEvent = Evt.Rappel:WaitForChild('RopeEvent')
local cutEvent = Evt.Rappel:WaitForChild('CutEvent')

uis.InputBegan:connect(function(input,chat)
	if not chat and Rappeling.Value == true then
		if input.KeyCode == Enum.KeyCode.C then
			while uis:IsKeyDown(Enum.KeyCode.C) do
				wait()
				saude.Variaveis.Stamina.Value = saude.Variaveis.Stamina.Value - 25
				ropeEvent:FireServer('Up',true)
			end
		end;

		if input.KeyCode == Enum.KeyCode.X then
			while uis:IsKeyDown(Enum.KeyCode.X) do
				wait()
				saude.Variaveis.Stamina.Value = saude.Variaveis.Stamina.Value - 900
				ropeEvent:FireServer('Down',true)
			end
		end;
	end
end)

uis.InputEnded:connect(function(input,chat)
	if not chat and Rappeling.Value == true then		
		if input.KeyCode == Enum.KeyCode.C then
			ropeEvent:FireServer('Up',false)
		end;

		if input.KeyCode == Enum.KeyCode.X then
			ropeEvent:FireServer('Down',false)
		end;
	end
end)




function L_150_.Update()

	local L_174_ = CFrame.new()
	speedMult = game:GetService('UserInputService').MouseDeltaSensitivity
	L_153_.cornerPeek.t = L_153_.peekFactor * Virar
	local L_326_ = CFrame.fromAxisAngle(Vector3.new(0, 0, 1), L_153_.cornerPeek.p) -- SOLUTION TO 3RD PERSON --> CFrame.new(10,0,0) * CFrame.fromAxisAngle(Vector3.new(0,0,1), this.cornerPeek.p)
	Camera.CFrame = Camera.CFrame * L_326_ * L_174_
	if saude.Variaveis.Stamina.Value <= (saude.Variaveis.Stamina.MaxValue/3) then
		local StaminaX = (1 - (saude.Variaveis.Stamina.Value)/(saude.Variaveis.Stamina.MaxValue/3))/20
		Poses.Energy.Barra.Stamina.ImageColor3 = Color3.fromRGB(255, 0, 0)
		Camera.CoordinateFrame = Camera.CoordinateFrame * CFrame.Angles( math.rad( StaminaX * math.sin( tick() * 3.5 )) , math.rad( StaminaX * math.sin( tick() * 1 )), 0)
	end
	if saude.Variaveis.Stamina.Value >= (saude.Variaveis.Stamina.MaxValue/3) then
		Poses.Energy.Barra.Stamina.ImageColor3 = Color3.fromRGB(51, 185, 44)
	end
	if saude.Variaveis.ArmStamina.Value >= (saude.Variaveis.ArmStamina.MaxValue/3) then
		Poses.ArmEnergy.Barra.AStamina.ImageColor3 = Color3.fromRGB(44, 192, 255)
	end
	if saude.Variaveis.ArmStamina.Value <= (saude.Variaveis.ArmStamina.MaxValue/3) then
		local StaminaX = (1 - (saude.Variaveis.ArmStamina.Value)/(saude.Variaveis.ArmStamina.MaxValue/3))/20
		Poses.ArmEnergy.Barra.AStamina.ImageColor3 = Color3.fromRGB(255, 0, 0)
		Camera.CoordinateFrame = Camera.CoordinateFrame * CFrame.Angles( math.rad( StaminaX * math.sin( tick() * 3.5 )) , math.rad( StaminaX * math.sin( tick() * 1 )), 0)
	end
end


local Nadando = false

function onStateChanged(_,state)
	--print(state)
	if state == Enum.HumanoidStateType.Swimming then
		Nadando = true
	else
		Nadando = false
	end
end

maxAir = 100
air = maxAir

lastHealth = 100
lastHealth2 = 100
maxWidth = 0.96

Humanoid.StateChanged:connect(onStateChanged)
game:GetService("RunService"):BindToRenderStep("Camera Update", 200, L_150_.Update)
while game:GetService("RunService").Heartbeat:wait() do
	speedMult = game:GetService('UserInputService').MouseDeltaSensitivity
	if _G.FreeLook == false and anim ~= nil then
		Tween(lp2,.7,{CFrame = cam.CFrame})
	end
	if (workspace.CurrentCamera.CFrame.p-workspace.CurrentCamera.Focus.p).Magnitude < 0.8 then
		--		print("first person")

		if cam.CFrame.LookVector.Y then
			--			if cam.CFrame.LookVector.Y < -0.2 then
			local e = cam.CFrame.LookVector.Y
			q = e
			--			character.Humanoid.CameraOffset =  Vector3.new(0,0,q-.2)
			--			else
			--				print("nope no look vector for you")
			--			end
		end

		if Poses.Agaixado.Visible == true and Poses.Esg_Left.Visible == false and Poses.Esg_Right.Visible == false then
			ts(Character.Humanoid, TweenInfo.new(.3), {CameraOffset = Vector3.new(CameraX,CameraY,q-.3)} ):Play()
			--			ts(character.Head, TweenInfo.new(.3), {Position = Vector3.new(0,-1,-1)} ):Play()		-- this doesnt work
			--			Crouch()
		elseif Poses.Agaixado.Visible == true and Poses.Esg_Left.Visible == true or Poses.Agaixado.Visible == true and Poses.Esg_Right.Visible == true then

			--Lean()		
		elseif Poses.Agaixado.Visible == false and Poses.Deitado.Visible == true and Poses.Esg_Left.Visible == false and Poses.Esg_Right.Visible == false then
			ts(Character.Humanoid, TweenInfo.new(.3), {CameraOffset = Vector3.new(CameraX,CameraY,q-1.3)} ):Play()
			--			Prone()		
		elseif Poses.Levantado.Visible == true and Poses.Esg_Left.Visible == false and Poses.Esg_Right.Visible == false then
			ts(Character.Humanoid, TweenInfo.new(.3), {CameraOffset = Vector3.new(CameraX,CameraY,q-.3)} ):Play()
			--			Stand()	
		elseif Poses.Levantado.Visible == true and Poses.Esg_Left.Visible == true or Poses.Levantado.Visible == true and Poses.Esg_Right.Visible == true then

			-- Lean()												
		end	
	else
		--		print("3rd person")
		if Poses.Agaixado.Visible == true and Poses.Esg_Left.Visible == false and Poses.Esg_Right.Visible == false then
			ts(Character.Humanoid, TweenInfo.new(.3), {CameraOffset = Vector3.new(CameraX,CameraY,0)} ):Play()
			--			Crouch()
		elseif Poses.Agaixado.Visible == true and Poses.Esg_Left.Visible == true or Poses.Agaixado.Visible == true and Poses.Esg_Right.Visible == true then

			--Lean()		
		elseif Poses.Agaixado.Visible == false and Poses.Deitado.Visible == true and Poses.Esg_Left.Visible == false and Poses.Esg_Right.Visible == false then
			ts(Character.Humanoid, TweenInfo.new(.3), {CameraOffset = Vector3.new(CameraX,CameraY,-1)} ):Play()
			--			Prone()		
		elseif Poses.Levantado.Visible == true and Poses.Esg_Left.Visible == false and Poses.Esg_Right.Visible == false then
			ts(Character.Humanoid, TweenInfo.new(.3), {CameraOffset = Vector3.new(CameraX,CameraY,0)} ):Play()
			--			Stand()	
		elseif Poses.Levantado.Visible == true and Poses.Esg_Left.Visible == true or Poses.Levantado.Visible == true and Poses.Esg_Right.Visible == true then

			-- Lean()												
		end	
	end
	if ServerConfig.CanDrown and player.Character:FindFirstChild("Head") ~= nil then
		local headLoc = game.Workspace.Terrain:WorldToCell(player.Character:FindFirstChild("Head").Position)
		local hasAnyWater = game.Workspace.Terrain:GetWaterCell(headLoc.x, headLoc.y, headLoc.z)
		if player.Character.Humanoid.Health ~= 0 then
			if hasAnyWater then
				if air > 0 then
					air = air-0.15
				elseif air <= 0 then
					air = 0
					Evt.Afogar:FireServer()
				end
			else
				if air < maxAir then
					air = air + .5
				end
			end
		end

		if air <= 50 then
			script.Parent.Frame.Oxygen.ImageColor3 = Color3.new(1,air/50,air/100)
			script.Parent.Frame.Oxygen.Visible = true
		elseif air < maxAir then
			script.Parent.Frame.Oxygen.ImageColor3 = Color3.new(1,1,air/100)
			script.Parent.Frame.Oxygen.Visible = true
		elseif air >= maxAir then
			script.Parent.Frame.Oxygen.Visible = false
		end
		script.Parent.Efeitos.Oxigen.ImageTransparency = air/100
		if air <= 25 then
			script.Parent.Efeitos.Oxigen.BackgroundTransparency = air/25
		end
	end
	if ServerConfig.EnableStamina then

		--Evt.Tired:FireServer(Player,Character.Humanoid)
		if Correndo.Value == true and Velocidade > 0 and saude.Variaveis.Stamina.Value > 0 then
			saude.Variaveis.Stamina.Value = saude.Variaveis.Stamina.Value - ServerConfig.RunValue
		elseif saude.Variaveis.Aiming.Value == true and saude.Variaveis.ArmStamina.Value > 0 then
			saude.Variaveis.ArmStamina.Value = saude.Variaveis.ArmStamina.Value - ServerConfig.AimValue
		elseif Stances == 0 and (Correndo.Value == false or Velocidade <= 0 or saude.Variaveis.Stamina.Value <= 0) then
			saude.Variaveis.Stamina.Value = saude.Variaveis.Stamina.Value + ServerConfig.StandRecover
			saude.Variaveis.ArmStamina.Value = saude.Variaveis.ArmStamina.Value + ServerConfig.StandRecover * 1.3
		elseif Stances == 1 and (Correndo.Value == false or Velocidade <= 0 or saude.Variaveis.Stamina.Value <= 0) then
			saude.Variaveis.Stamina.Value = saude.Variaveis.Stamina.Value + ServerConfig.CrouchRecover
			saude.Variaveis.ArmStamina.Value = saude.Variaveis.ArmStamina.Value + ServerConfig.StandRecover * 1.3
		elseif Stances == 2 and (Correndo.Value == false or Velocidade <= 0 or saude.Variaveis.Stamina.Value <= 0) then
			saude.Variaveis.Stamina.Value = saude.Variaveis.Stamina.Value + ServerConfig.ProneRecover
			saude.Variaveis.ArmStamina.Value = saude.Variaveis.ArmStamina.Value + ServerConfig.ProneRecover * 1.3
		end
	end
end
