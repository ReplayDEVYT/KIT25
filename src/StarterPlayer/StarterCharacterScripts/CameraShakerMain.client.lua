ShakeDist = 10

local cameraShaker = require(game.ReplicatedStorage.CameraShaker)
local camera = workspace.CurrentCamera
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

local camShake = cameraShaker.new(Enum.RenderPriority.Camera.Value, function(shakeCFrame)
	camera.CFrame = camera.CFrame * shakeCFrame
end)

local lasthealth = char:WaitForChild('Humanoid').MaxHealth
local hum = char:WaitForChild('Humanoid')

local function onDescendantAdded(desc)
	if desc:IsA("Explosion") and desc.BlastPressure > 0 or desc.Name == 'GrenExplosion'  then
		local ExDist = (game.Players.LocalPlayer.Character.Head.Position - desc.Position).magnitude
		local ShakeMagnitude = ExDist/(desc.BlastRadius/8)
		if ShakeMagnitude < ShakeDist then
			camShake:Start()
			camShake:ShakeOnce(ShakeMagnitude, 2, 0, 2)
		end
	end
end


function healthShake()
	if char:FindFirstChild('Humanoid') and char.Humanoid.Health < lasthealth  and (hum.Health/lasthealth) > 10 then
		camShake:Start()
		camShake:ShakeOnce((hum.Health/lasthealth)*2, 10, 0, 1.5)
	end
	lasthealth = char:WaitForChild('Humanoid').Health
end

hum.Changed:Connect(healthShake)
player.CharacterAdded:connect(function()
	lasthealth = hum.MaxHealth
end)

game.Workspace.DescendantAdded:Connect(onDescendantAdded)

--[thienbao2109]--