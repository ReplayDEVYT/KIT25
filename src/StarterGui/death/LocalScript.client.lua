local ts = require(game.ReplicatedStorage.TService)
local player = game:GetService("Players").LocalPlayer
--local hints = {"You can shoot out lights and glass.","Eat and drink to maintain energy and hydration.","Blood will gradually recover once you are back to a healthy state.","Press M to check your magazine, as well as the current weapon's bullet caliber and magazines/ammo remaining.","Headshotting a helmetless player will instantly kill them.","Account for wind and bullet drop depending on your target's range.","There is a 1/4 chance of a bullet ricocheting off of any surface.","Press U to equip a silencer on various weapons (they are not available on all of them!)","Team-kill is active in this game, and anti-team killing is not enforced.","This custom ACS engine is unfinished and is constantly updated.","You can view your armor's durability as well as your stamina, walkspeed, and current stance in the bottom left corner.","Press N to toggle night vision (if wearing).","There are secret death sounds you can acheive by dying.","Press F while holding a medical item or consumable (e.g. AI-2) to use it.","Press Y while having a weapon (or med/consumable) equipped to check the time.","Press H/K to toggle tactical accessories on your weapon (if any).","Performing empty reloads is faster than non-empty reloads.","Armor will mostly stop bullets, however armor can be penetrated and will deal a quarter of the actual damage to your health.","Taken by the Zone...","Firing in bursts reduces recoil when in full auto."}
local hinttext = script.Parent.Frame.Hint
local gui = script.Parent.Frame
local ply = game:GetService("Players").LocalPlayer
local hum = ply.Character:WaitForChild("Humanoid")
local Display = gui.Timer.Time
local Hours = 0 
local Minutes = 0 
local Seconds = 0 
local Milliseconds = 0


local function Msg(txt)
	gui.Killed.Text = txt
