local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local mouse = game.Players.LocalPlayer:GetMouse()

local viewportRotation = {}
viewportRotation.__index = viewportRotation

function viewportRotation:Enable(viewportFrame,sensitivity)

	local viewportModel = viewportFrame:FindFirstChildWhichIsA("Model")

	self.viewport = {
		inputChanged = nil;
		inputChanged2 = nil;
		inputBegan = nil;
		inputEnded = nil;

		touchStarted = nil;
		touchEnded = nil;
		
		renderStepped = nil;
	}
	setmetatable(self.viewport, viewportRotation)
	
	local ButtonsHeld = {}
	local LastMousePos = nil
	
	local scrollSpeed = 3
	local easeSpeed = .5
	local fovTarget = 70

	self.viewport.inputChanged = UserInputService.InputChanged:Connect(function(input, gameProcessedEvent)
		if input.UserInputType == Enum.UserInputType.MouseMovement then -- runs every time mouse is moved
			if ButtonsHeld["MouseButton1"] then -- makes sure player is holding down right click
				local CurrentMousePos = Vector2.new(mouse.X,mouse.Y)
				local change = (CurrentMousePos - LastMousePos)/(sensitivity*(70/viewportFrame.CurrentCamera.FieldOfView)) -- calculates distance mouse traveled (/5 to lower sensitivity)

				-- The angles part is weird here because of how the cube happens to be oriented. The angles may differ for other sections
				local bothY = CFrame.Angles(math.rad(change.Y), math.rad(change.X), -math.rad(change.Y))
				
				viewportModel:PivotTo(
					viewportModel:GetPivot() * (viewportModel:GetAttribute("bothY") and bothY or CFrame.Angles(
					viewportModel:GetAttribute("useY") and math.rad(change.Y) or 0,
					math.rad(change.X),
					viewportModel:GetAttribute("useY") and 0 or (viewportModel:GetAttribute("inverseY") and math.rad(change.Y) or -math.rad(change.Y)))
					))

				LastMousePos = CurrentMousePos
				-- This line makes everything possible. The PrimaryPart's orientation DOES NOT move the rest of the model with it.
				if viewportModel.PrimaryPart then viewportModel.PrimaryPart.Orientation = Vector3.zero end
			elseif ButtonsHeld["MouseButton3"] then
				local CurrentMousePos = Vector2.new(mouse.X,mouse.Y)
				local change = (CurrentMousePos - LastMousePos)/(135*(70/viewportFrame.CurrentCamera.FieldOfView)) -- calculates distance mouse traveled (/5 to lower sensitivity)

				-- The angles part is weird here because of how the cube happens to be oriented. The angles may differ for other sections
				viewportFrame.CurrentCamera.CFrame += (viewportFrame.CurrentCamera.CFrame.RightVector*-change.X) + (viewportFrame.CurrentCamera.CFrame.UpVector*change.Y)

				LastMousePos = CurrentMousePos
			end
		elseif input.UserInputType == Enum.UserInputType.Touch then
			if ButtonsHeld["Touch"] then
				local CurrentMousePos = Vector2.new(mouse.X,mouse.Y)
				local change = (CurrentMousePos - LastMousePos)/(sensitivity*(70/viewportFrame.CurrentCamera.FieldOfView)) -- calculates distance mouse traveled (/5 to lower sensitivity)

				-- The angles part is weird here because of how the cube happens to be oriented. The angles may differ for other sections
				local bothY = CFrame.Angles(math.rad(change.Y), math.rad(change.X), -math.rad(change.Y))

				viewportModel:PivotTo(
					viewportModel:GetPivot() * (viewportModel:GetAttribute("bothY") and bothY or CFrame.Angles(
					viewportModel:GetAttribute("useY") and math.rad(change.Y) or 0,
					math.rad(change.X),
					viewportModel:GetAttribute("useY") and 0 or (viewportModel:GetAttribute("inverseY") and math.rad(change.Y) or -math.rad(change.Y)))
					))

				LastMousePos = CurrentMousePos
				-- This line makes everything possible. The PrimaryPart's orientation DOES NOT move the rest of the model with it.
				if viewportModel.PrimaryPart then viewportModel.PrimaryPart.Orientation = Vector3.zero end
			end
		end
	end)

	self.viewport.inputBegan = viewportFrame.InputBegan:Connect(function(input, gameProcessedEvent)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then -- player starts dragging
			LastMousePos = Vector2.new(mouse.X, mouse.Y)
			ButtonsHeld["MouseButton1"] = true
		elseif input.UserInputType == Enum.UserInputType.MouseButton3 then
			LastMousePos = Vector2.new(mouse.X, mouse.Y)
			ButtonsHeld["MouseButton3"] = true
		end
	end)
	
	self.viewport.inputChanged2 = viewportFrame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseWheel then
			local up = input.Position.Z > 0 and -1 or 1

			fovTarget += up * scrollSpeed
		end
	end)

	self.viewport.inputEnded = viewportFrame.InputEnded:Connect(function(input, gameProcessedEvent)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then -- player stops dragging
			ButtonsHeld["MouseButton1"] = nil
			LastMousePos = nil
		elseif input.UserInputType == Enum.UserInputType.MouseButton3 then
			ButtonsHeld["MouseButton3"] = nil
			LastMousePos = nil
		end
	end)

	self.viewport.touchStarted = UserInputService.TouchStarted:Connect(function(input, gameProcessedEvent)
		if input.UserInputType == Enum.UserInputType.Touch then -- player starts dragging
			LastMousePos = Vector2.new(mouse.X, mouse.Y)
			ButtonsHeld["Touch"] = true
		end
	end)

	self.viewport.touchEnded = UserInputService.TouchEnded:Connect(function(input, gameProcessedEvent)
		if input.UserInputType == Enum.UserInputType.Touch then -- player starts dragging
			ButtonsHeld["Touch"] = nil
			LastMousePos = nil
		end
	end)
	
	self.viewport.renderStepped = RunService.RenderStepped:Connect(function()
		local camera = viewportFrame.CurrentCamera
		if not camera then self.viewport.renderStepped:Disconnect() return end
		
		local fovCamera = camera.FieldOfView
		local fovDifference = fovTarget - fovCamera

		camera.FieldOfView += fovDifference * easeSpeed
	end)

	return self.viewport
end

function viewportRotation:Disable(viewportFrame)
	if self.viewport then
		self.viewport.inputChanged:Disconnect()
		self.viewport.inputChanged2:Disconnect()
		self.viewport.inputBegan:Disconnect()
		self.viewport.inputEnded:Disconnect()

		self.viewport.touchStarted:Disconnect()
		self.viewport.touchEnded:Disconnect()
	end
end

return viewportRotation