Categories	=	{}
Formulas	=	{}

function addCat(id,name,info)
	return table.insert(Categories, id, {id=id, name=name, info=info, sub={}})
end

function addSubCat(cid, id, name, info)
	return table.insert(Categories[cid].sub, id, {category=cid, id=id, name=name, info=info, formulas={}, units={}})
end

function aF(cid, sid, formula, units) --add Formula
	local fr	=	{category=cid, sub=sid, formula=formula, units=units}
	-- In times like this we are happy that inserting tables just inserts a reference
	table.insert(Formulas, fr)
	table.insert(Categories[cid].sub[sid].formulas, fr)
	
	-- This function might need to be merged with U(...)
	for unit,_ in pairs(units) do
		Categories[cid].sub[sid].units[unit]	= true
	end
end

function U(...)
	out	= {}
	for i, p in ipairs({...}) do
		out[p]	= true
	end
	return out
end

----------------------------------------------
-- Categories && Sub-Categories && Formulas --
----------------------------------------------

c_O  = string.uchar(963)
c_P  = string.uchar(961)
c_e  = string.uchar(949)
c_Pi = string.uchar(960)
c_u  = string.uchar(181)
c_t  = string.uchar(964)

addCat(1, "Resistive Circuits", "Performs routine calculations of resistive circuits")

addSubCat(1, 1, "Resistance Formulas", "")
aF(1, 1, "R=(" ..c_P .."*len)/A",           U("r",c_P,"len","a") )
aF(1, 1, "G=(" ..c_O .."*A)/len",           U("g",c_O,"len","a") )
aF(1, 1, "G=1/R",                             U("g","r")           )
aF(1, 1, c_O .."=1/" ..c_P,                 U(c_O,c_P)           )

addSubCat(1, 2, "Ohm\'s Law and Power", "")
aF(1, 2, "U=I*R",                 U("r","u","i") )
aF(1, 2, "P=I*U",                 U("p","u","i") )
aF(1, 2, "P=(U*U)/R",             U("p","u","r") )
aF(1, 2, "P=U*U*G",               U("p","u","g") )
aF(1, 2, "R=1/G",                 U("r","g")    )

addSubCat(1, 3, "Temperature Effect", "")
aF(1, 3, "RR2=RR1*(1+α*(T2-T1))", U("rr2","rr1","α") )

addSubCat(1, 4, "Maximum DC Power Transfer", "")
aF(1, 4, "Vl=(Vs*Rl)/(Rs+Rl)",    U("vl","vs","rl","rs") )
aF(1, 4, "Il=Vs/(Rs+Rl)",         U("il","vs","rs","rl") )
aF(1, 4, "P=Il*Vl",               U("p","il", "vl")      )
aF(1, 3, "Pmax=(Vs*Vs)/(4*Rs)",   U("pmax","vs","rs")    )
aF(1, 3, "Rlm=Rs",                U("rlm","rs")          )

addSubCat(1, 5, "V, I Source", "")
aF(1, 5, "Is=Vs/Rs",              U("is","vs","rs") )
aF(1, 5, "Vs=Is*Rs",              U("vs","is","rs") )

addCat(2, "Capacitors, E-Fields", "Compute electric field properties and capacitance of various types\nof structures")

addSubCat(2, 1, "Point Charge", "")
aF(2, 1, "Er=Q/(4*"..c_Pi.."*"..c_e.."0*"..c_e.."r*r*r)",  U("er","q",c_Pi,c_e.."0",c_e.."r") )
aF(2, 1, "V=Q/(4*"..c_Pi.."*"..c_e.."0*"..c_e.."r*r)",     U("v","q",c_Pi,c_e.."0",c_e.."r")  )

addSubCat(2, 2, "Long Charged Line", "")
aF(2, 2, "Er="..c_P.."l/(2*"..c_Pi.."*"..c_e.."0*"..c_e.."r)",     U("er",c_P.."l",c_Pi,c_e.."0",c_e.."r")  )

