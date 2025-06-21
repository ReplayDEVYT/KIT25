`local setting = require(game.Workspace.LootMod.Settings)
local cooldown = setting.cooldown
local lootFolder = setting.lootFolder
local toolFolder = setting.toolFolder
local willReplace = setting.replace
local invFolder = Instance.new("Folder")
invFolder.Name = "Inventory"
invFolder.Parent = script.Parent
local spawned = Instance.new("BoolValue")
spawned.Parent = script.Parent
spawned.Name = "isSpawned"
local repS = game:GetService("ReplicatedStorage")
local lootTable = {}
for i, v in pairs(lootFolder:GetChildren()) do
	if v:FindFirstChild("toolType") then
		table.insert(lootTable, #lootTable+1, v)
	end
end

local function respawn()
	if #invFolder:GetChildren() > 0 then
		for i, v in invFolder:GetChildren() do
			v:Destroy()
		end
	end
	for i = 1, math.random(1, 10) do
		local itemSelect = 1
		if #lootTable >= 1 then
			itemSelect = math.floor(math.random(1, #lootTable))
		end
		local raritySelect = math.floor(math.random(1, 500))
		if #lootTable == 0 then
			raritySelect = 1
		end
		local rarityTable = {}
		local rarity = 1
		if raritySelect <= 150 then
			rarity = 1
		elseif raritySelect >= 151 and raritySelect <= 180 then
			rarity = 2
		elseif raritySelect >= 181 and raritySelect <= 190 then
			rarity = 3
		elseif raritySelect >= 191 and raritySelect <= 195 then
			rarity = 4
		elseif raritySelect >= 196 and raritySelect <= 199 then
			rarity = 5
		else
			rarity = 0
		end
		for i, v in pairs(lootTable) do
			if not v:FindFirstChild("rarity") then 
				local r = Instance.new("IntValue")
				r.Parent = v
				r.Name = "rarity"
				r.Value = 1
			end
			if v.rarity.Value == rarity then
				table.insert(rarityTable, #rarityTable + 1, v)
			end
		end
		local item = 1
		if #rarityTable > 0 then
			item = math.floor(math.random(1, #rarityTable))
		end
		for i, v in pairs(rarityTable) do
			if i == item then
				local spawnedItem = v:Clone()
				spawnedItem.Parent = invFolder
			end
		end
	end
	for i, v in pairs(invFolder:GetChildren()) do
		if v:IsA("Model") then
			spawned.Value = true
		end
	end
end
respawn()
spawn(function()
	while wait(math.floor(cooldown*60)) do
		if willReplace then
			pcall(respawn)
		elseif not spawned.Value then
			pcall(respawn)
		end
	end
end)