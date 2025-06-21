repeat
	wait()
until game.Players.LocalPlayer.Character
wait(0.5)

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local Char = player.Character
local Human = Char.Humanoid
local Saude = Char.Saude
local menu = script.Parent.Parent.Menu
local Target = Char.Saude.Variaveis.PlayerSelecionado
local Reset = game.ReplicatedStorage.ACS_Engine.Eventos.MedSys.Reset
local Vida = script.Parent.Vida
local Consciente = script.Parent.Consciente
local Dor = script.Parent.Dor
local Ferido = script.Parent.Ferido
local Sangrando = script.Parent.Sangrando
local effects = script.Parent.Status
local bleed = effects.Bleeding
local bleed2 = effects.Bleeding2
local freshwound = effects.FreshWound
local fracture = effects.Fracture
local painkiller = effects.PainKiller
local onpk = Saude.Stances.PK
local pain = effects.Pain
local limbs = script.Parent.Limbs
local torso = Char:WaitForChild("Torso"):WaitForChild("HP")
local stom = Char:WaitForChild("Stomach"):WaitForChild("HP")
local head = Char:WaitForChild("Head"):WaitForChild("HP")
local larm = Char:WaitForChild("Left Arm"):WaitForChild("HP")
local rarm = Char:WaitForChild("Right Arm"):WaitForChild("HP")
local lleg = Char:WaitForChild("Left Leg"):WaitForChild("HP")
local rleg = Char:WaitForChild("Right Leg"):WaitForChild("HP")
local headval = limbs.Head
local stomval = limbs.Torso
local torsoval = limbs.Thorax
local larmval = limbs.LArm
local rarmval = limbs.RArm
local llegval = limbs.LLeg
local rlegval = limbs.RLeg

local ts = require(game.ReplicatedStorage.TService)


local BleedTween = ts(Sangrando, TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,-1,true), {TextColor3 =  Color3.fromRGB(255, 0, 0)} )

