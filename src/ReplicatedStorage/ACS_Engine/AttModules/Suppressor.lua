local ts = require(game.ReplicatedStorage.TService)
local module = {}

--/Sight
module.SightZoom 	= 0		-- Set to 0 if you want to use weapon's default zoom
module.SightZoom2 	= 0		--Set this to alternative zoom or Aimpart2 Zoom

--/Barrel
module.IsSuppressor 	= true
module.IsFlashHider		= true

--/UnderBarrel
module.IsBipod 			= false

--/Other
module.EnableLaser 		= false
module.EnableFlashlight = false
module.InfraRed 		= false

--/Damage Modification
module.DamageMod = .85
module.minDamageMod = 1

--/Recoil Modification
module.camRecoil = {
	RecoilUp 		= .9
	,RecoilTilt 	= 1
	,RecoilLeft 	= 1.05
	,RecoilRight 	= 1.05
}

module.gunRecoil = {
	RecoilUp 		= .9
	,RecoilTilt 	= 1
	,RecoilLeft 	= 1.05
	,RecoilRight 	= 1.05
}

module.AimRecoilReduction = 1
module.AimSpreadReduction = 1

module.MinRecoilPower 			= 1
module.MaxRecoilPower 			= 1
module.RecoilPowerStepAmount 	= 1

module.MinSpread 				= 1.5
module.MaxSpread 				= 1				
module.AimInaccuracyStepAmount 	= 1
module.AimInaccuracyDecrease 	= 1
module.WalkMult 				= 1

module.MuzzleVelocityMod	 	= .75

return module