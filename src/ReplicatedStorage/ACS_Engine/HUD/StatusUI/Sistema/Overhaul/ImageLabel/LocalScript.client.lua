local Player = game:GetService("Players").LocalPlayer -- Return the player
local PlayerThumbnail = "http://www.roblox.com/Thumbs/Avatar.ashx?x=150&y=150&Format=Png&username="..Player.Name
local ImageLabel = script.Parent
--Now you can set anything that uses a image to be the variable PlayerThumbnail, like this:
ImageLabel.Image = PlayerThumbnail