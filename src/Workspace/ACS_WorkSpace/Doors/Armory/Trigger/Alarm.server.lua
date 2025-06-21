local sound = script.Parent.AlarmSound
sound.Playing = true
wait(30)
sound:Stop()
script.Parent.Script.Disabled = false
script.Disabled = true