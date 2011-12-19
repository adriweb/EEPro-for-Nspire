platform.apilevel = "1.0"

printt=print
pr={}

function print(s)
	table.insert(pr, s)
end

formulas	=	{}
units	=	{}

function f(t)
	table.insert(formulas, t)
end

function u(t)
	table.insert(units, t)
end

-- syntax :  {{category,subcategory}, equationString, {var1=true, var2=true, var3=true...}}
f{{1,1}, "P=I*U", {U=true,I=true, P=true}}
f{{1,1}, "U=R*I", {U=true, R=true, I=true}}

u{"I", "Current", {{"val", "A"}, {"val/1000", "mA"}}}
u{"U", "Voltage", {{"val", "V"}, {"val/1000", "mV"}}}
u{"P", "Power", {{"val", "W"}, {"val*1000", "kW"}, {"val*750", "hp"}}}
u{"R", "Resistance", {{"val", "Ω"}, {"val*1000", "kΩ"}}}

done={}

function find_data(known)
	for i, p in pairs(known) do
		var.store(i, p)
	end

	local no
	local dirty_exit	=	true
	local tosolve
	
	while dirty_exit do
		dirty_exit	=	false
		
		for i, formula in ipairs(formulas) do
			no=0		
				
			for var, value in pairs(formula[3]) do
				if not known[var] then
					no=no+1
					tosolve	=	var
					if no==2 then break end
				end
			end
			
			if no==1 then
				printt("I can solve " .. formula[2])
				
				local eq="max(exp" .. string.uchar(9654) .. "list(solve(" .. formula[2] .. ", " .. tosolve ..")," .. tosolve .."))"
				local sol	=	math.eval(eq)
				known[tosolve]	=	sol
				done[formula]=true
				var.store(tosolve, sol)
				
				printt(tosolve .. " = " .. sol)
				
				dirty_exit	=	true
				break
				
			elseif no==2 then
				printt("I can't solve " .. formula[2] .. " because I don't know the value of (a) variable(s) (" .. tosolve .. "?)")
			end
			
		end
	end

	for i, v in pairs(known) do
		print(i .. " = " .. v)
	end	
	
	return known
end

function on.create()
	known={U=5, I=2} -- START VALUE'S
	find_data(known)
end

function on.paint(gc)
	gc:setColorRGB(0,0,0)
	for i,v in pairs(pr) do
		gc:drawString(v, 2,14*i-14,"top")
	end
end
