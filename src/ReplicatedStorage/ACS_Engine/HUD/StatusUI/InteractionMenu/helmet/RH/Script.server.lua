local P = script.Parent.Parent.Parent.Player.Value
local clickEvent = nil
repeat wait() until P ~= nil
local HLoc = game.Workspace:FindFirstChild(P)
if not script.Parent:FindFirstChild("HelmetEvent") then
	clickEvent = Instance.new("RemoteEvent")
	clickEvent.Parent = script.Parent
	clickEvent.Name = "HelmetEvent"
else
	clickEvent = script.Parent:FindFirstChild("HelmetEvent")
end
wait(1)
local Helmet = HLoc:findFirstChild("Top")


function Click(p,p)
	if Helmet ~= nil then
		Helmet:Destroy()
		P.Character.Saude.Protecao.HelmetVida.Value = 0
		P.Character.Saude.Protecao.HelmetProtect.Value = 0
		print("helmetoff")
	end
end

clickEvent.OnServerEvent:Connect(Click)
-- J Productions 2013
-- Updated 2019 by exxtremestuffs - Added Remote Event to handle client side MoustButton1Click instance