end
game.Players.LocalPlayer.Character:WaitForChild('Humanoid').Died:connect(function()
	if player.PlayerGui:FindFirstChild("StatusUI") ~= nil then
		player.PlayerGui:FindFirstChild("StatusUI").Enabled = false
	end
	if player.PlayerGui:FindFirstChild("Optimize") ~= nil then
		player.PlayerGui:FindFirstChild("Optimize").Enabled = false
	end
	if player.PlayerGui:FindFirstChild("RaidTimer") ~= nil then
		player.PlayerGui:FindFirstChild("RaidTimer").Enabled = false
	end
	wait(5)
	print("RAID TIME: "..Display.Text)
	if hum:findFirstChild("creator") then
		if hum.creator.Value then
			if hum.creator.Value.TeamColor == ply.TeamColor and ply.Neutral == false and ply.Team.Name ~= "SCAV" and ply.Team.Name ~= "NEUTRAL" then
				if ply.Character:WaitForChild("Saude").Variaveis.ShotLimb.Value ~= "" then
					Msg(ply.Name.." was teamkilled by "..hum.creator.Value.Name.." ("..ply.Character:WaitForChild("Saude").Variaveis.ShotLimb.Value..")")
				else
					Msg(ply.Name.." was teamkilled by "..hum.creator.Value.Name)
					end
			else
				
				if ply.Character:WaitForChild("Saude").Variaveis.ShotLimb.Value ~= "" then
					Msg(ply.Name.." was killed by "..hum.creator.Value.Name.." ("..ply.Character:WaitForChild("Saude").Variaveis.ShotLimb.Value..")")
				else
					Msg(ply.Name.." was killed by "..hum.creator.Value.Name)
				end
			end
		end
	end
	script.Parent.Frame.Visible = true
	script.Parent.Frame.GameOver.TextTransparency = 1
	script.Parent.Frame.GameOver.Killed.TextTransparency = 1
	script.Parent.Frame.GameOver.badeffect.ImageTransparency = 1
	script.Parent.Frame.GameOver.TextStrokeTransparency = 1
	script.Parent.Frame.GameOver.Killed.TextStrokeTransparency = 1
	script.Parent.Frame.Killed.TextTransparency = 1
	script.Parent.Frame.Killed.TextStrokeTransparency = 1
	script.Parent.Frame.Timer.TextTransparency = 1
	script.Parent.Frame.Timer.TextStrokeTransparency = 1
	script.Parent.Frame.Timer.Time.TextTransparency = 1
	script.Parent.Frame.Timer.Time.TextStrokeTransparency = 1
	hinttext.TextTransparency = 1
	hinttext.TextStrokeTransparency = 1
	hinttext.Hint2.TextTransparency = 1
	hinttext.Hint2.TextStrokeTransparency = 1
	ts(script.Parent.Frame.GameOver,TweenInfo.new(1),{TextTransparency = 0,TextStrokeTransparency = .75}):Play()
	ts(script.Parent.Frame.GameOver.Killed,TweenInfo.new(1),{TextTransparency = 0,TextStrokeTransparency = .75}):Play()
	ts(script.Parent.Frame.GameOver.badeffect,TweenInfo.new(1),{ImageTransparency = 0.5}):Play()
	wait(2)
	ts(script.Parent.Frame.GameOver.Grad,TweenInfo.new(0.15),{Offset = Vector2.new(2,0)}):Play()
	ts(script.Parent.Frame.GameOver.Killed.Grad,TweenInfo.new(0.15),{Offset = Vector2.new(2,0)}):Play()
	wait(1)
	ts(script.Parent.Frame.GameOver,TweenInfo.new(1),{Position = UDim2.new(0.5,0,0.15,0)}):Play()
	ts(gui.Killed,TweenInfo.new(1),{TextTransparency = 0,TextStrokeTransparency = .75}):Play()
	ts(gui.Timer,TweenInfo.new(1),{TextTransparency = 0,TextStrokeTransparency = .75}):Play()
	ts(gui.Timer.Time,TweenInfo.new(1),{TextTransparency = 0,TextStrokeTransparency = .75}):Play()
	ts(hinttext,TweenInfo.new(1),{TextTransparency = 0,TextStrokeTransparency = .75}):Play()
	ts(hinttext.Hint2,TweenInfo.new(1),{TextTransparency = 0,TextStrokeTransparency = .75}):Play()
	--hinttext.Text = ""..hints[math.random(1,#hints)]
	ts(script.Parent.Frame.GameOver.badeffect,TweenInfo.new(game:GetService("Players").RespawnTime),{ImageTransparency = 1}):Play()
	ts(script.Parent.Frame.GameOver.Killed,TweenInfo.new(game:GetService("Players").RespawnTime),{TextTransparency = 1,TextStrokeTransparency = 1}):Play()
	ts(script.Parent.Frame.GameOver,TweenInfo.new(game:GetService("Players").RespawnTime),{TextTransparency = 1,TextStrokeTransparency = 1}):Play()
	
end)



while ply.Character:WaitForChild('Humanoid').Health > 0 do
	repeat
		local passed = wait(.001) 
		Milliseconds = Milliseconds + passed
		if Hours > 0 then
			Display.Text = (Hours..":"..Minutes..":"..Seconds)
		else
			Display.Text = (Minutes..":"..Seconds)
		end
	until Milliseconds > .99 
	Seconds = Seconds + 1
	Milliseconds = 0
	if Hours > 0 then
		if Seconds < 10 then
			Display.Text = (Hours..":"..Minutes..":0"..Seconds)
		else
			Display.Text = (Hours..":"..Minutes..":"..Seconds)
		end
	else
		if Seconds < 10 then
			Display.Text = (Minutes..":0"..Seconds)
		else
			Display.Text = (Minutes..":"..Seconds)
		end
		end
	if Seconds == 60 then 
		Minutes = Minutes + 1 
		Seconds = 0 
		if Hours > 0 then
			Display.Text = (Hours..":"..Minutes..":"..Seconds)
		else
			Display.Text = (Minutes..":"..Seconds)
		end 
	end
	if Minutes == 60 then 
		Hours = Hours + 1 
		Minutes = 0 
		if Hours > 0 then
			Display.Text = (Hours..":"..Minutes..":"..Seconds)
		else
			Display.Text = (Minutes..":"..Seconds)
		end
	end
end 