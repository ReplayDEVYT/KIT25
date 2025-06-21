local tweenservice = game:GetService("TweenService")

local twistjoint = script.Parent:WaitForChild("twistjoint")

local info = TweenInfo.new(.5,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut)
local lens = script.Parent:WaitForChild("Lens",.5)
local ls = script.Parent.Parent.Parent.Torso["Left Shoulder"]

local uparmcf = CFrame.new(0.371513367, 0.805222511, 0.0908584595, 0.2390735, -0.489400715, -0.838648081, 0.368107677, -0.753542781, 0.544673681, -0.898521364, -0.438929617, 3.92756156e-08)
local downarmcf = CFrame.new(0.268680573, 0.646888733, 0.0362091064, 0.400977284, -0.368627459, -0.838648081, 0.617395043, -0.567585051, 0.544673681, -0.67678684, -0.736178458, 2.95832923e-08)
local basearmcf = CFrame.new(0.5, 0.5, 0, -4.37113883e-08, 0, -1, 0, 0.99999994, 0, 1, 0, -4.37113883e-08)

local onanim = {
	tweenservice:Create(ls,info,{C1 = uparmcf}),
	.5,
	tweenservice:Create(twistjoint,info,{C0 = script.Parent:WaitForChild("downvalue").Value}),
	tweenservice:Create(lens,info,
		{
			Transparency = 0,
			Reflectance = 0,
			Color = script.Parent.NVG_Settings.LensColor.Value,
	}),
	tweenservice:Create(ls,info,{C1 = downarmcf}),	
	.5,
	tweenservice:Create(ls,info,{C1 = basearmcf}),		
}


local offanim = {
	tweenservice:Create(ls,info,{C1 = downarmcf}),
	.5,
	tweenservice:Create(twistjoint,info,{C0 = script.Parent:WaitForChild("upvalue").Value}),
	tweenservice:Create(lens,info,{
		Transparency = .3,
		Reflectance = .005,
		Color = lens.Color,
	}),
	tweenservice:Create(ls,info,{C1 = uparmcf}),
	.5,
	tweenservice:Create(ls,info,{C1 = basearmcf}),		
}

local config = {
	dark = {
		src = {
			460199742,
			460199916,
			460200108,
			460200265,
			460200379,
			460200555,
		},
	},
	
	light = {
		src = {
			460107714,
			460107818,
			460107958,
			460108053,
			460108179,
			460108373
		},	
	},
	
	onanim = onanim,
	offanim = offanim,
	
	tweeninfo = info,
	
	lens = lens,	
	
}

return config
