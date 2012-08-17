--------------------------
---- FormulaPro v1.2b ----
----- LGLP 3 License -----
--------------------------

Categories	=	{}
Formulas	=	{}

function addCat(id,name,info)
	return table.insert(Categories, id, {id=id, name=name, info=info, sub={}, varlink={}})
end

function addCatVar(cid, var, info, unit)
	Categories[cid].varlink[var] = {unit=unit, info=info}
end

function addSubCat(cid, id, name, info)
	return table.insert(Categories[cid].sub, id, {category=cid, id=id, name=name, info=info, formulas={}, variables={}})
end

function aF(cid, sid, formula, variables) --add Formula
	local fr	=	{category=cid, sub=sid, formula=formula, variables=variables}
	-- In times like this we are happy that inserting tables just inserts a reference
	table.insert(Formulas, fr)
	table.insert(Categories[cid].sub[sid].formulas, fr)
	
	-- This function might need to be merged with U(...)
	for variable,_ in pairs(variables) do
		Categories[cid].sub[sid].variables[variable]	= true
	end
end

function U(...)
	local out	= {}
	for i, p in ipairs({...}) do
		out[p]	= true
	end
	return out
end

----------------------------------------------
-- Categories && Sub-Categories && Formulas --
----------------------------------------------

c_O  = utf8(963)
c_P  = utf8(961)
c_e  = utf8(949)
c_Pi = utf8(960)
c_pi = utf8(960)
c_u  = utf8(956) -- mu
c_mu  = utf8(956) -- mu
c_t  = utf8(964)
c_Ohm = utf8(937)
c_theta = utf8(952)

addCat(1, "Resistive Circuits", "") 

addCatVar(1, "A", "Area", "m2")
addCatVar(1, "G", "Conductance", "S")
addCatVar(1, "I", "Current", "A")
addCatVar(1, "Il", "Load current", "A")
addCatVar(1, "Is", "Current source", "A")
addCatVar(1, "len", "Length", "m")
addCatVar(1, "P", "Power", "W")
addCatVar(1, "Pmax", "Maximum power in load", "W")
addCatVar(1, "R", "Resistance", utf8(937))
addCatVar(1, "Rl", "Load resistance", utf8(937))
addCatVar(1, "Rlm", "Match load resistance", utf8(937))
addCatVar(1, "RR1", "Resistance, T1", utf8(937))
addCatVar(1, "RR2", "Resistance, T2", utf8(937))
addCatVar(1, "Rs", "Source resistance", utf8(937))
addCatVar(1, "T1", "Temperature 1", "K")
addCatVar(1, "T2", "Temperature 2", "K")
addCatVar(1, "U", "Voltage", "V")
addCatVar(1, "Vl", "Load voltage", "V")
addCatVar(1, "Vs", "Source voltage", "V")
addCatVar(1, utf8(945), "Temperature coefficient", "1/"..utf8(176).."K")
addCatVar(1, utf8(961), "Resistivity", utf8(937).."*m")
addCatVar(1, utf8(963), "Conductivity", "S/m")


addSubCat(1, 1, "Resistance Formulas", "") 
aF(1, 1, "R="..utf8(961).."*len/A", U("R",""..utf8(961),"len","A")) 
aF(1, 1, "G="..utf8(963).."*A/len", U("G",""..utf8(963),"A","len")) 
aF(1, 1, "G=1/R", U("G","R")) 
aF(1, 1, utf8(963).."=1/"..utf8(961), U(""..utf8(963),""..utf8(961).."")) 


addSubCat(1, 2, "Ohm\'s Law and Power", "") 
aF(1, 2, "V=I*R", U("V","I","R")) 
aF(1, 2, "P=V*I", U("P","V","I")) 
aF(1, 2, "P=I^2*R", U("P","I","R")) 
aF(1, 2, "P=V^2/R", U("P","V","R")) 
aF(1, 2, "P=V^2*G", U("P","V","G")) 
aF(1, 2, "R=1/G", U("R","G")) 


addSubCat(1, 3, "Temperature Effect on Resistance", "") 
aF(1, 3, "RR2=RR1*(1+"..utf8(945).."*(T2-T1))", U("RR2","RR1",""..utf8(945),"T2","T1")) 


addSubCat(1, 4, "Maximum Power Transfer", "") 
aF(1, 4, "Vl=Vs*Rl/(Rs+Rl)", U("Vl","Vs","Rl","Rs")) 
aF(1, 4, "Il=Vs/(Rs+Rl)", U("Il","Vs","Rs","Rl")) 
aF(1, 4, "P=Il*Vl", U("P","Il","Vl")) 
aF(1, 4, "Pmax=Vs^2/(4*Rs)", U("Pmax","Vs","Rs")) 
aF(1, 4, "Rlm=Rs", U("Rlm","Rs")) 


addSubCat(1, 5, "Voltage and Current Source Equivalence", "") 
aF(1, 5, "Is=Vs/Rs", U("Is","Vs","Rs")) 
aF(1, 5, "Vs=Is*Rs", U("Vs","Is","Rs")) 




addCat(2, "Capacitors and Electric Fields", "") 

addCatVar(2, "A", "Area", "m2")
addCatVar(2, "C", "Capacitance", "F")
addCatVar(2, "cl", "Capacitance per unit length", "F/m")
addCatVar(2, "d", "Separation", "m")
addCatVar(2, "E", "Electric field", "V/m")
addCatVar(2, "Er", "Radial electric field", "V/m")
addCatVar(2, "Ez", "Electric field along z axis", "V/m")
addCatVar(2, "F", "Force on plate", "N")
addCatVar(2, "Q", "Charge", "C")
addCatVar(2, "r", "Radial distance", "m")
addCatVar(2, "ra", "Inner radius, wire radius", "m")
addCatVar(2, "rb", "Outer radius", "m")
addCatVar(2, "V", "Potential", "V")
addCatVar(2, "Vz", "Potential along z axis", "V")
addCatVar(2, "W", "Energy stored", "J")
addCatVar(2, "z", "z axis distance from disk", "m")
addCatVar(2, utf8(949).."r", "Relative permittivity", "unitless")
addCatVar(2, utf8(961).."l", "Line charge", "C/m")
addCatVar(2, utf8(961).."s", "Charge density", "C/m2")


addSubCat(2, 1, "Point Charge", "") 
aF(2, 1, "Er=Q/(4*"..utf8(960).."*"..utf8(949).."0*"..utf8(949).."r*r^2)", U("Er","Q",""..utf8(960),""..utf8(949).."0",""..utf8(949).."r","r")) 
aF(2, 1, "V=Q/(4*"..utf8(960).."*"..utf8(949).."0*"..utf8(949).."r*r)", U("V","Q",""..utf8(960),""..utf8(949).."0",""..utf8(949).."r","r")) 


addSubCat(2, 2, "Long Charged Line", "") 
aF(2, 2, "Er="..utf8(961).."l/(2*"..utf8(960).."*"..utf8(949).."0*"..utf8(949).."r*r)", U("Er",""..utf8(961).."l",""..utf8(960),""..utf8(949).."0",""..utf8(949).."r","r")) 


addSubCat(2, 3, "Charged Disk", "") 
aF(2, 3, "Ez="..utf8(961).."s/(2*"..utf8(949).."0*"..utf8(949).."r)*(1-(abs(z)/sqrt(ra^2+z^2)))", U("Ez",""..utf8(961).."s",""..utf8(949).."0",""..utf8(949).."r","z","ra")) 
aF(2, 3, "Vz="..utf8(961).."s/(2*"..utf8(949).."0*"..utf8(949).."r)*(sqrt(ra^2+z^2)-abs(z))", U("Vz",""..utf8(961).."s",""..utf8(949).."0",""..utf8(949).."r","ra","z")) 


addSubCat(2, 4, "Parallel Plates", "") 
aF(2, 4, "E=V/d", U("E","V","d")) 
aF(2, 4, "C="..utf8(949).."0*"..utf8(949).."r*A/d", U("C",""..utf8(949).."0",""..utf8(949).."r","A","d")) 
aF(2, 4, "Q=C*V", U("Q","C","V")) 
aF(2, 4, "F=-1/2*V^2*C/d", U("F","V","C","d")) 
aF(2, 4, "W=1/2*V^2*C", U("W","V","C")) 


addSubCat(2, 5, "Parallel Wires", "") 
aF(2, 5, "cl="..utf8(960).."*"..utf8(949).."0*"..utf8(949).."r/arccosh(d/(2*ra))", U("cl",""..utf8(960),""..utf8(949).."0",""..utf8(949).."r","d","ra")) 


addSubCat(2, 6, "Coaxial Cable", "") 
aF(2, 6, "V="..utf8(961).."l/(2*"..utf8(960).."*"..utf8(949).."0*"..utf8(949).."r)*ln(rb/ra)", U("V",""..utf8(961).."l",""..utf8(960),""..utf8(949).."0",""..utf8(949).."r","rb","ra")) 
aF(2, 6, "Er=V/(r*ln(rb/ra))", U("Er","V","r","rb","ra")) 
aF(2, 6, "cl=2*"..utf8(960).."*"..utf8(949).."0*"..utf8(949).."r/ln(rb/ra)", U("cl",""..utf8(960),""..utf8(949).."0",""..utf8(949).."r","rb","ra")) 


addSubCat(2, 7, "Sphere", "") 
aF(2, 7, "V=Q/(4*"..utf8(960).."*"..utf8(949).."0*"..utf8(949).."r)*(1/ra-1/rb)", U("V","Q",""..utf8(960),""..utf8(949).."0",""..utf8(949).."r","ra","rb")) 
aF(2, 7, "Er=Q/(4*"..utf8(960).."*"..utf8(949).."0*"..utf8(949).."r*r^2)", U("Er","Q",""..utf8(960),""..utf8(949).."0",""..utf8(949).."r","r")) 
aF(2, 7, "C=4*"..utf8(960).."*"..utf8(949).."0*"..utf8(949).."r*ra*rb/(rb-ra)", U("C",""..utf8(960),""..utf8(949).."0",""..utf8(949).."r","ra","rb")) 




addCat(3, "Inductors and Magnetism", "") 

addCatVar(3, c_theta, "Angle", "rad")
addCatVar(3, utf8(956).."r", "Relative permeability", "unitless")
addCatVar(3, "a", "Loop radius or side of a rectangular loop", "m")
addCatVar(3, "B", "Magnetic field", "T")
addCatVar(3, "bl", "Width of rectangular loop", "m")
addCatVar(3, "Bx", "Magnetic field, x axis", "T")
addCatVar(3, "By", "Magnetic field, y axis", "T")
addCatVar(3, "D", "Center-center wire spacing", "m")
addCatVar(3, "d", "Strip width", "m")
addCatVar(3, "f", "Frequency", "Hz")
addCatVar(3, "Fw", "Force between wires/unit length", "N/m")
addCatVar(3, "I", "Current", "A")
addCatVar(3, "I1", "Current in line 1", "A")
addCatVar(3, "I2", "Current in line 2", "A")
addCatVar(3, "Is", "Current in strip", "A/m")
addCatVar(3, "L", "Inductance per unit length", "H/m")
addCatVar(3, "L12", "Mutual inductance", "H")
addCatVar(3, "Ls", "Loop self-inductance", "H")
addCatVar(3, "r", "Radial distance", "m")
addCatVar(3, "ra", "Radius of inner conductor", "m")
addCatVar(3, "rb", "Radius of outer conductor", "m")
addCatVar(3, "Reff", "Effective resistance", utf8(937)) -- in Ohms
addCatVar(3, "rr0", "Wire radius", "m")
addCatVar(3, "T12", "Torque", "N*m")
addCatVar(3, "x", "x axis distance", "m")
addCatVar(3, "y", "y axis distance", "m")
addCatVar(3, "z", "Distance to loop z axis", "m")
addCatVar(3, utf8(948), "Skin depth", "m") -- delta
addCatVar(3, utf8(961), "Resistivity", utf8(937).."*m") -- rho


addSubCat(3, 1, "Long Line", "") 
aF(3, 1, "B="..utf8(956).."0*I/(2*"..utf8(960).."*r)", U("B",""..utf8(956).."0","I",""..utf8(960),"r")) 


addSubCat(3, 2, "Long Strip", "") 
aF(3, 2, "Bx=-"..utf8(956).."0*Is/(2*"..utf8(960)..")*(tan"..utf8(180).."((x+d/2)/y)-tan"..utf8(180).."((x-d/2)/y))", U("Bx",""..utf8(956).."0","Is",""..utf8(960),"tan","x","d","y")) 
aF(3, 2, "By="..utf8(956).."0*Is/(4*"..utf8(960)..")*ln((y^2+(x+d/2)^2)/(y^2+(x-d/2)^2))", U("By",""..utf8(956).."0","Is",""..utf8(960),"y","x","d")) 


addSubCat(3, 3, "Parallel Wires", "") 
aF(3, 3, "Fw="..utf8(956).."0*I1*I2/(2*"..utf8(960).."*D)", U("Fw",""..utf8(956).."0","I1","I2",""..utf8(960),"D")) 
aF(3, 3, "Bx="..utf8(956).."0/(2*"..utf8(960)..")*(I1/x-I2/(D-x))", U("Bx",""..utf8(956).."0",""..utf8(960),"I1","x","I2","D")) 
aF(3, 3, "L="..utf8(956).."0/(4*"..utf8(960)..")+"..utf8(956).."0/"..utf8(960).."*arccosh(D/(2*a))", U("L",""..utf8(956).."0",""..utf8(960),"D","a")) 


addSubCat(3, 4, "Loop", "") 
aF(3, 4, "B="..utf8(956).."0*I*a^2/(2*sqrt(a^2+z^2)^3)", U("B",""..utf8(956).."0","I","a","z")) 
aF(3, 4, "Ls="..utf8(956).."0*a*(ln(8*a/rr0)-2)", U("Ls",""..utf8(956).."0","a","rr0")) 
aF(3, 4, "L12=-"..utf8(956).."0*a*cos("..utf8(952)..")/(2*"..utf8(960)..")*ln((bl+d)/d)", U("L12",""..utf8(956).."0","a",""..utf8(952),""..utf8(960),"bl","d")) 
aF(3, 4, "T12="..utf8(956).."0*a*sin("..utf8(952)..")/(2*"..utf8(960)..")*I1*I2*ln((bl+d)/d)", U("T12",""..utf8(956).."0","a",""..utf8(952),""..utf8(960),"I1","I2","bl","d")) 


addSubCat(3, 5, "Coaxial Cable", "") 
aF(3, 5, "L="..utf8(956).."0/(8*"..utf8(960)..")+"..utf8(956).."0/(2*"..utf8(960)..")*ln(rb/ra)", U("L",""..utf8(956).."0",""..utf8(960),"rb","ra")) 


addSubCat(3, 6, "Skin Effect", "") 
aF(3, 6, utf8(948).."=1/sqrt("..utf8(960).."*f*"..utf8(956).."0*"..utf8(956).."r/"..utf8(961)..")", U(""..utf8(948),""..utf8(960),"f",""..utf8(956).."0",""..utf8(956).."r",""..utf8(961).."")) 
aF(3, 6, "Reff=sqrt("..utf8(960).."*f*"..utf8(956).."0*"..utf8(956).."r*"..utf8(961)..")", U("Reff",""..utf8(960),"f",""..utf8(956).."0",""..utf8(956).."r",""..utf8(961).."")) 




addCat(4, "Electron Motion", "") 

