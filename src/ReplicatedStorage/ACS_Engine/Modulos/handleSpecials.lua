local Engine = game.ServerStorage
local specialBullets = Engine.SpecialBullets


local module = {
	createSpecial = function(char, speed, objs)
		local effectscript = Engine.SpecialBullets:FindFirstChild(objs[3]):Clone()
		--[[if objs[3].SpecialBulletPart then
			local part = Instance.new('Part')
			part.Transparency = 1
			part.Anchored = true
			part.CanCollide = false
			part.Size = Vector3.new(.5,.5,.5)
			part.Name = "fakeBullet"
			part.CFrame = objs[1].CFrame
			effectscript.Parent = part
			part.Parent = workspace.ACS_WorkSpace.Server
			game:GetService('Debris'):AddItem(part,objs[3].SpecialBulletLife)
		else]]--
			effectscript.Parent = objs[1]
		--end
		effectscript.Creator.Value = objs[2].Name
		effectscript.Disabled = false
		print("special added")
			print(effectscript.Parent.Name)
	end;
	}
return module
