local air = false 
local impact = false
local lastbonked = 0


script.Parent.Touched:Connect(function(h)
	if not h:IsDescendantOf(script.Parent.Parent) and air == true and impact == false and h and h.Transparency < 1 and tick()-lastbonked > 0.5 then
		lastbonked = tick()
		air = false
		impact = true
		
		local random = math.random(1, 5)
		local sound = script["sound"..random]:clone()
		sound.Parent = script.Parent
		script.Parent:AddTag("3DSoundEmitter")
--		sound.Name = "impact sound"
--		sound.SoundGroup = game.SoundService.SoundGroup
		sound:Play()
		game.Debris:AddItem(sound, sound.TimeLength)
	end	
end)

while wait() do
	local ray = Ray.new(script.Parent.Position, Vector3.new(0, -3, 0))
	local hit, p = workspace:FindPartOnRay(ray, script.Parent.Parent)
	if hit then
	else
		air = true
		impact = false
	end
end