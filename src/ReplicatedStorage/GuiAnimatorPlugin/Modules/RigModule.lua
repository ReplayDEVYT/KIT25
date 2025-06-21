local module = {}
local ScreenGui
local success = pcall(function() 
	ScreenGui=game:WaitForChild("CoreGui"):FindFirstChild("RigScreenGui") or  Instance.new("ScreenGui",game:WaitForChild("CoreGui")) 
end)
if not success then
	ScreenGui= Instance.new("Folder")
end

ScreenGui.Name = "RigScreenGui"

function module:ClearRigs()
	ScreenGui:ClearAllChildren()
end

function module:ShowJoint(joint:ObjectValue)
	--print("Showing joint",joint)
	local part1:Frame = joint.Value
	local pos1,size1,size2 = part1.AbsolutePosition+part1.AbsoluteSize/2,part1.AbsoluteSize,joint.Parent.AbsoluteSize
	local finalPosition,angle, limbPos,updatedJointOffsetVector = self:GetTransformJointPositions(joint)
	local angleRad = math.rad(angle)
	
	
	local jointPos= updatedJointOffsetVector--+limbPos
	local jointFolder = Instance.new("Folder",ScreenGui)
	
	local function ShowPoint(position:Vector2)
		local point = Instance.new("Frame",jointFolder)
		point.Position = UDim2.fromOffset(position.X,position.Y)
		point.AnchorPoint=Vector2.one/2
		point.Size = UDim2.fromOffset(6,6)
		local round = Instance.new("UICorner",point)
		round.CornerRadius=UDim.new(1,0)
		
		return point
	end
	local function ShowLine(pos1:Vector2,pos2:Vector2)
		local line = Instance.new("Frame",jointFolder)
		local vector =  (pos2-pos1)
		local position = pos1+vector/2
		line.Position = UDim2.fromOffset(position.X,position.Y)
		line.AnchorPoint=Vector2.one/2
		line.Size = UDim2.fromOffset(2,vector.Magnitude)
		line.Rotation = math.deg(math.atan2(vector.Y,vector.X))+90
		line.BorderSizePixel=0
		line.ZIndex = -1
		return line
	end
	ShowPoint(pos1).BackgroundColor3=Color3.new(0,0,1)
	ShowPoint(jointPos).BackgroundColor3=Color3.new(0,1,0)
	ShowPoint(limbPos).BackgroundColor3=Color3.new(1,0,0)
	if angleRad==angleRad then 
		ShowLine(jointPos,pos1).BackgroundColor3=Color3.new(0,0,1)
		ShowLine(limbPos,jointPos).BackgroundColor3=Color3.new(1,0,0)
	else
		ShowLine(limbPos,pos1).BackgroundColor3=Color3.new(0,1,0)
	end
	return jointFolder
end
function module:CreateJoint(part1:Frame,part2:Frame)
	local joint = script.RigJoint:Clone()
	joint.Parent=part2 joint.Value=part1 joint.Name=part2.Name.."Joint"
	local angle = part2.Rotation-part1.Rotation
	local limbOffset = (part2.AbsolutePosition+part2.AbsoluteSize/2)-(part1.AbsolutePosition+part1.AbsoluteSize/2)
	--print(part2.AbsolutePosition+part2.AbsoluteSize/2,part1.AbsolutePosition+part1.AbsoluteSize/2,limbOffset)
	joint:SetAttribute("LimbOffset",UDim2.fromOffset(limbOffset.X,limbOffset.Y))
	joint:SetAttribute("JointOffset",UDim2.fromOffset(0,0))
	joint:SetAttribute("Angle",angle)
	return joint
end
function module:FindJoint(rig)
	for _,joint in pairs(rig:GetChildren()) do
		if joint:GetAttribute("RigJoint") then
			return joint
		end
	end
end
function module:GetRigJoints(rig:Instance)
	local joints = {}
	
	for _,joint in pairs(rig:GetDescendants()) do
		if joint:GetAttribute("RigJoint") then
			table.insert(joints,joint)
		end
	end
	--local function parentOf(b,a)
	--	repeat
	--		a = self:FindJoint(a.Value)
	--	until not a or a==b
	--	return a==b
	--end
	--table.sort(joints,function(a:ObjectValue,b:ObjectValue)
	--	return parentOf(a,b)
	--end)
	local function CountParents(a)
		local parents = 0
		while a do
			a = self:FindJoint(a.Value)
			parents += 1
		end
		return parents
	end
	local function CompareParents(a,b)
		return CountParents(a) < CountParents(b)
	end
	table.sort(joints,function(a:ObjectValue,b:ObjectValue)
		return CompareParents(a,b)
	end)
	return joints
end
function module:ShowRig(rig:Instance)
	for _,joint in pairs(self:GetRigJoints(rig)) do
		self:ShowJoint(joint)
	end
