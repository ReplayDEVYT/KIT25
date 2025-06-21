local ts = require(game.ReplicatedStorage.TService)
local player = game:GetService("Players").LocalPlayer
local maxuses = 5
Warp = require(game:GetService("ReplicatedStorage").Warp)

EffectsReplicationClient = {
	MetabolismClient = Warp.Client("Metabolism")
}

EffectsReplicationClient.MetabolismClient:Fire(true, script.Energy.Value, script.Hydration.Value)
print("sent to server")
local module = {

--//Client Animations
		IdleAnim = function(char, speed, objs)
			ts(objs[2],TweenInfo.new(0.3),{C1 = require(script.Parent.Settings).RightPos}):Play() -- require(script).FakeRightPos (For fake arms) | require(script).RightArmPos (For real arms)
			ts(objs[3],TweenInfo.new(0.3),{C1 = require(script.Parent.Settings).LeftPos}):Play() -- require(script).FakeLeftPos (For fake arms) | require(script).LeftArmPos (For real arms)	
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
	FiremodeAnim = function(char, speed, objs)
		ts(objs[3],TweenInfo.new(0.25),{C1 = require(script.Parent.Settings).LeftPos}):Play()
		ts(objs[2],TweenInfo.new(0.25),{C1 = require(script.Parent.Settings).RightPos * CFrame.new(0.1, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-10))}):Play()
		wait(0.25)
		ts(objs[3],TweenInfo.new(0.15),{C1 = require(script.Parent.Settings).LeftPos}):Play()
		ts(objs[2],TweenInfo.new(0.15),{C1 = require(script.Parent.Settings).RightPos}):Play() 
		wait(0.15)
	end;
	ChamberAnim = function(char, speed, objs)
		if maxuses > 0 then
		script.Parent.Parent.Parent.Parent:FindFirstChild('S'..objs[5].Name).Grip:WaitForChild("Eat"):Play()
		ts(objs[2],TweenInfo.new(0.5),{C1 = require(script.Parent.Settings).RightPos * CFrame.new(0.1, 0, 0) * CFrame.Angles(math.rad(-15), math.rad(0), math.rad(-20))}):Play()
		ts(objs[3],TweenInfo.new(0.45),{C1 = CFrame.new(0.15,0.1,-1.2) * CFrame.Angles(math.rad(-120),math.rad(15),math.rad(15))}):Play()
		wait(.35)
			ts(objs[3],TweenInfo.new(0.5),{C1 = CFrame.new(0,-1.35,-1.5) * CFrame.Angles(math.rad(-180),math.rad(35),math.rad(20))}):Play()
			objs[5].Opened.Transparency = 0
			objs[5].Closed.Transparency = 1
			wait(.35)
		ts(objs[3],TweenInfo.new(0.45),{C1 = CFrame.new(0.15,0.1,-1.2) * CFrame.Angles(math.rad(-120),math.rad(15),math.rad(15))}):Play()
		wait(.35)
		ts(objs[3],TweenInfo.new(0.45),{C1 = CFrame.new(0.15,0.1,-1.2) * CFrame.Angles(math.rad(-120),math.rad(15),math.rad(15))}):Play()
		wait(.35)
		ts(objs[3],TweenInfo.new(.75),{C1 = CFrame.new(-1,-0.65,-2) * CFrame.Angles(math.rad(-75),math.rad(55),math.rad(30))}):Play()
		wait(.6)
		ts(objs[3],TweenInfo.new(.7),{C1 = CFrame.new(0.15,0.1,-1.2) * CFrame.Angles(math.rad(-120),math.rad(15),math.rad(15))}):Play()
		wait(1.05)
		ts(objs[3],TweenInfo.new(.75),{C1 = CFrame.new(-1,-0.65,-2) * CFrame.Angles(math.rad(-75),math.rad(55),math.rad(30))}):Play()
		wait(.6)
		ts(objs[3],TweenInfo.new(.7),{C1 = CFrame.new(0.15,0.1,-1.2) * CFrame.Angles(math.rad(-120),math.rad(15),math.rad(15))}):Play()
		wait(1.05)
		ts(objs[3],TweenInfo.new(.75),{C1 = CFrame.new(-1,-0.65,-2) * CFrame.Angles(math.rad(-75),math.rad(55),math.rad(30))}):Play()
		wait(.6)
		ts(objs[3],TweenInfo.new(.7),{C1 = CFrame.new(0.15,0.1,-1.2) * CFrame.Angles(math.rad(-120),math.rad(15),math.rad(15))}):Play()	
			wait(0.3)
			objs[5].Opened.Transparency = 1
			objs[5].Closed.Transparency = 0
		if player.HungerVal then
				local value = player.HungerVal.Value
			if player.HungerVal.Value + 25 >= 100 then
				player.HungerVal.Value = 100
				print(value)
				print("set to 100")
			else
				player.HungerVal.Value = player.HungerVal.Value + 25
				print(player.HungerVal.Value)
				print("added")
			end
			end
			maxuses = maxuses - 1
			wait(0.1)
			print(maxuses)
		else
			player.Character.Humanoid:UnequipTools()
			script.Parent.Parent.Parent:Destroy()
			end
			
		end;

		ChamberBKAnim = function(char, speed, objs)
			ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(-0.875, -0.465, -1.15) * CFrame.Angles(math.rad(-95), math.rad(-2), math.rad(7.5))}):Play()
			ts(objs[3],TweenInfo.new(0.25),{C1 = CFrame.new(-1.5,-0.7,-2) * CFrame.Angles(math.rad(-180),math.rad(15),math.rad(45))}):Play()
			wait(0.3)	
			objs[5].Bolt:WaitForChild("SlideRelease"):Play()
			ts(objs[3],TweenInfo.new(0.35),{C1 = CFrame.new(-0.2,-0.7,-3) * CFrame.Angles(math.rad(-180),math.rad(15),math.rad(45))}):Play()
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
			ts(MagCW,TweenInfo.new(0),{C0 = CFrame.new(0.21, -0.4, -0.75) * CFrame.Angles(math.rad(90), math.rad(0), math.rad(180))}):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(-0.4,0.275,-2.5) * CFrame.Angles(math.rad(-120),math.rad(0),math.rad(7.5))}):Play()
			objs[5].Handle:WaitForChild("MagOut"):Play()
			wait(0.3)
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(0.15,0.475,-1.5) * CFrame.Angles(math.rad(-100),math.rad(0),math.rad(0))}):Play()
			wait(1.5)
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(-0.4,0.275,-2.5) * CFrame.Angles(math.rad(-120),math.rad(0),math.rad(7.5))}):Play()
			wait(0.3)
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(-0.5,0.475,-1.8) * CFrame.Angles(math.rad(-100),math.rad(0),math.rad(7.5))}):Play()
			objs[5].Handle:WaitForChild("MagIn"):Play()
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

			ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(-0.875, 0, -1.2) * CFrame.Angles(math.rad(-100), math.rad(-2), math.rad(7.5))}):Play()
			ts(objs[3],TweenInfo.new(0.5),{C1 = CFrame.new(1.195,1.4,-0.5) * CFrame.Angles(math.rad(0),math.rad(25),math.rad(0))}):Play()
			wait(.5)	
			objs[5].Handle:WaitForChild("MagGrab"):Play()
			local MagC = objs[5]:WaitForChild("Mag"):clone()
				MagC.Parent = workspace.CurrentCamera
				MagC.Name = "MagC"
				MagC.Transparency = 0			

			local MagCW = Instance.new("Motor6D")
				MagCW.Part0 = MagC
				MagCW.Part1 = objs[3].Parent.Parent:WaitForChild("Left Arm")
				MagCW.Parent = MagC
				MagCW.C1 = MagC.CFrame:toObjectSpace(objs[3].Parent.Parent:WaitForChild("Left Arm").CFrame)
			ts(MagCW,TweenInfo.new(0),{C0 = CFrame.new(0.21, -0.4, -0.75) * CFrame.Angles(math.rad(90), math.rad(0), math.rad(180))}):Play()
			
			ts(objs[3],TweenInfo.new(0.35),{C1 = CFrame.new(-0.85,0.475,-1) * CFrame.Angles(math.rad(-110),math.rad(0),math.rad(75))}):Play()
			
			wait(0.3)

			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(-0.85,1,-1) * CFrame.Angles(math.rad(-110),math.rad(0),math.rad(75))}):Play()

			local MagZ = objs[5]:WaitForChild("Mag"):clone()
				objs[5].Mag.Transparency = 1
				MagZ.Parent = workspace.CurrentCamera
				MagZ.Name = "MagZ"
				MagZ.Transparency = 0
				MagZ.Anchored = false
				MagZ.CanCollide = true
				MagZ:ClearAllChildren()
				MagZ.RotVelocity = Vector3.new(0,25,0)
				MagZ.Velocity = (MagZ.CFrame.LookVector * -15) + (MagZ.CFrame.RightVector * 5) + Vector3.new(0,25,0)


			objs[5].Mag.Transparency = 1
			objs[5].Handle:WaitForChild("MagOut"):Play()
			
			

			wait(0.3)				
			objs[5].Handle:WaitForChild("MagDrop"):Play()
			
			ts(objs[2],TweenInfo.new(0.5),{C1 = CFrame.new(-0.875, 0, -1.35) * CFrame.Angles(math.rad(-105), math.rad(-2), math.rad(7.5))}):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(-0.4,0.475,-2) * CFrame.Angles(math.rad(-110),math.rad(0),math.rad(7.5))}):Play()
			wait(0.5)
			ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(-0.875, 0, -1.2) * CFrame.Angles(math.rad(-100), math.rad(-2), math.rad(7.5))}):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(-0.5,0.475,-1.6) * CFrame.Angles(math.rad(-100),math.rad(0),math.rad(7.5))}):Play()
			objs[5].Handle:WaitForChild("MagIn"):Play()
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
		else
			objs[4].Part1 = objs[5].Handle
			ts(objs[3],TweenInfo.new(0.6),{C1 = CFrame.new(1.195,1.4,-0.5) * CFrame.Angles(math.rad(0),math.rad(25),math.rad(0))}):Play()
			wait(0.3)
			local MagA = objs[5]:WaitForChild("Mag"):clone()
				MagA.Parent = workspace.CurrentCamera
				MagA.Name = "MagA"
				MagA.Transparency = 0			
				objs[5].Handle:WaitForChild("MagGrab"):Play()
			local MagAW = Instance.new("Motor6D")
				MagAW.Part0 = MagA
				MagAW.Part1 = objs[3].Parent.Parent:WaitForChild("Left Arm")
				MagAW.Parent = MagA
				MagAW.C1 = MagA.CFrame:toObjectSpace(objs[3].Parent.Parent:WaitForChild("Left Arm").CFrame)

			ts(MagAW,TweenInfo.new(0),{C0 = CFrame.new(0, 0.5, -0.8) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))}):Play()
			ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(-0.875, 0, -1.15) * CFrame.Angles(math.rad(-95), math.rad(-2), math.rad(7.5))}):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(-0.5,0.475,-1.8) * CFrame.Angles(math.rad(-100),math.rad(0),math.rad(7.5))}):Play()
			wait(0.5)	
			objs[5].Mag.Transparency = 1
			objs[5].Handle:WaitForChild("MagOut"):Play()
			
			local MagC = objs[5]:WaitForChild("Mag"):clone()
				MagC.Parent = workspace.CurrentCamera
				MagC.Name = "MagC"
				MagC.Transparency = 0			

			local MagCW = Instance.new("Motor6D")
				MagCW.Part0 = MagC
				MagCW.Part1 = objs[3].Parent.Parent:WaitForChild("Left Arm")
				MagCW.Parent = MagC
				MagCW.C1 = MagC.CFrame:toObjectSpace(objs[3].Parent.Parent:WaitForChild("Left Arm").CFrame)

			ts(MagCW,TweenInfo.new(0),{C0 = CFrame.new(-0.2, 0.2, -0.75) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))}):Play()
			ts(objs[2],TweenInfo.new(0.5),{C1 = CFrame.new(-0.875, 0, -1.35) * CFrame.Angles(math.rad(-100), math.rad(-2), math.rad(7.5))}):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(-0.4,0.375,-2.2) * CFrame.Angles(math.rad(-120),math.rad(0),math.rad(7.5))}):Play()
			wait(0.3)							
			
			ts(objs[2],TweenInfo.new(0.4),{C1 = CFrame.new(-0.875, 0, -1.15) * CFrame.Angles(math.rad(-95), math.rad(-2), math.rad(7.5))}):Play()
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(-0.7,0.475,-2.5) * CFrame.Angles(math.rad(-120),math.rad(0),math.rad(7.5))}):Play()
			wait(0.3)
			ts(objs[3],TweenInfo.new(0.3),{C1 = CFrame.new(-0.7,0.875,-1.8) * CFrame.Angles(math.rad(-100),math.rad(0),math.rad(7.5))}):Play()
			ts(objs[2],TweenInfo.new(0.3),{C1 = CFrame.new(-0.875, 0, -1.125) * CFrame.Angles(math.rad(-95), math.rad(-2), math.rad(7.5))}):Play()
			objs[5].Handle:WaitForChild("MagIn"):Play()
			MagA:Destroy()
			objs[5].Mag.Transparency = 0
			wait(0.3)
			ts(objs[3],TweenInfo.new(0.6),{C1 = CFrame.new(1.195,1.4,-0.5) * CFrame.Angles(math.rad(0),math.rad(25),math.rad(0))}):Play()
			MagC:Destroy()	

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
