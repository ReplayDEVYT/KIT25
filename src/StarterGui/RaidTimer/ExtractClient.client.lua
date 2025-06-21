if not game:IsLoaded() then
	repeat task.wait() until game:IsLoaded()
end

--
local main = script.Parent
local timer = main:WaitForChild("Timer")
local exits = main:WaitForChild("Extracts")
local leave = main:WaitForChild("Leaving")
local failsound = main:WaitForChild("RaidFail")
local winsound = main:WaitForChild("RaidSuccess")
local ts = require(game.ReplicatedStorage.TService)
local UIS = game:GetService("UserInputService")
local Engine = workspace:WaitForChild("ExtractSystem")
local extracts = Engine:WaitForChild("Exits")

local config = Engine.MainConfig
local Settings = require(config.Config)
local settingvalue = config.Values


Player = game.Players.LocalPlayer
Character = Player.Character
Human = Character:WaitForChild("Humanoid")
local Mouse = Player:GetMouse()
local de = false
Tapped = false
TapTime = 0.25
local exitexample = main.Examples.Example
local events = game:GetService("ReplicatedStorage").ExtractEvents
local TPService = game:GetService('TeleportService')
local raidTime
local timeLimit
local timeValue = main.RaidTime
local inSeconds = ((Settings.TimeHours*120) + (Settings.TimeMinutes*60) + Settings.TimeSeconds)
--print("Raid time (in seconds) "..tostring(inSeconds))
local exitList = {}
local myExits = {}
local exitAmnt = (Settings.MaxExits + 1)
local lastValue = script.Parent.InExit.Value
local maxexits = exitAmnt
local currentExit
local realExit
local allexits = extracts:GetChildren()

for i,ext in pairs(allexits) do
	if ext:IsA("BasePart") then
		table.insert(exitList,ext)
	end
end

