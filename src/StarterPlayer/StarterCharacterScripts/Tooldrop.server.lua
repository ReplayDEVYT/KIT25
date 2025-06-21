local myHuman = script.Parent:WaitForChild("Humanoid")
local c = script.Parent
myHuman.Died:Connect(function()
	for i,v in ipairs(script.Parent:GetDescendants()) do
		if v:IsA("Motor6D") then
			-- v:Destroy() --Because we disabled Humanoid.BreakJointsOnDeath = false, the character won't move so we have to remove all Motor6D upon death.
			for i,v in ipairs(script.Parent:GetDescendants()) do --Support tool drop
				if v:IsA("BasePart") then
					v.CanCollide = true --Make it cancollide the floor so it won't fall through into the void

					--Tool drop variable

					for i,e in ipairs(c:GetDescendants()) do
						if e:IsA("Tool") then 
							if e:FindFirstChild("ACS_Modulo") == nil then
								e.Parent = workspace
							end
							game:GetService("Debris"):AddItem(e,60) --change this if you want to make them stay longer. i recommended to set it depend on player respawn time because it realistic lol
						end
					end

					for _,b in ipairs(c:GetChildren()) do
						if b:IsA("Model") then
							if b:FindFirstChild("KeepOnDeath") == nil then
								b.Parent = workspace
							end
							game:GetService("Debris"):AddItem(b,60)-- same one as above
						end
					end
				end
			end
		end
	end
end)




--Description

--Sorry for my bad english because English is my second language lol. 