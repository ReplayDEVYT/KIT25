local torso = script.Parent:WaitForChild("Torso")
local head = script.Parent:WaitForChild("Head")
local larm = script.Parent:WaitForChild("Left Arm")
local rarm = script.Parent:WaitForChild("Right Arm")
local lleg = script.Parent:WaitForChild("Left Leg")
local rleg = script.Parent:WaitForChild("Right Leg")
local sound1 = script:WaitForChild("Sound1"):Clone()
local sound2 = script:WaitForChild("Sound2"):Clone()
local sound3 = script:WaitForChild("Sound3"):Clone()
local sound4 = script:WaitForChild("Sound4"):Clone()
local sound5 = script:WaitForChild("Sound5"):Clone()
local sound6 = script:WaitForChild("Sound6"):Clone()
-- local death1 = script:WaitForChild("Death1"):Clone()
-- local death2 = script:WaitForChild("Death2"):Clone()
local VisorSounds = script:WaitForChild("VisorSounds"):Clone()



local cough1 = script:WaitForChild("Cough1"):Clone()
local cough2 = script:WaitForChild("Cough2"):Clone()
local tired = script:WaitForChild("Tired"):Clone()
local nvg1 = script:WaitForChild("On"):Clone()
local nvg2 = script:WaitForChild("Off"):Clone()
stand = script:WaitForChild("StandSFX"):Clone()
crouch = script:WaitForChild("CrouchSFX"):Clone()
slide = script:WaitForChild("SlideSFX"):Clone()
dive = script:WaitForChild("DiveSFX"):Clone()
--prone = script:WaitForChild("ProneSFX"):Clone()
lean1 = script:WaitForChild("LeanSFX1"):Clone()
lean2 = script:WaitForChild("LeanSFX2"):Clone()
hit1 = script["Hit1"]:Clone()
hit2 = script["Hit2"]:Clone()
hit3 = script["Hit3"]:Clone()
hit4 = script["Hit4"]:Clone()

hit1.Parent = head
hit2.Parent = head
hit3.Parent = head
hit4.Parent = head


sound1.Parent = script.Parent.Head
sound2.Parent = script.Parent.Head
sound3.Parent = script.Parent.Head
sound4.Parent = script.Parent.Head
sound5.Parent = script.Parent.Head
sound6.Parent = script.Parent.Head
-- death2.Parent = script.Parent.Head
-- death1.Parent = script.Parent.Head

VisorSounds.Parent = script.Parent.Head


cough1.Parent = script.Parent.Head
cough2.Parent = script.Parent.Head

tired.Parent = script.Parent.Head
stand.Parent = torso
crouch.Parent = torso
dive.Parent = torso
slide.Parent = torso
--prone.Parent = torso
lean1.Parent = torso
lean2.Parent = torso
for i,v in pairs(script:GetChildren()) do
	if v.Name:lower():find("p") and v:IsA("Sound") and not v.Name:lower():find("hp") then
		v:Clone().Parent = torso
	end
end

if head:FindFirstChild("HP") == nil then
local headv = script:WaitForChild("HPHead"):Clone()
local torsov = script:WaitForChild("HPTorso"):Clone()
local larmv = script:WaitForChild("HPLA"):Clone()
local rarmv = script:WaitForChild("HPRA"):Clone()
local llegv = script:WaitForChild("HPLL"):Clone()
local rlegv = script:WaitForChild("HPRL"):Clone()
headv.Parent = head
torsov.Parent = torso
larmv.Parent = larm
rarmv.Parent = rarm
llegv.Parent = lleg
rlegv.Parent = rleg
headv.Name = "HP"
torsov.Name = "HP"
larmv.Name = "HP"
rarmv.Name = "HP"
llegv.Name = "HP"
	rlegv.Name = "HP"
	nvg1.Parent = head
	nvg2.Parent = head
end

for i,v in pairs(script.Parent:GetChildren()) do
	if v:IsA("BasePart") then
		v.CollisionGroup = "Player"
	end
end

script:Destroy()
--print(script.Parent:WaitForChild("Humanoid").Health)