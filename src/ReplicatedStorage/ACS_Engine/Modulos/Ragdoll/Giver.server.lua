local button = script.Parent:WaitForChild("ClickDetector")
repeat wait() until script.Parent:FindFirstChildOfClass("Tool")
local gun = script.Parent:FindFirstChildOfClass("Tool")
local sound = script.Loot
local canloot = true
function onClicked(player)
	if game:GetService("Players"):FindFirstChild(player.Name) and canloot == true and gun ~= nil then
		local clone = gun:Clone()
		clone.Parent = game:GetService("Players"):FindFirstChild(player.Name).Backpack
		sound.Parent = script.Parent.Grip
		sound:Play()
		canloot = false
		wait(0.3)
		script.Parent:Destroy()
	end
end

button.MouseClick:connect(onClicked)

