local ts = require(game.ReplicatedStorage.TService)
local module = {}

--/Sight
module.SightZoom 	= 0		-- Set to 0 if you want to use weapon's default zoom
module.SightZoom2 	= 0		--Set this to alternative zoom or Aimpart2 Zoom

--/Barrel
module.IsSuppressor 	= false
module.IsFlashHider		= false

--/UnderBarrel
module.IsBipod 			= false

--/Other
module.EnableLaser 		= false
module.EnableFlashlight = false
module.InfraRed 		= false

--/Damage Modification
module.DamageMod = 1
module.minDamageMod = 1

--/Recoil Modification
module.camRecoil = {
	RecoilUp 		= 0.8
	,RecoilTilt 	= 1
	,RecoilLeft 	= 1.1
	,RecoilRight 	= 1.1
}

module.gunRecoil = {
	RecoilUp 		= 0.8
	,RecoilTilt 	= 1
	,RecoilLeft 	= 1.1
	,RecoilRight 	= 1.1
}

module.AimRecoilReduction = 0.9
module.AimSpreadReduction = 1

module.MinRecoilPower 			= 1
module.MaxRecoilPower 			= 1
module.RecoilPowerStepAmount 	= 1

module.MinSpread 				= 1
module.MaxSpread 				= 1					
module.AimInaccuracyStepAmount 	= 1
module.AimInaccuracyDecrease 	= 1
module.WalkMult 				= 1

module.MuzzleVelocityMod	 	= 1

return module