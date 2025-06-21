originalambient = Enum.ReverbType.NoReverb
local l = game.Lighting
local ambiencescript = workspace.scripts.ambience
local dayaudio = ambiencescript.day
local nightaudio = ambiencescript.night
local indoor = ambiencescript.indoor
local indoor2 = ambiencescript.indoor2
local atm = l:WaitForChild("Atmosphere")
local fog = atm.Density
if ambiencescript:FindFirstChild("music") then
music = ambiencescript.music
	fx = music.FX
end
local ts = require(game.ReplicatedStorage.TService)
--wait(.5)
local playerlist = game.Players
local otherplayers = playerlist:GetPlayers()
local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
local character = script.Parent
local rootpart = character:WaitForChild("HumanoidRootPart")
local CQCReverb = false
local heartbeat = game:GetService("RunService").Heartbeat
oldambiencer = game.Lighting.OutdoorAmbient.R
oldambienceg = game.Lighting.OutdoorAmbient.G
oldambienceb = game.Lighting.OutdoorAmbient.B
newambiencer = game.Lighting.OutdoorAmbient.R * 1.1
newambienceg = game.Lighting.OutdoorAmbient.G * 1.1
newambienceb = game.Lighting.OutdoorAmbient.B * 1.1
-------------------------------------------------------