addCatVar(4, "A0", "Richardson"..utf8(8217).."s constant", "A/(m2*K2)")
addCatVar(4, "B", "Magnetic field", "T")
addCatVar(4, "d", "Deflection tube diameter, plate spacing", "m")
addCatVar(4, "f", "Frequency", "Hz")
addCatVar(4, "f0", "Critical frequency", "Hz")
addCatVar(4, "I", "Thermionic current", "A")
addCatVar(4, "L", "Deflecting plate length", "m")
addCatVar(4, "Ls", "Beam length to destination", "m")
addCatVar(4, "r", "Radius of circular path", "m")
addCatVar(4, "S", "Surface area", "m2")
addCatVar(4, "T", "Temperature", "K")
addCatVar(4, "v", "Vertical velocity", "m/s")
addCatVar(4, "Va", "Accelerating voltage", "V")
addCatVar(4, "Vd", "Deflecting voltage", "V")
addCatVar(4, "y", "Vertical deflection", "m")
addCatVar(4, "yd", "Beam deflection on screen", "m")
addCatVar(4, "z", "Distance along beam axis", "m")
addCatVar(4, utf8(966), "Work function", "V")


addSubCat(4, 1, "Beam Deflection", "") 
aF(4, 1, "v=sqrt(2*(q/me)*Va)", U("v","q","me","Va")) 
aF(4, 1, "r=me*v/(q*B)", U("r","me","v","q","B")) 
aF(4, 1, "yd=L*Ls/(2*d*Va)*Vd", U("yd","L","Ls","d","Va","Vd")) 
aF(4, 1, "y=q*Vd/(2*me*d*v^2)*z^2", U("y","q","Vd","me","d","v","z")) 


addSubCat(4, 2, "Thermionic Emi"..utf8(946).."ion", "") 
aF(4, 2, "I=A0*S*T^2*exp(-q*"..utf8(966).."/(k*T))", U("I","A0","S","T","q",""..utf8(966),"k")) 


addSubCat(4, 3, "Photoemi"..utf8(946).."ion", "") 
aF(4, 3, "h*f=q*"..utf8(966).."+1/2*me*v^2", U("h","f","q",""..utf8(966),"me","v")) 
aF(4, 3, "f0=q*"..utf8(966).."/h", U("f0","q",""..utf8(966),"h")) 




addCat(5, "Meters and Bridge Circuits", "") 

addCatVar(5, "a", "Resistance multiplier", "unitless")
addCatVar(5, "b", "Resistance Multiplier", "unitless")
addCatVar(5, "c", "Resistance Multiplier", "unitless")
addCatVar(5, "CC3", "Capacitance, arm 3", "F")
addCatVar(5, "CC4", "Capacitance, arm 4", "F")
addCatVar(5, "Cs", "Series capacitor", "F")
addCatVar(5, "Cx", "Unknown capacitor", "F")
addCatVar(5, "DB", "Attenuator loss", "unitless")
addCatVar(5, "f", "Frequency", "Hz")
addCatVar(5, "Ig", "Galvanometer current", "A")
addCatVar(5, "Imax", "Maximum current", "A")
addCatVar(5, "Isen", "Current sensitivity", "A")
addCatVar(5, "Lx", "Unknown inductance", "unitless")
addCatVar(5, "Q", "Quality Factor", "unitless")
addCatVar(5, "Radj", "Adjustable resistor", utf8(937))
addCatVar(5, "Rg", "Galvanometer resistance", utf8(937))
addCatVar(5, "Rj", "Resistance in L pad", utf8(937))
addCatVar(5, "Rk", "Resistance in L pad", utf8(937))
addCatVar(5, "Rl", "Resistance from left", utf8(937))
addCatVar(5, "Rm", "Meter resistance", utf8(937))
addCatVar(5, "Rr", "Resistance from right", utf8(937))
addCatVar(5, "RR1", "Resistance, arm 1", utf8(937))
addCatVar(5, "RR2", "Resistance, arm 2", utf8(937))
addCatVar(5, "RR3", "Resistance, arm 3", utf8(937))
addCatVar(5, "RR4", "Resistance, arm 4", utf8(937))
addCatVar(5, "Rs", "Series resistance", utf8(937))
addCatVar(5, "Rse", "Series resistance", utf8(937))
addCatVar(5, "Rsh", "Shunt resistance", "A")
addCatVar(5, "Rx", "Unknown resistance", utf8(937))
addCatVar(5, "Vm", "Voltage across meter", "V")
addCatVar(5, "Vmax", "Maximum voltage", "V")
addCatVar(5, "Vs", "Source voltage", "V")
addCatVar(5, "Vsen", "Voltage sensitivity", "V")
addCatVar(5, utf8(969), "Radian frequency", "rad/s")


addSubCat(5, 1, "A, V, Omega Meters", "") 
aF(5, 1, "Rsh=Rm*Isen/(Imax-Isen)", U("Rsh","Rm","Isen","Imax")) 
aF(5, 1, "Rs=(Vmax-Vsen)/Isen", U("Rs","Vmax","Vsen","Isen")) 
aF(5, 1, "Isen=Vs/(Rs+Rm+Radj/2)", U("Isen","Vs","Rs","Rm","Radj")) 


addSubCat(5, 2, "Wheatstone Bridge", "") 
aF(5, 2, "Rx/RR2=RR3/RR4", U("Rx","RR2","RR3","RR4")) 
aF(5, 2, "Vm=eegalv(Rx,RR2,RR3,RR4,Rg,Rs,Vs)", U("Vm","Rx","RR2","RR3","RR4","Rg","Rs","Vs")) 
aF(5, 2, "Ig=Vm/Rg", U("Ig","Vm","Rg")) 


addSubCat(5, 3, "Wien Bridge", "") 
aF(5, 3, "Cx=((RR3/RR1)-(Rs/Rx))*Cs", U("Cx","RR3","RR1","Rs","Rx","Cs")) 
aF(5, 3, "Cx=1/("..utf8(969).."^2*Rs*Rx*Cs)", U("Cx",""..utf8(969),"Rs","Rx","Cs")) 
aF(5, 3, "f=1/(2/"..utf8(960).."*Cs*Rs)", U("f",""..utf8(960),"Cs","Rs")) 
aF(5, 3, utf8(969).."=2*"..utf8(960).."*f", U(""..utf8(969),""..utf8(960),"f")) 


addSubCat(5, 4, "Maxwell Bridge", "") 
aF(5, 4, "Cx=((RR3/RR1)-(Rs/Rx))*Cs", U("Cx","RR3","RR1","Rs","Rx","Cs")) 
aF(5, 4, "Cx=1/("..utf8(969).."^2*Rs*Rx*Cs)", U("Cx",""..utf8(969),"Rs","Rx","Cs")) 
aF(5, 4, "f=1/(2/"..utf8(960).."*Cs*Rs)", U("f",""..utf8(960),"Cs","Rs")) 
aF(5, 4, utf8(969).."=2*"..utf8(960).."*f", U(""..utf8(969),""..utf8(960),"f")) 


addSubCat(5, 5, "Owen Bridge", "") 
aF(5, 5, "Lx=CC3*RR1*RR4", U("Lx","CC3","RR1","RR4")) 
aF(5, 5, "Rx=CC3*RR1/CC4-RR2", U("Rx","CC3","RR1","CC4","RR2")) 


addSubCat(5, 6, "Symmetrical Resistive Attenuator", "") 
aF(5, 6, "a=(10^(DB/20)-1)/(10^(DB/20)+1)", U("a","DB")) 
aF(5, 6, "b=2*10^(DB/20)/(10^(DB/10)-1)", U("b","DB")) 
aF(5, 6, "c=(10^(DB/20)-1)", U("c","DB")) 


addSubCat(5, 7, "Unsymmetrical Resistive Attenuator", "") 
aF(5, 7, "Rj=Rl-Rk*Rr/(Rk+Rr)", U("Rj","Rl","Rk","Rr")) 
aF(5, 7, "Rk=sqrt(Rl*Rr^2/(Rl-Rr))", U("Rk","Rl","Rr")) 
aF(5, 7, "DB=20*LOG(sqrt((Rl-Rr)/Rr)+sqrt(Rl/Rr))", U("DB","Rl","Rr")) 




addCat(6, "RL and RC Circuits", "") 

addCatVar(6, "C", "Capacitor", "F")
addCatVar(6, "Cs", "Series capacitance", "F")
addCatVar(6, "Cp", "Parallel capacitance", "F")
addCatVar(6, "f", "Frequency", "Hz")
addCatVar(6, "iC", "Capacitor current", "A")
addCatVar(6, "iL", "Inductor current", "A")
addCatVar(6, "I0", "Initial inductor current", "A")
addCatVar(6, "L", "Inductance", "H")
addCatVar(6, "Lp", "Parallel inductance", "H")
addCatVar(6, "Ls", "Series inductance", "H")
addCatVar(6, "Qp", "Q, parallel circuit", "unitless")
addCatVar(6, "Qs", "Q, series circuit", "unitless")
addCatVar(6, "R", "Resistance", utf8(937))
addCatVar(6, "Rp", "Parallel resistance", utf8(937))
addCatVar(6, "Rs", "Series resistance", utf8(937))
addCatVar(6, utf8(964), "Time constant", "s")
addCatVar(6, "t", "Time", "s")
addCatVar(6, "vC", "Capacitor voltage", "V")
addCatVar(6, "vL", "Inductor voltage", "V")
addCatVar(6, "V0", "Initial capacitor voltage", "V")
addCatVar(6, "Vs", "Voltage stimulus", "V")
addCatVar(6, utf8(969), "Radian frequency", "rad/s") -- lowercase omega
addCatVar(6, "W", "Energy dissipated", "J")


addSubCat(6, 1, "RL Natural Response", "") 
aF(6, 1, utf8(964).."=L/R", U(""..utf8(964),"L","R")) 
aF(6, 1, "vL=I0*R*exp(-t/"..utf8(964)..")", U("vL","I0","R","t",""..utf8(964).."")) 
aF(6, 1, "iL=I0*exp(-t/"..utf8(964)..")", U("iL","I0","t",""..utf8(964).."")) 
aF(6, 1, "W=1/2*L*I0^2*(1-exp(-2*t/"..utf8(964).."))", U("W","L","I0","t",""..utf8(964).."")) 


addSubCat(6, 2, "RC Natural Response", "") 
aF(6, 2, utf8(964).."=R*C", U(""..utf8(964),"R","C")) 
aF(6, 2, "vC=V0*exp(-t/"..utf8(964)..")", U("vC","V0","t",""..utf8(964).."")) 
aF(6, 2, "iC=V0/R*exp(-t/"..utf8(964)..")", U("iC","V0","R","t",""..utf8(964).."")) 
aF(6, 2, "W=1/2*C*V0^2*(1-exp(-2*t/"..utf8(964).."))", U("W","C","V0","t",""..utf8(964).."")) 


addSubCat(6, 3, "RL Step Response", "") 
aF(6, 3, utf8(964).."=L/R", U(""..utf8(964),"L","R")) 
aF(6, 3, "vL=(Vs-I0*R)*exp(-t/"..utf8(964)..")", U("vL","Vs","I0","R","t",""..utf8(964).."")) 
aF(6, 3, "iL=Vs/R+(I0-Vs/R)*exp(-t/"..utf8(964)..")", U("iL","Vs","R","I0","t",""..utf8(964).."")) 


addSubCat(6, 4, "RC Step Response", "") 
aF(6, 4, utf8(964).."=R*C", U(""..utf8(964),"R","C")) 
aF(6, 4, "vC=Vs+(V0-Vs)*exp(-t/"..utf8(964)..")", U("vC","Vs","V0","t",""..utf8(964).."")) 
aF(6, 4, "iC=(Vs-V0)/R*exp(-t/"..utf8(964)..")", U("iC","Vs","V0","R","t",""..utf8(964).."")) 


addSubCat(6, 5, "RL Series-Parallel", "") 
aF(6, 5, utf8(969).."=2*"..utf8(960).."*f", U(""..utf8(969),""..utf8(960),"f")) 
aF(6, 5, "Qs="..utf8(969).."*Ls/Rs", U("Qs",""..utf8(969),"Ls","Rs")) 
aF(6, 5, "Rp=(Rs^2+"..utf8(969).."^2*Ls^2)/Rs", U("Rp","Rs",""..utf8(969),"Ls")) 
aF(6, 5, "Lp=(Rs^2+"..utf8(969).."^2*Ls^2)/("..utf8(969).."^2*Ls)", U("Lp","Rs",""..utf8(969),"Ls")) 
aF(6, 5, "Qp=Rp/("..utf8(969).."*Lp)", U("Qp","Rp",""..utf8(969),"Lp")) 
aF(6, 5, "Rs="..utf8(969).."^2*Lp^2*Rp/(Rp^2+"..utf8(969).."^2*Lp^2)", U("Rs",""..utf8(969),"Lp","Rp")) 
aF(6, 5, "Ls=Rp^2*Lp/(Rp^2+"..utf8(969).."^2*Lp^2)", U("Ls","Rp","Lp",""..utf8(969).."")) 
aF(6, 5, "Rp=Rs*(1+Qs^2)", U("Rp","Rs","Qs")) 
aF(6, 5, "Lp=Ls*(1+1/Qs^2)", U("Lp","Ls","Qs")) 
aF(6, 5, "Rs=Rp/(1+Qp^2)", U("Rs","Rp","Qp")) 
aF(6, 5, "Ls=Qp^2*Lp/(1+Qp^2)", U("Ls","Qp","Lp")) 


addSubCat(6, 6, "RC Series-Parallel", "") 
aF(6, 6, utf8(969).."=2*"..utf8(960).."*f", U(""..utf8(969),""..utf8(960),"f")) 
aF(6, 6, "Qs=1/("..utf8(969).."*Rs*Cs)", U("Qs",""..utf8(969),"Rs","Cs")) 
aF(6, 6, "Rp=Rs*(1+1/("..utf8(969).."^2*Rs^2*Cs^2))", U("Rp","Rs",""..utf8(969),"Cs")) 
aF(6, 6, "Cp=Cs/(1+"..utf8(969).."^2*Cs^2*Rs^2)", U("Cp","Cs",""..utf8(969),"Rs")) 
aF(6, 6, "Qp="..utf8(969).."*Rp*Cp", U("Qp",""..utf8(969),"Rp","Cp")) 
aF(6, 6, "Rs=Rp/(1+"..utf8(969).."^2*Rp^2*Cp^2)", U("Rs","Rp",""..utf8(969),"Cp")) 
aF(6, 6, "Cs=(1+"..utf8(969).."^2*Rp^2*Cp^2)/("..utf8(969).."^2*Rp^2*Cp)", U("Cs",""..utf8(969),"Rp","Cp")) 
aF(6, 6, "Rp=Rs*(1+Qs^2)", U("Rp","Rs","Qs")) 
aF(6, 6, "Cp=Cs/(1+1/Qs^2)", U("Cp","Cs","Qs")) 
aF(6, 6, "Rs=Rp/(1+Qp^2)", U("Rs","Rp","Qp")) 
aF(6, 6, "Cs=Cp*(1+Qp^2)/Qp^2", U("Cs","Cp","Qp")) 




addCat(7, "RLC Circuits", "") 

addCatVar(7, utf8(945), "Neper"..utf8(8217).."s frequency", "rad/s") --alpha, apostrophe
addCatVar(7, "A1", "Constant", "V")
addCatVar(7, "A2", "Constant", "V")
addCatVar(7, "B", "Susceptance", "S")
addCatVar(7, "B1", "Constant", "V")
addCatVar(7, "B2", "Constant", "V")
addCatVar(7, "BC", "Capacitive susceptance", "S")
addCatVar(7, "BL", "Inductive susceptance", "S")
addCatVar(7, "C", "Capacitance", "F")
addCatVar(7, "D1", "Constant", "V/s")
addCatVar(7, "D2", "Constant", "V")
addCatVar(7, "f", "Frequency", "Hz")
addCatVar(7, "G", "Conductance", "S")
addCatVar(7, "I0", "Initial inductor current", "A")
addCatVar(7, "L", "Inductance", "H")
addCatVar(7, utf8(952), "Phase angle", "rad") --theta
addCatVar(7, "R", "Resistance", utf8(937))
addCatVar(7, "s1", "Characteristic frequency", "rad/s")
addCatVar(7, "s2", "Characteristic frequency", "rad/s")
addCatVar(7, "s1i", "Characteristic frequency (imaginary)", "rad/s")
addCatVar(7, "s1r", "Characteristic frequency (real)", "rad/s")
addCatVar(7, "s2i", "Characteristic frequency (imaginary)", "rad/s")
addCatVar(7, "s2r", "Characteristic frequency (real)", "rad/s")
addCatVar(7, "t", "Time", "s")
addCatVar(7, "v", "Capacitor voltage", "V")
addCatVar(7, "V0", "Initial capacitor voltage", "V")
addCatVar(7, utf8(969), "Radian Frequency", "rad/s") -- lowercase omega
addCatVar(7, utf8(969).."d", "Damped radian frequency", "rad/s")
addCatVar(7, utf8(969).."0", "Classical radian frequency", "rad/s")
addCatVar(7, "X", "Reactance", utf8(937))
addCatVar(7, "XXC", "Capacitive reactance", utf8(937))
addCatVar(7, "XL", "Inductive reactance", utf8(937))
addCatVar(7, "Ym", "Admittance "..utf8(8211).." magnitude", "S")
addCatVar(7, "Zm", "Impedance "..utf8(8211).." magnitude", "S")


