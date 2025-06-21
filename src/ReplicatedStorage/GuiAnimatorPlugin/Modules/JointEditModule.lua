local rigMod = require(script.Parent.RigModule)
local ScreenGui = game:WaitForChild("CoreGui"):FindFirstChild("JointEditorScreenGui") or  Instance.new("ScreenGui",game:WaitForChild("CoreGui"))
ScreenGui.Name = "JointEditorScreenGui"

local module = {}
function module:ClearEditor()
	ScreenGui:ClearAllChildren()
end
local ArrowLength = 50
local CircleSize = 50
function module:MoveJoint(plugin, joint:ObjectValue,func)
	self:ClearEditor()
	local toolsFolder = Instance.new("Folder",ScreenGui) toolsFolder.Name="MoveTool"
	--local _,_,_,jointPos = rigMod:GetTransformJointPositions(joint)
	local arrows = {}
	local posUpdaters = {}
	
	local function ChangeTransform(deltaVector:Vector2)
		func(deltaVector)
		--for _,arrow in pairs(arrows) do
		--	arrow.Position+=UDim2.fromOffset(deltaVector.X,deltaVector.Y)
		--end
	end
	local function ArrowInput(arrow,input,arrowVector)
		if input.UserInputType==Enum.UserInputType.MouseButton1 and Enum.UserInputState.Begin then

			plugin:Activate(false)
			local mouse = plugin:GetMouse()
			local lastPos = Vector2.new(mouse.X,mouse.Y)
			local con=mouse.Move:Connect(function()

				local pos = Vector2.new(mouse.X,mouse.Y)
				local delta = pos-lastPos
				lastPos=pos
				ChangeTransform(delta*arrowVector )
			end)
			local con2 con2 = arrow.InputEnded:Connect(function(input)
				if input.UserInputType==Enum.UserInputType.MouseButton1 then
					con:Disconnect()
					con2:Disconnect()
				end
			end)


		end
	end
	local function UpdatePos()
		local _,_,_,jointPos = rigMod:GetTransformJointPositions(joint)
		for _,func in pairs(posUpdaters) do
			func(jointPos)
		end
	end
	local function AddArrow(color,angle)
		local Arrow = Instance.new("Frame",toolsFolder)
		Arrow.BackgroundColor3=color
		Arrow.Size = UDim2.fromOffset(ArrowLength,4)
		Arrow.Rotation  = angle
		local arrowDirection=Vector2.new(math.cos(math.rad(angle)),math.sin(math.rad(angle)))
		local arrowVector = arrowDirection*ArrowLength
		Arrow.AnchorPoint=Vector2.new(0.5,0.5)
		Arrow.Active=true
		Arrow.BorderSizePixel=0
		table.insert(arrows,Arrow)
		Arrow.InputBegan:Connect(function(input)
			ArrowInput(Arrow,input,arrowDirection)
		end)
		return Arrow,function(pos)
			local arrowPositionVector= arrowVector/2+pos
			Arrow.Position=UDim2.fromOffset(arrowPositionVector.X,arrowPositionVector.Y)
		end
	end
	local xArrow:Frame,posFunctionX = AddArrow(Color3.new(1,0,0),0)
	local yArrow:Frame,posFunctionY = AddArrow(Color3.new(0,0,1),90)
	table.insert(posUpdaters,posFunctionX)table.insert(posUpdaters,posFunctionY)
	UpdatePos()
	joint.Parent.Changed:Connect(function()
		UpdatePos()
	end)
	
end
function module:RotateJoint(plugin, joint:ObjectValue,func,finish)
	self:ClearEditor()
	plugin:Activate(false)
	local mouse = plugin:GetMouse()
	local toolsFolder = Instance.new("Folder",ScreenGui) toolsFolder.Name="RotateTool"
	--local _,_,_,jointPos = rigMod:GetTransformJointPositions(joint)
	local function GetJointPos()
		local _,_,_,jointPos = rigMod:GetTransformJointPositions(joint)
		return jointPos
	end
	local function GetMouseAngle()
		local mousePos = Vector2.new(mouse.X,mouse.Y)
		local jointPos = GetJointPos()
		local mouseVector = mousePos-jointPos
		local angle = math.atan2(mouseVector.Y,mouseVector.X)
		return math.deg(angle)
	end
	local function ChangeTransform(deltaAngle:number)
		return func(deltaAngle)
	end
	local function CircleInput(circle:Frame,input)
		if input.UserInputType==Enum.UserInputType.MouseButton1 and Enum.UserInputState.Begin then
			local startAngle = GetMouseAngle()
			local addedAngle = 0
			circle.Rotation=startAngle
			circle.RotatingPart.Rotation=0
			local lastAngle = GetMouseAngle()
			local con=mouse.Move:Connect(function()
				local angle = GetMouseAngle()
				local delta = angle-lastAngle
				lastAngle=angle
				addedAngle+=ChangeTransform(delta)
				circle.RotatingPart.Rotation= addedAngle --angle-startAngle
			end)
			local con2 con2 = circle.InputEnded:Connect(function(input)
				if input.UserInputType==Enum.UserInputType.MouseButton1 then
					con:Disconnect()
					con2:Disconnect()
					circle.Rotation=lastAngle
					circle.RotatingPart.Rotation=0
					finish()
				end
			end)


		end
	end
	local function AddCircle(angle)
		local Circle = script.RotatingToolUI:Clone()
		Circle.Parent =  toolsFolder
		Circle.Size = UDim2.fromOffset(CircleSize,CircleSize)
		Circle.Rotation  = angle

		Circle.InputBegan:Connect(function(input)
			CircleInput(Circle,input)
		end)
		return Circle,function(pos)
			Circle.Position=UDim2.fromOffset(pos.X,pos.Y)
		end
	end
	local rotatingTool:Frame,UpdateFunction = AddCircle(joint.Parent.Rotation)
	
	local function UpdatePos(func)
		local jointPos = GetJointPos()
		func(jointPos)
	end
	
	
	UpdatePos(UpdateFunction)
	joint.Parent.Changed:Connect(function()
		UpdatePos(UpdateFunction)
	end)

end

return module
