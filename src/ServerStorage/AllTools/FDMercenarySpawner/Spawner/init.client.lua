bin = script.Parent

function onSelected(mouse)
	mouse.Icon = "rbxasset://textures\\ArrowCursor.png"
	mouse.Button1Down:connect(function()
		script.RemoteEvent:FireServer(mouse.hit.p)
	end)
end



bin.Equipped:connect(onSelected)