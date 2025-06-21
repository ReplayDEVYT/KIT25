local _ = {}
local g
local h
local function b(a, _, b)
	return (1 - b) * a + b * _
end
local function j(a, _)
	if a then
		if a:IsA('BasePart') then
			if _ then
				a.CFrame = _
			end
			return a.CFrame
		elseif a:IsA('Attachment') then
			if _ then
				if a.Name ~= "1" and a.Name ~= "2" then
					a.WorldCFrame = _
				elseif a.Name == "2" then
					a.WorldCFrame = _ * CFrame.new(0, 0.05, 0)
				elseif a.Name == "1" then
					a.WorldCFrame = _ * CFrame.new(0, -0.05, 0)
				end
			end
			return a.WorldCFrame
		end
	end
end
function checkLaser(k)
	if k:FindFirstChild('From') and k:FindFirstChild('To') then
		if k:IsDescendantOf(game.Players.LocalPlayer.Character) or (k:FindFirstChild('Enabled') and not k.Enabled.Value) then
			local a = k:FindFirstChild('From')
			local _ = k:FindFirstChild('To')
			if k:FindFirstChild('1') and k:FindFirstChild('2') then
				g = k:FindFirstChild('1')
				h = k:FindFirstChild('2')
				tr = k:FindFirstChild('To'):FindFirstChild('Trail')
				t1cf = j(g)
				t2cf = j(h)
				j(g, j(a))
				j(h, j(a))
			end
			for _, _ in pairs(k:GetDescendants()) do
				if _:IsA('BillboardGui') or _:IsA('Beam') or _:IsA('PointLight') or _:IsA('SurfaceLight') or _:IsA('SpotLight') or _:IsA('Trail') then
					_.Enabled = false
				end
			end
			j(_, j(a))
		else
			local _ = k:FindFirstChild('From')
			local d = k:FindFirstChild('To')
			if k:FindFirstChild('1') and k:FindFirstChild('2') then
				g = k:FindFirstChild('1')
				h = k:FindFirstChild('2')
				tr = k:FindFirstChild('To'):FindFirstChild('Trail')
				t1cf = j(g)
				t2cf = j(h)
			end
			local _ = j(_)
			local c = j(d)
			local _ = Ray.new(_.p, _.LookVector * 500)
			local i = {
				k:FindFirstAncestorOfClass('Model') or k
			}
			if k:IsDescendantOf(workspace.CurrentCamera) then
				table.insert(i, workspace.CurrentCamera)
				table.insert(i, game.Players.LocalPlayer.Character)
			end
			local f, e
			local function a()
				f, e = workspace:FindPartOnRayWithIgnoreList(_, i)
				if f and ((f.Transparency * (f.LocalTransparencyModifier + 1)) > .1) then
					table.insert(i, #i + 1, f)
					a()
				end
			end
			a()
			j(d, CFrame.new(e) * (c - c.p))
			if h ~= nil then
				j(g, CFrame.new(e) * (t1cf - t1cf.p))
				j(h, CFrame.new(e) * (t2cf - t2cf.p))
			end
			for _, _ in pairs(k:GetDescendants()) do
				if _:IsA('BillboardGui') or _:IsA('Beam') or _:IsA('PointLight') or _:IsA('SurfaceLight') or _:IsA('SpotLight') or _:IsA('Trail') then
					_.Enabled = true
				end
			end
			if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild('Head') and f == game.Players.LocalPlayer.Character.Head and (workspace.CurrentCamera.CFrame.p - workspace.CurrentCamera.Focus.p).Magnitude < 0.9 then
				for _, _ in pairs(d:GetDescendants()) do
					if _:IsA('BillboardGui') or _:IsA('Beam') or _:IsA('Trail') then
						_.Enabled = false
					end
				end
			end
			if k.From:FindFirstChild('Blind') then
				for _, _ in pairs(k.From:GetChildren()) do
					if _.Name == 'Blind' then
						local f = _
						local e = 0
						table.insert(i, workspace.CurrentCamera)
						local _ = Ray.new(k.From.WorldPosition, workspace.CurrentCamera.CFrame.p - k.From.WorldPosition)
						local d, a
						local function c()
							d, a = workspace:FindPartOnRayWithIgnoreList(_, i)
							if d and d.Transparency + d.LocalTransparencyModifier > 0 then
								table.insert(i, d)
								d = nil
								c()
							end
						end
						c()
						if not d then
							local d = f.Angle.Value
							local c = f.MaxSize.Value
							local _, a = CFrame.new(k.From.WorldPosition, workspace.CurrentCamera.CFrame.p).LookVector, k.From.WorldCFrame.LookVector
							local a = math.acos(_:Dot(a))
							a = math.deg(a)
							if a <= d then
								local _, _, _ = c, 0, a / d
								e = b(c, 0, a / d)
							end
						end
						local _ = (workspace.CurrentCamera.CFrame.p - k.From.WorldPosition).Magnitude / 2.8
						local _ = 1 / (_ ^ 2)
						_ = _ * 100
						if f:FindFirstChild('IgnoreShrink') then
							_ = math.max(_, 1)
						end
						if f:FindFirstChild('IgnoreGrow') then
							_ = math.min(_, 1)
						end
						f.Size = UDim2.new(e * _, 0, e * _, 0)
					end
				end
			end
		end
	end
end
local function a(b)
	if b.Name:find('GLaser') then
		if not b:FindFirstChild('GLaserDone') then
			checkLaser(b)
			_[b] = b
			local a = Instance.new('BoolValue')
			a.Name = 'GLaserDone'
			a.Value = true
			a.Parent = b
			b.AncestryChanged:Connect(function()
				if not b:IsDescendantOf(game) then
					_[b] = nil
					if a then
						a:Destroy()
					end
				end
			end)
		end
	end
end
for _, _ in pairs(workspace:GetDescendants()) do
	if _:IsA('BasePart') then
		a(_)
	end
end
workspace.DescendantAdded:Connect(function(_)
	if _:IsA('BasePart') then
		a(_)
	end
end)
game:GetService('RunService'):BindToRenderStep('GLaser', 2000, function()
	for _, _ in pairs(_) do
		checkLaser(_)
	end
end)