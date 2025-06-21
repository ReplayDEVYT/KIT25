local ts = require(game.ReplicatedStorage.TService)
local effect = ts(script.Parent.Flare, TweenInfo.new(2,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,-1,true), {Size =  UDim2.new(0.525,math.random(0,100),1,math.random(0,100))} )
effect:Play()