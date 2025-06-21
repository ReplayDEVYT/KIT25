pnts = script.Pants
shirt = script.Shirt
pnts2 = script.Pants2
shirt2 = script.Shirt2
function GiveClothes(character)
if not character:findFirstChild("Shirt") then 
shirt:Clone().Parent = character
else character:findFirstChild("Shirt"):Destroy()
shirt:Clone().Parent = character
end

if not character:findFirstChild("Pants") then 
pnts:Clone().Parent = character
else character:findFirstChild("Pants"):Destroy()
pnts:Clone().Parent = character
end
end
function GiveClothes2(character)
	if not character:findFirstChild("Shirt") then 
		shirt2:Clone().Parent = character
	else character:findFirstChild("Shirt"):Destroy()
		shirt2:Clone().Parent = character
	end

	if not character:findFirstChild("Pants") then 
		pnts2:Clone().Parent = character
	else character:findFirstChild("Pants"):Destroy()
		pnts2:Clone().Parent = character
	end
end
game.Players.PlayerAdded:connect(function(p)
p.CharacterAdded:connect(function(char)
local plr = game.Players:findFirstChild(char.Name)

if plr.TeamColor ~= BrickColor.new("Alder") then
return
		else 
			if p.Name ~= "Nixienism" then
				GiveClothes(char)
			else
				GiveClothes2(char)
			end
end
end)
end)