addSubCat(2, 3, "Charged Disk", "")
aF(2, 3, "Ez=("..c_P.."s/(2*"..c_e.."0*"..c_e.."r))*(1-abs(z)/sqrt(ra*ra+z*z))",     U("ez",c_P.."s",c_e.."0",c_e.."r","z","ra")  )
aF(2, 3, "Vz=("..c_P.."s/(2*"..c_e.."0*"..c_e.."r))*(sqrt(ra*ra+z*z)-abs(z))",       U("ez",c_P.."s",c_e.."0",c_e.."r","z","ra")  )

addSubCat(2, 4, "Parallel Plates", "")
aF(2, 4, "E=V/d",                 U("e","v","d")           )
aF(2, 4, "C=("..c_e.."0*"..c_e.."r*A)/d",         U("c",c_e.."0",c_e.."r","a","d") )
aF(2, 4, "Q=C*V",                 U("q","c","v")           )
aF(2, 4, "F=-0.5*(V*V*C)/d",      U("f","v","c","d")       )
aF(2, 4, "W=0.5*V*V*C",           U("w","v","c")           )

addSubCat(2, 5, "Parallel Wires", "")
aF(2, 5, "scl="..c_Pi.."*"..c_e.."0*"..c_e.."r/arccosh(d/(2*ra))", U("cl",c_Pi,c_e.."0",c_e.."r","d","ra")     )

addSubCat(2, 6, "Coaxial Cable", "")
aF(2, 6, "V=("..c_P.."l/(2*"..c_Pi.."*"..c_e.."0*"..c_e.."r))*ln(rb/ra)",  U("v",c_P.."l",c_Pi,c_e.."0",c_e.."r","ra")     )
aF(2, 6, "Er=V/(r*ln(rb/ra))",            U("er","v","r","rb","ra")          )
aF(2, 6, "cl=(2*"..c_Pi.."*"..c_e.."0*"..c_e.."r)/ln(rb/ra)",      U("cl",c_Pi,c_e.."0",c_e.."r","rb","ra")    )

addSubCat(2, 7, "Sphere", "")
aF(2, 7, "V=(Q/(4*"..c_Pi.."*"..c_e.."0*"..c_e.."r))*(1/ra-1/rb)", U("v","q",c_Pi,c_e.."0",c_e.."r","ra","rb") )
aF(2, 7, "Er=Q/(4*"..c_Pi.."*"..c_e.."0*"..c_e.."r*r*r)",          U("er","q","r",c_Pi,c_e.."0",c_e.."r")      )
aF(2, 7, "cl=(4*"..c_Pi.."*"..c_e.."0*"..c_e.."r*ra*rb)/(rb-ra)",  U("cl",c_Pi,c_e.."0",c_e.."r","rb","ra")    )

addCat(3, "Inductors and Magnetism", "Calculate electrical and magnetic properties of physical elements")

addSubCat(3, 1, "Long Line", "")
aF(3, 1, "B=("..c_u.."0*I)/(2*"..c_Pi.."*r)", U("b",c_u.."0","i","r",c_Pi) )

addSubCat(3, 2, "Long Strip", "")

aF(3, 2, "Bx=((-"..c_u.."0*Is)/(2*"..c_Pi.."))*(atan((x+d/2)/y)-atan((x-d/2)/y))", U("bx",c_u.."0","is",c_Pi,"x","d","y") )
aF(3, 2, "By=(("..c_u.."0*Is)/(4*"..c_Pi.."))*ln((y*y-(x+d/2))/(y*y-(x-d/2)))",    U("by",c_u.."0","is",c_Pi,"x","d","y") )

addSubCat(3, 3, "Parallel Wires", "")
aF(3, 3, "Fw=("..c_u.."0*I1*I2)/2*"..c_Pi.."*D",               U("fw",c_u.."0","I1","I2",c_Pi,"D")       )
aF(3, 3, "Bx=("..c_u.."0/(2*"..c_Pi.."))*(I1/x-I2/(D-x))",     U("bx",c_u.."0","I1","I2",c_Pi,"D","x" )  )
aF(3, 3, "L=("..c_u.."0/(4*"..c_Pi.."))+("..c_u.."0/("..c_Pi.."))*acos(D/2*a)", U("L",c_u.."0","a",c_Pi,"D" )             )