heartbeat:Connect(function()
	wait()
	    otherplayers = playerlist:GetPlayers()

 for i,v in pairs(otherplayers) do
	if v.Character then
		otherplayercharacter = v.Character
	end
	
end
	
	raytop = Ray.new(rootpart.Position,Vector3.new(0,90,0))
	local hit,position = workspace:FindPartOnRayWithIgnoreList(raytop,{character,otherplayercharacter,camera})	
	raylow = Ray.new(rootpart.Position,Vector3.new(0,7,0))
	local hitl,position = workspace:FindPartOnRayWithIgnoreList(raylow,{character,otherplayercharacter,camera})
	
	if hitl and hit.Transparency < .5 and hit.CanCollide == true and hit.Name ~= "Trunk" then
		wait(.1)
		CQCReverb = true
		game.SoundService.AmbientReverb = "NoReverb"
		--ts(atm,TweenInfo.new(1),{Density = 0.2}):Play()
		local tweenday = ts(dayaudio,TweenInfo.new(3),{Volume = 0.4})
		local tweennight = ts(nightaudio,TweenInfo.new(3),{Volume = 0.4})
		local tweenindoor2 = ts(indoor2,TweenInfo.new(3),{Volume = 0})
		local tweenindoor = ts(indoor,TweenInfo.new(3),{Volume = 3})
		local tweenlighting = ts(l,TweenInfo.new(3),{OutdoorAmbient = Color3.fromRGB(newambiencer, newambienceg, newambienceb)})
		tweenday:Play()
		tweennight:Play()
		tweenindoor:Play()
		tweenindoor2:Play()
		tweenlighting:Play()
		fx.MidGain = -20
		fx.LowGain = 0
		fx.HighGain = -50
	else
		wait()
		CQCReverb = false
	end
	
	if hit and hit.Material and hit.Transparency < .5 and hit.CanCollide == true and CQCReverb == false and hit.Name ~= "Trunk" then
		wait()
		if hit.Name == "hideoutReverb" then
			wait(.1)
			local tweenday = ts(dayaudio,TweenInfo.new(3),{Volume = .01})
			local tweennight = ts(nightaudio,TweenInfo.new(3),{Volume = .01})
			local tweenindoor2 = ts(indoor2,TweenInfo.new(3),{Volume = 3})
			local tweenindoor = ts(indoor,TweenInfo.new(3),{Volume = 0})
			local tweenlighting = ts(l,TweenInfo.new(3),{OutdoorAmbient = Color3.fromRGB(newambiencer, newambienceg, newambienceb)})
			tweenday:Play()
			tweennight:Play()
			tweenindoor:Play()
			tweenindoor2:Play()
			tweenlighting:Play()
			--ts(atm,TweenInfo.new(1),{Density = 0.2}):Play()
			game.SoundService.AmbientReverb = "City"
			fx.MidGain = -5
			fx.LowGain = 0
			fx.HighGain = -50
		elseif hit.Material == Enum.Material.Concrete or hit.Material == Enum.Material.Cobblestone or hit.Material == Enum.Material.Slate or hit.Material == Enum.Material.Pebble or hit.Material == Enum.Material.Brick or hit.Material == Enum.Material.Sandstone or hit.Material == Enum.Material.Asphalt or hit.Material == Enum.Material.Rock or hit.Material == Enum.Material.Basalt or hit.Material == Enum.Material.Limestone or hit.Material == Enum.Material.Pavement or hit.Material == Enum.Material.Granite or hit.Material == Enum.Material.Plastic or hit.Material == Enum.Material.SmoothPlastic or hit.Material == Enum.Material.Neon or hit.Material == Enum.Material.ForceField or hit.Material == Enum.Material.Glass then
			wait(.1)
			local tweenday = ts(dayaudio,TweenInfo.new(3),{Volume = .01})
			local tweennight = ts(nightaudio,TweenInfo.new(3),{Volume = .01})
			local tweenindoor2 = ts(indoor2,TweenInfo.new(3),{Volume = 0})
			local tweenindoor = ts(indoor,TweenInfo.new(3),{Volume = 3})
			local tweenlighting = ts(l,TweenInfo.new(3),{OutdoorAmbient = Color3.fromRGB(newambiencer, newambienceg, newambienceb)})
			tweenday:Play()
			tweennight:Play()
			tweenindoor:Play()
			tweenindoor2:Play()
			tweenlighting:Play()
			--ts(atm,TweenInfo.new(1),{Density = 0.2}):Play()
			game.SoundService.AmbientReverb = "City"
			fx.MidGain = -5
			fx.LowGain = 0
			fx.HighGain = -50
		elseif hit.Material == Enum.Material.Metal or hit.Material == Enum.Material.CorrodedMetal or hit.Material == Enum.Material.DiamondPlate or hit.Material == Enum.Material.Glacier or hit.Material == Enum.Material.Foil or hit.Material == Enum.Material.Ice or hit.Material == Enum.Material.Marble then
			wait(.1)
			local tweenday = ts(dayaudio,TweenInfo.new(3),{Volume = 0})
			local tweennight = ts(nightaudio,TweenInfo.new(3),{Volume = 0})
			local tweenindoor2 = ts(indoor2,TweenInfo.new(3),{Volume = 0})
			local tweenindoor = ts(indoor,TweenInfo.new(3),{Volume = 3})
			local tweenlighting = ts(l,TweenInfo.new(3),{OutdoorAmbient = Color3.fromRGB(newambiencer, newambienceg, newambienceb)})
			tweenday:Play()
			tweennight:Play()
			tweenindoor:Play()
			tweenindoor2:Play()
			tweenlighting:Play()
			--ts(atm,TweenInfo.new(1),{Density = 0.2}):Play()
			fx.MidGain = -5
			fx.LowGain = -10
			fx.HighGain = -50
			game.SoundService.AmbientReverb = "City"
		elseif hit.Material == Enum.Material.Fabric or hit.Material == Enum.Material.Ground or hit.Material == Enum.Material.CrackedLava or hit.Material == Enum.Material.Mud or hit.Material == Enum.Material.Sand or hit.Material == Enum.Material.Salt or hit.Material == Enum.Material.Wood or hit.Material == Enum.Material.WoodPlanks or hit.Material == Enum.Material.Snow then
			wait(.1)
			local tweenday = ts(dayaudio,TweenInfo.new(3),{Volume = 0.4})
			local tweennight = ts(nightaudio,TweenInfo.new(3),{Volume = 0.4})
			local tweenindoor2 = ts(indoor2,TweenInfo.new(3),{Volume = 0})
			local tweenindoor = ts(indoor,TweenInfo.new(3),{Volume = 3})
			local tweenlighting = ts(l,TweenInfo.new(3),{OutdoorAmbient = Color3.fromRGB(newambiencer, newambienceg, newambienceb)})
			tweenday:Play()
			tweennight:Play()
			tweenindoor:Play()
			tweenindoor2:Play()
			tweenlighting:Play()
			--ts(atm,TweenInfo.new(1),{Density = 0.344}):Play()
			fx.MidGain = -5
			fx.LowGain = 0
			fx.HighGain = -50
			game.SoundService.AmbientReverb = "City"
		end
	elseif not hit and not hitl then
		wait()
		local tweenday = ts(dayaudio,TweenInfo.new(3),{Volume = 2})
		local tweennight = ts(nightaudio,TweenInfo.new(3),{Volume = 2})
		local tweenindoor2 = ts(indoor2,TweenInfo.new(3),{Volume = 0})
		local tweenindoor = ts(indoor,TweenInfo.new(3),{Volume = 0})
		local tweenlighting = ts(l,TweenInfo.new(3),{OutdoorAmbient = Color3.fromRGB(oldambiencer, oldambienceg, oldambienceb)})
		tweenday:Play()
		tweennight:Play()
		tweenindoor:Play()
		tweenindoor2:Play()
		tweenlighting:Play()
		game.SoundService.AmbientReverb = originalambient
		fx.MidGain = 0
		fx.LowGain = 0
		fx.HighGain = 0
		--ts(atm,TweenInfo.new(1),{Density = 0.344}):Play()
		end
	end)