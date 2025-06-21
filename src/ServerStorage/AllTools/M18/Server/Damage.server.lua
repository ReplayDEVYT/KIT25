local Object = script.Parent
local Used = false

local SplashDamage = 50
local Radius = 10
local GrenadeArmorFactor = 1

local Tag = Object:WaitForChild("creator")
local Debris = game:GetService("Debris")


function OnExplosionHit(Character, hitDistance, blastCenter)
	local Humanoid = Character:FindFirstChild("Humanoid")
	if hitDistance and blastCenter then
		local DistanceFactor = hitDistance/Radius
		DistanceFactor = 1-DistanceFactor
		if Humanoid then
			if Humanoid.Health > 0 then
				if  Humanoid.Parent:FindFirstChild("Saude")~= nil then
					if  Humanoid.Parent.Saude.Protecao.HelmetVida.Value > 0 and Humanoid.Parent.Saude.Protecao.VestVida.Value > 0 then

						if GrenadeArmorFactor <= (Humanoid.Parent.Saude.Protecao.VestBlastProtect.Value + Humanoid.Parent.Saude.Protecao.HelmetBlastProtect.Value) then
							
							local VestMult = ((100 - GrenadeArmorFactor)/(Humanoid.Parent.Saude.Protecao.VestBlastProtect.Value))
							local HelmMult = ((100 - GrenadeArmorFactor)/(Humanoid.Parent.Saude.Protecao.HelmetBlastProtect.Value))
							
							if VestMult > 1 then
								VestMult = 1
							elseif VestMult < 0 then
								VestMult = 0
							end

							if HelmMult > 1 then
								HelmMult = 1
							elseif HelmMult < 0 then
								HelmMult = 0
							end

							local HitDamage = (DistanceFactor*SplashDamage) * (GrenadeArmorFactor/(Humanoid.Parent.Saude.Protecao.VestBlastProtect.Value + Humanoid.Parent.Saude.Protecao.HelmetBlastProtect.Value))
							local VestDamage = ((DistanceFactor*SplashDamage) * VestMult)
							local HelmDamage = ((DistanceFactor*SplashDamage) * HelmMult)
							print("Colete + Helm: " ..HitDamage)
							if VestDamage <= 0 then
								VestDamage = 1
							end
							if HelmDamage <= 0 then
								HelmDamage = 1
							end
							if HitDamage <= 0 then
								HitDamage = 1
							end
							Humanoid.Parent.Saude.Protecao.HelmetVida.Value = Humanoid.Parent.Saude.Protecao.HelmetVida.Value - HelmDamage
							Humanoid.Parent.Saude.Protecao.VestVida.Value = Humanoid.Parent.Saude.Protecao.VestVida.Value - VestDamage
							Humanoid:TakeDamage(HitDamage)
						else
							local HitDamage = DistanceFactor*SplashDamage
							print(HitDamage)
							Humanoid:TakeDamage(HitDamage)
						end

					elseif Humanoid.Parent.Saude.Protecao.HelmetVida.Value > 0 and Humanoid.Parent.Saude.Protecao.VestVida.Value <= 0 then
						if GrenadeArmorFactor <= (Humanoid.Parent.Saude.Protecao.HelmetBlastProtect.Value) then
					
							local HelmMult = ((100 - GrenadeArmorFactor)/(Humanoid.Parent.Saude.Protecao.HelmetBlastProtect.Value))						
							
							if HelmMult > 1 then
								HelmMult = 1
							elseif HelmMult < 0 then
								HelmMult = 0
							end

							local HitDamage = (DistanceFactor*SplashDamage) * (GrenadeArmorFactor/(Humanoid.Parent.Saude.Protecao.VestBlastProtect.Value + Humanoid.Parent.Saude.Protecao.HelmetBlastProtect.Value))
							local HelmDamage = ((DistanceFactor*SplashDamage) * HelmMult)
							
							print("Helm: " ..HitDamage)

							if HelmDamage <= 0 then
								HelmDamage = 1
							end
							if HitDamage <= 0 then
								HitDamage = 1
							end

							Humanoid.Parent.Saude.Protecao.HelmetVida.Value = Humanoid.Parent.Saude.Protecao.HelmetVida.Value - HelmDamage
							Humanoid:TakeDamage(HitDamage)
						else
							local HitDamage = DistanceFactor*SplashDamage
							print(HitDamage)
							Humanoid:TakeDamage(HitDamage)
						end

					elseif Humanoid.Parent.Saude.Protecao.HelmetVida.Value <= 0 and Humanoid.Parent.Saude.Protecao.VestVida.Value > 0 then
						if GrenadeArmorFactor <= (Humanoid.Parent.Saude.Protecao.VestBlastProtect.Value) then
							
							local VestMult = ((100 - GrenadeArmorFactor)/(Humanoid.Parent.Saude.Protecao.VestBlastProtect.Value))
							
							if VestMult > 1 then
								VestMult = 1
							elseif VestMult < 0 then
								VestMult = 0
							end


							local HitDamage = (DistanceFactor*SplashDamage) * (GrenadeArmorFactor/(Humanoid.Parent.Saude.Protecao.VestBlastProtect.Value + Humanoid.Parent.Saude.Protecao.HelmetBlastProtect.Value))
							local VestDamage = ((DistanceFactor*SplashDamage) * VestMult)

							print("Colete: " ..HitDamage)
							if VestDamage <= 0 then
								VestDamage = 1
							end
							if HitDamage <= 0 then
								HitDamage = 1
							end
							Humanoid.Parent.Saude.Protecao.VestVida.Value = Humanoid.Parent.Saude.Protecao.VestVida.Value - VestDamage
							Humanoid:TakeDamage(HitDamage)
						else
							local HitDamage = DistanceFactor*SplashDamage
							print(HitDamage)
							Humanoid:TakeDamage(HitDamage)
						end

					elseif Humanoid.Parent.Saude.Protecao.HelmetVida.Value <= 0 and Humanoid.Parent.Saude.Protecao.VestVida.Value <= 0 then
						local HitDamage = DistanceFactor*SplashDamage
						print(HitDamage)
						Humanoid:TakeDamage(HitDamage)
					end
				else
					local HitDamage = DistanceFactor*SplashDamage
					print(HitDamage)
					Humanoid:TakeDamage(HitDamage)
				end
			end
		end
	end
