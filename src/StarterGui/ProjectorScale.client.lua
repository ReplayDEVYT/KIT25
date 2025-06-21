local uis = {}
local ignore = workspace:WaitForChild('Ignore')

local function waitforchildofclass(inst,class)
	if inst:FindFirstChildOfClass(class) then
		return inst:FindFirstChildOfClass(class)
	end
	repeat inst.ChildAdded:Wait() until inst:FindFirstChildOfClass(class)
	return inst:FindFirstChildOfClass(class)
end

workspace.CurrentCamera.DescendantAdded:Connect(function(d)
	if d:IsA('BasePart') and d.Name == 'ProjectorSight' then
		local ui = waitforchildofclass(d,'SurfaceGui')
		local clip = waitforchildofclass(ui,'Frame')
		local image = waitforchildofclass(clip,'ImageLabel')
		
		if not uis[ui] then
			uis[ui] = {image,{image.Size.X.Offset,image.Size.Y.Offset}}
			image.AncestryChanged:Connect(function()
				if not (ui and ui:IsDescendantOf(workspace.CurrentCamera)) then
					uis[ui] = nil
				end
			end)
		end
	end
end)

local function bindChar(char)
	char.DescendantAdded:Connect(function(d)
		if d:IsA('BasePart') and d.Name == 'ProjectorSight' then
			local ui = waitforchildofclass(d,'SurfaceGui')
			ui.Enabled = false
		end
	end)
end

if game:GetService('Players').LocalPlayer.Character then
	bindChar(game:GetService('Players').LocalPlayer.Character)
end
game:GetService('Players').LocalPlayer.CharacterAdded:Connect(bindChar)

local rp = RaycastParams.new()
rp.FilterType = Enum.RaycastFilterType.Whitelist
rp.IgnoreWater = true
local noangle = CFrame.new()*CFrame.Angles(math.rad(-90),0,0)


--print(string.rep('A',100))
if ignore:FindFirstChild('Part') then
	workspace.Ignore.Part:Destroy()
	p = Instance.new('Part')
	p.Size = Vector3.new(100,100,1)
	p.Anchored = true
	p.CanCollide = false
	p.Transparency = 1
	p.CFrame = noangle
	p.Parent = ignore
	rp.FilterDescendantsInstances = {p}
else
	p = Instance.new('Part')
	p.Size = Vector3.new(100,100,1)
	p.Anchored = true
	p.CanCollide = false
	p.Transparency = 1
	p.CFrame = noangle
	p.Parent = ignore
	rp.FilterDescendantsInstances = {p}
end

game:GetService('RunService'):BindToRenderStep('Holomod',2000,function()
	local count = 0
	for ui,im in pairs(uis) do
		if ui and im then
			count += 1
			
			--print(tostring(p and p.Parent and p.Parent:GetFullName()))
			
			local part = ui.Parent
			local from = workspace.CurrentCamera.CFrame.Position
			local to = (part.CFrame*CFrame.new(0,0,part.Size.Z/2)*CFrame.new(0,0,-(part:FindFirstChild('Zeroing') and part.Zeroing.Value or 20))).Position
			
			p.CFrame = part.CFrame*CFrame.new(0,0,(-part.Size.Z/2)-.5)
			
			local info = workspace:Raycast(from,to-from,rp)
			
			local SizeX,SizeY = unpack(im[2])
			local image = im[1]
			
			
			image.Visible = (info and info.Instance) and true or false
			if info and info.Instance then
				local m = workspace.CurrentCamera.FieldOfView/70
				
				image.Size = UDim2.new(0,SizeX*m,0,SizeY*m)
				
				local part = ui.Parent
				local ds = part.CFrame:PointToObjectSpace(info.Position)/part.Size
				image.Position = UDim2.new(.5+ds.X,0,.5-ds.Y,0)
			end
		end
	end
	if count > 0 then
		p.CFrame = noangle
	end
end)