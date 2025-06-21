
repeat
	wait()
until game.Players.LocalPlayer.Character
--// Variables
local L_1_ = game.Players.LocalPlayer
local L_2_ = L_1_.Character

local L_3_ = game.ReplicatedStorage:WaitForChild('ACS_Engine')
local L_4_ = L_3_:WaitForChild('Eventos')
local L_5_ = L_3_:WaitForChild('ServerConfigs')
local L_7_ = L_3_:WaitForChild('HUD')

local L_8_ = true

--// Modules
local L_9_ = require(L_5_:WaitForChild('Config'))

--// Body Parts
local L_11_ = L_2_:WaitForChild('Humanoid')
local L_12_ = L_2_:WaitForChild('HumanoidRootPart')
local L_13_ = L_2_:WaitForChild('Head')

--// Events
local L_14_ = L_4_:WaitForChild('TeamTag')

--// Functions
function spawnTag(L_15_arg1, L_16_arg2)
	if L_15_arg1 and L_15_arg1:FindFirstChild('Head') ~= nil and L_9_.TeamTags then
		if L_15_arg1:FindFirstChild('Head'):FindFirstChild('TeamTag') and L_15_arg1:FindFirstChild('Head') ~= nil then
			L_15_arg1:FindFirstChild('Head').TeamTag:Destroy()
		end
		local L_17_ = L_7_:WaitForChild('TeamTag'):clone()
		L_17_.Parent = L_15_arg1:FindFirstChild('Head')
		L_17_.Enabled = true
			L_17_.Adornee = L_15_arg1:FindFirstChild('Head')
		L_17_.Frame:WaitForChild('Frame').ImageColor3 = L_16_arg2
	end
end

--// Set up
for L_18_forvar1, L_19_forvar2 in pairs(game.Players:GetChildren()) do
	if L_19_forvar2:IsA('Player') and L_19_forvar2.Character and L_19_forvar2.Character:FindFirstChild('Head') ~= nil and L_19_forvar2.Character.Humanoid and L_19_forvar2.Character.Humanoid.Health > 0 then
		if L_19_forvar2.TeamColor == L_1_.TeamColor then
			if L_19_forvar2.Character:WaitForChild("Saude"):WaitForChild("FireTeam").SquadName.Value ~= '' then
				spawnTag(L_19_forvar2.Character, L_19_forvar2.Character:WaitForChild("Saude"):WaitForChild("FireTeam").SquadColor.Value)
			else
				spawnTag(L_19_forvar2.Character, Color3.fromRGB(255,255,255))
			end
		end;
	end;
end

--// Event Connections
L_14_.OnClientEvent:connect(function(L_22_arg1)
	if L_22_arg1.TeamColor == L_1_.TeamColor and L_22_arg1.Character and L_22_arg1.Character:FindFirstChild('Head') then
		if L_22_arg1.Character:WaitForChild("Saude"):WaitForChild("FireTeam").SquadName.Value ~= '' then
			spawnTag(L_22_arg1.Character, L_22_arg1.Character:WaitForChild("Saude"):WaitForChild("FireTeam").SquadColor.Value)
		else
			spawnTag(L_22_arg1.Character, Color3.fromRGB(255,255,255))
		end
	end;
	
	if L_22_arg1.TeamColor ~= L_1_.TeamColor then
		if L_22_arg1.Character and L_22_arg1.Character:FindFirstChild('Head') and L_22_arg1.Character:FindFirstChild('Head'):FindFirstChild('TeamTag') then
			L_22_arg1.Character:FindFirstChild('Head').TeamTag:Destroy()
		end
	end;
end)

--// Player Events

game:GetService("RunService").Heartbeat:connect(function()
	if L_9_.TeamTags then
	for L_32_forvar1, L_33_forvar2 in pairs(game.Players:GetChildren()) do
		if L_33_forvar2:IsA('Player') and L_33_forvar2.TeamColor ~= L_1_.TeamColor and L_33_forvar2 ~= L_1_ and L_33_forvar2.Character and L_13_ then
			if L_33_forvar2.Character:FindFirstChild('Head') and L_33_forvar2.Character:FindFirstChild('Head'):FindFirstChild('TeamTag') then
				L_33_forvar2.Character:FindFirstChild('Head'):FindFirstChild('TeamTag'):Destroy()				
			end
		end

	for L_18_forvar1, L_19_forvar2 in pairs(game.Players:GetChildren()) do
			if L_19_forvar2:IsA('Player') and L_19_forvar2.Character and L_19_forvar2.Character:FindFirstChild('Head') then
		if L_19_forvar2.TeamColor == L_1_.TeamColor then
					if L_19_forvar2.Character:WaitForChild("Saude"):WaitForChild("FireTeam").SquadName.Value ~= '' then
						spawnTag(L_19_forvar2.Character, L_19_forvar2.Character:WaitForChild("Saude"):WaitForChild("FireTeam").SquadColor.Value)
			else
				spawnTag(L_19_forvar2.Character, Color3.fromRGB(255,255,255))
			end
		end;
	end;
end
		end
end
end)