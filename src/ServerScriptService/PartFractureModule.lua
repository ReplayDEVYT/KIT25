-- Part fracturing system --

-- Version 3
-- Last updated: 31/07/2020

local Module = {}

DebugEnabled = false

Debris = game:GetService("Debris")

function Module.FracturePart(PartToFracture)
	
	local BreakingPointAttachment = PartToFracture:FindFirstChild("BreakingPoint")
	
	-- Settings
	local Configuration = PartToFracture:FindFirstChild("Configuration")
	
	local DebrisDespawn = false
	local DebrisDespawnDelay = 0
	local WeldDebris = false
	local AnchorDebris = false
	
	if DebugEnabled then
		local DebugPart = Instance.new("Part")
		DebugPart.Shape = "Ball"
		DebugPart.CanCollide = false
		DebugPart.Anchored = true
		DebugPart.Size = Vector3.new(0.5, 0.5, 0.5)
		DebugPart.Color = Color3.fromRGB(255, 0, 0)
		DebugPart.Position = BreakingPointAttachment.WorldPosition
		DebugPart.Parent = workspace
	end
	
	local BreakSound = PartToFracture:FindFirstChild("BreakSound")
	
	if BreakSound then
		local SoundPart = Instance.new("Part")
		SoundPart.Size = Vector3.new(0.2, 0.2, 0.2)
		SoundPart.Position = PartToFracture.Position
		SoundPart.Name = "TemporarySoundEmitter"
		SoundPart.Anchored = true
		SoundPart.CanCollide = false
		SoundPart.Transparency = 1
		local Sound = BreakSound:Clone()
		Sound.Parent = SoundPart
		SoundPart.Parent = workspace
		Sound:Play()
		Debris:AddItem(SoundPart, Sound.PlaybackSpeed)
	end
	
	if Configuration then
		DebrisDespawn = Configuration.DebrisDespawn.Value
		DebrisDespawnDelay = Configuration.DebrisDespawnDelay.Value
		WeldDebris = Configuration.WeldDebris.Value
		AnchorDebris = Configuration.AnchorDebris.Value
	else
		warn("The 'Configuration' is not a valid member of " .. PartToFracture.Name .. ". Please insert a 'Configuration' with the following values; 'DebrisDespawn' (bool), 'WeldDebris' (bool), 'DebrisDespawnDelay' (number/int)")
	end
	
	if not BreakingPointAttachment then
		warn("The 'BreakingPoint' attachment is not a valid member of " .. PartToFracture.Name .. ". Please insert an attachment named 'BreakingPoint'")
	end
	
	local BreakingPointY = BreakingPointAttachment.Position.Y
	local BreakingPointZ = BreakingPointAttachment.Position.Z
	
	local ShardBottomLeft = Instance.new("WedgePart")
	local ShardBottomRight = Instance.new("WedgePart")
	local ShardTopLeft = Instance.new("WedgePart")
	local ShardTopRight = Instance.new("WedgePart")
	
	local BreakSound = PartToFracture:FindFirstChild("BreakSound")
	
	-- Bottom Left
	ShardBottomLeft.Material = PartToFracture.Material
	ShardBottomLeft.Color = PartToFracture.Color
	ShardBottomLeft.CanCollide = false
	ShardBottomLeft.Transparency = PartToFracture.Transparency
	ShardBottomLeft.Size = PartToFracture.Size - Vector3.new(0, (PartToFracture.Size.Y / 2) - BreakingPointY, (PartToFracture.Size.Z / 2) + BreakingPointZ)
	local OldSizeY = ShardBottomLeft.Size.Y
	local OldSizeZ = ShardBottomLeft.Size.Z
	ShardBottomLeft.CFrame = PartToFracture.CFrame * CFrame.new(0, BreakingPointY - (ShardBottomLeft.Size.Y / 2), BreakingPointZ + (ShardBottomLeft.Size.Z / 2))
	ShardBottomLeft.CFrame = ShardBottomLeft.CFrame * CFrame.Angles(math.rad(90), 0, 0)
	ShardBottomLeft.Size = Vector3.new(ShardBottomLeft.Size.X, OldSizeZ, OldSizeY)
	local ShardBottomLeft2 = ShardBottomLeft:Clone()
	ShardBottomLeft2.CFrame = ShardBottomLeft2.CFrame * CFrame.Angles(math.rad(180), 0, 0)
	
	-- Bottom Right
	ShardBottomRight.Material = PartToFracture.Material
	ShardBottomRight.Color = PartToFracture.Color
	ShardBottomLeft.CanCollide = false
	ShardBottomRight.Transparency = PartToFracture.Transparency
	ShardBottomRight.Size = PartToFracture.Size - Vector3.new(0, (PartToFracture.Size.Y / 2) + BreakingPointY, (PartToFracture.Size.Z / 2) + BreakingPointZ)
	ShardBottomRight.CFrame = PartToFracture.CFrame * CFrame.new(0, BreakingPointY + (ShardBottomRight.Size.Y / 2), BreakingPointZ + (ShardBottomRight.Size.Z / 2))
	local ShardBottomRight2 = ShardBottomRight:Clone()
	ShardBottomRight2.CFrame = ShardBottomRight2.CFrame * CFrame.Angles(math.rad(180), 0, 0)
	
	-- Top Left
	ShardTopLeft.Material = PartToFracture.Material
	ShardTopLeft.Color = PartToFracture.Color
	ShardBottomLeft.CanCollide = false
	ShardTopLeft.Transparency = PartToFracture.Transparency
	ShardTopLeft.Size = PartToFracture.Size - Vector3.new(0, (PartToFracture.Size.Y / 2) + BreakingPointY, (PartToFracture.Size.Z / 2) - BreakingPointZ)
	local OldSizeY = ShardTopLeft.Size.Y
	local OldSizeZ = ShardTopLeft.Size.Z
	ShardTopLeft.CFrame = PartToFracture.CFrame * CFrame.new(0, BreakingPointY + (ShardTopLeft.Size.Y / 2), BreakingPointZ - (ShardTopLeft.Size.Z / 2))
	ShardTopLeft.CFrame = ShardTopLeft.CFrame * CFrame.Angles(math.rad(90), 0, 0)
	ShardTopLeft.Size = Vector3.new(ShardTopLeft.Size.X, OldSizeZ, OldSizeY)
	local ShardTopLeft2 = ShardTopLeft:Clone()
	ShardTopLeft2.CFrame = ShardTopLeft2.CFrame * CFrame.Angles(math.rad(180), 0, 0)
	
	-- Top Right
	ShardTopRight.Material = PartToFracture.Material
	ShardTopRight.Color = PartToFracture.Color
	ShardBottomLeft.CanCollide = false
	ShardTopRight.Transparency = PartToFracture.Transparency
	ShardTopRight.Size = PartToFracture.Size - Vector3.new(0, (PartToFracture.Size.Y / 2) - BreakingPointY, (PartToFracture.Size.Z / 2) - BreakingPointZ)
	ShardTopRight.CFrame = PartToFracture.CFrame * CFrame.new(0, BreakingPointY - (ShardTopRight.Size.Y / 2), BreakingPointZ - (ShardTopRight.Size.Z / 2))
	local ShardTopRight2 = ShardTopRight:Clone()
	ShardTopRight2.CFrame = ShardTopRight2.CFrame * CFrame.Angles(math.rad(180), 0, 0)
	
	local ShardDictionary = {ShardBottomLeft, ShardBottomLeft2, ShardBottomRight, ShardBottomRight2, ShardTopLeft, ShardTopLeft2, ShardTopRight, ShardTopRight2}
	
	
	local FirstShard = nil
	for Index, Shard in ipairs(ShardDictionary) do
		if not FirstShard then
			FirstShard = Shard
		end
		Shard.Anchored = AnchorDebris
		if not AnchorDebris then
			Shard.Velocity = PartToFracture.Velocity
			Shard.RotVelocity = PartToFracture.RotVelocity
		end
		if WeldDebris and FirstShard then
			local Weld = Instance.new("WeldConstraint")
			Weld.Name = "ShardWeld"
			Weld.Part0 = FirstShard
			Weld.Part1 = Shard
			Weld.Parent = Shard
		end
		Shard.Name = "Shard"
		Shard.Parent = PartToFracture.Parent
		if DebrisDespawn then
			Debris:AddItem(Shard, DebrisDespawnDelay)
		end
	end
	PartToFracture:Destroy()
	
end

return Module

-- System by Ethanthegrand14