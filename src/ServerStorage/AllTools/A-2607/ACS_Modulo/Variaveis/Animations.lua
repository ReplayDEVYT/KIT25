local ts = require(game.ReplicatedStorage.TService)
local Debris = game:GetService("Debris")
equipped = false
local mode = 1
local module = {

--//Client Animations
		IdleAnim = function(char, speed, objs)
			ts(objs[2],TweenInfo.new(0.3),{C1 = require(script.Parent.Settings).RightPos}):Play() -- require(script).FakeRightPos (For fake arms) | require(script).RightArmPos (For real arms)
			ts(objs[3],TweenInfo.new(0.3),{C1 = require(script.Parent.Settings).LeftPos}):Play() -- require(script).FakeLeftPos (For fake arms) | require(script).LeftArmPos (For real arms)	
		end;
		
		StanceDown = function(char, speed, objs)
			ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(-.875, 0.45, -1.25) * CFrame.Angles(math.rad(-75), math.rad(0), math.rad(0))}):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(1.1,-0.05,-1.65) * CFrame.Angles(math.rad(-90),math.rad(35),math.rad(-25))}):Play()
			wait(0.3)	
		end;

		StanceUp = function(char, speed, objs)
			ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(-1, -.75, -1.25) * CFrame.Angles(math.rad(-160), math.rad(0), math.rad(0))}):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(.75,-0.75,-1.35) * CFrame.Angles(math.rad(-170),math.rad(60),math.rad(15))}):Play()
			wait(0.3)	
		end;
		
		Patrol = function(char, speed, objs)
			ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(-.8, 0.3, -1.15) * CFrame.Angles(math.rad(-65), math.rad(0), math.rad(0))}):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(1.9,0.4,-0.9) * CFrame.Angles(math.rad(-50),math.rad(45),math.rad(-45))}):Play()
			wait(0.3)	
		end;

		SprintAnim = function(char, speed, objs)
			ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(-1, -.75, -1.25) * CFrame.Angles(math.rad(-160), math.rad(0), math.rad(0))}):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(.75,-0.75,-1.35) * CFrame.Angles(math.rad(-170),math.rad(60),math.rad(15))}):Play()
			wait(0.3)	
	end;
	
	FireAnim = function(char, speed, objs)  
		mode = mode + 1
		if mode > 2 then
			mode = 1
		end
	if mode == 1 then
		ts(objs[2],TweenInfo.new(0.15),{C1 = CFrame.new(-.65, 1.2, -1.5) * CFrame.Angles(math.rad(-75), math.rad(0), math.rad(0))}):Play()
			wait(.1)
		--ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(.5, 0.35, -1) * CFrame.Angles(math.rad(-95), math.rad(10), math.rad(-75))}):Play()
		ts(objs[2],TweenInfo.new(0.15),{C1 = CFrame.new(-.65, 1.4, -2) * CFrame.Angles(math.rad(-120), math.rad(0), math.rad(-45))}):Play()
		ts(objs[5].blade,TweenInfo.new(0.15),{CFrame = objs[5].blade.CFrame * CFrame.new(0,0,0) * CFrame.Angles(math.rad(35), math.rad(70), math.rad(0))}):Play()
			script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("Attack1"):Play()
			wait(.2)--0.2
		ts(objs[5].blade,TweenInfo.new(0.3),{CFrame = CFrame.new(0,0,0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))}):Play()
		ts(objs[2],TweenInfo.new(0.3),{C1 = require(script.Parent.Settings).RightPos}):Play()
		ts(objs[3],TweenInfo.new(0.3),{C1 = require(script.Parent.Settings).LeftPos}):Play()
		elseif mode == 2 then
			--ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(.65, .75, -2) * CFrame.Angles(math.rad(-75), math.rad(0), math.rad(45))}):Play()
			ts(objs[2],TweenInfo.new(0.1),{C1 = CFrame.new(-1.25, 1.75, -1.25) * CFrame.Angles(math.rad(-120), math.rad(0), math.rad(40))}):Play()
			wait(.1)
			--ts(objs[2],TweenInfo.new(0.15),{C1 = CFrame.new(-.65, 1.75, -1.25) * CFrame.Angles(math.rad(-120), math.rad(0), math.rad(40))}):Play()
			ts(objs[2],TweenInfo.new(0.15),{C1 = CFrame.new(0, .5, -2) * CFrame.Angles(math.rad(-75), math.rad(0), math.rad(45))}):Play()
			ts(objs[5].blade,TweenInfo.new(0.15),{CFrame = objs[5].blade.CFrame * CFrame.new(0,0,0) * CFrame.Angles(math.rad(35), math.rad(70), math.rad(0))}):Play()
			script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("Attack2"):Play()
			wait(.2)--0.2
			ts(objs[5].blade,TweenInfo.new(0.3),{CFrame = CFrame.new(0,0,0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))}):Play()
			ts(objs[2],TweenInfo.new(0.3),{C1 = require(script.Parent.Settings).RightPos}):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = require(script.Parent.Settings).LeftPos}):Play()
		end
	end;
	
	ImpactAnim = function(char, speed, objs)  
		if mode == 1 then
			--ts(objs[2],TweenInfo.new(0.15),{C1 = CFrame.new(-.65, 1.2, -1.5) * CFrame.Angles(math.rad(-75), math.rad(0), math.rad(0))}):Play()
			ts(objs[2],TweenInfo.new(0.15),{C1 = CFrame.new(-.65, 1.5, -1.5) * CFrame.Angles(math.rad(-120), math.rad(0), math.rad(-25))}):Play()
			wait(.1)
			if objs[12].Parent:FindFirstChild("Humanoid") == nil then
				script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("Impact"):Play()
				end
			wait(.05)
			ts(objs[2],TweenInfo.new(0.2),{C1 = require(script.Parent.Settings).RightPos}):Play()
			ts(objs[3],TweenInfo.new(0.2),{C1 = require(script.Parent.Settings).LeftPos}):Play()
		elseif mode == 2 then
			ts(objs[2],TweenInfo.new(0.1),{C1 = CFrame.new(-.5, 1.5, -.7) * CFrame.Angles(math.rad(-130), math.rad(0), math.rad(35))}):Play()
			if objs[12].Parent:FindFirstChild("Humanoid") == nil then
				script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("Impact"):Play()
			end
			wait(.05)--0.2
			ts(objs[2],TweenInfo.new(0.2),{C1 = require(script.Parent.Settings).RightPos}):Play()
			ts(objs[3],TweenInfo.new(0.2),{C1 = require(script.Parent.Settings).LeftPos}):Play()
		end
	end;

	EquipAnim = function(char, speed, objs)
		ts(objs[2],TweenInfo.new(0),{C1 = CFrame.new(-.875, -0.2, -1.25) * CFrame.Angles(math.rad(-60), math.rad(0), math.rad(0))}):Play()
		ts(objs[3],TweenInfo.new(0),{C1 = CFrame.new(1.2,-0.05,-1.65) * CFrame.Angles(math.rad(-90),math.rad(35),math.rad(-25))}):Play()
		wait(0.25)
		objs[5].Handle:WaitForChild("AimUp"):Play()
		script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("Equip"):Play()
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
	CheckWatch = function(char, speed, objs)
		ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(0.170, -0.74, -1)*CFrame.Angles(math.rad(-180), 0, 0)*CFrame.Angles(0, 0, math.rad(30))}):Play()
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
	FiremodeAnim = function(char, speed, objs)
		ts(objs[3],TweenInfo.new(0.25),{C1 = require(script.Parent.Settings).LeftPos}):Play()
		ts(objs[2],TweenInfo.new(0.25),{C1 = require(script.Parent.Settings).RightPos * CFrame.new(0.1, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-10))}):Play()
		wait(0.25)
		ts(objs[3],TweenInfo.new(0.15),{C1 = require(script.Parent.Settings).LeftPos}):Play()
		ts(objs[2],TweenInfo.new(0.15),{C1 = require(script.Parent.Settings).RightPos}):Play() 
		wait(0.15)
	end;
	ChamberAnim = function(char, speed, objs)
		ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(0.6, -0.2, -1) * CFrame.Angles(math.rad(-95), math.rad(30), math.rad(-60))}):Play()
		ts(objs[3],TweenInfo.new(0.35),{C1 = CFrame.new(0.3,-0.9,-0.7) * CFrame.Angles(math.rad(-120),math.rad(70),math.rad(15))}):Play()
		wait(0.35)	
		script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("SlidePull"):Play()
		ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(0.6, -0.5, -1) * CFrame.Angles(math.rad(-110), math.rad(30), math.rad(-60))}):Play()
		ts(objs[3],TweenInfo.new(0.25),{C1 = CFrame.new(-0.2,-1,-0.6) * CFrame.Angles(math.rad(-120),math.rad(70),math.rad(15))}):Play()
		ts(objs[5].Handle:WaitForChild("Bolt"),TweenInfo.new(0.25),{C0 = CFrame.new(0,0,0.4) * CFrame.Angles(0,math.rad(0),0)}):Play()
		ts(objs[5].Handle:WaitForChild("Slide"),TweenInfo.new(0.25),{C0 = CFrame.new(0,0,0.4) * CFrame.Angles(0,math.rad(0),0)}):Play()
		wait(0.3)
		ts(objs[2],TweenInfo.new(0.2),{C1 = CFrame.new(0.6, 0, -1) * CFrame.Angles(math.rad(-95), math.rad(30), math.rad(-60))}):Play()
		ts(objs[3],TweenInfo.new(0.25),{C1 = CFrame.new(-0.2,-1.8,-0.8) * CFrame.Angles(math.rad(-120),math.rad(70),math.rad(15))}):Play()
		script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("SlideRelease"):Play()
		ts(objs[5].Handle:WaitForChild("Bolt"),TweenInfo.new(0.1),{C0 = CFrame.new(0,0,0) * CFrame.Angles(0,math.rad(0),0)}):Play()
		ts(objs[5].Handle:WaitForChild("Slide"),TweenInfo.new(0.1),{C0 = CFrame.new(0,0,0) * CFrame.Angles(0,math.rad(0),0)}):Play()
		wait(0.2)
	end;
	ChamberCheckAnim = function(char, speed, objs)
	end;

		ChamberBKAnim = function(char, speed, objs)
			ts(objs[2],TweenInfo.new(0.3),{C1 = require(script.Parent.Settings).RightPos}):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(0.55,0.05,-1.5) * CFrame.Angles(math.rad(-120),math.rad(20),math.rad(0))}):Play()
			wait(0.3)	
		script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("SlideRelease"):Play()
			ts(objs[5].Handle:WaitForChild("Bolt"),TweenInfo.new(0.1),{C0 = CFrame.new(0,0,0) * CFrame.Angles(0,math.rad(0),0)}):Play()
			ts(objs[5].Handle:WaitForChild("Slide"),TweenInfo.new(0.1),{C0 = CFrame.new(0,0,0) * CFrame.Angles(0,math.rad(0),0)}):Play()
			wait(0.15)
		end;
		
		CheckAnim = function(char, speed, objs)
			ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(-0.875, 0.5, -1.15) * CFrame.Angles(math.rad(-95), math.rad(-2), math.rad(7.5))}):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(-0.5,0.475,-1.6) * CFrame.Angles(math.rad(-100),math.rad(0),math.rad(7.5))}):Play()
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
			ts(MagCW,TweenInfo.new(0),{C0 = CFrame.new(.3, -0.2, .85) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(90))}):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(-0.45,0.475,-2.05) * CFrame.Angles(math.rad(-100),math.rad(0),math.rad(7.5))}):Play()
		script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("MagOut"):Play()
			wait(0.3)
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(0.15,0.475,-1.5) * CFrame.Angles(math.rad(-100),math.rad(0),math.rad(0))}):Play()
			wait(1.5)
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(-0.45,0.475,-2.05) * CFrame.Angles(math.rad(-100),math.rad(0),math.rad(7.5))}):Play()
			wait(0.3)
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(-0.5,0.475,-1.6) * CFrame.Angles(math.rad(-100),math.rad(0),math.rad(7.5))}):Play()
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
			ts(objs[2],TweenInfo.new(0.15),{C1 = CFrame.new(0, 0.425, -1.25) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(-45))}):Play()
			ts(objs[3],TweenInfo.new(0.4),{C1 = CFrame.new(1.195,1.4,-0.5) * CFrame.Angles(math.rad(0),math.rad(25),math.rad(0))}):Play()
			--ts(objs[3],TweenInfo.new(0.2),{C1 = CFrame.new(1.35,-0.95,-1.45) * CFrame.Angles(math.rad(-130),math.rad(75),math.rad(15))}):Play()
			--wait(0.3)	
			--ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(-0.975, 0.425, -0.75) * CFrame.Angles(math.rad(-85), math.rad(0), math.rad(-30))}):Play()
			--ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(1.2,-1.5,-1.65) * CFrame.Angles(math.rad(-125),math.rad(75),math.rad(15))}):Play()
			wait(0.15)
			
			script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("MagOut"):Play()
			
			local MagZ = objs[5]:WaitForChild("Mag"):clone()
				objs[5].Mag.Transparency = 1
				MagZ.Parent = workspace.CurrentCamera
				MagZ.Name = "MagZ"
				MagZ.Transparency = 0
				MagZ.Anchored = false
				MagZ.CanCollide = true
				MagZ:ClearAllChildren()
				MagZ.Velocity = MagZ.CFrame.RightVector * 25


			Debris:AddItem(MagZ,1)
			script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("MagGrab"):Play()
			--[[local MagC = objs[5]:WaitForChild("Mag"):clone()
				objs[5].Mag.Transparency = 1
				MagC.Parent = workspace.CurrentCamera
				MagC.Name = "MagC"
				MagC.Transparency = 0
			
			local MagCW = Instance.new("Motor6D")
				MagCW.Part0 = MagC
				MagCW.Part1 = objs[3].Parent.Parent:WaitForChild("Left Arm")
				MagCW.Parent = MagC
				MagCW.C1 = MagC.CFrame:toObjectSpace(objs[5].Mag.CFrame)]]--

			wait(0.05)
			
			ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(-0.975, 0.425, -0.75) * CFrame.Angles(math.rad(-85), math.rad(0), math.rad(30))}):Play()
				
			wait(0.2)
			ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(-0.975, 0.425, -0.75) * CFrame.Angles(math.rad(-85), math.rad(0), math.rad(30))}):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(1.2,-1.5,-1.65) * CFrame.Angles(math.rad(-125),math.rad(75),math.rad(15))}):Play()
			wait(0.3)
			ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(-0.975, 0.425, -0.75) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(30))}):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(1.35,-0.95,-1.45) * CFrame.Angles(math.rad(-130),math.rad(75),math.rad(15))}):Play()
			script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("MagIn"):Play()
			script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("MagDrop"):Play()
			--MagC:Destroy()
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
			wait(0.55)
		else
			ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(-0.975, 0.425, -0.75) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(30))}):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(1.35,-0.95,-1.45) * CFrame.Angles(math.rad(-130),math.rad(75),math.rad(15))}):Play()
			wait(0.3)	
			ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(-0.975, 0.425, -0.75) * CFrame.Angles(math.rad(-85), math.rad(0), math.rad(30))}):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(1.2,-1.5,-1.65) * CFrame.Angles(math.rad(-125),math.rad(75),math.rad(15))}):Play()
			
			local MagC = objs[5]:WaitForChild("Mag"):clone()
				objs[5].Mag.Transparency = 1
				MagC.Parent = workspace.CurrentCamera
				MagC.Name = "MagC"
				MagC.Transparency = 0
			
			local MagCW = Instance.new("Motor6D")
				MagCW.Part0 = MagC
				MagCW.Part1 = objs[3].Parent.Parent:WaitForChild("Left Arm")
				MagCW.Parent = MagC
				MagCW.C1 = MagC.CFrame:toObjectSpace(objs[5].Mag.CFrame)
				

			script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("MagOut"):Play()
			
			wait(0.3)
			script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("MagGrab"):Play()				
			ts(objs[3],TweenInfo.new(0.4),{C1 = CFrame.new(1.195,1.4,-0.5) * CFrame.Angles(math.rad(0),math.rad(25),math.rad(0))}):Play()
			wait(0.75)
			ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(-0.975, 0.425, -0.75) * CFrame.Angles(math.rad(-85), math.rad(0), math.rad(30))}):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(1.2,-1.5,-1.65) * CFrame.Angles(math.rad(-125),math.rad(75),math.rad(15))}):Play()
			wait(0.3)
			ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(-0.975, 0.425, -0.75) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(30))}):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(1.35,-0.95,-1.45) * CFrame.Angles(math.rad(-130),math.rad(75),math.rad(15))}):Play()
			script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("MagIn"):Play()
			MagC:Destroy()
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
			wait(0.55)
		end
		end;

