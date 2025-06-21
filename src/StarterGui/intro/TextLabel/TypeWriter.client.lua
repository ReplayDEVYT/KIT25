
if game:GetService("Players").LocalPlayer.DisplayName then
	text = "["..tostring(game:GetService("Players").LocalPlayer.Team.Name).."] "..tostring(game:GetService("Players").LocalPlayer.DisplayName).."" --Text
else
	text = "["..tostring(game:GetService("Players").LocalPlayer.Team.Name).."] "..tostring(game:GetService("Players").LocalPlayer.Name).."" --Text
end

wait(4)

for i = 1,string.len(text),1 do 
script.Parent.Text = string.sub(text,1,i)
task.wait(0.01)
end
