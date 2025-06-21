--Variables
local WS = workspace.ExtractSystem
local exits = WS.Exits
local alarm = WS.Exits:FindFirstChild("Bunker Hermetic Door").Sound
local light = WS.Exits:FindFirstChild("Bunker Hermetic Door").PointLight
--Function
script.Parent.Triggered:Connect(function()
	alarm.Playing = true;
	light.Enabled = true;
	exits:FindFirstChild("Bunker Hermetic Door").Config.Requirements.Event.Done.Value = true
	exits:FindFirstChild("Bunker Hermetic Door").Config.CanExtract.Value = true
	wait(30)
	alarm.Playing = false;
end)