--[[
	WRITTEN BY @Vergoblis, THIS IS A PUBLIC MODULE
]]

local TweenService = game:GetService("TweenService")

return function(TweenObject, TweenInfo, TweenProperties, keepAlive)
	local Tween = TweenService:Create(TweenObject,TweenInfo,TweenProperties)

	if keepAlive == nil or not keepAlive then
		Tween.Completed:Once(function()
			Tween:Destroy()
			Tween = nil
		end)
	end
	return Tween
end