local ts = require(game.ReplicatedStorage.TService)
first = true
local module = {

--//Client Animations
		IdleAnim = function(char, speed, objs)
			ts(objs[2],TweenInfo.new(0.3),{C1 = require(script.Parent.Settings).RightPos}):Play() -- require(script).FakeRightPos (For fake arms) | require(script).RightArmPos (For real arms)
			ts(objs[3],TweenInfo.new(0.3),{C1 = require(script.Parent.Settings).LeftPos}):Play() -- require(script).FakeLeftPos (For fake arms) | require(script).LeftArmPos (For real arms)	
		end;
		
	StanceDown = function(char, speed, objs)
		ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(-0.4, 0.3, -1.05) * CFrame.Angles(math.rad(-70), math.rad(-10), math.rad(-15))}):Play()
		ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(1.2, 0.65, -1.25) * CFrame.Angles(math.rad(-90), math.rad(25), math.rad(-25))}):Play()
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
			ts(objs[2],TweenInfo.new(0.77),{C1 = require(script.Parent.Settings).RightPos}):Play()
			ts(objs[3],TweenInfo.new(0.77),{C1 = require(script.Parent.Settings).LeftPos}):Play()
			wait(0.5)
		end;
	AimAnim = function(char, speed, objs)
		if objs[9] == 1 then
		ts(objs[5]:WaitForChild("Fade"),TweenInfo.new(0.3),{Transparency = 1}):Play()
		objs[5].Scope1.Transparency = 1
		objs[5].ScopeMount.Transparency = 1
			----objs[5].Lens.Transparency = 1
			------objs[5].Lens2.Transparency = .45
		else
			ts(objs[5]:WaitForChild("Fade"),TweenInfo.new(0.3),{Transparency = 1}):Play()
			objs[5].Scope1.Transparency = 1
			objs[5].ScopeMount.Transparency = 1
			----objs[5].Lens.Transparency = .5
			------objs[5].Lens2.Transparency = 1
		end
	end;
	UnAimAnim = function(char, speed, objs)
		ts(objs[5]:WaitForChild("Fade"),TweenInfo.new(0.3),{Transparency = 0}):Play()
		objs[5].Scope1.Transparency = 0
		objs[5].ScopeMount.Transparency = 0 
		----objs[5].Lens.Transparency = 1
		------objs[5].Lens2.Transparency = 1
	end;
	ZoomAnim = function(char, speed, objs)
		ts(objs[3],TweenInfo.new(0.25),{C1 = require(script.Parent.Settings).LeftPos}):Play()
		script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("FlashOn"):Play()
		objs[5].Switch1.Transparency = 1
		objs[5].Switch2.Transparency = 0
		objs[5].Reticle.SurfaceGui.ClippingFrame.Reticle.Image = "rbxassetid://7053247153"
		ts(objs[2],TweenInfo.new(0.20),{C1 = CFrame.new(-.65, -0.2, -1) * CFrame.Angles(math.rad(-89), math.rad(-1), math.rad(-1))}):Play()
		ts(objs[3],TweenInfo.new(0.20),{C1 = CFrame.new(1.205,0.11,-1.605) * CFrame.Angles(math.rad(-119),math.rad(34),math.rad(-21))}):Play()
		wait(0.20)
		ts(objs[2],TweenInfo.new(0.20),{C1 = CFrame.new(-.65, -0.2, -1) * CFrame.Angles(math.rad(-90.5), math.rad(0.5), math.rad(0.5))}):Play()
		ts(objs[3],TweenInfo.new(0.20),{C1 = CFrame.new(1.1955,0.095,-1.6) * CFrame.Angles(math.rad(-120.5),math.rad(35.5),math.rad(-19.5))}):Play()
		wait(0.20)
		ts(objs[2],TweenInfo.new(0.20),{C1 = CFrame.new(-.65, -0.2, -1) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))}):Play()
		ts(objs[3],TweenInfo.new(0.20),{C1 = CFrame.new(1.2,0.1,-1.6) * CFrame.Angles(math.rad(-120),math.rad(35),math.rad(-20))}):Play()
		wait(0.20)
	end;

	UnZoomAnim = function(char, speed, objs)
		ts(objs[3],TweenInfo.new(0.25),{C1 = require(script.Parent.Settings).LeftPos}):Play()
		script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("FlashOn"):Play()
		objs[5].Switch1.Transparency = 0
		objs[5].Switch2.Transparency = 1
		objs[5].Reticle.SurfaceGui.ClippingFrame.Reticle.Image = "rbxassetid://6694542625"
		ts(objs[2],TweenInfo.new(0.20),{C1 = CFrame.new(-.65, -0.2, -1) * CFrame.Angles(math.rad(-89), math.rad(-1), math.rad(-1))}):Play()
		ts(objs[3],TweenInfo.new(0.20),{C1 = CFrame.new(1.205,0.11,-1.605) * CFrame.Angles(math.rad(-119),math.rad(34),math.rad(-21))}):Play()
		wait(0.20)
		ts(objs[2],TweenInfo.new(0.20),{C1 = CFrame.new(-.65, -0.2, -1) * CFrame.Angles(math.rad(-90.5), math.rad(0.5), math.rad(0.5))}):Play()
		ts(objs[3],TweenInfo.new(0.20),{C1 = CFrame.new(1.1955,0.095,-1.6) * CFrame.Angles(math.rad(-120.5),math.rad(35.5),math.rad(-19.5))}):Play()
		wait(0.20)
		ts(objs[2],TweenInfo.new(0.20),{C1 = CFrame.new(-.65, -0.2, -1) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))}):Play()
		ts(objs[3],TweenInfo.new(0.20),{C1 = CFrame.new(1.2,0.1,-1.6) * CFrame.Angles(math.rad(-120),math.rad(35),math.rad(-20))}):Play()
		wait(0.20)
	end;

	ChamberAnim = function(char, speed, objs)
		if script.Parent.Ammo.Value > 0 and script.Parent.Ammo.Value < 5 then
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(1.2,0.55,-1.35) * CFrame.Angles(math.rad(-90),math.rad(35),math.rad(-25))}):Play()
			ts(objs[2],TweenInfo.new(0.25),{C1 = CFrame.new(-0.95, -0.3, -0.85) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))}):Play()
			ts(objs[4],TweenInfo.new(0.25),{C1 = CFrame.new(0.45,-0,1.1) * CFrame.Angles(math.rad(90),math.rad(0),math.rad(0))}):Play()

			wait(0.25)
			script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("BoltOpen"):Play()
			ts(objs[5].Handle:WaitForChild("Bolt"),TweenInfo.new(0.2),{C0 = CFrame.new(0.2035,0.061,0) * CFrame.Angles(0,0,math.rad(35))}):Play()
			ts(objs[5].Handle:WaitForChild("Slide"),TweenInfo.new(0.2),{C0 = CFrame.new(0.2035,0.061,0) * CFrame.Angles(0,0,math.rad(35))}):Play()
			ts(objs[2],TweenInfo.new(0.2),{C1 = CFrame.new(-1.03, -0.3, -0.73) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))}):Play()
			ts(objs[4],TweenInfo.new(0.2),{C1 = CFrame.new(0.63,0.12,1.1) * CFrame.Angles(math.rad(105),math.rad(-2.5),math.rad(2.5))}):Play()
			wait(0.2)
			ts(objs[5].Handle:WaitForChild("Bolt"),TweenInfo.new(0.15),{C0 = CFrame.new(0.2035,0.061,0.45) * CFrame.Angles(0,0,math.rad(35))}):Play()
			ts(objs[5].Handle:WaitForChild("Slide"),TweenInfo.new(0.15),{C0 = CFrame.new(0.2035,0.061,0.45) * CFrame.Angles(0,0,math.rad(35))}):Play()
			ts(objs[2],TweenInfo.new(0.15),{C1 = CFrame.new(-1.03, -0.75, -0.73) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))}):Play()
			ts(objs[4],TweenInfo.new(0.15),{C1 = CFrame.new(0.53,0.12,1.55) * CFrame.Angles(math.rad(105),math.rad(1.5),math.rad(2.5))}):Play()
			wait(0.15)
			script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("BoltClose"):Play()
			ts(objs[5].Handle:WaitForChild("Bolt"),TweenInfo.new(0.15),{C0 = CFrame.new(0.2035,0.061,0) * CFrame.Angles(0,0,math.rad(35))}):Play()
			ts(objs[5].Handle:WaitForChild("Slide"),TweenInfo.new(0.15),{C0 = CFrame.new(0.2035,0.061,0) * CFrame.Angles(0,0,math.rad(35))}):Play()
			ts(objs[2],TweenInfo.new(0.15),{C1 = CFrame.new(-1.03, -0.3, -0.73) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))}):Play()
			ts(objs[4],TweenInfo.new(0.15),{C1 = CFrame.new(0.53,0.12,1.1) * CFrame.Angles(math.rad(105),math.rad(-1),math.rad(2.5))}):Play()
			wait(0.2)
			ts(objs[5].Handle:WaitForChild("Bolt"),TweenInfo.new(0.35),{C0 = CFrame.new(0,0,0) * CFrame.Angles(0,math.rad(0),0)}):Play()
			ts(objs[5].Handle:WaitForChild("Slide"),TweenInfo.new(0.35),{C0 = CFrame.new(0,0,0) * CFrame.Angles(0,math.rad(0),0)}):Play()
			ts(objs[2],TweenInfo.new(0.25),{C1 = CFrame.new(-1.03, -0.3, -0.83) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))}):Play()
			ts(objs[4],TweenInfo.new(0.25),{C1 = CFrame.new(0.53,0.02,1.1) * CFrame.Angles(math.rad(100),math.rad(-0.5),math.rad(1.75))}):Play()
			wait(0.25)
			ts(objs[3],TweenInfo.new(0.35),{C1 = require(script.Parent.Settings).LeftPos}):Play()
			ts(objs[2],TweenInfo.new(0.35),{C1 = require(script.Parent.Settings).RightPos}):Play() 
			ts(objs[4],TweenInfo.new(0.35),{C1 = require(script.Parent.Settings).GunPos}):Play()
			wait(0.35)
			first = true
		end
	end;
	
	ChamberCheckAnim = function(char, speed, objs)
