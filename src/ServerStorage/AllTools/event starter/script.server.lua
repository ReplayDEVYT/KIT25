function onActivated()
	script.Parent.sound:Play()
end

script.Parent.Activated:Connect(onActivated)