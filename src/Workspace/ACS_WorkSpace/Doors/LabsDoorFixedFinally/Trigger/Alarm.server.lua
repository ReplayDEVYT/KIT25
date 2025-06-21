local sound = script.Parent.AlarmSound
sound:Play()
task.wait(2)
script.Parent.Script.Disabled = false
script.Disabled = true