local Utilities = {}

Utilities.Weld = function(p1, p2, par, c0, c1)
	local w = Instance.new("Motor6D", p1)
	w.Part0 = p1
	w.Part1 = p2
	w.Name = p1.Name
	w.C0 = c0 or p1.CFrame:inverse() * p2.CFrame
	w.C1 = c1 or CFrame.new()
	w.Parent = par
	return w
end

Utilities.WeldComplex = function(x,y,par)
	local W = Instance.new("Motor6D")
	W.Name = y.Name
	W.Part0 = x
	W.Part1 = y
	local CJ = CFrame.new(x.Position)
	local C0 = x.CFrame:inverse()*CJ
	local C1 = y.CFrame:inverse()*CJ
	W.C0 = C0
	W.C1 = C1
	W.Parent = par
	return W
end

Utilities.CheckForHumanoid = function(search)
	local result = false
	local humanoid = nil
	if search then
		if (search.Parent:FindFirstChild("Humanoid") or search.Parent.Parent:FindFirstChild("Humanoid")) then
			result = true
			if search.Parent:FindFirstChild('Humanoid') then
				humanoid = search.Parent.Humanoid
			elseif search.Parent.Parent:FindFirstChild('Humanoid') then
				humanoid = search.Parent.Parent.Humanoid
			end
		else
			result = false
		end	
	end
	return result,humanoid
end

return Utilities