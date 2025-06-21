--!nonstrict
local rigModule = require(script.Parent.RigModule)
local tweenService = game:GetService("TweenService")
local module = {
	
}
module.__index=module
function module.new():GuiAnimation
	local animation = {
		KeyFrames=CreateTimeLine(),
		FPS=30,
		CurrentTime=0,
		TotalFrames=120,
		Loops=false,
		Playing=nil,
	}
	animation.TimeChanged={
		ConnectedFunctions={}
	}
	function animation.TimeChanged:Connect(func)
		table.insert(self.ConnectedFunctions,func)
		return {
			Disconnect=function()
				table.remove(self.ConnectedFunctions,table.find(self.ConnectedFunctions,func))
			end
		}
	end
	function animation.TimeChanged:Fire(input)
		for _,func in pairs(self.ConnectedFunctions) do
			func(input)
		end
	end
	animation.Ended={
		ConnectedFunctions={}
	}
	function animation.Ended:Connect(func)
		table.insert(self.ConnectedFunctions,func)
		return {
			Disconnect=function()
				table.remove(self.ConnectedFunctions,table.find(self.ConnectedFunctions,func))
			end
		}
	end
	function animation.Ended:Fire(input)
		for _,func in pairs(self.ConnectedFunctions) do
			func(input)
		end
	end
	setmetatable(animation,module)
	return animation
end
function module.CreateKeyFrame(Transform:UDim2,TransformAngle:number,EasingStyle:Enum.EasingStyle?,EasingDirection:Enum.EasingDirection?)
	
	local keyframe = {
		Name="KeyFrame",
		Transform=Transform or UDim2.new(),
		TransformAngle=TransformAngle or 0,
		EasingStyle=EasingStyle or Enum.EasingStyle.Linear ,
		EasingDirection=EasingDirection or Enum.EasingDirection.In
	}
	return keyframe
end
function module.Export(self:GuiAnimation,name:string,parent:Instance)
	local animationFolder = Instance.new("Animation",parent)
	if name then animationFolder.Name = name end
	animationFolder:SetAttribute("FPS",self.FPS)
	animationFolder:SetAttribute("TotalFrames",self.TotalFrames)
	animationFolder:SetAttribute("Loops",self.Loops)
	for limb,keyFrames in pairs(self.KeyFrames) do
		local jointFolder = Instance.new("Folder",animationFolder) 
		jointFolder.Name = limb
		for frameNum,keyFrame:KeyFrame in pairs(keyFrames) do
			local frameInstance = Instance.new("IntValue",jointFolder)
			frameInstance.Name=keyFrame.Name
			frameInstance.Value=tonumber(frameNum)
			frameInstance:SetAttribute("Transform",keyFrame.Transform)
			frameInstance:SetAttribute("TransformAngle",keyFrame.TransformAngle)
			frameInstance:SetAttribute("EasingStyle",keyFrame.EasingStyle.Value)
			frameInstance:SetAttribute("EasingDirection",keyFrame.EasingDirection.Value)
		end 
	end
	return animationFolder
end
function module:Import(animationInstance:Folder)
	local animation = module.new()
	animation.FPS= animationInstance:GetAttribute("FPS")
	animation.TotalFrames= animationInstance:GetAttribute("TotalFrames")
	animation.Loops= animationInstance:GetAttribute("Loops")
	for _,jointFrames in pairs(animationInstance:GetChildren()) do
		animation.KeyFrames[jointFrames.Name]={}
		for _,KeyFrameData in pairs(jointFrames:GetChildren()) do
			local keyFrame = module.CreateKeyFrame(
				KeyFrameData:GetAttribute("Transform"),
				KeyFrameData:GetAttribute("TransformAngle"),
				Enum.EasingStyle:GetEnumItems()[KeyFrameData:GetAttribute("EasingStyle")+1],
				Enum.EasingDirection:GetEnumItems()[KeyFrameData:GetAttribute("EasingDirection")+1]
			)
			animation.KeyFrames[jointFrames.Name][KeyFrameData.Value]=keyFrame
		end
	end
	return animation
