local Debris = game:GetService("Debris")
local RunService = game:GetService("RunService")

local function renderStep()
	RunService.RenderStepped:Wait()
end

local function onDescendantAdded(desc)
	if desc:IsA("Explosion") and desc.BlastPressure > 0 or desc.Name == 'GrenExplosion' then
		local p = Instance.new("Part")
		p.Anchored = true
		p.CanCollide = false
		p.Transparency = 1
		p.CFrame = CFrame.new(desc.Position)
		p.Name = "ExpLight"
		local light = Instance.new("PointLight")
		light.Parent = p
		light.Range = math.max(12,desc.BlastRadius)
		light.Brightness = 10
		light.Shadows = true
		spawn(function ()
			for i = 1,0,-.1 do
				light.Color = Color3.new(1,1,i)
				renderStep()
			end
			for i = 1,0,-.05 do
				light.Color = Color3.new(i*2,i,0)
				light.Brightness = i*10
				renderStep()
			end
			light.Enabled = false
		end)
		p.Parent = workspace
		while desc:IsDescendantOf(workspace) do
			desc.AncestryChanged:Wait()
		end
		p:Destroy()
	end
end

workspace.DescendantAdded:Connect(onDescendantAdded)