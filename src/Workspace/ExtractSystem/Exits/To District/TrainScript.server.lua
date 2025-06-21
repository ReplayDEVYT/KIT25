local ts = require(game.ReplicatedStorage.TService)
local Train = script.Parent
local Model = Train:WaitForChild("TrainModel")
local Points = Train:WaitForChild("Points")
local pointA = Points.pointA.Value
local pointB = Points.pointB.Value
local pointC = Points.pointC.Value
local OneUse = false

function Run()
	print("Train is available")
	Train.Loop:Stop()
	Train.Config.CanExtract.Value = false
	--wait(math.random(25,35)*60)
	wait(15)
	print("Train is running")
	Train.Loop:Play()
	ts(Train,TweenInfo.new(37, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),{CFrame = pointA.CFrame}):Play()
	wait(10)
	Train.Horn:Play()
	wait(1)
	Train.Horn2:Play()
	wait(5)
	print("Train has arrived")
	Train.Stop:Play()
	Train.Loop:Stop()
	Train.Idle:Play()
	wait(23)
	for i,car in pairs(Model:GetChildren()) do
		if car.Name == "Passenger" then
			for i,m in pairs(car.Car.Doors:GetChildren()) do
				if m.Name == "L" then
					
			
			for i,f in pairs(m:GetChildren()) do
						if f:IsA("BasePart") then
							if f:FindFirstChildOfClass("Motor6D") then
								for i,x in pairs(f:GetChildren()) do
									if x:IsA("Motor6D") then
										if x.Name == "L" then
											ts(x,TweenInfo.new(5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),{C0 = x.C0 * CFrame.new(0,0,-2)}):Play()
										elseif x.Name == "R" then
											ts(x,TweenInfo.new(5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),{C0 = x.C0  * CFrame.new(0,0,-2)}):Play()
										end
									end
								end
							end
						end
					end
					end
				end
		end
		end
	Train.Doors:Play()
	print("Train doors opened")
	Train.Config.Requirements.Event.Value = "Wait for the train to leave"
	wait(math.random(3,4)*20)
	--wait(10)
	Train.Horn:Play()
	print("Transit train departure in 30 seconds")
	wait(30)
	--wait(10)
	print("Train is leaving")
	Train.Horn:Play()
	wait(1)
	Train.Horn2:Play()
	wait(5)
	for i,car in pairs(Model:GetChildren()) do
		if car.Name == "Passenger" then
			for i,m in pairs(car.Car.Doors:GetChildren()) do
				if m.Name == "L" then


					for i,f in pairs(m:GetChildren()) do
						if f:IsA("BasePart") then
							if f:FindFirstChildOfClass("Motor6D") then
								for i,x in pairs(f:GetChildren()) do
									if x:IsA("Motor6D") then
										if x.Name == "L" then
											ts(x,TweenInfo.new(3),{C0 = x.C0 * CFrame.new(0,0,2)}):Play()
										elseif x.Name == "R" then
											ts(x,TweenInfo.new(3),{C0 = x.C0  * CFrame.new(0,0,2)}):Play()
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
	Train.Doors:Play()
	Train.Config.Requirements.Event.Done.Value = true
	Train.Config.CanExtract.Value = true
	wait(2)
	Train.Start:Play()
	Train.Idle:Stop()
	wait(9)
	Train.Loop:Play()
	print("Train has departured")
	wait(0.5)
	ts(Train,TweenInfo.new(37, Enum.EasingStyle.Sine, Enum.EasingDirection.In),{CFrame = pointB.CFrame}):Play()
	wait(60)
	if OneUse == false then
		ts(Train,TweenInfo.new(0),{CFrame = pointC.CFrame}):Play()
		Run()
	end
end


Run()