Tool = script.Parent

function onActivated()
	if Tool.Fire.Value == false then
		Tool.Effects.Fire.Enabled = true
		Tool.Effects.Flare.Enabled = true
		Tool.Effects.Light.Enabled = true
		Spark()
		Tool.Fire.Value = true
		Tool.Enabled = false
		wait(0.25)
		Tool.Enabled = true
	else
		Tool.Effects.Fire.Enabled = false
		Tool.Effects.Flare.Enabled = false
		Tool.Effects.Light.Enabled = false
		Tool.Fire.Value = false
		Tool.Enabled = false
		wait(0.25)
		Tool.Enabled = true
	end
end

function Spark()
	Tool.Effects.Sparks.Enabled = true
	Tool.Handle.Spark:Play()
	wait(0.1)
	Tool.Effects.Sparks.Enabled = false
end

function onUnequipped()
	Tool.Effects.Fire.Enabled = false
	Tool.Effects.Flare.Enabled = false
	Tool.Effects.Light.Enabled = false
	Tool.Fire.Value = false
end

script.Parent.Activated:connect(onActivated)
script.Parent.Unequipped:connect(onUnequipped)