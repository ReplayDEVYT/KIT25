pnts = script.Pants
shirt = script.Shirt

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

game.Players.PlayerAdded:connect(function(p)
p.CharacterAdded:connect(function(char)
wait(1.12)
local plr = game.Players:findFirstChild(char.Name)

if plr.TeamColor ~= BrickColor.new("Black") then
return
else GiveClothes(char)
end
end)
end)
