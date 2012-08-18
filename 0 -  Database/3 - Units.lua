--------------------------
---- FormulaPro v1.3 ----
----- LGLP 3 License -----
--------------------------

local mathpi = math.pi

Units	= {}

function Units.mainToSub(main, sub, n)
	local c=Units[main][sub]
	return n*c[1]+c[2]
end

function Units.subToMain(main, sub, n)
	local c=Units[main][sub]
	return (n-c[2])/c[1]
end

--[[

Units["mainunit"]	= {}
Units["mainunit"]["subunit"]	= {a, b}

meaning: n mainunit = n*a+b subunit
or
n subunit = (n-b)/a mainunit

--]]


Mt	= {}

Mt.G	= 1/1000000000
Mt.M	= 1/1000000
Mt.k	= 1/1000
Mt.h	= 1/100
Mt.da	= 1/10
Mt.d	= 10
Mt.c	= 100
Mt.m	= 1000
Mt.u	= 1000000
Mt.n	= 1000000000

Mt.us	= utf8(956)


Units["W/K"]	= {}
Units["W/K"]["kW/K"]	= {Mt.k, 0}
Units["W/K"]["mW/K"]	= {Mt.m, 0}

Units["1/"..utf8(176).."K"]	= {}

Units["m/s"]	= {}
Units["m/s"]["km/s"]	= {Mt.k, 0}
Units["m/s"]["cm/s"]	= {Mt.c, 0}
Units["m/s"]["mm/s"]	= {Mt.m, 0}
Units["m/s"]["m/h" ]	= {3600, 0}
Units["m/s"]["km/h"]	= {3.6 , 0}


Units["m"]	= {}
Units["m"]["km"      ]	= {Mt.k, 0}
Units["m"]["dm"      ]	= {Mt.d, 0}
Units["m"]["cm"      ]	= {Mt.c, 0}
Units["m"]["mm"      ]	= {Mt.m, 0}
Units["m"][Mt.us.."m"]	= {Mt.u, 0}
Units["m"]["nm"      ]	= {Mt.n, 0}



-- these are actually the same type
Units["Hz"]	= {}
Units["Hz"]["kHz"]	= {Mt.k, 0}
Units["Hz"]["MHz"]	= {Mt.M, 0}
Units["Hz"]["GHz"]	= {Mt.G, 0}

Units["rad/s"]	= {}
Units["rad/s"]["RPM"]	= {1/(2*mathpi/60), 0}

Units["A/m"]	= {}
Units["A/m"]["mA/m"]	= {Mt.m, 0}

Units["V/s"]	= {}
Units["V/s"]["mV/s"]	= {Mt.m, 0}

Units["C/m"]	= {}
Units["C/m"][Mt.us.."C/m"]	= {Mt.u  , 0}
Units["C/m"]["C/mm"      ]	= {1/Mt.m, 0}

Units["m2/s"]	= {}

Units[utf8(937)]	= {} --Ohm
Units[utf8(937)]["m"..utf8(937)]	= {Mt.m, 0}
Units[utf8(937)]["k"..utf8(937)]	= {Mt.k, 0}
Units[utf8(937)]["M"..utf8(937)]	= {Mt.M, 0}

Units["s"]	= {}
Units["s"]["ms"      ]	= {Mt.m, 0}
Units["s"][Mt.us.."s"]	= {Mt.u, 0}
Units["s"]["ns"      ]	= {Mt.n, 0}

Units[utf8(937).."/m"]	= {}
Units[utf8(937).."/m"][utf8(937).."/cm"]	= {1/Mt.c, 0}
Units[utf8(937).."/m"][utf8(937).."/mm"]	= {1/Mt.m, 0}

Units["1/m3"]	= {}

Units["N"]	= {}
Units["N"]["daN"]	= {Mt.da, 0}

Units["Wb"]	= {}
Units["Wb"]["mWb"]	= {Mt.m, 0}
	
Units["A"]	= {}
Units["A"]["kA"]	= {Mt.k, 0}
Units["A"]["mA"]	= {Mt.m, 0}	
Units["A"][Mt.us.."A"]	= {Mt.u, 0}

Units["S/m"]	= {}
Units["S/m"]["mS/m"]	= {Mt.m  , 0}
Units["S/m"]["S/mm"]	= {1/Mt.m, 0}

Units["C"]	= {}
Units["C"]["mC"]	= {Mt.m, 0}
Units["C"][Mt.us.."C"]	= {Mt.u, 0}

Units["m2/(V*s)"]	= {}

Units["A/V2"]	= {}
Units["A/V2"]["mA/V2"]	= {Mt.m  , 0}


