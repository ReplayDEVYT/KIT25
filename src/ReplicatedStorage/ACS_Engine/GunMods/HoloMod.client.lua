--[[	
	
	// True-Holo Sight | Flashlitgh | Laser Mod
	 
	// scripted by spite90

	// Modified by 00scorpion00
	
--]]

local cam = game.Workspace.CurrentCamera
local runservice = game:GetService("RunService")

local gun
local t = 0

while not gun do --Waits for the gun for a second
	local model = cam:FindFirstChildOfClass("Model")
	if model then
		gun = model:FindFirstChild(model.Name)
	end
	t = t+wait()
	
end

function check()
for _,obj in pairs(gun:GetDescendants())do
	if obj:IsA("BasePart") and string.match(obj.Name,"ProjectorSight") then
			local gui = obj.SurfaceGui
			--gui.AlwaysOnTop = true
		gui.Adornee = obj
		local reticle = gui.ClippingFrame.Reticle
		local SizeX,SizeY = gui.ClippingFrame.Reticle.Size.X.Offset,gui.ClippingFrame.Reticle.Size.Y.Offset

		runservice.Stepped:connect(function()
				local HoloSize = ((cam.FieldOfView/70))
				if reticle:FindFirstChild("PosOnly") == nil then
			--reticle.Size = UDim2.new(0, SizeX * HoloSize, 0, SizeY * HoloSize)
				end
				local dist_scale = obj.CFrame:pointToObjectSpace(cam.CFrame.Position)/obj.Size
				if reticle:FindFirstChild("SizeOnly") == nil then
					reticle.Position=UDim2.new(.5+dist_scale.x,0,.5-dist_scale.y,0)	
					end
		end)
	end
	end
end
check()

gun.DescendantAdded:connect(check)
