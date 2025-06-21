--By Rufus14
owner = game:GetService("Players").LocalPlayer
character = owner.Character
tool = script.Parent
event = tool:WaitForChild("knifeevent")
mouse = owner:GetMouse()
equipped = false
tool.Equipped:connect(function()
	owner = game:GetService("Players"):GetPlayerFromCharacter(tool.Parent)
	character = owner.Character
	equipped = true
end)
tool.Unequipped:connect(function()
	equipped = false
end)
mouse.KeyDown:connect(function(key)
	key = key:lower()
	if key == "e" and equipped then
		event:FireServer("skin")
	end
end)
mouse.Button1Up:connect(function()
	event:FireServer("throw", mouse.Hit)
end)