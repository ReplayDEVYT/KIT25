local FLIRFolders = {}
local player = game.Players.LocalPlayer
local char = player.Character
local nvg = char:WaitForChild("Helmet")
local FLIRActive = nvg.Up["NVG_Settings"]:WaitForChild("FLIR")
function WeldIt(p1,p2)
	local w = Instance.new('Weld')
	w.Part0, w.Part1 = p1, p2
	w.C1 = p2.CFrame:inverse() * p1.CFrame
	w.Parent = p1
	w.Name = p2.Name
end

while nvg do
	wait()
	if FLIRActive and FLIRActive.Value == true and char.Humanoid.Health > 0 then
	for _,c in pairs(game.Players:GetChildren())do
		if c:IsA("Player") and c.Character ~= nil and c.Character:findFirstChild("FLIRParts")== nil then
			local Folder = Instance.new("Folder",c.Character)
			Folder.Name = "FLIRParts"
			table.insert(FLIRFolders,Folder)
			for _,p in pairs(c.Character:GetDescendants()) do
				if p:IsA("BasePart") and p.Transparency < 1 then
					local Part = p:Clone()
						local OldSize = p.Size
						--p.Transparency = 1
					Part.Parent = Folder
						WeldIt(Part,p)
						Part.CFrame = p.CFrame
					Part.Transparency = 0
					Part.Color = Color3.fromRGB(255,255,255)
					Part.Material = Enum.Material.Neon
						Part.Size = Vector3.new(OldSize.X+0.025,OldSize.Y+0.025,OldSize.Z+0.025)
						for i,v in pairs(Part:GetChildren()) do
					if v:IsA("Decal") or v:IsA("Texture") then
						v:Destroy()
							end
							end
						if Part:IsA("MeshPart") then
							Part.TextureID = "rbxassetid://2114473"
						end
						if Part:FindFirstChildOfClass("SpecialMesh") and Part:FindFirstChildOfClass("SpecialMesh").TextureId then
							Part:FindFirstChildOfClass("SpecialMesh").TextureId = "rbxassetid://2114473"
						end
					Part.CanCollide = false
					Part.Anchored = false
					Part.Massless = true
				end
			end
		end
		end
	else
		for _,c in pairs(game.Players:GetChildren())do
			if c:IsA("Player") and c.Character ~= nil and c.Character:findFirstChild("FLIRParts")~= nil then
				c.Character:findFirstChild("FLIRParts"):Destroy()
			end
		end
	end
end