print("Raid Started")
print("Pre-randomized Exits:", #exitList)

local randomizedExits
function setup()
	--print("setup")
	timer.Visible = false
	leave.Visible = false
	exits.Visible = false
	local function RandomizeTable(tbl)
		local returntbl={}
		if tbl[1]~=nil then
			for i=1,#tbl do
				table.insert(returntbl,math.random(1,#returntbl+1),tbl[i])
			end
		end
		return returntbl
	end

	randomizedExits = RandomizeTable(exitList)

	--RandomizeTable(exitList)
	for i,v in pairs(randomizedExits) do
		if v:IsA("BasePart") then
			local config = v:WaitForChild("Config")
			exitAmnt = exitAmnt - 1
			if exitAmnt == 0 then
				print("erm no extracts")
			end
			if exitAmnt > 0 then
				local clone = exitexample:Clone()
				clone.Parent = exits
				v.Transparency = 1
				local name = v.Name
				local config = v:WaitForChild("Config")
				local exitnum = tostring(maxexits-exitAmnt)--tostring(config.ExitNumber.Value)
				local alwaysopen = config.AlwaysOpen
				local requirements = config.Requirements
				clone.Name = exitnum.." - "..name
				--	if config.Transit.Value == true then
				--		clone.Name = exitnum.." - "..name
				--	else
				--		clone.Name = exitnum.." - "..name
				-- clone.Message.Frame.ExtNumber:FindFirstChild("ExtNumber") = Color3.fromRGB(255, 170, 0)
				-- end
				if alwaysopen.Value == false then
					clone.Time.Visible = true
					clone.Time.Text = "??:??:??"
				end
				if config.Transit.Value == true then
					clone.Time.Visible = true
					clone.Time.Text = "TRANSIT"
				end
				if requirements.Value == true then
					local money = requirements:FindFirstChild("Money")
					local event = requirements:FindFirstChild("Event")
					local stat = requirements:FindFirstChild("Stat")
					clone.Message.Requirement.Visible = true
					if money ~= nil and money.Value ~= "" then
						clone.Message.Requirement.Text = "Bring "..money.Value.." ("..money.Amount.Value..")"
					elseif event ~= nil and event.Value ~= "" then
						clone.Message.Requirement.Text = event.Value
					elseif stat ~= nil and stat.Value ~= "" then
						clone.Message.Requirement.Text = "Needs "..stat.Amount.Value.." "..stat.Value.." ("..stat.Type.Value..")"
					end
				end
				if alwaysopen.Used.Value == false then
					clone.Time.TextColor3 = Color3.fromRGB(255,255,255)
					clone.Message.ExtName.TextColor3 = Color3.fromRGB(255,255,255)
					clone.Message.Frame.ExtNumber.TextColor3 = Color3.fromRGB(255,255,255)
				else
					clone.Time.TextColor3 = Color3.fromRGB(255,0,0)
					clone.Message.ExtName.TextColor3 = Color3.fromRGB(255,0,0)
					clone.Message.Frame.ExtNumber.TextColor3 = Color3.fromRGB(255,0,0)
					clone.Message.Requirement.Visible = false
				end
				if config.Transit.Value == true then
					clone.Time.TextColor3 = Color3.fromRGB(255, 192, 65)
				end
				clone.Message.Frame:WaitForChild("ExtNumber").Text = "EXIT0"..exitnum
				clone.Message:WaitForChild("ExtName").Text = name
				clone.Message.Frame:WaitForChild("ExtNumber").TextColor3 = Color3.fromRGB(255, 255, 255)
				--	if config.Transit.Value == true then
				--		clone.Message.Frame:WaitForChild("ExtNumber").Text = "TRANS0"..exitnum
				--		clone.Message:WaitForChild("ExtName").Text = name
				--		clone.Message.Frame:WaitForChild("ExtName").TextColor3 = Color3.fromRGB(255, 192, 65)
				--	else
				--		clone.Message.Frame:WaitForChild("ExtNumber").Text = "EXIT0"..exitnum
				--		clone.Message:WaitForChild("ExtName").Text = name
				--		clone.Message.Frame:WaitForChild("ExtNumber").TextColor3 = Color3.fromRGB(255, 255, 255)
				--	end
				clone.Visible = true
			end
		end
	end
end

function opentimer(view,text,mode)
	if de == false then
		de = true
		timer.Visible = true
		if view == true then
			local mes = timer.Clip.Message
			if text ~= nil then
				mes.Text.Text = tostring(text)
			end
			ts(mes,TweenInfo.new(0.35),{Position = UDim2.new(0.25,0,0,0)}):Play()
			wait(1)
			exits.Visible = true
			ts(exits,TweenInfo.new(0.5),{Position = UDim2.new(0.9,0,0.055,0)}):Play()
		end
		if mode ~= nil and mode == "Quick" then
			delay(3,function()
				closetimer()
			end)
		else
			wait(5)
			closetimer()
		end

	end
end
function closetimer()
	if exits.Visible == true and de == true then
		ts(exits,TweenInfo.new(0.5),{Position = UDim2.new(0.9,0,-0.3,0)}):Play()
		wait(1)
		exits.Visible = false
		local mes  = timer.Clip.Message
		ts(mes,TweenInfo.new(0.35),{Position = UDim2.new(1.5,0,0,0)}):Play()
		wait(1)
	end
	timer.Visible = false
	wait(1)
	de = false
end

Mouse.KeyDown:connect(function(key)
	if key == "y" then
		--print("somewhat working")
		if not Tapped then
			Tapped = true
			wait(TapTime)
			Tapped = false
			opentimer(false,"Find an extraction point.")
			--print("OpenTimer")
		else
			opentimer(true,"Find an extraction point.")
			--print("OpenTimer with extracts")
		end
	end
end)

function Leaving(plyr,exit,timer,exitvalue,firedServer)
	--if exitvalue ~= lastValue and firedServer ~= nil --[[and realExit ~= nil]] then
	for i,pod in pairs(extracts:GetChildren()) do
		if pod:IsA("Part") and pod.Name == exit.Name then
			realExit = pod.Name
		end
	end
	if realExit ~= nil then
		for i,pod2 in pairs(exits:GetChildren()) do
			if pod2.Name:lower():find(realExit:lower()) then
				currentExit = pod2.Name
			end
		end
	end
	print(currentExit)
	if not currentExit or not exits:FindFirstChild(currentExit) then return end
	--print(exit.Name)
	--print(realExit.." is real exit")
	local count = main.Countdown
	if timer ~= nil then
		count.Value = timer
	else
		count.Value = 10
	end
	if exitvalue == true then
		print("PlayerExiting client")
		if plyr ~= nil and exit ~= nil and exitvalue == true and plyr:DistanceFromCharacter(exit.Position) <= (exit.Size.magnitude*0.5) then
			for i,v in pairs(leave:GetDescendants()) do
				if v:IsA("TextLabel") then
					v.BackgroundTransparency = 1
					v.TextTransparency = 1
					v.TextStrokeTransparency = 1
				elseif v:IsA("ImageLabel") then
					v.BackgroundTransparency = 1
					v.ImageTransparency = 1
				end
			end
			delay(1.75,function()
				ts(exits:FindFirstChild(currentExit).Message.Frame, TweenInfo.new(0.25,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut,0,true), {BackgroundColor3 =  Color3.fromRGB(170, 255, 0)}):Play()
				ts(exits:FindFirstChild(currentExit).Message.ExtName, TweenInfo.new(0.25,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut,0,true), {BackgroundColor3 =  Color3.fromRGB(170, 255, 0)}):Play()
			end)
			exits:FindFirstChild(currentExit).Message.Frame.ExtNumber.TextColor3 = Color3.fromRGB(170, 255, 0)
			opentimer(true,"Stay in the extraction point","Quick")
			leave.Visible = true
			for i,x in pairs(leave:GetDescendants()) do
				if x.Name == "Text" then
					ts(x,TweenInfo.new(2),{BackgroundTransparency = 0.25,TextTransparency = 0}):Play()
				elseif x.Name == "Time" then
					ts(x,TweenInfo.new(2),{TextTransparency = 0}):Play()
				elseif x.Name == "ImageLabel" then
					ts(x,TweenInfo.new(2),{BackgroundTransparency = 0.25,ImageTransparency = 0}):Play()
				end
			end
			while count.Value >= 0  do
				task.wait()
				if exitvalue == true and plyr:DistanceFromCharacter(exit.Position) <= (exit.Size.magnitude*0.5) then
					task.wait(0.01)
					count.Value = count.Value - 0.05
					leave.Message.Text.Text = "Extraction in "..tostring(string.format("%.2f",count.Value))
					if count.Value <= 0.05 and exitvalue == true and plyr:DistanceFromCharacter(exit.Position) <= (exit.Size.magnitude*0.5) then
						leave.Message.Text.Text = "Extraction in 0.00"
						local	fade = script.Parent.fade
						fade.Visible = true
						fade.BackgroundTransparency = 1
						ts(fade,TweenInfo.new(2),{BackgroundTransparency = 0}):Play()
						local	SKP_6 = game:GetService("StarterGui")
						SKP_6:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
						break
					end
				elseif exitvalue == false or (exit ~= nil and plyr:DistanceFromCharacter(exit.Position) > (exit.Size.magnitude*0.5) or exit == nil) then
					break
				end
			end
			if script.Parent.InExit.Value == true then
				task.wait(3)
				--winsound:Play()
				--task.wait(winsound.TimeLength)
				events.PlayerExiting:FireServer(exit,script.Parent.InExit.Value,raidTime)
				--game:GetService("TeleportService"):Teleport(tonumber(place.Value))
				--[[wait(2)
				--if workspace.PermaDeath.Toggle.Value == true then
				local exp = 300 + (Player:WaitForChild('raidStatistics').Kills.Value * 200) + (#Player:FindFirstChild("Backpack"):GetChildren() * 100)
				local tools = {}
				for i,tool in pairs(Player:FindFirstChild("Backpack"):GetChildren()) do
					if tool:IsA('Tool') then
						print(tool.Name.." is a tool lol")
						table.insert(tools,tool)
					end
				end
				local teleData = {
					Killed = false,
					Missing = false,
					XPMult = 1.5,
					XP = exp,
					Looting = (#Player:FindFirstChild("Backpack"):GetChildren() * 100),
					Kills = (Player:WaitForChild('raidStatistics').Kills.Value * 200),
					duration = raidTime,
					Hit = nil,
					Killer = nil,
					Tools = tools
				}]]--
				--print(tools[1].Name.." for confirmation of the tools")
				--game:GetService("TeleportService"):Teleport(6252938991,Player,teleData)
				--end
		--[[fade.Text.Visible = true
		fade.quack:Play()
		wait(5)
		SKP_6:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
		SKP_6:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)]]--
				--Player:LoadCharacter()
			elseif script.Parent.InExit.Value == false then
				for i,x in pairs(leave:GetDescendants()) do
					if x.Name == "Text" then
						ts(x,TweenInfo.new(0.5),{BackgroundTransparency = 1,TextTransparency = 1,TextStrokeTransparency = 1}):Play()
					elseif x.Name == "Time" then
						ts(x,TweenInfo.new(0.5),{TextTransparency = 1,TextStrokeTransparency = 1}):Play()
					elseif x.Name == "ImageLabel" then
						ts(x,TweenInfo.new(0.5),{BackgroundTransparency = 1,ImageTransparency = 1}):Play()
					end
				end
				task.wait(0.5)
				leave.Visible = false
			end
		end
	elseif exitvalue == false then
		for i,x in pairs(leave:GetDescendants()) do
			if x.Name == "Text" then
				ts(x,TweenInfo.new(0.5),{BackgroundTransparency = 1,TextTransparency = 1,TextStrokeTransparency = 1}):Play()
			elseif x.Name == "Time" then
				ts(x,TweenInfo.new(0.5),{TextTransparency = 1,TextStrokeTransparency = 1}):Play()
			elseif x.Name == "ImageLabel" then
				ts(x,TweenInfo.new(0.5),{BackgroundTransparency = 1,ImageTransparency = 1}):Play()
			end
		end
		task.wait(0.5)
		leave.Visible = false
	end
	--end
	lastValue = exitvalue
end

--[[script.Parent.InExit.Changed:connect(function()
	Leaving(Player)
end)]]--
events.PlayerExiting.OnClientEvent:connect(Leaving)

setup()
print("Randomized Exits:", #randomizedExits)  -- Check if the list has entries

local Hours = 0 
local Minutes = 0 
local Seconds = 0 
local Milliseconds = 0
while Character:FindFirstChild('Humanoid').Health > 0 do
	timeLimit = Engine.Timer.Value
	timeHours = Settings.TimeHours
	timeMinutes = Settings.TimeMinutes
	timeSeconds = Settings.TimeSeconds
	if timeLimit ~= nil then
		if timeMinutes <= 0 and timeSeconds <= 0 or (timeLimit == "00:00:00" or timeLimit == "00:0:0" or timeLimit == "00:00:0") then 
			wait(Settings.TimeBeforeExit)
			print("Missing in Action!")
			local fade = script.Parent.fade
			fade.Visible = true
			fade.BackgroundTransparency = 1
			ts(fade,TweenInfo.new(2),{BackgroundTransparency = 0}):Play()
			local SKP_6 = game:GetService("StarterGui")
			SKP_6:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
			wait(2.25)
			--failsound:Play()
			local exp = 50 + (Player:WaitForChild('raidStatistics').Kills.Value * 200) + (#Player:FindFirstChild("Backpack"):GetChildren() * 100)
			local teleData = {
				Killed = false,
				Missing = true,
				XPMult = 0.85,
				XP = exp,
				Looting = (#Player:FindFirstChild("Backpack"):GetChildren() * 100),
				Kills = (Player:WaitForChild('raidStatistics').Kills.Value * 200),
				duration = raidTime,
				Hit = nil,
				Killer = nil,
			}
			task.wait(3)
			game:GetService("TeleportService"):Teleport(6252938991,Player,teleData)
			break
		end
		timeValue.Value = tostring(timeLimit)
		timer.Time.Text = timeValue.Value
		if timeMinutes <= 10 then
			timer.Time.TextColor3 = Color3.fromRGB(255,0,0)
			timer.Visible = true
		elseif timeMinutes > 10 then
			timer.Time.TextColor3 = Color3.fromRGB(255,255,255)
		end
	end
	repeat
		local passed = wait(.001) 
		Milliseconds = Milliseconds + passed
	until Milliseconds > .99 
	--print(tostring(timeLimit))
	Seconds = Seconds + 1
	Milliseconds = 0

	if Seconds == 60 then 
		Minutes = Minutes + 1 
		Seconds = 0 
	end
	if Minutes == 60 then 
		Hours = Hours + 1 
		Minutes = 0
	end

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
end 