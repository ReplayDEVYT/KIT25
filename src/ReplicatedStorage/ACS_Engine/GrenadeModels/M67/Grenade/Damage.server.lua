local Object = script.Parent
local Used = false

local SplashDamage = 150
local Radius = 49.5
local GrenadeArmorFactor = 50

local Tag = Object:WaitForChild("creator")
local Debris = game:GetService("Debris")

function CheckForHumanoid(L_225_arg1)
	local L_226_ = false
	local L_227_ = nil
	if L_225_arg1 then
		if (L_225_arg1.Parent:FindFirstChildOfClass("Humanoid") or L_225_arg1.Parent.Parent:FindFirstChildOfClass("Humanoid")) then
			L_226_ = true
			if L_225_arg1.Parent:FindFirstChildOfClass('Humanoid') then
				L_227_ = L_225_arg1.Parent:FindFirstChildOfClass('Humanoid')
			elseif L_225_arg1.Parent.Parent:FindFirstChildOfClass('Humanoid') then
				L_227_ = L_225_arg1.Parent.Parent:FindFirstChildOfClass('Humanoid')
			end
		else
			L_226_ = false
		end	
	end
	return L_226_, L_227_
end

function Explode()


	local Explosion = Instance.new("Explosion")
	Explosion.BlastRadius = Radius*.875
	Explosion.BlastPressure = 0
	Explosion.Position = Object.Position
	Explosion.Parent = Object

	for i,v in pairs(game.Players:GetPlayers())do
		if v.Character then
			if v.Character:FindFirstChild("HumanoidRootPart") then
				local HM = v.Character:FindFirstChild("HumanoidRootPart")
				if (HM.Position - Object.Position).magnitude <= Radius then
					
					local ray = Ray.new(Object.Position, (HM.Position - Object.Position).unit * 1000)
					local part, position = workspace:FindPartOnRay(ray, Object, false, true)

					if part then
						local FoundHuman,VitimaHuman = CheckForHumanoid(part)

						if FoundHuman and VitimaHuman.Health > 0 then
							local DistanceFactor = (HM.Position - Object.Position).magnitude/Radius
							DistanceFactor = 1-DistanceFactor
							local HitDamage = DistanceFactor*SplashDamage
							VitimaHuman:TakeDamage(HitDamage)
							
							local TagC = Tag:Clone()
							TagC.Parent = VitimaHuman
							Debris:AddItem(TagC,1)
						end
					end
				end
			end
		end
	end

	wait(5)
	Object:Destroy()
end

--helpfully checks a table for a specific value
function contains(t, v)
	for _, val in pairs(t) do
		if val == v then
			return true
		end
	end
	return false
end

--used by checkTeams


--use this to determine if you want this human to be harmed or not, returns boolean

function boom()
	wait(3)
	Used = true
	Object.Anchored = true
	Object.CanCollide = false
	Object.Transparency = 1
	Object:AddTag("3DSoundEmitter"); Object.Explode:Play()
	Explode()
end

boom()