while true do
	for i,stat in pairs(effects:GetChildren()) do
		if stat:IsA("ImageLabel") and stat.Visible == true then
			stat.MouseEnter:connect(function()
				if stat:FindFirstChild("Info") ~= nil then
					stat.Info.Visible = true
				end
			end)
			stat.MouseLeave:connect(function()
				if stat:FindFirstChild("Info") ~= nil then
					stat.Info.Visible = false
				end
			end)
		end
	end
	if Target.Value == "N/A" then
		limbs.Visible = true
		menu.Visible = false
		headval.Main.Barra.Num.Text = math.ceil(head.Value).."/"..head.MaxValue
		if head.Value <= (head.MaxValue* 0.25) and head.Value > 0 then
			headval.Main.Barra.Num.TextColor3 = Color3.fromRGB(255,0,0)
			headval.Main.Barra.BorderColor3 = Color3.fromRGB(255,0,0)
			ts(headval.Main.Barra.Val, TweenInfo.new(.25), {BackgroundColor3 =  Color3.fromRGB(255,0,0)} ):Play()
			headval.badeffect.Visible = true
			ts(headval.icon, TweenInfo.new(.25), {ImageColor3 =  Color3.fromRGB(255,0,0)} ):Play()
		elseif head.Value <= 0 then
			headval.Main.Barra.Num.TextColor3 = Color3.fromRGB(255,0,0)
			headval.Main.Barra.BorderColor3 = Color3.fromRGB(255,0,0)
			ts(headval.Main.Barra.Val, TweenInfo.new(.25), {BackgroundColor3 =  Color3.fromRGB(255,0,0)} ):Play()
			headval.badeffect.Visible = false
			ts(headval.icon, TweenInfo.new(.25), {ImageColor3 =  Color3.fromRGB(0,0,0)} ):Play()
		else
			ts(headval.Main.Barra.Val, TweenInfo.new(.25), {BackgroundColor3 =  Color3.fromRGB(0,255,0)} ):Play()
			headval.Main.Barra.Num.TextColor3 = Color3.fromRGB(255,255,255)
			headval.Main.Barra.BorderColor3 = Color3.fromRGB(0,0,0)
			headval.badeffect.Visible = false
			ts(headval.icon, TweenInfo.new(.25), {ImageColor3 =  Color3.fromRGB(255,255,255)} ):Play()
		end
		ts(headval.Main.Barra.Val, TweenInfo.new(.25), {Size =  UDim2.new((head.Value/head.MaxValue),0,0.5,0)} ):Play()
		torsoval.Main.Barra.Num.Text = math.ceil(torso.Value).."/"..torso.MaxValue
		if torso.Value <= (torso.MaxValue * 0.25) and torso.Value > 0 then
			torsoval.Main.Barra.Num.TextColor3 = Color3.fromRGB(255,0,0)
			torsoval.Main.Barra.BorderColor3 = Color3.fromRGB(255,0,0)
			ts(torsoval.Main.Barra.Val, TweenInfo.new(.25), {BackgroundColor3 =  Color3.fromRGB(255,0,0)} ):Play()
			torsoval.badeffect.Visible = true
			ts(torsoval.icon, TweenInfo.new(.25), {ImageColor3 =  Color3.fromRGB(255,0,0)} ):Play()
			
			--torsoval.Main.Barra.Num.TextColor3 = Color3.fromRGB(255,0,0)
			--torsoval.Main.Barra.BorderColor3 = Color3.fromRGB(255,0,0)
			--ts(torsoval.Main.Barra.Val, TweenInfo.new(.25), {BackgroundColor3 =  Color3.fromRGB(255,0,0)} ):Play()
		elseif torso.Value <= 0 then
			torsoval.Main.Barra.Num.TextColor3 = Color3.fromRGB(255,0,0)
			torsoval.Main.Barra.BorderColor3 = Color3.fromRGB(255,0,0)
			ts(torsoval.Main.Barra.Val, TweenInfo.new(.25), {BackgroundColor3 =  Color3.fromRGB(255,0,0)} ):Play()
			torsoval.badeffect.Visible = false
			ts(torsoval.icon, TweenInfo.new(.25), {ImageColor3 =  Color3.fromRGB(0,0,0)} ):Play()
			
			--torsoval.Main.Barra.Num.TextColor3 = Color3.fromRGB(255,0,0)
			--torsoval.Main.Barra.BorderColor3 = Color3.fromRGB(255,0,0)
		--	ts(thoraxval.Main.Barra.Val, TweenInfo.new(.25), {BackgroundColor3 =  Color3.fromRGB(255,0,0)} ):Play()
		else
			ts(torsoval.Main.Barra.Val, TweenInfo.new(.25), {BackgroundColor3 =  Color3.fromRGB(0,255,0)} ):Play()
			torsoval.Main.Barra.Num.TextColor3 = Color3.fromRGB(255,255,255)
			torsoval.Main.Barra.BorderColor3 = Color3.fromRGB(0,0,0)
			torsoval.badeffect.Visible = false
			ts(torsoval.icon, TweenInfo.new(.25), {ImageColor3 =  Color3.fromRGB(255,255,255)} ):Play()
			
			--ts(torsoval.Main.Barra.Val, TweenInfo.new(.25), {BackgroundColor3 =  Color3.fromRGB(0,255,0)} ):Play()
			--torsoval.Main.Barra.Num.TextColor3 = Color3.fromRGB(255,255,255)
			--torsoval.Main.Barra.BorderColor3 = Color3.fromRGB(0,0,0)
		end
		ts(torsoval.Main.Barra.Val, TweenInfo.new(.25), {Size =  UDim2.new((torso.Value/torso.MaxValue),0,0.5,0)} ):Play()
		
		
		
		
		
		
		stomval.Main.Barra.Num.Text = math.ceil(stom.Value).."/"..stom.MaxValue
		if stom.Value <= (stom.MaxValue * 0.25) and stom.Value > 0 then
			stomval.Main.Barra.Num.TextColor3 = Color3.fromRGB(255,0,0)
			stomval.Main.Barra.BorderColor3 = Color3.fromRGB(255,0,0)
			ts(stomval.Main.Barra.Val, TweenInfo.new(.25), {BackgroundColor3 =  Color3.fromRGB(255,0,0)} ):Play()
			stomval.badeffect.Visible = true
			ts(stomval.icon, TweenInfo.new(.25), {ImageColor3 =  Color3.fromRGB(255,0,0)} ):Play()

			--torsoval.Main.Barra.Num.TextColor3 = Color3.fromRGB(255,0,0)
			--torsoval.Main.Barra.BorderColor3 = Color3.fromRGB(255,0,0)
			--ts(torsoval.Main.Barra.Val, TweenInfo.new(.25), {BackgroundColor3 =  Color3.fromRGB(255,0,0)} ):Play()
		elseif stom.Value <= 0 then
			stomval.Main.Barra.Num.TextColor3 = Color3.fromRGB(255,0,0)
			stomval.Main.Barra.BorderColor3 = Color3.fromRGB(255,0,0)
			ts(stomval.Main.Barra.Val, TweenInfo.new(.25), {BackgroundColor3 =  Color3.fromRGB(255,0,0)} ):Play()
			stomval.badeffect.Visible = false
			ts(stomval.icon, TweenInfo.new(.25), {ImageColor3 =  Color3.fromRGB(0,0,0)} ):Play()

			--torsoval.Main.Barra.Num.TextColor3 = Color3.fromRGB(255,0,0)
			--torsoval.Main.Barra.BorderColor3 = Color3.fromRGB(255,0,0)
			--	ts(thoraxval.Main.Barra.Val, TweenInfo.new(.25), {BackgroundColor3 =  Color3.fromRGB(255,0,0)} ):Play()
		else
			ts(stomval.Main.Barra.Val, TweenInfo.new(.25), {BackgroundColor3 =  Color3.fromRGB(0,255,0)} ):Play()
			stomval.Main.Barra.Num.TextColor3 = Color3.fromRGB(255,255,255)
			stomval.Main.Barra.BorderColor3 = Color3.fromRGB(0,0,0)
			stomval.badeffect.Visible = false
			ts(stomval.icon, TweenInfo.new(.25), {ImageColor3 =  Color3.fromRGB(255,255,255)} ):Play()

			--ts(torsoval.Main.Barra.Val, TweenInfo.new(.25), {BackgroundColor3 =  Color3.fromRGB(0,255,0)} ):Play()
			--torsoval.Main.Barra.Num.TextColor3 = Color3.fromRGB(255,255,255)
			--torsoval.Main.Barra.BorderColor3 = Color3.fromRGB(0,0,0)
		end
		ts(stomval.Main.Barra.Val, TweenInfo.new(.25), {Size =  UDim2.new((stom.Value/stom.MaxValue),0,0.5,0)} ):Play()
		
		
		
		
		
		
		
		larmval.Main.Barra.Num.Text = math.ceil(larm.Value).."/"..larm.MaxValue
		if larm.Value <= (larm.MaxValue * 0.25) and larm.Value > 0 then
			larmval.Main.Barra.Num.TextColor3 = Color3.fromRGB(255,0,0)
			larmval.Main.Barra.BorderColor3 = Color3.fromRGB(255,0,0)
			ts(larmval.Main.Barra.Val, TweenInfo.new(.25), {BackgroundColor3 =  Color3.fromRGB(255,0,0)} ):Play()
			larmval.badeffect.Visible = true
			ts(larmval.icon, TweenInfo.new(.25), {ImageColor3 =  Color3.fromRGB(255,0,0)} ):Play()
		elseif larm.Value <= 0 then
			larmval.Main.Barra.Num.TextColor3 = Color3.fromRGB(255,0,0)
			larmval.Main.Barra.BorderColor3 = Color3.fromRGB(255,0,0)
			ts(larmval.Main.Barra.Val, TweenInfo.new(.25), {BackgroundColor3 =  Color3.fromRGB(255,0,0)} ):Play()
			larmval.badeffect.Visible = false
			ts(larmval.icon, TweenInfo.new(.25), {ImageColor3 =  Color3.fromRGB(0,0,0)} ):Play()
		else
			ts(larmval.Main.Barra.Val, TweenInfo.new(.25), {BackgroundColor3 =  Color3.fromRGB(0,255,0)} ):Play()
			larmval.Main.Barra.Num.TextColor3 = Color3.fromRGB(255,255,255)
			larmval.Main.Barra.BorderColor3 = Color3.fromRGB(0,0,0)
			larmval.badeffect.Visible = false
			ts(larmval.icon, TweenInfo.new(.25), {ImageColor3 =  Color3.fromRGB(255,255,255)} ):Play()
		end
		ts(larmval.Main.Barra.Val, TweenInfo.new(.25), {Size =  UDim2.new((larm.Value/larm.MaxValue),0,0.5,0)} ):Play()
		rarmval.Main.Barra.Num.Text = math.ceil(rarm.Value).."/"..rarm.MaxValue
		if rarm.Value <= (rarm.MaxValue * 0.25) and rarm.Value > 0 then
		rarmval.Main.Barra.Num.TextColor3 = Color3.fromRGB(255,0,0)
			rarmval.Main.Barra.BorderColor3 = Color3.fromRGB(255,0,0)
			ts(rarmval.Main.Barra.Val, TweenInfo.new(.25), {BackgroundColor3 =  Color3.fromRGB(255,0,0)} ):Play()
			rarmval.badeffect.Visible = true
			ts(rarmval.icon, TweenInfo.new(.25), {ImageColor3 =  Color3.fromRGB(255,0,0)} ):Play()
		elseif rarm.Value <= 0 then
			rarmval.Main.Barra.Num.TextColor3 = Color3.fromRGB(255,0,0)
			rarmval.Main.Barra.BorderColor3 = Color3.fromRGB(255,0,0)
			ts(rarmval.Main.Barra.Val, TweenInfo.new(.25), {BackgroundColor3 =  Color3.fromRGB(255,0,0)} ):Play()
			rarmval.badeffect.Visible = false
			ts(rarmval.icon, TweenInfo.new(.25), {ImageColor3 =  Color3.fromRGB(0,0,0)} ):Play()
		else
			ts(rarmval.Main.Barra.Val, TweenInfo.new(.25), {BackgroundColor3 =  Color3.fromRGB(0,255,0)} ):Play()
			rarmval.Main.Barra.Num.TextColor3 = Color3.fromRGB(255,255,255)
			rarmval.Main.Barra.BorderColor3 = Color3.fromRGB(0,0,0)
			rarmval.badeffect.Visible = false
			ts(rarmval.icon, TweenInfo.new(.25), {ImageColor3 =  Color3.fromRGB(255,255,255)} ):Play()
		end
		ts(rarmval.Main.Barra.Val, TweenInfo.new(.25), {Size =  UDim2.new((rarm.Value/rarm.MaxValue),0,0.5,0)} ):Play()
		llegval.Main.Barra.Num.Text = math.ceil(lleg.Value).."/"..lleg.MaxValue
		if lleg.Value <= (lleg.MaxValue * 0.25) and lleg.Value > 0 then
			llegval.Main.Barra.Num.TextColor3 = Color3.fromRGB(255,0,0)
			llegval.Main.Barra.BorderColor3 = Color3.fromRGB(255,0,0)
			ts(llegval.Main.Barra.Val, TweenInfo.new(.25), {BackgroundColor3 =  Color3.fromRGB(255,0,0)} ):Play()
			llegval.badeffect.Visible = true
			ts(llegval.icon, TweenInfo.new(.25), {ImageColor3 =  Color3.fromRGB(255,0,0)} ):Play()
		elseif lleg.Value <= 0 then
			llegval.Main.Barra.Num.TextColor3 = Color3.fromRGB(255,0,0)
			llegval.Main.Barra.BorderColor3 = Color3.fromRGB(255,0,0)
			ts(llegval.Main.Barra.Val, TweenInfo.new(.25), {BackgroundColor3 =  Color3.fromRGB(255,0,0)} ):Play()
			llegval.badeffect.Visible = false
			ts(llegval.icon, TweenInfo.new(.25), {ImageColor3 =  Color3.fromRGB(0,0,0)} ):Play()
		else
			ts(llegval.Main.Barra.Val, TweenInfo.new(.25), {BackgroundColor3 =  Color3.fromRGB(0,255,0)} ):Play()
			llegval.Main.Barra.Num.TextColor3 = Color3.fromRGB(255,255,255)
			llegval.Main.Barra.BorderColor3 = Color3.fromRGB(0,0,0)
			llegval.badeffect.Visible = false
			ts(llegval.icon, TweenInfo.new(.25), {ImageColor3 =  Color3.fromRGB(255,255,255)} ):Play()
		end
		ts(llegval.Main.Barra.Val, TweenInfo.new(.25), {Size =  UDim2.new((lleg.Value/lleg.MaxValue),0,0.5,0)} ):Play()
		rlegval.Main.Barra.Num.Text = math.ceil(rleg.Value).."/"..rleg.MaxValue
		if rleg.Value <= (rleg.MaxValue * 0.25) and rleg.Value > 0 then
			rlegval.Main.Barra.Num.TextColor3 = Color3.fromRGB(255,0,0)
			rlegval.Main.Barra.BorderColor3 = Color3.fromRGB(255,0,0)
			ts(rlegval.Main.Barra.Val, TweenInfo.new(.25), {BackgroundColor3 =  Color3.fromRGB(255,0,0)} ):Play()
			rlegval.badeffect.Visible = true
			ts(rlegval.icon, TweenInfo.new(.25), {ImageColor3 =  Color3.fromRGB(255,0,0)} ):Play()
		elseif rleg.Value <= 0 then
			rlegval.Main.Barra.Num.TextColor3 = Color3.fromRGB(255,0,0)
			rlegval.Main.Barra.BorderColor3 = Color3.fromRGB(255,0,0)
			ts(rlegval.Main.Barra.Val, TweenInfo.new(.25), {BackgroundColor3 =  Color3.fromRGB(255,0,0)} ):Play()
			rlegval.badeffect.Visible = false
			ts(rlegval.icon, TweenInfo.new(.25), {ImageColor3 =  Color3.fromRGB(0,0,0)} ):Play()
		else
			ts(rlegval.Main.Barra.Val, TweenInfo.new(.25), {BackgroundColor3 =  Color3.fromRGB(0,255,0)} ):Play()
			rlegval.Main.Barra.Num.TextColor3 = Color3.fromRGB(255,255,255)
			rlegval.Main.Barra.BorderColor3 = Color3.fromRGB(0,0,0)
			rlegval.badeffect.Visible = false
			ts(rlegval.icon, TweenInfo.new(.25), {ImageColor3 =  Color3.fromRGB(255,255,255)} ):Play()
		end
		ts(rlegval.Main.Barra.Val, TweenInfo.new(.25), {Size =  UDim2.new((rleg.Value/rleg.MaxValue),0,0.5,0)} ):Play()
		limbs.HPText.Text = math.ceil(Human.Health)
		if Human.Health <= 0 then
			Vida.Text = "Deceased"
			Vida.TextColor3 = Color3.fromRGB(255,0,0)
			Vida.BorderColor3 = Color3.fromRGB(255,0,0)
			Vida.badeffect.Visible = true
			limbs.HPText.TextColor3 = Color3.fromRGB(255,0,0)
			limbs.HPText.badeffect.Visible = true
		elseif Human.Health <= (Human.MaxHealth * .5) then
			Vida.Text = "High Risk"
			Vida.badeffect.Visible = true
			Vida.TextColor3 = Color3.fromRGB(255,0,0)
			Vida.BorderColor3 = Color3.fromRGB(255,0,0)
			limbs.HPText.TextColor3 = Color3.fromRGB(255,0,0)
			limbs.HPText.badeffect.Visible = true
		elseif Human.Health <= (Human.MaxHealth * .75) then
			Vida.Text = "Low Risk"
			Vida.TextColor3 = Color3.fromRGB(255,255,0)
			Vida.BorderColor3 = Color3.fromRGB(255,255,0)
			Vida.badeffect.Visible = false
			limbs.HPText.TextColor3 = Color3.fromRGB(190, 231, 19)
			limbs.HPText.badeffect.Visible = false
		elseif Human.Health <= (Human.MaxHealth) then
			Vida.Text = "Healthy"
			Vida.TextColor3 = Color3.fromRGB(255,255,255)
			Vida.BorderColor3 = Color3.fromRGB(255,255,255)
			Vida.badeffect.Visible = false
			limbs.HPText.TextColor3 = Color3.fromRGB(190, 231, 19)
			limbs.HPText.badeffect.Visible = false
		end
		
		if Saude.Stances.Caido.Value == true then
			Consciente.Text = "Dying"
			Consciente.BorderColor3 = Color3.fromRGB(255,0,0)
			Consciente.TextColor3 = Color3.fromRGB(255,0,0)
			Consciente.badeffect.Visible = true
		else
			Consciente.Text = "Conscious"
			Consciente.BorderColor3 = Color3.fromRGB(255,255,255)
			Consciente.TextColor3 = Color3.fromRGB(255,255,255)
			Consciente.badeffect.Visible = false
		end

		if Saude.Variaveis.Dor.Value <= 0 then
			Dor.Text = "No pain"
			Dor.TextColor3 = Color3.fromRGB(255,255,255)
			Dor.BorderColor3 = Color3.fromRGB(255,255,255)
			Dor.badeffect.Visible = false
			pain.Visible = false
		elseif Saude.Variaveis.Dor.Value <= 25 and onpk.Value == false then
			Dor.Text = "Minor pain"
			Dor.TextColor3 = Color3.fromRGB(255,255,255)
			Dor.BorderColor3 = Color3.fromRGB(255,255,255)
			Dor.badeffect.Visible = false
		elseif Saude.Variaveis.Dor.Value < 100 and onpk.Value == false then
			Dor.Text = "Major pain"
			Dor.TextColor3 = Color3.fromRGB(255,255,0)
			Dor.BorderColor3 = Color3.fromRGB(255,255,0)
			Dor.badeffect.Visible = false
			pain.Visible = true
		elseif Saude.Variaveis.Dor.Value >= 100 and onpk.Value == false then
			Dor.Text = "Extreme pain"
			Dor.TextColor3 = Color3.fromRGB(255,0,0)
			Dor.BorderColor3 = Color3.fromRGB(255,0,0)
			Dor.badeffect.Visible = true
			pain.Visible = true
		end


		if Saude.Stances.Ferido.Value == true then
			Ferido.Visible = true
			fracture.Visible = true
			painkiller.Visible = false
		else
			Ferido.Visible = false
			fracture.Visible = false
			if onpk.Value == true then
				painkiller.Visible = true
				pain.Visible = false
			else
				painkiller.Visible = false
			end
		end

		if Saude.Stances.Sangrando.Value == true or Saude.Stances.Tourniquet.Value == true then
			if Saude.Stances.Tourniquet.Value == true then
				Sangrando.Text = 'Tourniquet'
				Sangrando.BorderColor3 = Color3.fromRGB(255,255,0)
				Sangrando.badeffect.Visible = false
				bleed.Visible = false
				freshwound.Visible = true
			else
				Sangrando.Text = 'Bleeding'
				Sangrando.BorderColor3 = Color3.fromRGB(255,0,0)
				Sangrando.badeffect.Visible = true
				if Saude.Variaveis.HeavyBleed.Value == true then
					bleed.Visible = true
					bleed2.Visible = false
				else
					bleed.Visible = false
					bleed2.Visible = true
				end
				freshwound.Visible = false
			end
			Sangrando.Visible = true
			Sangrando.TextColor3 = Color3.fromRGB(255,255,255)
			Sangrando.BorderColor3 = Color3.fromRGB(255,0,0)
			bleed.Visible = true
			--freshwound.Visible = false
			BleedTween:Play()
		else
			Sangrando.Visible = false
			bleed.Visible = false
			bleed2.Visible = false
			freshwound.Visible = false
			BleedTween:Cancel()
		end
		effects.Toxin.Visible = false
		for i,lan in pairs(Char:GetChildren()) do
			if lan:FindFirstChild("UnknownToxin") then
				effects.Toxin.Visible = true
			end
		end
	else
		limbs.Visible = false
		menu.Visible = true
		local player2 = game.Players:FindFirstChild(Target.Value)
		local PlHuman = player2.Character.Humanoid
		local PlSaude = player2.Character.Saude
		if PlHuman.Health > 0 then
		if PlHuman.Health <= 0 then
			Vida.Text = "Dead"
				Vida.TextColor3 = Color3.fromRGB(255,0,0)
				Vida.BorderColor3 = Color3.fromRGB(255,0,0)
				Vida.badeffect.Visible = true
		elseif PlHuman.Health <= (PlHuman.MaxHealth * .5) then
			Vida.Text = "High Risk"
				Vida.TextColor3 = Color3.fromRGB(255,0,0)
				Vida.BorderColor3 = Color3.fromRGB(255,0,0)
				Vida.badeffect.Visible = true
		elseif PlHuman.Health <= (PlHuman.MaxHealth * .75) then
			Vida.Text = "Low Risk"
				Vida.TextColor3 = Color3.fromRGB(255,255,0)
				Vida.BorderColor3 = Color3.fromRGB(255,255,0)
				Vida.badeffect.Visible = false
		elseif PlHuman.Health <= (PlHuman.MaxHealth) then
			Vida.Text = "Healthy"
				Vida.TextColor3 = Color3.fromRGB(255,255,255)
				Vida.BorderColor3 = Color3.fromRGB(255,255,255)
				Vida.badeffect.Visible = false
		end

		if PlSaude.Stances.Caido.Value == true then
				Consciente.Text = "Dying"
				Consciente.BorderColor3 = Color3.fromRGB(255,0,0)
				Consciente.TextColor3 = Color3.fromRGB(255,0,0)
				Consciente.badeffect.Visible = true
		else
				Consciente.Text = "Conscious"
				Consciente.BorderColor3 = Color3.fromRGB(255,255,255)
				Consciente.TextColor3 = Color3.fromRGB(255,255,255)
				Consciente.badeffect.Visible = false
		end

		if PlSaude.Variaveis.Dor.Value <= 0 then
			Dor.Text = "No pain"
				Dor.TextColor3 = Color3.fromRGB(255,255,255)
				Dor.BorderColor3 = Color3.fromRGB(255,255,255)
				Dor.badeffect.Visible = false
		elseif PlSaude.Variaveis.Dor.Value <= 25 then
			Dor.Text = "Minor pain"
				Dor.TextColor3 = Color3.fromRGB(255,255,255)
				Dor.BorderColor3 = Color3.fromRGB(255,255,255)
				Dor.badeffect.Visible = false
		elseif PlSaude.Variaveis.Dor.Value < 100 then
			Dor.Text = "Major pain"
				Dor.TextColor3 = Color3.fromRGB(255,255,0)
				Dor.BorderColor3 = Color3.fromRGB(255,255,0)
				Dor.badeffect.Visible = false
		elseif PlSaude.Variaveis.Dor.Value >= 100 then
			Dor.Text = "Extreme pain"
				Dor.TextColor3 = Color3.fromRGB(255,0,0)
				Dor.BorderColor3 = Color3.fromRGB(255,0,0)
				Dor.badeffect.Visible = true
		end

		if PlSaude.Stances.Ferido.Value == true then
				Ferido.Visible = true
				fracture.Visible = true
				painkiller.Visible = false
			else
				Ferido.Visible = false
				fracture.Visible = false
				if onpk.Value == true then
					painkiller.Visible = true
				else
					painkiller.Visible = false
				end
			end

		if PlSaude.Stances.Sangrando.Value == true or PlSaude.Stances.Tourniquet.Value == true then
			if PlSaude.Stances.Tourniquet.Value == true then
					Sangrando.Text = 'Tourniquet'
					Sangrando.BorderColor3 = Color3.fromRGB(255,255,0)
					Sangrando.badeffect.Visible = false
					bleed.Visible = false
					freshwound.Visible = true
			else
					Sangrando.Text = 'Bleeding'
					Sangrando.BorderColor3 = Color3.fromRGB(255,0,0)
					Sangrando.badeffect.Visible = true
					if PlSaude.Variaveis.HeavyBleed.Value == true then
						bleed.Visible = true
						bleed2.Visible = false
					else
						bleed.Visible = false
						bleed2.Visible = true
					end
					
					freshwound.Visible = false
			end
			Sangrando.Visible = true
				Sangrando.TextColor3 = Color3.fromRGB(255,255,255)
				Sangrando.BorderColor3 = Color3.fromRGB(255,0,0)
				BleedTween:Play()
				bleed.Visible = true
				--freshwound.Visible = false
		else
			Sangrando.Visible = false
				BleedTween:Cancel()
				bleed.Visible = false
				bleed2.Visible = false
				freshwound.Visible = false
		end
		else
			Reset:FireServer()
		end
	end
wait()
end

--Target.Changed:Connect(update)