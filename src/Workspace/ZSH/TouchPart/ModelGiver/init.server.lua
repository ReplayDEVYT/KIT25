local attachpts = {
	R15 = {
		Vest = "UpperTorso",
		Face = "Head",
		Helmet = "Head",
		Top = "Head",
		Helm = "Head",
		Belt = "LowerTorso",
	},
	R6 = {
		Vest = "Torso",
		Face = "Head",
		Helmet = "Head",
		Top = "Head",
		Helm = "Head",
		Belt = "Torso",
	}
}


local function recursive(parent,root)
	for k,v in pairs(parent:GetChildren()) do
		if v:IsA("BasePart") then
			local w = Instance.new("Weld")
			w.Part0 = root
			w.Part1 = v
			w.C1 = v.CFrame:toObjectSpace(root.CFrame)
			w.Parent = root
			v.Anchored = false
			v.CanCollide = false
		elseif v:IsA("Model") and v.Name ~= "Up" then
			recursive(v,root)
		end
	end
end



local model = script.Parent.Parent:FindFirstChildOfClass("Model")

local upnvg = model:FindFirstChild("Up")
local downnvg = model:FindFirstChild("Down")
if upnvg and downnvg then
	recursive(upnvg,upnvg.PrimaryPart)
	local nvgjoint = Instance.new("Motor6D")
	nvgjoint.Part0 = model.Middle
	nvgjoint.Part1 = upnvg.PrimaryPart
		
	local upvalue = Instance.new("CFrameValue")
	local downvalue = Instance.new("CFrameValue")
		
	upvalue.Name = "upvalue"
	downvalue.Name = "downvalue"
		
	upvalue.Value = model.Middle.CFrame:inverse()*upnvg.PrimaryPart.CFrame
	downvalue.Value = model.Middle.CFrame:inverse()*downnvg.PrimaryPart.CFrame
		
	upvalue.Parent = upnvg
	downvalue.Parent = upnvg
		
	nvgjoint.Name = "twistjoint"
	nvgjoint.C0 = upvalue.Value
	nvgjoint.Parent = upnvg
	
	downnvg:Destroy()
	
	local autoconfig = script:WaitForChild("AUTO_CONFIG"):Clone()
	autoconfig.Parent = upnvg
	
elseif upnvg or downnvg then
	print("Missing "..(not upnvg and "Up" or "Down").."NVG Model")
end	

local attachtype = model.Name

local bounced

function onTouched(hit)
	if hit.Parent:FindFirstChild("Humanoid") and not bounced then
		bounced = true
		delay(2,function()
			bounced = false
		end)
		local char = hit.Parent
		local oldmodel = char:FindFirstChild(attachtype)
		if oldmodel then
			oldmodel:Remove()
		end
		
		local g = model:Clone()
		
		recursive(g,g.Middle)
		
		local Y = Instance.new("Weld")
		Y.Part0 = char[attachpts[char.Humanoid.RigType.Name][attachtype]]
		Y.Part1 = g.Middle
		Y.Parent = Y.Part0
		
		g.Parent = char
		hit.Parent.Saude.Protecao.HelmetProtect.Value = 400
		hit.Parent.Saude.Protecao.HelmetVida.Value = 90
	end
end

script.Parent.Touched:connect(onTouched)