addSubCat(7, 1, "Series Impedance", "") 
aF(7, 1, "abs(Zm)^2=R^2+X^2", U("Zm","R","X")) 
aF(7, 1, utf8(952).."=tan"..utf8(180).."(X/R)", U(""..utf8(952),"tan","X","R")) 
aF(7, 1, "X=XL+XXC", U("X","XL","XXC")) 
aF(7, 1, "XL="..utf8(969).."*L", U("XL",""..utf8(969),"L")) 
aF(7, 1, "XXC=-1/("..utf8(969).."*C)", U("XXC",""..utf8(969),"C")) 
aF(7, 1, utf8(969).."=2*"..utf8(960).."*f", U(""..utf8(969),""..utf8(960),"f")) 


addSubCat(7, 2, "Parallel Admittance", "") 
aF(7, 2, "abs(Ym)^2=G^2+B^2", U("Ym","G","B")) 
aF(7, 2, utf8(952).."=tan"..utf8(180).."(G/B)", U(""..utf8(952),"tan","G","B")) 
aF(7, 2, "G=1/R", U("G","R")) 
aF(7, 2, "B=BL+BC", U("B","BL","BC")) 
aF(7, 2, "BL=-1/("..utf8(969).."*L)", U("BL",""..utf8(969),"L")) 
aF(7, 2, "BC="..utf8(969).."*C", U("BC",""..utf8(969),"C")) 
aF(7, 2, utf8(969).."=2*"..utf8(960).."*f", U(""..utf8(969),""..utf8(960),"f")) 


addSubCat(7, 3, "RLC Natural Response", "") 
aF(7, 3, "s1r=real(-"..utf8(945).."+sqrt("..utf8(945).."^2-"..utf8(969).."0^2))", U("s1r",""..utf8(945),""..utf8(969).."0")) 
aF(7, 3, "s1i=imag(-"..utf8(945).."+sqrt("..utf8(945).."^2-"..utf8(969).."0^2))", U("s1i",""..utf8(945),""..utf8(969).."0")) 
aF(7, 3, "s2r=real(-"..utf8(945).."-sqrt("..utf8(945).."^2-"..utf8(969).."0^2))", U("s2r",""..utf8(945),""..utf8(969).."0")) 
aF(7, 3, "s2i=imag(-"..utf8(945).."-sqrt("..utf8(945).."^2-"..utf8(969).."0^2))", U("s2i",""..utf8(945),""..utf8(969).."0")) 
aF(7, 3, utf8(969).."0=sqrt(1/(L*C))", U(""..utf8(969).."0","L","C")) 
aF(7, 3, utf8(945).."=1/(2*R*C)", U(""..utf8(945),"R","C")) 


addSubCat(7, 4, "Underdamped Transient Case", "") 
aF(7, 4, utf8(969).."0=sqrt(1/(L*C))", U(""..utf8(969).."0","L","C")) 
aF(7, 4, utf8(945).."=1/(2*R*C)", U(""..utf8(945),"R","C")) 
aF(7, 4, utf8(969).."d=sqrt("..utf8(969).."0^2-"..utf8(945).."^2)", U(""..utf8(969).."d",""..utf8(969).."0",""..utf8(945).."")) 
aF(7, 4, "v=B1*exp(-"..utf8(945).."*t)*cos("..utf8(969).."d*t)+B2*exp(-"..utf8(945).."*t)*sin("..utf8(969).."d*t)", U("v","B1",""..utf8(945),"t",""..utf8(969).."d","B2")) 
aF(7, 4, "B1=V0", U("B1","V0")) 
aF(7, 4, "B2=-"..utf8(945).."/"..utf8(969).."d*(V0-2R*I0)", U("B2",""..utf8(945),""..utf8(969).."d","V0","R","I0")) 


addSubCat(7, 5, "Critically-Damped Transient Case", "") 
aF(7, 5, utf8(945).."=1/(2*R*C)", U(""..utf8(945),"R","C")) 
aF(7, 5, utf8(969).."0=sqrt(1/(L*C))", U(""..utf8(969).."0","L","C")) 
aF(7, 5, "v=D1*t*exp(-"..utf8(945).."*t)+D2*exp(-"..utf8(945).."*t)", U("v","D1","t",""..utf8(945),"D2")) 
aF(7, 5, "D1=I0/C+"..utf8(945).."*V0", U("D1","I0","C",""..utf8(945),"V0")) 
aF(7, 5, "D2=V0", U("D2","V0")) 


addSubCat(7, 6, "Overdamped Transient Case", "") 
aF(7, 6, "s1=-"..utf8(945).."+sqrt("..utf8(945).."^2-"..utf8(969).."0^2)", U("s1",""..utf8(945),""..utf8(969).."0")) 
aF(7, 6, "s2=-"..utf8(945).."-sqrt("..utf8(945).."^2-"..utf8(969).."0^2)", U("s2",""..utf8(945),""..utf8(969).."0")) 
aF(7, 6, utf8(969).."0=1/sqrt(L*C)", U(""..utf8(969).."0","L","C")) 
aF(7, 6, utf8(945).."=1/(2*R*C)", U(""..utf8(945),"R","C")) 
aF(7, 6, "v=A1*exp(s1*t)+A2*exp(s2*t)", U("v","A1","s1","t","A2","s2")) 
aF(7, 6, "A1=(V0*s2+1/C*(V0/R+I0))/(s2-s1)", U("A1","V0","s2","C","R","I0","s1")) 
aF(7, 6, "A2=-(V0*s1+1/C*(V0/R+I0))/(s2-s1)", U("A2","V0","s1","C","R","I0","s2")) 




addCat(8, "AC Circuits", "") 

addCatVar(8, "C", "Capacitance", "F")
addCatVar(8, "f", "Frequency", "Hz")
addCatVar(8, "I", "Instantaneous current", "A")
addCatVar(8, "Im", "Current amplitude", "A")
addCatVar(8, "L", "Inductance", "H")
addCatVar(8, utf8(952), "Impedance phase angle", "rad")
addCatVar(8, utf8(952).."1", "Phase angle 1", "rad")
addCatVar(8, utf8(952).."2", "Phase angle 2", "rad")
addCatVar(8, "R", "Resistance", utf8(937))
addCatVar(8, "RR1", "Resistance 1", utf8(937))
addCatVar(8, "RR2", "Resistance 2", utf8(937))
addCatVar(8, "t", "Time", "s")
addCatVar(8, "V", "Total voltage", "V")
addCatVar(8, "VC", "Voltage across capacitor", "V")
addCatVar(8, "VL", "Voltage across inductor", "V")
addCatVar(8, "Vm", "Maximum voltage", "V")
addCatVar(8, "VR", "Voltage across resistor", "V")
addCatVar(8, utf8(969), "Radian frequency", "rad/s")
addCatVar(8, "X", "Reactance", utf8(937))
addCatVar(8, "XX1", "Reactance 1", utf8(937))
addCatVar(8, "XX2", "Reactance 2", utf8(937))
addCatVar(8, "Y"..utf8(95), "Admittance", "S")
addCatVar(8, "Z1m", "Impedance 1 magnitude", utf8(937))
addCatVar(8, "Z2m", "Impedance 2 magnitude", utf8(937))
addCatVar(8, "Z"..utf8(95), "Complex impedance", utf8(937))
addCatVar(8, "Zm", "Impedance magnitude", utf8(937))


addSubCat(8, 1, "RL Series Impedance", "") 
aF(8, 1, "I=Im*sin("..utf8(969).."*t)", U("I","Im",""..utf8(969),"t")) 
aF(8, 1, "abs(Zm)^2=R^2+"..utf8(969).."^2*L^2", U("Zm","R",""..utf8(969),"L")) 
aF(8, 1, "VR=Zm*Im*sin("..utf8(969).."*t)*cos("..utf8(952)..")", U("VR","Zm","Im",""..utf8(969),"t",""..utf8(952).."")) 
aF(8, 1, "VL=Zm*Im*cos("..utf8(969).."*t)*sin("..utf8(952)..")", U("VL","Zm","Im",""..utf8(969),"t",""..utf8(952).."")) 
aF(8, 1, "V=VR+VL", U("V","VR","VL")) 
aF(8, 1, "Vm=Im*Zm", U("Vm","Im","Zm")) 
aF(8, 1, utf8(952).."=tan"..utf8(180).."("..utf8(969).."*L/R)", U(""..utf8(952),"tan",""..utf8(969),"L","R")) 
aF(8, 1, utf8(969).."=2*"..utf8(960).."*f", U(""..utf8(969),""..utf8(960),"f")) 


addSubCat(8, 2, "RC Series Impedance", "") 
aF(8, 2, "I=Im*sin("..utf8(969).."*t)", U("I","Im",""..utf8(969),"t")) 
aF(8, 2, "abs(Zm)^2=R^2+1/("..utf8(969).."*C)^2", U("Zm","R",""..utf8(969),"C")) 
aF(8, 2, "VR=Zm*Im*sin("..utf8(969).."*t)*cos("..utf8(952)..")", U("VR","Zm","Im",""..utf8(969),"t",""..utf8(952).."")) 
aF(8, 2, "VC=Zm*Im*cos("..utf8(969).."*t)*sin("..utf8(952)..")", U("VC","Zm","Im",""..utf8(969),"t",""..utf8(952).."")) 
aF(8, 2, "V=VR+VC", U("V","VR","VC")) 
aF(8, 2, "Vm=Im*Zm", U("Vm","Im","Zm")) 
aF(8, 2, utf8(952).."=tan"..utf8(180).."(-1/("..utf8(969).."*C*R))", U(""..utf8(952),"tan",""..utf8(969),"C","R")) 
aF(8, 2, utf8(969).."=2*"..utf8(960).."*f", U(""..utf8(969),""..utf8(960),"f")) 


addSubCat(8, 3, "Impedance "..utf8(60).."-"..utf8(62).." Admittance", "") 
aF(8, 3, "Y"..utf8(95).."=1/Z"..utf8(95), U("Y")) 


addSubCat(8, 4, "Two Impedances in Series", "") 
aF(8, 4, "abs(Zm)^2=R^2+X^2", U("Zm","R","X")) 
aF(8, 4, utf8(952).."=tan"..utf8(180).."(X/R)", U(""..utf8(952),"tan","X","R")) 
aF(8, 4, "R=RR1+RR2", U("R","RR1","RR2")) 
aF(8, 4, "X=XX1+XX2", U("X","XX1","XX2")) 
aF(8, 4, "abs(Z1m)^2=RR1^2+XX1^2", U("Z1m","RR1","XX1")) 
aF(8, 4, "abs(Z2m)^2=RR2^2+XX2^2", U("Z2m","RR2","XX2")) 
aF(8, 4, utf8(952).."1=tan"..utf8(180).."(XX1/RR1)", U(""..utf8(952).."1","tan","XX1","RR1")) 
aF(8, 4, utf8(952).."2=tan"..utf8(180).."(XX2/RR2)", U(""..utf8(952).."2","tan","XX2","RR2")) 


addSubCat(8, 5, "Two Impedances in Parallel", "") 
aF(8, 5, "abs(Zm)^2=((RR1*RR2-XX1*XX2)^2+(RR1*XX2+RR2*XX1)^2)/((RR1+RR2)^2+(XX1+XX2)^2)", U("Zm","RR1","RR2","XX1","XX2")) 
aF(8, 5, utf8(952).."=tan"..utf8(180).."((XX1*RR2+RR1*XX2)/(RR1*RR2-XX1*XX2))-tan"..utf8(180).."((XX1+XX2)/(RR1+RR2))", U(""..utf8(952),"tan","XX1","RR2","RR1","XX2")) 
aF(8, 5, "R=Zm*cos("..utf8(952)..")", U("R","Zm",""..utf8(952).."")) 
aF(8, 5, "X=Zm*sin("..utf8(952)..")", U("X","Zm",""..utf8(952).."")) 
aF(8, 5, "abs(Z1m)^2=RR1^2+XX1^2", U("Z1m","RR1","XX1")) 
aF(8, 5, "abs(Z2m)^2=RR2^2+XX2^2", U("Z2m","RR2","XX2")) 
aF(8, 5, utf8(952).."1=tan"..utf8(180).."(XX1/RR1)", U(""..utf8(952).."1","tan","XX1","RR1")) 
aF(8, 5, utf8(952).."2=tan"..utf8(180).."(XX2/RR2)", U(""..utf8(952).."2","tan","XX2","RR2")) 




addCat(9, "Polyphase Circuits", "") 

addCatVar(9, "IL", "Line current", "A")
addCatVar(9, "Ip", "Phase current", "A")
addCatVar(9, "P", "Power per phase", "W")
addCatVar(9, "PT", "Total power", "W")
addCatVar(9, utf8(952), "Impedance angle", "rad")
addCatVar(9, "VL", "Line voltage", "V")
addCatVar(9, "Vp", "Phase voltage", "V")
addCatVar(9, "W1", "Wattmeter 1", "W")
addCatVar(9, "W2", "Wattmeter 2", "W")


addSubCat(9, 1, "Balanced Delta Network", "") 
aF(9, 1, "VL=Vp", U("VL","Vp")) 
aF(9, 1, "IL=sqrt(3)*Ip", U("IL","Ip")) 
aF(9, 1, "P=Vp*Ip*cos("..utf8(952)..")", U("P","Vp","Ip",""..utf8(952).."")) 
aF(9, 1, "PT=3*Vp*Ip*cos("..utf8(952)..")", U("PT","Vp","Ip",""..utf8(952).."")) 
aF(9, 1, "PT=sqrt(3)*VL*IL*cos("..utf8(952)..")", U("PT","VL","IL",""..utf8(952).."")) 


addSubCat(9, 2, "Balanced Wye Network", "") 
aF(9, 2, "VL=sqrt(3)*Vp", U("VL","Vp")) 
aF(9, 2, "IL=Ip", U("IL","Ip")) 
aF(9, 2, "P=Vp*Ip*cos("..utf8(952)..")", U("P","Vp","Ip",""..utf8(952).."")) 
aF(9, 2, "PT=3*Vp*Ip*cos("..utf8(952)..")", U("PT","Vp","Ip",""..utf8(952).."")) 
aF(9, 2, "PT=sqrt(3)*VL*IL*cos("..utf8(952)..")", U("PT","VL","IL",""..utf8(952).."")) 


addSubCat(9, 3, "Power Measurements", "") 
aF(9, 3, "W1=VL*IL*cos("..utf8(952).."+"..utf8(960).."/6)", U("W1","VL","IL",""..utf8(952),""..utf8(960).."")) 
aF(9, 3, "W2=VL*IL*cos("..utf8(952).."-"..utf8(960).."/6)", U("W2","VL","IL",""..utf8(952),""..utf8(960).."")) 
aF(9, 3, "PT=sqrt(3)*VL*IL*cos("..utf8(952)..")", U("PT","VL","IL",""..utf8(952).."")) 




