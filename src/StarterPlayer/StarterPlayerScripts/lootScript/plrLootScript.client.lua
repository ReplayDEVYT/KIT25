local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local runS = game:GetService("RunService")
local repS = game:GetService("ReplicatedStorage")
local input = game:GetService("UserInputService")
local lootEvent = repS:WaitForChild("lootEvent")
local setting = require(game.Workspace.LootMod.Settings)
local button = setting.button
local camLock = setting.firstPerson
local mouse = localPlayer:GetMouse()
local lootGui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 0)
frame.Position = UDim2.new(0.5, -25, 0.5, 0)
frame.AnchorPoint = Vector2.new(1, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(7, 0, 18)
frame.BorderSizePixel = 0
frame.Parent = lootGui
lootGui.Parent = localPlayer.PlayerGui
lootGui.Name = "bodyLooter"
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
local lootName = lootText:Clone()
lootName.Position = UDim2.new(0.5, 0, 0.5, 40)
lootName.Text = "NONE"
lootName.TextSize = 10
lootName.Parent = lootGui
local emptyText = lootText:Clone()
emptyText.Text = "EMPTY"
emptyText.TextSize = 10
emptyText.TextColor3 = Color3.fromRGB(109, 0, 0)
emptyText.Parent = lootGui
local lootSelect = script.lootSelect
local allowPlrLooting = setting.plrLooting
local weapon = nil
local debounce = false
local selected = nil
local selectedButton = nil
local open = false
local colors = {Color3.fromRGB(255, 0, 0), Color3.fromRGB(155, 0, 255), Color3.fromRGB(255, 120, 0), Color3.fromRGB(255, 255, 255)}

while not localPlayer.Character do
	wait()
end

runS.RenderStepped:Connect(function()
	if not allowPlrLooting then return end
	if camLock then
		localPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
	end
	if not mouse.Target then return end
	if mouse.Target.Parent.Name == "lootBag" then
		if mouse.Target.Parent:FindFirstChild("Inventory") and #mouse.Target.Parent:FindFirstChild("Inventory"):GetChildren() <= 0 then
			if not localPlayer.Character.Humanoid.RootPart then return end
			local distance = (localPlayer.Character.Humanoid.RootPart.Position - mouse.Target.Position).Magnitude
			if distance > setting.lootRange*2 then return end
			emptyText.TextTransparency = 0
			debounce = false
			for i, v in pairs(frame:GetChildren()) do
				v:Destroy()
			end
			frame.Size = UDim2.new(0, 200, 0, 0)
			lootText.TextTransparency = 1
			lootName.TextTransparency = 1
			selectedButton = nil
			selected = nil
			open = false
			return
		end
		emptyText.TextTransparency = 1
		if #mouse.Target.Parent:FindFirstChild("Inventory"):GetChildren() ~= #frame:GetChildren() and debounce then
			debounce = false
			for i, v in pairs(frame:GetChildren()) do
				v:Destroy()
			end
			frame.Size = UDim2.new(0, 200, 0, 0)
			lootText.TextTransparency = 1
			lootName.TextTransparency = 1
			return
		end
		if not localPlayer.Character.Humanoid.RootPart then return end
		local distance = (localPlayer.Character.Humanoid.RootPart.Position - mouse.Target.Position).Magnitude
		if distance > setting.lootRange*2 then return end
		if debounce then return end
		lootName.Text = mouse.Target.Parent.name.Value
		if not open then 
			lootText.TextTransparency = 0
			lootName.TextTransparency = 0
			return
		end
		lootText.TextTransparency = 1
		lootName.TextTransparency = 1
		for i, v in pairs(mouse.Target.Parent:FindFirstChild("Inventory"):GetChildren()) do
			frame.Size = frame.Size + UDim2.new(0, 0, 0, 20)
			local lootButton = lootSelect:Clone()
			lootButton.Position = frame.Size
			lootButton.TextColor3 = colors[v.toolType.Value]
			if lootButton.Position == UDim2.new(0, 200, 0, 20) then
				selected = v
				selectedButton = lootButton
				selectedButton.BackgroundTransparency = 0
			end
			lootButton.Text = v.Name
			lootButton.Parent = frame
		end
		debounce = true
	else
		debounce = false
		for i, v in pairs(frame:GetChildren()) do
			v:Destroy()
		end
		frame.Size = UDim2.new(0, 200, 0, 0)
		lootText.TextTransparency = 1
		emptyText.TextTransparency = 1
		lootName.TextTransparency = 1
		selectedButton = nil
		selected = nil
		open = false
	end
end)

local function onInputEnd(input, gameProcessed)
	local succ, err = pcall(function()
		if input.UserInputType == Enum.UserInputType.Keyboard then
			if input.KeyCode == Enum.KeyCode[button] then
				if open then
					if not selected then return end
					lootEvent:FireServer(selected, selected.Parent.Parent)
					debounce = false
					for i, v in pairs(frame:GetChildren()) do
						v:Destroy()
					end
					frame.Size = UDim2.new(0, 200, 0, 0)
				else
					if not mouse.Target then return end
					if mouse.Target.Parent.Name == "lootBag" then
						if not #mouse.Target.Parent:FindFirstChild("Inventory"):GetChildren() then
							emptyText.TextTransparency = 0
							return
						end
						open = true
					end
				end
			end
		end
	end)
	if not succ then print(err) end
end

local function wheelForward()
	local succ, err = pcall(function()
		if not debounce then return end
		if not selectedButton then return end
		if selectedButton.Position.Y.Offset == 20 then
			return
		else
			local changed = false
			for i, v in pairs(frame:GetChildren()) do
				if changed then return end
				if v.Position.Y.Offset == selectedButton.Position.Y.Offset - 20 then
					selectedButton.BackgroundTransparency = 1
					selectedButton = v
					selectedButton.BackgroundTransparency = 0
					selected = selected.Parent[v.Text]
					changed = true
				end
			end
		end
	end)
	if not succ then print(err) end
end

local function wheelBackward()
	local succ, err = pcall(function()
		if not debounce then return end
		if not selectedButton then return end
		local highest = UDim2.new(0, 200, 0, 0)
		for i, v in pairs(frame:GetChildren()) do
			if v.Position.Y.Offset > highest.Y.Offset then
				highest = v.Position
			end
		end
		if selectedButton.Position == highest then
			return
		else
			local changed = false
			for i, v in pairs(frame:GetChildren()) do
				if changed then return end
				if v.Position.Y.Offset == selectedButton.Position.Y.Offset + 20 then
					selectedButton.BackgroundTransparency = 1
					selectedButton = v
					selectedButton.BackgroundTransparency = 0
					selected = selected.Parent[v.Text]
					changed = true
				end
			end
		end
	end)
	if not succ then print(err) end
end

local function respawned()
	frame:Destroy()
	lootGui:Destroy()
	lootText:Destroy()
	emptyText:Destroy()
	lootName:Destroy()
	lootGui = Instance.new("ScreenGui")
	frame = Instance.new("Frame")
	frame.Size = UDim2.new(0, 200, 0, 0)
	frame.Position = UDim2.new(0.5, -25, 0.5, 0)
	frame.AnchorPoint = Vector2.new(1, 0.5)
	frame.BackgroundColor3 = Color3.fromRGB(7, 0, 18)
	frame.BorderSizePixel = 0
	frame.Parent = lootGui
	lootGui.Parent = localPlayer.PlayerGui
	lootGui.Name = "bodyLooter"
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
	lootName = lootText:Clone()
	lootName.Position = UDim2.new(0.5, 0, 0.5, 40)
	lootName.Text = "NONE"
	lootName.TextSize = 10
	lootName.Parent = lootGui
	emptyText = lootText:Clone()
	emptyText.Text = "EMPTY"
	emptyText.TextSize = 10
	emptyText.TextColor3 = Color3.fromRGB(109, 0, 0)
	emptyText.Parent = lootGui
	open = false
end

input.InputEnded:Connect(onInputEnd)
mouse.WheelForward:Connect(wheelForward)
mouse.WheelBackward:Connect(wheelBackward)
localPlayer.CharacterAdded:Connect(respawned)