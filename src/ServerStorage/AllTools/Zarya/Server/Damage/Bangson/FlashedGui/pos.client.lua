local rand = math.random(1,2)
script.Parent:WaitForChild("Burn").Image = script:GetChildren()[math.random(#script:GetChildren())].Texture
if rand == 1 then
	script.Parent:WaitForChild("Burn").Rotation = 180
else
	script.Parent:WaitForChild("Burn").Rotation = 0
end
script.Parent.Burn.ImageTransparency = ((script.Parent:WaitForChild("Brightness").Value*-1)/script.Parent:WaitForChild("Time").Value) - 0.5
local TweenService = game:GetService("TweenService")


local tween0 = TweenService:Create(script.Parent.Burn, TweenInfo.new(script.Parent:WaitForChild("Time").Value*3), {ImageTransparency = 1})
tween0:Play()