addCat(10, "Electrical Resonance", "") 

addCatVar(10, utf8(945), "Damping coefficient", "rad/s")
addCatVar(10, utf8(946), "Bandwidth", "rad/s")
addCatVar(10, "C", "Capacitance", "F")
addCatVar(10, "Im", "Current", "A")
addCatVar(10, "L", "Inductance", "H")
addCatVar(10, utf8(952), "Phase angle", "rad")
addCatVar(10, "Q", "Quality factor", "unitless")
addCatVar(10, "R", "Resistance", utf8(937))
addCatVar(10, "Rg", "Generator resistance", utf8(937))
addCatVar(10, "Vm", "Maximum voltage", "V")
addCatVar(10, utf8(969), "Radian frequency", "rad/s")
addCatVar(10, utf8(969).."0", "Resonant frequency", "rad/s")
addCatVar(10, utf8(969).."1", "Lower cutoff frequency", "rad/s")
addCatVar(10, utf8(969).."2", "Upper cutoff frequency", "rad/s")
addCatVar(10, utf8(969).."d", "Damped resonant frequency", "rad/s")
addCatVar(10, utf8(969).."m", "Frequency for maximum amplitude", "rad/s")
addCatVar(10, "Yres", "Admittance at resonance", "S")
addCatVar(10, "Z", "Impedance", utf8(937))
addCatVar(10, "Zres", "Impedance at resonance", utf8(937))


addSubCat(10, 1, "Parallel Resonance I", "") 
aF(10, 1, "Vm=Im/sqrt(1/R^2+("..utf8(969).."*C-1/("..utf8(969).."*L))^2)", U("Vm","Im","R",""..utf8(969),"C","L")) 
aF(10, 1, utf8(952).."=tan"..utf8(180).."(("..utf8(969).."*C-1/("..utf8(969).."*L))*R)", U(""..utf8(952),"tan",""..utf8(969),"C","L","R")) 
aF(10, 1, utf8(969).."0=1/sqrt(L*C)", U(""..utf8(969).."0","L","C")) 
aF(10, 1, utf8(969).."1=-1/(2*R*C)+sqrt(1/(2*R*C)^2+1/(L*C))", U(""..utf8(969).."1","R","C","L")) 
aF(10, 1, utf8(969).."2= 1/(2*R*C)+sqrt(1/(2*R*C)^2+1/(L*C))", U(""..utf8(969).."2","R","C","L")) 
aF(10, 1, utf8(946).."="..utf8(969).."2-"..utf8(969).."1", U(""..utf8(946),""..utf8(969).."2",""..utf8(969).."1")) 
aF(10, 1, "Q="..utf8(969).."0/"..utf8(946), U("Q",""..utf8(969).."0",""..utf8(946).."")) 
aF(10, 1, "Q=R*sqrt(C/L)", U("Q","R","C","L")) 
aF(10, 1, "Q="..utf8(969).."0*R*C", U("Q",""..utf8(969).."0","R","C")) 


addSubCat(10, 2, "Parallel Resonance II", "") 
aF(10, 2, "Q="..utf8(969).."0/"..utf8(946), U("Q",""..utf8(969).."0",""..utf8(946).."")) 
aF(10, 2, utf8(969).."1="..utf8(969).."0*(-1/(2*Q)+sqrt(1/(2*Q)^2+1))", U(""..utf8(969).."1",""..utf8(969).."0","Q")) 
aF(10, 2, utf8(969).."2="..utf8(969).."0*( 1/(2*Q)+sqrt(1/(2*Q)^2+1))", U(""..utf8(969).."2",""..utf8(969).."0","Q")) 
aF(10, 2, utf8(945).."=1/(2*R*C)", U(""..utf8(945),"R","C")) 
aF(10, 2, utf8(945).."="..utf8(969).."0/(2*Q)", U(""..utf8(945),""..utf8(969).."0","Q")) 
aF(10, 2, utf8(969).."d=sqrt("..utf8(969).."0^2-"..utf8(945).."^2)", U(""..utf8(969).."d",""..utf8(969).."0",""..utf8(945).."")) 
aF(10, 2, utf8(969).."d="..utf8(969).."0*sqrt(1-1/(4*Q^2))", U(""..utf8(969).."d",""..utf8(969).."0","Q")) 


addSubCat(10, 3, "Resonance in a Lo"..utf8(946).."y Inductor", "") 
aF(10, 3, utf8(969).."0=sqrt(1/(L*C)-(R/L)^2)", U(""..utf8(969).."0","L","C","R")) 
aF(10, 3, "Yres=(L+Rg*R*C)/(L*Rg)", U("Yres","L","Rg","R","C")) 
aF(10, 3, "Zres=1/Yres", U("Zres","Yres")) 
aF(10, 3, utf8(969).."m=sqrt(sqrt((1/(L*C))^2*(1+2*R/Rg)+(R/L)^2*(2/(L*C)))-(R/L)^2)", U(""..utf8(969).."m","L","C","R","Rg")) 


addSubCat(10, 4, "Series Resonance", "") 
aF(10, 4, utf8(969).."0=(1/sqrt(L*C))", U(""..utf8(969).."0","L","C")) 
aF(10, 4, "Z=sqrt(R^2+("..utf8(969).."*L-1/("..utf8(969).."*C))^2)", U("Z","R",""..utf8(969),"L","C")) 
aF(10, 4, utf8(952).."=tan"..utf8(180).."(("..utf8(969).."*L-1/("..utf8(969).."*C))/R)", U(""..utf8(952),"tan",""..utf8(969),"L","C","R")) 
aF(10, 4, utf8(969).."1=-R/(2*L)+sqrt((R/(2*L))^2+1/(L*C))", U(""..utf8(969).."1","R","L","C")) 
aF(10, 4, utf8(969).."2=R/(2*L)+sqrt((R/(2*L))^2+1/(L*C))", U(""..utf8(969).."2","R","L","C")) 
aF(10, 4, utf8(946).."="..utf8(969).."2-"..utf8(969).."1", U(""..utf8(946),""..utf8(969).."2",""..utf8(969).."1")) 
aF(10, 4, utf8(946).."=R/L", U(""..utf8(946),"R","L")) 
aF(10, 4, "Q="..utf8(969).."0*L/R", U("Q",""..utf8(969).."0","L","R")) 
aF(10, 4, "Q=1/R*sqrt(L/C)", U("Q","R","L","C")) 




addCat(11, "OpAmp Circuits", "") 

addCatVar(11, "Acc", "Common Mode current gain", "unitless", "")
addCatVar(11, "Aco", "Common Mode gain from real OpAmp", "unitless")
addCatVar(11, "Ad", "Differential mode gain", "unitless")
addCatVar(11, "Agc", "Transconductance", "S")
addCatVar(11, "Aic", "Current gain", "unitless")
addCatVar(11, "Av", "Voltage gain", "unitless")
addCatVar(11, "CC1", "Input capacitor", "F")
addCatVar(11, "Cf", "Feedback capacitor", "F")
addCatVar(11, "CMRR", "CM rejection ratio", "unitless")
addCatVar(11, "Cp", "Bypass capacitor", "F")
addCatVar(11, "fcp", "3dB bandwidth, circuit", "Hz")
addCatVar(11, "fd", "Characteristic frequency", "Hz")
addCatVar(11, "f0", "Passband, geometric center", "Hz")
addCatVar(11, "fop", "3dB bandwidth, OpAmp", "Hz")
addCatVar(11, "IIf", "Maximum current through Rf", "A")
addCatVar(11, "RR1", "Input resistor", utf8(937))
addCatVar(11, "RR2", "Current stabilizor", utf8(937))
addCatVar(11, "RR3", "Feedback resistor", utf8(937))
addCatVar(11, "RR4", "Resistor", utf8(937))
addCatVar(11, "Rf", "Feedback resistor", utf8(937))
addCatVar(11, "Rin", "Input resistance", utf8(937))
addCatVar(11, "Rl", "Load resistance", utf8(937))
addCatVar(11, "Ro", "Output resistance, OpAmp", utf8(937))
addCatVar(11, "Rout", "Output resistance", utf8(937))
addCatVar(11, "Rp", "Bias current resistor", utf8(937))
addCatVar(11, "Rs", "Voltage divide resistor", utf8(937))
addCatVar(11, "tr", "10-90"..utf8(37).." rise time", "s")
addCatVar(11, "dVH", "Hysteresis", "V")
addCatVar(11, "VL", "Detection threshold, low", "V")
addCatVar(11, "Vomax", "Maximum circuit output", "V")
addCatVar(11, "VR", "Reference voltage", "V")
addCatVar(11, "Vrate", "Maximum voltage rate", "V/s")
addCatVar(11, "VU", "Detection threshold, high", "V")
addCatVar(11, "Vz1", "Zener breakdown 1", "V")
addCatVar(11, "Vz2", "Zener breakdown 2", "V")


addSubCat(11, 1, "Basic Inverter", "") 
aF(11, 1, "Av=-Rf/RR1", U("Av","Rf","RR1")) 
aF(11, 1, "Rp=RR1*Rf/(RR1+Rf)", U("Rp","RR1","Rf")) 
aF(11, 1, "fcp=fop*Av*(RR1/Rf)", U("fcp","fop","Av","RR1","Rf")) 
aF(11, 1, "tr=0.35*Rf/(fop*Av*RR1)", U("tr","Rf","fop","Av","RR1")) 


addSubCat(11, 2, "Non-Inverting Amplifier", "") 
aF(11, 2, "Av=1+Rf/RR1", U("Av","Rf","RR1")) 
aF(11, 2, "Rp=RR1*Rf/(RR1+Rf)", U("Rp","RR1","Rf")) 


addSubCat(11, 3, "Current Amplifier", "") 
aF(11, 3, "Aic=(Rs+Rf)*Av/(Rl+Ro+Rs*(1+Av))", U("Aic","Rs","Rf","Av","Rl","Ro")) 
aF(11, 3, "Rin=Rf/(1+Av)", U("Rin","Rf","Av")) 
aF(11, 3, "Rout=Rs*(1+Av)", U("Rout","Rs","Av")) 


addSubCat(11, 4, "Transconductance Amplifier", "") 
aF(11, 4, "Agc=1/Rs", U("Agc","Rs")) 
aF(11, 4, "Rout=Rs*(1+Av)", U("Rout","Rs","Av")) 


addSubCat(11, 5, "Level Detector (Inverting)", "") 
aF(11, 5, "RR1=Rp*Rf/(Rp+Rf)", U("RR1","Rp","Rf")) 
aF(11, 5, "dVH=(Vz1+Vz2)*Rp/(Rp+Rf)", U("VH","Vz1","Vz2","Rp","Rf")) 
aF(11, 5, "VU=(VR*Rf+Rp*Vz1)/(Rf+Rp)", U("VU","VR","Rf","Rp","Vz1")) 
aF(11, 5, "VL=(VR*Rf-Rp*Vz2)/(Rf+Rp)", U("VL","VR","Rf","Rp","Vz2")) 


addSubCat(11, 6, "Level Detector (Non-inverting)", "") 
aF(11, 6, "RR1=Rp*Rf/(Rp+Rf)", U("RR1","Rp","Rf")) 
aF(11, 6, "dVH=(Vz1+Vz2)*Rp/(Rp+Rf)", U("VH","Vz1","Vz2","Rp","Rf")) 
aF(11, 6, "VU=(VR*(Rf+Rp)+Rp*Vz2)/Rf", U("VU","VR","Rf","Rp","Vz2")) 
aF(11, 6, "VL=(VR*(Rp+Rf)-Rp*Vz1)/Rf", U("VL","VR","Rp","Rf","Vz1")) 


addSubCat(11, 7, "Differentiator", "") 
aF(11, 7, "Rf=Vomax/IIf", U("Rf","Vomax","IIf")) 
aF(11, 7, "Rp=Rf", U("Rp","Rf")) 
aF(11, 7, "CC1=Vomax/(Rf*Vrate)", U("CC1","Vomax","Rf","Vrate")) 
aF(11, 7, "RR1=1/(2*"..utf8(960).."*fd*CC1)", U("RR1",""..utf8(960),"fd","CC1")) 
aF(11, 7, "fd=1/(2*"..utf8(960).."*Rf*CC1)", U("fd",""..utf8(960),"Rf","CC1")) 
aF(11, 7, "Cp=10/(2*"..utf8(960).."*f0*Rp)", U("Cp",""..utf8(960),"f0","Rp")) 
aF(11, 7, "Cf=1/(4*"..utf8(960).."*f0*Rf)", U("Cf",""..utf8(960),"f0","Rf")) 


addSubCat(11, 8, "Differential Amplifier", "") 
aF(11, 8, "Ad=RR3/RR1", U("Ad","RR3","RR1")) 
aF(11, 8, "Aco=RR3^2/(RR1*(RR1+RR3)*CMRR)", U("Aco","RR3","RR1","CMRR")) 
aF(11, 8, "Ad=(Av*RR3)/sqrt(RR1^2*Av^2+RR3^2)", U("Ad","Av","RR3","RR1")) 
aF(11, 8, "Acc=(RR4*RR1-RR2*RR3)/(RR1*(RR2+RR4))", U("Acc","RR4","RR1","RR2","RR3")) 




addCat(12, "Solid State Devices", "") 