end
function CreateTimeLine()
	local KeyFrames:{[string]:TimeStamps}={}
	return KeyFrames
end
function module.RoundTimeToFrame(self:GuiAnimation, Time)
	return math.round(Time*self.FPS)+1,Time*self.FPS+1
end
function module.FrameToTime(self:GuiAnimation, FrameNum)
	return (FrameNum-1)/self.FPS
end
function module.GetFrame(self:GuiAnimation,Time)
	local frame={}
	for limb,timeStamps in pairs(self.KeyFrames) do
		
		frame[limb]=self:GetTransformAtTime(limb,Time)
		
	end
	return frame
end
function module.GetCurrentFrame(self:GuiAnimation)
	return self:GetFrame(self.CurrentTime)
end
function module.GetCurrentFrameNum(self:GuiAnimation)
	return self:RoundTimeToFrame(self.CurrentTime)
end
function module.GetNextTimeStamp(self:GuiAnimation,limb,currentFrame):(KeyFrame?,number?)
	local nextFrameNum,nextTimeStamp=nil,nil
	for frameNum,timeStamp in pairs(self.KeyFrames[limb]) do
		if tonumber(frameNum) > tonumber(currentFrame) and (not nextFrameNum or tonumber(nextFrameNum)>tonumber(frameNum)) then
			nextFrameNum,nextTimeStamp=frameNum, timeStamp
		end
	end
	return nextTimeStamp,nextFrameNum
end
function module.GetPrevTimeStamp(self:GuiAnimation,limb,currentFrame):(KeyFrame?,number?)
	local lastFrameNum,lastTimeStamp=nil,nil
	for frameNum,timeStamp in pairs(self.KeyFrames[limb]) do
		if tonumber(frameNum) < tonumber(currentFrame) and (not lastFrameNum or tonumber(lastFrameNum)<tonumber(frameNum)) then
			lastFrameNum, lastTimeStamp=frameNum, timeStamp
		end
		
	end
	return lastTimeStamp,lastFrameNum
end
function module.DeleteKeyFrames(self:GuiAnimation,frames:{[string]:{number}})
	for limb,frames in pairs(frames) do
		for _,frameNum in pairs(frames) do
			self.KeyFrames[limb][frameNum]=nil
		end
	end
end
function module.CreateKeyFrameAtFrame(self:GuiAnimation,limb:string,frame:number)
	if not self.KeyFrames[limb] then
		self.KeyFrames[limb]={}
	end
	if self.KeyFrames[limb][frame] then
		return self.KeyFrames[limb][frame]
	end
	local transformData = self:GetTransformAtTime(limb,self:FrameToTime(frame))
	
	local keyFrame = module.CreateKeyFrame(transformData.Transform,transformData.TransformAngle)
	self.KeyFrames[limb][frame]=keyFrame
	return keyFrame
end
function module.UpdateKeyFrame(self:GuiAnimation,data:{[string]:KeyFrame},frame:number)

	for limb,keyframeOverwrite in pairs(data) do
		local keyframe = self:CreateKeyFrameAtFrame(limb,frame)
		for prop,val in pairs(keyframeOverwrite)  do
			keyframe[prop]=val
		end
	end
end
function module.UpdateKeyFrames(self:GuiAnimation,data:{[number]:{[string]:KeyFrame}})
	for frame,keyFrame in pairs(data) do
		self:UpdateKeyFrame(keyFrame,frame)
	end
end
function module.UpdateCurrentKeyFrame(self:GuiAnimation,data:{[string]:KeyFrame})
	self:UpdateKeyFrame(data, self:GetCurrentFrameNum())
