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

if gun and gun:FindFirstChild('Screen') and gun:FindFirstChild('Cam') then
	local GUI = gun.Screen.SurfaceGui
	local Frame = GUI:WaitForChild("Frame")
	local CamPart = gun:FindFirstChild("Cam")
	local FovX = GUI:FindFirstChild("FOVX") and GUI.FOVX.Value or 15 --horizontal field of view
	local FovY = GUI:FindFirstChild("FOVY") and GUI.FOVY.Value or 15 --vertical field of view
	local ResX = 0
	local ResY = 0
	local CamOn = false
	local Range = GUI:FindFirstChild("Ranging") and GUI.Ranging.Value or 150 --View Range
	local FPS = 20 --Frames per second
	local RenderDelay = 1
	local lasttick = 0
	local function Render()
		if CamOn == true and tick()-lasttick > 1/FPS then
			local unitX = FovX/ResX
			local unitY = FovY/ResX
			local anchorX = FovX/2
			local anchorY = FovY/2
			for y=1,ResY do
				for x=1,ResX do
					local currentpixel = Frame["X"..x.."Y"..y]
					local AngleX = math.rad(anchorX-(x-0.5)*unitX)
					local AngleY = math.rad(anchorY-(y-0.5)*unitY)
					local newray = Ray.new(CamPart.Position, (CamPart.CFrame*CFrame.Angles(0,AngleX,0)*CFrame.Angles(AngleY,0,0)).lookVector*Range) 
					local hitpart = game.Workspace:FindPartOnRay(newray, gun)	
					currentpixel.BackgroundColor3 = hitpart and (hitpart.Parent:FindFirstChild('Humanoid') and hitpart.Parent:FindFirstChild('NoThermal') == nil or hitpart.Material == Enum.Material.Neon) and ((GUI:FindFirstChild("HotColor") and GUI.HotColor.Value) or Color3.fromRGB(0,0,0)) or (hitpart and hitpart.Parent:FindFirstChild("KeepOnDeath") == nil and hitpart.Parent:FindFirstChild("NoThermal") == nil and hitpart.Parent:FindFirstChild("Middle") == nil and ((GUI:FindFirstChild("ColdColor") and GUI.ColdColor.Value) or hitpart == nil) or Color3.fromRGB(148, 202, 154))
				end
			end
			lasttick = tick()
			--wait(RenderDelay)
		end
	end

	local function NewResolution(resX,resY)
		CamOn = false
		Frame:ClearAllChildren()
		local pixelsmade = 0
		for y=1,resY do
			for x=1,resX do
				local sizeX = 1/resX
				local sizeY = 1/resY
				local pixel = Instance.new("TextLabel")
				pixel.BackgroundColor3 = Color3.new(1,1,1)
				pixel.BorderSizePixel = 0
				pixel.Size = UDim2.new(sizeX,0,sizeY,0)
				pixel.Position = UDim2.new(sizeX*(x-1),0,sizeY*(y-1),0)
				pixel.Text = ""
				pixel.Name = "X"..x.."Y"..y
				pixel.Parent = Frame
			end	
		end
		ResX = resX
		ResY = resY
		CamOn = true
	end
	runservice.Heartbeat:Connect(Render)

	NewResolution(40,40) --Change resolution here
end