addCatVar(12, utf8(945), "CB current gain", "unitless")
addCatVar(12, "aLGJ", "Linearly graded junction parameter", "1/m4")
addCatVar(12, "A", "Area", "m2")
addCatVar(12, "A1", "EB junction area", "m2")
addCatVar(12, "A2", "CB junction area", "m2")
addCatVar(12, utf8(945).."f", "Forward "..utf8(945), "unitless")
addCatVar(12, "Aj", "Junction area", "m2")
addCatVar(12, utf8(945).."r", "Reverse "..utf8(945), "unitless")
addCatVar(12, utf8(946), "CE current gain", "unitless")
addCatVar(12, "b", "Channel width", "m")
addCatVar(12, utf8(946).."f", "Forward "..utf8(946), "unitless")
addCatVar(12, utf8(946).."r", "Reverse "..utf8(946), "unitless")
addCatVar(12, "Cj", "Junction capacitance", "F")
addCatVar(12, "CL", "Load capacitance", "F")
addCatVar(12, "Cox", "Oxide capacitance per unit area", "F/m2")
addCatVar(12, "D", "Diffusion coefficient", "m2/s")
addCatVar(12, "DB", "Base diffusion coefficient", "m2/s")
addCatVar(12, "DC", "Collector diffusion coefficient", "m2/s")
addCatVar(12, "DE", "Emitter diffusion coefficient", "m2/s")
addCatVar(12, "Dn", "n diffusion coefficient", "m2/s")
addCatVar(12, "Dp", "p diffusion coefficient", "m2/s")
addCatVar(12, utf8(949).."ox", "Oxide permittivity", "unitless")
addCatVar(12, utf8(949).."s", "Silicon Permittivity", "unitless")
addCatVar(12, "Ec", "Conduction band", "J")
addCatVar(12, "EF", "Fermi level", "J")
addCatVar(12, "Ei", "Intrinsic Fermi level", "J")
addCatVar(12, "Ev", "Valence band", "J")
addCatVar(12, "ffmax", "Maximum frequency", "Hz")
addCatVar(12, utf8(947), "Body coefficient", "V5")
addCatVar(12, "gd", "Drain conductance", "S")
addCatVar(12, "gm", "Transconductance", "S")
addCatVar(12, "gmL", "Transconductance, load device", "S")
addCatVar(12, "Go", "Conductance", "S")
addCatVar(12, "I", "Junction current", "A")
addCatVar(12, "I0", "Saturation current", "A")
addCatVar(12, "IB", "Base current", "A")
addCatVar(12, "IC", "Collector current", "A")
addCatVar(12, "ICB0", "CB leakage, E open", "A")
addCatVar(12, "ICE0", "CE leakage, B open", "A")
addCatVar(12, "ICsat", "Collector I at saturation edge", "A")
addCatVar(12, "ID", "Drain current", "A")
addCatVar(12, "IDmod", "Channel modulation drain current", "A")
addCatVar(12, "ID0", "Drain current at zero bias", "A")
addCatVar(12, "IDsat", "Drain saturation current", "A")
addCatVar(12, "IE", "Emitter current", "A")
addCatVar(12, "IIf", "Forward current", "A")
addCatVar(12, "Ir", "Reverse current", "A")
addCatVar(12, "Ir0", "E-M reverse current component", "A")
addCatVar(12, "IRG", "G-R current", "A")
addCatVar(12, "IRG0", "Zero bias G-R current", "A")
addCatVar(12, "Is", "Saturation current", "A")
addCatVar(12, utf8(955), "Modulation parameter", "1/V")
addCatVar(12, "Is", "Saturation current", "A")
addCatVar(12, "kD", "MOS constant, driver", "A/V2")
addCatVar(12, "kL", "MOS constant, load", "A/V2")
addCatVar(12, "kn", "MOS constant", "A/V2")
addCatVar(12, "kn1", "MOS process constant", "A/V2")
addCatVar(12, "kN", "MOS constant, n channel", "A/V2")
addCatVar(12, "kP", "MOS constant, p channel", "A/V2")
addCatVar(12, "KR", "Ratio", "unitless")
addCatVar(12, "L", "Transistor length", "m")
addCatVar(12, "LC", "Diffusion length, collector", "m")
addCatVar(12, "LD", "Drive transistor length", "m")
addCatVar(12, "LE", "Diffusion length, emitter", "m")
addCatVar(12, "LL", "Load transistor length", "m")
addCatVar(12, "LLn", "Diffusion length, n", "m")
addCatVar(12, "lNN", "n-channel length", "m")
addCatVar(12, "Lp", "Diffusion length, p", "m")
addCatVar(12, "lP", "p-channel length", "m")
addCatVar(12, utf8(956).."n", "n (electron) mobility", "m2/(V*s)")
addCatVar(12, utf8(956).."p", "p (positive charge) mobility", "m2/(V*s)")
addCatVar(12, "mn", "n effective mass", "unitless")
addCatVar(12, "mp", "p effective mass", "unitless")
addCatVar(12, "N", "Doping concentration", "1/m3")
addCatVar(12, "Na", "Acceptor density", "1/m3")
addCatVar(12, "nnC", "n density, collector", "1/m3")
addCatVar(12, "Nd", "Donor density", "1/m3")
addCatVar(12, "nE", "n density, emitter", "1/m3")
addCatVar(12, "ni", "Intrinsic density", "1/m3")
addCatVar(12, "N0", "Surface concentration", "1/m3")
addCatVar(12, "npo", "n density in p material", "1/m3")
addCatVar(12, "p", "p density", "1/m3")
addCatVar(12, "pB", "p density, base", "1/m3")
addCatVar(12, utf8(966).."F", "Fermi potential", "V")
addCatVar(12, utf8(966).."GC", "Work function potential", "V")
addCatVar(12, "pno", "p density in n material", "1/m3")
addCatVar(12, "Qtot", "Total surface impurities", "unitless")
addCatVar(12, "Qb", "Bulk charge at bias", "C/m2")
addCatVar(12, "Qb0", "Bulk charge at 0 bias", "C/m2")
addCatVar(12, "Qox", "Oxide charge density", "C/m2")
addCatVar(12, "Qsat", "Base Q, transition edge", "C")
addCatVar(12, utf8(961).."n", "n resistivity", utf8(937).."*m")
addCatVar(12, utf8(961).."p", "p resistivity", utf8(937).."*m")
addCatVar(12, "Rl", "Load resistance", utf8(937))
addCatVar(12, utf8(964).."B", "lifetime in base", "s")
addCatVar(12, utf8(964).."D", "Time constant", "s")
addCatVar(12, utf8(964).."L", "Time constant", "s")
addCatVar(12, utf8(964).."o", "Lifetime", "s")
addCatVar(12, utf8(964).."p", "Minority carrier lifetime", "s")
addCatVar(12, utf8(964).."t", "Base transit time", "s")
addCatVar(12, "t", "Time", "s")
addCatVar(12, "TT", "Temperature", "K")
addCatVar(12, "tch", "Charging time", "s")
addCatVar(12, "tdis", "Discharge time", "s")
addCatVar(12, "tox", "Gate oxide thickness", "m")
addCatVar(12, "tr", "Collector current rise time", "s")
addCatVar(12, "ts", "Charge storage time", "s")
addCatVar(12, "tsd1", "Storage delay, turn off", "s")
addCatVar(12, "tsd2", "Storage delay, turn off", "s")
addCatVar(12, "Ttr", "Transit time", "s")
addCatVar(12, "V1", "Input voltage", "V")
addCatVar(12, "Va", "Applied voltage", "V")
addCatVar(12, "Vbi", "Built-in voltage", "V")
addCatVar(12, "VBE", "BE bias voltage", "V")
addCatVar(12, "VCB", "CB bias voltage", "V")
addCatVar(12, "VCC", "Collector supply voltage", "V")
addCatVar(12, "VCEs", "CE saturation voltage", "V")
addCatVar(12, "VDD", "Drain supply voltage", "V")
addCatVar(12, "VDS", "Drain voltage", "V")
addCatVar(12, "VDsat", "Drain saturation voltage", "V")
addCatVar(12, "VEB", "EB bias voltage", "V")
addCatVar(12, "VG", "Gate voltage", "V")
addCatVar(12, "VGS", "Gate to source voltage", "V")
addCatVar(12, "VIH", "Input high", "V")
addCatVar(12, "Vin", "Input voltage", "V")
addCatVar(12, "VIL", "Input low voltage", "V")
addCatVar(12, "VL", "Load voltage", "V")
addCatVar(12, "VM", "Midpoint voltage", "V")
addCatVar(12, "VOH", "Output high", "V")
addCatVar(12, "VOL", "Output low", "V")
addCatVar(12, "Vo", "Output voltage", "V")
addCatVar(12, "Vp", "Pinchoff voltage", "V")
addCatVar(12, "VSB", "Substrate bias", "V")
addCatVar(12, "VT", "Threshold voltage", "V")
addCatVar(12, "VT0", "Threshold voltage at 0 bias", "V")
addCatVar(12, "VTD", "Depletion transistor threshold", "V")
addCatVar(12, "VTL", "Load transistor threshold", "V")
addCatVar(12, "VTL0", "Load transistor threshold", "V")
addCatVar(12, "VTN", "n channel threshold", "V")
addCatVar(12, "VTP", "p channel threshold", "V")
addCatVar(12, "W", "MOS transistor width", "m")
addCatVar(12, "WB", "Base width", "m")
addCatVar(12, "WD", "Drive transistor width", "m")
addCatVar(12, "WL", "Load transistor width", "m")
addCatVar(12, "WN", "n-channel width", "m")
addCatVar(12, "WP", "p-channel width", "m")
addCatVar(12, "x", "Depth from surface", "m")
addCatVar(12, "xd", "Depletion layer width", "m")
addCatVar(12, "xn", "Depletion width, n side", "m")
addCatVar(12, "xp", "Depletion width, p side", "m")
addCatVar(12, "Z", "JFET width", "m")


addSubCat(12, 1, "Semiconductor Basics", "") 
aF(12, 1, utf8(961).."n=1/(q*"..utf8(956).."n*Nd)", U(""..utf8(961).."n","q",""..utf8(956).."n","Nd")) 
aF(12, 1, utf8(961).."p=1/(q*"..utf8(956).."p*Na)", U(""..utf8(961).."p","q",""..utf8(956).."p","Na")) 
aF(12, 1, "Dn=((k*TT)/q)*"..utf8(956).."n", U("Dn","k","TT","q",""..utf8(956).."n")) 
aF(12, 1, "Dp=((k*TT)/q)*"..utf8(956).."p", U("Dp","k","TT","q",""..utf8(956).."p")) 
aF(12, 1, "Ei=EF+(k*TT*ln(Na/ni(TT)))", U("Ei","EF","k","TT","Na")) 
aF(12, 1, "EF=Ei+(k*TT*ln(Nd/ni(TT)))", U("EF","Ei","k","TT","Nd")) 
aF(12, 1, "Ei=(Ec+Ev)/2+3/4*(k*TT)*ln(mp/mn)", U("Ei","Ec","Ev","k","TT","mp","mn")) 
aF(12, 1, "N/N0=erfc(x/(2*sqrt(D*t)))", U("N","N0","x","D","t")) 
aF(12, 1, "N=Qtot/(A*sqrt("..utf8(960).."*D*t))*exp(-x^2/(4*D*t))", U("N","Qtot","A",""..utf8(960),"D","t","x")) 


addSubCat(12, 2, "PN Junctions", "") 
aF(12, 2, "Vbi=k*TT/q*ln(Nd*Na/ni(TT)^2)", U("Vbi","k","TT","q","Nd","Na")) 
aF(12, 2, "xn=sqrt(2*"..utf8(949).."s*"..utf8(949).."0*abs(Vbi-Va)*Na/(q*Nd*(Na+Nd)))", U("xn",""..utf8(949).."s",""..utf8(949).."0","Vbi","Va","Na","q","Nd")) 
aF(12, 2, "xp=(Nd/Na)*xn", U("xp","Nd","Na","xn")) 
aF(12, 2, "xd=xn+xp", U("xd","xn","xp")) 
aF(12, 2, "Cj="..utf8(949).."s*"..utf8(949).."0*Aj/xd", U("Cj",""..utf8(949).."s",""..utf8(949).."0","Aj","xd")) 
aF(12, 2, "Vbi=2*k*TT/q*ln(aLGJ*xd/(2*ni(TT)))", U("Vbi","k","TT","q","aLGJ","xd")) 
aF(12, 2, "xd=(12*"..utf8(949).."s*"..utf8(949).."0/(q*aLGJ)*abs(Vbi-Va))^(1/3)", U("xd",""..utf8(949).."s",""..utf8(949).."0","q","aLGJ","Vbi","Va")) 


addSubCat(12, 3, "PN Junction Currents", "") 
aF(12, 3, "I=q*Aj*(Dn/LLn*npo+Dp/Lp*pno)*(exp(q*Va/(k*TT))-1)", U("I","q","Aj","Dn","LLn","npo","Dp","Lp","pno","Va","k","TT")) 
aF(12, 3, "I=I0*(exp(q*Va/(k*TT))-1)", U("I","I0","q","Va","k","TT")) 
aF(12, 3, "I0=q*Aj*(Dn/LLn*npo+Dp/Lp*pno)", U("I0","q","Aj","Dn","LLn","npo","Dp","Lp","pno")) 
aF(12, 3, "IRG0=-q*Aj*ni(TT)*xd/(2*"..utf8(964).."o)", U("IRG0","q","Aj","TT","xd",""..utf8(964).."o")) 
aF(12, 3, "IRG=q*Aj*ni(TT)*xd/(2*"..utf8(964).."o)*(exp(q*Va/(2*k*TT))-1)", U("IRG","q","Aj","TT","xd",""..utf8(964).."o","Va","k")) 
aF(12, 3, "Go=q/(k*TT)*(I+I0)", U("Go","q","k","TT","I","I0")) 
aF(12, 3, "ts="..utf8(964).."p*ln(1+IIf/Ir)", U("ts",""..utf8(964).."p","IIf","Ir")) 
aF(12, 3, "1/(1+Ir/IIf)=erf(sqrt(ts/"..utf8(964).."p))", U("Ir","IIf","ts",""..utf8(964).."p")) 


addSubCat(12, 4, "Transistor Currents", "") 
aF(12, 4, utf8(945).."=IC/IE", U(""..utf8(945),"IC","IE")) 
aF(12, 4, utf8(946).."="..utf8(945).."/(1-"..utf8(945)..")", U(""..utf8(946),""..utf8(945).."")) 
aF(12, 4, "IE=IB+IC", U("IE","IB","IC")) 
aF(12, 4, "IC="..utf8(945).."*IE+ICB0", U("IC",""..utf8(945),"IE","ICB0")) 
aF(12, 4, "IC="..utf8(945).."/(1-"..utf8(945)..")*IB+ICB0/(1-"..utf8(945)..")", U("IC",""..utf8(945),"IB","ICB0")) 
aF(12, 4, "IC="..utf8(946).."*IB+ICE0", U("IC",""..utf8(946),"IB","ICE0")) 
aF(12, 4, "ICE0=ICB0*("..utf8(946).."+1)", U("ICE0","ICB0",""..utf8(946).."")) 


addSubCat(12, 5, "Ebers-Moll Equations", "") 
aF(12, 5, "IE=IIf-"..utf8(945).."r*Ir", U("IE","IIf",""..utf8(945).."r","Ir")) 
aF(12, 5, "IC="..utf8(945).."f*IIf-Ir", U("IC",""..utf8(945).."f","IIf","Ir")) 
aF(12, 5, "IB=(1-"..utf8(945).."f)*IIf+(1-"..utf8(945).."r)*Ir", U("IB",""..utf8(945).."f","IIf",""..utf8(945).."r","Ir")) 
aF(12, 5, utf8(946).."f="..utf8(945).."f/(1-"..utf8(945).."f)", U(""..utf8(946).."f",""..utf8(945).."f")) 
aF(12, 5, utf8(946).."r="..utf8(945).."r/(1-"..utf8(945).."r)", U(""..utf8(946).."r",""..utf8(945).."r")) 
aF(12, 5, utf8(945).."f*IIf=Is", U(""..utf8(945).."f","IIf","Is")) 
aF(12, 5, utf8(945).."r*Ir=Is", U(""..utf8(945).."r","Ir","Is")) 
aF(12, 5, "ICB0=(1-"..utf8(945).."r*"..utf8(945).."f)*Ir0", U("ICB0",""..utf8(945).."r",""..utf8(945).."f","Ir0")) 
aF(12, 5, "ICE0=ICB0*("..utf8(946).."f+1)", U("ICE0","ICB0",""..utf8(946).."f")) 
aF(12, 5, "ICE0=Ir0*(1-"..utf8(945).."f*"..utf8(945).."r)/(1-"..utf8(945).."f)", U("ICE0","Ir0",""..utf8(945).."f",""..utf8(945).."r")) 


addSubCat(12, 6, "Ideal Currents - pnp", "") 
aF(12, 6, "IE=q*A1*(DE*nE/LE+DB*pB/WB)*(exp((q*VEB)/(k*TT))-1)-q*A2*DB/WB*pB*(exp((q*VCB)/(k*TT))-1)", U("IE","q","A1","DE","nE","LE","DB","pB","WB","VEB","k","TT","A2","VCB")) 
aF(12, 6, "IC=q*A1*DB*pB/WB*(exp((q*VEB)/(k*TT))-1)-q*A2*(DC*nC/LC+DB*pB/WB)*(exp((q*VCB)/(k*TT))-1)", U("IC","q","A1","DB","pB","WB","VEB","k","TT","A2","DC","nC","LC","VCB")) 
aF(12, 6, "IB=q*A1*DE/LE*nE*(exp((q*VBE)/(k*TT))-1)+q*A2*DC/LC*nC*(exp((q*VCB)/(k*TT))-1)", U("IB","q","A1","DE","LE","nE","VBE","k","TT","A2","DC","LC","nC","VCB")) 
aF(12, 6, utf8(945).."=((DB*pB)/WB)/(DB*pB/WB+DE*nE/LE)", U(""..utf8(945),"DB","pB","WB","DE","nE","LE")) 


