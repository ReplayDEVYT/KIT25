local ts = require(game.ReplicatedStorage.TService)
local player = game:GetService("Players").LocalPlayer
local module = {

--//Client Animations
	DoorAnim = function(char, speed, objs)
		ts(objs[2],TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut),{C1 = require(script.Parent.ContextSettings).RightPos}):Play() -- require(script).FakeRightPos (For fake arms) | require(script).RightArmPos (For real arms)
		ts(objs[3],TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut),{C1 = CFrame.new(0.35,0.1,-1.2) * CFrame.Angles(math.rad(-120),math.rad(15),math.rad(15))}):Play()
		wait(0.3)
		ts(objs[3],TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut),{C1 = CFrame.new(0.35,-0.1,-1.2) * CFrame.Angles(math.rad(-120),math.rad(15),math.rad(15))}):Play()
		wait(0.2)
	end;
	DoorAnim2 = function(char, speed, objs)

		ts(objs[2],TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut),{C1 = require(script.Parent.ContextSettings).RightPos}):Play() -- require(script).FakeRightPos (For fake arms) | require(script).RightArmPos (For real arms)
		ts(objs[3],TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut),{C1 = CFrame.new(1.195,1.4,-0.5) * CFrame.Angles(math.rad(0),math.rad(25),math.rad(0))}):Play()
		objs[5].Handle:WaitForChild("AimUp"):Play()
		wait(1)
		ts(objs[3],TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut),{C1 = CFrame.new(0.35,0.1,-1.2) * CFrame.Angles(math.rad(-120),math.rad(15),math.rad(15))}):Play()
		wait(0.3)
		ts(objs[3],TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut),{C1 = CFrame.new(0.35,0.1,-1.2) * CFrame.Angles(math.rad(-120),math.rad(15),math.rad(25))}):Play()
		objs[9]:FindFirstChild("knob").KeySound:Play()
		wait(0.75)
		ts(objs[3],TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut),{C1 = CFrame.new(1.195,1.4,-0.5) * CFrame.Angles(math.rad(0),math.rad(25),math.rad(0))}):Play()
		objs[5].Handle:WaitForChild("AimUp"):Play()
		wait(0.7)
		ts(objs[3],TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut),{C1 = CFrame.new(0.35,0.1,-1.2) * CFrame.Angles(math.rad(-120),math.rad(15),math.rad(15))}):Play()
		wait(0.3)
		ts(objs[3],TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut),{C1 = CFrame.new(0.35,-0.1,-1.2) * CFrame.Angles(math.rad(-120),math.rad(15),math.rad(25))}):Play()
		wait(0.2)
	end;
	DoorAnim3 = function(char, speed, objs)
		ts(objs[2],TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut),{C1 = CFrame.new(-0.75, -.9, -1.6) * CFrame.Angles(math.rad(-80), math.rad(-70), math.rad(0))}):Play()
		ts(objs[3],TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut),{C1 = CFrame.new(0.75,0.75,-1) * CFrame.Angles(math.rad(-90),math.rad(-45),math.rad(-25))}):Play()
		wait(.3)	
	end;
	DoorAnim4 = function(char, speed, objs)

		ts(objs[2],TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut),{C1 = require(script.Parent.ContextSettings).RightPos}):Play() -- require(script).FakeRightPos (For fake arms) | require(script).RightArmPos (For real arms)
		ts(objs[3],TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut),{C1 = CFrame.new(1.195,1.4,-0.5) * CFrame.Angles(math.rad(0),math.rad(25),math.rad(0))}):Play()
		objs[5].Handle:WaitForChild("AimUp"):Play()
		wait(1)
		ts(objs[3],TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut),{C1 = CFrame.new(0.35,0.1,-1.2) * CFrame.Angles(math.rad(-120),math.rad(15),math.rad(10))}):Play()
		wait(0.3)
		ts(objs[3],TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut),{C1 = CFrame.new(0.35,0,-1.2) * CFrame.Angles(math.rad(-120),math.rad(15),math.rad(70))}):Play()
		objs[9]:FindFirstChild("knob").KeySound:Play()
		wait(0.75)
		ts(objs[3],TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut),{C1 = CFrame.new(1.195,1.4,-0.5) * CFrame.Angles(math.rad(0),math.rad(25),math.rad(0))}):Play()
		objs[5].Handle:WaitForChild("AimUp"):Play()
		wait(0.7)
		ts(objs[3],TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut),{C1 = CFrame.new(0.35,0.1,-1.2) * CFrame.Angles(math.rad(-120),math.rad(15),math.rad(15))}):Play()
		wait(0.3)
		ts(objs[3],TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut),{C1 = CFrame.new(0.35,-0.1,-1.2) * CFrame.Angles(math.rad(-120),math.rad(15),math.rad(25))}):Play()
		wait(0.2)
	end;
	BreachAnim = function(char, speed, objs)
		ts(objs[2],TweenInfo.new(0.3),{C1 = require(script.Parent.ContextSettings).RightPos}):Play() -- require(script).FakeRightPos (For fake arms) | require(script).RightArmPos (For real arms)
		ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(0.35,0.1,-1.2) * CFrame.Angles(math.rad(-120),math.rad(15),math.rad(15))}):Play()
		wait(0.3)
		ts(objs[3],TweenInfo.new(0.2),{C1 = CFrame.new(0.35,.25,-1.2) * CFrame.Angles(math.rad(-120),math.rad(15),math.rad(15))}):Play()
		wait(0.2)
		ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(0.15,.25,-1) * CFrame.Angles(math.rad(-120),math.rad(15),math.rad(15))}):Play()
		wait(0.3)
	end;
	PointAnim = function(char, speed, objs)
		ts(objs[2],TweenInfo.new(0.3),{C1 = require(script.Parent.ContextSettings).RightPos}):Play() -- require(script).FakeRightPos (For fake arms) | require(script).RightArmPos (For real arms)
		ts(objs[3],TweenInfo.new(0.2),{C1 = CFrame.new(0.35,0.1,-1.2) * CFrame.Angles(math.rad(-120),math.rad(15),math.rad(15))}):Play()
		wait(0.3)
	end;
	NVGAnim = function(char, speed, objs)
		ts(objs[2],TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut),{C1 = require(script.Parent.ContextSettings).RightPos}):Play() -- require(script).FakeRightPos (For fake arms) | require(script).RightArmPos (For real arms)
		ts(objs[3],TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut),{C1 = CFrame.new(0.4, -0.75, -0.5)*CFrame.Angles(math.rad(-180), 0, 0)*CFrame.Angles(0, 0, math.rad(30))}):Play()
		objs[5].Handle:WaitForChild("AimUp"):Play()
		wait(0.3)
		ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(0, -1.25, -0.5)*CFrame.Angles(math.rad(-180), 0, 0)*CFrame.Angles(0, 0, math.rad(30))}):Play()
		wait(.3)
	end;
	NVGAnim2 = function(char, speed, objs)
		ts(objs[2],TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut),{C1 = require(script.Parent.ContextSettings).RightPos}):Play() -- require(script).FakeRightPos (For fake arms) | require(script).RightArmPos (For real arms)
		ts(objs[3],TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut),{C1 = CFrame.new(0, -1.25, -0.5)*CFrame.Angles(math.rad(-180), 0, 0)*CFrame.Angles(0, 0, math.rad(30))}):Play()
		objs[5].Handle:WaitForChild("AimUp"):Play()
		wait(0.3)
		ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(0.4, -0.75, -0.5)*CFrame.Angles(math.rad(-180), 0, 0)*CFrame.Angles(0, 0, math.rad(30))}):Play()
		wait(0.3)
	end;
	CheckWatch = function(char, speed, objs)
		ts(objs[2],TweenInfo.new(0.65, Enum.EasingStyle.Back, Enum.EasingDirection.InOut),{C1 = require(script.Parent.ContextSettings).RightPos}):Play() -- require(script).FakeRightPos (For fake arms) | require(script).RightArmPos (For real arms)
		ts(objs[3],TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.InOut),{C1 = CFrame.new(0.202,-0.744,-0.925) * CFrame.Angles(math.rad(178.928),math.rad(-29.089),math.rad(11.735))}):Play()
		objs[5].Handle:WaitForChild("AimUp"):Play()
		wait(2)
	end;
	InspectAnim = function(char, speed, objs)
		objs[5].Handle:WaitForChild("inspect1"):Play()
		ts(objs[3],TweenInfo.new(1),{C1 = CFrame.new(0.805950999, 0.654529691, -1.92835355, 0.999723792, 0.0109803826, 0.0207702816, -0.0223077796, 0.721017241, 0.692557871, -0.00737112388, -0.692829967, 0.721063137)}):Play()
		ts(objs[2],TweenInfo.new(1),{C1 = CFrame.new(-1.49363565, -0.699174881, -1.32277012, 0.66716975, -8.8829113e-09, -0.74490571, 0.651565909, -0.484672248, 0.5835706, -0.361035138, -0.874695837, -0.323358655)}):Play()
		wait(5)
		objs[5].Handle:WaitForChild("inspect2"):Play()
		ts(objs[2],TweenInfo.new(1),{C1 = CFrame.new(1.37424219, -0.699174881, -1.03685927, -0.204235911, 0.62879771, 0.750267386, 0.65156585, -0.484672219, 0.58357054, 0.730581641, 0.60803473, -0.310715646)}):Play()
		wait(5)
	end;
	AttachAnim = function(char, speed, objs)
		objs[5].Handle:WaitForChild("inspect1"):Play()
		ts(objs[3],TweenInfo.new(1),{C1 = CFrame.new(0.805950999, 0.654529691, -1.92835355, 0.999723792, 0.0109803826, 0.0207702816, -0.0223077796, 0.721017241, 0.692557871, -0.00737112388, -0.692829967, 0.721063137)}):Play()
		ts(objs[2],TweenInfo.new(1),{C1 = CFrame.new(-1.49363565, -0.699174881, -1.32277012, 0.66716975, -8.8829113e-09, -0.74490571, 0.651565909, -0.484672248, 0.5835706, -0.361035138, -0.874695837, -0.323358655)}):Play()
	end;
	UnequipAnim = function(char, speed, objs)
		ts(objs[2],TweenInfo.new(0.5),{C1 = CFrame.new(-0.75, -.9, -1.6) * CFrame.Angles(math.rad(-80), math.rad(-70), math.rad(0))}):Play()
		ts(objs[3],TweenInfo.new(0.5),{C1 = CFrame.new(0.75,0.75,-1) * CFrame.Angles(math.rad(-90),math.rad(-45),math.rad(-25))}):Play()
		wait(0.5)	
	end;
	ProneDownAnim = function(char, speed, objs)
		ts(objs[3],TweenInfo.new(0.45),{C1 = CFrame.new(0.805950999, 0.654529691, -1.92835355, 0.999723792, 0.0109803826, 0.0207702816, -0.0223077796, 0.721017241, 0.692557871, -0.00737112388, -0.692829967, 0.721063137)}):Play()
		ts(objs[2],TweenInfo.new(0.5),{C1 = require(script.Parent.ContextSettings).RightPos}):Play()
		wait(0.5)
		ts(objs[2],TweenInfo.new(0.3),{C1 = objs[6].RightPos}):Play()
		ts(objs[3],TweenInfo.new(0.3),{C1 = objs[6].LeftPos}):Play()
		wait(0.2)
	end;
	ProneUpAnim = function(char, speed, objs)
		ts(objs[3],TweenInfo.new(0.45),{C1 = CFrame.new(0.805950999, 0.654529691, -1.92835355, 0.999723792, 0.0109803826, 0.0207702816, -0.0223077796, 0.721017241, 0.692557871, -0.00737112388, -0.692829967, 0.721063137)}):Play()
		ts(objs[2],TweenInfo.new(0.5),{C1 = require(script.Parent.ContextSettings).RightPos}):Play()
		wait(0.45)
		ts(objs[2],TweenInfo.new(0.3),{C1 = objs[6].RightPos}):Play()
		ts(objs[3],TweenInfo.new(0.3),{C1 = objs[6].LeftPos}):Play()
		wait(0.2)
	end;
	
	BlindFireRight = function(char, speed, objs)
		ts(objs[2],TweenInfo.new(0.4,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut),{C1 = objs[6].RightPos * CFrame.new(-1, -.1, 0) * CFrame.Angles(math.rad(0), math.rad(-57), math.rad(2))}):Play() -- require(script).FakeRightPos (For fake arms) | require(script).RightArmPos (For real arms)
		ts(objs[3],TweenInfo.new(0.4,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut),{C1 = objs[6].LeftPos * CFrame.new(-1, -.1, 0) * CFrame.Angles(math.rad(0), math.rad(-57), math.rad(2))}):Play() -- require(script).FakeLeftPos (For fake arms) | require(script).LeftArmPos (For real arms)	
	end;
	BlindFireOver = function(char, speed, objs)
		ts(objs[2],TweenInfo.new(0.4,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut),{C1 = objs[6].RightPos * CFrame.new(-1.175, -.4, 0) * CFrame.Angles(math.rad(0), math.rad(-18), math.rad(-57))}):Play() -- require(script).FakeRightPos (For fake arms) | require(script).RightArmPos (For real arms)
		ts(objs[3],TweenInfo.new(0.4,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut),{C1 = objs[6].LeftPos * CFrame.new(-1.175, -.4, 0) * CFrame.Angles(math.rad(0), math.rad(-18), math.rad(-57))}):Play() -- require(script).FakeLeftPos (For fake arms) | require(script).LeftArmPos (For real arms)	
		wait(0.1)
		ts(objs[2],TweenInfo.new(0.4,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{C1 = objs[6].RightPos * CFrame.new(-1.175, -.4, 0) * CFrame.Angles(math.rad(0), math.rad(-20), math.rad(-59))}):Play() -- require(script).FakeRightPos (For fake arms) | require(script).RightArmPos (For real arms)
		ts(objs[3],TweenInfo.new(0.4,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{C1 = objs[6].LeftPos * CFrame.new(-1.175, -.4, 0) * CFrame.Angles(math.rad(0), math.rad(-20), math.rad(-59))}):Play() -- require(script).FakeLeftPos (For fake arms) | require(script).LeftArmPos (For real arms)	
	end;
	LeftHandShoulder = function(char, speed, objs)
		ts(objs[2],TweenInfo.new(0.4,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut),{C1 = objs[6].RightPos * CFrame.new(1, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-10))}):Play() -- require(script).FakeRightPos (For fake arms) | require(script).RightArmPos (For real arms)
		ts(objs[3],TweenInfo.new(0.4,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut),{C1 = objs[6].LeftPos * CFrame.new(1, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-10))}):Play() -- require(script).FakeLeftPos (For fake arms) | require(script).LeftArmPos (For real arms)	
	end;
	Inventory = function(char, speed, objs)
		ts(objs[2],TweenInfo.new(0.65, Enum.EasingStyle.Back, Enum.EasingDirection.InOut),{C1 = require(script.Parent.ContextSettings).RightPos}):Play() -- require(script).FakeRightPos (For fake arms) | require(script).RightArmPos (For real arms)
		ts(objs[3],TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.InOut),{C1 = CFrame.new(0.75,0.75,-1) * CFrame.Angles(math.rad(-90),math.rad(-45),math.rad(-25))}):Play() -- require(script).FakeLeftPos (For fake arms) | require(script).LeftArmPos (For real arms)	
	end;

