function onTouched(hit)
	if hit.Name == "porta" or hit.Name == "knob" then
		script.Parent.Alarm.Disabled = false
		print("alarm")
		script.Disabled = true
	end
end

script.Parent.Touched:connect(onTouched)