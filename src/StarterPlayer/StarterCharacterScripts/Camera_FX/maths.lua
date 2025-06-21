local physics = {}

do
	local sort = table.sort
  	local atan2 = math.atan2
  	local inf = math.huge
  	local cos = math.cos
  	local sin = math.sin
  	local setmetatable = setmetatable
  	local tick = tick
  	local dot = Vector3.new().Dot
  	physics.spring = {}
  	do
    	local spring = {}
    	physics.spring = spring
    	local tick = tick
    	local setmt = setmetatable
    	local cos = math.cos
    	local sin = math.sin
    	local e = 2.718281828459045
    	function spring.new(init)
      		local null = 0 * (init or 0)
      		local d = 1
      		local s = 1
      		local p0 = init or null
      		local v0 = null
      		local p1 = init or null
      		local t0 = tick()
      		local h = 0
      		local c1 = null
      		local c2 = null
      		local self = {}
      		local meta = {}
      		local function updateconstants()
        		if s == 0 then
          			h = 0
          			c1 = null
          			c2 = null
        		elseif d < 0.99999999 then
          			h = (1 - d * d) ^ 0.5
          			c1 = p0 - p1
          			c2 = d / h * c1 + v0 / (h * s)
        		elseif d < 1.00000001 then
          			h = 0
          			c1 = p0 - p1
          			c2 = c1 + v0 / s
        		else
         			h = (d * d - 1) ^ 0.5
          			local a = -v0 / (2 * s * h)
          			local b = -(p1 - p0) / 2
          			c1 = (1 - d / h) * b + a
          			c2 = (1 + d / h) * b - a
        		end
      		end
      		local function pos(x)
        		if x < 0.001 then
          			return p0
        		end
        		if s == 0 then
          			return p0
        		elseif d < 0.99999999 then
          			local co = cos(h * s * x)
          			local si = sin(h * s * x)
          			local ex = e ^ (d * s * x)
          			return co / ex * c1 + si / ex * c2 + p1
        		elseif d < 1.00000001 then
          			local ex = e ^ (s * x)
          			return (c1 + s * x * c2) / ex + p1
        		else
         			local co = e ^ ((-d - h) * s * x)
          			local si = e ^ ((-d + h) * s * x)
          			return c1 * co + c2 * si + p1
        		end
      		end
      		local function vel(x)
        		if x < 0.001 then
          			return v0
       			end
        		if s == 0 then
          			return p0
        		elseif d < 0.99999999 then
          			local co = cos(h * s * x)
          			local si = sin(h * s * x)
          			local ex = e ^ (d * s * x)
          			return s * (co * h - d * si) / ex * c2 - s * (co * d + h * si) / ex * c1
        		elseif d < 1.00000001 then
          			local ex = e ^ (s * x)
          			return -s / ex * (c1 + (s * x - 1) * c2)
        		else
          			local co = e ^ ((-d - h) * s * x)
          			local si = e ^ ((-d + h) * s * x)
          			return si * (h - d) * s * c2 - co * (d + h) * s * c1
        		end
      		end
      		local function posvel(x)
        		if s == 0 then
          			return p0
        		elseif d < 0.99999999 then
          			local co = cos(h * s * x)
          			local si = sin(h * s * x)
          			local ex = e ^ (d * s * x)
          			return co / ex * c1 + si / ex * c2 + p1, s * (co * h - d * si) / ex * c2 - s * (co * d + h * si) / ex * c1
        		elseif d < 1.00000001 then
          			local ex = e ^ (s * x)
          			return (c1 + s * x * c2) / ex + p1, -s / ex * (c1 + (s * x - 1) * c2)
        		else
          			local co = e ^ ((-d - h) * s * x)
          			local si = e ^ ((-d + h) * s * x)
          			return c1 * co + c2 * si + p1, si * (h - d) * s * c2 - co * (d + h) * s * c1
        		end
      		end
      		updateconstants()
      		function self.getpv()
        		return posvel(tick() - t0)
      		end
      		function self.setpv(p, v)
        		local time = tick()
        		p0, v0 = p, v
        		t0 = time
        		updateconstants()
      		end
      		function self:accelerate(a)
        		local time = tick()
        		local p, v = posvel(time - t0)
        		p0, v0 = p, v + a
        		t0 = time
        		updateconstants()
      		end
      		function meta:__index(index)
        		local time = tick()
        		if index == "p" then
          			return pos(time - t0)
        		elseif index == "v" then
          			return vel(time - t0)
        		elseif index == "t" then
          			return p1
        		elseif index == "d" then
          			return d
        		elseif index == "s" then
          			return s
        		end
      		end
      		function meta:__newindex(index, value)
        		local time = tick()
        		if index == "p" then
          			p0, v0 = value, vel(time - t0)
        		elseif index == "v" then
          			p0, v0 = pos(time - t0), value
        		elseif index == "t" then
          			p0, v0 = posvel(time - t0)
          			p1 = value
        		elseif index == "d" then
          			if value == nil then
            			warn("nil value for d")
            			warn(debug.stacktrace())
            			value = d
          			end
          			p0, v0 = posvel(time - t0)
          			d = value
        		elseif index == "s" then
          			if value == nil then
            			warn("nil value for s")
            			warn(debug.stacktrace())
            			value = s
          			end
          			p0, v0 = posvel(time - t0)
          			s = value
        		elseif index == "a" then
          			local p, v = posvel(time - t0)
          			p0, v0 = p, v + value
        		end
        		t0 = time
        		updateconstants()
      		end
      		return setmt(self, meta)
    	end
	end
  	local err = 1.0E-10
  	local function solve(a, b, c, d, e)
    	if not a then
      		return
    	elseif a > -err and a < err then
      		return solve(b, c, d, e)
    	end
    	if e then
      		local k = -b / (4 * a)
      		local p = (8 * a * c - 3 * b * b) / (8 * a * a)
      		local q = (b * b * b + 8 * a * a * d - 4 * a * b * c) / (8 * a * a * a)
      		local r = (16 * a * a * b * b * c + 256 * a * a * a * a * e - 3 * a * b * b * b * b - 64 * a * a * a * b * d) / (256 * a * a * a * a * a)
      		local h0, h1, h2 = solve(1, 2 * p, p * p - 4 * r, -q * q)
      		local s = h2 or h0
      		if s < err then
        		local f0, f1 = solve(1, p, r)
        		if not f1 or f1 < 0 then
          			return
        		else
          			local f = f1 ^ 0.5
          			return k - f, k + f
        		end
      		else
        		local h = s ^ 0.5
        		local f = (h * h * h + h * p - q) / (2 * h)
        		if f > -err and f < err then
          			return k - h, k
        		else
          			local r0, r1 = solve(1, h, f)
          			local r2, r3 = solve(1, -h, r / f)
          			if r0 and r2 then
            			return k + r0, k + r1, k + r2, k + r3
          			elseif r0 then
            			return k + r0, k + r1
          			elseif r2 then
            			return k + r2, k + r3
          			else
            			return
          			end
        		end
      		end
    	elseif d then
      		local k = -b / (3 * a)
      		local p = (3 * a * c - b * b) / (9 * a * a)
      		local q = (2 * b * b * b - 9 * a * b * c + 27 * a * a * d) / (54 * a * a * a)
      		local r = p * p * p + q * q
      		local s = r ^ 0.5 + q
      		if s > -err and s < err then
        		if q < 0 then
          			return k + (-2 * q) ^ 0.3333333333333333
        		else
          			return k - (2 * q) ^ 0.3333333333333333
        		end
      		elseif r < 0 then
        		local m = (-p) ^ 0.5
        		local d = atan2((-r) ^ 0.5, q) / 3
        		local u = m * cos(d)
        		local v = m * sin(d)
        		return k - 2 * u, k + u - 1.7320508075688772 * v, k + u + 1.7320508075688772 * v
      		elseif s < 0 then
        		local m = -(-s) ^ 0.3333333333333333
        		return k + p / m - m
      		else
        		local m = s ^ 0.3333333333333333
        		return k + p / m - m
      		end
    	elseif c then
      		local k = -b / (2 * a)
      		local u2 = k * k - c / a
      		if u2 < 0 then
        		return
      		else
        		local u = u2 ^ 0.5
        		return k - u, k + u
      		end
    	elseif b then
      		return -b / a
    	else
      		return
    	end
  	end
  	physics.solve = solve
  	local minpos = function(a, b, c, d)
    	if a and a >= 0 then
      		return a
    	elseif b and b >= 0 then
      		return b
    	elseif c and c >= 0 then
      		return c
    	elseif d and d >= 0 then
      		return d
    	end
  	end
  	physics.minpos = minpos
  	local function minposroot(a, b, c, d, e)
    	return minpos(solve(a, b, c, d, e))
  	end
  	physics.minposroot = minposroot
  	function physics.cpoint_traj_point(v, a, r)
    	local a0 = -2 * dot(r, v)
    	local a1 = 2 * (dot(v, v) - dot(a, r))
    	local a2 = 3 * dot(a, v)
    	local a3 = dot(a, a)
    	local t = minpos(solve(a3, a2, a1, a0))
    	if t then
      		return t, t * v + t * t / 2 * a
    	end
  	end
  	function physics.simple_trajectory(s, a, r)
    	local a0 = 4 * dot(r, r)
    	local a1 = -4 * (dot(a, r) + s * s)
    	local a2 = dot(a, a)
    	local u = minpos(solve(a2, a1, a0))
    	if u then
      		local t = u ^ 0.5
      		return r / t - t / 2 * a
    	end
  	end
  	function physics.trajectory(pp, pv, pa, tp, tv, ta, s)
    	local rp = tp - pp
    	local rv = tv - pv
    	local ra = ta - pa
    	local t0, t1, t2, t3 = solve(dot(ra, ra) / 4, dot(ra, rv), dot(ra, rp) + dot(rv, rv) - s * s, 2 * dot(rp, rv), dot(rp, rp))
    	if t0 and t0 > 0 then
      		return ra * t0 / 2 + tv + rp / t0, t0
    	elseif t1 and t1 > 0 then
      		return ra * t1 / 2 + tv + rp / t1, t1
    	elseif t2 and t2 > 0 then
      		return ra * t2 / 2 + tv + rp / t2, t2
    	elseif t3 and t3 > 0 then
      		return ra * t3 / 2 + tv + rp / t3, t3
    	end
  	end
end

return physics