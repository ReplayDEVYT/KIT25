local players = game:GetService("Players")
local events = game:GetService('ReplicatedStorage').ExtractEvents
local Zone = require(game.ReplicatedStorage:WaitForChild("Zone"))

local WS = workspace.ExtractSystem
local config = WS.MainConfig
local Settings = require(config.Config)
local settingvalue = config.Values
function UpdateSettings()
	for i,valu in pairs(settingvalue:GetChildren()) do
		if Settings[valu.Name] ~= nil then
			valu.Value = Settings[valu.Name]
		end
	end
end

local transitextract = false
local transitplace = 0

function UpdateSettingsReverse()
	for i,valu in pairs(settingvalue:GetChildren()) do
		if Settings[valu.Name] ~= nil then
			Settings[valu.Name] = valu.Value
		end
	end
end

UpdateSettings()
for i,changed in pairs(settingvalue:GetChildren()) do
	changed.Changed:connect(UpdateSettingsReverse)
end
local playerval
local oldplayer
local exits = WS.Exits
for i,v in pairs(exits:GetChildren()) do
	if v:IsA("BasePart") then
		--exit = v
		v.Transparency = 1
		print(v.Name)
		
		

		local zone = Zone.new(v)
		zone:bindToGroup("Extracts")
		zone.playerEntered:Connect(function(player)
			local char = player.Character
			if char ~= nil and char:FindFirstChild("Humanoid") and v.Config.AlwaysOpen.Used.Value == false and v.Config.CanExtract.Value == true then
				local hum = char:FindFirstChild("Humanoid")
				if player ~= nil then
					local playerhud = player.PlayerGui:FindFirstChild("RaidTimer")

					if v.Config.AlwaysOpen.Value == false then
						v.Config.AlwaysOpen.Used.Value = true
					end
					if v.Config.Transit.Value == true then
						transitextract = true
					elseif v.Config.Transit.Value == false then
						transitextract = false
					end
					if v.Config.Requirements.Value == true then
						if v.Config.Requirements:FindFirstChild("Event") and v.Config.Requirements.Event.Value ~= "" and v.Config.Requirements.Event.Done.Value == true then

						elseif v.Config.Requirements:FindFirstChild("Stat") and v.Config.Requirements.Stat.Value ~= "" then

						elseif v.Config.Requirements:FindFirstChild("Money") and v.Config.Requirements.Money.Value ~= "" then

						end
					end
					if transitextract == false then
						print(player.Name.." is extracting at "..v.Name)
					elseif transitextract == true then
						print(player.Name.." is starting transit")
					end

					playerhud.InExit.Value = true
					playerhud.InExit.Firer.Value = "Server"

					if v.Config:FindFirstChild("Time") then
						events.PlayerExiting:FireClient(player,player,v,v.Config:FindFirstChild("Time").Value,playerhud.InExit.Value,true)
					elseif v.Config:FindFirstChild("Time") == nil then
						events.PlayerExiting:FireClient(player,player,v,nil,playerhud.InExit.Value,true)
					end


					--[[while hum ~= nil and playerhud ~= nil do
						wait()
						local distance = (hit.Parent:FindFirstChild("Torso").Position - v.Position).magnitude
						local exitdistance = (v.Position.magnitude)
						--if hit.Parent.Torso.Position.magnitude <= exitdistance then
						if player:DistanceFromCharacter(v.Position) <= (v.Size.magnitude*0.5) then
							playerhud.InExit.Value = true
							playerhud.InExit.Firer.Value = "Server"
						else
							playerhud.InExit.Value = false
							playerhud.InExit.Firer.Value = "Server"
						end
					end]]--
				end
			end
		end)

		zone.playerExited:Connect(function(player)
			local playerhud = player.PlayerGui:FindFirstChild("RaidTimer")
			playerhud.InExit.Value = false
			playerhud.InExit.Firer.Value = "Server"

			if v.Config.AlwaysOpen.Value == false then
				v.Config.AlwaysOpen.Used.Value = false
			end
			if v.Config:FindFirstChild("Time") then
				events.PlayerExiting:FireClient(player,player,v,v.Config:FindFirstChild("Time").Value,playerhud.InExit.Value,true)
			elseif v.Config:FindFirstChild("Time") == nil then
				events.PlayerExiting:FireClient(player,player,v,nil,playerhud.InExit.Value,true)
			end

		end)

		--[[v.Touched:connect(function(hit)
			--print("i touch something")
			if hit.Parent ~= nil and hit.Parent:FindFirstChild("Humanoid") and v.Config.AlwaysOpen.Used.Value == false and v.Config.CanExtract.Value == true and (oldplayer ~= nil and hit.Parent.Name ~= oldplayer or oldplayer == nil) then
				local hum = hit.Parent:FindFirstChild("Humanoid")
				local player = players:GetPlayerFromCharacter(hit.Parent)
				oldplayer = hit.Parent.Name
				if player ~= nil then
					local playerhud = player.PlayerGui:FindFirstChild("RaidTimer")
					playerhud.InExit.Changed:connect(function()
						if playerhud.InExit.Value == true then
					if v.Config.AlwaysOpen.Value == false then
						v.Config.AlwaysOpen.Used.Value = true
					end
					if v.Config.Requirements.Value == true then
						if v.Config.Requirements.Event.Value ~= "" and v.Config.Requirements.Event.Done.Value == true then

						elseif v.Config.Requirements.Stat.Value ~= "" then

						elseif v.Config.Requirements.Money.Value ~= "" then

						end
					end
					print(player.Name.." is extracting at "..v.Name)
					
					if v.Config:FindFirstChild("Time") then
								events.PlayerExiting:FireClient(player,player,v,v.Config:FindFirstChild("Time").Value,playerhud.InExit.Value,true)
						elseif v.Config:FindFirstChild("Time") == nil then
						events.PlayerExiting:FireClient(player,player,v,nil,playerhud.InExit.Value,true)
							end
					else
							if v.Config.AlwaysOpen.Value == false then
								v.Config.AlwaysOpen.Used.Value = false
							end
							if v.Config:FindFirstChild("Time") then
								events.PlayerExiting:FireClient(player,player,v,v.Config:FindFirstChild("Time").Value,playerhud.InExit.Value,true)
							elseif v.Config:FindFirstChild("Time") == nil then
								events.PlayerExiting:FireClient(player,player,v,nil,playerhud.InExit.Value,true)
							end
					end
						--de = true
					end)
					while hum ~= nil and playerhud ~= nil do
						wait()
						local distance = (hit.Parent:FindFirstChild("Torso").Position - v.Position).magnitude
						local exitdistance = (v.Position.magnitude)
						--if hit.Parent.Torso.Position.magnitude <= exitdistance then
						if player:DistanceFromCharacter(v.Position) <= (v.Size.magnitude*0.5) then
							playerhud.InExit.Value = true
							playerhud.InExit.Firer.Value = "Server"
						else
							playerhud.InExit.Value = false
							playerhud.InExit.Firer.Value = "Server"
						end
					end
				end
			end
		end)]]--
	end