addSubCat(3, 4, "Loop", "")
addSubCat(3, 5, "Coaxial Cable", "")
addSubCat(3, 6, "Skin Effect", "")

addCat(4, "Electron Motion", "Investigate the trajectories of electrons under the influence \nof electric and magnetic fields")
addSubCat(4, 1, "Beam Deflection", "")
addSubCat(4, 2, "Thermionic Emission", "")
addSubCat(4, 3, "Photoemission", "")

addCat(5, "Meters and Bridge Circuits", "This category covers a variety of topics on meters, commonly used\nbridge and attenuator circuits")
addSubCat(5, 1, "A, V, W Meters", "")
addSubCat(5, 2, "Wheatstone Bridge", "")
addSubCat(5, 3, "Wien Bridge", "")
addSubCat(5, 4, "Maxwell Bridge", "")
addSubCat(5, 5, "Attenuators - Symmetric R", "")
addSubCat(5, 6, "Attenuators - Unsym R", "")

addCat(6, "RL and RC Circuits", "Compute the natural and transient properties of simple RL\nand RC circuits")
addSubCat(6, 1, "RL Natural Response", "")
aF(6, 1, c_t.."=L/R",                           U(c_t,"l","r")                )
aF(6, 1, "vL=I0*R*exp(-t/"..c_t..")",               U("vl","i0","r","t",c_t)      )
aF(6, 1, "iL=I0*exp(-t/"..c_t..")",                 U("il","i0","t",c_t)          )
aF(6, 1, "W=1/2*L*I0*I0*(1-exp(-2*t/"..c_t.."))",   U("w","l","i0","t",c_t)       )

addSubCat(6, 2, "RC Natural Response", "")
aF(6, 2, c_t.."=R*C",                           U(c_t,"r","c")                )
aF(6, 2, "vC=V0*exp(-t/"..c_t..")",                 U("vc","v0","t",c_t)          )
aF(6, 2, "iC=V0/R*exp(-t/"..c_t..")",               U("iC","v0","r","t",c_t)      )
aF(6, 2, "W=1/2*C*V0*V0*(1-exp(-2*t/"..c_t.."))",   U("w","c","v0","t",c_t)       )

addSubCat(6, 3, "RL Step response", "")
aF(6, 3, c_t.."=L/R",                           U(c_t,"l","r")                )
aF(6, 3, "vL=(Vs-I0*R)*exp(-t/"..c_t..")",          U("vl","i0","r","t",c_t)      )
aF(6, 3, "iL=Vs/R+(I0-Vs/R)*exp(-t/"..c_t..")",     U("il","vs","r","i0","t",c_t) )

addSubCat(6, 4, "RC Step Response", "")
aF(6, 4, c_t.."=R*C",                           U(c_t,"r","c")                )
aF(6, 4, "vC=Vs+(V0-Vs)*exp(-t/"..c_t..")",         U("vc","vs","v0","t",c_t)     )
aF(6, 4, "iC=(Vs-V0)/R*exp(-t/"..c_t..")",          U("ic","vs","v0","r","t",c_t) )

addSubCat(6, 5, "RL Series to Parallel", "")
aF(6, 5, "",                 U("","","")           )
-- 11 formulas here :o --

addSubCat(6, 6, "RC Series to Parallel", "")
aF(6, 6, "",                 U("","","")           )
-- 11 formulas here :o --


addCat(7, "RLC Circuits", "Compute the impedance, admittance, natural response and\ntransient behavior of RLC circuits")
addSubCat(7, 1, "Series Impedance", "")
addSubCat(7, 2, "Parallel Admittance", "")
addSubCat(7, 3, "RLC Natural Response", "")
addSubCat(7, 4, "Under-damped case", "")
addSubCat(7, 5, "Critical Damping", "")
addSubCat(7, 6, "Over-damped Case", "")

addCat(8, "AC Circuits", "Calculate properties of AC circuits")
addSubCat(8, 1, "RL Series Impedance", "")
addSubCat(8, 2, "RC Series Impedance", "")
addSubCat(8, 3, "Impedance - Admittance", "")
addSubCat(8, 4, "2 Z's in Series", "")
addSubCat(8, 5, "2 Z's in Parallel", "")

