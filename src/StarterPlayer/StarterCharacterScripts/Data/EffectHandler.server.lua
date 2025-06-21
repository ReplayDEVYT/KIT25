local Engine = game.ReplicatedStorage:WaitForChild("ACS_Engine")
local ServerConfig = require(Engine.ServerConfigs:WaitForChild("Config"))

local character = script.Parent.Parent

local plr = game:GetService("Players"):GetPlayerFromCharacter(character)

local maxThirst = 100
local maxHunger = 100
local thirstValue
local hungerValue

local ThirstDrain = script.ThirstDrain.Value
local HungerDrain = script.HungerDrain.Value

local thirstprev = script.ThirstDrain.prev.Value
local hungerprev = script.HungerDrain.prev.Value
local stomach = character:WaitForChild("Stomach").HP

-- PROFILESERVICE NOT IMPLEMENTED IN THIS VERSION
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")

if not plr:FindFirstChild("HungerVal") then
	Instance.new("IntValue", plr).Name = "HungerVal"
end
hungerValue = plr.HungerVal

if not plr:FindFirstChild("ThirstVal") then
	Instance.new("IntValue", plr).Name = "ThirstVal"
end
thirstValue = plr.ThirstVal

hungerValue.Value = 100
thirstValue.Value = 100
print("added vals")

task.spawn(function()

	while wait(60) do

		if thirstValue.Value - ThirstDrain >= 0 then
			thirstValue.Value -= ThirstDrain
		else
			thirstValue.Value = 0
		end

		if hungerValue.Value - HungerDrain >= 0 then
			hungerValue.Value -= HungerDrain
		else
			hungerValue.Value = 0
		end

	end
end)


-- multiply * 5 drain if stomach black

stomach.Changed:Connect(function()
	print("checking stomach")
	if stomach.Value <= 0 then
		print("ouch ouch ouch it hurts!! water and food pooling out of stomach oh no")
		thirstprev = ThirstDrain
		hungerprev = HungerDrain

		ThirstDrain += 7.6
		HungerDrain += 7.2
		print("multiplied drain")
	else
		ThirstDrain = thirstprev
		HungerDrain = hungerprev
	end
end)

repeat task.wait() until plr.ThirstVal ~= nil and plr.HungerVal ~= nil

thirstValue.Changed:connect(function()
	if thirstValue.Value <= 0 then
		task.delay(30, function()
			if thirstValue.Value <= 0 then
				plr.Character.Saude.Variaveis.Stamina.MaxValue -= 300
				plr.Character.Saude.Variaveis.ArmStamina.MaxValue -= 300
			else
				print("player isnt dehydrated after 2nd check, so nvm")
			end
		end)
	end
end)


hungerValue.Changed:connect(function()
	if hungerValue.Value <= 0 then
		task.delay(10, function()
			if hungerValue.Value <= 0 then
				plr.Character.Saude.Variaveis.Stamina.MaxValue -= 400
				plr.Character.Saude.Variaveis.ArmStamina.MaxValue -= 400
			else
				print("player isnt hungry after 2nd check, so nvm")
			end
		end)
	end
end)