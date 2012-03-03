function math.solve(formula, tosolve)
	local eq="max(exp" .. string.uchar(9654) .. "list(solve(" .. formula .. ", " .. tosolve ..")," .. tosolve .."))"
	return math.eval(eq)
end

function find_data(known)
	local done={}
	
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
				print("I can solve " .. formula[2])
				
			--	local eq="max(exp" .. string.uchar(9654) .. "list(solve(" .. formula[2] .. ", " .. tosolve ..")," .. tosolve .."))"
				local sol	=	math.solve(formula[2], tosolve)
				known[tosolve]	=	sol
				done[formula]=true
				var.store(tosolve, sol)
				
				print(tosolve .. " = " .. sol)
				
				dirty_exit	=	true
				break
				
			elseif no==2 then
				print("I can't solve " .. formula[2] .. " because I don't know the value of (a) variable(s) (" .. tosolve .. "?)")
			end
			
		end
	end
	
	return known
end
