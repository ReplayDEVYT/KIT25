-- mizmii's content checker
-- this will remove any users that have assets to popular roblox.. er.. "games"

w = require(game.ReplicatedStorage.Warp)

--[[local R = {
	C = w.Client("GConfirm")
}]]--

local C = game:GetService("ContentProvider")

local TAId = 0

local function IDCheck(I)
	if C:GetAssetFetchStatus(I) == Enum.AssetFetchStatus.Success then
		-- R.C:Fire(true)
		print("DETECTED!!!!!!!!!!")
	end
end


STVO = {
	[1] = "rbxasset://Sounds/VO_Default/_breathing/breathing2.wav",
	[2] = "rbxasset://Sounds/VO_Default/_grunt/grunt2.wav",
	[3] = "rbxasset://Sounds/VO_Default/_mmm/mmm4.wav",
	[4] = "rbxasset://Sounds/VO_Default/_swallow/swallow0.wav"
}

TAId = STVO[math.random(1,#STVO)]

IDCheck(TAId)

STG = {
	[1] = "rbxasset://Sounds/Gameplay/kiss_sfx.mp3",
	[2] = "rbxasset://Sounds/Gameplay/TearCloth_001.mp3",
	[3] = "rbxasset://Sounds/Enemies/Werewolf_attack1.mp3",
	[4] = "rbxasset://Sounds/Enemies/BeeDamage.wav"
}

TAId = STG[math.random(1,#STG)]

STM = {
	[1] = "rbxasset://Meshes/OX_495152230.mesh",
	[2] = "rbxasset://Meshes/OX_542944474.mesh",
	[3] = "rbxasset://Meshes/OX_542944456.mesh",
	[4] = "rbxasset://Meshes/OX_1182494709.mesh"
}

TAId = STM[math.random(1,#STM)]

IDCheck(TAId)

TAId = "rbxasset://Sounds/Gameplay/ClothMove_"..math.random(10,21)

IDCheck(TAId)