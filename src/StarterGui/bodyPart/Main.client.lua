local plr = game:GetService("Players").LocalPlayer
local char = plr.Character
repeat wait() until char ~= nil and char:WaitForChild("Head")
--print(char.Name)
local ts = require(game.ReplicatedStorage.TService)
local animating = false
local Limbs = script.Parent:WaitForChild("Limbs")
local lasthealth
local saude = char:WaitForChild("Saude")
local varia = saude:WaitForChild("Variaveis")
local stances = saude:WaitForChild("Stances")
local Status = Limbs:WaitForChild("Status")
yup = false

LimbsList = {
	"LeftFoot",
	"LeftLowerLeg",
	"LeftUpperLeg",
	"RightFoot",
	"RightLowerLeg",
	"RightUpperLeg",
	"LeftHand",
	"LeftLowerArm",
	"LeftUpperArm",
	"RightHand",
	"RightLowerArm",
	"RightUpperArm",
	"Left Arm",
	"Right Arm",
	"Left Leg",
	"Right Leg",
	"UpperTorso",
	"LowerTorso",
	"Torso",
	"Head",
	"Stomach",
}


function HideLimbs()
	--print("hidelimbs")
	--if animating == false then
		--animating = true
		for i,v in pairs(Limbs:GetDescendants()) do
			if v:IsA("ImageLabel") then
				--v.ImageTransparency = 0.5
				--animating = true
				ts(v, TweenInfo.new(1.25), {ImageTransparency = 1} ):Play()
				--wait(1.25)
				--animating = false
			end
		end
		wait(1.25)
		--animating = false
		--print("can animate")
	--end
end

function ShowLimbs()
	--print("showlimbs")
	--if animating == false then
		--animating = true
		for i,v in pairs(Limbs:GetDescendants()) do
			if v:IsA("ImageLabel") then
				--animating = true
				--v.ImageTransparency = 1
				ts(v, TweenInfo.new(1.25), {ImageTransparency = 0} ):Play()
				--animating = false
			end
		end
		wait(10)
		--animating = false
		HideLimbs()
	--end
end


function UpdateLimb(Health,Limb,Max,Check)
	return function(Health)
		--print(Health)
		--print(Limb)
		--print(Max)
		--print("attempt to updatelimbs")
		if lasthealth == nil then
			lasthealth = Max
			end
	--print("updatelimbs")
		if Check ~= nil or (Health < (lasthealth or Max) or Health > (lasthealth or Max)) then
		--if Health.Parent ~= nil then
		--print("updatelimbs")
		--local Limb = Health.Parent
	--if Limb ~= nil and Health ~= nil then
		
		local guiLimb = Limbs:FindFirstChild(Limb.Name)
		if guiLimb then
			if Health > 0 then
				--guiLimb["icon"].ImageColor3 = Color3.new(1,Health.Value/(Health.MaxValue),Health.Value/Health.MaxValue)
				ts(guiLimb["icon"], TweenInfo.new(0.25), {ImageColor3 = Color3.new(1,Health/Max,Health/Max)} ):Play()
				if guiLimb:FindFirstChild("icon2") then
						ts(guiLimb["icon2"], TweenInfo.new(0.25), {ImageColor3 = Color3.new(1,Health/Max,Health/Max)} ):Play()
				end
			elseif Health <= 0 then
				ts(guiLimb["icon"], TweenInfo.new(0.25), {ImageColor3 = Color3.new(0,0,0)} ):Play()
				if guiLimb:FindFirstChild("icon2") then
						ts(guiLimb["icon2"], TweenInfo.new(0.25), {ImageColor3 = Color3.new(0,0,0)} ):Play()
				end
				--guiLimb["icon"].ImageColor3 = Color3.new(0,0,0)
				end
			end
		end
		if stances.Tourniquet.Value == true then
			Status.FreshWound.Visible = stances.Tourniquet.Value
			Status.Bleeding.Visible = false
			Status.Bleeding2.Visible = false
		end
		if stances.Sangrando.Value == true and stances.Tourniquet.Value == false then
			Status.Bleeding.Visible = varia.HeavyBleed.Value
			if Status.Bleeding.Visible == false then
				Status.Bleeding2.Visible = true
			else
				Status.Bleeding2.Visible = false
			end
		end
		if varia.Dor.Value > 0 then
			if stances.PK.Value == false then
				Status.Pain.Visible = true
				Status.PainKiller.Visible = false
			end
		end
		if stances.PK.Value == true then
			Status.Pain.Visible = false
			Status.PainKiller.Visible = true
		end
		if stances.Ferido.Value == true then
			Status.Fracture.Visible = true
		else
			Status.Fracture.Visible = false
		end
		Status.Toxin.Visible = false
		for i,lan in pairs(char:GetChildren()) do
			if lan:FindFirstChild("UnknownToxin") then
				Status.Toxin.Visible = true
			end
		end
		ShowLimbs()
		--end
	--end
		lasthealth = Health
		end
end

for i,x in pairs(char:GetChildren()) do
	if x:IsA("BasePart") then
		--print("yup"..x.Name)
	if table.find(LimbsList, x.Name) then
			--print(x.Name)
			for i,hp in pairs(x:GetChildren()) do
				if yup == false then
					repeat wait() until x ~= nil and x:WaitForChild("HP")
					end
				if hp.Name == "HP" then
					yup = true
					hp.Changed:connect(UpdateLimb(hp.Value,x,hp.MaxValue))
					--print("hp found "..hp.Value.." "..hp.MaxValue)
				end
				end
		end
	end
end

HideLimbs()

char:WaitForChild("Humanoid").Died:connect(function()
	script.Parent.Enabled = false
end)