--//Server Animations
	RightHighReady = CFrame.new(-1, -.5, -1.25) * CFrame.Angles(math.rad(-160), math.rad(0), math.rad(0));
	LeftHighReady = CFrame.new(.85,-0.35,-1.15) * CFrame.Angles(math.rad(-170),math.rad(60),math.rad(15));

	RightLowReady = CFrame.new(-1, 0.85, -1.15) * CFrame.Angles(math.rad(-60), math.rad(0), math.rad(0));
	LeftLowReady = CFrame.new(.95,.75,-1.35) * CFrame.Angles(math.rad(-60),math.rad(35),math.rad(-25));

	RightPatrol = CFrame.new(-1, 1.5, -0.45) * CFrame.Angles(math.rad(-30), math.rad(0), math.rad(0));
	LeftPatrol = CFrame.new(1,1.35,-0.75) * CFrame.Angles(math.rad(-30),math.rad(35),math.rad(-25));

	RightAim = CFrame.new(-.575, 1, -.65) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0));
	LeftAim = CFrame.new(1.3,0.35,-1.45) * CFrame.Angles(math.rad(-120),math.rad(35),math.rad(-25));
	
	RightSprint = CFrame.new(-1, 1.5, -0.45) * CFrame.Angles(math.rad(-30), math.rad(0), math.rad(0));
	LeftSprint = CFrame.new(1,1.35,-0.75) * CFrame.Angles(math.rad(-30),math.rad(35),math.rad(-25));

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
	
	ServerFireAnim = function(char, speed, objs)  
		mode = mode + 1
		if mode > 2 then
			mode = 1
		end
		if mode == 1 then
			ts(objs[2],TweenInfo.new(0.15),{C1 = CFrame.new(-.65, 1.2, -1.5) * CFrame.Angles(math.rad(-75), math.rad(0), math.rad(0))}):Play()
			wait(.1)
			--ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(.5, 0.35, -1) * CFrame.Angles(math.rad(-95), math.rad(10), math.rad(-75))}):Play()
			ts(objs[2],TweenInfo.new(0.15),{C1 = CFrame.new(-.65, 1.4, -2) * CFrame.Angles(math.rad(-120), math.rad(0), math.rad(-45))}):Play()
			wait(.2)--0.2
			ts(objs[2],TweenInfo.new(0.3),{C1 = objs[8].RightArmPos}):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = objs[8].LeftArmPos}):Play()
		elseif mode == 2 then
			--ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(.65, .75, -2) * CFrame.Angles(math.rad(-75), math.rad(0), math.rad(45))}):Play()
			ts(objs[2],TweenInfo.new(0.1),{C1 = CFrame.new(-1.25, 1.75, -1.25) * CFrame.Angles(math.rad(-120), math.rad(0), math.rad(40))}):Play()
			wait(.1)
			--ts(objs[2],TweenInfo.new(0.15),{C1 = CFrame.new(-.65, 1.75, -1.25) * CFrame.Angles(math.rad(-120), math.rad(0), math.rad(40))}):Play()
			ts(objs[2],TweenInfo.new(0.15),{C1 = CFrame.new(0, .5, -2) * CFrame.Angles(math.rad(-75), math.rad(0), math.rad(45))}):Play()
			wait(.2)--0.2
			ts(objs[2],TweenInfo.new(0.3),{C1 = objs[8].RightArmPos}):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = objs[8].LeftArmPos}):Play()
		end
	end;
	
}

return module
