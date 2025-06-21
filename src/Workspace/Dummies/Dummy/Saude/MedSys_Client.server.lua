local Char = script.Parent.Parent
local Character = script.Parent.Parent
if Char:FindFirstChild("Humanoid") then
	human = Char:FindFirstChild("Humanoid")
	ultimavida = human.MaxHealth
end
local PastaVar = script.Parent.Variaveis
local PastasStan = script.Parent.Stances
local Sangrando = PastasStan.Sangrando
local Sang = PastaVar.Sangue
local UltimoSang = Sang.MaxValue
local Dor = PastaVar.Dor
local Doer = PastaVar.Doer
local MLs = PastaVar.MLs
local Steady = PastasStan.Steadiness
--local Energia = PastaVar.Energia
local Ferido = PastasStan.Ferido
local Caido = PastasStan.Caido
local PK = PastasStan.PK

local Ragdoll = require(game.ReplicatedStorage.ACS_Engine.Modulos.Ragdoll)
local configuracao = require(game.ReplicatedStorage.ACS_Engine.ServerConfigs.Config)

local debounce = false
value = PastaVar.Arms
scavarms = game.ReplicatedStorage.ACS_Engine.Arms.SCAV:GetChildren()
value.Value = scavarms[math.random(#scavarms)]
--Char.Humanoid.BreakJointsOnDeath = false
local random = math.random(1,2)
local canRandom = true
if configuracao.EnableRagdoll == true and Char:FindFirstChild("Humanoid") then
	Char.Humanoid.Died:Connect(function()
		Ragdoll(Char)
	end)
end

local leghp = script.Parent.Parent:WaitForChild("Left Leg"):WaitForChild("HP")
local leghp2 = script.Parent.Parent:WaitForChild("Right Leg"):WaitForChild("HP")
local torsohp = script.Parent.Parent:WaitForChild("Torso"):WaitForChild("HP")
local stomachhp = script.Parent.Parent:WaitForChild("Stomach"):WaitForChild("HP")
local headhp = script.Parent.Parent:WaitForChild("Head"):WaitForChild("HP")
local armhp = script.Parent.Parent:WaitForChild("Left Arm"):WaitForChild("HP")
local armhp2 = script.Parent.Parent:WaitForChild("Right Arm"):WaitForChild("HP")


local lleghp = script.Parent.Parent:WaitForChild("Left Leg"):WaitForChild("HP").MaxValue
local lleghp2 = script.Parent.Parent:WaitForChild("Right Leg"):WaitForChild("HP").MaxValue
local ltorsohp = script.Parent.Parent:WaitForChild("Torso"):WaitForChild("HP").MaxValue
local lstomachhp = script.Parent.Parent:WaitForChild("Stomach"):WaitForChild("HP").MaxValue
local lheadhp = script.Parent.Parent:WaitForChild("Head"):WaitForChild("HP").MaxValue
local larmhp = script.Parent.Parent:WaitForChild("Left Arm"):WaitForChild("HP").MaxValue
local larmhp2 = script.Parent.Parent:WaitForChild("Right Arm"):WaitForChild("HP").MaxValue


local SKP_20 = Character.Humanoid.Health
soundDeb = false
game:GetService('RunService').Heartbeat:Connect(function()

	if Character and Character:FindFirstChild("Head") and Character:FindFirstChild("Humanoid") and Character:FindFirstChild("Torso") and Character:FindFirstChild("Stomach") and Character:FindFirstChild("HumanoidRootPart") then
		if Character.Humanoid.Health > 0 and Character:FindFirstChild("Head") ~= nil and Character:WaitForChild("Head", 1):WaitForChild("HP").Value > 0 and Character:WaitForChild("Torso"):WaitForChild("HP").Value > 0 and Character:FindFirstChild("Stomach") then
			Character.Humanoid.Health = (Character:WaitForChild("Head"):WaitForChild("HP").Value + Character:WaitForChild("Torso"):WaitForChild("HP").Value + Character:WaitForChild("Stomach"):WaitForChild("HP").Value + Character:WaitForChild("Left Arm"):WaitForChild("HP").Value + Character:WaitForChild("Right Arm"):WaitForChild("HP").Value + Character:WaitForChild("Left Leg"):WaitForChild("HP").Value + Character:WaitForChild("Right Leg"):WaitForChild("HP").Value)
		elseif Character:WaitForChild("Head"):WaitForChild("HP").Value == 0 and Character:WaitForChild("Torso"):WaitForChild("HP").Value == 0 and Character:WaitForChild("Left Arm"):WaitForChild("HP").Value == 0 and Character:WaitForChild("Right Arm"):WaitForChild("HP").Value == 0 and Character:WaitForChild("Stomach"):WaitForChild("HP").Value == 0 and Character:WaitForChild("Left Leg"):WaitForChild("HP").Value == 0 and Character:WaitForChild("Right Leg"):WaitForChild("HP").Value == 0 then
			Character.Humanoid.Health = 0
		elseif Character:FindFirstChild("Head") ~= nil and (Character:WaitForChild("Head"):WaitForChild("HP").Value <= 0 and PastaVar:WaitForChild("ShotLimb") == "Head") or Character:FindFirstChild("Torso") ~= nil and (Character:WaitForChild("Torso"):WaitForChild("HP").Value <= 0 and PastaVar:WaitForChild("ShotLimb") == "Torso") then
			Character.Humanoid.Health = 0
		end
		if Character.Humanoid.Health > 0 and armhp.Value > 0 and armhp2.Value > 0 or PK.Value == true then
			Steady.Value = 1
		end
		if Character.Humanoid.Health > 0 and armhp.Value <= 0 and Steady.Value > 0 and armhp2.Value > 0 and PK.Value == false then
			Steady.Value = 0.75
			Dor.Value = Dor.Value + 1
		end
		if Character.Humanoid.Health > 0 and armhp2.Value <= 0 and Steady.Value > 0 and PK.Value == false then
			Steady.Value = 0.5
		end
		if Sangrando.Value == true then
			if PastasStan.Tourniquet.Value == false then
				if script.Parent.Parent.Humanoid.Health < ultimavida -(configuracao.BleedDamage*2.25) then
					PastaVar.HeavyBleed.Value = true
				end
			--[[if leghp.Value < lleghp -(configuracao.BleedDamage) then
				wait(math.random(1,10))
				leghp.Value = (leghp.Value - 1)

			end
			if leghp2.Value < lleghp2 -(configuracao.BleedDamage) then
				wait(math.random(1,10))
				leghp2.Value = (leghp2.Value - 1)

			end
			if armhp.Value < larmhp -(configuracao.BleedDamage) then
				wait(math.random(1,10))
				armhp.Value = (armhp.Value - 1)

			end
			if armhp2.Value < larmhp2 -(configuracao.BleedDamage) then
				wait(math.random(1,10))
				armhp2.Value = (armhp2.Value - 1)

			end
			if headhp.Value < lheadhp -(configuracao.BleedDamage) then
				wait(math.random(1,10))
				headhp.Value = (headhp.Value - 1)

			end
			if torsohp.Value < ltorsohp -(configuracao.BleedDamage) then
				wait(math.random(1,10))
				torsohp.Value = (torsohp.Value - 1)

			end]]--
				if stomachhp.Value > 0 and torsohp.Value > 20 and headhp.Value > 10 and human.Health > (human.Health/2) then
					Sang.Value = (Sang.Value - (MLs.Value/60))
					UltimoSang = Sang.Value
					MLs.Value = MLs.Value + 1
					canRandom = true
					if headhp.Parent ~= nil and headhp.Parent:FindFirstChild('Cough'..random) or human.Health <= 0 or headhp <= 0 or torsohp <= 0 then
						headhp.Parent:FindFirstChild('Cough'..random):Stop()
					end
				elseif (stomachhp.Value <= 0 or torsohp.Value <= 20 or headhp.Value <= 10 or human.Health <= (human.Health/2)) and headhp and headhp.Parent and human.Health > 0 then
					Sang.Value = (Sang.Value - (MLs.Value/60*4))
					UltimoSang = Sang.Value
					MLs.Value = MLs.Value + 4
					for i,man in pairs(headhp.Parent:GetChildren()) do
						if man:IsA('Sound') and man.Name:find("Sound") and man.Name ~= "Sound" then
							man:Stop()
						end
					end
					if canRandom then
						if headhp.Parent ~= nil and headhp.Parent:FindFirstChild('Cough'..random) then
							if not headhp.Parent:HasTag("3DSoundEmitter") then
								headhp.Parent:AddTag("3DSoundEmitter")
							end
							headhp.Parent:FindFirstChild('Cough'..random):Play()
						end
						canRandom = false
						if canRandom == false then
							delay(headhp.Parent ~= nil and headhp.Parent:FindFirstChild('Cough'..random).TimeLength+.2 or 5,function()
								canRandom = true
							end)
						end
						random = math.random(1,2)
					end
				end
			end
		end

		if PastasStan.Tourniquet.Value == true then
			Dor.Value = Dor.Value + 0.1
		end

		if (human.Health - ultimavida < 0) then
			Sang.Value = Sang.Value + (human.Health - ultimavida)*((configuracao.BloodMult)*(configuracao.BloodMult)*(configuracao.BloodMult))
			UltimoSang = Sang.Value
		end

		if (human.Health - ultimavida < 0) then
			Dor.Value = math.ceil(Dor.Value + (human.Health - ultimavida)*(-configuracao.PainMult))
			--Energia.Value = math.ceil(Energia.Value + (human.Health - ultimavida)*(5))
		end	

		if (human.Health - ultimavida < 0) --[[and (Sangrando.Value == true)]] then
			MLs.Value = MLs.Value + ((ultimavida - human.Health)* (configuracao.BloodMult))
		end

		if leghp.Value > (leghp.MaxValue*.75) and leghp2.Value > (leghp.MaxValue*.75)  then
			--old one = script.Parent.Parent.Humanoid.Health < ultimavida -(configuracao.InjuredDamage)
			wait(math.random(50,100)/100)
			Ferido.Value = false
		end

		if script.Parent.Parent.Humanoid.Health < ultimavida -(configuracao.BleedDamage) then
			Sangrando.Value = true
			if script.Parent.Parent.Humanoid.Health < ultimavida -(configuracao.BleedDamage*2.25) then
				PastaVar.HeavyBleed.Value = true
			end	
		end	

		if leghp.Value <= (leghp.MaxValue*.25) or leghp2.Value <= (leghp.MaxValue*.25)  then
			--old one = script.Parent.Parent.Humanoid.Health < ultimavida -(configuracao.InjuredDamage)
			Ferido.Value = true
			if torsohp.Value <= (torsohp.Value/2) or leghp.Value <= (leghp.Value/3) and leghp2.Value <= (leghp.Value/3) or headhp.Value <= (headhp.Value/2) or Sang.Value <= 35 then
				--old one = script.Parent.Parent.Humanoid.Health < ultimavida -(configuracao.KODamage)
				if math.random(0,100) == 35 then
					Caido.Value = true
				end
			end
		end

		if PastaVar.Stamina.Value <= (PastaVar.Stamina.MaxValue / 4) then
			local breathdebounce = false
			if not breathdebounce then
				breathdebounce = true
				script.Parent.Parent:WaitForChild("Head")["Tired"]:Play()
			end
			script.Parent.Parent:WaitForChild("Head")["Tired"].Looped = true
			repeat until PastaVar.Stamina.Value >= (PastaVar.Stamina.MaxValue / 2)
			script.Parent.Parent:WaitForChild("Head")["Tired"].Looped = false
			breathdebounce = false
		end

		if Character.Humanoid.Health < SKP_20 and Character.Humanoid.Health > 0 and (Character.Humanoid.Health/SKP_20) > 10 then
			local rand = math.random(1,4)
			if script.Parent.Parent:FindFirstChild('Head') and script.Parent.Parent:FindFirstChild('Head'):FindFirstChild("Hit3") ~= nil and soundDeb == false then
				soundDeb = true
				script.Parent.Parent:WaitForChild("Head")["Hit"..rand].PlaybackSpeed = (math.random(95,105)/100)
				script.Parent.Parent:WaitForChild("Head")["Hit"..rand].Playing = true
				wait(script.Parent.Parent:WaitForChild("Head")["Hit"..rand].TimeLength + 0.5)
				soundDeb = false
			end
			SKP_20 = Character.Humanoid.Health
		end

		if human.Health >= ultimavida and Sangrando.Value == false then
			Sang.Value = Sang.Value + 10	
			MLs.Value = MLs.Value - 10		

		end

		if Sang.Value <= 0 then
			--human.Health = 0
		end

		ultimavida = script.Parent.Parent.Humanoid.Health
		if script.Parent.Parent:FindFirstChild("Stomach") ~= nil then
			lleghp = script.Parent.Parent:WaitForChild("Left Leg"):WaitForChild("HP").Value
			lleghp2 = script.Parent.Parent:WaitForChild("Right Leg"):WaitForChild("HP").Value
			ltorsohp = script.Parent.Parent:WaitForChild("Torso"):WaitForChild("HP").Value
			lstomachhp = script.Parent.Parent:WaitForChild("Stomach"):WaitForChild("HP").Value
			lheadhp = script.Parent.Parent:WaitForChild("Head"):WaitForChild("HP").Value
			larmhp = script.Parent.Parent:WaitForChild("Left Arm"):WaitForChild("HP").Value
			larmhp2 = script.Parent.Parent:WaitForChild("Right Arm"):WaitForChild("HP").Value
		end

		spawn(function(timer)
			if Sang.Value >= 3500 and Dor.Value < 200 and debounce == false and Caido.Value == true then
				debounce = true
				wait(60)
				Caido.Value = false
				debounce = false
			end	
		end)
	end

end)




-- Quero um pouco de credito,plox :P --
--  FEITO 100% POR SCORPION --
-- Oficial Release 1.5 --
