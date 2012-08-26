--------------------------
---- FormulaPro v1.3 ----
----- LGLP 3 License -----
--------------------------

function initBasicFunctions()
	local basicFunctions = {
		["erf"] = [[Define erf(x)=Func:2/sqrt(pi)*integral(exp(-t*t),t,0,x):EndFunc]],
		["erfc"] = [[Define erfc(x)=Func:1-erf(x):EndFunc]],
		["ni"] = [[Define ni(ttt)=Func:7.7835*10^21*ttt^(3/2)*exp((4.73*10^-4*ttt^2/(ttt+636)-1.17)/(1.72143086667*10^-4*ttt)):EndFunc]],
		["eegalv"] = [[Define eegalv(rrx,rr2,rr3,rr4,rrg,rrs,vs)=Func:Local rra,rrb,rrc,vb,rg34,rx2ab: rg34:=rrg+rr3+rr4:  rra:=((rrg*rr3)/(rg34)): rrb:=((rrg*rr4)/(rg34)): rrc:=((rr3*rr4)/(rg34)): rx2ab:=rrx+rr2+rra+rrb: rra:=((rrg*rr3)/(rg34)): vb:=((((vs*(rrx+rra)*(rr2+rrb))/(rx2ab)))/(rrs+rrc+(((rrx+rra)*(rr2+rrb))/(rx2ab)))): vb*(((rx)/(rrx+rra))-((rr2)/(rr2+rrb))):Return :EndFunc]],
	}
	for var,func in pairs(basicFunctions) do
		math.eval(func..":Lock " .. var) -- defines and prevents against delvar.
	end
end
