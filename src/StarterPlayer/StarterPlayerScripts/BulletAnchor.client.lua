local space = workspace.Terrain

space.ChildAdded:Connect(function(child)
	if child:IsA("BasePart") then
		local anchored
		repeat
			if child.Velocity.Magnitude < 0.01 then
				if not anchored then
					coroutine.wrap(function()
						wait(1)
						if child.Velocity.Magnitude < 0.01 and not anchored then
							anchored = true
						end
					end)()
				end
				if anchored then
					child.Anchored = true
					child.Velocity = Vector3.new(0,0,0)
					child.CanCollide = false
				end
			end
			wait(0.1)
		until anchored
	end
end)