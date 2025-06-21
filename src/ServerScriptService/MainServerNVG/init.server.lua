script:WaitForChild("MainNVG").Parent = game.StarterPlayer.StarterPlayerScripts

script.Parent = game.ServerScriptService
local nvgevent = Instance.new("RemoteEvent")
nvgevent.Name = "nvg"
nvgevent.Parent = game.ReplicatedStorage

local nvgevent2 = Instance.new("RemoteEvent")
nvgevent2.Name = "nvg2"
nvgevent2.Parent = game.ReplicatedStorage

local activenvgs = {}
local previoustoggle = {}

nvgevent.OnServerEvent:Connect(function(plr)
	if plr.Character then
		local helmet = plr.Character:FindFirstChild("Helmet") or plr.Character:FindFirstChild("Top")
		if helmet then
			local nvg = helmet:FindFirstChild("Up")
			if nvg then
				local id = plr.Name
				local prevtoggle = previoustoggle[id]
				local newt = time()
				if not prevtoggle or newt - prevtoggle > 0.6 then
					previoustoggle[id] = newt
					local bool
					if activenvgs[id] then
						activenvgs[id] = nil
						bool = false
					else
						activenvgs[id] = nvg
						bool = true
					end
					for _, v in pairs(game.Players:GetPlayers()) do
						if v ~= plr then
							pcall(function() -- evita erros caso cliente tenha desconectado
								nvgevent:FireClient(v, nvg, bool)
							end)
						end
					end
				end	
			end
		end
	end	
end)

nvgevent2.OnServerEvent:Connect(function(plr)
	if plr.Character then
		local helmet = plr.Character:FindFirstChild("Helmet")
		if helmet then
			local nvg = helmet:FindFirstChild("Up")
			if nvg then
				local id = plr.Name
				local prevtoggle = previoustoggle[id]
				local newt = time()
				if not prevtoggle or newt - prevtoggle > 0.6 then
					previoustoggle[id] = newt
					local bool
					if activenvgs[id] then
						activenvgs[id] = nil
						bool = false
					else
						activenvgs[id] = nvg
						bool = true
					end
					for _, v in pairs(game.Players:GetPlayers()) do
						if v ~= plr then
							pcall(function()
								nvgevent2:FireClient(v, nvg, bool)
							end)
						end
					end
				end	
			end
		end
	end	
end)

local enabledautolighting = script:WaitForChild("EnableAutoLighting")

if enabledautolighting.Value then

	local lighting = game.Lighting
	local secs = lighting.ClockTime * 3600
	local speed = script:WaitForChild("TimeSpeed").Value

	game:GetService("RunService").Heartbeat:Connect(function(dt)
		secs = secs + dt * speed
		if secs >= 86400 then
			secs = secs - 86400
		end
		lighting.ClockTime = secs / 3600
	end)

end

for _, v in pairs(script:GetChildren()) do
	if string.match(v.ClassName, "Value") then
		v.Parent = game.ReplicatedStorage
	end
end

game.Players.PlayerAdded:Connect(function(plr)
	for _, nvg in pairs(activenvgs) do
		if nvg then
			pcall(function()
				nvgevent:FireClient(plr, nvg, true)
				-- nvgevent2:FireClient(plr, nvg, true)
			end)
		end
	end
end)

game.Players.PlayerRemoving:Connect(function(plr)
	local id = plr.Name
	if activenvgs[id] then
		activenvgs[id] = nil
		for _, v in pairs(game.Players:GetPlayers()) do
			if v ~= plr then
				pcall(function()
					nvgevent2:FireClient(v, nil, false) -- envia nil para indicar desligado
				end)
			end
		end
	end
end)