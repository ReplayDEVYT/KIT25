print("randomizing weather")

local temp = script.Parent.Temperature

temp.Value = math.random((temp.Value / 2), (temp.Value * 1.5))

print("temperature is "..temp.Value)