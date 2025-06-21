-- Roblox character sound script

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local FootstepsSoundGroup = script:WaitForChild("Footsteps")
local DeathSounds = {"0"; "0";}
local SOUND_DATA = {
	Climbing = {
		SoundId = "rbxasset://sounds/action_footsteps_plastic.mp3",
		Looped = true,
	},
	Died = {
		SoundId = "rbxassetid://0",
	},
	FreeFalling = {
		SoundId = "rbxassetid://3053419536",
		Looped = true,
	},
	GettingUp = {
		SoundId = "rbxasset://sounds/action_get_up.mp3",
	},
	Jumping = {
		SoundId = "rbxasset://sounds/action_get_up.mp3",
	},
	Landing = {
		SoundId = "rbxassetid://3784889529",

	},
	Running = {
		SoundId = '' ,
		Looped = true,
		Playing = true,
		Pitch = 1,
	},
	Splash = {
		SoundId = "rbxasset://sounds/impact_water.mp3",
	},
	Swimming = {
		SoundId = "rbxasset://sounds/action_swim.mp3",
		Looped = true,
		Pitch = 1.6,
	},
}

 -- wait for the first of the passed signals to fire
local function waitForFirst(...)
	local shunt = Instance.new("BindableEvent")
	local slots = {...}

	local function fire(...)
		for i = 1, #slots do
			slots[i]:Disconnect()
		end

		return shunt:Fire(...)
	end

	for i = 1, #slots do
		slots[i] = slots[i]:Connect(fire)
	end

	return shunt.Event:Wait()
end

-- map a value from one range to another
local function map(x, inMin, inMax, outMin, outMax)
	return (x - inMin)*(outMax - outMin)/(inMax - inMin) + outMin
end

local function playSound(sound)
	sound.TimePosition = 0
	sound.Playing = true
end

local function stopSound(sound)
	sound.Playing = false
	sound.TimePosition = 0
end

