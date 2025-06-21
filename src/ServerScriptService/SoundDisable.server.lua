for _,v in pairs(game:GetDescendants()) do
	if v:IsA('Sound') and v.TimeLength == 0 then
		v.SoundId = ""
	end
end