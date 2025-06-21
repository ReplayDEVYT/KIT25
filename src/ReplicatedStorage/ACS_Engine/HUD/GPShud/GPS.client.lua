repeat wait() until game.Players.LocalPlayer.Character

local function WaitForChild(parent, childName, maxWait)
	local startTime = tick()
	while parent:FindFirstChild(childName) == nil do
		wait()
		if maxWait and tick() - startTime > maxWait then
			return nil
		end
	end
	return parent[childName]
end

local Radar_Gui = script.Parent
local Player = game.Players.LocalPlayer
local Character = Player.Character
local Saude = Character:WaitForChild("Saude")
local RadarFrame = WaitForChild(Radar_Gui, 'Frame')
local Engine = game.ReplicatedStorage:WaitForChild('ACS_Engine')
local ServerConfig = require(Engine.ServerConfigs:WaitForChild('Config'))

local RANGE = ServerConfig.GPSdistance

local MinhasVisao = WaitForChild(RadarFrame,'MinhaVisao')
local RosaDosVentos = WaitForChild(RadarFrame,'RosaDosVentos')
local FoeBlip = WaitForChild(RadarFrame, 'FoeBlip')
local FriendBlip = WaitForChild(RadarFrame, 'FriendBlip')

-- Any names (keys) not in this list will be deleted (values must evaluate to true)

-- This is to store other things that may require our radar attention

local Camera = workspace.CurrentCamera

local SaveList = {MinhaVisao = 1, RosaDosVentos = 1, FoeBlip = 1, FriendBlip = 1}
local SquadSave = {UIGridLayout = 1}


Character.Humanoid.Died:Connect(function()
	script.Parent.Enabled = false
end)

game:GetService("RunService").RenderStepped:connect(function()

	local Direction = (Vector2.new(Camera.Focus.x,Camera.Focus.z)-Vector2.new(Camera.CoordinateFrame.x,Camera.CoordinateFrame.z)).Unit
	local theta = (math.atan2(Direction.y,Direction.x))*(-180/math.pi) - 90	

	if Saude.FireTeam.SquadName.Value ~= "" then
		MinhasVisao.ImageColor3 = Saude.FireTeam.SquadColor.Value
	else
		MinhasVisao.ImageColor3 = Color3.fromRGB(255,255,255)
	end
	
	local frame = Vector3.new(Camera.CoordinateFrame.x, 0, Camera.CoordinateFrame.z)
	local focus = Vector3.new(Camera.Focus.x, 0, Camera.Focus.z)
	local frame = CFrame.new(focus, frame)

	script.Parent.Frame.RosaDosVentos.Rotation = theta
	local players = game.Players:GetPlayers()

	if Saude.FireTeam.SquadName.Value ~= "" and Player then
		script.Parent.Squad.Visible = true
		script.Parent.Squad.Esquadrao.Text = Saude:WaitForChild("FireTeam"):WaitForChild("SquadName").Value
	else
		script.Parent.Squad.Visible = false
	end

	local Nomes = script.Parent.Squad.Membros:GetChildren()
	for i = 1, #Nomes do
		if not SquadSave[Nomes[i].Name] then
			Nomes[i]:Destroy()
		end
	end

	for i = 1, #players do
		if players[i] ~= Player and players[i].Character and Player and Player.Character then
			local unit = script.Parent.Squad.Membros:FindFirstChild(players[i].Name)
			if not unit then
				if players[i].TeamColor == Player.TeamColor and players[i].Character:WaitForChild("Saude"):WaitForChild("FireTeam"):WaitForChild("SquadName").Value == Player.Character:WaitForChild("Saude"):WaitForChild("FireTeam"):WaitForChild("SquadName").Value and Player.Character:WaitForChild("Saude"):WaitForChild("FireTeam"):WaitForChild("SquadName").Value ~= "" then
					unit = script.Parent.Squad.Exemplo:Clone()
					unit.Visible = true
					unit.Text = players[i].Name
					unit.Name = players[i].Name
					unit.Parent = script.Parent.Squad.Membros
				end
			end
		end
	end


	local labels = RadarFrame:GetChildren()
	for i = 1, #labels do
		if not SaveList[labels[i].Name] then
			labels[i]:Destroy()
		end
	end

	for i = 1, #players do
		if players[i] ~= Player and players[i].Character and Player and Player.Character then
			local unit = RadarFrame:FindFirstChild(players[i].Name)
			if not unit then
				if players[i].TeamColor == Player.TeamColor then
					unit = FriendBlip:Clone()
				else
					unit = FoeBlip:Clone()
				end
				unit.Visible = false
				unit.Name = players[i].Name
				unit.Parent = RadarFrame
			end


			if players[i].Character:FindFirstChild('Humanoid') and players[i].Character:FindFirstChild('HumanoidRootPart') then

				-- Get the relative position of the players
				local pos = CFrame.new(players[i].Character.HumanoidRootPart.Position.X, 0, players[i].Character.HumanoidRootPart.Position.Z)
				local relativeCFrame = frame:inverse() * pos
				local distanceRatio = relativeCFrame.p.Magnitude/RANGE
				if distanceRatio < 0.9 then
					local xScale = 0.5 - ((relativeCFrame.x/RANGE)/2)
					local yScale = 0.5 - ((relativeCFrame.z/RANGE)/2)
					unit.Position = UDim2.new(xScale, 0, yScale, 0)
					unit.Rotation = -players[i].Character.HumanoidRootPart.Orientation.Y + theta
				
				if players[i].TeamColor == Player.TeamColor then
						if players[i].Character:WaitForChild("Saude"):WaitForChild("FireTeam"):WaitForChild("SquadName").Value ~= "" then
							unit.ImageColor3 = players[i].Character:WaitForChild("Saude"):WaitForChild("FireTeam"):WaitForChild("SquadColor").Value
					else
						unit.ImageColor3 = FriendBlip.ImageColor3
					end
				else
					unit.ImageColor3 = FoeBlip.ImageColor3
				end
					unit.Visible = true
					
				else
					unit.Visible = false
				end
			else
				unit.Visible = false
			end
		end
	end
end)
