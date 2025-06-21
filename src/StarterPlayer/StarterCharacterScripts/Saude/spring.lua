local spring_service = {}
local run_service = game:GetService('RunService')

local running = {}

local meta = {
	__index = function(self, i)
		return rawget(self, i) or rawget(spring_service, i) or nil
	end
}

function spring_service.new(d, k)
	local data = setmetatable({
		position = 0,
		velocity = 0,
		target = 0,

		d = d,
		k = k,
	}, meta)

	running[data] = true

	return data
end

function spring_service:step(start, velocity, goal, stiffness, dampening, delta_time)
	self.velocity = velocity + ((-stiffness * (start-goal))+(-dampening * velocity)) * delta_time
	self.position += self.velocity * delta_time
end

run_service.RenderStepped:Connect(function(delta_time)
	for v in next, running do
		v:step(v.position, v.velocity, v.target, v.k, v.d, math.min(delta_time, 0.02))
	end
end)

return spring_service