Units["N/m"]	= {}
Units["N/m"]["daN"]	= {Mt.da, 0}

Units["rad"]	= {}
Units["rad"]["degree"]	= {180/mathpi, 0}

Units["F"]	= {}
Units["F"]["kF"]	= {Mt.k, 0}
Units["F"]["mF"]	= {Mt.m, 0}
Units["F"][Mt.us.."F"]	= {Mt.u, 0}
Units["F"]["nF"]	= {Mt.n, 0}


Units[utf8(937).."*m"]	= {}
Units[utf8(937).."*m"][utf8(937).."*cm"]	= {Mt.c, 0}
Units[utf8(937).."*m"][utf8(937).."*mm"]	= {Mt.m, 0}

Units["H"]	 = {}
Units["H"]["mH"]	= {Mt.m, 0}
Units["H"][Mt.us.."H"]	= {Mt.u, 0}
Units["H"]["nH"]	= {Mt.n, 0}

Units["K"]	= {}
Units["K"]["°C"]	= {1, -273.15}
Units["K"]["°F"]	= {9/5, -459.67}
Units["K"]["°R"]	= {9/5, 0}

Units["J"]	= {}
Units["J"]["GJ"]	= {Mt.G, 0} 
Units["J"]["MJ"]	= {Mt.M, 0}
Units["J"]["kJ"]	= {Mt.k, 0}	
Units["J"]["kWh"]	= {1/3600000, 0}

Units["1/V"]	= {}
	
Units["F/m"]	= {}
Units["F/m"]["F/cm"]	= {1/Mt.c, 0}
Units["F/m"]["F/mm"]	= {1/Mt.m, 0}
Units["F/m"][Mt.us.."F/m"]	= {Mt.u, 0}

Units["V5"]	= {}

Units["H/m"]	= {}
Units["H/m"]["mH/m"]	= {Mt.m  , 0}
Units["H/m"]["H/mm"]	= {1/Mt.m, 0}
Units["H/m"][Mt.us.."H/m"]	= {Mt.u, 0}

Units["F/m2"]	= {}
Units["F/m2"]["F/cm2"]	= {1/Mt.c^2, 0}
Units["F/m2"]["mF/m2"]	= {Mt.m         , 0}
Units["F/m2"][Mt.us.."F/m2"]	= {Mt.u , 0}

Units["N*m"]	= {}
Units["N*m"]["daN*m"]	= {Mt.da, 0}
Units["N*m"]["N*cm" ]	= {Mt.c , 0}
Units["N*m"]["N*mm" ]	= {Mt.m , 0}

Units["S"]	= {}
Units["S"]["mS"]	= {Mt.m, 0}
Units["S"][Mt.us.."S"]	= {Mt.u, 0}

Units["1/m4"]	= {}

Units["A/(m2*K2)"]	= {}

Units["T"]	= {}
Units["T"]["mT"]	= {Mt.m, 0}
Units["T"][Mt.us.."T"]	= {Mt.u, 0}
Units["T"]["nT"]	= {Mt.n, 0}

Units["W"]	= {}
Units["W"]["GW"]	= {Mt.G, 0}
Units["W"]["MW"]	= {Mt.M, 0}
Units["W"]["kW"]	= {Mt.k, 0}
Units["W"]["mW"]	= {Mt.m, 0}
Units["W"][Mt.us.."W"]	= {Mt.u, 0}

Units["V"]	= {}
Units["V"]["MV"]	= {Mt.M, 0}
Units["V"]["kV"]	= {Mt.k, 0}
Units["V"]["mV"]	= {Mt.m, 0}
Units["V"][Mt.us.."V"]	= {Mt.u, 0}

Units["m2"]	= {}
Units["m2"]["cm2"]	= {Mt.c^2, 0}
Units["m2"]["mm2"]	= {Mt.m^2, 0}
Units["m2"]["km2"]	= {Mt.k^2, 0}

Units["A/Wb"]	= {}

Units["Pa"]	= {}
Units["Pa"]["hPa"]	= {Mt.h    , 0}
Units["Pa"]["bar"]	= {1/100000, 0}
Units["Pa"]["atm"]	= {1.01325 , 0}

Units["1/K"]	= {}

Units["V/m"]	= {}
Units["V/m"]["mV/m"]	= {Mt.m   , 0}
Units["V/m"]["V/mm"]	= {1/Mt.m , 0}
Units["V/m"]["V/cm"]	= {1/Mt.c , 0}

Units["C/m2"]	= {}
Units["C/m2"]["mC/m2"]	= {Mt.m, 0}
Units["C/m2"][Mt.us.."C/m2"]	= {Mt.u, 0}
