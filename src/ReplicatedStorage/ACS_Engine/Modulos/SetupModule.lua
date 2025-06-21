local Engine = game.ReplicatedStorage:WaitForChild("ACS_Engine")
local Mod = Engine:WaitForChild("Modulos")
local Ultil = require(Mod:WaitForChild("Utilities"))
local player = game:GetService("Players").LocalPlayer
return function(armModel,utilities,char,RA,RAW,LA,LAW,AnimBase,AnimBaseW,config,curGun)
	local raw
	local law
	local ra
	local la
	local Grip
	local GripW
	local arms = script.Parent.Parent.Arms
	local redarms = script.Parent.Parent.Arms.REDFOR
	local zeusarms = script.Parent.Parent.Arms.ZEUS
	local bluarms = script.Parent.Parent.Arms.BLUFOR
	local usecarms = script.Parent.Parent.Arms.USEC
	local beararms = script.Parent.Parent.Arms.BEAR
	local value = player.Character:FindFirstChild("Saude").Variaveis.Arms
	local clock = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("clock")
	
	
	teambasedarms = true
	scavarms = true
	rngarms = arms.SCAV:GetChildren()
	
		
	if teambasedarms == true then --v_suzuki
		if player.TeamColor == redarms.Team.Value then
			ra = redarms:FindFirstChild('Right Arm'):clone()
			la = redarms:FindFirstChild('Left Arm'):clone()
		elseif player.TeamColor == bluarms.Team.Value then
			ra = bluarms:FindFirstChild('Right Arm'):clone()
			la = bluarms:FindFirstChild('Left Arm'):clone()
		elseif player.TeamColor == zeusarms.Team.Value then
			ra = zeusarms:FindFirstChild('Right Arm'):clone()
			la = zeusarms:FindFirstChild('Left Arm'):clone()
		elseif player.TeamColor == beararms.Team.Value then
			ra = beararms:FindFirstChild('Right Arm'):clone()
			la = beararms:FindFirstChild('Left Arm'):clone()
		elseif player.TeamColor == usecarms.Team.Value then
			ra = usecarms:FindFirstChild('Right Arm'):clone()
			la = usecarms:FindFirstChild('Left Arm'):clone()
		elseif player.TeamColor ~= bluarms.Team.Value and player.TeamColor ~= redarms.Team.Value and player.TeamColor ~= usecarms.Team.Value and player.TeamColor ~= beararms.Team.Value then
			if scavarms == true then
				ra = value.Value:FindFirstChild("Right Arm"):clone()
				la = value.Value:FindFirstChild("Left Arm"):clone()
				else
				ra = arms:FindFirstChild('Right Arm'):clone()
				la = arms:FindFirstChild('Left Arm'):clone()
				end
		end
	
	--[[else
		repeat wait() until value.Value ~= nil
		ra = value.Value:WaitForChild("Right Arm"):clone()
		la = value.Value:WaitForChild("Left Arm"):clone()]]--
	end
	ra:FindFirstChild("Arm").Color = player.Character["Right Arm"].Color
	la:FindFirstChild("Arm").Color = player.Character["Left Arm"].Color
	--clock.Parent = la:WaitForChild("clockpart")
	clock.Adornee = la:WaitForChild("clockpart")
	clock.Enabled = true
	clock.ClockMain.Enabled = true
	--print("yahoooo!! "..tostring(clock.Face).." "..clock.Adornee.Name)
		ra.Parent = armModel
		raw = Instance.new('Motor6D')
		raw.Name = 'RAW'
		raw.Parent = AnimBase	
		raw.Part0 = AnimBase
		raw.Part1 = ra
		raw.C1 = config.RightPos
		
		la.Parent = armModel
		law = Instance.new('Motor6D')
		law.Name = 'LAW'
		law.Parent = AnimBase
		law.Part0 = AnimBase
		law.Part1 = la
		law.C1 = config.LeftPos
		
		Grip = curGun:WaitForChild('Handle')
		GripW = Instance.new('Motor6D')
		GripW.Name = 'GripW'
		GripW.Parent = Grip
		GripW.Part0 = ra
		GripW.Part1 = Grip
		Grip.Anchored = false
	GripW.C1 = config.GunPos


	return raw,law,ra,la,Grip,GripW
end