end

function Explode()
	wait(1)
	Object.Explosion:Emit(100)
	Object.Sparks:Emit(50)
	wait(1)
	Object.Fuse:Play()
	Object.Smoke1.Enabled = true
	wait(2)
	Object.Smoke2.Enabled = true
	wait(3)
	Object.Smoke3.Enabled = true
	wait(2)
	Object.Smoke4.Enabled = true
	wait(40)
	Object.Fuse:Stop()
	Object.Smoke1.Enabled = false
	Object.Smoke2.Enabled = false
	Object.Smoke3.Enabled = false
	wait(5)
	Object:Destroy()
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

function tagHuman(human)
	local tag = Tag:Clone()
	tag.Parent = human
	game:GetService("Debris"):AddItem(tag)
end

--use this to determine if you want this human to be harmed or not, returns boolean

function boom()
	wait(1)
	Used = true
	Object.Anchored = false
	--Object.Orientation = Vector3.new(0,0,0)
	Object.Transparency = 1
	Explode()
end

Object.Touched:Connect(function(part)
	if Used == true or part.Name == "Handle" then return end
	if part:IsDescendantOf(Tag.Value.Character) then return end
	if part.Parent then
		Used = true
		local SSS = game:GetService("ServerScriptService")
		local BreakModule = require(SSS:WaitForChild("PartFractureModule"))
		local HitPart = part
		local shattersfx = game.ReplicatedStorage.ACS_Engine.Shatter:GetChildren()
		local PhysicsService = game:GetService("PhysicsService")
		if HitPart ~= nil and HitPart.Name == "BreakableObj" or HitPart.Material == Enum.Material.Glass and HitPart.Parent.Name ~= "Top" or (HitPart.Transparency >= 0.15 and HitPart.Transparency < 1 and HitPart.Parent.Name ~= "Top" and HitPart.Name ~= "Ignorable" and (HitPart.Material == Enum.Material.Glass)) then --Name of the part that's breakable.
			if HitPart ~= nil then
				local BreakingPoint = HitPart:FindFirstChild("BreakingPoint") --Finds the BReaking Point Attachment.
				if BreakingPoint and BreakingPoint:IsA("Attachment") then
					BreakingPoint.WorldPosition = BreakingPoint.WorldPosition * Vector3.new(0,Object.Position.Y,Object.Position.Z) -- Break position = bullet hit posisiton. 
					BreakingPoint.Position = Vector3.new(0, BreakingPoint.Position.Y, BreakingPoint.Position.Z) 
					PhysicsService:SetPartCollisionGroup(HitPart, "GlassParts")
					BreakModule.FracturePart(HitPart) -- Calls the module that will be given on the bottom of this message.
				else
					local breakpart = game.ReplicatedStorage.ACS_Engine.breakpart
					for i,v in pairs (breakpart:GetChildren()) do
						v:Clone().Parent = HitPart
					end
					local BreakingPoint2 = HitPart:FindFirstChild("BreakingPoint") --Finds the BReaking Point Attachment.
					if BreakingPoint2 and BreakingPoint2:IsA("Attachment") then
						if HitPart.Material ~= Enum.Material.Wood and HitPart.Material ~= Enum.Material.WoodPlanks then
							HitPart:WaitForChild("BreakSound").SoundId = shattersfx[math.random(#shattersfx)].SoundId
						end
						BreakingPoint2.WorldPosition = Object.Position -- Break position = bullet hit posisiton. 
						BreakingPoint2.Position = Vector3.new(0, BreakingPoint2.Position.Y, BreakingPoint2.Position.Z) 
						BreakingPoint2.WorldOrientation = HitPart.Orientation
						BreakModule.FracturePart(HitPart) -- Calls the module that will be given on the bottom of this message.
					end
				end
			end
		end
		local list = Object.ImpactSound:GetChildren()
		local chosen = list[math.random(#list)].SoundId
		Object.Impact.SoundId = chosen
		Object.Impact:Play()
		for i,x in pairs(Object:GetChildren()) do
			if x:IsA("BasePart") then
				PhysicsService:SetPartCollisionGroup(x, "GlassParts")
				end
			end
		Object.Velocity = Vector3.new(Object.Velocity.x/10,Object.Velocity.y/10,Object.Velocity.z/10)
		Object.RotVelocity = Vector3.new(Object.RotVelocity.x/10,Object.RotVelocity.y/10,Object.RotVelocity.z/10)
		game:GetService("Debris"):AddItem(Object, 10)
	end
end)
for i,v in pairs(Object:GetDescendants()) do
	if v:IsA("Sound") then
		v.SoundGroup = game.SoundService.All.Throwables
	end
end
boom()