
local t = ""

local function fadeIn(audio)
	audio:Play()
end

local function fadeOut(audio)
	audio:Stop()
end
L = game:GetService("Lighting") 
ts = require(game.ReplicatedStorage.TService)

while wait(0.075) do
	if game.Lighting:GetMinutesAfterMidnight() < 7*60 or game.Lighting:GetMinutesAfterMidnight() > 18*60 then
		lastT = t
		t = "night"
	else
		lastT = t
		t = "day"
	end
	if lastT ~= t then
		if t == "night" then
			fadeOut(script.day)
			fadeIn(script.night)
		elseif t == "day" then
			fadeOut(script.night)
			fadeIn(script.day)
		end
	end
	--wait(.01)
	T = L:GetMinutesAfterMidnight()
	L:SetMinutesAfterMidnight(T + .025)
	if T < 300 then --Night time, after midnight.
		--game.Lighting.Atmosphere.Color = Color3.new((90+(T-390)/7)/255,(90+(T-390)/7)/255,(90+(T-390)/7)/255)
		ts(game.Lighting.Atmosphere,TweenInfo.new(2,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{Color = Color3.fromRGB(0, 0, 0),Decay = Color3.fromRGB(0, 0, 0),Haze = 2}):Play()
		ts(game.Lighting,TweenInfo.new(2,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{Ambient = Color3.fromRGB(25, 25, 25)}):Play()
		
		--game.Lighting.Atmosphere.Decay = Color3.new(231/255,247/255,255/255)
		ts(game.Lighting.Color,TweenInfo.new(2,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{Saturation = 0}):Play()
		ts(game.Lighting,TweenInfo.new(2,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{Brightness = 1.5}):Play()
	elseif T > 300 and T < 390 then --Dawn, sun rise.
		--game.Lighting.Atmosphere.Color = Color3.new((90+(T-390)/7)/255,(90+(T-390)/7)/255,(90+(T-390)/7)/255)
		ts(game.Lighting.Atmosphere,TweenInfo.new(2,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{Color = Color3.fromRGB(255, 100, 11),Decay = Color3.fromRGB(139, 87, 3),Haze = 2.05}):Play()
		--game.Lighting.Atmosphere.Decay = Color3.new(231/255,247/255,255/255)
		ts(game.Lighting,TweenInfo.new(2,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{Ambient = Color3.fromRGB(76, 42, 29)}):Play()
		ts(game.Lighting.Color,TweenInfo.new(2,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{Saturation = 0}):Play()
		ts(game.Lighting,TweenInfo.new(2,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{Brightness = 1.75}):Play()
	elseif T > 390 and T < 600 then --Morning.
		--game.Lighting.Atmosphere.Color = Color3.new((90+(T-390)/7)/255,(90+(T-390)/7)/255,(90+(T-390)/7)/255)
		ts(game.Lighting.Atmosphere,TweenInfo.new(2,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{Color = Color3.fromRGB(90,90,90),Decay = Color3.new(255/255,243/255,171/255),Haze = 2.05}):Play()
		--game.Lighting.Atmosphere.Decay = Color3.new(231/255,247/255,255/255)
		ts(game.Lighting,TweenInfo.new(2,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{Ambient = Color3.fromRGB(42, 42, 42)}):Play()
		ts(game.Lighting.Color,TweenInfo.new(2,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{Saturation = -0.3}):Play()
		ts(game.Lighting,TweenInfo.new(2,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{Brightness = 1}):Play()
	elseif T > 600 and T < 840 then --Day time.
		ts(game.Lighting.Atmosphere,TweenInfo.new(2,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{Color = Color3.fromRGB(217, 247, 255),Decay = Color3.fromRGB(139, 139, 139),Haze = 2}):Play()
		--game.Lighting.Atmosphere.Decay = Color3.new(231/255,247/255,255/255)
		ts(game.Lighting,TweenInfo.new(2,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{Ambient = Color3.fromRGB(42, 42, 42)}):Play()
		ts(game.Lighting.Color,TweenInfo.new(2,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{Saturation = -0.4}):Play()
		ts(game.Lighting,TweenInfo.new(2,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{Brightness = 1.25}):Play()
	elseif T > 840 and T < 1050 then --Afternoon.
		ts(game.Lighting.Atmosphere,TweenInfo.new(2,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{Color = Color3.fromRGB(217, 247, 255),Decay =  Color3.new(231/255,247/255,255/255),Haze = 2}):Play()
		--game.Lighting.Atmosphere.Decay = Color3.new(231/255,247/255,255/255)
		ts(game.Lighting,TweenInfo.new(2,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{Ambient = Color3.fromRGB(42, 42, 42)}):Play()
		ts(game.Lighting.Color,TweenInfo.new(2,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{Saturation = -0.4}):Play()
		ts(game.Lighting,TweenInfo.new(2,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{Brightness = 1.75}):Play()
	elseif T > 1050 and T < 1140 then --Evening, sun set.
		--game.Lighting.Atmosphere.Color = Color3.new((90+(T-390)/7)/255,(90+(T-390)/7)/255,(90+(T-390)/7)/255)
		ts(game.Lighting.Atmosphere,TweenInfo.new(2,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{Color = Color3.fromRGB(255, 100, 11),Decay = Color3.fromRGB(139, 87, 3),Haze = 2.05}):Play()
		--game.Lighting.Atmosphere.Decay = Color3.new(231/255,247/255,255/255)
		ts(game.Lighting,TweenInfo.new(2,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{Ambient = Color3.fromRGB(45, 30, 9)}):Play()
		ts(game.Lighting.Color,TweenInfo.new(2,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{Saturation = 0}):Play()
		ts(game.Lighting,TweenInfo.new(2,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{Brightness = 1.75}):Play()
	elseif T > 1140 then --Night time, before midnight.
		--game.Lighting.Atmosphere.Color = Color3.new((90+(T-390)/7)/255,(90+(T-390)/7)/255,(90+(T-390)/7)/255)
		ts(game.Lighting.Atmosphere,TweenInfo.new(2,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{Color = Color3.fromRGB(255, 100, 11),Decay = Color3.fromRGB(139, 87, 3),Haze = 2.05}):Play()
		--game.Lighting.Atmosphere.Decay = Color3.new(231/255,247/255,255/255)
		ts(game.Lighting,TweenInfo.new(2,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{Ambient = Color3.fromRGB(39, 20, 14)}):Play()
		ts(game.Lighting.Color,TweenInfo.new(2,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{Saturation = 0}):Play()
		ts(game.Lighting,TweenInfo.new(2,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{Brightness = 1.5}):Play()
	end		
end
