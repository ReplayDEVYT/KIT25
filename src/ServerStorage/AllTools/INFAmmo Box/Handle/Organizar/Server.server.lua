local evt = script.Parent.Server.PegarEvento
local debounce = false

function onTouched(hit) 
if (hit.Parent:FindFirstChild("Humanoid") ~= nil) then
local player = game.Players:GetPlayerFromCharacter(hit.Parent)
local d = hit.Parent:GetChildren() 

for i=1, #d do 
if script.Parent.AmmoLeft.Value > 0 and debounce == false then
	if (d[i].className == "Tool") then 
		if script.Parent.Universal.Value == true or (d[i].ACS_Modulo.Variaveis.BType.Value == script.Parent.BulletType.Value) then

				if d[i].ACS_Modulo.Variaveis.StoredAmmo.Value < d[i].ACS_Modulo.Variaveis.StoredAmmo.MaxValue then

					if script.Parent.AmmoLeft.Value >= (d[i].ACS_Modulo.Variaveis.StoredAmmo.MaxValue - d[i].ACS_Modulo.Variaveis.StoredAmmo.Value) then

					debounce = true
					
					script.Parent.Parent.Sound:play()
					script.Parent.AmmoLeft.Value = script.Parent.AmmoLeft.Value - (d[i].ACS_Modulo.Variaveis.StoredAmmo.MaxValue - d[i].ACS_Modulo.Variaveis.StoredAmmo.Value)
					d[i].ACS_Modulo.Variaveis.StoredAmmo.Value = d[i].ACS_Modulo.Variaveis.StoredAmmo.Value + (d[i].ACS_Modulo.Variaveis.StoredAmmo.MaxValue - d[i].ACS_Modulo.Variaveis.StoredAmmo.Value)
					script.Parent.Parent.Interface.Frame.Barra.Amount.Text = script.Parent.AmmoLeft.Value .." / "..script.Parent.AmmoLeft.MaxValue
					script.Parent.Parent.Interface.Frame.Barra.Valor.Size = UDim2.new(script.Parent.AmmoLeft.Value/script.Parent.AmmoLeft.MaxValue,0,1,0)

					wait(1)

					debounce = false


				else
				
					debounce = true
					
					script.Parent.Parent.Sound:play()
					d[i].ACS_Modulo.Variaveis.StoredAmmo.Value = d[i].ACS_Modulo.Variaveis.StoredAmmo.Value + script.Parent.AmmoLeft.Value
					script.Parent.AmmoLeft.Value = 0
					script.Parent.Parent.GUI.Frame.Amount.Text = script.Parent.AmmoLeft.Value .." Bullets"

					wait(1)

					debounce = false

				end

			end

		end

	end
elseif script.Parent.AmmoLeft.Value <= 0 and debounce == false then
	debounce = true
	script.Parent.Parent:Destroy()
end
end
end
end 

script.Parent.Parent.Touched:connect(onTouched) 