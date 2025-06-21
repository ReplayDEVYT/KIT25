local P = script.Parent.Parent.Parent.Player.Value
local clickEvent = nil
repeat wait() until P ~= nil
local HLoc = game.Workspace:FindFirstChild(P)
if not script.Parent:FindFirstChild("VestEvent") then
	clickEvent = Instance.new("RemoteEvent")
	clickEvent.Parent = script.Parent
	clickEvent.Name = "VestEvent"
else
	clickEvent = script.Parent:FindFirstChild("VestEvent")
end
wait(1)
local Helmet = HLoc:findFirstChild("Chest")


function Click(p,p)
	if Helmet ~= nil then
		Helmet:Destroy()
		P.Character.Saude.Protecao.VestVida.Value = 0
		P.Character.Saude.Protecao.VestProtect.Value = 0
		print("vestoff")
	end
end

clickEvent.OnServerEvent:Connect(Click)
-- J Productions 2013
-- Updated 2019 by exxtremestuffs - Added Remote Event to handle client side MoustButton1Click instance