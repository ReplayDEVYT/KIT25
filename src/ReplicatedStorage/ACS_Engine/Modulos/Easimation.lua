--[[

DOCUMENTATION:

-- ========== EVENTS ============

• easimation.Played/easimation.Stopped - fired when the tween starts/stops when using easimation:Play() and easimation:Stop() (before the tween is actually visible)
• easimation.PlayCompleted/easimation.StopCompleted - fired when the tween finishes when using easimation:Play() and easimation:Stop()
• easimation.WeightEaseStarted - fired when the easing starts when using easimation:EaseWeight()
• easimation.WeightEaseCompleted - fired when the easing tween completes when using easimation:EaseWeight()
• easimation.SpeedEaseStarted- fired when the easing starts when using easimation:EaseSpeed()
• easimation.SpeedEaseCompleted - fired when the easing tween completes when using easimation:EaseSpeed()
• easimation.Eased - fired during easing constantly when the value is being updated (kind of like a Changed event)


-- ========== FUNCTIONS ============


--  easimation.New(animation, humanoid)

	• Returns an easimation object with access to the easing functions, the easing events (listed above), and the original animation track. 
	  You still have access to the original AnimationTrack's functions and properties, and you can access them by indexing the easimation
	  object like this:

      ex. easimation["animTrack"].IsPlaying --> would still be true or false


--  easimationObject:Play(finalWeight, speed, tweenInfo)

	• After getting your easimation object by using easimation.New(), then you can use easimationObject:Play() where finalWeight is the 
  	  weight to ease to. :Play() eases from "0" to finalWeight, with tweenInfo specified by you. speed is the Speed to play
      the animation at, obviously. Weights after 1 are the same visually, so if you enter a weight higher than 1 and want the same nice
      tween effect, this module tweens the weight to 1 and then sets the weight to your specified weight right after.


--  easimationObject:Stop(tweenInfo)

	• After getting your easimation object by using easimation.New(), then you can also use easimationObject:Stop()
      where tweenInfo is the Tween info to ease with. It tweens from its current weight to 0.


--  easimationObject:EaseWeight(finalWeight, tweenInfo)

	• After getting your easimation object by using easimation.New(), then you can also use easimationObject:EaseWeight(),
      where tweenInfo is the Tween info to ease with and finalWeight is the weight to tween to from its current weight.

--  easimationObject:EaseSpeed(finalSpeed, tweenInfo)

	• After getting your easimation object by using easimation.New(), then you can also use easimationObject:EaseSpeed(),
      where tweenInfo is the Tween info to ease with and finalSpeed is the speed to tween to from its current speed.


-- ===============  INSTRUCTION MANUAL  ================== 

To set it up, require it in the script(s) you need it for, obviously.
Now, you need to make a new easimation object by using easimation.New() [documentation above]

ex. local anim = easimation.New(script:WaitForChild("Animation"), humanoid)

Now you have an easimation object with access to the functions and events, as well as the original AnimationTrack. You're only gaining,
and not losing here.


Demonstrations of each function:

	local anim = easimation.New(script:WaitForChild("Animation"), humanoid)
	
	Playing the animation:
	anim:Play(1, 1, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingStyle.Out))
	
	Stopping the animation:
	anim:Stop(TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingStyle.Out))
	
	Easing the weight (let's assume its current weight is 0):
	anim:EaseWeight(1, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingStyle.Out)) -- eases the weight to 1 after 1 second
	
	Easing the speed (let's assume its current speed is 0):
	anim:EaseSpeed(-1, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingStyle.Out)) -- eases the speed to -1 after 1.5 seconds


Once again, thanks for using my module! PM me on the DevForum @rek_kie or reply to the DevForum post if there are any bugs. Enjoy!

]]--

local easimation = {}

local ts = require(game.ReplicatedStorage.TService)

