repeat wait() until game:GetService('Players').LocalPlayer and game:GetService('Players').LocalPlayer.Character and workspace.CurrentCamera

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Camera = workspace.CurrentCamera
local spring = require(script.maths)

local TargetEvent
if RunService:IsClient() then
	TargetEvent = RunService.RenderStepped
else
	TargetEvent = RunService.Heartbeat
end

local generalSettings = {
	canSwing = true;
	canBobble = true;
	canAim = true;

	fpsCam = true;
	camBobble = false;
	camImpact = true;
	camHurt = true;

	lowestFallHeight = 20;
	maxFallHeight = 30;
}

--legends:
--[s]: speed
--[d]: damper
--[t]: target
--[p]: position
--[v]: velocity
local speedSpring = spring.spring.new()
speedSpring.s = 8
local swaySpring = spring.spring.new(0)
swaySpring.s = 4
swaySpring.d = 1
local swaySpeed = spring.spring.new(0)
swaySpeed.s = 6
swaySpeed.d = 1
swaySpeed.t = 1
local damageSpring = spring.spring.new(Vector3.new())
damageSpring.s = 20
damageSpring.d = 0.75
local impactSpring = spring.spring.new(Vector3.new())
impactSpring.s	= 15
impactSpring.d	= 1
local velocitySpring = spring.spring.new(Vector3.new())
velocitySpring.s = 16
velocitySpring.t = Vector3.new()
velocitySpring.p = Vector3.new()
local aimSpring = spring.spring.new()
aimSpring.s = 15
aimSpring.d = 0.9
aimSpring.t = 1
local swingSpring = spring.spring.new(Vector3.new())
swingSpring.s = 10
swingSpring.d = 0.75

local offStates = {"PlatformStanding", "Ragdoll", "Seated", "GettingUp", "Swimming", "Climbing"}
local onStates = {"Jumping","Running","FreeFalling","FallingDown"}

local velocity = Vector3.new()
local speed = 0
local distance = 0
local swayt = 0
local lastHealth = Humanoid.Health
local isFalling = false
local deb = false
local active

for _,state in pairs(offStates) do
	Humanoid[state]:Connect(function()
		active = false
	end)
end

for _,state in pairs(onStates) do
	Humanoid[state]:Connect(function(speed)
		active = true
	end)
end

local function ToQuaternion(c)
	local x,y,z,
		xx,yx,zx,
		xy,yy,zy,
		xz,yz,zz=CFrame.new().components(c)
	local tr=xx+yy+zz
	if tr>2.99999 then
		return x,y,z,0,0,0,1
	elseif tr>-0.99999 then
		local m=2*(tr+1)^0.5
		return x,y,z,
			  (yz-zy)/m,
			  (zx-xz)/m,
			  (xy-yx)/m,
			  m/4
	else
		local qx=xx+yx+zx+1
		local qy=xy+yy+zy+1
		local qz=xz+yz+zz+1
		local m	=(qx*qx+qy*qy+qz*qz)^0.5
		return x,y,z,qx/m,qy/m,qz/m,0
	end
end

local toQuaternion=ToQuaternion
local function interpolator(c0,c1)
	if c1 then
		local x0,y0,z0,qx0,qy0,qz0,qw0=toQuaternion(c0)
		local x1,y1,z1,qx1,qy1,qz1,qw1=toQuaternion(c1)
		local x,y,z=x1-x0,y1-y0,z1-z0
		local c=qx0*qx1+qy0*qy1+qz0*qz1+qw0*qw1
		if c<0 then
			qx0,qy0,qz0,qw0=-qx0,-qy0,-qz0,-qw0
		end
		if c<0.9999 then
			local s=(1-c*c)^0.5
			local th=math.acos(c)
			return function(t)
				local s0=math.sin(th*(1-t))/s
				local s1=math.sin(th*t)/s
				return CFrame.new(
					x0+t*x,
					y0+t*y,
					z0+t*z,
					s0*qx0+s1*qx1,
					s0*qy0+s1*qy1,
					s0*qz0+s1*qz1,
					s0*qw0+s1*qw1
				)
			end
		else
			return function(t)
				return CFrame.new(x0+t*x,y0+t*y,z0+t*z,qx1,qy1,qz1,qw1)
			end
		end
	else
		local x,y,z,qx,qy,qz,qw=ToQuaternion(c0)
		if qw<0.9999 then
			local s=(1-qw*qw)^0.5
			local th=math.acos(qw)
			return function(t)
				local s1=math.sin(th*t)/s
				return CFrame.new(
					t*x,
					t*y,
					t*z,
					s1*qx,
					s1*qy,
					s1*qz,
					math.sin(th*(1-t))/s+s1*qw
				)
			end
		else
			return function(t)
				return CFrame.new(t*x,t*y,t*z,qx,qy,qz,qw)
			end
		end
	end
