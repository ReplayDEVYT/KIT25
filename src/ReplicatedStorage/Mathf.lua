local Mathf = {}
function Mathf.Clamp(Num,Min,Max)
	return Num < Min and Min or Num > Max and Max or Num
end
function Mathf.Lerp(n,g,t)
	return n+(g-n)*t
end
function Mathf.Wrap(Number,Min,Max)
	if Number < Min then Number = Max + (Number-Min) end
	if Number > Max then Number = Min + (Number-Max) end
	if Number < Min or Number > Max then Mathf.Wrap(Number,Min,Max) end
	return Number
end
function  Mathf.Cubic_Interpolate(v0, v1, v2, v3,x)
	P = (v3 - v2) - (v0 - v1)
	Q = (v0 - v1) - P
	R = v2 - v0
	S = v1

	return P*x^3 + Q*x^2 + R*x + S
 end
function Mathf.Round(n,m,b)
	return math.floor(n/m+b)*m
end
function Mathf.InPart(part,pos)
	rel=part.CFrame:pointToObjectSpace(pos)
	if math.abs(rel.x) <= part.Size.x/2 and math.abs(rel.y) <= part.Size.y/2 and math.abs(rel.z) <= part.Size.z/2 then
		return true
	end
	return false
end
function Mathf.DirectionToPlane(relPos,v)
		plane=relPos.x <= -v.Size.x/2 and "-x" or relPos.x >= v.Size.x/2 and "x" or relPos.z <= -v.Size.z/2 and "-z" or relPos.z >= v.Size.z/2 and "z"
		local lv = relPos.lookVector		
		if plane =="-x" then
			forw=lv.x
			dist=math.abs(math.abs(relPos.x)-v.Size.x/2)
			dist2=math.abs(math.abs(relPos.x)+v.Size.x/2)
		elseif plane=="x" then
			forw=lv.x
			dist=-math.abs(math.abs(relPos.x)-v.Size.x/2)
			dist2=-math.abs(math.abs(relPos.x)+v.Size.x/2)
		elseif plane=="z" then
			forw=lv.z
			dist=math.abs(math.abs(relPos.z)-v.Size.z/2)
			dist2=math.abs(math.abs(relPos.z)+v.Size.z/2)
		elseif plane=="-z" then
			forw=lv.z
			dist=-math.abs(math.abs(relPos.z)-v.Size.z/2)
			dist2=-math.abs(math.abs(relPos.z)+v.Size.z/2)			
		end
		amt=dist/forw
		amt2=dist2/forw
		pos=relPos.p+lv*amt
		pos=CFrame.new(Mathf.Clamp(pos.x,-v.Size.x/2,v.Size.x/2),Mathf.Clamp(pos.y,-v.Size.y/2,v.Size.y/2),Mathf.Clamp(pos.z,-v.Size.z/2,v.Size.z/2))	
		return pos
end
function Mathf.Noise(input,inc,Seed)
	input=input+Seed
	point1=Mathf.Round(input,inc,0)
	npoint1=Mathf.Round(input,inc,-1)
	epoint1=Mathf.Round(input,inc,0.99)
	nepoint1=Mathf.Round(input,inc,1.99)
	if point1== 0 then point1 = 1 end
	if npoint1==0 then npoint1=1 end
	if epoint1==0 then epoint1=1 end
	if nepoint1==0 then nepoint1=1 end
	ntepoint1=(math.sin(nepoint1+nepoint1/nepoint1*math.tan(nepoint1))+1)/2
	ntpoint1=(math.sin(npoint1+npoint1/npoint1*math.tan(npoint1))+1)/2
	tpoint1=(math.sin(point1+point1/point1*math.tan(point1))+1)/2
	tepoint1=(math.sin(epoint1+epoint1/epoint1*math.tan(epoint1))+1)/2
	dist=math.abs(point1-epoint1)
	if dist~=0 then
	perc=math.abs(input-point1)/dist
	else
	perc=1
	end
	avg=(tepoint1)
	av=(tpoint1)
	preva=(ntpoint1)
	nexta=(ntepoint1)
	avperc=(perc)
	forx = Mathf.Cubic_Interpolate(preva,av,avg,nexta,avperc)
	return forx
end
function Mathf.Round(Num,Mult,Bias)
	return math.floor(Num/Mult+Bias)*Mult
end
function Mathf.LerpColor3(c1,c2,p)
	return Color3.new(c1.r+(c2.r-c1.r)*p,c1.g+(c2.g-c1.g)*p,c1.b+(c2.b-c1.b)*p)
