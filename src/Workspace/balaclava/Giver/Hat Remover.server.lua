function onTouched(hit) 
	local d = hit.Parent:GetChildren() 
	for i=1, #d do 
		if (d[i].className == "Accessory") then 
			d[i]:remove() 
		end 
	end
end 

script.Parent.Touched:connect(onTouched) 