local function initializeSoundSystem(player, humanoid, rootPart)
	local sounds = {}

	-- initialize sounds
	for name, props in pairs(SOUND_DATA) do
		local sound = Instance.new("Sound")
		sound.Name = name

		-- set default values
		sound.Archivable = false
		sound.EmitterSize = 5
		sound.MaxDistance = 150
		sound.Volume = 0.65

		for propName, propValue in pairs(props) do
			sound[propName] = propValue
		end

		sound.Parent = rootPart
		sounds[name] = sound
	end

	local playingLoopedSounds = {}

	local function stopPlayingLoopedSounds(except)
		for sound in pairs(playingLoopedSounds) do
			if sound ~= except then
				sound.Playing = false
				playingLoopedSounds[sound] = nil
			end
		end
	end

	-- state transition callbacks
	local stateTransitions = {
		[Enum.HumanoidStateType.FallingDown] = function()
			stopPlayingLoopedSounds()
		end,

		[Enum.HumanoidStateType.GettingUp] = function()
			stopPlayingLoopedSounds()
			playSound(sounds.GettingUp)
		end,

		[Enum.HumanoidStateType.Jumping] = function()
			stopPlayingLoopedSounds()
			playSound(sounds.Jumping)
		end,

		[Enum.HumanoidStateType.Swimming] = function()
			local verticalSpeed = math.abs(rootPart.Velocity.Y)
			if verticalSpeed > 0.1 then
				sounds.Splash.Volume = math.clamp(map(verticalSpeed, 100, 350, 0.28, 1), 0, 1)
				playSound(sounds.Splash)
			end
			stopPlayingLoopedSounds(sounds.Swimming)
			sounds.Swimming.Playing = true
			playingLoopedSounds[sounds.Swimming] = true
		end,

		[Enum.HumanoidStateType.Freefall] = function()
			sounds.FreeFalling.Volume = 0
			stopPlayingLoopedSounds(sounds.FreeFalling)
			playingLoopedSounds[sounds.FreeFalling] = true
		end,

		[Enum.HumanoidStateType.Landed] = function()
			stopPlayingLoopedSounds()
			local verticalSpeed = math.abs(rootPart.Velocity.Y)
			if verticalSpeed > 0.05 then
				sounds.Landing.Volume = math.clamp(map(verticalSpeed, 50, 100, 0, 1), 0, 1)
				playSound(sounds.Landing)
			end
		end,

		[Enum.HumanoidStateType.Running] = function()
			stopPlayingLoopedSounds(sounds.Running)
			sounds.Running.Playing = true
			playingLoopedSounds[sounds.Running] = true
		end,

		[Enum.HumanoidStateType.Climbing] = function()
			local sound = sounds.Climbing
			if math.abs(rootPart.Velocity.Y) > 0.1 then
				sound.Playing = true
				stopPlayingLoopedSounds(sound)
			else
				stopPlayingLoopedSounds()
			end
			playingLoopedSounds[sound] = true
		end,

		[Enum.HumanoidStateType.Seated] = function()
			stopPlayingLoopedSounds()
		end,

		[Enum.HumanoidStateType.Dead] = function()
			stopPlayingLoopedSounds()
			playSound(sounds.Died)
		end,
	}

	-- updaters for looped sounds
	local loopedSoundUpdaters = {
		[sounds.Climbing] = function(dt, sound, vel)
			sound.Playing = vel.Magnitude > 0.1
		end,

		[sounds.FreeFalling] = function(dt, sound, vel)
			if vel.Magnitude > 75 then
				sound.Volume = math.clamp(sound.Volume + 0.9*dt, 0, 1)
			else
				sound.Volume = 0
			end
		end,

		[sounds.Running] = function(dt, sound, vel)
			--sound.Playing = vel.Magnitude > 0.5 and humanoid.MoveDirection.Magnitude > 0.5

			--[[sound.SoundId = FootstepsSoundGroup:WaitForChild(humanoid.FloorMaterial).SoundId 
			sound.PlaybackSpeed = FootstepsSoundGroup:WaitForChild(humanoid.FloorMaterial).PlaybackSpeed * (vel.Magnitude/20)
			sound.Volume = FootstepsSoundGroup:WaitForChild(humanoid.FloorMaterial).Volume * (vel.Magnitude/12) * humanoid.Parent.Saude.Stances.Loudness.Value
			sound.EmitterSize = FootstepsSoundGroup:WaitForChild(humanoid.FloorMaterial).Volume * (vel.Magnitude/12) * 50 * humanoid.Parent.Saude.Stances.Loudness.Value

			if FootstepsSoundGroup:FindFirstChild(humanoid.FloorMaterial) == nil then
				sound.SoundId = FootstepsSoundGroup:WaitForChild("nil Sound").SoundId
				sound.PlaybackSpeed = FootstepsSoundGroup:WaitForChild("nil Sound").PlaybackSpeed
				sound.EmitterSize = FootstepsSoundGroup:WaitForChild("nil Sound").Volume
				sound.Volume = FootstepsSoundGroup:WaitForChild("nil Sound").Volume
			end]]--
		end,
	}

	-- state substitutions to avoid duplicating entries in the state table
	local stateRemap = {
		[Enum.HumanoidStateType.RunningNoPhysics] = Enum.HumanoidStateType.Running,
	}

	local activeState = stateRemap[humanoid:GetState()] or humanoid:GetState()
	local activeConnections = {}

	local stateChangedConn = humanoid.StateChanged:Connect(function(_, state)
		state = stateRemap[state] or state

		if state ~= activeState then
			local transitionFunc = stateTransitions[state]

			if transitionFunc then
				transitionFunc()
			end

			activeState = state
		end
	end)

	local steppedConn = RunService.Stepped:Connect(function(_, worldDt)
		-- update looped sounds on stepped
		for sound in pairs(playingLoopedSounds) do
			local updater = loopedSoundUpdaters[sound]

			if updater then
				updater(worldDt, sound, rootPart.Velocity)
			end
		end
	end)

	local humanoidAncestryChangedConn
	local rootPartAncestryChangedConn
	local characterAddedConn

	local function terminate()
		stateChangedConn:Disconnect()
		steppedConn:Disconnect()
		humanoidAncestryChangedConn:Disconnect()
		rootPartAncestryChangedConn:Disconnect()
		characterAddedConn:Disconnect()
	end

	humanoidAncestryChangedConn = humanoid.AncestryChanged:Connect(function(_, parent)
		if not parent then
			terminate()
		end
	end)

	rootPartAncestryChangedConn = rootPart.AncestryChanged:Connect(function(_, parent)
		if not parent then
			terminate()
		end
	end)

	characterAddedConn = player.CharacterAdded:Connect(terminate)
