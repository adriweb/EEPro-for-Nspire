Categories	=	{}
Formulas	=	{}

function addCat(id,name,info)
	return table.insert(Categories, id,{id=id, name=name, info=info, sub={}})
end

function addSubCat(cid, id, name, info)
	return table.insert(Categories[cid].sub, id, {category=cid, id=id, name=name, info=info, formulas={}})
end

function aF(cid, sid, formula, units) --Add Formula
	local fr	=	{category=cid, sub=sid, formula=formula, units=units}
	-- In times like this we are happy that inserting tables just inserts a reference
	table.insert(Formulas, fr)
	table.insert(Categories[cid].sub[sid], fr)
end

function U(...)
	out	= {}
	for i, p in ipairs({...}) do
		out[p]	= true
	end
	return out
end

----------------------------------
-- Categories && Sub-Categories --
----------------------------------

AddCat(1, "Resistive Circuits", "")

AddSubCat(1, 1, "Resistance Formulas", "")
aF(1, 1, "R=(ρ*len)/A", U("r","ρ","len","a") )
aF(1, 1, "G=(σ*A)/len", U("g","σ","len","a") )
aF(1, 1, "G=1/R",       U("g","r")           )
aF(1, 1, "σ=1/ρ",       U("ρ","σ")           )

AddSubCat(1, 2, "Ohm\'s Law and Power", "")
aF(1, 2, "U=I*R",     U("r","u","i") )
aF(1, 2, "P=I*U",     U("p","u","i") )
aF(1, 2, "P=(U*U)/R", U("p","u","r") )
aF(1, 2, "P=U*U*G",   U("p","u","g") )
aF(1, 2, "R=1/G",     U("r","g",)    )

AddSubCat(1, 3, "Temperature Effect", "")
aF(1, 3, "RR2=RR1*(1+α*(T2-T1))", U("rr2","rr1","α") )

AddSubCat(1, 4, "Maximum DC Power Transfer", "")
aF(1, 4, "Vl=(Vs*Rl)/(Rs+Rl)",  U("vl","vs","rl","rs") )
aF(1, 4, "Il=Vs/(Rs+Rl)",       U("il","vs","rs","rl") )
aF(1, 4, "P=Il*Vl",             U("p","il", "vl")      )
aF(1, 3, "Pmax=(Vs*Vs)/(4*Rs)", U("pmax","vs","rs")    )
aF(1, 3, "Rlm=Rs",              U("rlm","rs")          )

AddSubCat(1, 5, "V, I Source", "")
aF(1, 5, "Is=Vs/Rs", U("is","vs","rs") )
aF(1, 5, "Vs=Is*Rs", U("vs","is","rs") )

AddCat(2, "Capacitors, E-Fields", "")
AddSubCat(2, 1, "Point Charge", "")
AddSubCat(2, 2, "Long Charged Line", "")
AddSubCat(2, 3, "Charged Disk", "")
AddSubCat(2, 4, "Parallel Plates", "")
AddSubCat(2, 5, "Parallel Wires", "")
AddSubCat(2, 6, "Coaxial Cable", "")
AddSubCat(2, 7, "Sphere", "")

AddCat(3, "Inductors and Magnetism", "")
AddSubCat(3, 1, "Long Line", "")
AddSubCat(3, 2, "Long Strip", "")
AddSubCat(3, 3, "Parallel Wires", "")
AddSubCat(3, 4, "Loop", "")
AddSubCat(3, 5, "Coaxial Cable", "")
AddSubCat(3, 6, "Skin Effect", "")

AddCat(4, "Electron Motion", "")
AddSubCat(4, 1, "Beam Deflection", "")
AddSubCat(4, 2, "Thermionic Emission", "")
AddSubCat(4, 3, "Photoemission", "")

AddCat(5, "Meters and Bridge Circuits", "")
AddSubCat(5, 1, "A, V, W Meters", "")
AddSubCat(5, 2, "Wheatstone Bridge", "")
AddSubCat(5, 3, "Wien Bridge", "")
AddSubCat(5, 4, "Maxwell Bridge", "")
AddSubCat(5, 5, "Attenuators - Symmetric R", "")
AddSubCat(5, 6, "Attenuators - Unsym R", "")

AddCat(6, "RL and RC Circuits", "")
AddSubCat(6, 1, "RL Natural Response", "")
AddSubCat(6, 2, "RC Natural Response", "")
AddSubCat(6, 3, "RL Step response", "")
AddSubCat(6, 4, "RC Step Response", "")
AddSubCat(6, 5, "RL Series to Parallel", "")
AddSubCat(6, 6, "RC Series to Parallel", "")

AddCat(7, "RLC Circuits", "")
AddSubCat(7, 1, "Series Impedance", "")
AddSubCat(7, 2, "Parallel Admittance", "")
AddSubCat(7, 3, "RLC Natural Response", "")
AddSubCat(7, 4, "Under-damped case", "")
AddSubCat(7, 5, "Critical Damping", "")
AddSubCat(7, 6, "Over-damped Case", "")

