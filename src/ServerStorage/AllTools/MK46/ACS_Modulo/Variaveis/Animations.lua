local ts = require(game.ReplicatedStorage.TService)
local module = {

--//Client Animations
		IdleAnim = function(char, speed, objs)
			ts(objs[2],TweenInfo.new(0.3),{C1 = require(script.Parent.Settings).RightPos}):Play() -- require(script).FakeRightPos (For fake arms) | require(script).RightArmPos (For real arms)
			ts(objs[3],TweenInfo.new(0.3),{C1 = require(script.Parent.Settings).LeftPos}):Play() -- require(script).FakeLeftPos (For fake arms) | require(script).LeftArmPos (For real arms)	
	end;
	
	FireAnim = function(char, speed, objs)

		ts(objs[5].CarryHandle:WaitForChild("CarryHandle"),TweenInfo.new(0.2),{C1 = CFrame.new(0.0,0.0,0.0) * CFrame.Angles(math.rad(math.random(-2,2)),math.rad(0),math.rad(math.random(-2,2)))}):Play()
		ts(objs[5].Bullet1:WaitForChild("Bullet1"),TweenInfo.new(0.1),{C1 = CFrame.new(0.05,0.05,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Link1:WaitForChild("Link1"),TweenInfo.new(0.1),{C1 = CFrame.new(0.05,0.05,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Bullet2:WaitForChild("Bullet2"),TweenInfo.new(0.1),{C1 = CFrame.new(0.05,0.05,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Link2:WaitForChild("Link2"),TweenInfo.new(0.1),{C1 = CFrame.new(0.05,0.05,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Bullet3:WaitForChild("Bullet3"),TweenInfo.new(0.1),{C1 = CFrame.new(0.05,0.05,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Link3:WaitForChild("Link3"),TweenInfo.new(0.1),{C1 = CFrame.new(0.05,0.05,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Bullet4:WaitForChild("Bullet4"),TweenInfo.new(0.1),{C1 = CFrame.new(0.05,0.05,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Link4:WaitForChild("Link4"),TweenInfo.new(0.1),{C1 = CFrame.new(0.05,0.05,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Bullet5:WaitForChild("Bullet5"),TweenInfo.new(0.1),{C1 = CFrame.new(0.05,0.05,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Link5:WaitForChild("Link5"),TweenInfo.new(0.1),{C1 = CFrame.new(0.05,0.05,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Bullet6:WaitForChild("Bullet6"),TweenInfo.new(0.1),{C1 = CFrame.new(0.05,0.05,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Link6:WaitForChild("Link6"),TweenInfo.new(0.1),{C1 = CFrame.new(0.05,0.05,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Bullet7:WaitForChild("Bullet7"),TweenInfo.new(0.1),{C1 = CFrame.new(0.05,0.05,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Link7:WaitForChild("Link7"),TweenInfo.new(0.1),{C1 = CFrame.new(0.05,0.05,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Bullet8:WaitForChild("Bullet8"),TweenInfo.new(0.1),{C1 = CFrame.new(0.05,0.05,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Link8:WaitForChild("Link8"),TweenInfo.new(0.1),{C1 = CFrame.new(0.05,0.05,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Bullet9:WaitForChild("Bullet9"),TweenInfo.new(0.1),{C1 = CFrame.new(0.05,0.05,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Link9:WaitForChild("Link9"),TweenInfo.new(0.1),{C1 = CFrame.new(0.05,0.05,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()

		wait(0.00001)

		ts(objs[5].CarryHandle:WaitForChild("CarryHandle"),TweenInfo.new(0.2),{C1 = CFrame.new(0.0,0.0,0.0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Bullet1:WaitForChild("Bullet1"),TweenInfo.new(0.1),{C1 = CFrame.new(0.0,0.0,0.0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Link1:WaitForChild("Link1"),TweenInfo.new(0.1),{C1 = CFrame.new(0.0,0.0,0.0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Bullet2:WaitForChild("Bullet2"),TweenInfo.new(0.1),{C1 = CFrame.new(0.0,0.0,0.0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Link2:WaitForChild("Link2"),TweenInfo.new(0.1),{C1 = CFrame.new(0.0,0.0,0.0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Bullet3:WaitForChild("Bullet3"),TweenInfo.new(0.1),{C1 = CFrame.new(0.0,0.0,0.0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Link3:WaitForChild("Link3"),TweenInfo.new(0.1),{C1 = CFrame.new(0.0,0.0,0.0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Bullet4:WaitForChild("Bullet4"),TweenInfo.new(0.1),{C1 = CFrame.new(0.0,0.0,0.0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Link4:WaitForChild("Link4"),TweenInfo.new(0.1),{C1 = CFrame.new(0.0,0.0,0.0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Bullet5:WaitForChild("Bullet5"),TweenInfo.new(0.1),{C1 = CFrame.new(0.0,0.0,0.0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Link5:WaitForChild("Link5"),TweenInfo.new(0.1),{C1 = CFrame.new(0.0,0.0,0.0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Bullet6:WaitForChild("Bullet6"),TweenInfo.new(0.1),{C1 = CFrame.new(0.0,0.0,0.0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Link6:WaitForChild("Link6"),TweenInfo.new(0.1),{C1 = CFrame.new(0.0,0.0,0.0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Bullet7:WaitForChild("Bullet7"),TweenInfo.new(0.1),{C1 = CFrame.new(0.0,0.0,0.0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Link7:WaitForChild("Link7"),TweenInfo.new(0.1),{C1 = CFrame.new(0.0,0.0,0.0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Bullet8:WaitForChild("Bullet8"),TweenInfo.new(0.1),{C1 = CFrame.new(0.0,0.0,0.0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Link8:WaitForChild("Link8"),TweenInfo.new(0.1),{C1 = CFrame.new(0.0,0.0,0.0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Bullet9:WaitForChild("Bullet9"),TweenInfo.new(0.1),{C1 = CFrame.new(0.0,0.0,0.0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Link9:WaitForChild("Link9"),TweenInfo.new(0.1),{C1 = CFrame.new(0.0,0.0,0.0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Bullet10:WaitForChild("Bullet10"),TweenInfo.new(0.1),{C1 = CFrame.new(0.0,0.0,0.0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Link10:WaitForChild("Link10"),TweenInfo.new(0.1),{C1 = CFrame.new(0.0,0.0,0.0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Bullet11:WaitForChild("Bullet11"),TweenInfo.new(0.1),{C1 = CFrame.new(0.0,0.0,0.0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Link11:WaitForChild("Link11"),TweenInfo.new(0.1),{C1 = CFrame.new(0.0,0.0,0.0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Bullet12:WaitForChild("Bullet12"),TweenInfo.new(0.1),{C1 = CFrame.new(0.0,0.0,0.0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		ts(objs[5].Link12:WaitForChild("Link12"),TweenInfo.new(0.1),{C1 = CFrame.new(0.0,0.0,0.0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()

		print(objs[7].Value)
		if objs[7].Value == 11 then
			objs[5].Bullet1.Transparency = 1
			objs[5].Link1.Transparency = 1
		elseif objs[7].Value  == 10 then
			objs[5].Bullet1.Transparency = 1
			objs[5].Link1.Transparency = 1
			objs[5].Bullet2.Transparency = 1
			objs[5].Link2.Transparency = 1
		elseif objs[7].Value  == 9 then
			objs[5].Bullet1.Transparency = 1
			objs[5].Link1.Transparency = 1
			objs[5].Bullet2.Transparency = 1
			objs[5].Link2.Transparency = 1	
			objs[5].Bullet3.Transparency = 1
			objs[5].Link3.Transparency = 1	
		elseif objs[7].Value  == 8 then
			objs[5].Bullet1.Transparency = 1
			objs[5].Link1.Transparency = 1
			objs[5].Bullet2.Transparency = 1
			objs[5].Link2.Transparency = 1	
			objs[5].Bullet3.Transparency = 1
			objs[5].Link3.Transparency = 1	
			objs[5].Bullet4.Transparency = 1
			objs[5].Link4.Transparency = 1		
		elseif objs[7].Value  == 7 then
			objs[5].Bullet1.Transparency = 1
			objs[5].Link1.Transparency = 1
			objs[5].Bullet2.Transparency = 1
			objs[5].Link2.Transparency = 1	
			objs[5].Bullet3.Transparency = 1
			objs[5].Link3.Transparency = 1	
			objs[5].Bullet4.Transparency = 1
			objs[5].Link4.Transparency = 1		
			objs[5].Bullet5.Transparency = 1
			objs[5].Link5.Transparency = 1		
		elseif objs[7].Value  == 6 then
			objs[5].Bullet1.Transparency = 1
			objs[5].Link1.Transparency = 1
			objs[5].Bullet2.Transparency = 1
			objs[5].Link2.Transparency = 1	
			objs[5].Bullet3.Transparency = 1
			objs[5].Link3.Transparency = 1	
			objs[5].Bullet4.Transparency = 1
			objs[5].Link4.Transparency = 1		
			objs[5].Bullet5.Transparency = 1
			objs[5].Link5.Transparency = 1
			objs[5].Bullet6.Transparency = 1
			objs[5].Link6.Transparency = 1	
		elseif objs[7].Value  == 5 then
			objs[5].Bullet1.Transparency = 1
			objs[5].Link1.Transparency = 1
			objs[5].Bullet2.Transparency = 1
			objs[5].Link2.Transparency = 1	
			objs[5].Bullet3.Transparency = 1
			objs[5].Link3.Transparency = 1	
			objs[5].Bullet4.Transparency = 1
			objs[5].Link4.Transparency = 1		
			objs[5].Bullet5.Transparency = 1
			objs[5].Link5.Transparency = 1
			objs[5].Bullet6.Transparency = 1
			objs[5].Link6.Transparency = 1
			objs[5].Bullet7.Transparency = 1
			objs[5].Link7.Transparency = 1	
		elseif objs[7].Value  == 4 then
			objs[5].Bullet1.Transparency = 1
			objs[5].Link1.Transparency = 1
			objs[5].Bullet2.Transparency = 1
			objs[5].Link2.Transparency = 1	
			objs[5].Bullet3.Transparency = 1
			objs[5].Link3.Transparency = 1	
			objs[5].Bullet4.Transparency = 1
			objs[5].Link4.Transparency = 1		
			objs[5].Bullet5.Transparency = 1
			objs[5].Link5.Transparency = 1
			objs[5].Bullet6.Transparency = 1
			objs[5].Link6.Transparency = 1
			objs[5].Bullet7.Transparency = 1
			objs[5].Link7.Transparency = 1	
			objs[5].Bullet8.Transparency = 1
			objs[5].Link8.Transparency = 1	
		elseif objs[7].Value  == 3 then
			objs[5].Bullet1.Transparency = 1
			objs[5].Link1.Transparency = 1
			objs[5].Bullet2.Transparency = 1
			objs[5].Link2.Transparency = 1	
			objs[5].Bullet3.Transparency = 1
			objs[5].Link3.Transparency = 1	
			objs[5].Bullet4.Transparency = 1
			objs[5].Link4.Transparency = 1		
			objs[5].Bullet5.Transparency = 1
			objs[5].Link5.Transparency = 1
			objs[5].Bullet6.Transparency = 1
			objs[5].Link6.Transparency = 1
			objs[5].Bullet7.Transparency = 1
			objs[5].Link7.Transparency = 1	
			objs[5].Bullet8.Transparency = 1
			objs[5].Link8.Transparency = 1	
			objs[5].Bullet9.Transparency = 1
			objs[5].Link9.Transparency = 1	
		elseif objs[7].Value  == 2 then
			objs[5].Bullet1.Transparency = 1
			objs[5].Link1.Transparency = 1
			objs[5].Bullet2.Transparency = 1
			objs[5].Link2.Transparency = 1	
			objs[5].Bullet3.Transparency = 1
			objs[5].Link3.Transparency = 1	
			objs[5].Bullet4.Transparency = 1
			objs[5].Link4.Transparency = 1		
			objs[5].Bullet5.Transparency = 1
			objs[5].Link5.Transparency = 1
			objs[5].Bullet6.Transparency = 1
			objs[5].Link6.Transparency = 1
			objs[5].Bullet7.Transparency = 1
			objs[5].Link7.Transparency = 1	
			objs[5].Bullet8.Transparency = 1
			objs[5].Link8.Transparency = 1	
			objs[5].Bullet9.Transparency = 1
			objs[5].Link9.Transparency = 1
			objs[5].Bullet10.Transparency = 1
			objs[5].Link10.Transparency = 1
			objs[5].Link9.Transparency = 1	
		elseif objs[7].Value  == 1 then
			objs[5].Bullet1.Transparency = 1
			objs[5].Link1.Transparency = 1
			objs[5].Bullet2.Transparency = 1
			objs[5].Link2.Transparency = 1	
			objs[5].Bullet3.Transparency = 1
			objs[5].Link3.Transparency = 1	
			objs[5].Bullet4.Transparency = 1
			objs[5].Link4.Transparency = 1		
			objs[5].Bullet5.Transparency = 1
			objs[5].Link5.Transparency = 1
			objs[5].Bullet6.Transparency = 1
			objs[5].Link6.Transparency = 1
			objs[5].Bullet7.Transparency = 1
			objs[5].Link7.Transparency = 1	
			objs[5].Bullet8.Transparency = 1
			objs[5].Link8.Transparency = 1	
			objs[5].Bullet9.Transparency = 1
			objs[5].Link9.Transparency = 1
			objs[5].Bullet10.Transparency = 1
			objs[5].Link10.Transparency = 1	
			objs[5].Bullet11.Transparency = 1
			objs[5].Link11.Transparency = 1	
		elseif objs[7].Value  == 0 then
			objs[5].Bullet1.Transparency = 1
			objs[5].Link1.Transparency = 1
			objs[5].Bullet2.Transparency = 1
			objs[5].Link2.Transparency = 1	
			objs[5].Bullet3.Transparency = 1
			objs[5].Link3.Transparency = 1	
			objs[5].Bullet4.Transparency = 1
			objs[5].Link4.Transparency = 1		
			objs[5].Bullet5.Transparency = 1
			objs[5].Link5.Transparency = 1
			objs[5].Bullet6.Transparency = 1
			objs[5].Link6.Transparency = 1
			objs[5].Bullet7.Transparency = 1
			objs[5].Link7.Transparency = 1	
			objs[5].Bullet8.Transparency = 1
			objs[5].Link8.Transparency = 1	
			objs[5].Bullet9.Transparency = 1
			objs[5].Link9.Transparency = 1
			objs[5].Bullet10.Transparency = 1
			objs[5].Link10.Transparency = 1	
			objs[5].Bullet11.Transparency = 1
			objs[5].Link11.Transparency = 1	
			objs[5].Bullet12.Transparency = 1
			objs[5].Link12.Transparency = 1												
		end

	end;
		
		StanceDown = function(char, speed, objs)
			ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(-.875, -0.2, -1.25) * CFrame.Angles(math.rad(-60), math.rad(0), math.rad(0))}):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(1.2,-0.05,-1.65) * CFrame.Angles(math.rad(-90),math.rad(35),math.rad(-25))}):Play()
			wait(0.3)	
		end;

		StanceUp = function(char, speed, objs)
			ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(-.875, -1.85, -1.25) * CFrame.Angles(math.rad(-160), math.rad(0), math.rad(0))}):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(.8,-0.6,-1.15) * CFrame.Angles(math.rad(-170),math.rad(60),math.rad(15))}):Play()
			wait(0.3)	
		end;
		
		Patrol = function(char, speed, objs)
			ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(-0.75, -.9, -1.6) * CFrame.Angles(math.rad(-80), math.rad(-70), math.rad(0))}):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(0.75,0.75,-1) * CFrame.Angles(math.rad(-90),math.rad(-45),math.rad(-25))}):Play()
			wait(0.3)	
		end;

	SprintAnim = function(char, speed, objs)
		ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(-0.75, -.9, -2.1) * CFrame.Angles(math.rad(-80), math.rad(-70), math.rad(0))}):Play()
		ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(0.75,0.75,-1) * CFrame.Angles(math.rad(-90),math.rad(-45),math.rad(-25))}):Play()
		wait(0.3)	
	end; 

		EquipAnim = function(char, speed, objs)
			ts(objs[2],TweenInfo.new(0),{C1 = CFrame.new(-.875, -0.2, -1.25) * CFrame.Angles(math.rad(-60), math.rad(0), math.rad(0))}):Play()
			ts(objs[3],TweenInfo.new(0),{C1 = CFrame.new(1.2,-0.05,-1.65) * CFrame.Angles(math.rad(-90),math.rad(35),math.rad(-25))}):Play()
			wait(0.1)
			objs[5].Handle:WaitForChild("AimUp"):Play()
			ts(objs[2],TweenInfo.new(0.5),{C1 = require(script.Parent.Settings).RightPos}):Play()
			ts(objs[3],TweenInfo.new(0.5),{C1 = require(script.Parent.Settings).LeftPos}):Play()
			wait(0.5)
		end;

	CheckWatch = function(char, speed, objs)
		ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(0.170, -0.74, -1)*CFrame.Angles(math.rad(-180), 0, 0)*CFrame.Angles(0, 0, math.rad(30))}):Play()
		objs[5].Handle:WaitForChild("AimUp"):Play()
		wait(2)
	end;
	ZoomAnim = function(char, speed, objs)
		ts(objs[3],TweenInfo.new(0.25),{C1 = require(script.Parent.Settings).LeftPos}):Play()
		ts(objs[2],TweenInfo.new(0.25),{C1 = require(script.Parent.Settings).RightPos * CFrame.new(0.1, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-10))}):Play()
		wait(0.25)
		ts(objs[3],TweenInfo.new(0.15),{C1 = require(script.Parent.Settings).LeftPos}):Play()
		ts(objs[2],TweenInfo.new(0.15),{C1 = require(script.Parent.Settings).RightPos}):Play() 
		wait(0.15)
		objs[5].ProjectorSight.SurfaceGui.ClippingFrame.Reticle.Image = "rbxassetid://3284997389"
		objs[5].Handle:WaitForChild("AimDown"):Play()
		wait(0.3)
	end;

	UnZoomAnim = function(char, speed, objs)
		ts(objs[3],TweenInfo.new(0.25),{C1 = require(script.Parent.Settings).LeftPos}):Play()
		ts(objs[2],TweenInfo.new(0.25),{C1 = require(script.Parent.Settings).RightPos * CFrame.new(0.1, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-10))}):Play()
		wait(0.25)
		ts(objs[3],TweenInfo.new(0.15),{C1 = require(script.Parent.Settings).LeftPos}):Play()
		ts(objs[2],TweenInfo.new(0.15),{C1 = require(script.Parent.Settings).RightPos}):Play() 
		wait(0.15)
		objs[5].ProjectorSight.SurfaceGui.ClippingFrame.Reticle.Image = "rbxassetid://3284996772"
		objs[5].Handle:WaitForChild("AimDown"):Play()
		wait(0.3)
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
	FiremodeAnim = function(char, speed, objs)
		ts(objs[3],TweenInfo.new(0.25),{C1 = require(script.Parent.Settings).LeftPos}):Play()
		ts(objs[2],TweenInfo.new(0.25),{C1 = require(script.Parent.Settings).RightPos * CFrame.new(0.1, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-10))}):Play()
		wait(0.25)
		ts(objs[3],TweenInfo.new(0.15),{C1 = require(script.Parent.Settings).LeftPos}):Play()
		ts(objs[2],TweenInfo.new(0.15),{C1 = require(script.Parent.Settings).RightPos}):Play() 
		wait(0.15)
	end;
	
	ChamberAnim = function(char, speed, objs)
		ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(-0.775, 0.05, -1.25) * CFrame.Angles(math.rad(-90), math.rad(-2), math.rad(2))}):Play()
		ts(objs[3],TweenInfo.new(0.35),{C1 = CFrame.new(-0.65,-1.35,-2.25) * CFrame.Angles(math.rad(-180),math.rad(15),math.rad(15))}):Play()
		wait(0.35)	
		script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("SlidePull"):Play()
		ts(objs[3],TweenInfo.new(0.25),{C1 = CFrame.new(-0.7,-1.35,-1.5) * CFrame.Angles(math.rad(-180),math.rad(15),math.rad(15))}):Play()
		ts(objs[5].Handle:WaitForChild("Bolt"),TweenInfo.new(0.25),{C0 = CFrame.new(objs[6].BoltExtend) * CFrame.Angles(0,math.rad(0),0)}):Play()
		ts(objs[5].Handle:WaitForChild("Slide"),TweenInfo.new(0.25),{C0 = CFrame.new(objs[6].SlideExtend) * CFrame.Angles(0,math.rad(0),0)}):Play()
		wait(0.3)
		script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("SlideRelease"):Play()
		ts(objs[5].Handle:WaitForChild("Bolt"),TweenInfo.new(0.1),{C0 = CFrame.new(0,0,0) * CFrame.Angles(0,math.rad(0),0)}):Play()
		ts(objs[5].Handle:WaitForChild("Slide"),TweenInfo.new(0.1),{C0 = CFrame.new(0,0,0) * CFrame.Angles(0,math.rad(0),0)}):Play()
	end;
	ChamberCheckAnim = function(char, speed, objs)
		ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(1.275, 0.365, -0.9) * CFrame.Angles(math.rad(-85), math.rad(10), math.rad(-90))}):Play()
		ts(objs[3],TweenInfo.new(0.35),{C1 = CFrame.new(-0.15,0.05,-1.2) * CFrame.Angles(math.rad(-120),math.rad(15),math.rad(15))}):Play()
		wait(0.35)	
		script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("SlidePull"):Play()
		ts(objs[3],TweenInfo.new(0.25),{C1 = CFrame.new(-0.15,-0.275,-1.175) * CFrame.Angles(math.rad(-120),math.rad(15),math.rad(15))}):Play()
		ts(objs[5].Handle:WaitForChild("Bolt"),TweenInfo.new(0.25),{C0 = CFrame.new(objs[6].BoltExtend) * CFrame.Angles(0,math.rad(0),0) - Vector3.new(0, 0, .25)}):Play()
		ts(objs[5].Handle:WaitForChild("Slide"),TweenInfo.new(0.25),{C0 = CFrame.new(objs[6].SlideExtend) * CFrame.Angles(0,math.rad(0),0) - Vector3.new(0, 0, .25)}):Play()
		wait(1)
		script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("SlideRelease"):Play()
		ts(objs[5].Handle:WaitForChild("Bolt"),TweenInfo.new(0.1),{C0 = CFrame.new(0,0,0) * CFrame.Angles(0,math.rad(0),0)}):Play()
		ts(objs[5].Handle:WaitForChild("Slide"),TweenInfo.new(0.1),{C0 = CFrame.new(0,0,0) * CFrame.Angles(0,math.rad(0),0)}):Play()
	end;
		ChamberBKAnim = function(char, speed, objs)
			ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(-0.875, -0.465, -1.15) * CFrame.Angles(math.rad(-95), math.rad(-2), math.rad(7.5))}):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(0.1,-0.15,-1.115) * CFrame.Angles(math.rad(-110),math.rad(25),math.rad(0))}):Play()
			wait(0.3)	
			objs[5].Bolt:WaitForChild("SlideRelease"):Play()
			ts(objs[3],TweenInfo.new(0.15),{C1 = CFrame.new(0.1,-0.15,-1.025) * CFrame.Angles(math.rad(-100),math.rad(30),math.rad(0))}):Play()
			ts(objs[5].Handle:WaitForChild("Bolt"),TweenInfo.new(0.1),{C0 = CFrame.new(0,0,0) * CFrame.Angles(0,math.rad(0),0)}):Play()
			ts(objs[5].Handle:WaitForChild("Slide"),TweenInfo.new(0.1),{C0 = CFrame.new(0,0,0) * CFrame.Angles(0,math.rad(0),0)}):Play()
			wait(0.15)
		end;
		
		CheckAnim = function(char, speed, objs)
			ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(-0.875, 0, -1.15) * CFrame.Angles(math.rad(-95), math.rad(-2), math.rad(7.5))}):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(0.3,0.155,-0.5) * CFrame.Angles(math.rad(-100),math.rad(50),math.rad(7.5))}):Play()	
		wait(0.3)
		script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("LidUp"):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(0.3,0.155,0.2) * CFrame.Angles(math.rad(-100),math.rad(50),math.rad(0))}):Play()
			wait(1.5)

			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(0.3,0.155,-0.5) * CFrame.Angles(math.rad(-100),math.rad(50),math.rad(7.5))}):Play()
		wait(0.3)
		script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("LidDown"):Play()
		end;
		
		ShellInsertAnim = function(char, speed, objs)
			ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(-0.975, -0.365, -1.2) * CFrame.Angles(math.rad(-115), math.rad(-2), math.rad(9))}):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(1.55,-0.4,-1.15) * CFrame.Angles(math.rad(-100),math.rad(70),math.rad(-41))}):Play()
			wait(0.3)
			objs[5].Handle:WaitForChild("ShellInsert"):Play()
			ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(-0.975, -0.365, -1.2) * CFrame.Angles(math.rad(-110), math.rad(-2), math.rad(9))}):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(-0.5,0.475,-1.6) * CFrame.Angles(math.rad(-100),math.rad(70),math.rad(-41))}):Play()
			objs[6].Value = objs[6].Value - 1
			objs[7].Value = objs[7].Value + 1
			wait(0.3)
		end;
		
		ReloadAnim = function(char, speed, objs)
		if objs[10]:FindFirstChild("WeldConstraint")~= nil then
			objs[10].WeldConstraint:Destroy()
		end

		objs[4].Part1 = objs[5].Handle

		ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(-0.875, 0, -1.15) * CFrame.Angles(math.rad(-95), math.rad(-2), math.rad(7.5))}):Play()
		ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(0.3,0.155,-0.5) * CFrame.Angles(math.rad(-100),math.rad(50),math.rad(7.5))}):Play()
		wait(0.3)

		script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("LidUp"):Play()
		ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(0.6,0.1,0.2) * CFrame.Angles(math.rad(-100),math.rad(50),math.rad(0))}):Play()
		ts(objs[5].Lid:WaitForChild("Lid"),TweenInfo.new(0.3),{C1 = CFrame.new(0,1,0.1) * CFrame.Angles(math.rad(-70),math.rad(0),math.rad(0))}):Play()
		wait(0.3)
		ts(objs[3],TweenInfo.new(0.6),{C1 = CFrame.new(-0.195,0.6,-1.5) * CFrame.Angles(math.rad(-100),math.rad(0),math.rad(0))}):Play()
		wait(0.3)
		objs[5].Mag.Transparency = 1
		script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("MagOut"):Play()
		ts(objs[2],TweenInfo.new(0.4),{C1 = CFrame.new(-0.875, 0, -1.15) * CFrame.Angles(math.rad(-95), math.rad(-10), math.rad(7.5))}):Play()
		ts(objs[3],TweenInfo.new(0.6),{C1 = CFrame.new(0,0,-1.5) * CFrame.Angles(math.rad(-100),math.rad(-30),math.rad(0))}):Play()
		wait(0.3)
		ts(objs[2],TweenInfo.new(0.4),{C1 = CFrame.new(-0.875, 0, -1.3) * CFrame.Angles(math.rad(-110), math.rad(-5), math.rad(7.5))}):Play()
		ts(objs[3],TweenInfo.new(0.6),{C1 = CFrame.new(0,0.5,-1.9) * CFrame.Angles(math.rad(-60),math.rad(-30),math.rad(0))}):Play()	
		wait(0.2)
		ts(objs[2],TweenInfo.new(0.4),{C1 = CFrame.new(-0.875, -0.2, -1.6) * CFrame.Angles(math.rad(-110), math.rad(-2), math.rad(7.5))}):Play()
		local MagC = objs[5]:WaitForChild("Mag"):clone()
		MagC.Parent = workspace.CurrentCamera
		MagC.Name = "MagC"
		MagC.Transparency = 0			

		local MagCW = Instance.new("Motor6D")
		MagCW.Part0 = MagC
		MagCW.Part1 = objs[3].Parent.Parent:WaitForChild("Left Arm")
		MagCW.Parent = MagC
		MagCW.C1 = MagC.CFrame:toObjectSpace(objs[3].Parent.Parent:WaitForChild("Left Arm").CFrame)
		ts(MagCW,TweenInfo.new(0),{C1 = CFrame.new(0.2, -0.7, -0.7) * CFrame.Angles(math.rad(-90), math.rad(180), math.rad(0))}):Play()
		wait(0.3)				
		ts(objs[2],TweenInfo.new(0.4),{C1 = CFrame.new(-0.875, 0, -1.15) * CFrame.Angles(math.rad(-95), math.rad(-2), math.rad(7.5))}):Play()
		ts(objs[3],TweenInfo.new(0.6),{C1 = CFrame.new(0,0.5,-1.9) * CFrame.Angles(math.rad(-60),math.rad(-30),math.rad(0))}):Play()
		wait(0.3)
		ts(objs[2],TweenInfo.new(0.4),{C1 = CFrame.new(-0.875, 0, -1.15) * CFrame.Angles(math.rad(-95), math.rad(-2), math.rad(10.5))}):Play()
		ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(0,0,-1.5) * CFrame.Angles(math.rad(-100),math.rad(-30),math.rad(0))}):Play()
		wait(0.2)
		ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(-0.5,0.475,-1.6) * CFrame.Angles(math.rad(-100),math.rad(3),math.rad(7.5))}):Play()
		ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(-0.875, 0, -1.15) * CFrame.Angles(math.rad(-95), math.rad(3), math.rad(7.5))}):Play()
		wait(0.3)
		objs[5].Mag.Transparency = 0	
		script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("MagIn"):Play()
		MagC:Destroy()
		ts(objs[3],TweenInfo.new(0.4),{C1 = CFrame.new(0,0.475,-0.5) * CFrame.Angles(math.rad(-100),math.rad(0),math.rad(7.5))}):Play()
		ts(objs[2],TweenInfo.new(0.2),{C1 = CFrame.new(-0.875, 0, -1.15) * CFrame.Angles(math.rad(-95), math.rad(-2), math.rad(7.5))}):Play()
		wait(0.2)
		ts(objs[2],TweenInfo.new(0.4),{C1 = CFrame.new(-0.875, 0, -1.25) * CFrame.Angles(math.rad(-95), math.rad(-12), math.rad(7.5))}):Play()
		ts(objs[3],TweenInfo.new(0.4),{C1 = CFrame.new(0.7,-0.2,-0.4) * CFrame.Angles(math.rad(-100),math.rad(50),math.rad(7.5))}):Play()
		wait(0.4)
		objs[5].Bullet1.Transparency = 0
		objs[5].Link1.Transparency = 0
		objs[5].Bullet2.Transparency = 0
		objs[5].Link2.Transparency = 0	
		objs[5].Bullet3.Transparency = 0
		objs[5].Link3.Transparency = 0	
		objs[5].Bullet4.Transparency = 0
		objs[5].Link4.Transparency = 0		
		objs[5].Bullet5.Transparency = 0
		objs[5].Link5.Transparency = 0
		objs[5].Bullet6.Transparency = 0
		objs[5].Link6.Transparency = 0
		objs[5].Bullet7.Transparency = 0
		objs[5].Link7.Transparency = 0	
		objs[5].Bullet8.Transparency = 0
		objs[5].Link8.Transparency = 0	
		objs[5].Bullet9.Transparency = 0
		objs[5].Link9.Transparency = 0
		objs[5].Bullet10.Transparency = 0
		objs[5].Link10.Transparency = 0	
		objs[5].Bullet11.Transparency = 0
		objs[5].Link11.Transparency = 0	
		objs[5].Bullet12.Transparency = 0
		objs[5].Link12.Transparency = 0	
		ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(-0.875, 0, -1.25) * CFrame.Angles(math.rad(-95), math.rad(-2), math.rad(7.5))}):Play()
		ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(0.6,0.1,0.2) * CFrame.Angles(math.rad(-100),math.rad(50),math.rad(0))}):Play()
		wait(0.3)
		script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("LidDown"):Play()
		ts(objs[5].Lid:WaitForChild("Lid"),TweenInfo.new(0.3),{C1 = CFrame.new(0,0,0) * CFrame.Angles(math.rad(-5),math.rad(0),math.rad(0))}):Play()
		ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(0.3,0.155,-0.5) * CFrame.Angles(math.rad(-100),math.rad(50),math.rad(7.5))}):Play()
		ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(-0.875, 0, -1.35) * CFrame.Angles(math.rad(-95), math.rad(-2), math.rad(7.5))}):Play()
		wait(0.3)
		ts(objs[3],TweenInfo.new(0.2),{C1 = CFrame.new(0.3,0.155,0) * CFrame.Angles(math.rad(-140),math.rad(50),math.rad(7.5))}):Play()
		ts(objs[2],TweenInfo.new(0.2),{C1 = CFrame.new(-0.875, 0, -1.15) * CFrame.Angles(math.rad(-95), math.rad(-2), math.rad(7.5))}):Play()
		wait(0.2)
		ts(objs[5].Lid:WaitForChild("Lid"),TweenInfo.new(0.1),{C1 = CFrame.new(0,0,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))}):Play()
		objs[5].Handle:WaitForChild("LidClick"):Play()
		ts(objs[3],TweenInfo.new(0.2),{C1 = CFrame.new(0.3,0.155,-0.3) * CFrame.Angles(math.rad(-90),math.rad(50),math.rad(7.5))}):Play()
		ts(objs[2],TweenInfo.new(0.2),{C1 = CFrame.new(-0.875, 0, -1.35) * CFrame.Angles(math.rad(-95), math.rad(-2), math.rad(7.5))}):Play()
		if (objs[6].Value - (objs[8].Ammo - objs[7].Value)) < 0 then
			objs[7].Value = objs[7].Value + objs[6].Value
			objs[6].Value = 0
			--Evt.Recarregar:FireServer(objs[5].Value)

		elseif objs[7].Value <= 0 then
			objs[6].Value = objs[6].Value - (objs[8].Ammo - objs[7].Value)
			--Evt.Recarregar:FireServer(objs[5].Value)
			objs[7].Value = objs[8].Ammo
			objs[9] = false

		elseif objs[7].Value > 0 and objs[9] and objs[8].IncludeChamberedBullet then
			objs[6].Value = objs[6].Value - (objs[8].Ammo - objs[7].Value) - 1
			--objs[10].Recarregar:FireServer(objs[6].Value)
			objs[7].Value = objs[8].Ammo + 1

		elseif objs[7].Value > 0 and objs[9] and not objs[8].IncludeChamberedBullet then
			objs[6].Value = objs[6].Value - (objs[8].Ammo - objs[7].Value)
			--Evt.Recarregar:FireServer(objs[5].Value)
			objs[7].Value = objs[8].Ammo
		end
		wait(0.55)
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
	
}

return module