end

local function playerAdded(player)
	local function characterAdded(character)
		-- Avoiding memory leaks in the face of Character/Humanoid/RootPart lifetime has a few complications:
		-- * character deparenting is a Remove instead of a Destroy, so signals are not cleaned up automatically.
		-- ** must use a waitForFirst on everything and listen for hierarchy changes.
		-- * the character might not be in the dm by the time CharacterAdded fires
		-- ** constantly check consistency with player.Character and abort if CharacterAdded is fired again
		-- * Humanoid may not exist immediately, and by the time it's inserted the character might be deparented.
		-- * RootPart probably won't exist immediately.
		-- ** by the time RootPart is inserted and Humanoid.RootPart is set, the character or the humanoid might be deparented.

		if not character.Parent then
			waitForFirst(character.AncestryChanged, player.CharacterAdded)
		end

		if player.Character ~= character or not character.Parent then
			return
		end

		local humanoid = character:FindFirstChildOfClass("Humanoid")
		while character:IsDescendantOf(game) and not humanoid do
			waitForFirst(character.ChildAdded, character.AncestryChanged, player.CharacterAdded)
			humanoid = character:FindFirstChildOfClass("Humanoid")
		end

		if player.Character ~= character or not character:IsDescendantOf(game) then
			return
		end

		-- must rely on HumanoidRootPart naming because Humanoid.RootPart does not fire changed signals
		local rootPart = character:FindFirstChild("HumanoidRootPart")
		while character:IsDescendantOf(game) and not rootPart do
			waitForFirst(character.ChildAdded, character.AncestryChanged, humanoid.AncestryChanged, player.CharacterAdded)
			rootPart = character:FindFirstChild("HumanoidRootPart")
		end

		if rootPart and humanoid:IsDescendantOf(game) and character:IsDescendantOf(game) and player.Character == character then
			initializeSoundSystem(player, humanoid, rootPart)
		end
	end

	if player.Character then
		characterAdded(player.Character)
	end
	player.CharacterAdded:Connect(characterAdded)
end

Players.PlayerAdded:Connect(playerAdded)
for _, player in ipairs(Players:GetPlayers()) do
	playerAdded(player)
end


repeat
	wait()
until game.Players.LocalPlayer.Character

local Character = game.Players.LocalPlayer.Character
local Head = Character:WaitForChild("HumanoidRootPart")
local RunningSound = Head:WaitForChild("Running")
local Humanoid = Character:WaitForChild("Humanoid")
local vel = 0

Humanoid.Changed:Connect(function(property)
	
end)

Humanoid.Running:connect(function(a)
		--[[RunningSound.PlaybackSpeed 	= FootstepsSoundGroup:WaitForChild(Humanoid.FloorMaterial).PlaybackSpeed * (a/20) * (math.random(30,50)/40)
	RunningSound.Volume 		= FootstepsSoundGroup:WaitForChild(Humanoid.FloorMaterial).Volume * (a/20)
	RunningSound.MaxDistance 		= FootstepsSoundGroup:WaitForChild(Humanoid.FloorMaterial).MaxDistance * (a/40)
		RunningSound.EmitterSize 	= FootstepsSoundGroup:WaitForChild(Humanoid.FloorMaterial).EmitterSize * (a/50) * 50
	vel 						= a]]--
end)
