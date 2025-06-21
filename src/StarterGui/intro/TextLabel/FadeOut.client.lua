local ts = require(game.ReplicatedStorage.TService)
wait(10) --wait for 10 seconds
ts(script.Parent,TweenInfo.new(3),{TextTransparency = 1,TextStrokeTransparency = 1}):Play()