addSubCat(12, 7, "Switching Transients", "") 
aF(12, 7, "Qsat=ICsat*"..utf8(964).."t", U("Qsat","ICsat",""..utf8(964).."t")) 
aF(12, 7, "ICsat=VCC/Rl", U("ICsat","VCC","Rl")) 
aF(12, 7, "tr="..utf8(964).."B*ln(1/(1-(ICsat*"..utf8(964).."t)/(IB*"..utf8(964).."B)))", U("tr",""..utf8(964).."B","ICsat",""..utf8(964).."t","IB")) 
aF(12, 7, "tsd1="..utf8(964).."B*ln(IB*"..utf8(964).."B/(ICsat*"..utf8(964).."t))", U("tsd1",""..utf8(964).."B","IB","ICsat",""..utf8(964).."t")) 
aF(12, 7, "tsd2="..utf8(964).."B*ln(2*IB*"..utf8(964).."B/(ICsat*"..utf8(964).."t*(1+IB*"..utf8(964).."B/(ICsat*"..utf8(964).."t))))", U("tsd2",""..utf8(964).."B","IB","ICsat",""..utf8(964).."t")) 
aF(12, 7, "VCEs=k*TT/q*ln(1+IC/IB*(1-"..utf8(945).."r)/("..utf8(945).."r*(1-IC/IB*(1-"..utf8(945).."f)/"..utf8(945).."f)))", U("VCEs","k","TT","q","IC","IB",""..utf8(945).."r",""..utf8(945).."f")) 


addSubCat(12, 8, "MOS Transistor I", "") 
aF(12, 8, utf8(966).."F=k*TT/q*ln(ni(TT)/p)", U(""..utf8(966).."F","k","TT","q","p")) 
aF(12, 8, "xd=sqrt(2*"..utf8(949).."s*"..utf8(949).."0*(2*"..utf8(966).."F)/(q*Na))", U("xd",""..utf8(949).."s",""..utf8(949).."0",""..utf8(966).."F","q","Na")) 
aF(12, 8, "Qb0=-sqrt(2*q*Na*"..utf8(949).."s*"..utf8(949).."0*abs(2*"..utf8(966).."F))", U("Qb0","q","Na",""..utf8(949).."s",""..utf8(949).."0",""..utf8(966).."F")) 
aF(12, 8, "Qb=-sqrt(2*q*Na*"..utf8(949).."s*"..utf8(949).."0*abs(-2*"..utf8(966).."F+VSB))", U("Qb","q","Na",""..utf8(949).."s",""..utf8(949).."0",""..utf8(966).."F","VSB")) 
aF(12, 8, "Cox="..utf8(949).."ox*"..utf8(949).."0/tox", U("Cox",""..utf8(949).."ox",""..utf8(949).."0","tox")) 
aF(12, 8, utf8(131).."=1/Cox*sqrt(2*q*Na*"..utf8(949).."s*"..utf8(949).."0)", U("Cox","q","Na",""..utf8(949).."s",""..utf8(949).."0")) 
aF(12, 8, "VT0="..utf8(966).."GC-2*"..utf8(966).."F-Qb0/Cox-Qox/Cox", U("VT0",""..utf8(966).."GC",""..utf8(966).."F","Qb0","Cox","Qox")) 


addSubCat(12, 9, "MOS Transistor II", "") 
aF(12, 9, "kn1="..utf8(956).."n*Cox", U("kn1",""..utf8(956).."n","Cox")) 
aF(12, 9, "kn1="..utf8(956).."n*"..utf8(949).."ox*"..utf8(949).."0/tox", U("kn1",""..utf8(956).."n",""..utf8(949).."ox",""..utf8(949).."0","tox")) 
aF(12, 9, "kn=kn1*W/L", U("kn","kn1","W","L")) 
aF(12, 9, "IDmod=kn/2*(VGS-VT)^2*(1+"..utf8(137).."*VDS)", U("IDmod","kn","VGS","VT","VDS")) 
aF(12, 9, "ID=when(VGS-VT"..utf8(156).."VDS,kn/2*(2*(VGS-VT)*VDS-VDS^2),kn/2*(VGS-VT)^2)", U("ID","VGS","VT","VDS","kn")) 
aF(12, 9, "VT=VT0+"..utf8(131).."*(sqrt(abs(-2*"..utf8(966).."F+VSB))-sqrt(2*"..utf8(966).."F))", U("VT","VT0",""..utf8(966).."F","VSB")) 
aF(12, 9, "gm=kn*(VGS-VT)", U("gm","kn","VGS","VT")) 
aF(12, 9, "Ttr=4/3*L^2/("..utf8(956).."n*(VGS-VT))", U("Ttr","L",""..utf8(956).."n","VGS","VT")) 
aF(12, 9, "ffmax=gm/(2*"..utf8(960).."*Cox*W*L)", U("ffmax","gm",""..utf8(960),"Cox","W","L")) 
aF(12, 9, "gd=kn*(VGS-VT)", U("gd","kn","VGS","VT")) 


addSubCat(12, 10, "MOS Inverter (Resistive Load)", "") 
aF(12, 10, "kD="..utf8(956).."n*Cox*WD/LD", U("kD",""..utf8(956).."n","Cox","WD","LD")) 
aF(12, 10, "VOH=VDD", U("VOH","VDD")) 
aF(12, 10, "VOL^2-2*(1/(kD*Rl)+VDD-VT)*VOL+2*VDD/(kD*Rl)=0", U("VOL","kD","Rl","VDD","VT")) 
aF(12, 10, "kD/2*(2*(VIH-VT)*Vo-Vo^2)=(VDD-Vo)/Rl", U("kD","VIH","VT","Vo","VDD","Rl")) 
aF(12, 10, "kD/2*(VM-VT)^2=(VDD-VM)/Rl", U("kD","VM","VT","VDD","Rl")) 


addSubCat(12, 11, "MOS Inverter (Saturated Load)", "") 
aF(12, 11, "kL="..utf8(956).."n*Cox*WL/LL", U("kL",""..utf8(956).."n","Cox","WL","LL")) 
aF(12, 11, "kD="..utf8(956).."n*Cox*WD/LD", U("kD",""..utf8(956).."n","Cox","WD","LD")) 
aF(12, 11, "KR=kD/kL", U("KR","kD","kL")) 
aF(12, 11, "VOH=VDD-(VT0+"..utf8(131).."*(sqrt(VOH+2*"..utf8(966).."F)-sqrt(2*"..utf8(966).."F)))", U("VOH","VDD","VT0",""..utf8(966).."F")) 
aF(12, 11, "KR*(2*(Vin-VTD)*Vo-Vo^2)=(VDD-Vo-VTL)^2", U("KR","Vin","VTD","Vo","VDD","VTL")) 
aF(12, 11, "VTL=VT0+"..utf8(131).."*(sqrt(Vo+2*"..utf8(966).."F)-sqrt(2*"..utf8(966).."F))", U("VTL","VT0","Vo",""..utf8(966).."F")) 
aF(12, 11, "VIH=(2*(VDD-VTL))/(sqrt(3*KR)+1)+VT0", U("VIH","VDD","VTL","KR","VT0")) 
aF(12, 11, "Vo=(VDD-VTL+VT0+VT0*sqrt(KR))/(1+sqrt(KR))", U("Vo","VDD","VTL","VT0","KR")) 
aF(12, 11, "gmL=kL*(VDD-VTL)", U("gmL","kL","VDD","VTL")) 
aF(12, 11, utf8(964).."L=CL/gmL", U(""..utf8(964).."L","CL","gmL")) 
aF(12, 11, "tch="..utf8(964).."L*(V1/Vo-1)", U("tch",""..utf8(964).."L","V1","Vo")) 
aF(12, 11, utf8(964).."D=CL/(kD*(V1-VT0))", U(""..utf8(964).."D","CL","kD","V1","VT0")) 
aF(12, 11, "tdis="..utf8(964).."D*((2*VTD)/(V1-VTD)+ln(2*(V1-VTD)/Vo-1))", U("tdis",""..utf8(964).."D","VTD","V1","Vo")) 


addSubCat(12, 12, "MOS Inverter (Depletion Load)", "") 
aF(12, 12, "kL="..utf8(956).."n*Cox*WL/LL", U("kL",""..utf8(956).."n","Cox","WL","LL")) 
aF(12, 12, "kD="..utf8(956).."n*Cox*WD/LD", U("kD",""..utf8(956).."n","Cox","WD","LD")) 
aF(12, 12, "kD/2*(2*(VOH-VT0)*VOL-VOL^2)=kL/2*VTL^2", U("kD","VOH","VT0","VOL","kL","VTL")) 
aF(12, 12, "VTL=VTL0+"..utf8(131).."*(sqrt(Vo+2*"..utf8(966).."F)-sqrt(2*"..utf8(966).."F))", U("VTL","VTL0","Vo",""..utf8(966).."F")) 
aF(12, 12, "tch=CL*VL/I0", U("tch","CL","VL","I0")) 
aF(12, 12, "I0=kL*VTL^2", U("I0","kL","VTL")) 


addSubCat(12, 13, "CMOS Transistor Pair", "") 
aF(12, 13, "kP="..utf8(956).."p*Cox*WP/lP", U("kP",""..utf8(956).."p","Cox","WP","lP")) 
aF(12, 13, "kN="..utf8(956).."n*Cox*WN/lNN", U("kN",""..utf8(956).."n","Cox","WN","lNN")) 
aF(12, 13, "VIH=2*Vo+VTN+(kP/kN)*(VDD-abs(VTP))/(1+kP/kN)", U("VIH","Vo","VTN","kP","kN","VDD","VTP")) 
aF(12, 13, "VIL=(2*Vo-VDD-VTP+kN/kP*VTN)/(1+kN/kP)", U("VIL","Vo","VDD","VTP","kN","kP","VTN")) 
aF(12, 13, "kN/2*(Vin-VTN)^2=kP/2*(VDD-Vin-abs(VTP))^2", U("kN","Vin","VTN","kP","VDD","VTP")) 


addSubCat(12, 14, "Junction FET", "") 
aF(12, 14, "ID=2*q*Z*"..utf8(956).."n*Nd*b/L*(VDD-2/3*(Vbi-Vp)*(((VDD+Vbi-VG)/(Vbi-Vp))^1.5-((Vbi-VG)/(Vbi-Vp))^1.5))", U("ID","q","Z",""..utf8(956).."n","Nd","b","L","VDD","Vbi","Vp","VG")) 
aF(12, 14, "IDsat=2*q*Z*"..utf8(956).."n*Nd*b/L*(VDsat-2/3*(Vbi-Vp)*(((VDD+Vbi-VG)/(Vbi-Vp))^1.5-((Vbi-VG)/(Vbi-Vp))^1.5))", U("IDsat","q","Z",""..utf8(956).."n","Nd","b","L","VDsat","Vbi","Vp","VDD","VG")) 
aF(12, 14, "b=sqrt(2*"..utf8(949).."0*"..utf8(949).."s/(q*Nd)*(Vbi+VDsat-VG))", U("b",""..utf8(949).."0",""..utf8(949).."s","q","Nd","Vbi","VDsat","VG")) 
aF(12, 14, "VDsat=VG-Vp", U("VDsat","VG","Vp")) 
aF(12, 14, "IDsat=ID0*(1-VG/Vp)^2", U("IDsat","ID0","VG","Vp")) 




addCat(13, "Linear Amplifiers", "") 

addCatVar(13, utf8(945).."0", "Current gain, CE", "unitless")
addCatVar(13, "Ac", "Common mode gain", "unitless")
addCatVar(13, "Ad", "Differential mode gain", "unitless")
addCatVar(13, "Ai", "Current gain, CB", "unitless")
addCatVar(13, "Aov", "Overall voltage gain", "unitless")
addCatVar(13, "Av", "Voltage gain, CC/CD", "unitless")
addCatVar(13, utf8(946).."0", "Current gain, CB", "unitless")
addCatVar(13, "CMRR", "Common mode reject ratio", "unitless")
addCatVar(13, "gm", "Transconductance", "S")
addCatVar(13, utf8(956), "Amplification factor", "unitless")
addCatVar(13, "rb", "Base resistance", utf8(937))
addCatVar(13, "rrc", "Collector resistance", utf8(937))
addCatVar(13, "rd", "Drain resistance", utf8(937))
addCatVar(13, "re", "Emitter resistance", utf8(937))
addCatVar(13, "RBA", "External base resistance", utf8(937))
addCatVar(13, "RCA", "External collector resistance", utf8(937))
addCatVar(13, "RDA", "External drain resistance", utf8(937))
addCatVar(13, "REA", "External emitter resistance", utf8(937))
addCatVar(13, "RG", "External gate resistance", utf8(937))
addCatVar(13, "Ric", "Common mode input resistance", utf8(937))
addCatVar(13, "Rid", "Differential input resistance", utf8(937))
addCatVar(13, "Rin", "Input resistance", utf8(937))
addCatVar(13, "Rl", "Load resistance", utf8(937))
addCatVar(13, "Ro", "Output resistance", utf8(937))
addCatVar(13, "Rs", "Source resistance", utf8(937))


addSubCat(13, 1, "BJT (Common Base)", "") 
aF(13, 1, utf8(946).."0="..utf8(945).."0/(1-"..utf8(945).."0)", U(""..utf8(946).."0",""..utf8(945).."0")) 
aF(13, 1, "Rin=re+rb/"..utf8(946).."0", U("Rin","re","rb",""..utf8(946).."0")) 
aF(13, 1, "Ro=rrc", U("Ro","rrc")) 
aF(13, 1, "Ai="..utf8(945).."0", U("Ai",""..utf8(945).."0")) 
aF(13, 1, "Av="..utf8(945).."0*Rl/(re+rb/"..utf8(946).."0)", U("Av",""..utf8(945).."0","Rl","re","rb",""..utf8(946).."0")) 
aF(13, 1, "Aov=("..utf8(945).."0*rrc)*(Rin/(Rin+Rs))/(re+rb/"..utf8(946).."0)", U("Aov",""..utf8(945).."0","rrc","Rin","Rs","re","rb",""..utf8(946).."0")) 


addSubCat(13, 2, "BJT (Common Emitter)", "") 
aF(13, 2, utf8(946).."0="..utf8(945).."0/(1-"..utf8(945).."0)", U(""..utf8(946).."0",""..utf8(945).."0")) 
aF(13, 2, "Rin=rb+"..utf8(946).."0*re", U("Rin","rb",""..utf8(946).."0","re")) 
aF(13, 2, "Ro=rrc", U("Ro","rrc")) 
aF(13, 2, "Ai=-"..utf8(946).."0", U("Ai",""..utf8(946).."0")) 
aF(13, 2, "Av=-"..utf8(946).."0*Rl/("..utf8(946).."0*re+rb)", U("Av",""..utf8(946).."0","Rl","re","rb")) 
aF(13, 2, "Aov=-"..utf8(946).."0*Rl/(Rs+Rin)", U("Aov",""..utf8(946).."0","Rl","Rs","Rin")) 


addSubCat(13, 3, "BJT (Common Collector)", "") 
aF(13, 3, utf8(946).."0="..utf8(945).."0/(1-"..utf8(945).."0)", U(""..utf8(946).."0",""..utf8(945).."0")) 
aF(13, 3, "Rin=rb+"..utf8(946).."0*re+("..utf8(946).."0+1)*Rl", U("Rin","rb",""..utf8(946).."0","re","Rl")) 
aF(13, 3, "Ro=re+(Rs+rb)/"..utf8(946).."0", U("Ro","re","Rs","rb",""..utf8(946).."0")) 
aF(13, 3, "Ai=rrc/(rrc*(1-"..utf8(945).."0)+Rl+re)", U("Ai","rrc",""..utf8(945).."0","Rl","re")) 
aF(13, 3, "Av="..utf8(945).."0*Rl/(re+Rl)", U("Av",""..utf8(945).."0","Rl","re")) 
aF(13, 3, "Aov=("..utf8(946).."0+1)*Rl/(Rs+Rin+("..utf8(946).."0+1)*Rl)", U("Aov",""..utf8(946).."0","Rl","Rs","Rin")) 


