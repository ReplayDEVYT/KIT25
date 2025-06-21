for i, Guis in ipairs(script.Parent:GetChildren()) do

		if Guis.className ~= "LocalScript" then
			if Guis.Name ~= "CirculoDeFundo" then
				
		Guis.Botao.MouseEnter:connect(function()
			Guis.CirculoSelecao.Visible = true
		end)	
				
		Guis.Botao.MouseLeave:connect(function()
			Guis.CirculoSelecao.Visible = false
		end)
		
			end
		end



end