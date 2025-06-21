local Tool = script.Parent
local Remote = Tool:WaitForChild("Remote")
local Handle = Tool:WaitForChild("Handle")
local DamageScript = script:WaitForChild("Damage")
local Config = Tool:WaitForChild("Config")
local Heartbeat = game:GetService("RunService").Heartbeat
local FriendlyFire = Config.Teamkill.Value

local LeftDown = false

local AttackAble = true
local AttackVelocity = Config.Velocity.Value
local AttackDamage = Config.Damage.Value

local Character = nil
local Humanoid = nil

--returns the wielding player of this tool
function getPlayer()
	local char = Tool.Parent
	return game:GetService("Players"):GetPlayerFromCharacter(Character)
end

function Toss(direction)
	local OriginalWalkSpeed = Humanoid.WalkSpeed
	OriginalWalkSpeed = OriginalWalkSpeed
	Humanoid.WalkSpeed = 0
	local handlePos = Vector3.new(Tool.Handle.Position.X, 0, Tool.Handle.Position.Z)
	local spawnPos = Character.Head.Position
	spawnPos  = spawnPos + (direction * 5)
	Tool.Handle.Transparency = 1
	local Object = Tool.Handle:Clone()
	Object:AddTag("3DSoundEmitter"); Object.Parent = workspace
	Object.Transparency = 0
	Object.Swing.Pitch = math.random(90, 110)/100
	Object.Swing:Play()
	Object.CanCollide = true
	Object.CFrame = Tool.Handle.CFrame
	Object.Velocity = ((direction*AttackVelocity) + Vector3.new(0,AttackVelocity/7.5,0)) / 2
	local rand = 11.25
	Object.RotVelocity = Vector3.new(math.random(-rand,rand),math.random(-rand,rand),math.random(-rand,rand))
	Object:SetNetworkOwner(getPlayer())
	local ScriptClone = DamageScript:Clone()
	ScriptClone.FriendlyFire.Value = FriendlyFire
	ScriptClone.Damage.Value = AttackDamage
	ScriptClone.Parent = Object
	ScriptClone.Disabled = false
	local tag = Instance.new("ObjectValue")
	tag.Value = getPlayer()
	tag.Name = "creator"
	tag.Parent = Object
	Humanoid.WalkSpeed = OriginalWalkSpeed
	Tool:Destroy()
end

Remote.OnServerEvent:Connect(function(player, mousePosition)
	if not AttackAble then return end
	AttackAble = false
	if Humanoid and Humanoid.RigType == Enum.HumanoidRigType.R15 then
		Remote:FireClient(getPlayer(), "PlayAnimation", "Animation")
	end
	local targetPos = mousePosition.p
	local lookAt = (targetPos - Character.Head.Position).unit
	Toss(lookAt)
	LeftDown = true
end)

function onLeftUp()
	LeftDown = false
end

Tool.Equipped:Connect(function()
	Character = Tool.Parent
	Humanoid = Character:FindFirstChildOfClass("Humanoid")
end)

Tool.Unequipped:Connect(function()
	Character = nil
	Humanoid = nil
end)