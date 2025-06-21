local ts = require(game.ReplicatedStorage.TService)
local module = {

--//Client Animations
		IdleAnim = function(char, speed, objs)
			ts(objs[2],TweenInfo.new(0.3),{C1 = require(script.Parent.Settings).RightPos}):Play() -- require(script).FakeRightPos (For fake arms) | require(script).RightArmPos (For real arms)
			ts(objs[3],TweenInfo.new(0.3),{C1 = require(script.Parent.Settings).LeftPos}):Play() -- require(script).FakeLeftPos (For fake arms) | require(script).LeftArmPos (For real arms)	
	end;
	
	AimAnim = function(char, speed, objs)
		if objs[9] == 1 then
			ts(objs[5]:WaitForChild("Fade"),TweenInfo.new(0.3),{Transparency = 1}):Play()
			objs[5].Scope2.Transparency = 0
			objs[5].Scope1.Transparency = 1
			objs[5].Sight1.Transparency = 1
			--objs[5].Sight2.Transparency = 0
		else
			ts(objs[5]:WaitForChild("Fade"),TweenInfo.new(0.3),{Transparency = 0}):Play()
			objs[5].Scope2.Transparency = 1
			objs[5].Scope1.Transparency = 0
			objs[5].Sight1.Transparency = 0
		end

	end;
	UnAimAnim = function(char, speed, objs)
		ts(objs[5]:WaitForChild("Fade"),TweenInfo.new(0.3),{Transparency = 0}):Play()
		objs[5].Scope2.Transparency = 1
		objs[5].Scope1.Transparency = 0
		objs[5].Sight1.Transparency = 0
		--objs[5].Sight2.Transparency = 0


	end;
		
		StanceDown = function(char, speed, objs)
		ts(objs[2],TweenInfo.new(0.3),{C1 = require(script.Parent.Settings).RightPos}):Play() -- require(script).FakeRightPos (For fake arms) | require(script).RightArmPos (For real arms)
		ts(objs[3],TweenInfo.new(0.3),{C1 = require(script.Parent.Settings).LeftPos}):Play() -- require(script).FakeLeftPos (For fake arms) | require(script).LeftArmPos (For real arms)	
	end;

		StanceUp = function(char, speed, objs)
		ts(objs[2],TweenInfo.new(0.3),{C1 = require(script.Parent.Settings).RightPos}):Play() -- require(script).FakeRightPos (For fake arms) | require(script).RightArmPos (For real arms)
		ts(objs[3],TweenInfo.new(0.3),{C1 = require(script.Parent.Settings).LeftPos}):Play() -- require(script).FakeLeftPos (For fake arms) | require(script).LeftArmPos (For real arms)	
	end;
		
		Patrol = function(char, speed, objs)
		ts(objs[2],TweenInfo.new(0.3),{C1 = require(script.Parent.Settings).RightPos}):Play() -- require(script).FakeRightPos (For fake arms) | require(script).RightArmPos (For real arms)
		ts(objs[3],TweenInfo.new(0.3),{C1 = require(script.Parent.Settings).LeftPos}):Play() -- require(script).FakeLeftPos (For fake arms) | require(script).LeftArmPos (For real arms)	
	end;

		SprintAnim = function(char, speed, objs)
		ts(objs[2],TweenInfo.new(0.3),{C1 = require(script.Parent.Settings).RightPos}):Play() -- require(script).FakeRightPos (For fake arms) | require(script).RightArmPos (For real arms)
		ts(objs[3],TweenInfo.new(0.3),{C1 = require(script.Parent.Settings).LeftPos}):Play() -- require(script).FakeLeftPos (For fake arms) | require(script).LeftArmPos (For real arms)	
	end;

		EquipAnim = function(char, speed, objs)
			objs[5].Handle:WaitForChild("AimUp"):Play()
			ts(objs[2],TweenInfo.new(0),{C1 = require(script.Parent.Settings).RightPos}):Play()
			ts(objs[3],TweenInfo.new(0),{C1 = require(script.Parent.Settings).LeftPos}):Play()
		end;

		ZoomAnim = function(char, speed, objs)
			--ts(objs[2],TweenInfo.new(0),{C1 = CFrame.new(-.875, -0.2, -1.25) * CFrame.Angles(math.rad(-60), math.rad(0), math.rad(0))}):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(-0.65, -0.7, -1)*CFrame.Angles(math.rad(-180), 0, 0)*CFrame.Angles(0, 0, math.rad(30))}):Play()
			wait(0.3)
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(-0.25, -1.1, -1)*CFrame.Angles(math.rad(-180), 0, 0)*CFrame.Angles(0, 0, math.rad(5))}):Play()
			ts(objs[5].g33:WaitForChild("g33"),TweenInfo.new(0.3),{C1 = CFrame.new(-0.2, 0.21, 0)*CFrame.Angles(0, 0, math.rad(90))*CFrame.new(0.15, -0.77, 0)}):Play()
			wait(0.3)
		end;

		UnZoomAnim = function(char, speed, objs)
			--ts(objs[2],TweenInfo.new(0),{C1 = CFrame.new(-.875, -0.2, -1.25) * CFrame.Angles(math.rad(-60), math.rad(0), math.rad(0))}):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(-0.25, -1.1, -1)*CFrame.Angles(math.rad(-180), 0, 0)*CFrame.Angles(0, 0, math.rad(5))}):Play()
			wait(0.3)
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(-0.65, -0.7, -1)*CFrame.Angles(math.rad(-180), 0, 0)*CFrame.Angles(0, 0, math.rad(30))}):Play()
			ts(objs[5].g33:WaitForChild("g33"),TweenInfo.new(0.3),{C1 = CFrame.new()}):Play()
			wait(0.3)
		end;
	FireAnim = function(char, speed, objs)

		ts(objs[5].CarryHandle:WaitForChild("CarryHandle"),TweenInfo.new(0.2),{C1 = CFrame.new(0.0,0.0,0.0) * CFrame.Angles(math.rad(math.random(-2,2)),math.rad(0),math.rad(math.random(-2,2)))}):Play()
		ts(objs[5].Bullet1:WaitForChild("Bullet1"),TweenInfo.new(0.1),{C1 = CFrame.new(0.05,0.05,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Bullet2:WaitForChild("Bullet2"),TweenInfo.new(0.1),{C1 = CFrame.new(0.05,0.05,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Bullet3:WaitForChild("Bullet3"),TweenInfo.new(0.1),{C1 = CFrame.new(0.05,0.05,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Bullet4:WaitForChild("Bullet4"),TweenInfo.new(0.1),{C1 = CFrame.new(0.05,0.05,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Bullet5:WaitForChild("Bullet5"),TweenInfo.new(0.1),{C1 = CFrame.new(0.05,0.05,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Bullet6:WaitForChild("Bullet6"),TweenInfo.new(0.1),{C1 = CFrame.new(0.05,0.05,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Bullet7:WaitForChild("Bullet7"),TweenInfo.new(0.1),{C1 = CFrame.new(0.05,0.05,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()

		wait(0.00001)

		ts(objs[5].CarryHandle:WaitForChild("CarryHandle"),TweenInfo.new(0.2),{C1 = CFrame.new(0.0,0.0,0.0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Bullet1:WaitForChild("Bullet1"),TweenInfo.new(0.1),{C1 = CFrame.new(0.0,0.0,0.0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Bullet2:WaitForChild("Bullet2"),TweenInfo.new(0.1),{C1 = CFrame.new(0.0,0.0,0.0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Bullet3:WaitForChild("Bullet3"),TweenInfo.new(0.1),{C1 = CFrame.new(0.0,0.0,0.0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Bullet4:WaitForChild("Bullet4"),TweenInfo.new(0.1),{C1 = CFrame.new(0.0,0.0,0.0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Bullet5:WaitForChild("Bullet5"),TweenInfo.new(0.1),{C1 = CFrame.new(0.0,0.0,0.0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Bullet6:WaitForChild("Bullet6"),TweenInfo.new(0.1),{C1 = CFrame.new(0.0,0.0,0.0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Bullet7:WaitForChild("Bullet7"),TweenInfo.new(0.1),{C1 = CFrame.new(0.0,0.0,0.0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()

		print(objs[7].Value)

	end;
		ChamberAnim = function(char, speed, objs)
		ts(objs[2],TweenInfo.new(0.3),{C1 = require(script.Parent.Settings).RightPos}):Play() -- require(script).FakeRightPos (For fake arms) | require(script).RightArmPos (For real arms)
		ts(objs[3],TweenInfo.new(0.3),{C1 = require(script.Parent.Settings).LeftPos}):Play() -- require(script).FakeLeftPos (For fake arms) | require(script).LeftArmPos (For real arms)	
	end;
	
	InspectAnim = function(char, speed, objs)
		ts(objs[2],TweenInfo.new(0.3),{C1 = require(script.Parent.Settings).RightPos}):Play() -- require(script).FakeRightPos (For fake arms) | require(script).RightArmPos (For real arms)
		ts(objs[3],TweenInfo.new(0.3),{C1 = require(script.Parent.Settings).LeftPos}):Play() -- require(script).FakeLeftPos (For fake arms) | require(script).LeftArmPos (For real arms)	
	end;

		ChamberBKAnim = function(char, speed, objs)
			ts(objs[2],TweenInfo.new(0.3),{C1 = require(script.Parent.Settings).RightPos}):Play() -- require(script).FakeRightPos (For fake arms) | require(script).RightArmPos (For real arms)
			ts(objs[3],TweenInfo.new(0.3),{C1 = require(script.Parent.Settings).LeftPos}):Play() -- require(script).FakeLeftPos (For fake arms) | require(script).LeftArmPos (For real arms)	
	end;
		CheckAnim = function(char, speed, objs)
		ts(objs[2],TweenInfo.new(0.3),{C1 = require(script.Parent.Settings).RightPos}):Play() -- require(script).FakeRightPos (For fake arms) | require(script).RightArmPos (For real arms)
		ts(objs[3],TweenInfo.new(0.3),{C1 = require(script.Parent.Settings).LeftPos}):Play() -- require(script).FakeLeftPos (For fake arms) | require(script).LeftArmPos (For real arms)	
		end;
		
		ShellInsertAnim = function(char, speed, objs)
			ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(-0.975, -0.365, -1.2) * CFrame.Angles(math.rad(-115), math.rad(-2), math.rad(9))}):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(1.55,-0.4,-1.15) * CFrame.Angles(math.rad(-100),math.rad(70),math.rad(-41))}):Play()
			wait(0.3)
			objs[5].Handle:WaitForChild("ShellInsert"):Play()
			ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(-0.975, -0.365, -1.2) * CFrame.Angles(math.rad(-110), math.rad(-2), math.rad(9))}):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(1.6,-0.3,-1.1) * CFrame.Angles(math.rad(-100),math.rad(70),math.rad(-41))}):Play()
			objs[6].Value = objs[6].Value - 1
			objs[7].Value = objs[7].Value + 1
			wait(0.3)
		end;
		
		ReloadAnim = function(char, speed, objs)
		ts(objs[2],TweenInfo.new(0.3),{C1 = require(script.Parent.Settings).RightPos}):Play() -- require(script).FakeRightPos (For fake arms) | require(script).RightArmPos (For real arms)
		ts(objs[3],TweenInfo.new(0.3),{C1 = require(script.Parent.Settings).LeftPos}):Play() -- require(script).FakeLeftPos (For fake arms) | require(script).LeftArmPos (For real arms)	
		end;
--//Server Animations
	RightHighReady = CFrame.new(-.815, 0.15, -1.1) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0));
	LeftHighReady = CFrame.new(.815,0.15,-1.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0));
	
	RightLowReady =CFrame.new(-.815, 0.15, -1.1) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0));
	LeftLowReady = CFrame.new(.815,0.15,-1.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0));
	
	RightPatrol = CFrame.new(-.815, 0.15, -1.1) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0));
	LeftPatrol = CFrame.new(.815,0.15,-1.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0));

	RightAim = CFrame.new(-.815, 0.15, -1.1) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0));
	LeftAim = CFrame.new(.815,0.15,-1.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0));
	
	RightSprint = CFrame.new(-.815, 0.15, -1.1) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0));
	LeftSprint = CFrame.new(.815,0.15,-1.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0));

	ShootPos = CFrame.new(0,0,.15);
	
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
	
}

return module