AddCat(8, "AC Circuits", "")
AddSubCat(8, 1, "RL Series Impedance", "")
AddSubCat(8, 2, "RC Series Impedance", "")
AddSubCat(8, 3, "Impedance - Admittance", "")
AddSubCat(8, 4, "2 Z's in Series", "")
AddSubCat(8, 5, "2 Z's in Parallel", "")

AddCat(9, "Polyphase Circuits", "")
AddSubCat(9, 1, "Balanced D Network", "")
AddSubCat(9, 2, "Balance Wye Network", "")
AddSubCat(9, 3, "Power Measurements", "")

AddCat(10, "Electrical Resonance", "")
AddSubCat(10, 1, "Parallel Resonance I", "")
AddSubCat(10, 2, "Parallel Resonance II", "")
AddSubCat(10, 3, "Lossy Inductor", "")
AddSubCat(10, 4, "Series Resonance", "")

AddCat(11, "Op. Amp Circuits", "")
AddSubCat(11, 1, "Basic Inverter", "")
AddSubCat(11, 2, "Non-Inverting Amplifier", "")
AddSubCat(11, 3, "Current Amplifier", "")
AddSubCat(11, 4, "Transconductance Amplifier", "")
AddSubCat(11, 5, "Lvl. Detector Invert", "")
AddSubCat(11, 6, "Lvl. Detector Non-Invert", "")
AddSubCat(11, 7, "Differentiator", "")
AddSubCat(11, 8, "Diff. Amplifier", "")

AddCat(12, "Solid State Devices", "")
AddSubCat(12, 1, "Semiconductor Basics", "")
AddSubCat(12, 2, "PN Junctions", "")
AddSubCat(12, 3, "PN Junction Currents", "")
AddSubCat(12, 4, "Transistor Currents", "")
AddSubCat(12, 5, "Ebers-Moll Equations", "")
AddSubCat(12, 6, "Ideal Currents - pnp", "")
AddSubCat(12, 7, "Switching Transients", "")
AddSubCat(12, 8, "MOS Transistor I", "")
AddSubCat(12, 9, "MOS Transistor II", "")
AddSubCat(12, 10, "MOS Inverter R Load", "")
AddSubCat(12, 11, "MOS Inverter Sat Load", "")
AddSubCat(12, 12, "MOS Inverter Depl. Ld", "")
AddSubCat(12, 13, "CMOS Transistor Pair", "")
AddSubCat(12, 14, "Junction FET", "")

AddCat(13, "Linear Amplifiers", "")
AddSubCat(13, 1, "BJT (CB)", "")
AddSubCat(13, 2, "BJT (CE)", "")
AddSubCat(13, 3, "BJT (CC)", "")
AddSubCat(13, 4, "FET (Common Gate)", "")
AddSubCat(13, 5, "FET (Common Source)", "")
AddSubCat(13, 6, "FET (Common Drain)", "")
AddSubCat(13, 7, "Darlington (CC-CC)", "")
AddSubCat(13, 8, "Darlington (CC-CE)", "")
AddSubCat(13, 9, "EC Amplifier", "")
AddSubCat(13, 10, "Differential Amplifier", "")
AddSubCat(13, 11, "Source Coupled JFET", "")

AddCat(14, "Class A, B, C Amps", "")
AddSubCat(14, 1, "Class A Amplifier", "")
AddSubCat(14, 2, "Power Transistor", "")
AddSubCat(14, 3, "Push-Pull Principle", "")
AddSubCat(14, 4, "Class B Amplifier", "")
AddSubCat(14, 5, "Class C Amplifier", "")

AddCat(15, "Transformers", "")
AddSubCat(15, 1, "Ideal Transformer", "")
AddSubCat(15, 2, "Linear Equiv. Circuit", "")

AddCat(16, "Motors, Generators", "")
AddSubCat(16, 1, "Energy Conversion", "")
AddSubCat(16, 2, "DC Generator", "")
AddSubCat(16, 3, "Sep. Excited DC Gen.", "")
AddSubCat(16, 4, "DC Shunt Generator", "")
AddSubCat(16, 5, "DC Series Generator", "")
AddSubCat(16, 6, "Sep Excite DC Motor", "")
AddSubCat(16, 7, "DC Shunt Motor", "")
AddSubCat(16, 8, "DC Series Motor", "")
AddSubCat(16, 9, "Perm Magnet Motor", "")
AddSubCat(16, 10, "Induction Motor I", "")
AddSubCat(16, 11, "Induction Motor II", "")
AddSubCat(16, 12, "1 f Induction Motor", "")
AddSubCat(16, 13, "Synchronous Machines", "")