end

workspace:WaitForChild("PermaDeath").Toggle.Changed:Connect(function()
	game.Players.CharacterAutoLoads = not workspace:WaitForChild("PermaDeath").Toggle.Value
end)

game.Players.CharacterAutoLoads = not workspace:WaitForChild("PermaDeath").Toggle.Value

events.PlayerExiting.OnServerEvent:connect(function(player,exit2,exitvalue,timer)
	if exitvalue == true then
		if transitextract == false then
			--de = false
			oldplayer = nil
			if player ~= nil and exit2 ~= nil and timer ~= nil then
				local Player = player
				local del = exit2.Parent:FindFirstChild("Del"..exit2.Name)
				local badgeService = game:GetService("BadgeService")
				local id = 930045441378817
				if del ~= nil then
					del:Destroy()
				end
				player.Character.Humanoid:UnequipTools()
				local dumpfolder = Instance.new("Folder",game.ReplicatedStorage)
				dumpfolder.Name = player.Name
				player.Character.Parent = dumpfolder
				--oldplayer = player
				badgeService:AwardBadge(player.UserId, id)
				print(player.Name.." has extracted")
				wait(2.5)
				local exp = 300 + (Player:WaitForChild('raidStatistics').Kills.Value * 200) + (#Player:FindFirstChild("Backpack"):GetChildren() * 100)
				local tools = {}
				for i,tool in pairs(Player:FindFirstChild("Backpack"):GetChildren()) do
					if tool:IsA('Tool') then
						print(tool.Name.." is a tool lol")
						table.insert(tools,tool)
					end
				end
				local TeleportData = {
					Killed = false,
					Missing = false,
					XPMult = 1.5,
					XP = exp,
					Looting = (#Player:FindFirstChild("Backpack"):GetChildren() * 100),
					Kills = (Player:WaitForChild('raidStatistics').Kills.Value * 200),
					duration = timer,
					Hit = nil,
					Killer = nil,
					Tools = tools
				}
				if tools[1] then
					print(tools[1].Name.." for confirmation of the tools")
				end
				--game:GetService("TeleportService"):Teleport(6252938991,Player,TeleportData)
				Player:Kick("No place to teleport to when extracting.")
				dumpfolder:Destroy()
			end
		elseif transitextract == true then
			--de = false
			oldplayer = nil
			if player ~= nil and exit2 ~= nil and timer ~= nil then
				local Player = player
				local del = exit2.Parent:FindFirstChild("Del"..exit2.Name)
				local badgeService = game:GetService("BadgeService")
				local id = 84380672686294
				if del ~= nil then
					del:Destroy()
				end
				player.Character.Humanoid:UnequipTools()
				local dumpfolder = Instance.new("Folder",game.ReplicatedStorage)
				dumpfolder.Name = player.Name
				player.Character.Parent = dumpfolder
				--oldplayer = player
				badgeService:AwardBadge(player.UserId, id)
				wait(2.5)
				local exp = 300 + (Player:WaitForChild('raidStatistics').Kills.Value * 200) + (#Player:FindFirstChild("Backpack"):GetChildren() * 100)
				local tools = {}
				for i,tool in pairs(Player:FindFirstChild("Backpack"):GetChildren()) do
					if tool:IsA('Tool') then
						print(tool.Name.." is a tool lol")
						table.insert(tools,tool)
					end
				end
				local TeleportData = {
					Killed = false,
					Missing = false,
					XPMult = 1.5,
					XP = exp,
					Looting = (#Player:FindFirstChild("Backpack"):GetChildren() * 100),
					Kills = (Player:WaitForChild('raidStatistics').Kills.Value * 200),
					duration = timer,
					Hit = nil,
					Killer = nil,
					Tools = tools
				}
				if tools[1] then
					print(tools[1].Name.." for confirmation of the tools")
				end
				--game:GetService("TeleportService"):Teleport(exit2.Config.TransitID.Value,Player,TeleportData)
				Player:Kick("No place to teleport to when extracting.")
				dumpfolder:Destroy()
			end
		end
	end
end)