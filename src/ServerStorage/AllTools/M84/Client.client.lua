local Player = game:GetService("Players").LocalPlayer
local UIS = game:GetService("UserInputService")
local Mouse = Player:GetMouse()
local Tool = script.Parent
local Remote = Tool:WaitForChild("Remote")
local Tracks = {}
local InputType = Enum.UserInputType
local IsEquipped = false
local BeganConnection, EndedConnectionl
local ThrowBeganConnection, ThrowEndedConnectionl
local Power = Tool.Config.Velocity.Value


function playAnimation(animName)
	if Tracks[animName] then
		Tracks[animName]:Play()
	else
		local anim = Tool:FindFirstChild(animName)
		if anim and Tool.Parent and Tool.Parent:FindFirstChild("Humanoid") then
			Tracks[animName] = Tool.Parent.Humanoid:LoadAnimation(anim)
			playAnimation(animName)
		end
	end
end

function stopAnimation(animName)
	if Tracks[animName] then
		Tracks[animName]:Stop()
	end
end

function inputBegan(input)
	if input.UserInputType == InputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.G then
		local Object = script.Parent.Handle
		Object.Swing:Play()
		if Power == 200 then

		playAnimation("High")
		wait(.55)
		local lp = game.Players.LocalPlayer
		local ms = lp:GetMouse()
		if not IsEquipped then return end
		Remote:FireServer(ms.Hit)

		elseif Power == 150 then
			
		playAnimation("Med")
		wait(.55)
		local lp = game.Players.LocalPlayer
		local ms = lp:GetMouse()
		if not IsEquipped then return end
		Remote:FireServer(ms.Hit)

		elseif Power == 75 then
			
		playAnimation("Low")
		wait(.75)
		local lp = game.Players.LocalPlayer
		local ms = lp:GetMouse()
		if not IsEquipped then return end
		Remote:FireServer(ms.Hit)

		end
	end
end


function ThrowType(input, gameProcessed)
	if input.UserInputType == Enum.UserInputType.Keyboard then
		if input.KeyCode == Enum.KeyCode.F then
			print("Low Throw:",input.KeyCode)
			Power = 75
			script.Parent.Power:FireServer(Power)
		elseif input.KeyCode == Enum.KeyCode.H then
			print("Med Throw:",input.KeyCode)
			Power = 100
			script.Parent.Power:FireServer(Power)
		elseif input.KeyCode == Enum.KeyCode.G then
			print("High Throw:",input.KeyCode)
			Power = 150
			script.Parent.Power:FireServer(Power)
		end
	end
end

function onEquip()
	BeganConnection = UIS.InputBegan:connect(inputBegan)
	ThrowBeganConnection = UIS.InputBegan:Connect(ThrowType)
	IsEquipped = true
end

function onUnequip()
	if BeganConnection then
		BeganConnection:disconnect()
		ThrowBeganConnection:disconnect()
		BeganConnection = nil
		ThrowBeganConnection = nil
		IsEquipped = false
	end
end

Tool.Equipped:connect(onEquip)
Tool.Unequipped:connect(onUnequip)