--[[
MIT License

Copyright (c) 2025 thatrtxdude

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]--


--!nonstrict
-- ValveFlicker Module
-- Simulates light flickering effects commonly seen in Valve games like Half-Life and Quake.
-- This module allows you to apply predefined or custom flickering patterns to Light instances.

local ValveFlicker = {}
local RunService = game:GetService("RunService")

--------------------------------------------------------------------------------
-- Type Definitions
--------------------------------------------------------------------------------

-- Represents the flickering state of a single light.
type LightState = {
	currentIndex: number,        -- The current position in the flicker sequence.
	accumulatedTime: number,     -- Time elapsed since the last brightness update.
	targetBrightness: number,    -- The brightness level the light is transitioning towards.
	currentBrightness: number,   -- The current brightness level of the light.
	maxBrightness: number,       -- The maximum brightness of the light (its initial brightness).
	debugGui: BillboardGui?,     -- (Optional) BillboardGui for debugging visualization.
	debugLabel: TextLabel?,       -- (Optional) TextLabel within the debug GUI.
	paused: boolean    -- New field for pause state
}

-- Defines a specific flickering pattern and manages the lights using that pattern.
type LightStyle = {
	sequence: string,             -- A string representing the flicker pattern (e.g., "mmamam").
	letterValues: { [string]: number }, -- Maps characters in the sequence to brightness values.
	transitionTime: number,       -- The duration of each brightness transition in seconds.
	lights: { [Light]: LightState }, -- A dictionary of lights currently using this style and their states.
	started: boolean,            -- Indicates if the Heartbeat connection for this style is active.
	connection: RBXScriptConnection? -- The Heartbeat connection responsible for updating lights in this style.
}

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------

local DEFAULT_TRANSITION_TIME = 1 / 10 -- Transition time for each step in the flicker sequence (0.1 seconds, equivalent to 10 Hz).
local MIN_BRIGHTNESS = 0             -- The minimum possible brightness for a light.
local DEFAULT_BAR_LENGTH = 20          -- The number of characters used to represent brightness in the debug bar.

--------------------------------------------------------------------------------
-- Module-Scoped Variables
--------------------------------------------------------------------------------

-- Stores all defined light styles, indexed by a unique number.
local LIGHT_STYLES: { [number]: LightStyle } = {}

--------------------------------------------------------------------------------
-- Pre-calculated Values
--------------------------------------------------------------------------------

-- Maps lowercase letters 'a' through 'z' to brightness values between 0 and 1.
local LETTER_VALUES = (function()
	local values = {}
	local startChar, endChar = string.byte("a"), string.byte("z")
	for i = startChar, endChar do
		local letter = string.char(i)
		-- Normalize the character code to a 0-1 range.
		local brightnessValue = (i - startChar) / (endChar - startChar)
		values[letter] = brightnessValue
	end
	return values
end)()

--------------------------------------------------------------------------------
-- Helper Functions (Internal)
--------------------------------------------------------------------------------

-- Linearly interpolates between two numbers.
local function lerp(a: number, b: number, t: number): number
	return a + (b - a) * t
end

-- Creates a debug BillboardGui and TextLabel attached to a light.
local function createDebugGui(light: Light): (BillboardGui?, TextLabel?)
	local parentPart = light.Parent
	if not parentPart or not parentPart:IsA("BasePart") then
		return nil, nil -- Cannot create debug GUI if the light is not parented to a BasePart.
	end

	local billboardGui = Instance.new("BillboardGui")
	billboardGui.Name = "FlickerDebug"
	billboardGui.Size = UDim2.fromOffset(200, 50)
	billboardGui.StudsOffset = Vector3.new(0, 3, 0)
	billboardGui.Adornee = parentPart
	billboardGui.Parent = parentPart
	billboardGui.AlwaysOnTop = true

	local textLabel = Instance.new("TextLabel")
	textLabel.Size = UDim2.fromScale(1, 1)
	textLabel.BackgroundTransparency = 1
	textLabel.TextScaled = true
	textLabel.TextColor3 = Color3.new(1, 1, 1)
	textLabel.Font = Enum.Font.SourceSansBold
	textLabel.Text = "Initializing Flicker..."
	textLabel.Parent = billboardGui

	return billboardGui, textLabel
end

-- Removes a light style and disconnects its Heartbeat connection.
local function removeStyle(styleIndex: number)
	local style = LIGHT_STYLES[styleIndex]
	if style then
		if style.connection then
			style.connection:Disconnect()
			style.connection = nil
		end

		-- Destroy debug GUIs for all lights using this style.
		for _, lightState in pairs(style.lights) do
			if lightState.debugGui then
				lightState.debugGui:Destroy()
			end
		end
	end
	LIGHT_STYLES[styleIndex] = nil
end

-- Creates a new light style with the given parameters.
local function createLightStyle(styleIndex: number, sequence: string, transitionTime: number?)
	assert(type(styleIndex) == "number", "Style index must be a number.")
	assert(type(sequence) == "string", "Sequence must be a string.")
	assert(not LIGHT_STYLES[styleIndex], string.format("A light style with index %d already exists.", styleIndex))

	-- Ensure all characters in the sequence are valid.
	for i = 1, #sequence do
		local char = sequence:sub(i, i)
		assert(LETTER_VALUES[char], string.format("Invalid character '%s' in flicker sequence.", char))
	end

	LIGHT_STYLES[styleIndex] = {
		sequence = sequence,
		letterValues = LETTER_VALUES,
		transitionTime = transitionTime or DEFAULT_TRANSITION_TIME,
		lights = {},
		started = false,
		connection = nil
	}
end

-- Gets the target brightness for the current step in the flicker sequence.
local function getNextBrightness(style: LightStyle, lightState: LightState): number
	local char = style.sequence:sub(lightState.currentIndex, lightState.currentIndex)
	return (style.letterValues[char] or 0) * lightState.maxBrightness
end

-- Advances the light's current index in the flicker sequence.
local function updateIndex(style: LightStyle, lightState: LightState)
	lightState.currentIndex += 1
	if lightState.currentIndex > #style.sequence then
		lightState.currentIndex = 1 -- Loop back to the beginning of the sequence.
	end
end

-- Updates the brightness of all lights using a specific style.
local function updateAllLightsForStyle(styleIndex: number, deltaTime: number)
	local style = LIGHT_STYLES[styleIndex]
	if not style then return end

	for light, lightState in pairs(style.lights) do
		if not light:IsDescendantOf(workspace) then
			-- Stop flickering if the light has been removed from the workspace
			ValveFlicker.stopFlicker(light, styleIndex)
		elseif not lightState.paused then -- Only update if not paused
			lightState.accumulatedTime += deltaTime

			-- Calculate the interpolation alpha (0 to 1) for the current transition
			local alpha = math.min(lightState.accumulatedTime / style.transitionTime, 1)

			-- Interpolate towards the target brightness
			lightState.currentBrightness = lerp(lightState.currentBrightness, lightState.targetBrightness, alpha)
			light.Brightness = math.clamp(lightState.currentBrightness, MIN_BRIGHTNESS, lightState.maxBrightness)

			-- Update the debug GUI if it exists
			if lightState.debugLabel then
				local filledCount = math.floor((lightState.currentBrightness / lightState.maxBrightness) * DEFAULT_BAR_LENGTH)
				local brightnessBar = string.rep("█", filledCount) .. string.rep("░", DEFAULT_BAR_LENGTH - filledCount)
				lightState.debugLabel.Text = string.format(
					"Style %d\nPattern Char: '%s' (%d/%d)\nBrightness: %.2f/%.2f\n%s",
					styleIndex,
					style.sequence:sub(lightState.currentIndex, lightState.currentIndex),
					lightState.currentIndex,
					#style.sequence,
					lightState.currentBrightness,
					lightState.maxBrightness,
					brightnessBar
				)
			end

			-- If the transition is complete, move to the next step in the sequence
			if alpha >= 1 then
				lightState.accumulatedTime = 0
				updateIndex(style, lightState)
				lightState.targetBrightness = getNextBrightness(style, lightState)
			end
		end
	end
end

-- Starts the Heartbeat connection for a given style if it's not already running.
local function startStyleConnection(styleIndex: number)
	local style = LIGHT_STYLES[styleIndex]
	if style and not style.started then
		style.started = true
		style.connection = RunService.Heartbeat:Connect(function(deltaTime)
			updateAllLightsForStyle(styleIndex, deltaTime)
		end)
	end
end

-- Cleans up light styles that are no longer in use (have no lights assigned).
local function cleanupUnusedStyles()
	for index, style in pairs(LIGHT_STYLES) do
		if next(style.lights) == nil then
			-- Disconnect the Heartbeat if it's active.
			if style.connection then
				style.connection:Disconnect()
			end
			LIGHT_STYLES[index] = nil
		end
	end
end

-- Initializes the default light flicker styles.
local function initializeDefaultStyles()
	createLightStyle(0, "m")  -- Normal
	createLightStyle(1, "mmamammmmammamamaaamammma")  -- Fluorescent flicker
	createLightStyle(2, "abcdefghijklmnopqrstuvwxyzyxwvutsrqponmlkjihgfedcba")  -- Slow strong pulse
	createLightStyle(3, "mmmmmaaaaammmmmaaaaaabcdefgabcdefg")  -- Candle
	createLightStyle(4, "mamamamamama")  -- Fast strobe
	createLightStyle(5, "jklqrstuvwxyzyxwvutsrqponmlkj")  -- Gentle pulse (shortened a bit)
	createLightStyle(6, "nmonqnmomnmomomno")  -- Flicker
	createLightStyle(7, "mmmaaaabcdefgmmmmaaaammmaamm")  -- Candle 2
	createLightStyle(8, "mmmaaammmaaammmabcdefaaaammmmabcdefmmmaaaa")  -- Candle 3
	createLightStyle(9, "aaaaaaaazzzzzzzz")  -- Slow strobe
	createLightStyle(10, "mmamammmmammamamaaamammma")  -- Fluorescent flicker 2
	createLightStyle(11, "abcdefghijklmnopqrrqponmlkjihgfedcba")  -- Slow pulse not fade to black
	createLightStyle(63, "a")  -- Constant light
	createLightStyle(64, "amonqnmoanmomomaefafano")  -- Fluorescent flicker
end

--------------------------------------------------------------------------------
-- Public API
--------------------------------------------------------------------------------

--- Starts the light flickering effect on a given Light instance.
-- @param light The Light instance to apply the flicker to.
-- @param styleIndex The index of the flicker style to use.
-- @param debug (Optional) If true, displays a debug BillboardGui on the light.
-- @param startIndex (Optional) The starting index in the flicker sequence (defaults to 1).
function ValveFlicker.startFlicker(light: Light, styleIndex: number, debug: boolean?, startIndex: number?)
	assert(typeof(light) == "Instance" and light:IsA("Light"), "First argument must be a Light instance.")
	local style = LIGHT_STYLES[styleIndex]
	if not style then
		warn(string.format("Light style with index %d does not exist.", styleIndex))
		return
	end

	-- Validate and clamp the start index if provided.
	if startIndex then
		assert(type(startIndex) == "number", "Start index must be a number.")
		startIndex = math.clamp(math.floor(startIndex), 1, #style.sequence)
	end

	-- Initialize the light's state if it's not already being tracked for this style.
	if not style.lights[light] then
		style.lights[light] = {
			currentIndex = startIndex or 1,
			accumulatedTime = 0,
			targetBrightness = 0,
			currentBrightness = light.Brightness,
			maxBrightness = light.Brightness,
			debugGui = nil,
			debugLabel = nil
		}
	end

	local lightState = style.lights[light]
	-- Set the initial target brightness if it hasn't been set yet.
	if lightState.targetBrightness == 0 then
		lightState.targetBrightness = getNextBrightness(style, lightState)
	end

	-- Create the debug GUI if requested and it doesn't already exist.
	if debug and not lightState.debugGui then
		local gui, label = createDebugGui(light)
		lightState.debugGui = gui
		lightState.debugLabel = label
	end

	-- Ensure the Heartbeat connection for this style is running.
	startStyleConnection(styleIndex)
end

--- Pauses the flickering effect for a given light without removing its state.
-- @param light The Light instance to pause flickering for.
-- @param styleIndex The index of the flicker style being used.
function ValveFlicker.pauseFlicker(light: Light, styleIndex: number)
	local style = LIGHT_STYLES[styleIndex]
	if style and style.lights[light] then
		local lightState = style.lights[light]
		lightState.paused = true
		-- Store the current brightness while paused
		if light and light:IsDescendantOf(workspace) then
			light.Brightness = lightState.currentBrightness
		end
	end
end

--- Resumes the flickering effect for a previously paused light.
-- @param light The Light instance to resume flickering for.
-- @param styleIndex The index of the flicker style being used.
function ValveFlicker.resumeFlicker(light: Light, styleIndex: number)
	local style = LIGHT_STYLES[styleIndex]
	if style and style.lights[light] then
		local lightState = style.lights[light]
		lightState.paused = false
		-- Reset accumulated time to ensure smooth transition
		lightState.accumulatedTime = 0
	end
end

--- Gets the current light style information for a given light.
-- @param light The Light instance to check.
-- @return A table containing the style index and configuration, or nil if the light isn't using any style.
function ValveFlicker.getLightStyle(light: Light): {styleIndex: number, sequence: string, transitionTime: number, paused: boolean}?
	assert(typeof(light) == "Instance" and light:IsA("Light"), "Argument must be a Light instance.")

	-- Search through all styles to find which one is using this light
	for styleIndex, style in pairs(LIGHT_STYLES) do
		local lightState = style.lights[light]
		if lightState then
			return {
				styleIndex = styleIndex,
				sequence = style.sequence,
				transitionTime = style.transitionTime,
				paused = lightState.paused or false
			}
		end
	end

	return nil -- Light is not using any style
end

--- Stops the light flickering effect on a given Light instance.
-- @param light The Light instance to stop flickering.
-- @param styleIndex The index of the flicker style being used.
function ValveFlicker.stopFlicker(light: Light, styleIndex: number)
	local style = LIGHT_STYLES[styleIndex]
	if style and style.lights[light] then
		local lightState = style.lights[light]
		style.lights[light] = nil -- Remove the light from the style's tracked lights.

		-- Restore the light's original brightness if it still exists.
		if light and light:IsDescendantOf(workspace) then
			light.Brightness = lightState.maxBrightness
		end

		-- Destroy the debug GUI if it exists.
		if lightState.debugGui then
			lightState.debugGui:Destroy()
		end
	end
	cleanupUnusedStyles() -- Check if the style is now unused and clean it up.
end

--- Creates a custom light flicker style.
-- @param styleIndex A unique index for the new style.
-- @param sequence A string representing the flicker pattern (e.g., "aabbcc").
-- @param transitionTime (Optional) The duration of each brightness transition in seconds.
function ValveFlicker.createCustomStyle(styleIndex: number, sequence: string, transitionTime: number?)
	createLightStyle(styleIndex, sequence, transitionTime)
end

--- Removes a light flicker style. This will stop any lights using this style from flickering.
-- @param styleIndex The index of the style to remove.
function ValveFlicker.removeStyle(styleIndex: number)
	removeStyle(styleIndex)
end

-- Initialize the default flicker styles when the module is loaded.
initializeDefaultStyles()

-- Ensure Heartbeat connections are stopped and debug GUIs are destroyed when the game closes.
game:BindToClose(function()
	for _, style in pairs(LIGHT_STYLES) do
		if style.connection then
			style.connection:Disconnect()
		end
		for _, lightState in pairs(style.lights) do
			if lightState.debugGui then
				lightState.debugGui:Destroy()
			end
		end
	end
end)

return ValveFlicker