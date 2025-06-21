local RunService = game:GetService("RunService")
local ReverbMod = require(game.ReplicatedStorage.DynamicAudioV2)
local Sound = script.Parent
local Part = Sound.Parent

function RoundTo(Number: number, NumberOfDecimalPlaces: number)
	local RoundTo = 10^(NumberOfDecimalPlaces or 0)
	local Rounded = math.floor(Number * RoundTo + 0.5) / RoundTo
	return Rounded
end

local RayParam = ReverbMod.newRayParams(Part, 8, 40, 100, true, false)
local Obj = ReverbMod.new(RayParam)
Obj.FilterDescendantsInstances = {Part}

Obj:AddSound(Sound)
Obj:StartUpdate()