wait(0.35)
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
		ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(-0.5,0.475,-1.8) * CFrame.Angles(math.rad(-100),math.rad(0),math.rad(7.5))}):Play()
		wait(.35)
		local MagC = objs[5]:WaitForChild("Mag"):clone()
		objs[5].Mag.Transparency = 1
		MagC.Parent = workspace.CurrentCamera
		MagC.Name = "MagC"
		MagC.Transparency = 0			

		local MagCW = Instance.new("Motor6D")
		MagCW.Part0 = MagC
		MagCW.Part1 = objs[3].Parent.Parent:WaitForChild("Left Arm")
		MagCW.Parent = MagC
		MagCW.C1 = MagC.CFrame:toObjectSpace(objs[3].Parent.Parent:WaitForChild("Left Arm").CFrame)
		ts(MagCW,TweenInfo.new(0),{C0 = CFrame.new(-0.2, 0.5, -0.75) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))}):Play()
		ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(-0.4,0.275,-2.5) * CFrame.Angles(math.rad(-120),math.rad(0),math.rad(7.5))}):Play()
		script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("MagOut"):Play()
		wait(0.3)
		ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(0.15,0.475,-1.5) * CFrame.Angles(math.rad(-100),math.rad(0),math.rad(0))}):Play()
		wait(1.5)
		ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(-0.4,0.275,-2.5) * CFrame.Angles(math.rad(-120),math.rad(0),math.rad(7.5))}):Play()
		wait(0.3)
		ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(-0.5,0.475,-1.8) * CFrame.Angles(math.rad(-100),math.rad(0),math.rad(7.5))}):Play()
		script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("MagIn"):Play()
		MagC:Destroy()
		objs[5].Mag.Transparency = 0	
		wait(0.3)
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
		if objs[7].Value <= 0 then
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(1.2,0.55,-1.35) * CFrame.Angles(math.rad(-90),math.rad(35),math.rad(-25))}):Play()
			ts(objs[2],TweenInfo.new(0.25),{C1 = CFrame.new(-0.95, -0.3, -0.85) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))}):Play()
			ts(objs[4],TweenInfo.new(0.25),{C1 = CFrame.new(0.45,-0,1.1) * CFrame.Angles(math.rad(90),math.rad(0),math.rad(0))}):Play()

			wait(0.25)
			script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("BoltOpen"):Play()
			ts(objs[5].Handle:WaitForChild("Bolt"),TweenInfo.new(0.2),{C0 = CFrame.new(0.2035,0.061,0) * CFrame.Angles(0,0,math.rad(35))}):Play()
			ts(objs[5].Handle:WaitForChild("Slide"),TweenInfo.new(0.2),{C0 = CFrame.new(0,0,0) * CFrame.Angles(0,0,math.rad(0))}):Play()
			ts(objs[2],TweenInfo.new(0.2),{C1 = CFrame.new(-1.03, -0.3, -0.73) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))}):Play()
			ts(objs[4],TweenInfo.new(0.2),{C1 = CFrame.new(0.63,0.12,1.1) * CFrame.Angles(math.rad(105),math.rad(-2.5),math.rad(2.5))}):Play()
			wait(0.2)
			ts(objs[5].Handle:WaitForChild("Bolt"),TweenInfo.new(0.15),{C0 = CFrame.new(0.2035,0.061,0.45) * CFrame.Angles(0,0,math.rad(35))}):Play()
			ts(objs[5].Handle:WaitForChild("Slide"),TweenInfo.new(0.15),{C0 = CFrame.new(0,0,0.45) * CFrame.Angles(0,0,math.rad(0))}):Play()
			ts(objs[2],TweenInfo.new(0.15),{C1 = CFrame.new(-1.03, -0.75, -0.73) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))}):Play()
			ts(objs[4],TweenInfo.new(0.15),{C1 = CFrame.new(0.53,0.12,1.55) * CFrame.Angles(math.rad(105),math.rad(1.5),math.rad(2.5))}):Play()
			wait(0.15)



			ts(objs[2],TweenInfo.new(0.4),{C1 = CFrame.new(-0.875, 0, -1.15) * CFrame.Angles(math.rad(-94), math.rad(-2), math.rad(7))}):Play()
			ts(objs[3],TweenInfo.new(0.4),{C1 = CFrame.new(-0.518,0.550,-1.6) * CFrame.Angles(math.rad(-100),math.rad(0),math.rad(7.5))}):Play()
			ts(objs[4],TweenInfo.new(0.35),{C1 = require(script.Parent.Settings).GunPos}):Play()
			--Left+Right Reload 1
			wait(0.5)	
			objs[5].Mag.Transparency = 1
			local Mag1 = objs[5]:WaitForChild("Mag"):clone()
			Mag1.Parent = workspace.CurrentCamera
			Mag1.Name = "Mag1"
			Mag1.Transparency = 0			

			local MagW1 = Instance.new("Motor6D")
			MagW1.Part0 = Mag1
			MagW1.Part1 = objs[3].Parent.Parent:WaitForChild("Left Arm")
			MagW1.Parent = Mag1
			MagW1.C1 = Mag1.CFrame:toObjectSpace(objs[5].Mag.CFrame)

			--ts(MagW1,TweenInfo.new(0),{C0 = CFrame.new(-0.18, 0.32, -0.82) * CFrame.Angles(math.rad(-83), math.rad(0), math.rad(1.5))}):Play()
			ts(objs[2],TweenInfo.new(0.5),{C1 = CFrame.new(-0.8725, 0.112, -1.18) * CFrame.Angles(math.rad(-91), math.rad(-4), math.rad(6))}):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(-0.518,0.550,-2.4) * CFrame.Angles(math.rad(-100),math.rad(0),math.rad(7.5))}):Play()
			--Left+Right Reload 2
			wait(.05)

			script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("MagOut"):Play()
			wait(0.25)
			ts(objs[2],TweenInfo.new(0.7),{C1 = CFrame.new(-0.82, 0.110, -1.14) * CFrame.Angles(math.rad(-91), math.rad(-2), math.rad(7))}):Play()
			ts(objs[3],TweenInfo.new(0.5),{C1 = CFrame.new(-0.65,0.475,-3.05) * CFrame.Angles(math.rad(-100),math.rad(0),math.rad(25.5))}):Play()
			--Left+Right Reload 3
			wait(0.5)
			script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("MagGrab"):Play()
			ts(objs[2],TweenInfo.new(0.7),{C1 = CFrame.new(-0.80, 0.107, -1.13) * CFrame.Angles(math.rad(-90), math.rad(-3), math.rad(8))}):Play()
			wait(0.5)
			script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("MagPouch"):Play()
			--//RightReload4
			--//Above is where you reach into the pouch.	

			wait(0.2)
			ts(objs[3],TweenInfo.new(0.0),{C1 = CFrame.new(0.25,0.475,-3.05) * CFrame.Angles(math.rad(-100),math.rad(0),math.rad(7.5))}):Play()	
			--//Left Reload 4
			wait(0.2)

			ts(objs[2],TweenInfo.new(0.7),{C1 = CFrame.new(-0.872, 0.100, -1.17) * CFrame.Angles(math.rad(-96), math.rad(-2), math.rad(14))}):Play()
			--//Right Reload 5
			wait(0.3)	
			wait(0.175)

			ts(objs[2],TweenInfo.new(0.4),{C1 = CFrame.new(-0.875, 0, -1.15) * CFrame.Angles(math.rad(-95), math.rad(-2), math.rad(7.5))}):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(-0.4,0.275,-2.1) * CFrame.Angles(math.rad(-120),math.rad(0),math.rad(7.5))}):Play()
			wait(0.25)
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(-0.5,1,-1.7) * CFrame.Angles(math.rad(-100),math.rad(0),math.rad(7.5))}):Play()
			ts(objs[2],TweenInfo.new(0.1),{C1 = CFrame.new(-0.875, 0, -1.125) * CFrame.Angles(math.rad(-95), math.rad(-2), math.rad(7.5))}):Play()
			script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("MagIn"):Play()
			Mag1:Destroy()
			objs[5].Mag.Transparency = 0	

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
			wait(.15)
			ts(objs[3],TweenInfo.new(0.35),{C1 = require(script.Parent.Settings).LeftPos}):Play()
			ts(objs[2],TweenInfo.new(0.35),{C1 = require(script.Parent.Settings).RightPos}):Play() 
			ts(objs[4],TweenInfo.new(0.35),{C1 = require(script.Parent.Settings).GunPos}):Play()
			wait(0.5)
			script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("BoltClose"):Play()
			ts(objs[5].Handle:WaitForChild("Bolt"),TweenInfo.new(0.15),{C0 = CFrame.new(0.2035,0.061,0) * CFrame.Angles(0,0,math.rad(35))}):Play()
			ts(objs[5].Handle:WaitForChild("Slide"),TweenInfo.new(0.15),{C0 = CFrame.new(0,0,0) * CFrame.Angles(0,0,math.rad(0))}):Play()
			ts(objs[2],TweenInfo.new(0.15),{C1 = CFrame.new(-1.03, -0.3, -0.73) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))}):Play()
			ts(objs[4],TweenInfo.new(0.15),{C1 = CFrame.new(0.53,0.12,1.1) * CFrame.Angles(math.rad(105),math.rad(-1),math.rad(2.5))}):Play()
			wait(0.2)
			ts(objs[5].Handle:WaitForChild("Bolt"),TweenInfo.new(0.35),{C0 = CFrame.new(0,0,0) * CFrame.Angles(0,math.rad(0),0)}):Play()
			ts(objs[5].Handle:WaitForChild("Slide"),TweenInfo.new(0.35),{C0 = CFrame.new(0,0,0) * CFrame.Angles(0,math.rad(0),0)}):Play()
			ts(objs[2],TweenInfo.new(0.25),{C1 = CFrame.new(-1.03, -0.3, -0.83) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))}):Play()
			ts(objs[4],TweenInfo.new(0.25),{C1 = CFrame.new(0.53,0.02,1.1) * CFrame.Angles(math.rad(100),math.rad(-0.5),math.rad(1.75))}):Play()
			wait(0.25)
			ts(objs[3],TweenInfo.new(0.35),{C1 = require(script.Parent.Settings).LeftPos}):Play()
			ts(objs[2],TweenInfo.new(0.35),{C1 = require(script.Parent.Settings).RightPos}):Play() 
			ts(objs[4],TweenInfo.new(0.35),{C1 = require(script.Parent.Settings).GunPos}):Play()
			wait(0.35)
		else
			ts(objs[2],TweenInfo.new(0.4),{C1 = CFrame.new(-0.875, 0, -1.15) * CFrame.Angles(math.rad(-94), math.rad(-2), math.rad(7))}):Play()
			ts(objs[3],TweenInfo.new(0.4),{C1 = CFrame.new(-0.518,0.550,-1.6) * CFrame.Angles(math.rad(-100),math.rad(0),math.rad(7.5))}):Play()
			--Left+Right Reload 1
			wait(0.5)	
			objs[5].Mag.Transparency = 1
			local Mag1 = objs[5]:WaitForChild("Mag"):clone()
			Mag1.Parent = workspace.CurrentCamera
			Mag1.Name = "Mag1"
			Mag1.Transparency = 0			

			local MagW1 = Instance.new("Motor6D")
			MagW1.Part0 = Mag1
			MagW1.Part1 = objs[3].Parent.Parent:WaitForChild("Left Arm")
			MagW1.Parent = Mag1
			MagW1.C1 = Mag1.CFrame:toObjectSpace(objs[5].Mag.CFrame)

			--ts(MagW1,TweenInfo.new(0),{C0 = CFrame.new(-0.18, 0.32, -0.82) * CFrame.Angles(math.rad(-83), math.rad(0), math.rad(1.5))}):Play()
			ts(objs[2],TweenInfo.new(0.5),{C1 = CFrame.new(-0.8725, 0.112, -1.18) * CFrame.Angles(math.rad(-91), math.rad(-4), math.rad(6))}):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(-0.518,0.550,-2.4) * CFrame.Angles(math.rad(-100),math.rad(0),math.rad(7.5))}):Play()
			--Left+Right Reload 2
			wait(.05)

			script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("MagOut"):Play()
			wait(0.25)
			ts(objs[2],TweenInfo.new(0.7),{C1 = CFrame.new(-0.82, 0.110, -1.14) * CFrame.Angles(math.rad(-91), math.rad(-2), math.rad(7))}):Play()
			ts(objs[3],TweenInfo.new(0.5),{C1 = CFrame.new(-0.65,0.475,-3.05) * CFrame.Angles(math.rad(-100),math.rad(0),math.rad(25.5))}):Play()
			--Left+Right Reload 3
			wait(0.5)
			script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("MagGrab"):Play()
			ts(objs[2],TweenInfo.new(0.7),{C1 = CFrame.new(-0.80, 0.107, -1.13) * CFrame.Angles(math.rad(-90), math.rad(-3), math.rad(8))}):Play()
			wait(0.5)
			script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("MagPouch"):Play()
			--//RightReload4
			--//Above is where you reach into the pouch.	

			wait(0.2)
			ts(objs[3],TweenInfo.new(0.0),{C1 = CFrame.new(0.25,0.475,-3.05) * CFrame.Angles(math.rad(-100),math.rad(0),math.rad(7.5))}):Play()	
			--//Left Reload 4
			wait(0.2)

			ts(objs[2],TweenInfo.new(0.7),{C1 = CFrame.new(-0.872, 0.100, -1.17) * CFrame.Angles(math.rad(-96), math.rad(-2), math.rad(14))}):Play()
			--//Right Reload 5
			wait(0.3)	
			wait(0.175)

			ts(objs[2],TweenInfo.new(0.4),{C1 = CFrame.new(-0.875, 0, -1.15) * CFrame.Angles(math.rad(-95), math.rad(-2), math.rad(7.5))}):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(-0.4,0.275,-2.1) * CFrame.Angles(math.rad(-120),math.rad(0),math.rad(7.5))}):Play()
			wait(0.25)
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(-0.5,1,-1.7) * CFrame.Angles(math.rad(-100),math.rad(0),math.rad(7.5))}):Play()
			ts(objs[2],TweenInfo.new(0.1),{C1 = CFrame.new(-0.875, 0, -1.125) * CFrame.Angles(math.rad(-95), math.rad(-2), math.rad(7.5))}):Play()
			script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("MagIn"):Play()
			Mag1:Destroy()
			objs[5].Mag.Transparency = 0	

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
			wait(.55)
		end
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
	
}

return module