addSubCat(13, 4, "FET (Common Gate)", "") 
aF(13, 4, utf8(956).."=gm*rd", U(""..utf8(956),"gm","rd")) 
aF(13, 4, "Rin=(Rl+rd)/("..utf8(956).."+1)", U("Rin","Rl","rd",""..utf8(956).."")) 
aF(13, 4, "Av=("..utf8(956).."+1)*Rl/(rd+Rl)", U("Av",""..utf8(956),"Rl","rd")) 
aF(13, 4, "Ro=rd+("..utf8(956).."+1)*RG", U("Ro","rd",""..utf8(956),"RG")) 


addSubCat(13, 5, "FET (Common Source)", "") 
aF(13, 5, utf8(956).."=gm*rd", U(""..utf8(956),"gm","rd")) 
aF(13, 5, "Rin=(Rl+rd)/("..utf8(956).."+1)", U("Rin","Rl","rd",""..utf8(956).."")) 
aF(13, 5, "Av=-gm*(rd*Rl/(rd+Rl))", U("Av","gm","rd","Rl")) 
aF(13, 5, "Ro=rd", U("Ro","rd")) 


addSubCat(13, 6, "FET (Common Drain)", "") 
aF(13, 6, utf8(956).."=gm*rd", U(""..utf8(956),"gm","rd")) 
aF(13, 6, "Rin=(Rl+rd)/("..utf8(956).."+1)", U("Rin","Rl","rd",""..utf8(956).."")) 
aF(13, 6, "Av="..utf8(956).."*Rl/(("..utf8(956).."+1)*Rl+rd)", U("Av",""..utf8(956),"Rl","rd")) 
aF(13, 6, "Ro=rd/("..utf8(956).."+1)", U("Ro","rd",""..utf8(956).."")) 


addSubCat(13, 7, "Darlington (CC-CC)", "") 
aF(13, 7, "Rin="..utf8(946).."0*(re+"..utf8(946).."0*(re+Rl))", U("Rin",""..utf8(946).."0","re","Rl")) 
aF(13, 7, "Ro=re+("..utf8(946).."0*(re+rb)+Rs)/"..utf8(946).."0^2", U("Ro","re",""..utf8(946).."0","rb","Rs")) 
aF(13, 7, "Ai="..utf8(946).."0^2*RBA/(RBA+"..utf8(946).."0*(Rl+re))", U("Ai",""..utf8(946).."0","RBA","Rl","re")) 


addSubCat(13, 8, "Darlington (CC-CE)", "") 
aF(13, 8, "Rin=rb+"..utf8(946).."0*re", U("Rin","rb",""..utf8(946).."0","re")) 
aF(13, 8, "Ro=rrc/"..utf8(946).."0", U("Ro","rrc",""..utf8(946).."0")) 
aF(13, 8, "Av=-Rl/(re+Rs/"..utf8(946).."0^2)", U("Av","Rl","re","Rs",""..utf8(946).."0")) 


addSubCat(13, 9, "Emitter-Coupled Amplifier", "") 
aF(13, 9, utf8(946).."0="..utf8(945).."0/(1-"..utf8(945).."0)", U(""..utf8(946).."0",""..utf8(945).."0")) 
aF(13, 9, "Av=Rl*("..utf8(946).."0/(2*"..utf8(946).."0*re+Rl))", U("Av","Rl",""..utf8(946).."0","re")) 
aF(13, 9, "Ai=-"..utf8(945).."0*"..utf8(946).."0", U("Ai",""..utf8(945).."0",""..utf8(946).."0")) 
aF(13, 9, "Rin="..utf8(946).."0*re+rb", U("Rin",""..utf8(946).."0","re","rb")) 
aF(13, 9, "Ro=rrc", U("Ro","rrc")) 


addSubCat(13, 10, "Differential Amplifier", "") 
aF(13, 10, "Ad=-1/2*gm*RCA", U("Ad","gm","RCA")) 
aF(13, 10, "Ac=-"..utf8(945).."0*RCA/(2*REA+re)", U("Ac",""..utf8(945).."0","RCA","REA","re")) 
aF(13, 10, "Rid=2*(rb+"..utf8(946).."0*re)", U("Rid","rb",""..utf8(946).."0","re")) 
aF(13, 10, "Ric="..utf8(946).."0*REA", U("Ric",""..utf8(946).."0","REA")) 


addSubCat(13, 11, "Source-Coupled JFET Pair", "") 
aF(13, 11, "Ad=-1/2*gm*(rd*RDA)/(rd+RDA)", U("Ad","gm","rd","RDA")) 
aF(13, 11, "Ac=-"..utf8(956).."*RDA/(("..utf8(956).."+1)*2*Rs+rd+RDA)", U("Ac",""..utf8(956),"RDA","Rs","rd")) 
aF(13, 11, utf8(956).."=gm*rd", U(""..utf8(956),"gm","rd")) 
aF(13, 11, "CMMR=gm*Rs", U("CMMR","gm","Rs")) 




addCat(14, "Class A, B and C Amplifiers", "") 

addCatVar(14, "gm", "Transconductance", "S")
addCatVar(14, "hFE", "CE current gain", "unitless")
addCatVar(14, "hOE", "CE output conductance", "S")
addCatVar(14, "I", "Current", "A")
addCatVar(14, "IB", "Base current", "A")
addCatVar(14, "IC", "Collector Current", "A")
addCatVar(14, "dIC", "Current swing from operating pt.", "A")
addCatVar(14, "ICBO", "Collector current EB open", "A")
addCatVar(14, "ICQ", "Current at operating point", "A")
addCatVar(14, "Idc", "DC current", "A")
addCatVar(14, "Imax", "Maximum current", "A")
addCatVar(14, "K", "Constant", "unitless")
addCatVar(14, "m", "Constant", "1/K")
addCatVar(14, utf8(962), "Efficiency", "unitless")
addCatVar(14, "n", "Turns ratio", "unitless")
addCatVar(14, "N1","# turns in primary", "unitless")
addCatVar(14, "N2","# turns in secondary", "unitless")
addCatVar(14, "Pd", "Power dissipated", "W")
addCatVar(14, "Pdc", "DC power input to amp", "W")
addCatVar(14, "Po", "Power output", "W")
addCatVar(14, "PP", "Compliance", "V")
addCatVar(14, "Q", "Quality factor", "unitless")
addCatVar(14, utf8(952).."JA", "Thermal resistance", "W/K")
addCatVar(14, "R", "Equivalent resistance", utf8(937))
addCatVar(14, "Rl", "Load resistance", utf8(937))
addCatVar(14, "RR0", "Internal circuit loss", utf8(937))
addCatVar(14, "RR2", "Load resistance", utf8(937))
addCatVar(14, "RB", "External base resistance", utf8(937))
addCatVar(14, "Rrc", "Coupled load resistance", utf8(937))
addCatVar(14, "Rxt", "External emitter resistance", utf8(937))
addCatVar(14, "S", "Instability factor", "unitless")
addCatVar(14, "TA", "Ambient temperature", "K")
addCatVar(14, "TJ", "Junction temperature", "K")
addCatVar(14, "dTj", "Change in temperature", "K")
addCatVar(14, "V0", "Voltage across tank circuit", "V")
addCatVar(14, "V1", "Voltage across tuned circuit", "V")
addCatVar(14, "VBE", "Base emitter voltage", "V")
addCatVar(14, "VCC", "Collector supply voltage", "V")
addCatVar(14, "dVCE", "Voltage swing from operating pt.", "V")
addCatVar(14, "VCEmx", "Maximum transistor rating", "V")
addCatVar(14, "VCEmn", "Minimum transistor rating", "V")
addCatVar(14, "Vm", "Maximum amplitude", "V")
addCatVar(14, "VPP", "Peak-peak volts, secondary", "V")
addCatVar(14, "XXC", "Tuned circuit parameter", utf8(937))
addCatVar(14, "XC1", utf8(960).." equivalent circuit parameter", utf8(937))
addCatVar(14, "XC2", utf8(960).." equivalent circuit parameter", utf8(937))
addCatVar(14, "XL", utf8(960).." series reactance", utf8(937))


addSubCat(14, 1, "Class A Amplifier", "") 
aF(14, 1, "R=n^2*Rl", U("R","n","Rl")) 
aF(14, 1, "dIC=dVCE/R", U("dIC","dVCE","R")) 
aF(14, 1, "Imax=ICQ+dIC", U("Imax","ICQ","dIC")) 
aF(14, 1, "Pdc=VCC*ICQ", U("Pdc","VCC","ICQ")) 
aF(14, 1, "PP=VCEmx-VCEmn", U("PP","VCEmx","VCEmn")) 
aF(14, 1, "VPP=n*PP", U("VPP","n","PP")) 
aF(14, 1, "Po=(dIC)^2*R/8", U("Po","dIC","R")) 
aF(14, 1, "x=Po/Pdc", U("Po","Pdc"))


addSubCat(14, 2, "Power Transistor", "") 
aF(14, 2, "TJ=TA+"..utf8(952).."JA*Pd", U("TJ","TA",""..utf8(952).."JA","Pd")) 
aF(14, 2, "IC=hFE*IB+(1+hFE)*ICBO", U("IC","hFE","IB","ICBO")) 
aF(14, 2, "IB=-(IC*Rxt-VBE)/(Rxt+RB)", U("IB","IC","Rxt","VBE","RB")) 
aF(14, 2, "IC=-hFE*VBE/(hFE*Rxt+RB)+hFE*(Rxt+RB)/(hFE*Rxt+RB)*ICBO", U("IC","hFE","VBE","Rxt","RB","ICBO")) 
aF(14, 2, "S=(1+RB/Rxt)*hFE/(hFE+RB/Rxt)", U("S","RB","Rxt","hFE")) 
aF(14, 2, "IC=-hFE*IB+S*ICBO*(1+m*dTj)", U("IC","hFE","IB","S","ICBO","m","Tj")) 


addSubCat(14, 3, "Push-Pull Principle", "") 
aF(14, 3, "R=VCC/Imax", U("R","VCC","Imax")) 
aF(14, 3, "Po=VCC^2/(2*R)", U("Po","VCC","R")) 
aF(14, 3, "Po=(N2/(2*N1))^2*VCC^2/(2*RR2)", U("Po","N2","N1","VCC","RR2")) 


addSubCat(14, 4, "Class B Amplifier", "") 
aF(14, 4, "Po=K^2*VCC^2/(2*R)", U("Po","K","VCC","R")) 
aF(14, 4, "Idc=2*K*Imax/"..utf8(960), U("Idc","K","Imax",""..utf8(960).."")) 
aF(14, 4, "Pdc=2*K*Imax*VCC/"..utf8(960), U("Pdc","K","Imax","VCC",""..utf8(960).."")) 
aF(14, 4, "Pdc=2*K*VCC^2/("..utf8(960).."*R)", U("Pdc","K","VCC",""..utf8(960),"R")) 
aF(14, 4, "x=Po/Pdc", U("Po","Pdc")) 
aF(14, 4, "x="..utf8(960).."*K/4", U(""..utf8(960),"K")) 
aF(14, 4, "Pd=2*VCC^2/("..utf8(960).."*R)*(K-K^2*"..utf8(960).."/4)", U("Pd","VCC",""..utf8(960),"R","K")) 
aF(14, 4, "V1=gm*Rl*Vm/(2*sqrt(2))*(1/(1+hOE*Rl/2))", U("V1","gm","Rl","Vm","hOE")) 
aF(14, 4, "IC=gm*Vm/"..utf8(960).."*(1/(1+hOE*Rl/2))", U("IC","gm","Vm",""..utf8(960),"hOE","Rl")) 


addSubCat(14, 5, "Class C Amplifier", "") 
aF(14, 5, "x=I^2*Rrc/(I^2*(Rrc+RR0))", U("I","Rrc","RR0")) 
aF(14, 5, "XXC=V0^2/(Q*Po)", U("XXC","V0","Q","Po")) 
aF(14, 5, "XL=XXC*Q^2/(Q^2+1)", U("XL","XXC","Q")) 
aF(14, 5, "XC1=-Rl/Q", U("XC1","Rl","Q")) 
aF(14, 5, "XL=1/Q*(Rl+sqrt(Rl*RR2))", U("XL","Q","Rl","RR2")) 
aF(14, 5, "XC2=-RR2/Q", U("XC2","RR2","Q")) 




addCat(15, "Transformers", "") 

addCatVar(15, "I1", "Primary current", "A")
addCatVar(15, "I2", "Secondary current", "A")
addCatVar(15, "N1","# primary turns", "unitless")
addCatVar(15, "N2","# secondary turns", "unitless")
addCatVar(15, "RR1", "Primary resistance", utf8(937))
addCatVar(15, "RR2", "Secondary resistance", utf8(937))
addCatVar(15, "Rin", "Equiv. primary resistance", utf8(937))
addCatVar(15, "Rl", "Resistive part of load", utf8(937))
addCatVar(15, "V1", "Primary voltage", "V")
addCatVar(15, "V2", "Secondary voltage", "V")
addCatVar(15, "XX1", "Primary reactance", utf8(937))
addCatVar(15, "XX2", "Secondary reactance", utf8(937))
addCatVar(15, "Xin", "Equivalent primary reactance", utf8(937))
addCatVar(15, "Xl", "Reactive part of load", utf8(937))
addCatVar(15, "Zin", "Primary impedance", utf8(937))
addCatVar(15, "ZL", "Secondary load", utf8(937))


addSubCat(15, 1, "Ideal Transformer", "") 
aF(15, 1, "V1/V2=N1/N2", U("V1","V2","N1","N2")) 
aF(15, 1, "I1*N1=I2*N2", U("I1","N1","I2","N2")) 
aF(15, 1, "V1*I1=V2*I2", U("V1","I1","V2","I2")) 
aF(15, 1, "Zin=(N1/N2)^2*ZL", U("Zin","N1","N2","ZL")) 


addSubCat(15, 2, "Linear Equivalent Circuit", "") 
aF(15, 2, "V1=N1/N2*V2", U("V1","N1","N2","V2")) 
aF(15, 2, "I1=I2*N2/N1", U("I1","I2","N2","N1")) 
aF(15, 2, "Rin=RR1+(N1/N2)^2*(RR2+Rl)", U("Rin","RR1","N1","N2","RR2","Rl")) 
aF(15, 2, "Xin=XX1+(N1/N2)^2*(XX2+Xl)", U("Xin","XX1","N1","N2","XX2","Xl")) 




addCat(16, "Motors and Generators", "") 

