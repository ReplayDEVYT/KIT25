local Module = {};

ts = require(game.ReplicatedStorage.TService)

Module.NotificationCleanup = function(notification, delaytime)
	task.wait(delaytime)
	local fade = ts(notification,TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false),{GroupTransparency = 1})
	fade:Play()
	task.delay(1,function()
		notification:Destroy()
		print("notification finished")
	end)
end

Module.Notify = function(text, icon, sound, duration)
	local notiftemp = script.Parent.Template.Notif:Clone()
	notiftemp.Parent = script.Parent:FindFirstChild("Notification")

	notiftemp.Visible = true
	notiftemp.GroupTransparency = 1
	notiftemp.TextLabel.Text = text
	notiftemp.Alert.SoundId = "rbxassetid://"..sound
	notiftemp.icon.Image = "rbxassetid://"..icon

	notiftemp.Alert:Play()
	ts(notiftemp,TweenInfo.new(0.1,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false),{GroupTransparency = 0}):Play()

	Module.NotificationCleanup(notiftemp, duration)
end

return Module;