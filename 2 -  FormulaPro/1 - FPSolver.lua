function math.solve(formula, tosolve)
	local eq="max(exp" .. string.uchar(9654) .. "list(solve(" .. formula .. ", " .. tosolve ..")," .. tosolve .."))"
	return math.eval(eq)
end

function find_data(known, cid, sid)
	local done	= {}
	
	for _, var in ipairs(var.list()) do
		math.eval("delvar " .. var)
	end
	
	for key, value in pairs(known) do
		var.store(key, value)
	end

	local no
	local dirty_exit	=	true
	local tosolve
	
	while dirty_exit do
		dirty_exit	=	false
		
		for i, formula in ipairs(Formulas) do
			if ((not cid) or (cid and formula.category == cid)) and ((not sid) or (formula.category == cid and formula.sub == sid)) then
				no=0		
					
				for var in pairs(formula.variables) do
					if not known[var] then
						no=no+1
						tosolve	=	var
						if no==2 then break end
					end
				end
				
				if no==1 then
					print("I can solve " .. formula.formula)
					
					local sol	=	math.solve(formula.formula, tosolve)
					known[tosolve]	=	sol
					done[formula]=true
					var.store(tosolve, sol)
					
					print(tosolve .. " = " .. sol)
					
					dirty_exit	=	true
					break
					
				elseif no==2 then
					print("I can not solve " .. formula.formula .. " because I don't know the value of multiple variables")
				end
			end
		end
	end
	
	return known
end