end
function module.GetTransformAtTime(self:GuiAnimation,limb,Time)
	if not self.KeyFrames[limb] then return end
	local frameNum,frameTime = self:RoundTimeToFrame(Time)
	if tonumber(frameNum) == tonumber(frameTime) then
		local keyFrame = self.KeyFrames[limb][frameNum]
		if keyFrame then return keyFrame end
	end
	local prevFrame,prevFrameNum = self:GetPrevTimeStamp(limb,frameTime)
	local nextFrame,nextFrameNum=self:GetNextTimeStamp(limb,frameTime)
	if prevFrame and nextFrame then
		local alpha = tweenService:GetValue((frameTime-prevFrameNum)/(nextFrameNum-prevFrameNum),
			prevFrame.EasingStyle or Enum.EasingStyle.Linear ,
			prevFrame.EasingDirection or Enum.EasingDirection.In
		)
		return {
			Transform = prevFrame.Transform:Lerp(nextFrame.Transform,alpha),
			TransformAngle =prevFrame.TransformAngle+(nextFrame.TransformAngle-prevFrame.TransformAngle)*alpha 
		}
	elseif prevFrame then
		return {
			Transform = prevFrame.Transform,
			TransformAngle =prevFrame.TransformAngle 
		}
	elseif nextFrame then
		return {
			Transform = nextFrame.Transform,
			TransformAngle =nextFrame.TransformAngle 
		}
	else
		return {
			Transform = UDim2.fromOffset(0,0),
			TransformAngle =0
		}
	end
end
function module.SetRigPoseAtTime(self:GuiAnimation,rig,Time)
	local joints = rigModule:GetRigJoints(rig)
	for _,joint in pairs(joints) do
		local transformInfo = self:GetTransformAtTime(joint.Name,Time)
		
		if not transformInfo then continue end
		joint:SetAttribute("Transform",transformInfo.Transform)
		joint:SetAttribute("TransformAngle",transformInfo.TransformAngle)
	end
end
function module.SetRigPoseAtCurrentTime(self:GuiAnimation,rig,Time)
	self:SetRigPoseAtTime(rig,self.CurrentTime)
	--print(self.KeyFrames)
end
function module.GetKeyFrames(self:GuiAnimation)
	return self.KeyFrames
end
function module.GetKeyFrame(self:GuiAnimation,limb:string,frame:number)
	return self.KeyFrames[limb] and self.KeyFrames[limb][frame]
end
function module.SetCurrentTime(self:GuiAnimation,Time:number)
	local atEnd = false
	local _,TimeFrame = self:RoundTimeToFrame(Time)
	if TimeFrame>=self.TotalFrames then
		Time=self:FrameToTime(self.TotalFrames)
		atEnd = true
	end
	self.CurrentTime=Time
	self.TimeChanged:Fire(Time)
	return atEnd
end
function module.Play(self:GuiAnimation)
	if self.Playing then return end
	local _,TimeFrame = self:RoundTimeToFrame(self.CurrentTime)
	if TimeFrame>=self.TotalFrames then
		self:SetCurrentTime(0)
	end
	self.Playing = game:GetService("RunService").RenderStepped:Connect(function(deltaTime)
		if self:SetCurrentTime(self.CurrentTime+deltaTime) then
			if self.Loops then
				self:SetCurrentTime(0)
			else
				self:Pause()
				self.Ended:Fire()
			end
			
		end
	end)
end

function module.Stop(self:GuiAnimation)
	self:Pause()
	self:SetCurrentTime(0)
end
function module.Pause(self:GuiAnimation)
	if self.Playing then
		self.Playing:Disconnect()
		self.Playing = nil
	end
end

function module.LoadRig(self:GuiAnimation,rig)
	local con con=self.TimeChanged:Connect(function()
		self:SetRigPoseAtCurrentTime(rig) 
		rigModule:TransformRigJoints(rig)
	end)
	return con
end

export type KeyFrame=typeof(module.CreateKeyFrame(UDim2.new(),0))
export type TimeLine=typeof(CreateTimeLine())
export type TimeStamps={
	[number]:KeyFrame,
}
export type GuiAnimation=typeof(module.new())


return module