function easimation.New(anim, humanoid)

	if not humanoid or not humanoid:IsA("Humanoid") then 
		warn("A humanoid has not been supplied to load the animation into.")
		return
	end

	if not anim or not anim:IsA("Animation") then 
		warn("An animation has not been supplied. Please supply an animation.")
		return
	end

	--print("Created")
	--events

	local PlayEvent = Instance.new("BindableEvent")
	local StoppedEvent = Instance.new("BindableEvent")
	local PlayCompletedEvent = Instance.new("BindableEvent")
	local StopCompletedEvent = Instance.new("BindableEvent")
	local WeightEaseStartedEvent = Instance.new("BindableEvent")
	local WeightEaseCompletedEvent = Instance.new("BindableEvent")
	local SpeedEaseStartedEvent = Instance.new("BindableEvent")
	local SpeedEaseCompletedEvent = Instance.new("BindableEvent")
	local EasedEvent = Instance.new("BindableEvent")

	local playingtween
	local stoppingtween

	--object

	local easimationObject = {
		["animTrack"] = humanoid:LoadAnimation(anim),
		["Played"] = PlayEvent.Event,
		["Stopped"] = StoppedEvent.Event,
		["PlayCompleted"] = PlayCompletedEvent.Event,
		["StopCompleted"] = StopCompletedEvent.Event,
		["WeightEaseStarted"] = WeightEaseStartedEvent.Event,
		["WeightEaseCompleted"] = WeightEaseCompletedEvent.Event,
		["SpeedEaseStarted"] = SpeedEaseStartedEvent.Event,
		["SpeedEaseCompleted"] = SpeedEaseCompletedEvent.Event,
		["Eased"] = EasedEvent.Event	 
	}

	function easimationObject:Play(finalWeight, speed, tweenInfo)
		speed = speed or 1
		if easimationObject["animTrack"].IsPlaying then return end
		--easimationObject["animTrack"]:Stop(0)
		
		if stoppingtween and stoppingtween.PlaybackState == Enum.PlaybackState.Playing then
			stoppingtween:Cancel()
			stoppingtween = nil
		end

		if playingtween and playingtween.PlaybackState == Enum.PlaybackState.Playing then
			playingtween:Cancel()
			playingtween = nil
		end
		
		local weightForTween 

		if finalWeight > 1 then 
			weightForTween = 1 
		else
			weightForTween = finalWeight
		end
		--if easimationObject["animTrack"].IsPlaying then return end
		easimationObject["animTrack"]:Play(0, .000001, speed) -- "Play" it at that weight so that it counts as Playing by ROBLOX, but have no visible effect 
		PlayEvent:Fire()

		local number = Instance.new("NumberValue")
		number.Value = easimationObject["animTrack"].WeightCurrent

		number:GetPropertyChangedSignal("Value"):Connect(function()
			easimationObject["animTrack"]:AdjustWeight(number.Value, 0)
			EasedEvent:Fire()
		end)

		playingtween = ts(number, tweenInfo, {Value = weightForTween})
		playingtween:Play()
		print("tweening "..easimationObject.animTrack.Animation.Name)
		playingtween.Completed:Connect(function()			
			number:Destroy()
			print("done tweening "..easimationObject.animTrack.Animation.Name)
			playingtween = nil
			if easimationObject["animTrack"].WeightCurrent ~= finalWeight then
				easimationObject["animTrack"]:AdjustWeight(finalWeight, 0)
			end	
			weightForTween = nil
			PlayCompletedEvent:Fire()

		end)

		if not easimationObject["animTrack"].Looped then
			easimationObject["animTrack"].Stopped:Connect(function()
				easimationObject["animTrack"]:Stop(0.01)
				StoppedEvent:Fire()
			end)
		end

	end

	function easimationObject:Stop(tweenInfo)
		if playingtween and playingtween.PlaybackState == Enum.PlaybackState.Playing then
			playingtween:Cancel()
			playingtween = nil
		end
		
		if stoppingtween and stoppingtween.PlaybackState == Enum.PlaybackState.Playing then
			stoppingtween:Cancel()
			stoppingtween = nil
		end
		
		local number = Instance.new("NumberValue")
		number.Value = easimationObject["animTrack"].WeightCurrent


		easimationObject["animTrack"]:Stop(100000000000) -- So that when you call :Stop() with this, .IsPlaying will be set to false immediately 
		StoppedEvent:Fire()                             -- without visually interrupting the tween, so it functions like stopping an animation with 
		-- normal fade time

		number:GetPropertyChangedSignal("Value"):Connect(function()
			easimationObject["animTrack"]:AdjustWeight(number.Value, 0)
			EasedEvent:Fire()
		end)

		stoppingtween = ts(number, tweenInfo, {Value = 0.000001})
		stoppingtween:Play()

		stoppingtween.Completed:Connect(function()
			number:Destroy()
			stoppingtween = nil
			easimationObject["animTrack"]:Stop(0)
			StopCompletedEvent:Fire()
		end)
	end

	function easimationObject:EaseWeight(finalWeight, tweenInfo)
		local weightForTween 

		if finalWeight > 1 then 
			weightForTween = 1 
		else
			weightForTween = finalWeight
		end

		local number = Instance.new("NumberValue")
		number.Value = easimationObject["animTrack"].WeightCurrent

		number:GetPropertyChangedSignal("Value"):Connect(function()
			easimationObject["animTrack"]:AdjustWeight(number.Value, 0)
			EasedEvent:Fire()
		end)

		local tween = ts(number, tweenInfo, {Value = weightForTween})
		tween:Play()
		WeightEaseStartedEvent:Fire()

		tween.Completed:Connect(function()
			number:Destroy()
			tween:Destroy()
			if easimationObject["animTrack"].WeightCurrent ~= finalWeight then
				easimationObject["animTrack"]:AdjustWeight(finalWeight, 0)
			end
			weightForTween = nil
			WeightEaseCompletedEvent:Fire()
		end)
	end

	function easimationObject:EaseSpeed(finalSpeed, tweenInfo)
		local speedForTween = finalSpeed

		local number = Instance.new("NumberValue")
		number.Value = easimationObject["animTrack"].Speed

		number:GetPropertyChangedSignal("Value"):Connect(function()
			easimationObject["animTrack"]:AdjustSpeed(number.Value)
			EasedEvent:Fire()
		end)

		local tween = ts(number, tweenInfo, {Value = speedForTween})
		tween:Play()
		SpeedEaseStartedEvent:Fire()

		tween.Completed:Connect(function()
			number:Destroy()
			tween:Destroy()
			if easimationObject["animTrack"].WeightCurrent ~= finalSpeed then
				easimationObject["animTrack"]:AdjustSpeed(finalSpeed, 0)
			end
			speedForTween = nil
			SpeedEaseCompletedEvent:Fire()
		end)
	end

	return easimationObject
end

return easimation
