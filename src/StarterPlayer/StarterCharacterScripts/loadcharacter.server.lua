local id=game.Players[script.Parent.Name].userId -- StarterPlayer - StarterCharacterScripts
if game.Players[script.Parent.Name].CharacterAppearanceId>0 then
	id=game.Players[script.Parent.Name].CharacterAppearanceId
end
local a=game.Players:GetCharacterAppearanceAsync(id):GetChildren()
local num=0
while a[num+1]~=nil do
	num=num+1
	local p=a[num]
	if p~=nil then
		if p:IsA('Accessory') then
			local accessoryType = p.AccessoryType
			if accessoryType == Enum.AccessoryType.Hat or accessoryType == Enum.AccessoryType.Hair then
				p.Parent=script.Parent
			end
		end
		if p:IsA('Decal') then
			script.Parent.Head.face.Texture=p.Texture
		end
		if p:IsA('BodyColors') then
			p:clone().Parent=script.Parent
		end
	end
end

task.wait(3)

if game.Players[script.Parent.Name].Team.Name == "SCAV" then
	local shirt = Instance.new("Shirt", script.Parent)
	local pants = Instance.new("Pants", script.Parent)

	pants.PantsTemplate = "http://www.roblox.com/asset/?id=15407993109"
	shirt.ShirtTemplate = "http://www.roblox.com/asset/?id=15407977475"
elseif game.Players[script.Parent.Name].Team.Name == "BEAR" then
	local shirt = Instance.new("Shirt", script.Parent)
	local pants = Instance.new("Pants", script.Parent)

	pants.PantsTemplate = "http://www.roblox.com/asset/?id=15407895432"
	shirt.ShirtTemplate = "http://www.roblox.com/asset/?id=15407889079"
elseif game.Players[script.Parent.Name].Team.Name == "USEC" then
	local shirt = Instance.new("Shirt", script.Parent)
	local pants = Instance.new("Pants", script.Parent)

	pants.PantsTemplate = "http://www.roblox.com/asset/?id=15407863359"
	shirt.ShirtTemplate = "http://www.roblox.com/asset/?id=15382761764"
else
	local shirt = Instance.new("Shirt", script.Parent)
	local pants = Instance.new("Pants", script.Parent)

	pants.PantsTemplate = "http://www.roblox.com/asset/?id=15407993109"
	shirt.ShirtTemplate = "http://www.roblox.com/asset/?id=15407977475"
end

