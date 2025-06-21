local toggle = false

function act(yes)
	toggle = not toggle
	yes.Visible = toggle
	script.Parent["1"].Visible = not toggle
end

script.Parent.MouseButton1Click:connect(act(script.Parent.Parent.Menu))