end
function module:FixJointLocation(joint:ObjectValue)
	local part1:Frame,part2:Frame = joint.Value,joint.Parent
	local angle = part1.Rotation+joint:GetAttribute("Angle")
	part2.Rotation=angle
	local limbPosition:UDim2 = joint:GetAttribute("LimbOffset")
	local mainPosition:Vector2,mainSize:Vector2 = part1.AbsolutePosition+part1.AbsoluteSize/2,part1.AbsoluteSize
	local parentFrame = part2.Parent
	local parentOffset = Vector2.zero
	while not parentFrame:IsA("GuiObject") or parentFrame==game do parentFrame=parentFrame.Parent end
	if parentFrame~= game then
		parentOffset = parentFrame.AbsolutePosition
	end
	
	local limbSize,limbAnchor = part2.AbsoluteSize,part2.AnchorPoint
	local sizeOffset = -limbSize/2+limbAnchor*limbSize
	local positionVector = (
		Vector2.new(limbPosition.X.Scale,limbPosition.Y.Scale)*mainSize+Vector2.new(limbPosition.X.Offset,limbPosition.Y.Offset)+mainPosition+
			sizeOffset-parentOffset
	)
	local finalPosition = UDim2.fromOffset(positionVector.X,positionVector.Y)
	part2.Position=finalPosition
end
function module:GetTransformJointPositions(joint:ObjectValue)
	local part1:Frame,				part2:Frame			= 	joint.Value,joint.Parent
	local limbSize,					limbAnchor 			= 	part2.AbsoluteSize,part2.AnchorPoint
	local transformOffset:UDim2,	transformAngle 		= 	joint:GetAttribute("Transform"),joint:GetAttribute("TransformAngle")
	local jointOffset:UDim2								=	joint:GetAttribute("JointOffset")
	local transformVector 								= 	Vector2.new(transformOffset.X.Offset,transformOffset.Y.Offset)+Vector2.new(transformOffset.X.Scale,transformOffset.Y.Scale)*limbSize
	local jointVector:Vector2							=	Vector2.new(jointOffset.X.Offset,jointOffset.Y.Offset)+Vector2.new(jointOffset.X.Scale,jointOffset.Y.Scale)*limbSize
	local angle 										= 	part1.Rotation+joint:GetAttribute("Angle")
	local limbPosition:UDim2 							= 	joint:GetAttribute("LimbOffset")
	local mainPosition:Vector2,		mainSize:Vector2 	= 	part1.AbsolutePosition+part1.AbsoluteSize/2,part1.AbsoluteSize
	local sizeOffset 									= 	-limbSize/2+limbAnchor*limbSize
	local parentFrame,				parentOffset 		= 	part1.Parent,Vector2.zero

	while not parentFrame:IsA("GuiObject") or parentFrame==game do parentFrame=parentFrame.Parent end
	if parentFrame~= game then
		parentOffset = parentFrame.AbsolutePosition
	end
	--part2.Rotation=angle
	
	local jointOffsetAngle = math.atan2(jointVector.Y,jointVector.X)+math.rad(angle)--+math.rad(transformAngle)
	jointVector=Vector2.new(math.cos(jointOffsetAngle),math.sin(jointOffsetAngle))*jointVector.Magnitude
	local trueOffsetVector = (
			Vector2.new(limbPosition.X.Scale,limbPosition.Y.Scale)*mainSize+
			Vector2.new(limbPosition.X.Offset,limbPosition.Y.Offset)
	)
	local trueOffsetAngle = math.atan2(trueOffsetVector.Y,trueOffsetVector.X)+math.rad(angle)--+math.rad(transformAngle)
	trueOffsetVector=Vector2.new(math.cos(trueOffsetAngle),math.sin(trueOffsetAngle))*trueOffsetVector.Magnitude
	local transformVectorAngle =  math.atan2(transformVector.Y,transformVector.X)+math.rad(angle)
	transformVector=Vector2.new(math.cos(transformVectorAngle),math.sin(transformVectorAngle))*transformVector.Magnitude
	
	local jointPositionVector = (
		trueOffsetVector+mainPosition-parentOffset+jointVector+transformVector
	)
	local jointLimbOffset = -jointVector
	--transformAngle
	local currentAngle = (math.atan2(jointLimbOffset.Y,jointLimbOffset.X))+math.rad(transformAngle)
	local jointTransformVector = Vector2.new(math.cos(currentAngle),math.sin(currentAngle))*jointLimbOffset.Magnitude

	local positionVector=jointPositionVector+jointTransformVector
	local finalPositionVector=positionVector+sizeOffset
	local finalPosition = UDim2.fromOffset(finalPositionVector.X,finalPositionVector.Y)

	local jointTruePos,limbTruePos=jointPositionVector+parentOffset,positionVector+parentOffset
	return finalPosition,angle+transformAngle, limbTruePos,jointTruePos
end
function module:TransformJoint(joint:ObjectValue)
	local part1:Frame,				part2:Frame			= 	joint.Value,joint.Parent
	local finalPosition,angle, positionVector,jointPositionVector = self:GetTransformJointPositions(joint)
	part2.Rotation=angle
	part2.Position=finalPosition
	
	
end
function module:FixRigJointsLocation(rig:Instance)
	for _,joint in pairs(self:GetRigJoints(rig)) do
		self:FixJointLocation(joint)
	end
end
function module:TransformRigJoints(rig:Instance)
	self:FixRigJointsLocation(rig)
	for _,joint in pairs(self:GetRigJoints(rig)) do
		self:TransformJoint(joint)
	end
end
function module:ResetTransformRigJoints(rig:Instance)
	self:FixRigJointsLocation(rig)
	for _,joint in pairs(self:GetRigJoints(rig)) do
		joint:SetAttribute("Transform",UDim2.new())
		joint:SetAttribute("TransformAngle",0)
	end
end
return module
