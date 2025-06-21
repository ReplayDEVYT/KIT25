local char = script.Parent
local g = game:GetService('ServerStorage').StomachHitbox.StomachModel:Clone()
g.Parent = char
local C = g:GetChildren()
for i=1, #C do
	if C[i].className == "Part" or C[i].className == "UnionOperation" or C[i].className == "MeshPart" then
		local W = Instance.new("Weld")
		W.Part0 = g.Middle
		W.Part1 = C[i]
		local CJ = CFrame.new(g.Middle.Position)
		local C0 = g.Middle.CFrame:inverse()*CJ
		local C1 = C[i].CFrame:inverse()*CJ
		W.C0 = C0
		W.C1 = C1
		W.Parent = g.Middle
	end
	local Y = Instance.new("Motor6D")
	Y.Part0 = char.Torso
	Y.Part1 = g.Middle
	Y.C0 = CFrame.new(0, 0, 0)
	Y.Parent = Y.Part0
	Y.Name = "Stomach"
end

local h = g:GetChildren()
for i = 1, # h do
	if h[i]:IsA('BasePart') then
	h[i].Anchored = false
	h[i].CanCollide = false
		h[i].Parent = char
		end
end