end

local function fromAxisAngle(x,y,z)
	if not y then
		x,y,z=x.x,x.y,x.z
	end
	local m=(x*x+y*y+z*z)^0.5
	if m>1e-5 then
		local si=math.sin(m/2)/m
		return CFrame.new(0,0,0,si*x,si*y,si*z,math.cos(m/2))
	else
		return CFrame.new()
	end
end

local function gunBob(a, r, baseWalkSpeed)
	local a, r = a or 1, r or 1
	local d, s, v = distance * 6.28318 * 3 / 4, speed, -velocity
	local w = Vector3.new(r * math.sin(d / 4 - 1) / 256 + r * (math.sin(d / 64) - r * v.z / 4) / 512, r * math.cos(d / 128) / 128 - r * math.cos(d / 8) / 256, r * math.sin(d / 8) / 128 + r * v.x / 1024) * s / 20 * 6.28318
	return CFrame.new(r * math.cos(d / 8 - 1) * s / 196, 1.25 * a * math.sin(d / 4) * s / 512, 0) * fromAxisAngle(w)
end

local function gunSway(a)
    local d, s = tick() * 6, 2 * (1.2 - a)
    return CFrame.new(math.cos(d / 8) * s / 128, -math.sin(d / 4) * s / 128, math.sin(d / 16) * s / 64)
end

local OnStep do
	OnStep = TargetEvent:Connect(function(dt)
		if Character and HumanoidRootPart and Humanoid then
			if Character == nil and (Humanoid ~= nil and Humanoid.Health <= 0) then
				OnStep:Disconnect()
				--[[if OnStep then
					OnStep:Disconnect()
					OnStep = nil
				end]]
			end
			local mouseDelta = game:GetService("UserInputService"):GetMouseDelta()
	    	local a = velocitySpring.v
	    	swingSpring.t = Vector3.new(a.z / 1024 / 32 + a.y / 1024 / 16 + (mouseDelta.y / 10) / 1024 * 3 / 2, a.x / 1024 / 32 + (mouseDelta.x / 10) / 1024 * 3 / 2, -(mouseDelta.x / 10) / 1024 * 3 / 2)
			local aim = aimSpring.p
			local relv = CFrame.new().VectorToObjectSpace(HumanoidRootPart.CFrame, HumanoidRootPart.Velocity)
			speedSpring.t = (active and Humanoid.Health > 0) and (Vector3.new(1, 0, 1) * relv).magnitude or 0
			velocitySpring.t = relv
			speed = speedSpring.p
			distance = distance + dt * speedSpring.p
			velocity = velocitySpring.p
			swayt = swayt + dt * swaySpeed.p
			if generalSettings.fpsCam then -- CAMERA SWAY CODE (took long enough to find, jeez)
				local cf = CFrame.new()
				cf = Camera.CoordinateFrame
			    local t = swayt
			    local s, d = 2 * speed * dt, distance * 6.28318 / 4 * 3 / 4
			    local ss = swaySpring.p
			    local bobAngles = fromAxisAngle(s * math.cos(d + 2) / 6048 * dt, s * math.cos(d / 2) / 6048 * dt, s * math.cos(d / 2 + 2) / 6096) * fromAxisAngle(ss * math.cos(2 * t + 2) / 2048, ss * math.cos(2 * t / 2) / 2048, ss * math.cos(2 * t / 2 - 2) / 4096 * dt)
				local VMbobAngles = fromAxisAngle(s * math.cos(d + 2) / -2048, s * math.cos(d / 2) / -2048, s * math.cos(d / 2 + 2) / -4096) * fromAxisAngle(ss * math.cos(2 * t + 2) / 2048, ss * math.cos(2 * t / 2) / 2048, ss * math.cos(2 * t / 2 - 2) / 4096)
				
				local damageAngles = fromAxisAngle(damageSpring.p)
				local impactAngles = fromAxisAngle(impactSpring.p)
				if generalSettings.camBobble and active == true then
					cf = cf * bobAngles
					HumanoidRootPart.CFrame = HumanoidRootPart.CFrame*VMbobAngles
				end
				if generalSettings.camHurt then
					cf = cf * damageAngles
				end
				if generalSettings.camImpact then
					cf = cf * impactAngles
				end
				Camera.CoordinateFrame = cf
			end
			
				local cf = CFrame.new()
				cf = Camera.CoordinateFrame
				
				if generalSettings.canSwing then
					cf = cf * fromAxisAngle(swingSpring.v)
				end
				if generalSettings.canBobble then
					cf = cf * gunBob(0.7 - 0.3 * aimSpring.p, 1 - 0.8 * aimSpring.p, Humanoid.WalkSpeed) * gunSway(aim)
				end
			end
	end)
end