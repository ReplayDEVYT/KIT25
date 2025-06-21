local player = game:GetService('Players').LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local saude = char:WaitForChild('Saude')
local limb = saude:WaitForChild('Variaveis').ShotLimb
local raidTime
local exp = 0 + (player:WaitForChild('raidStatistics').Kills.Value * 200) + (#player:FindFirstChild("Backpack"):GetChildren() * 100)
char:WaitForChild('Humanoid').Died:connect(function()
	local tag = char:WaitForChild('Humanoid'):FindFirstChild("creator") ~= nil and char:WaitForChild('Humanoid'):FindFirstChild("creator").Value and char:WaitForChild('Humanoid'):FindFirstChild("creator").Value.Name or nil
	wait(7)
	if workspace.PermaDeath.Toggle.Value == true then
		local teleData = {
			Killed = true,
			Missing = false,
			XPMult = 0.5,
			XP = exp,
			Looting = (#player:FindFirstChild("Backpack"):GetChildren() * 100),
			Kills = (player:WaitForChild('raidStatistics').Kills.Value * 200),
			duration = raidTime,
			Hit = limb.Value,
			Killer = tag or nil,
		}
	-- game:GetService("TeleportService"):Teleport(6252938991,player,teleData)
	player:Kick("You died! No place to teleport to.")
	end
end)
local Hours = 0 
local Minutes = 0 
local Seconds = 0 
local Milliseconds = 0	 
while char:FindFirstChild('Humanoid').Health > 0 do
	repeat
		local passed = task.wait(.001) 
		Milliseconds = Milliseconds + passed
		if Hours > 0 then
			raidTime = (Hours..":"..Minutes..":"..Seconds)
		else
			raidTime = (Minutes..":"..Seconds)
		end
	until Milliseconds > .99 
	Seconds = Seconds + 1
	Milliseconds = 0
	if Hours > 0 then
		if Seconds < 10 then
			raidTime = (Hours..":"..Minutes..":0"..Seconds)
		else
			raidTime = (Hours..":"..Minutes..":"..Seconds)
		end
	else
		if Seconds < 10 then
			raidTime = (Minutes..":0"..Seconds)
		else
			raidTime = (Minutes..":"..Seconds)
		end
	end
	if Seconds == 60 then 
		Minutes = Minutes + 1 
		Seconds = 0 
		if Hours > 0 then
			raidTime = (Hours..":"..Minutes..":"..Seconds)
		else
			raidTime = (Minutes..":"..Seconds)
		end 
	end
	if Minutes == 60 then 
		Hours = Hours + 1 
		Minutes = 0 
		if Hours > 0 then
			raidTime = (Hours..":"..Minutes..":"..Seconds)
		else
			raidTime = (Minutes..":"..Seconds)
		end
	end
end 