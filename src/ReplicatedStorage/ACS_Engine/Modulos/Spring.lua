local Spring = {}

function Spring.new(Initial)
	local t0 = tick()
	local p0 = Initial or 0
	local v0 = Initial and 0*Initial or 0
	local t	= Initial or 0
	local d	= 1
	local s	= 1

	local function positionVelocity(Tick)	
		local x	= Tick - t0
		local c0 = p0 - t
		if s == 0 then
			return p0, 0
		elseif d < 1 then
			local c	= math.sqrt(1 - d ^ 2)
			local c1 = (v0 / s + d * c0) / c
			local co = math.cos(c * s * x)
			local si = math.sin(c * s * x)
			local e	= math.exp(d * s * x)
			return t + (c0 * co + c1 * si) / e,
				s * ((c * c1 - d * c0) * co - (c * c0 + d * c1) * si) / e
		else
			local c1 = v0 / s + c0
			local e	= math.exp(s * x)
			return t + (c0 + c1 * s * x) / e,
				s * (c1 - c0 - c1 * s * x) / e
		end
	end

	return setmetatable(
		{
			accelerate = function(_, acceleration)
				local T = tick()
				local p, v = positionVelocity(T)
				p0 = p
				v0 = v + acceleration
				t0 = T
			end;
		},
		{
			__index = function(_, index)
				if index == "value" or index == "position" or index == "p" then
					local p, v = positionVelocity(tick())
					return p
				elseif index == "velocity" or index == "v" then
					local p, v = positionVelocity(tick())
					return v
				elseif index == "acceleration" or index == "a" then
					local x	= tick() - t0
					local c0 = p0 - t
					if s == 0 then
						return 0
					elseif d < 1 then
						local c = math.sqrt(1 - d ^ 2)
						local c1 = (v0 / s + d * c0) / c
						local cs = (c0 * d ^ 2 - 2 * c * d * c1 - c0 * c ^ 2) * math.cos(c * s * x)
						local sn = (c1 * d ^ 2 + 2 * c * d * c0 - c1 * c ^ 2) * math.sin(c * s * x)
						return s ^ 2 *(cs + sn) / math.exp(d * s * x)
					else
						local c1 = v0 / s + c0
						return s ^ 2 * (c0 - 2 * c1 + c1 * s * x) / math.exp(s * x)
					end
				elseif index == "target" or index == "t" then
					return t
				elseif index == "damper" or index == "d" then
					return d
				elseif index == "speed" or index == "s" then
					return s
				elseif index == "magnitude" or index == "m" then
					local p, v = positionVelocity(tick())
					return p.magnitude
				else
					error(index.." is not a valid member of spring", 0)
				end
			end;

			__newindex = function(_, index, value)
				local T = tick()
				if index == "value" or index == "position" or index == "p" then
					local p, v = positionVelocity(T)
					p0, v0 = value, v
				elseif index == "velocity" or index == "v" then
					local p, v = positionVelocity(T)
					p0, v0 = p, value
				elseif index == "acceleration" or index == "a" then
					local p, v = positionVelocity(T)
					p0, v0 = p, v + value
				elseif index == "target" or index == "t" then
					p0, v0 = positionVelocity(T)
					t = value
				elseif index == "damper" or index == "d" then
					p0, v0 = positionVelocity(T)
					d = value < 0 and 0 or value < 1 and value or 1
				elseif index == "speed" or index == "s" then
					p0, v0 = positionVelocity(T)
					s = value < 0 and 0 or value
				else
					error(index.." is not a valid member of spring", 0)
				end
				t0 = T
			end;
		}
	)
end

return Spring