--//Server Animations
	RightHighReady = CFrame.new(-1, -1, -1.5) * CFrame.Angles(math.rad(-160), math.rad(0), math.rad(0));
	LeftHighReady = CFrame.new(.85,-0.35,-1.15) * CFrame.Angles(math.rad(-170),math.rad(60),math.rad(15));

	RightLowReady = CFrame.new(-1, 0.5, -1.25) * CFrame.Angles(math.rad(-60), math.rad(0), math.rad(0));
	LeftLowReady = CFrame.new(1.25,1.15,-1.35) * CFrame.Angles(math.rad(-60),math.rad(35),math.rad(-25));

	RightPatrol = CFrame.new(-1, -.35, -1.5) * CFrame.Angles(math.rad(-80), math.rad(-80), math.rad(0));
	LeftPatrol = CFrame.new(1,1.25,-.75) * CFrame.Angles(math.rad(-90),math.rad(-45),math.rad(-25));

	RightAim = CFrame.new(-.575, 0.1, -1) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0));
	LeftAim = CFrame.new(1.4,0.25,-1.45) * CFrame.Angles(math.rad(-120),math.rad(35),math.rad(-25));
	
	RightSprint = CFrame.new(-1, 0.5, -1.25) * CFrame.Angles(math.rad(-60), math.rad(0), math.rad(0));
	LeftSprint = CFrame.new(1.25,1.15,-1.35) * CFrame.Angles(math.rad(-60),math.rad(35),math.rad(-25));

	ShootPos = CFrame.new(0,0,.25);
	
	--//BEGINNING OF SERVER SIDE RELOAD

	RightReloadState1 = CFrame.new(-0.875, 0.5, -1.15) * CFrame.Angles(math.rad(-95), math.rad(-2), math.rad(7.5));
	LeftReloadState1 = CFrame.new(1.195,1.4,-0.5) * CFrame.Angles(math.rad(0),math.rad(25),math.rad(0));

	RightReloadState2 = CFrame.new(-0.875, 0.5, -1.35) * CFrame.Angles(math.rad(-100), math.rad(-2), math.rad(7.5));

	RightReloadState3 = CFrame.new(-0.875, 0.5, -1.15) * CFrame.Angles(math.rad(-95), math.rad(-2), math.rad(7.5));
	LeftReloadState3 = CFrame.new(-0.5,0.475,-1.6) * CFrame.Angles(math.rad(-100),math.rad(0),math.rad(7.5));

	RightReloadState4 = CFrame.new(-0.875, 0.5, -1.125) * CFrame.Angles(math.rad(-95), math.rad(-2), math.rad(7.5));

	--//END OF SERVER SIDE RELOAD

	--//BEGINNING OF SERVER SIDE CHAMBERING	

	RightChamberState1 = CFrame.new(-0.975, 0.165, -1.5) * CFrame.Angles(math.rad(-115), math.rad(-10), math.rad(10));
	LeftChamberState1 = CFrame.new(-0.15,0.05,-1.2) * CFrame.Angles(math.rad(-120),math.rad(15),math.rad(15));												

	LeftChamberState2 = CFrame.new(-0.15,-0.275,-1.175) * CFrame.Angles(math.rad(-120),math.rad(15),math.rad(15));


	--//END OF SERVER SIDE CHAMBERING
	
	LeftWave = CFrame.new(0.170, -0.74, -1)*CFrame.Angles(math.rad(-180), 0, 0)*CFrame.Angles(0, 0, math.rad(30));
	RightWave = CFrame.new(-0.85, -0.2, -1.2) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0));
	
	BOver = CFrame.new(-1.175, -.4, 0) * CFrame.Angles(math.rad(0), math.rad(-18), math.rad(-67));
	BRight = CFrame.new(-1, -.1, 0) * CFrame.Angles(math.rad(0), math.rad(-67), math.rad(2));
	BLeft = CFrame.new(1, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-10))
	
}

return module
