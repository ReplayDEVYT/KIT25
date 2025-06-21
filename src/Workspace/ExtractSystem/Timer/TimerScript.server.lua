local Engine = workspace:WaitForChild("ExtractSystem")
local extracts = Engine.Exits

local config = Engine.MainConfig
local Settings = require(config.Config)
local settingvalue = config.Values


local raidTime
local timeLimit
local timeValue = script.Parent
local inSeconds = ((Settings.TimeHours*120) + (Settings.TimeMinutes*60) + Settings.TimeSeconds)


local Hours = 0 
local Minutes = 0 
local Seconds = 0 
local Milliseconds = 0

local timeHours = Settings.TimeHours
local timeMinutes = Settings.TimeMinutes
local timeSeconds = Settings.TimeSeconds
local oldSeconds = Settings.TimeSeconds
local oldMins = Settings.TimeMinutes
local oldHours = Settings.TimeHours

function Format(Int)
	return string.format("%02i", Int)
end

function convertToHMS(Seconds)
	local Minutes = (Seconds - Seconds%60)/60
	Seconds = Seconds - Minutes*60
	local Hours = (Minutes - Minutes%60)/60
	Minutes = Minutes - Hours*60
	return Format(Hours)..":"..Format(Minutes)..":"..Format(Seconds)
end

while true do
	if timeLimit ~= nil then
		timeValue.Value = tostring(timeLimit)
	end
	repeat
		local passed = wait(.001) 
		Milliseconds = Milliseconds + passed
		--[[if Hours > 0 then
			raidTime = (Hours..":"..Minutes..":"..Seconds)
		else
			raidTime = (Minutes..":"..Seconds)
		end]]--
	until Milliseconds > .99 
	Seconds = Seconds + 1
	if Settings.RaidTimer == true then
		timeSeconds = timeSeconds - 1
		inSeconds -= 1
		if timeSeconds <= 0 and timeMinutes <= 0 then
			timeSeconds = 0
		end
	elseif Settings.RaidTimer == false then
		timeSeconds = oldSeconds
		timeMinutes = oldMins
		timeHours = oldHours
	end
	Milliseconds = 0
	
	raidTime = convertToHMS(Seconds)
	timeLimit = convertToHMS(inSeconds)
	
	
	--[[if Hours > 0 then
		if Seconds < 10 then
			raidTime = (Hours..":"..Minutes..":0"..Seconds)
			timeLimit = (timeHours..":"..timeMinutes..":0"..timeSeconds)
		else
			raidTime = (Hours..":"..Minutes..":"..Seconds)
			timeLimit = (timeHours..":"..timeMinutes..":"..timeSeconds)
		end


	else
		if Seconds < 10 then
			raidTime = (Minutes..":0"..Seconds)
			timeLimit = ("00:"..timeMinutes..":0"..timeSeconds)
		else
			raidTime = (Minutes..":"..Seconds)
			timeLimit = ("00:"..timeMinutes..":"..timeSeconds)
		end
	end
	if Seconds == 60 then 
		Minutes = Minutes + 1 
		Seconds = 0 
		if Hours > 0 then
			raidTime = (Hours..":"..Minutes..":"..Seconds)
		else
			raidTime = (Minutes..":"..Seconds)
		end 
	end
	if Minutes == 60 then 
		Hours = Hours + 1 
		Minutes = 0 
		if Hours > 0 then
			raidTime = (Hours..":"..Minutes..":"..Seconds)
		else
			raidTime = (Minutes..":"..Seconds)
		end
	end


	if timeSeconds < 0 and timeMinutes > 0 then 
		timeMinutes = timeMinutes - 1 
		timeSeconds = 60 
		if timeHours > 0 then
			if timeSeconds < 10 then
				timeLimit = (timeHours..":"..timeMinutes..":0"..timeSeconds)
			else
				timeLimit = (timeHours..":"..timeMinutes..":"..timeSeconds)
			end
		else
			--timeLimit = ("00:"..timeMinutes..":"..timeSeconds)
			if timeSeconds < 10 then
				timeLimit = ("00:"..timeMinutes..":0"..timeSeconds)
			else
				timeLimit = ("00:"..timeMinutes..":"..timeSeconds)
			end
		end
	end
	if timeMinutes < 0 and timeHours > 0 then 
		timeHours = timeHours - 1 
		timeMinutes = 60 
		if timeHours > 0 then
			if timeSeconds < 10 then
				timeLimit = (timeHours..":"..timeMinutes..":0"..timeSeconds)
			else
				timeLimit = (timeHours..":"..timeMinutes..":"..timeSeconds)
			end
		else
			--timeLimit = ("00:"..timeMinutes..":"..timeSeconds)
			if timeSeconds < 10 then
				timeLimit = ("00:"..timeMinutes..":0"..timeSeconds)
			else
				timeLimit = ("00:"..timeMinutes..":"..timeSeconds)
			end
		end
	end]]--
end 