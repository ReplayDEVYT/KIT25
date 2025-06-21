--[[workspace.DescendantAdded:Connect(function(v)
	if v:IsA('Sound') and v.Name == 'Running' then
		v:GetPropertyChangedSignal('Volume'):Connect(function()
			v.Volume = 0
		end)
		v.Volume = 0
	end
end)]]--
local UserInputService = game:GetService("UserInputService")

local Warp = require(game:GetService("ReplicatedStorage").Warp);


-- events
local ReplicationFootstepC = {
	Play = Warp.Client("PlayFootstep")
}

--[[for _,v in pairs(workspace:GetDescendants()) do
	if v:IsA('Sound') and v.Name == 'Running' then
		v:GetPropertyChangedSignal('Volume'):Connect(function()
			v.Volume = 0
		end)
		v.Volume = 0
	end
end]]--

local soundsFolder = script.Mats
local runFolder = script.Running
local jumpFolder = script.Jump
local landFolder = script.Land
local gearSounds = script.Gear
local proneSoundsFolder = script.Prone
local gear2 = gearSounds:GetChildren()
local gearFast = script.FastGear:GetChildren()

--[[for i,v in pairs(soundsFolder:GetChildren()) do
	for _,v2 in pairs(v:GetChildren()) do
		local s = Instance.new('Sound')
		s.SoundId = v2.SoundId
		s.Volume = v2.Volume

		game:GetService('ContentProvider'):PreloadAsync({s})
	end
end

for i,v in pairs(runFolder:GetChildren()) do
	for _,v2 in pairs(v:GetChildren()) do
		local s = Instance.new('Sound')
		s.SoundId = v2.SoundId
		s.Volume = v2.Volume

		game:GetService('ContentProvider'):PreloadAsync({s})
	end
end
for i,v in pairs(jumpFolder:GetChildren()) do
	for _,v2 in pairs(v:GetChildren()) do
		local s = Instance.new('Sound')
		s.SoundId = v2.SoundId
		s.Volume = v2.Volume

		game:GetService('ContentProvider'):PreloadAsync({s})
	end
end
for i,v in pairs(landFolder:GetChildren()) do
	for _,v2 in pairs(v:GetChildren()) do
		local s = Instance.new('Sound')
		s.SoundId = v2.SoundId
		s.Volume = v2.Volume

		game:GetService('ContentProvider'):PreloadAsync({s})
	end
end
for i,v in pairs(gearSounds:GetChildren()) do
	for _,v2 in pairs(v:GetChildren()) do
		local s = Instance.new('Sound')
		s.SoundId = v2.SoundId
		s.Volume = v2.Volume

		game:GetService('ContentProvider'):PreloadAsync({s})
	end
end]]--

local toLoad = {}
for i,v in pairs(script:GetDescendants()) do
	if v:IsA("Sound") then
		table.insert(toLoad,v)
	end
end
--game:GetService('ContentProvider'):PreloadAsync(toLoad)

local default = soundsFolder.Default
local default2 = jumpFolder.Default
local default3 = landFolder.Default

local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")

