local lighting = game:GetService("Lighting")
local toggle = false
local button = script.Parent
local music = script.Parent.Parent.Music
local tracks = music.Tracks:GetChildren()
button.MouseButton1Down:connect(function()
	toggle = not toggle
	if toggle == true then
		script.Parent.Parent:WaitForChild("StartMusic"):Play()
		music.SoundId = "rbxassetid://"..tracks[math.random(#tracks)].Value
		music:Play()
	else
		script.Parent.Parent:WaitForChild("StopMusic"):Play()
		music:Stop()
	end
end)

