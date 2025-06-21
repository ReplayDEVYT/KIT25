local ts = require(game.ReplicatedStorage.TService)
local module = {

--//Client Animations
		IdleAnim = function(char, speed, objs)
			ts(objs[2],TweenInfo.new(0.3),{C1 = require(script.Parent.Settings).RightPos}):Play() -- require(script).FakeRightPos (For fake arms) | require(script).RightArmPos (For real arms)
			ts(objs[3],TweenInfo.new(0.3),{C1 = require(script.Parent.Settings).LeftPos}):Play() -- require(script).FakeLeftPos (For fake arms) | require(script).LeftArmPos (For real arms)	
		end;
		
		StanceDown = function(char, speed, objs)
			ts(objs[2],TweenInfo.new(0.3),{C1 = require(script.Parent.Settings).RightPos}):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = require(script.Parent.Settings).LeftPos}):Play()
		end;

		StanceUp = function(char, speed, objs)
			ts(objs[2],TweenInfo.new(0.3),{C1 = require(script.Parent.Settings).RightPos}):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = require(script.Parent.Settings).LeftPos}):Play()
		end;
		
		Patrol = function(char, speed, objs)
			ts(objs[2],TweenInfo.new(0.3),{C1 = require(script.Parent.Settings).RightPos}):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = require(script.Parent.Settings).LeftPos}):Play()	
		end;

		SprintAnim = function(char, speed, objs)
			ts(objs[2],TweenInfo.new(0.3),{C1 = require(script.Parent.Settings).RightPos}):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = require(script.Parent.Settings).LeftPos}):Play()
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

		ZoomAnim = function(char, speed, objs)
			--ts(objs[2],TweenInfo.new(0),{C1 = CFrame.new(-.875, -0.2, -1.25) * CFrame.Angles(math.rad(-60), math.rad(0), math.rad(0))}):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(-0.65, -0.7, -1)*CFrame.Angles(math.rad(-180), 0, 0)*CFrame.Angles(0, 0, math.rad(30))}):Play()
			wait(0.3)
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(-0.25, -1.1, -1)*CFrame.Angles(math.rad(-180), 0, 0)*CFrame.Angles(0, 0, math.rad(5))}):Play()
			ts(objs[5].g33:WaitForChild("g33"),TweenInfo.new(0.3),{C1 = CFrame.new(-0.2, 0.21, 0)*CFrame.Angles(0, 0, math.rad(90))*CFrame.new(0.225, -0.75, 0)}):Play()
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

		ChamberAnim = function(char, speed, objs)
		ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(-.8, 0.3, -1.15) * CFrame.Angles(math.rad(-65), math.rad(0), math.rad(0))}):Play()
		ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(1.9,0.4,-0.9) * CFrame.Angles(math.rad(-50),math.rad(45),math.rad(-45))}):Play()
			wait(0.3)
		end;

		ChamberBKAnim = function(char, speed, objs)
		ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(-.8, 0.3, -1.15) * CFrame.Angles(math.rad(-65), math.rad(0), math.rad(0))}):Play()
		ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(1.9,0.4,-0.9) * CFrame.Angles(math.rad(-50),math.rad(45),math.rad(-45))}):Play()
			wait(0.3)
	end;
	
	ChamberCheckAnim = function(char, speed, objs)

	end;
		
		CheckAnim = function(char, speed, objs)
			
		end;
		
		ShellInsertAnim = function(char, speed, objs)
			
		end;
		
		ReloadAnim = function(char, speed, objs)
					ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(-.8, 0.3, -1.15) * CFrame.Angles(math.rad(-65), math.rad(0), math.rad(0))}):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(1.9,0.4,-0.9) * CFrame.Angles(math.rad(-50),math.rad(45),math.rad(-45))}):Play()
		script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("Reload"):Play()
		wait(3)	
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
			wait(1)
		end;
--//Server Animations
	RightHighReady = CFrame.new(-.815, 0.55, -1.1) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0));
	LeftHighReady = CFrame.new(.815,0.55,-1.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0));

	RightLowReady = CFrame.new(-.815, 0.55, -1.1) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0));
	LeftLowReady = CFrame.new(.815,0.55,-1.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0));

	RightPatrol = CFrame.new(-.815, 0.55, -1.1) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0));
	LeftPatrol = CFrame.new(.815,0.55,-1.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0));

	RightAim = CFrame.new(-.815, 0.55, -1.1) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0));
	LeftAim = CFrame.new(.815,0.55,-1.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0));
	
	RightSprint = CFrame.new(-.815, 0.55, -1.1) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0));
	LeftSprint = CFrame.new(.815,0.55,-1.15) * CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0));

	ShootPos = CFrame.new(0,0,.25);
	
}

return module
