--------------------------
---- FormulaPro v1.3 ----
----- LGLP 3 License -----
--------------------------

function initBasicFunctions()
	local basicFunctions = {
		["erf"] = [[Define erf(x)=Func:2/sqrt(pi)*integral(exp(-t*t),t,0,x):EndFunc]],
		["erfc"] = [[Define erfc(x)=Func:1-erf(x):EndFunc]]
	}
	for var,func in pairs(basicFunctions) do
		math.eval(func..":Lock " .. var) -- defines and prevents against delvar.
	end
end