addCat(9, "Polyphase Circuits", "")
addSubCat(9, 1, "Balanced D Network", "")
addSubCat(9, 2, "Balance Wye Network", "")
addSubCat(9, 3, "Power Measurements", "")

addCat(10, "Electrical Resonance", "")
addSubCat(10, 1, "Parallel Resonance I", "")
addSubCat(10, 2, "Parallel Resonance II", "")
addSubCat(10, 3, "Lossy Inductor", "")
addSubCat(10, 4, "Series Resonance", "")

addCat(11, "Op. Amp Circuits", "")
addSubCat(11, 1, "Basic Inverter", "")
addSubCat(11, 2, "Non-Inverting Amplifier", "")
addSubCat(11, 3, "Current Amplifier", "")
addSubCat(11, 4, "Transconductance Amplifier", "")
addSubCat(11, 5, "Lvl. Detector Invert", "")
addSubCat(11, 6, "Lvl. Detector Non-Invert", "")
addSubCat(11, 7, "Differentiator", "")
addSubCat(11, 8, "Diff. Amplifier", "")

addCat(12, "Solid State Devices", "")
addSubCat(12, 1, "Semiconductor Basics", "")
addSubCat(12, 2, "PN Junctions", "")
addSubCat(12, 3, "PN Junction Currents", "")
addSubCat(12, 4, "Transistor Currents", "")
addSubCat(12, 5, "Ebers-Moll Equations", "")
addSubCat(12, 6, "Ideal Currents - pnp", "")
addSubCat(12, 7, "Switching Transients", "")
addSubCat(12, 8, "MOS Transistor I", "")
addSubCat(12, 9, "MOS Transistor II", "")
addSubCat(12, 10, "MOS Inverter R Load", "")
addSubCat(12, 11, "MOS Inverter Sat Load", "")
addSubCat(12, 12, "MOS Inverter Depl. Ld", "")
addSubCat(12, 13, "CMOS Transistor Pair", "")
addSubCat(12, 14, "Junction FET", "")

addCat(13, "Linear Amplifiers", "")
addSubCat(13, 1, "BJT (CB)", "")
addSubCat(13, 2, "BJT (CE)", "")
addSubCat(13, 3, "BJT (CC)", "")
addSubCat(13, 4, "FET (Common Gate)", "")
addSubCat(13, 5, "FET (Common Source)", "")
addSubCat(13, 6, "FET (Common Drain)", "")
addSubCat(13, 7, "Darlington (CC-CC)", "")
addSubCat(13, 8, "Darlington (CC-CE)", "")
addSubCat(13, 9, "EC Amplifier", "")
addSubCat(13, 10, "Differential Amplifier", "")
addSubCat(13, 11, "Source Coupled JFET", "")

addCat(14, "Class A, B, C Amps", "")
addSubCat(14, 1, "Class A Amplifier", "")
addSubCat(14, 2, "Power Transistor", "")
addSubCat(14, 3, "Push-Pull Principle", "")
addSubCat(14, 4, "Class B Amplifier", "")
addSubCat(14, 5, "Class C Amplifier", "")

addCat(15, "Transformers", "")
addSubCat(15, 1, "Ideal Transformer", "")
addSubCat(15, 2, "Linear Equiv. Circuit", "")

addCat(16, "Motors, Generators", "")
addSubCat(16, 1, "Energy Conversion", "")
addSubCat(16, 2, "DC Generator", "")
addSubCat(16, 3, "Sep. Excited DC Gen.", "")
addSubCat(16, 4, "DC Shunt Generator", "")
addSubCat(16, 5, "DC Series Generator", "")
addSubCat(16, 6, "Sep Excite DC Motor", "")
addSubCat(16, 7, "DC Shunt Motor", "")
addSubCat(16, 8, "DC Series Motor", "")
addSubCat(16, 9, "Perm Magnet Motor", "")
addSubCat(16, 10, "Induction Motor I", "")
addSubCat(16, 11, "Induction Motor II", "")
addSubCat(16, 12, "1 f Induction Motor", "")
addSubCat(16, 13, "Synchronous Machines", "")
