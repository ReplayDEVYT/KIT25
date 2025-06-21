local smoothness = 30/3
wait(1)
local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
local dev = script.Parent
local lastY = 0
local units = {
	[dev.N ] = math.pi/2;      -- North
	[dev.n1 ] = 10/18*math.pi;  -- 010
	[dev.n2 ] = 11/18*math.pi;    -- 020
	[dev.E ] = math.pi;        -- East
	[dev.e1 ] = 19/18*math.pi;  -- 100
	[dev.e2 ] = 10/9*math.pi;   -- 110
	[dev.S ] =  3*math.pi/2;   -- South
	[dev.s1 ] =  14/9*math.pi;  -- 190	
	[dev.s2 ] =  29/18*math.pi; -- 200
	[dev.W ] =  2*math.pi;     -- West
	[dev.w1 ] =  37/18*math.pi; -- 280
	[dev.w2 ] =  19/9*math.pi;  -- 290
	[dev.A] =  2*math.pi/3;    -- 030 (120)
	[dev.a1] =  13/18*math.pi;  -- 040
	[dev.a2] =  7/9*math.pi;    -- 050
	[dev.B] =  5*math.pi/6;	   -- 060 (150)
	[dev.b1] =  8/9*math.pi;	-- 070
	[dev.b2] =  17/18*math.pi;	-- 080
	[dev.C] =  7*math.pi/6;    -- 120 (210)
	[dev.c1] =  11/9*math.pi;   -- 130
	[dev.c2] =  23/18*math.pi;  -- 140
	[dev.D] =  4*math.pi/3;    -- 150 (240)
	[dev.d1] =  25/18*math.pi;  -- 160
	[dev.d2] =  13/9*math.pi;   -- 170
	[dev.F] =  5*math.pi/3;    -- 210 (300)
	[dev.f1] =  31/18*math.pi;  -- 220
	[dev.f2] =  16/9*math.pi;   -- 230
	[dev.G] =  11*math.pi/6;   -- 240 (330)
	[dev.g1] =  17/9*math.pi;   -- 250
	[dev.g2] =  35/18*math.pi;   -- 260
	[dev.H] =  math.pi/6;      -- 300 (390)
	[dev.h1] =  20/9*math.pi;   -- 310
	[dev.h2] =  41/18*math.pi;  -- 320
	[dev.I] =  math.pi/3;      -- 330 (420)
	[dev.i1] =  43/18*math.pi;  -- 340
	[dev.i2] =  22/9*math.pi;   -- 350
}

function restrictAngle(angle)
	if angle < -math.pi then
		return angle + math.pi*2
	elseif angle > math.pi then
		return angle - math.pi*2
	else
		return angle
	end
end

while true do
	local delta = wait(1 / 30)
	local look = camera.CoordinateFrame.lookVector
	local look = Vector3.new(look.x, 0, look.z).unit
	local lookY = math.atan2(look.z, look.x)
	local difY = restrictAngle(lookY - lastY)
	lookY = restrictAngle(lastY + difY*delta*smoothness)
	lastY = lookY
	for unit, rot in pairs(units) do
		rot = restrictAngle(lookY - rot)
		if math.sin(rot) > 0 then
			local cosRot = math.cos(rot)
			local cosRot2 = cosRot * cosRot
			unit.Visible = true
			unit.Position = UDim2.new(0.5 + cosRot * 0.6, unit.Position.X.Offset, 0, 3)
			unit.TextTransparency = 2 * cosRot2
		else
			unit.Visible = false
		end
	end
end