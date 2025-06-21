local Warp = require(game:GetService("ReplicatedStorage").Warp);


-- events
local FootstepReplication = {
	Play = Warp.Server("PlayFootstep")
}


FootstepReplication.Play:Connect(function(plr,id,volume,timestamp,parent,maxDistance)
	--print('Got from client: ' .. plr.Name)
	for _,v in pairs(game.Players:GetPlayers()) do
		if v ~= plr then
			--print('Firing with info {' .. tostring(id) .. ', ' .. tostring(vtolume) .. ', ' .. tostring(timestamp and 't1: ' .. timestamp[1] .. 't2: ' .. timestamp[2]) .. ', ' .. tostring(parent and parent:GetFullName()) .. '}, to client ' .. v.Name)
			FootstepReplication.Play:FireWithDistance(true,plr.Character.HumanoidRootPart.Position,600,id,volume,timestamp,parent, maxDistance)
		end
	end
end)