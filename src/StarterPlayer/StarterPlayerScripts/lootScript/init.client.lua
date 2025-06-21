local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local runS = game:GetService("RunService")
local repS = game:GetService("ReplicatedStorage")
local input = game:GetService("UserInputService")
local lootEvent = repS:WaitForChild("lootEvent")
local setting = require(game.Workspace.LootMod.Settings)
local button = setting.button
local mouse = localPlayer:GetMouse()
local weapon = nil
local debounce = false
local lootGui = Instance.new("ScreenGui")
local lootText = Instance.new("TextLabel")
lootText.BackgroundTransparency = 1
lootText.Font = "Jura"
lootText.TextColor3 = Color3.fromRGB(255,255,255)
lootText.Text = "["..button.."] INTERACT"
lootText.Size = UDim2.new(0, 250, 0, 25)
lootText.TextSize = 15
lootText.AnchorPoint = Vector2.new(0.5, 0.5)
lootText.Position = UDim2.new(0.5, 0, 0.5, 20)
lootText.Parent = lootGui
lootText.TextTransparency = 1
local weaponName = lootText:Clone()
weaponName.Position = UDim2.new(0.5, 0, 0.5, 45)
weaponName.Text = "NONE"
weaponName.Parent = lootGui
lootGui.Name = "pickupGui"
lootGui.Parent = localPlayer.PlayerGui
local weaponGiven = false

while not localPlayer.Character do
	wait()
end

runS.RenderStepped:Connect(function()
	if debounce and not weapon.Parent then
		weaponName.Text = "NONE"
		weaponName.TextTransparency = 1
		lootText.TextTransparency = 1
		weapon = nil
		debounce = false
		weaponGiven = false
		return
	end
	if not mouse.Target then
		debounce = false
		weaponName.Text = "NONE"
		weaponName.TextTransparency = 1
		lootText.TextTransparency = 1
		return
	end
	if mouse.Target.Parent.Parent.Name == "WeaponSpawn" or mouse.Target.Name == "WeaponSpawn" then
		if weaponGiven then
			weaponName.Text = "NONE"
			weaponName.TextTransparency = 1
			lootText.TextTransparency = 1
			weapon = nil
			debounce = false
			weaponGiven = false
			return
		end
		if not localPlayer.Character.Humanoid.RootPart then return end
		local distance = (localPlayer.Character.Humanoid.RootPart.Position - mouse.Target.Position).Magnitude
		if distance > setting.lootRange then return end
		if debounce then return end
		if mouse.Target.Parent.Parent.Name == "WeaponSpawn" then
			weapon = mouse.Target.Parent
			debounce = true
			weaponName.Text = weapon.Name
			lootText.TextTransparency = 0
			weaponName.TextTransparency = 0
		elseif mouse.Target.Name == "WeaponSpawn" then
			local spawned = mouse.Target:FindFirstChild("isSpawned")
			for i, v in pairs(mouse.Target:GetChildren()) do
				if not spawned.Value then return end
				if v:IsA("Model") then
					weapon = v
					debounce = true
					weaponName.Text = weapon.Name
					weaponName.TextTransparency = 0
					lootText.TextTransparency = 0
				end
			end
		end
	else
		debounce = false
		weaponName.Text = "NONE"
		weaponName.TextTransparency = 1
		lootText.TextTransparency = 1
		weapon = nil
	end
end)

local function respawned()
	lootGui:Destroy()
	lootText:Destroy()
	weaponName:Destroy()
	lootGui = Instance.new("ScreenGui")
	lootText = Instance.new("TextLabel")
	lootText.BackgroundTransparency = 1
	lootText.Font = "Jura"
	lootText.TextColor3 = Color3.fromRGB(255,255,255)
	lootText.Text = "["..button.."] INTERACT"
	lootText.Size = UDim2.new(0, 250, 0, 25)
	lootText.TextSize = 15
	lootText.AnchorPoint = Vector2.new(0.5, 0.5)
	lootText.Position = UDim2.new(0.5, 0, 0.5, 20)
	lootText.Parent = lootGui
	lootText.TextTransparency = 1
	weaponName = lootText:Clone()
	weaponName.Position = UDim2.new(0.5, 0, 0.5, 45)
	weaponName.Text = "NONE"
	weaponName.Parent = lootGui
	lootGui.Name = "pickupGui"
	lootGui.Parent = localPlayer.PlayerGui
end

local function fix(character)
	character.Humanoid:ChangeState(Enum.HumanoidStateType.Ragdoll)
	character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,false)
end
local function onInputEnd(input, gameProcessed)
	pcall(function()
	if not debounce then return end
	if input.UserInputType == Enum.UserInputType.Keyboard then
			if input.KeyCode == Enum.KeyCode[button] then
			lootEvent:FireServer(weapon, weapon.Parent)
			debounce = false
			weapon = nil
			weaponName.Text = "NONE"
			weaponName.TextTransparency = 1
			lootText.TextTransparency = 1
			weaponGiven = true
		end
	end
	end)
end

input.InputEnded:Connect(onInputEnd)
localPlayer.CharacterAdded:Connect(respawned)
localPlayer.CharacterRemoving:Connect(fix)