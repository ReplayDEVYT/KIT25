local repS = game:GetService("ReplicatedStorage")
local DSS = game:GetService("DataStoreService")
local LootStore = DSS:GetDataStore("LMLootSave")
local players = game:GetService("Players")
local Groups = game:GetService("GroupService")
local setting = require(game.Workspace.LootMod.Settings)
local pickup = Instance.new("RemoteEvent")
pickup.Name = "lootEvent"
pickup.Parent = repS
local toolFolder = setting.toolFolder
local dropLoot = setting.dropLoot
local despawnTime = setting.lootClear
local inventorySave = setting.lootSave
local lootFolder = setting.lootFolder
local ragdoll = setting.ragdoll

function characterRemove(plr, character)
	character.Archivable = true
	local plr : (Player) = plr
	--local plr = players:GetPlayerFromCharacter(character)
	local backpack = plr:FindFirstChildOfClass("Backpack"):Clone()
	if not backpack then return warn('backpack not cloned, line 21 lol') end
	local inventory = {}
	for i, v in ipairs(backpack:GetChildren()) do
		if v:IsA("Tool") then
			local itemClone = v:Clone()
			table.insert(inventory, #inventory + 1, itemClone)
		end
	end
	backpack:Destroy()
	local lootBag
	if ragdoll then
		lootBag = workspace:WaitForChild(plr.Name.."'s dead body",5)
		--[[
		if lootBag then
			warn('lootbag found')
		else
			warn('lootbag not found')
		end
		]]
		if not lootBag then return end
		--lootBag.Parent = workspace
		lootBag.Name = "lootBag"
		lootBag:FindFirstChild("Saude"):Destroy()
		--lootBag:FindFirstChild("Health"):Destroy()
		--lootBag:FindFirstChild("Humanoid").DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
		--lootBag:FindFirstChild("Animate"):Destroy()
		--lootBag:FindFirstChild("Humanoid"):FindFirstChild("Animator"):Destroy()
		--lootBag:FindFirstChild("Humanoid").RootPart:SetNetworkOwner(nil)
		--lootBag:FindFirstChild("Humanoid"):ChangeState(Enum.HumanoidStateType.Physics)
	else
		lootBag = setting.customPlrLoot:Clone()
		if not lootBag then return end
		if not lootBag.PrimaryPart then
			lootBag.PrimaryPart = lootBag:GetChildren()[1]
		end
		lootBag.PrimaryPart.Position = character.PrimaryPart.Position
		lootBag.Parent = workspace
		lootBag.Name = "lootBag"
	end
	local name = Instance.new("StringValue")
	name.Name = "name"
	name.Value = plr.Name
	name.Parent = lootBag
	local invFolder = Instance.new("Folder")
	invFolder.Parent = lootBag
	invFolder.Name = "Inventory"
	for i, v in pairs(inventory) do
		v.Parent = invFolder
	end
	--spawn(function()
	--wait(despawnTime*60)
	--lootBag:Destroy()
	--end)
end

pickup.OnServerEvent:Connect(function(plr, weapon, spawnZone, box)
	if typeof(spawnZone) ~= "string" and spawnZone.Name == "WeaponSpawn" then
		local spawned = spawnZone:FindFirstChild("isSpawned")
		local spawnedItem = nil
		if not spawned.Value then return end
		for i, v in pairs(spawnZone:GetChildren()) do
			if v:IsA("Model") then
				spawnedItem = v
			end
		end
		if not spawnedItem then return end
		if weapon == spawnedItem then
			spawned.Value = false
			local loot = toolFolder[weapon.Name]:Clone()
			local ltype = spawnedItem.toolType:Clone()
			ltype.Parent = loot
			loot.Parent = plr.Backpack
			spawnedItem:Destroy()
		end
	elseif typeof(spawnZone) ~= "string" and spawnZone.Name == "lootBag" then
		weapon.Parent = plr.Backpack
	elseif typeof(spawnZone) == "string" and spawnZone == "lootContainer" then
		if box ~= nil then
			if box:FindFirstChild("Open") then
				box.Open:Play()
			end
		end
		local spawned = weapon.Parent.Parent:FindFirstChild("isSpawned")
		if not spawned.Value then return end
		if #weapon.Parent:GetChildren() == 1 then
			spawned.Value = false
		end
		while not toolFolder:FindFirstChild(weapon.Name) do
			wait()
		end
		local loot = toolFolder[weapon.Name]:Clone()
		local ltype = weapon.toolType:Clone()
		ltype.Parent = loot
		loot.Parent = plr.Backpack
		weapon:Destroy()
	end
end)

players.PlayerAdded:Connect(function(plr)
	plr.CharacterAdded:Connect(function(char)
		if dropLoot then
			plr.CharacterRemoving:Connect(function()
				characterRemove(plr, char)
			end)
			--
			char:FindFirstChildOfClass("Humanoid").Died:Connect(function()
				characterRemove(plr, char)
			end)
		end
		if inventorySave then
			local weapons = {}
			local success, err = pcall(function()
				local plrData = LootStore:GetAsync(plr.UserId)
				if plrData then
					weapons = plrData
				end
			end)
			for i, v in ipairs(weapons) do
				while not lootFolder:FindFirstChild(v) do
					wait()
				end
				local weaponS = lootFolder[v]
				while not toolFolder:FindFirstChild(v) do
					wait()
				end
				local tool = toolFolder[v]:Clone()
				local ltype = weaponS.toolType:Clone()
				ltype.Parent = tool
				tool.Parent = plr.Backpack
			end
			if not success then print("LM: Error loading "..plr.Name.."'s inventory.") warn(err) end
		end
	end)

end)
players.PlayerRemoving:Connect(function(plr)
	local backpack = plr.Backpack:Clone()
	if inventorySave then
		local weapons = {}
		for i, v in ipairs(backpack:GetChildren()) do
			table.insert(weapons, v.Name)
			print(v.Name)
		end
		local success, err = pcall(function()
			local plrData = LootStore:SetAsync(plr.UserId, weapons)
		end)
		if not success then print("LM: Error saving "..plr.Name.."'s inventory.") warn(err) end
	end
	backpack:Destroy()
end)