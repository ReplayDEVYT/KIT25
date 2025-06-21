--[[print("caching sounds")

local semit = Instance.new("Sound", game.Players.LocalPlayer.Character:WaitForChild("Head"))
semit.Name = "ColdSound"

print("finished caching sounds")]]--

local character = script.Parent
local player = game:GetService("Players"):GetPlayerFromCharacter(character)

local NotifModule = require(player.PlayerGui.NotificationUI.NotifModule)
local weather = game.Workspace.Weather
local temp = weather.Temperature
local s
local startheartbeat = false

local deb = false

local function ColdEffect()
	task.spawn(function()
		local tween = TweenInfo.new(
			2,
			Enum.EasingStyle.Linear,
			Enum.EasingDirection.InOut,
			0,
			false
		)

		game:GetService("TweenService"):Create(script.Coldness, tween, { Value = 100 }):Play()
	end)

	repeat task.wait() until script.Coldness.Value == 100

	task.spawn(function()
		NotifModule.Notify("Your character is cold! Aim speed and visibility decreased.", "125798567538670", "137408246946660", 10)
	end)

	task.spawn(function()
		player.PlayerGui.Frostbite.Enabled = true
		player.PlayerGui.Frostbite.Overlay.ImageTransparency = 1

		local tween = TweenInfo.new(
			3,
			Enum.EasingStyle.Circular,
			Enum.EasingDirection.Out,
			0,
			false
		)

		game:GetService("TweenService"):Create(player.PlayerGui.Frostbite.Overlay, tween, { ImageTransparency = 0 }):Play()
	end)

	script.IsCold.Value = true

	character.Saude.Stances.Steadiness.Value -= 0.3

	local children = script.Freezing:GetChildren()

	local s = children[math.random(#children)]

	s = s:Clone()
	s.Name = "ColdBreath"
	s.Parent = character["Head"]
	s:Play()

	s.Ended:Wait()

	s:Destroy()
	s = nil

	startheartbeat = true
end

local function HotEffect()
	task.spawn(function()
		NotifModule.Notify("Your character is hot! Max arm and leg stamina decreased.", "125798567538670", "137408246946660", 10)
	end)

	script.IsHot.Value = true

	character.Saude.Variaveis.Stamina.MaxValue -= 400
	character.Saude.Variaveis.ArmStamina.MaxValue -= 400

	local children = script.Burning:GetChildren()

	local s = children[math.random(#children)]

	s = s:Clone()
	s.Name = "HotBreath"
	s.Parent = character["Head"]
	s:Play()

	s.Ended:Wait()

	s:Destroy()
	s = nil

	startheartbeat = true
end

local function WarmUp()
	task.spawn(function()
		NotifModule.Notify("Your character is no longer cold. Debuffs have been temporarily removed.", "125798567538670", "137408246946660", 10)
	end)

	task.spawn(function()

		local tween = TweenInfo.new(
			3,
			Enum.EasingStyle.Circular,
			Enum.EasingDirection.Out,
			0,
			false
		)

		game:GetService("TweenService"):Create(player.PlayerGui.Frostbite.Overlay, tween, { ImageTransparency = 1 }):Play()
	end)

	character.Saude.Stances.Steadiness.Value += 0.3
	
	script.IsCold.Value = false
end

local function ClearEffects()
	task.spawn(function()

		local tween = TweenInfo.new(
			3,
			Enum.EasingStyle.Circular,
			Enum.EasingDirection.Out,
			0,
			false
		)

		game:GetService("TweenService"):Create(player.PlayerGui.Frostbite.Overlay, tween, { ImageTransparency = 1 }):Play()
	end)
	
	character.Saude.Variaveis.Stamina.MaxValue += 400
	character.Saude.Variaveis.ArmStamina.MaxValue += 400
end

local function SpawnCheck()
	if temp.Value <= -15 and script.InHeatZone.Value == false then
		print("player spawned in, cold weather")

		task.wait(7)

		ColdEffect()
	elseif temp.Value >= 29 then
		print ("player spawned in, oh my GOD its miserable")

		task.wait(7)

		HotEffect()
	end
end

print("checking current temp")

SpawnCheck()

--[[game:GetService("RunService").Heartbeat:Connect(function()
	if startheartbeat then
		print('test (will overload server 100p)')
		if script.IsCold.Value == false and script.IsHot.Value == false then
			if temp.Value <= -15 then
				deb = false
				print("weather changed to cold")
				ColdEffect()
			elseif temp.Value >= 29 then
				deb = false
				print("weather changed to hot")
				HotEffect()
			elseif temp.Value < 29 and temp.Value > -15 and not deb then
				print("character is neither hot or cold")
				deb = true
				ClearEffects()
			end
		end
	end
end)]]--

script.InHeatZone.Changed:Connect(function()
	if script.IsCold.Value == true and script.InHeatZone.Value == true and script.Coldness.Value > 0 then
		print("draining coldness")
	
		task.spawn(function()
			local tween = TweenInfo.new(
				4,
				Enum.EasingStyle.Linear,
				Enum.EasingDirection.InOut,
				0,
				false
			)
	
			game:GetService("TweenService"):Create(script.Coldness, tween, { Value = 0 }):Play()
		end)
	
		repeat task.wait() until script.Coldness.Value == 0
	
		WarmUp()
	elseif script.IsCold.Value == false and script.InHeatZone.Value == false and temp.Value <= -15 then
		print("brrr its so cold")
		ColdEffect()
	end
end)

workspace.Weather.Temperature.Changed:Connect(function()
	
	print("oh hey temp change")
	
	if script.IsCold.Value == false and script.IsHot.Value == false then
		if temp.Value <= -15 then
			deb = false
			print("weather changed to cold")
			ColdEffect()
		elseif temp.Value >= 29 then
			deb = false
			print("weather changed to hot")
			HotEffect()
		elseif temp.Value < 29 and temp.Value > -15 and not deb then
			print("character is neither hot or cold")
			deb = true
			ClearEffects()
		end
	end
end)

--[[script.InHeatZone.Changed:Connect(function()
	if workspace.Weather.Raining.Value == true then
		print("it's raining")
		droplets:Enable()
	else
		print("it's not raining")
		droplets:Disable()
	end
end)]]--