plr.CharacterAdded:Connect(function(c)
	char = c
	humanoid = char:WaitForChild("Humanoid")

	char.Humanoid.StateChanged:Connect(function(old,new)
		local mat = char.Humanoid.FloorMaterial
		if not char['Torso']:FindFirstChild("land") and (old == Enum.HumanoidStateType.Freefall and new == Enum.HumanoidStateType.Landed or humanoid:GetState() == Enum.HumanoidStateType.Landed or new == Enum.HumanoidStateType.Landed) and mat ~= Enum.Material.Air then
			if landFolder:FindFirstChild(string.sub(tostring(mat), string.len('Enum.Material.')+1)) then
				use = landFolder[string.sub(tostring(mat), string.len('Enum.Material.')+1)]:GetChildren()
			else
				use = default3:GetChildren()
			end
			local s = use[math.random(#use)]
			local sound = s:Clone()
			sound.Name = "land"
			rightLeg = not rightLeg
			sound.Parent = char['Torso']
			sound:Play()

			ReplicationFootstepC.Play:Fire(true,s.SoundId,s.Volume, stamp, sound.Parent, sound.MaxDistance)
			game.Debris:AddItem(sound,sound.TimeLength+1)
		end
	end)
	
end)

local rightLeg = false
local function cwait(timeamount)
	timeamount = timeamount or 0
	local tc = 0
	repeat
		local c = game:GetService('RunService').RenderStepped:Wait()
		tc = tc+c
	until
	tc >= timeamount
	return tc
end
ReplicationFootstepC.Play:Connect(function(id,volume,timestamp,parent,maxDistance)
	--print('Gotten with info {' .. tostring(id) .. ', ' .. tostring(volume) .. ', ' .. tostring(timestamp and 't1: ' .. timestamp[1] .. 't2: ' .. timestamp[2]) .. ', ' .. tostring(parent and parent:GetFullName()) .. '}')
	if id and volume and timestamp and parent then
		--print('all there')
		local s = Instance.new('Sound',parent)
		s.Name = 'footstep'
		s.Volume = volume
		s.SoundId = id
		s.TimePosition = 0
		if not parent:HasTag("3DSoundEmitter") then
			parent:AddTag("3DSoundEmitter")
		end
		s.SoundGroup = game.SoundService.All.Character
		s:Play()
		s.MaxDistance = maxDistance*1.65
		s.RollOffMinDistance = 17
		game.Debris:AddItem(s,s.TimeLength+1)
	
		
	end
end)

UserInputService.JumpRequest:Connect(function()
	local mat = char.Humanoid.FloorMaterial
	if humanoid:GetState() == Enum.HumanoidStateType.Jumping and mat ~= Enum.Material.Air then
		if jumpFolder:FindFirstChild(string.sub(tostring(mat), string.len('Enum.Material.')+1)) then
			use = jumpFolder[string.sub(tostring(mat), string.len('Enum.Material.')+1)]:GetChildren()
		else
			use = default2:GetChildren()
		end
		local num = math.random(1,6)
		char.Torso["P"..num]:Play()
		local s = use[math.random(#use)]
		local sound = s:Clone()
		sound.Name = "jumpy"
		rightLeg = not rightLeg
		sound.Parent = char['Torso']
		sound.SoundGroup = game.SoundService.All.Character
		sound:Play()

		ReplicationFootstepC.Play:Fire(true,s.SoundId,s.Volume, stamp, sound.Parent, sound.MaxDistance)
		game.Debris:AddItem(sound,sound.TimeLength+1)

	end
end)

char.Humanoid.StateChanged:Connect(function(old,new)
	local mat = char.Humanoid.FloorMaterial
	if not char['Torso']:FindFirstChild("land") and (old == Enum.HumanoidStateType.Freefall and new == Enum.HumanoidStateType.Landed or humanoid:GetState() == Enum.HumanoidStateType.Landed or new == Enum.HumanoidStateType.Landed) and mat ~= Enum.Material.Air then
		if landFolder:FindFirstChild(string.sub(tostring(mat), string.len('Enum.Material.')+1)) then
			use = landFolder[string.sub(tostring(mat), string.len('Enum.Material.')+1)]:GetChildren()
		else
			use = default3:GetChildren()
		end
		local s = use[math.random(#use)]
		local sound = s:Clone()
		sound.Name = "land"
		rightLeg = not rightLeg
		sound.Parent = char['Torso']
		sound.SoundGroup = game.SoundService.All.Character
		sound:Play()

		ReplicationFootstepC.Play:Fire(true,s.SoundId,s.Volume, stamp, sound.Parent, sound.MaxDistance)
		game.Debris:AddItem(sound,sound.TimeLength+1)
	end
end)

while true do
	--print("run")
	char = plr.Character
	--print(char.Humanoid.MoveDirection.Magnitude)
	if (char and char:FindFirstChild('Humanoid') and char.Humanoid.MoveDirection.Magnitude > 0 and char:FindFirstChild('Torso') and char:FindFirstChild('Torso').Velocity.Magnitude >= 2.25 and char.Humanoid.WalkSpeed > 0 and char.Humanoid.Health > 0) then
		if char:FindFirstChild("Saude").Stances.Stance.Value ~= 2 then
			humanoid = char:FindFirstChild("Humanoid")
			local mat = char.Humanoid.FloorMaterial
			if mat ~= Enum.Material.Air then

				if soundsFolder:FindFirstChild(mat.Name) then
					use = soundsFolder[mat.Name]:GetChildren()
					if char.Saude.Stances.Correndo.Value == true then
						use2 = runFolder[mat.Name]:GetChildren()
					end
				else
					use = default:GetChildren()
				end

				--local use = soundsFolder[string.sub(tostring(mat), string.len('Enum.Material.')+1)]:GetChildren() or default:GetChildren()

				local s = use[math.random(#use)]
				local s2
				if use2 and char.Saude.Stances.Correndo.Value == true then
					s2 = use2[math.random(#use2)]
				end
				local sound = s:Clone()
				sound.Name = "footstepC"
				--print(sound.Name)
				local sound2
				if s2 ~= nil and char.Saude.Stances.Correndo.Value == true then
					sound2 = s2:Clone()
					sound2.Name = "footstepR"
				end
				if char.Saude.Stances.Correndo.Value == true then
					sound.Volume = 0
					sound.MaxDistance = 600
					if sound2 ~= nil then
						sound2.Volume = sound2.Volume + 1
						sound2.MaxDistance = 600
					end
				elseif char.Humanoid.WalkSpeed > 4 then
					sound.Volume = sound.Volume
					sound.MaxDistance = 350
				elseif char.Humanoid.WalkSpeed <= 4 and char.Humanoid.WalkSpeed > 0 then
					sound.Volume = sound.Volume / 2 
					sound.MaxDistance = 50 
				end
				rightLeg = not rightLeg
				if rightLeg then
					sound.Parent = char['Right Leg']
					if sound2 ~= nil then
						sound2.Parent = char['Right Leg']
					end
				else
					sound.Parent = char['Left Leg']
					if sound2 ~= nil then
						sound2.Parent = char['Left Leg']
					end
				end
				--print(sound.Parent.Name)
				sound.SoundGroup = game.SoundService.All.Character
				sound:Play()
				if sound2 ~= nil then
					sound2.SoundGroup = game.SoundService.All.Character
					sound2:Play()
				end

				--use = gear2
				local gears

				if s2 ~= nil and char.Saude.Stances.Correndo.Value == true then
					gears = gearFast[math.random(#gearFast)]
				else
					gears = gear2[math.random(#gear2)]
				end

				local gearsfx = gears:Clone()
				gearsfx.Name = "gearsound"
				gearsfx.Parent = char['Torso']
				if char.Saude.Stances.Correndo.Value == true then
					gearsfx.Volume = 0.6
					gearsfx.MaxDistance = 500
				elseif char.Humanoid.WalkSpeed > 4 then
					gearsfx.Volume = 0.5
					gearsfx.MaxDistance = 100
				elseif char.Humanoid.WalkSpeed <= 4 and char.Humanoid.WalkSpeed > 0 then
					gearsfx.Volume = 0.05
					gearsfx.MaxDistance = 50
				end
				gearsfx.SoundGroup = game.SoundService.All.Character
				gearsfx:Play()

				ReplicationFootstepC.Play:Fire(true,gearsfx.SoundId,gearsfx.Volume, stamp, gearsfx.Parent, gearsfx.MaxDistance)
				game.Debris:AddItem(gearsfx,gearsfx.TimeLength+1)


				stamp = {}
				if char.Saude.Stances.Correndo.Value == true and sound2 ~= nil then
					ReplicationFootstepC.Play:Fire(true,sound2.SoundId,sound2.Volume, stamp, sound2.Parent, sound2.MaxDistance)
				end
				ReplicationFootstepC.Play:Fire(true,sound.SoundId,sound.Volume, stamp, sound.Parent, sound.MaxDistance)
				--ReplicationFootstepC.Play:Fire(true,s.SoundId,s.Volume, stamp, sound.Parent, sound.MaxDistance)
				game.Debris:AddItem(sound,sound.TimeLength+1)
				if sound2 ~= nil then
					game.Debris:AddItem(sound2,sound2.TimeLength+1)
				end
				--		local waitTimeLeft = 0--(1/(char.Humanoid.WalkSpeed/16))*1
				--		repeat
				--			local add = game:GetService('RunService').RenderStepped:Wait()
				--			waitTimeLeft = waitTimeLeft+(add*(char.Humanoid.WalkSpeed/16))
				--		until
				--			waitTimeLeft >= .3
				cwait((((1/60)*18)/(char.Humanoid.WalkSpeed/14.25))*1.25)
				--task.wait((((1/60)*18)/(char.Humanoid.WalkSpeed/14.25))*1.25)
			else
				game:GetService('RunService').RenderStepped:Wait()
			end
		elseif char:FindFirstChild("Saude").Stances.Stance.Value == 2 then
			print("prone sound")
			humanoid = char:FindFirstChild("Humanoid")
			local mat = char.Humanoid.FloorMaterial
			if mat ~= Enum.Material.Air then
				if mat == Enum.Material.Grass or Enum.Material.LeafyGrass then
					if proneSoundsFolder:FindFirstChild("Grass") then
						use = proneSoundsFolder.Grass:GetChildren()
						if char.Saude.Stances.Correndo.Value == true then
							use2 = runFolder[mat.Name]:GetChildren()
						end
					end
				else
					if proneSoundsFolder:FindFirstChild("Conc") then
						use = proneSoundsFolder.Conc:GetChildren()
						if char.Saude.Stances.Correndo.Value == true then
							use2 = runFolder[mat.Name]:GetChildren()
						end
					end
				end

				--local use = soundsFolder[string.sub(tostring(mat), string.len('Enum.Material.')+1)]:GetChildren() or default:GetChildren()

				local s = use[math.random(#use)]
				local s2
				if use2 and char.Saude.Stances.Correndo.Value == true then
					s2 = use2[math.random(#use2)]
				end
				local sound = s:Clone()
				sound.Name = "footstepC"
				--print(sound.Name)
				local sound2
				if s2 ~= nil and char.Saude.Stances.Correndo.Value == true then
					sound2 = s2:Clone()
					sound2.Name = "footstepR"
				end
				if char.Saude.Stances.Correndo.Value == true then
					sound.Volume = 0.1
					sound.MaxDistance = 600
					if sound2 ~= nil then
						sound2.Volume = 3
						sound2.MaxDistance = 600
					end
				elseif char.Humanoid.WalkSpeed > 4 then
					sound.Volume = 3
					sound.MaxDistance = 350
				elseif char.Humanoid.WalkSpeed <= 4 and char.Humanoid.WalkSpeed > 0 then
					sound.Volume = 1.25 
					sound.MaxDistance = 50 
				end
				rightLeg = not rightLeg
				if rightLeg then
					sound.Parent = char['Right Leg']
					if sound2 ~= nil then
						sound2.Parent = char['Right Leg']
					end
				else
					sound.Parent = char['Left Leg']
					if sound2 ~= nil then
						sound2.Parent = char['Left Leg']
					end
				end
				--print(sound.Parent.Name)
				sound.SoundGroup = game.SoundService.All.Character
				sound:Play()
				if sound2 ~= nil then
					sound2.SoundGroup = game.SoundService.All.Character
					sound2:Play()
				end

				--use = gear2
				local gears

				if s2 ~= nil and char.Saude.Stances.Correndo.Value == true then
					gears = gearFast[math.random(#gearFast)]
				else
					gears = gear2[math.random(#gear2)]
				end

				local gearsfx = gears:Clone()
				gearsfx.Name = "gearsound"
				gearsfx.Parent = char['Torso']
				if char.Saude.Stances.Correndo.Value == true then
					gearsfx.Volume = 0.6
					gearsfx.MaxDistance = 500
				elseif char.Humanoid.WalkSpeed > 4 then
					gearsfx.Volume = 0.5
					gearsfx.MaxDistance = 100
				elseif char.Humanoid.WalkSpeed <= 4 and char.Humanoid.WalkSpeed > 0 then
					gearsfx.Volume = 0.5
					gearsfx.MaxDistance = 50
				end
				gearsfx.SoundGroup = game.SoundService.All.Character
				gearsfx:Play()

				ReplicationFootstepC.Play:Fire(true,gearsfx.SoundId,gearsfx.Volume, stamp, gearsfx.Parent, gearsfx.MaxDistance)
				game.Debris:AddItem(gearsfx,gearsfx.TimeLength+1)


				stamp = {}
				if char.Saude.Stances.Correndo.Value == true and sound2 ~= nil then
					ReplicationFootstepC.Play:Fire(true,sound2.SoundId,sound2.Volume, stamp, sound2.Parent, sound2.MaxDistance)
				end
				ReplicationFootstepC.Play:Fire(true,sound.SoundId,sound.Volume, stamp, sound.Parent, sound.MaxDistance)
				--ReplicationFootstepC.Play:Fire(true,s.SoundId,s.Volume, stamp, sound.Parent, sound.MaxDistance)
				game.Debris:AddItem(sound,sound.TimeLength+1)
				if sound2 ~= nil then
					game.Debris:AddItem(sound2,sound2.TimeLength+1)
				end
				--		local waitTimeLeft = 0--(1/(char.Humanoid.WalkSpeed/16))*1
				--		repeat
				--			local add = game:GetService('RunService').RenderStepped:Wait()
				--			waitTimeLeft = waitTimeLeft+(add*(char.Humanoid.WalkSpeed/16))
				--		until
				--			waitTimeLeft >= .3
				cwait((((1/60)*18)/(char.Humanoid.WalkSpeed/14.25))*1.25)
				--task.wait((((1/60)*18)/(char.Humanoid.WalkSpeed/14.25))*1.25)
			else
				game:GetService('RunService').RenderStepped:Wait()
			end
		end
	else
		game:GetService('RunService').RenderStepped:Wait()
	end
end