end
function Mathf.SmoothLerp(n,g,t)
	return t < 0.001 and n or t > 0.999 and g or Mathf.Lerp(n,g,(math.cos(t*math.rad(180)-math.rad(180))+1)/2)
end
function Mathf.PercentBetween(i,n1,n2)
	return Mathf.Clamp((i-n1)/(n2-n1),0,1)
end
function Mathf.LerpTowards(n,g,t)
	if n==g then return g end
	if n < g then
		return Mathf.Clamp(n+t,n,g)
	else
		return Mathf.Clamp(n-t,g,n)
	end
end
function Mathf.CFrameModel(m,c,g)
	for _,v in ipairs(m:GetChildren()) do
		if v:IsA("BasePart") then
			v.CFrame=g*(c:toObjectSpace(v.CFrame))
		end
		Mathf.CFrameModel(v,c,g)
	end
end
function Mathf.Vector3ToPixel(Position,Camera,Reference)
screen_width=Reference.AbsoluteSize.X
screen_height=Reference.AbsoluteSize.Y
point = (Camera.CoordinateFrame*CFrame.Angles(0,0,-Camera:GetRoll())):inverse() * (Position)
fovMult = 1 / math.tan(math.rad(Camera.FieldOfView)/2)
x = screen_width / 2 * (1 + point.x / -point.z * fovMult * screen_height / screen_width)
y = screen_height / 2 * (1 + point.y / -point.z * fovMult)
if point.z > 0 then
	x=20000
	y=20000
end

return x,screen_height-y-36
end

function Mathf.LerpAngle(a1,a2,t)
	local dist=math.abs(a2-a1)
	if dist > 180 then
		if a2 > a1 then
			a1=a1+360
		else
			a2=a2+360
		end
	end
	return Mathf.Wrap(Mathf.Lerp(a1,a2,t),0,360)
end
function Mathf.LerpTowardsAngle(a1,a2,t)
	local dist=math.abs(a2-a1)
	if dist > 180 then
		if a1 > a2 then
			a1=a1+360
		else
			a2=a2+360
		end
	end
	return Mathf.LerpTowards(a1,a2,t)
end
function Mathf.LerpAngle2(A1,A2,Percent)
	A1=(A1+180)
	A2=(A2+180)
	difference = math.abs(A2 - A1);
	if (difference > 180) then
		-- We need to add on to one of the values.
		if (A2 > A1) then
			-- We'll add it on to start...
			A2 = A2-360
		else
			-- Add it on to end.
			A1 = A1-360
		end
	end
	A1=(A1-180)
	A2=(A2-180)
	--print(math.floor(A1).."vs"..math.floor(A2))
	return Mathf.Wrap(Mathf.Lerp(A1,A2,Percent),-180,180)
end
function Mathf.AngleDistance(A1,A2)
	A1=math.deg(A1)
	A2=math.deg(A2)
	difference = math.abs(A2 - A1);
	if (difference > 180) then
		-- We need to add on to one of the values.
		if (A1 > A2) then
			-- We'll add it on to start...
			A2 = A2+360
		else
			-- Add it on to end.
			A1 = A1+360
		end
	end
	return math.rad(A1-A2)
end
function Mathf.LerpAngle(A1,A2,Percent)
	difference = math.abs(A2 - A1);
	if (difference > 180) then
		-- We need to add on to one of the values.
		if (A2 > A1) then
			-- We'll add it on to start...
			A1 =A1+360
		else
			-- Add it on to end.
			A2 =A2+360
		end
	end
	return Mathf.Wrap(Mathf.Lerp(A1,A2,Percent),0,360)
end
function Mathf.InterpolateCFrame(CF1,CF2,Percent)
	--[[x1,y1,z1=CF1:toEulerAnglesXYZ()
	x2,y2,z2=CF2:toEulerAnglesXYZ()
	Angle=Vector3.new(math.rad(Mathf.LerpAngle(math.deg(x1),math.deg(x2),Percent)),math.rad(Mathf.LerpAngle2(math.deg(y1),math.deg(y2),Percent)),math.rad(Mathf.LerpAngle2(math.deg(z1),math.deg(z2),Percent)))
	return CFrame.new(CF1.p:Lerp(CF2.p,Percent))*CFrame.Angles(Angle.x,Angle.y,Angle.z)]]
	return Percent < 0.001 and CF1 or Percent > 0.999 and CF2 or CF1:lerp(CF2,Percent)
end
return Mathf
