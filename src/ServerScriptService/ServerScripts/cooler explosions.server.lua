Duration1 = 0.2
Duration2 = 8
local Explosion = script:WaitForChild("Explosions")
local close = Explosion.Close:GetChildren()
local distant = Explosion.Distant:GetChildren()
local far = Explosion.Far:GetChildren()
Debris = game:GetService("Debris")

function Particalize(Explosion)
	Explosion.Visible = false
	local Part = Instance.new("Part")
	Part.Name = "ExplosionParticle"
	local ExpP = Part
	local S = close[math.random(#close)]:Clone()
	S.PlaybackSpeed = math.random(90,110)/100
	S.Parent = ExpP
	local S2 = distant[math.random(#distant)]:Clone()
	S2.PlaybackSpeed = math.random(90,110)/100
	S2.Parent = ExpP
	local S3 = far[math.random(#far)]:Clone()
	S3.PlaybackSpeed = math.random(90,110)/100
	S3.Parent = ExpP
	Part.Transparency = 1
	Part.Size = Vector3.new(0,0,0)
	Part.Anchored = true
	Part.CanCollide = false
	Part.CFrame = CFrame.new(Explosion.Position)
	Part.Parent = game.Workspace
	S:Play()
	S2:Play()
	S3:Play()
	local C = script:GetChildren()
	for i=1,#C do
		if C[i].className == "ParticleEmitter" then
			local Particle = C[i]:Clone()
			Particle.Parent = Part
			Particle.Enabled = true
		end
	end
	wait(Duration1)
	local P = Part:GetChildren()
	for i=1,#P do
		if P[i].className == "ParticleEmitter" then
			P[i].Enabled = false
		end
	end
	--wait(8)
	Debris:AddItem(Part,Duration2)
end

game.Workspace.DescendantAdded:connect(function(desc)
	if desc:IsA("Explosion") and desc.Visible == true and desc.BlastPressure > 0 then
		Particalize(desc)
	end
end)