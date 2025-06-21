local velocity = 0
local air = false 
local impact = false

script.Parent.Touched:Connect(function(touched)
	if touched and not touched:IsDescendantOf(script.Parent.Parent) and air == true and impact == false and touched.Transparency < 1 then
		air = false
		impact = true
		
		local random = math.random(1, 5)
		local sound = script[random]:clone()
		sound.Parent = script.Parent
		sound.Volume = sound.Volume * (math.floor(velocity/14))
		sound.EmitterSize 	= sound.Volume * (math.floor(velocity/12)) * 50
		if sound.Volume >=6 then
			sound.Volume = sound.Volume /2
		end
--		print(sound.Volume)
--		sound.Name = "impact sound"
--		sound.SoundGroup = game.SoundService.SoundGroup
		sound:Play()
		game.Debris:AddItem(sound, sound.TimeLength)
	end	
end)

while wait() do
	velocity = script.Parent.Velocity.magnitude
	local ray = Ray.new(script.Parent.Position, Vector3.new(0, -3, 0))
	local hit, p = game.Workspace:FindPartOnRay(ray, script.Parent.Parent)
	if hit then
	else
		air = true
		impact = false
	end
end