addCatVar(16, "A", "Area", "m2")
addCatVar(16, "ap","# parallel paths", "unitless")
addCatVar(16, "B", "Magnetic induction", "T")
addCatVar(16, "Ea", "Average emf induced in armature", "V")
addCatVar(16, "Ef", "Field voltage", "V")
addCatVar(16, "Ema", "Phase voltage", "V")
addCatVar(16, "Es", "Induced voltage", "V")
addCatVar(16, "Eta", "Average emf induced per turn", "V")
addCatVar(16, "F", "Magnetic pressure", "Pa")
addCatVar(16, "H", "Magnetic field intensity", "A/m")
addCatVar(16, "Ia", "Armature current", "A")
addCatVar(16, "IIf", "Field current", "A")
addCatVar(16, "IL", "Load current", "A")
addCatVar(16, "Ir", "Rotor current per phase", "A")
addCatVar(16, "Isb", "Backward stator current", "A")
addCatVar(16, "Isf", "Forward stator current", "A")
addCatVar(16, "K", "Machine constant", "unitless")
addCatVar(16, "Kf", "Field coefficient", "A/Wb")
addCatVar(16, "KM", "Induction motor constant", "unitless")
addCatVar(16, "L", "Length of each turn", "m")
addCatVar(16, utf8(952), "Phase delay", "r")
addCatVar(16, "N", "Total # armature coils", "unitless")
addCatVar(16, "Ns","# stator coils", "unitless")
addCatVar(16, utf8(961), "Resistivity", utf8(937).."/m")
addCatVar(16, utf8(966), "Flux", "Wb")
addCatVar(16, "p","# poles", "unitless")
addCatVar(16, "P", "Power", "W")
addCatVar(16, "Pa", "Mechanical power", "W")
addCatVar(16, "Pma", "Power in rotor per phase", "W")
addCatVar(16, "Pme", "Mechanical power", "W")
addCatVar(16, "Pr", "Rotor power per phase", "W")
addCatVar(16, "RR1", "Rotor resistance per phase", utf8(937))
addCatVar(16, "Ra", "Armature resistance", utf8(937))
addCatVar(16, "Rd", "Adjustable resistance", utf8(937))
addCatVar(16, "Re", "Ext. shunt resistance", utf8(937))
addCatVar(16, "Rel", "Magnetic reluctance", "A/Wb")
addCatVar(16, "Rf", "Field coil resistance", utf8(937))
addCatVar(16, "Rl", "Load resistance", utf8(937))
addCatVar(16, "Rr", "Equivalent rotor resistance", utf8(937))
addCatVar(16, "Rs", "Series field resistance", utf8(937))
addCatVar(16, "Rst", "Stator resistance", utf8(937))
addCatVar(16, "s", "Slip", "unitless")
addCatVar(16, "sf", "Slip for forward flux", "unitless")
addCatVar(16, "sm", "Maximum slip", "unitless")
addCatVar(16, "T", "Internal torque", "N*m")
addCatVar(16, "Tb", "Backward torque", "N*m")
addCatVar(16, "Tf", "Forward torque", "N*m")
addCatVar(16, "Tgmax", "Breakdown torque", "N*m")
addCatVar(16, "TL", "Load torque", "N*m")
addCatVar(16, "Tloss", "Torque loss", "N*m")
addCatVar(16, "Tmmax", "Maximum positive torque", "N*m")
addCatVar(16, "TTmax", "Pullout torque", "N*m")
addCatVar(16, "Ts", "Shaft torque", "N*m")
addCatVar(16, "Va", "Applied voltage", "V")
addCatVar(16, "Vf", "Field voltage", "V")
addCatVar(16, "Vfs", "Field voltage", "V")
addCatVar(16, "Vt", "Terminal voltage", "V")
addCatVar(16, utf8(969).."m", "Mechanical radian frequency", "rad/s")
addCatVar(16, utf8(969).."me", "Electrical radian frequency", "rad/s")
addCatVar(16, utf8(969).."r", "Electrical rotor speed", "rad/s")
addCatVar(16, utf8(969).."s", "Electrical stator speed", "rad/s")
addCatVar(16, "Wf", "Magnetic energy", "J")
addCatVar(16, "XL", "Inductive reactance", utf8(937))


addSubCat(16, 1, "Energy Conversion", "") 
aF(16, 1, "Wf=1/2*H*B*L*A", U("Wf","H","B","L","A")) 
aF(16, 1, "Wf=1/2*Rel*"..utf8(966).."^2", U("Wf","Rel",""..utf8(966).."")) 
aF(16, 1, "F=B^2/(2*"..utf8(956).."0)", U("F","B",""..utf8(956).."0")) 
aF(16, 1, "Es=Ns*"..utf8(969).."s*"..utf8(966).."/sqrt(2)", U("Es","Ns",""..utf8(969).."s",""..utf8(966).."")) 


addSubCat(16, 2, "DC Generator", "") 
aF(16, 2, utf8(969).."me=p/2*"..utf8(969).."m", U(""..utf8(969).."me","p",""..utf8(969).."m")) 
aF(16, 2, "Eta=p/"..utf8(960).."*"..utf8(969).."m*"..utf8(966), U("Eta","p",""..utf8(960),""..utf8(969).."m",""..utf8(966).."")) 
aF(16, 2, "Ea=N/ap*(p/"..utf8(960)..")*"..utf8(969).."m*"..utf8(966), U("Ea","N","ap","p",""..utf8(960),""..utf8(969).."m",""..utf8(966).."")) 
aF(16, 2, "Ea=K*"..utf8(969).."m*"..utf8(966), U("Ea","K",""..utf8(969).."m",""..utf8(966).."")) 
aF(16, 2, "K=N*p/(ap*"..utf8(960)..")", U("K","N","p","ap",""..utf8(960).."")) 
aF(16, 2, "T*"..utf8(969).."m=Ea*Ia+Ef*IIf", U("T",""..utf8(969).."m","Ea","Ia","Ef","IIf")) 
aF(16, 2, "T=K*"..utf8(966).."*Ia", U("T","K",""..utf8(966),"Ia")) 
aF(16, 2, "Ra="..utf8(961).."*N/ap^2*(L/A)", U("Ra",""..utf8(961),"N","ap","L","A")) 
aF(16, 2, "Vf=Rf*IIf", U("Vf","Rf","IIf")) 
aF(16, 2, "Vt=K*"..utf8(969).."m*"..utf8(966).."-Ra*Ia", U("Vt","K",""..utf8(969).."m",""..utf8(966),"Ra","Ia")) 
aF(16, 2, "Ts=K*"..utf8(966).."*Ia+Tlo"..utf8(946), U("Ts","K",""..utf8(966),"Ia","Tlo"..utf8(946).."")) 


addSubCat(16, 3, "Separately-Excited DC Generator", "") 
aF(16, 3, "IIf=Vfs/(Re+Rf)", U("IIf","Vfs","Re","Rf")) 
aF(16, 3, "Ea=K*"..utf8(969).."m*"..utf8(966), U("Ea","K",""..utf8(969).."m",""..utf8(966).."")) 
aF(16, 3, "Vt=IL*Rl", U("Vt","IL","Rl")) 
aF(16, 3, "Vt=Ea-Ra*IL", U("Vt","Ea","Ra","IL")) 
aF(16, 3, "IL=K*"..utf8(966).."*"..utf8(969).."m/(Ra+Rl)", U("IL","K",""..utf8(966),""..utf8(969).."m","Ra","Rl")) 


addSubCat(16, 4, "DC Shunt Generator", "") 
aF(16, 4, "Ea=K*"..utf8(969).."m*"..utf8(966), U("Ea","K",""..utf8(969).."m",""..utf8(966).."")) 
aF(16, 4, "Vt=(Re+Rf)*IIf", U("Vt","Re","Rf","IIf")) 
aF(16, 4, "Vt=IL*Rl", U("Vt","IL","Rl")) 
aF(16, 4, "Vt=Ea-Ra*Ia", U("Vt","Ea","Ra","Ia")) 
aF(16, 4, "Ia=IL+IIf", U("Ia","IL","IIf")) 
aF(16, 4, "Ea=Ra*Ia+(Re+Rf)*IIf", U("Ea","Ra","Ia","Re","Rf","IIf")) 


addSubCat(16, 5, "DC Series Generator", "") 
aF(16, 5, "Ia=IIf", U("Ia","IIf")) 
aF(16, 5, "Vt=Ea-(Ra+Rs)*IL", U("Vt","Ea","Ra","Rs","IL")) 


addSubCat(16, 6, "Separately-Excited DC Motor", "") 
aF(16, 6, "Vf=Rf*IIf", U("Vf","Rf","IIf")) 
aF(16, 6, "Vt=K*"..utf8(966).."*"..utf8(969).."m+Ra*Ia", U("Vt","K",""..utf8(966),""..utf8(969).."m","Ra","Ia")) 
aF(16, 6, "TL=K*"..utf8(966).."*Ia-Tlo"..utf8(946), U("TL","K",""..utf8(966),"Ia","Tlo"..utf8(946).."")) 
aF(16, 6, "Ea=K*"..utf8(969).."m*"..utf8(966), U("Ea","K",""..utf8(969).."m",""..utf8(966).."")) 
aF(16, 6, "T=K*Ia*"..utf8(966), U("T","K","Ia",""..utf8(966).."")) 
aF(16, 6, utf8(969).."m=Vt/(K*"..utf8(966)..")-Ra*T/(K*"..utf8(966)..")^2", U(""..utf8(969).."m","Vt","K",""..utf8(966),"Ra","T")) 
aF(16, 6, "T=Tlo"..utf8(946).."+TL", U("T","Tlo"..utf8(946),"TL")) 
aF(16, 6, "P=T*"..utf8(969).."m", U("P","T",""..utf8(969).."m")) 


addSubCat(16, 7, "DC Shunt Motor", "") 
aF(16, 7, "Vt=(Re+Rf)*IIf", U("Vt","Re","Rf","IIf")) 
aF(16, 7, "Vt=K*"..utf8(966).."*"..utf8(969).."m+Ra*Ia", U("Vt","K",""..utf8(966),""..utf8(969).."m","Ra","Ia")) 
aF(16, 7, "TL=K*"..utf8(966).."*Ia-Tlo"..utf8(946), U("TL","K",""..utf8(966),"Ia","Tlo"..utf8(946).."")) 
aF(16, 7, "Ea=K*"..utf8(969).."m*"..utf8(966), U("Ea","K",""..utf8(969).."m",""..utf8(966).."")) 
aF(16, 7, utf8(969).."m=Vt/(K*"..utf8(966)..")-(Ra+Rd)*T/(K*"..utf8(966)..")^2", U(""..utf8(969).."m","Vt","K",""..utf8(966),"Ra","Rd","T")) 
aF(16, 7, "T=Tlo"..utf8(946).."+TL", U("T","Tlo"..utf8(946),"TL")) 
aF(16, 7, "T=K*"..utf8(966).."*Ia", U("T","K",""..utf8(966),"Ia")) 


addSubCat(16, 8, "DC Series Motor", "") 
aF(16, 8, "Vt=K*"..utf8(966).."*"..utf8(969).."m+(Ra+Rs+Rd)*IL", U("Vt","K",""..utf8(966),""..utf8(969).."m","Ra","Rs","Rd","IL")) 
aF(16, 8, "TL=K*"..utf8(966).."*IL-Tlo"..utf8(946), U("TL","K",""..utf8(966),"IL","Tlo"..utf8(946).."")) 
aF(16, 8, "Ea=K*"..utf8(969).."m*"..utf8(966), U("Ea","K",""..utf8(969).."m",""..utf8(966).."")) 
aF(16, 8, "T=K*"..utf8(966).."*IL", U("T","K",""..utf8(966),"IL")) 
aF(16, 8, utf8(969).."m=Vt/(K*"..utf8(966)..")-(Ra+Rs+Rd)*T/(K*"..utf8(966)..")^2", U(""..utf8(969).."m","Vt","K",""..utf8(966),"Ra","Rs","Rd","T")) 
aF(16, 8, "T=Tlo"..utf8(946).."+TL", U("T","Tlo"..utf8(946),"TL")) 
aF(16, 8, "K*"..utf8(966).."=Kf*IL", U("K",""..utf8(966),"Kf","IL")) 
aF(16, 8, "T=Kf*IL^2", U("T","Kf","IL")) 


addSubCat(16, 9, "Permanent Magnet Motor", "") 
aF(16, 9, "Ea=K*"..utf8(966).."*"..utf8(969).."m", U("Ea","K",""..utf8(966),""..utf8(969).."m")) 
aF(16, 9, "T=K*"..utf8(966).."*Ia", U("T","K",""..utf8(966),"Ia")) 
aF(16, 9, "Vt=Ea+Ra*Ia", U("Vt","Ea","Ra","Ia")) 
aF(16, 9, "T=Tlo"..utf8(946).."+TL", U("T","Tlo"..utf8(946),"TL")) 
aF(16, 9, utf8(969).."m=Vt/(K*"..utf8(966)..")-Ra*T/(K*"..utf8(966)..")^2", U(""..utf8(969).."m","Vt","K",""..utf8(966),"Ra","T")) 


addSubCat(16, 10, "Induction Motor I", "") 
aF(16, 10, utf8(969).."r="..utf8(969).."s-p/2*"..utf8(969).."m", U(""..utf8(969).."r",""..utf8(969).."s","p",""..utf8(969).."m")) 
aF(16, 10, "s=1-p/2*("..utf8(969).."m/"..utf8(969).."s)", U("s","p",""..utf8(969).."m",""..utf8(969).."s")) 
aF(16, 10, "Pr/Pma=s", U("Pr","Pma","s")) 
aF(16, 10, utf8(969).."r=s*"..utf8(969).."s", U(""..utf8(969).."r","s",""..utf8(969).."s")) 
aF(16, 10, "Pma=3*Ir*Ema", U("Pma","Ir","Ema")) 
aF(16, 10, "Pme=3*(p/2)*("..utf8(969).."m/"..utf8(969).."s)*Pma", U("Pme","p",""..utf8(969).."m",""..utf8(969).."s","Pma")) 
aF(16, 10, "Pme=T*"..utf8(969).."m", U("Pme","T",""..utf8(969).."m")) 
aF(16, 10, "T=3*(p/2)*(Pma/"..utf8(969).."s)", U("T","p","Pma",""..utf8(969).."s")) 
aF(16, 10, "Pma=Rr*Ir^2+(1-s)/s*Rr*Ir^2", U("Pma","Rr","Ir","s")) 
aF(16, 10, "Pa=(1-s)/s*Rr*Ir^2", U("Pa","s","Rr","Ir")) 
aF(16, 10, "Rr=RR1/KM^2", U("Rr","RR1","KM")) 


addSubCat(16, 11, "Induction Motor II", "") 
aF(16, 11, "Pma=Rr/s*Ir^2", U("Pma","Rr","s","Ir")) 
aF(16, 11, "T=3/2*(p*Pma/"..utf8(969).."s)", U("T","p","Pma",""..utf8(969).."s")) 
aF(16, 11, "T=3/2*(p/"..utf8(969).."s)*(Rr/s)*(Va^2/((Rst+Rr/s)^2+XL^2))", U("T","p",""..utf8(969).."s","Rr","s","Va","Rst","XL")) 
aF(16, 11, "Tmmax=3/4*(p/"..utf8(969).."s)*(Va^2/(sqrt(Rst^2+XL^2)+Rst))", U("Tmmax","p",""..utf8(969).."s","Va","Rst","XL")) 
aF(16, 11, "sm=Rr/sqrt(Rs^2+XL^2)", U("sm","Rr","Rs","XL")) 
aF(16, 11, "Tgmax=-(3/4)*(p/"..utf8(969).."s)*(Va^2/(sqrt(Rs^2+XL^2)-Rst))", U("Tgmax","p",""..utf8(969).."s","Va","Rs","XL","Rst")) 
aF(16, 11, "Rr=RR1/KM^2", U("Rr","RR1","KM")) 


addSubCat(16, 12, "Single-Phase Induction Motor", "") 
aF(16, 12, "sf=1-p/2*("..utf8(969).."m/"..utf8(969).."s)", U("sf","p",""..utf8(969).."m",""..utf8(969).."s")) 
aF(16, 12, "Tf=p/2*(1/"..utf8(969).."s)*(Isf^2*Rr/(2*sf))", U("Tf","p",""..utf8(969).."s","Isf","Rr","sf")) 
aF(16, 12, "Tb=-(p/2)*(1/"..utf8(969).."s)*(Isb^2*Rr/(2*(2-sf)))", U("Tb","p",""..utf8(969).."s","Isb","Rr","sf")) 


addSubCat(16, 13, "Synchronous Machines", "") 
aF(16, 13, utf8(969).."m=2/p*"..utf8(969).."s", U(""..utf8(969).."m","p",""..utf8(969).."s")) 
aF(16, 13, "TTmax=3*(p/2)*(IIf*Va/"..utf8(969).."s)", U("TTmax","p","IIf","Va",""..utf8(969).."s")) 
aF(16, 13, "Pma=Va*Ia*cos("..utf8(952)..")", U("Pma","Va","Ia",""..utf8(952).."")) 
aF(16, 13, "T=Pme/"..utf8(969).."m", U("T","Pme",""..utf8(969).."m")) 
aF(16, 13, "T=3*(p/2)*(Pma/"..utf8(969).."s)", U("T","p","Pma",""..utf8(969).."s"))
