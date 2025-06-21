local TweenService = game:GetService("TweenService")
--print('stun starting')

if workspace.CurrentCamera:FindFirstChild("Stun") then
	workspace.CurrentCamera:FindFirstChild("Stun"):Destroy()
end

local guiMain = Instance.new("ColorCorrectionEffect") 
guiMain.Parent = workspace.CurrentCamera 
guiMain.Brightness = script.Parent:WaitForChild("Brightness").Value
guiMain.Name = "Stun"

local stunSound = script:WaitForChild("stun1"):Clone()
stunSound.Parent = game:GetService('Players')[script.Parent.Parent.Name].PlayerGui
--stunSound.Volume = 1/(script.Parent.Dist.Value*script.Parent.Dist.Value)
stunSound:Play()

Flashed = script.Parent:WaitForChild('FlashedGui'):Clone()
script.Parent.Time:Clone().Parent = Flashed
script.Parent:WaitForChild("Brightness"):Clone().Parent = Flashed
Flashed.Parent = game:GetService('Players')[script.Parent.Parent.Name].PlayerGui
Flashed.pos.Disabled = false

local tweenInfo = TweenInfo.new(
	script.Parent.Time.Value, -- Time
	Enum.EasingStyle.Linear, -- EasingStyle
	Enum.EasingDirection.InOut, -- EasingDirection
	0, -- RepeatCount (when less than zero the tween will loop indefinitely)
	false, -- Reverses (tween will reverse once reaching it's goal)
	0 -- DelayTime
)

local tween0 = TweenService:Create(stunSound, TweenInfo.new(script.Parent.Time.Value), {Volume = stunSound.Volume*2})
tween0:Play()

local tween = TweenService:Create(guiMain, tweenInfo, {Brightness = 0})
tween:Play()

local m = script.ExpMuffle:Clone()
m.Parent = game.SoundService.All
game.Debris:AddItem(m,script.Parent.Time.Value+1)

task.delay(script.Parent.Time.Value/2,function()
	if m then
		TweenService:Create(m,TweenInfo.new(script.Parent.Time.Value/1.25),{HighGain = 0,LowGain = 0,MidGain = 0}):Play()
	end
end)

if not game.Players.LocalPlayer.PlayerGui:FindFirstChild("MuffleWind") then
	local wind = game.ReplicatedStorage.ACS_Engine.FX.MuffleWind:Clone()
	wind.Parent = game.Players.LocalPlayer.PlayerGui
	wind.SoundGroup = game.SoundService.All
	wind:Play()
	game.Debris:AddItem(wind,script.Parent.Time.Value/2+1)
	task.delay(script.Parent.Time.Value/2,function()
		TweenService:Create(wind,TweenInfo.new(1),{Volume = 0}):Play()
	end)
end

spawn(function()
	wait(script.Parent.Time.Value)

	local tween = TweenService:Create(stunSound, TweenInfo.new(0.5), {Volume = 0})
	tween:Play()
end)

wait(script.Parent.Time.Value + .5)

--print('stun ending')

guiMain:Destroy()
stunSound:Destroy()
wait(script.Parent.Time.Value*2)
script.Parent:Destroy()
Flashed:Destroy()