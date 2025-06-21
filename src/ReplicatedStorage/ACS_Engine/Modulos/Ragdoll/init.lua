return function(char)
	local faces = {
		"rbxassetid://1477688751",
		"rbxassetid://1972707642",
		"rbxassetid://1477688751",
		"rbxassetid://476060645",
		"rbxassetid://1403453868",
	}
	local blood = game.ReplicatedStorage.ACS_Engine.MaterialHit.EntryBlood:GetChildren()
	local DeathSounds = {"4946899509";"4946900085";"4530992331";"4530994702";"1489926028"; "1489926696"; "3372006703"; "3372003797"; "3371973237"; "6108616307"; "6108618493"; "6108618184";}
	local HFTFJotaro = "rbxassetid://4946899509"
	local CSGO = "rbxassetid://2865870544"
	local HL2 = "rbxassetid://1602011701"
	local randomizer = math.random(1,100)
	local DeathSFX = "rbxassetid://"..DeathSounds[math.random(#DeathSounds)]
	local root =char:FindFirstChild("HumanoidRootPart")
	if root ~= nil then
		root:Destroy()
	end
	local function getAttachment0(attachmentName, char)
		for _,child in next,char:GetChildren() do
			local attachment = child:FindFirstChild(attachmentName)
			if attachment then
				return attachment
			end
		end
	end
	for _,v in pairs(char:GetChildren()) do
		if v:FindFirstChild('KeepOnDeath') and v:IsA("Model") and char:FindFirstChildWhichIsA("Tool") and char:FindFirstChildWhichIsA("Tool"):FindFirstChild("ACS_Modulo") then
			local Clicker = Instance.new("ClickDetector")
			local Giverscript = script.Giver:Clone()
			Clicker.Parent = v
			Clicker.MaxActivationDistance = 5
			v.Grip.Arma.Enabled = true
			v.Grip.Arma.Text.Text = "[MOUSE1] PICK UP "..char:FindFirstChildWhichIsA("Tool").Name
			v.Parent = workspace
			Giverscript.Parent = v
			char:FindFirstChildWhichIsA("Tool").Parent = v
			v.Giver.Disabled = false
			for i,v in pairs(v.Grip:GetChildren()) do
				if v:IsA("Sound") then
					v:Stop()
				end
			end
			local wl = Instance.new('WeldConstraint')
			wl.Part1 = char['Right Arm']
			wl.Part0 = v.Grip
			wl.Parent = v.Grip
			--local ran_num = math.random(100,200) / 100
			--game.Debris:AddItem(wl,ran_num) --default is 1
			for _,v2 in pairs(v:GetDescendants()) do
				if v2:IsA('BasePart') then
					if v2:FindFirstChild("NoWeld") == nil then
						local wl = Instance.new('WeldConstraint')
						wl.Part1 = v2
						wl.Part0 = v.Grip
						wl.Parent = v.Grip
					end
					v2.CanCollide = true
					v2:GetPropertyChangedSignal('CanCollide'):Connect(function()
						v2.CanCollide = true
					end)
					--v2.CollisionGroupId = id
				end
			end
			game.Debris:AddItem(v,120)

		end
		if v:FindFirstChild('KeepOnDeath') and v:IsA("Model") and not char:FindFirstChildWhichIsA("Tool") then
			game.Debris:AddItem(v,0)			
		end
	end 
	local Torso = char:FindFirstChild("Torso")
	local Head = char:FindFirstChild("Head")
	local rarm = char:FindFirstChild("Right Arm")
	local larm = char:FindFirstChild("Left Arm")
	local rleg = char:FindFirstChild("Right Leg")
	local lleg = char:FindFirstChild("Left Leg")
	if char.Saude:WaitForChild('Variaveis').ShotLimb.Value ~= "Head" or (Head:FindFirstChild("HP") == nil and Head:FindFirstChild("DeathSound") == nil) then
		local sound = Instance.new("Sound")
		sound.Parent = Head
		sound.Name = "DeathSound"

		local Player = game.Players[char.Name]
		local Team = Player.Team
		local RS2 = game:GetService("ReplicatedStorage")
		local line

		if Team == game.Teams.USEC then
			print("team is usec, agony for usec")
			local sounds = RS2.UsecVoicelines.Agony:GetChildren()
			if #sounds > 0 then
				local randSound = sounds[math.random(#sounds)]
				line = randSound
				print(line)
			end
		elseif Team == game.Teams.BEAR then
			print("team is bear, agony for bear")
			local sounds = RS2.BearVoicelines.Agony:GetChildren()
			if #sounds > 0 then
				local randSound = sounds[math.random(#sounds)]
				line = randSound
				print(line)
			end
		elseif Team == game.Teams.SCAV then
			print("team is scav, agony for scav")
			local sounds = RS2.ScavVoicelines.Agony:GetChildren()
			if #sounds > 0 then
				local randSound = sounds[math.random(#sounds)]
				line = randSound
				print(line)
		else
			end
			print("player somehow has no team, saying scav line")
			local sounds = RS2.ScavVoicelines.Agony:GetChildren()
			if #sounds > 0 then
				local randSound = sounds[math.random(#sounds)]
				line = randSound
				print(line)
			end
		end

		sound.SoundId = line.SoundId
	--[[if randomizer ~= 69 and randomizer ~= 42 then
		
	elseif randomizer == 69 then
		sound.SoundId = HFTFJotaro
	elseif randomizer == 42 then
		sound.SoundId = CSGO
	elseif randomizer == 50 then
		sound.SoundId = HL2
		end]]--
		sound.MaxDistance = 150
		sound.Volume = 1
		Head:AddTag("3DSoundEmitter")
		if Head.Transparency < 1 then
			sound:Play()
		end
	end
	if char:FindFirstChild("AnimBase") then
		char:FindFirstChild("AnimBase"):Destroy()
	end
	Head.face.Texture = faces[math.random(#faces)]
	if Head:FindFirstChild("HP") and Head:FindFirstChild("HP").Value <= 0 and Head.Transparency < 1 then
		local trol = blood[math.random(#blood)]:Clone()
		trol.Parent = Head
		trol.Face = "Front"
	end
end
