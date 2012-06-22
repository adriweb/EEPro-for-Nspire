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
	local couldnotsolve	= {}
	
	local loops	= 0
	while dirty_exit do
		loops	= loops+1
		if loops == 100 then error("too many loops!") end
		dirty_exit	=	false
		
		for i, formula in ipairs(Formulas) do
		
			local skip	= false
			if couldnotsolve[formula] then
				skip	= true
				for k, v in pairs(known) do
					if not couldnotsolve[formula][k] then
						skip	= false
						couldnotsolve[formula] = nil
						break
					end
				end
			end	
				
			if ((not cid) or (cid and formula.category == cid)) and ((not sid) or (formula.category == cid and formula.sub == sid)) and not skip then
				no=0		
					
				for var in pairs(formula.variables) do
					if not known[var] then
						no=no+1
						tosolve	=	var
						if no==2 then break end
					end
				end
				
				if no==1 then
					print("I can solve " .. tosolve .. " for " .. formula.formula)
					
					local sol,r	=	math.solve(formula.formula, tosolve)
					if sol then 
						known[tosolve]	=	sol
						done[formula]=true
						var.store(tosolve, sol)
						couldnotsolve[formula]	= nil
						print(tosolve .. " = " .. sol)
					else
						print("Oops! Something went wrong:", r)
						-- Need to issue a warning dialog
						couldnotsolve[formula]	= copyTable(known)
						
					end	
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
