--INSTRUCTIONS:
--Put this script in the part that you want
--Instead of Mid gray put the team color they change to
--Subscribe to UnaffectedGaming

local changedTeam = BrickColor.new("Parsley green"); -- replace Mid gray with the team color they change to

local part = script.Parent;

part.Touched:connect(function(hit)
	
	local plr = game.Players:GetPlayerFromCharacter(hit.Parent);
	
	if plr then
			
		plr.TeamColor = changedTeam;
		
	end
	
end)