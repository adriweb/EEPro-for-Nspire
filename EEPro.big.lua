function utf8(n)
	return string.uchar(n)
end

SubNumbers={185, 178, 179, 8308, 8309, 8310, 8311, 8312, 8313}
function numberToSub(w,n)
	return w..utf8(SubNumbers[tonumber(n)])
end

Constants	= {}
Constants["g"      ]	= {info="Acceleration due to gravity"        , value="9.81"                  , unit="m*s^-2"             }
Constants["mu"     ]	= {info="Atomic mass unit"                   , value="1.66 * 10^-27"         , unit="kg"                 }
Constants["u"      ]	= Constants["mu"]
Constants["N"      ]	= {info="Avogadro's Number"                  , value="6.022 * 10^23"         , unit="mol^-1"             }
Constants["a0"     ]	= {info="Bohr radius"                        , value="0.529 * 10^-10"        , unit="m"                  }
Constants["k"      ]	= {info="Boltzmann constant"                 , value="1.38 * 10^-23"         , unit="J/K^-1"             }
Constants["em"     ]	= {info="Electron charge to mass ratio"      , value="-1.7588 * 10^11"       , unit="C/kg^-1"            }
Constants["re"     ]	= {info="Electron classical radius"          , value="2.818 * 10^-15"        , unit="m"                  }
Constants["mec2"   ]	= {info="Electron mass energy (J)"           , value="8.187 * 10^-14"        , unit="J"                  }
Constants["mec2DUP"]	= {info="Electron mass energy (MeV)"         , value="0.511"                 , unit="MeV"                }
Constants["me"     ]	= {info="Electron rest mass"                 , value="9.109 * 10^-31"        , unit="kg"                 }
Constants["F"      ]	= {info="Faraday constant"                   , value="9.649 * 10^4"          , unit="C/mol^-1"           }
Constants[utf8(945)]	= {info="Fine-structure constant"            , value="7.297 * 10^-3"         , unit=nil                  }
Constants["R"      ]	= {info="Gas constant"                       , value="8.314"                 , unit="J/((mol^-1)*(K^-1))"}
Constants["G"      ]	= {info="Gravitational constant"             , value="6.67 * 10^-11"         , unit="Nm^2/kg^-2"         }
Constants["mnc2"   ]	= {info="Neutron mass energy (J)"            , value="1.505 * 10^-10"        , unit="J"                  }
Constants["mnc2DUP"]	= {info="Neutron mass energy (MeV)"          , value="939.565"               , unit="MeV"                }
Constants["mn"     ]	= {info="Neutron rest mass"                  , value="1.675 * 10^-27"        , unit="kg"                 }
--Constants["mn/me"]	= {info="Neutron-electron mass ratio"        , value="1838.68"               , unit=nil                  }
--Constants["mn/mp"]	= {info="Neutron-proton mass ratio"          , value="1.0014"                , unit=nil                  }
Constants[utf8(956).."0"]	= {info="Permeability of a vacuum"       , value="4*pi * 10^-7"          , unit="N/A^-2"             }
Constants[utf8(949).."0"]	= {info="Permittivity of a vacuum"       , value="8.854 * 10^-12"        , unit="F/m^-1"             }
Constants["h"      ]	= {info="Planck constant"                    , value="6.626 * 10^-34"        , unit="J/s"                }
Constants["mpc2"   ]	= {info="Proton mass energy (J)"             , value="1.503 * 10^-10"        , unit="J"                  }
Constants["mpc2DUP"]	= {info="Proton mass energy (MeV)"           , value="938.272"               , unit="MeV"                }
Constants["mp"     ]	= {info="Proton rest mass"                   , value="1.6726 * 10^-27"       , unit="kg"                 }
Constants["pe"     ]	= {info="Proton-electron mass ratio"         , value="1836.15"               , unit=nil                  }
Constants["Rbc"    ]	= {info="Rydberg constant"                   , value="1.0974 * 10^7"         , unit="m^-1"               }
Constants["C"      ]	= {info="Speed of light in vacuum"           , value="2.9979 * 10^8"         , unit="m/s"                }
Constants["pi"     ]	= {info="PI"                                 , value="pi"                    , unit=nil                  }
Constants[utf8(960)]	= Constants["pi"]
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
c_u  = utf8(181)
c_t  = utf8(964)
c_Ohm = utf8(937)

addCat(1, "Resistive Circuits", "Performs routine calculations of resistive circuits")

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
aF(1, 1, "R=(" ..c_P .."*len)/A",           U("R",c_P,"len","A") )
aF(1, 1, "G=(" ..c_O .."*A)/len",           U("G",c_O,"len","A") )
aF(1, 1, "G=1/R",                             U("G","R")           )
aF(1, 1, c_O .."=1/" ..c_P,                 U(c_O,c_P)           )

addSubCat(1, 2, "Ohm\'s Law and Power", "")
aF(1, 2, "U=I*R",                 U("R","U","I") )
aF(1, 2, "P=I*U",                 U("P","U","I") )
aF(1, 2, "P=(U*U)/R",             U("P","U","R") )
aF(1, 2, "P=U*U*G",               U("P","U","G") )
aF(1, 2, "R=1/G",                 U("R","G")    )

addSubCat(1, 3, "Temperature Effect", "")
aF(1, 3, "RR2=RR1*(1+"..utf8(945).."*(T2-T1))", U("RR2","RR1","T1", "T2", utf8(945)) )

addSubCat(1, 4, "Maximum DC Power Transfer", "")
aF(1, 4, "Vl=(Vs*Rl)/(Rs+Rl)",    U("Vl","Vs","Rl","Rs") )
aF(1, 4, "Il=Vs/(Rs+Rl)",         U("Il","Rs","Rs","Rl") )
aF(1, 4, "P=Il*Vl",               U("P","Il", "Vl")      )
aF(1, 3, "Pmax=(Vs*Vs)/(4*Rs)",   U("Pmax","Vs","Rs")    )
aF(1, 3, "Rlm=Rs",                U("Rlm","Rs")          )

addSubCat(1, 5, "V, I Source", "")
aF(1, 5, "Is=Vs/Rs",              U("Is","Vs","Rs") )
aF(1, 5, "Vs=Is*Rs",              U("Vs","Is","Rs") )

addCat(2, "Capacitors, E-Fields", "Compute electric field properties and capacitance of various types\nof structures")

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
aF(2, 1, "Er=Q/(4*"..c_Pi.."*"..c_e.."0*"..c_e.."r*r*r)",  U("Er","Q",c_Pi,c_e.."0",c_e.."r") )
aF(2, 1, "V=Q/(4*"..c_Pi.."*"..c_e.."0*"..c_e.."r*r)",     U("V","Q",c_Pi,c_e.."0",c_e.."r")  )

addSubCat(2, 2, "Long Charged Line", "")
aF(2, 2, "Er="..c_P.."l/(2*"..c_Pi.."*"..c_e.."0*"..c_e.."r)",     U("Er",c_P.."l",c_Pi,c_e.."0",c_e.."r")  )

addSubCat(2, 3, "Charged Disk", "")
aF(2, 3, "Ez=("..c_P.."s/(2*"..c_e.."0*"..c_e.."r))*(1-abs(z)/sqrt(ra*ra+z*z))",     U("Ez",c_P.."s",c_e.."0",c_e.."r","z","ra")  )
aF(2, 3, "Vz=("..c_P.."s/(2*"..c_e.."0*"..c_e.."r))*(sqrt(ra*ra+z*z)-abs(z))",       U("Vz",c_P.."s",c_e.."0",c_e.."r","z","ra")  )

addSubCat(2, 4, "Parallel Plates", "")
aF(2, 4, "E=V/d",                 U("E","V","d")           )
aF(2, 4, "C=("..c_e.."0*"..c_e.."r*A)/d",         U("C",c_e.."0",c_e.."r","A","D") )
aF(2, 4, "Q=C*V",                 U("Q","C","V")           )
aF(2, 4, "F=-0.5*(V*V*C)/d",      U("F","V","C","D")       )
aF(2, 4, "W=0.5*V*V*C",           U("W","V","C")           )

addSubCat(2, 5, "Parallel Wires", "")
aF(2, 5, "scl="..c_Pi.."*"..c_e.."0*"..c_e.."r/arccosh(d/(2*ra))", U("cl",c_Pi,c_e.."0",c_e.."r","d","ra")     )

addSubCat(2, 6, "Coaxial Cable", "")
aF(2, 6, "V=("..c_P.."l/(2*"..c_Pi.."*"..c_e.."0*"..c_e.."r))*ln(rb/ra)",  U("V",c_P.."l",c_Pi,c_e.."0",c_e.."r","ra")     )
aF(2, 6, "Er=V/(r*ln(rb/ra))",            U("Er","V","r","rb","ra")          )
aF(2, 6, "cl=(2*"..c_Pi.."*"..c_e.."0*"..c_e.."r)/ln(rb/ra)",      U("cl",c_Pi,c_e.."0",c_e.."r","rb","ra")    )

addSubCat(2, 7, "Sphere", "")
aF(2, 7, "V=(Q/(4*"..c_Pi.."*"..c_e.."0*"..c_e.."r))*(1/ra-1/rb)", U("V","Q",c_Pi,c_e.."0",c_e.."r","ra","rb") )
aF(2, 7, "Er=Q/(4*"..c_Pi.."*"..c_e.."0*"..c_e.."r*r*r)",          U("Er","Q","r",c_Pi,c_e.."0",c_e.."r")      )
aF(2, 7, "cl=(4*"..c_Pi.."*"..c_e.."0*"..c_e.."r*ra*rb)/(rb-ra)",  U("cl",c_Pi,c_e.."0",c_e.."r","rb","ra")    )

addCat(3, "Inductors and Magnetism", "Calculate electrical and magnetic properties of physical elements")

addCatVar(3, utf8(952), "Angle", "radian")
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
addCatVar(3, "Reff", "Effective resistance", utf8(937))
addCatVar(3, "rr0", "Wire radius", "m")
addCatVar(3, "T12", "Torque", "N*m")
addCatVar(3, "x", "x axis distance", "m")
addCatVar(3, "y", "y axis distance", "m")
addCatVar(3, "z", "Distance to loop z axis", "m")
addCatVar(3, utf8(948), "Skin depth", "m")
addCatVar(3, utf8(961), "Resistivity", utf8(937).."*m")

addSubCat(3, 1, "Long Line", "")
aF(3, 1, "B=("..c_u.."0*I)/(2*"..c_Pi.."*r)", U("B",c_u.."0","I","r",c_Pi) )

addSubCat(3, 2, "Long Strip", "")

aF(3, 2, "Bx=((-"..c_u.."0*Is)/(2*"..c_Pi.."))*(atan((x+d/2)/y)-atan((x-d/2)/y))", U("Bx",c_u.."0","Is",c_Pi,"x","d","y") )
aF(3, 2, "By=(("..c_u.."0*Is)/(4*"..c_Pi.."))*ln((y*y-(x+d/2))/(y*y-(x-d/2)))",    U("By",c_u.."0","Is",c_Pi,"x","d","y") )

addSubCat(3, 3, "Parallel Wires", "")
aF(3, 3, "Fw=("..c_u.."0*I1*I2)/2*"..c_Pi.."*D",               U("Fw",c_u.."0","I1","I2",c_Pi,"D")       )
aF(3, 3, "Bx=("..c_u.."0/(2*"..c_Pi.."))*(I1/x-I2/(D-x))",     U("Bx",c_u.."0","I1","I2",c_Pi,"D","x" )  )
aF(3, 3, "L=("..c_u.."0/(4*"..c_Pi.."))+("..c_u.."0/("..c_Pi.."))*acos(D/2*a)", U("L",c_u.."0","a",c_Pi,"D" )             )

addSubCat(3, 4, "Loop", "")
addSubCat(3, 5, "Coaxial Cable", "")
addSubCat(3, 6, "Skin Effect", "")

addCat(4, "Electron Motion", "Investigate the trajectories of electrons under the influence \nof electric and magnetic fields")

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
addSubCat(4, 2, "Thermionic Emission", "")
addSubCat(4, 3, "Photoemission", "")

addCat(5, "Meters and Bridge Circuits", "This category covers a variety of topics on meters, commonly used\nbridge and attenuator circuits")

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
addCatVar(5, utf8(969), "Radian frequency", "r/s")

addSubCat(5, 1, "A, V, W Meters", "")
addSubCat(5, 2, "Wheatstone Bridge", "")
addSubCat(5, 3, "Wien Bridge", "")
addSubCat(5, 4, "Maxwell Bridge", "")
addSubCat(5, 5, "Attenuators - Symmetric R", "")
addSubCat(5, 6, "Attenuators - Unsym R", "")

addCat(6, "RL and RC Circuits", "Compute the natural and transient properties of simple RL\nand RC circuits")

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
addCatVar(6, utf8(969), "Radian frequency", "r/s")
addCatVar(6, "W", "Energy dissipated", "J")

addSubCat(6, 1, "RL Natural Response", "")
aF(6, 1, c_t.."=L/R",                           U(c_t,"L","R")                )
aF(6, 1, "vL=I0*R*exp(-t/"..c_t..")",               U("vL","I0","r","t",c_t)      )
aF(6, 1, "iL=I0*exp(-t/"..c_t..")",                 U("iL","I0","t",c_t)          )
aF(6, 1, "W=1/2*L*I0*I0*(1-exp(-2*t/"..c_t.."))",   U("W","l","I0","t",c_t)       )

addSubCat(6, 2, "RC Natural Response", "")
aF(6, 2, c_t.."=R*C",                           U(c_t,"R","C")                )
aF(6, 2, "vC=V0*exp(-t/"..c_t..")",                 U("vC","V0","t",c_t)          )
aF(6, 2, "iC=V0/R*exp(-t/"..c_t..")",               U("iC","V0","R","t",c_t)      )
aF(6, 2, "W=1/2*C*V0*V0*(1-exp(-2*t/"..c_t.."))",   U("W","C","V0","t",c_t)       )

addSubCat(6, 3, "RL Step response", "")
aF(6, 3, c_t.."=L/R",                           U(c_t,"L","R")                )
aF(6, 3, "vL=(Vs-I0*R)*exp(-t/"..c_t..")",          U("vL","I0","R","t",c_t)      )
aF(6, 3, "iL=Vs/R+(I0-Vs/R)*exp(-t/"..c_t..")",     U("iL","Vs","R","I0","t",c_t) )

addSubCat(6, 4, "RC Step Response", "")
aF(6, 4, c_t.."=R*C",                           U(c_t,"R","C")                )
aF(6, 4, "vC=Vs+(V0-Vs)*exp(-t/"..c_t..")",         U("vC","Vs","V0","t",c_t)     )
aF(6, 4, "iC=(Vs-V0)/R*exp(-t/"..c_t..")",          U("iC","Vs","V0","R","t",c_t) )

addSubCat(6, 5, "RL Series to Parallel", "")
aF(6, 5, "",                 U("","","")           )
-- 11 formulas here :o --

addSubCat(6, 6, "RC Series to Parallel", "")
aF(6, 6, "",                 U("","","")           )
-- 11 formulas here :o --


addCat(7, "RLC Circuits", "Compute the impedance, admittance, natural response and\ntransient behavior of RLC circuits")

addCatVar(7, utf8(945), "Neper"..utf8(8217).."s frequency", "rad/s")
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
addCatVar(7, utf8(952), "Phase angle", "rad")
addCatVar(7, "R", "Resistance", utf8(937))
addCatVar(7, "s1", "Characteristic frequency", "rad/s")
addCatVar(7, "s2", "Characteristic frequency", "rad/s")
addCatVar(7, "s1i", "Characteristic frequency (imaginary)", "rad/s")
addCatVar(7, "s1r", "Characteristic frequency (real)", "rad/s")
addCatVar(7, "s2i", "Characteristic frequency (imaginary)", "rad/s")
addCatVar(7, "s2i", "Characteristic frequency (real)", "rad/s")
addCatVar(7, "t", "Time", "s")
addCatVar(7, "v", "Capacitor voltage", "V")
addCatVar(7, "V0", "Initial capacitor voltage", "V")
addCatVar(7, utf8(969), "Radian Frequency", "rad/s")
addCatVar(7, utf8(969).."d", "Damped radian frequency", "rad/s")
addCatVar(7, utf8(969).."0", "Classical radian frequency", "rad/s")
addCatVar(7, "X", "Reactance", utf8(937))
addCatVar(7, "XXC", "Capacitive reactance", utf8(937))
addCatVar(7, "XL", "Inductive reactance", utf8(937))
addCatVar(7, "Ym", "Admittance "..utf8(8211).." magnitude", "S")
addCatVar(7, "Zm", "Impedance "..utf8(8211).." magnitude", "S")

addSubCat(7, 1, "Series Impedance", "")
addSubCat(7, 2, "Parallel Admittance", "")
addSubCat(7, 3, "RLC Natural Response", "")
addSubCat(7, 4, "Under-damped case", "")
addSubCat(7, 5, "Critical Damping", "")
addSubCat(7, 6, "Over-damped Case", "")

addCat(8, "AC Circuits", "Calculate properties of AC circuits")

addCatVar(8, "C", "Capacitance", "F")
addCatVar(8, "f", "Frequency", "Hz")
addCatVar(8, "I", "Instantaneous current", "A")
addCatVar(8, "Im", "Current amplitude", "A")
addCatVar(8, "L", "Inductance", "H")
addCatVar(8, utf8(952), "Impedance phase angle", "rad")
addCatVar(8, utf8(952).."1", "Phase angle 1", "rad")
addCatVar(8, utf8(952).."2", "Phase angle 2", "r")
addCatVar(8, "R", "Resistance", utf8(937))
addCatVar(8, "RR1", "Resistance 1", utf8(937))
addCatVar(8, "RR2", "Resistance 2", utf8(937))
addCatVar(8, "t", "Time", "s")
addCatVar(8, "V", "Total voltage", "V")
addCatVar(8, "VC", "Voltage across capacitor", "V")
addCatVar(8, "VL", "Voltage across inductor", "V")
addCatVar(8, "Vm", "Maximum voltage", "V")
addCatVar(8, "VR", "Voltage across resistor", "V")
addCatVar(8, utf8(969), "Radian frequency", "r/s")
addCatVar(8, "X", "Reactance", utf8(937))
addCatVar(8, "XX1", "Reactance 1", utf8(937))
addCatVar(8, "XX2", "Reactance 2", utf8(937))
addCatVar(8, "Y"..utf8(95), "Admittance", "S")
addCatVar(8, "Z1m", "Impedance 1 magnitude", utf8(937))
addCatVar(8, "Z2m", "Impedance 2 magnitude", utf8(937))
addCatVar(8, "Z"..utf8(95), "Complex impedance", utf8(937))
addCatVar(8, "Zm", "Impedance magnitude", utf8(937))

addSubCat(8, 1, "RL Series Impedance", "")
addSubCat(8, 2, "RC Series Impedance", "")
addSubCat(8, 3, "Impedance - Admittance", "")
addSubCat(8, 4, "2 Z's in Series", "")
addSubCat(8, 5, "2 Z's in Parallel", "")

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

addSubCat(9, 1, "Balanced D Network", "")
addSubCat(9, 2, "Balance Wye Network", "")
addSubCat(9, 3, "Power Measurements", "")

addCat(10, "Electrical Resonance", "")

addCatVar(10, utf8(945), "Damping coefficient", "r/s")
addCatVar(10, utf8(946), "Bandwidth", "r/s")
addCatVar(10, "C", "Capacitance", "F")
addCatVar(10, "Im", "Current", "A")
addCatVar(10, "L", "Inductance", "H")
addCatVar(10, utf8(952), "Phase angle", "rad")
addCatVar(10, "Q", "Quality factor", "unitless")
addCatVar(10, "R", "Resistance", utf8(937))
addCatVar(10, "Rg", "Generator resistance", utf8(937))
addCatVar(10, "Vm", "Maximum voltage", "V")
addCatVar(10, utf8(969), "Radian frequency", "r/s")
addCatVar(10, utf8(969).."0", "Resonant frequency", "r/s")
addCatVar(10, utf8(969).."1", "Lower cutoff frequency", "r/s")
addCatVar(10, utf8(969).."2", "Upper cutoff frequency", "r/s")
addCatVar(10, utf8(969).."d", "Damped resonant frequency", "r/s")
addCatVar(10, utf8(969).."m", "Frequency for maximum amplitude", "r/s")
addCatVar(10, "Yres", "Admittance at resonance", "S")
addCatVar(10, "Z", "Impedance", utf8(937))
addCatVar(10, "Zres", "Impedance at resonance", utf8(937))

addSubCat(10, 1, "Parallel Resonance I", "")
addSubCat(10, 2, "Parallel Resonance II", "")
addSubCat(10, 3, "Lossy Inductor", "")
addSubCat(10, 4, "Series Resonance", "")

addCat(11, "Op. Amp Circuits", "")

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
addCatVar(11, utf8(8710).."VH", "Hysteresis", "V")
addCatVar(11, "VL", "Detection threshold, low", "V")
addCatVar(11, "Vomax", "Maximum circuit output", "V")
addCatVar(11, "VR", "Reference voltage", "V")
addCatVar(11, "Vrate", "Maximum voltage rate", "V/s")
addCatVar(11, "VU", "Detection threshold, high", "V")
addCatVar(11, "Vz1", "Zener breakdown 1", "V")
addCatVar(11, "Vz2", "Zener breakdown 2", "V")

addSubCat(11, 1, "Basic Inverter", "")
addSubCat(11, 2, "Non-Inverting Amplifier", "")
addSubCat(11, 3, "Current Amplifier", "")
addSubCat(11, 4, "Transconductance Amplifier", "")
addSubCat(11, 5, "Lvl. Detector Invert", "")
addSubCat(11, 6, "Lvl. Detector Non-Invert", "")
addSubCat(11, 7, "Differentiator", "")
addSubCat(11, 8, "Diff. Amplifier", "")

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

addCatVar(14, "gm", "Transconductance", "S")
addCatVar(14, "hFE", "CE current gain", "unitless")
addCatVar(14, "hOE", "CE output conductance", "S")
addCatVar(14, "I", "Current", "A")
addCatVar(14, "IB", "Base current", "A")
addCatVar(14, "IC", "Collector Current", "A")
addCatVar(14, utf8(8710).."IC", "Current swing from operating pt.", "A")
addCatVar(14, "ICBO", "Collector current EB open", "A")
addCatVar(14, "ICQ", "Current at operating point", "A")
addCatVar(14, "Idc", "DC current", "A")
addCatVar(14, "Imax", "Maximum current", "A")
addCatVar(14, "K", "Constant", "unitless")
addCatVar(14, "m", "Constant", "1/K")
addCatVar(14, utf8(962), "Efficiency", "unitless")
addCatVar(14, "n", "Turns ratio", "unitless")
addCatVar(14, "N1", utf8(35).." turns in primary", "unitless")
addCatVar(14, "N2", utf8(35).." turns in secondary", "unitless")
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
addCatVar(14, utf8(8710).."Tj", "Change in temperature", "K")
addCatVar(14, "V0", "Voltage across tank circuit", "V")
addCatVar(14, "V1", "Voltage across tuned circuit", "V")
addCatVar(14, "VBE", "Base emitter voltage", "V")
addCatVar(14, "VCC", "Collector supply voltage", "V")
addCatVar(14, utf8(8710).."VCE", "Voltage swing from operating pt.", "V")
addCatVar(14, "VCEmx", "Maximum transistor rating", "V")
addCatVar(14, "VCEmn", "Minimum transistor rating", "V")
addCatVar(14, "Vm", "Maximum amplitude", "V")
addCatVar(14, "VPP", "Peak-peak volts, secondary", "V")
addCatVar(14, "XXC", "Tuned circuit parameter", utf8(937))
addCatVar(14, "XC1", utf8(960).." equivalent circuit parameter", utf8(937))
addCatVar(14, "XC2", utf8(960).." equivalent circuit parameter", utf8(937))
addCatVar(14, "XL", utf8(960).." series reactance", utf8(937))

addSubCat(14, 1, "Class A Amplifier", "")
addSubCat(14, 2, "Power Transistor", "")
addSubCat(14, 3, "Push-Pull Principle", "")
addSubCat(14, 4, "Class B Amplifier", "")
addSubCat(14, 5, "Class C Amplifier", "")

addCat(15, "Transformers", "")

addCatVar(15, "I1", "Primary current", "A")
addCatVar(15, "I2", "Secondary current", "A")
addCatVar(15, "N1", utf8(35).." primary turns", "unitless")
addCatVar(15, "N2", utf8(35).." secondary turns", "unitless")
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
addSubCat(15, 2, "Linear Equiv. Circuit", "")

addCat(16, "Motors, Generators", "")

addCatVar(16, "A", "Area", "m2")
addCatVar(16, "ap", utf8(35).." parallel paths", "unitless")
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
addCatVar(16, "N", "Total "..utf8(35).." armature coils", "unitless")
addCatVar(16, "Ns", utf8(35).." stator coils", "unitless")
addCatVar(16, utf8(961), "Resistivity", utf8(937).."/m")
addCatVar(16, utf8(966), "Flux", "Wb")
addCatVar(16, "p", utf8(35).." poles", "unitless")
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
addCatVar(16, utf8(969).."m", "Mechanical radian frequency", "r/s")
addCatVar(16, utf8(969).."me", "Electrical radian frequency", "r/s")
addCatVar(16, utf8(969).."r", "Electrical rotor speed", "r/s")
addCatVar(16, utf8(969).."s", "Electrical stator speed", "r/s")
addCatVar(16, "Wf", "Magnetic energy", "J")
addCatVar(16, "XL", "Inductive reactance", utf8(937))


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
------------------------------------------------------------------
--                  Overall Global Variables                    --
------------------------------------------------------------------
--
-- Uses BetterLuaAPI : https://github.com/adriweb/BetterLuaAPI-for-TI-Nspire
--

a_acute = string.uchar(225)
a_circ  = string.uchar(226)
a_tilde = string.uchar(227)
a_diaer = string.uchar(228)
a_ring  = string.uchar(229)
e_acute = string.uchar(233)
e_grave = string.uchar(232)
o_acute = string.uchar(243) 
o_circ  = string.uchar(244)
l_alpha = string.uchar(945)
l_beta = string.uchar(946)
l_omega = string.uchar(2126)
sup_plus = string.uchar(8314)
sup_minus = string.uchar(8315)
right_arrow = string.uchar(8594)


Color = {
	["black"] = {0, 0, 0},
	["red"] = {255, 0, 0},
	["green"] = {0, 255, 0},
	["blue "] = {0, 0, 255},
	["white"] = {255, 255, 255},
	["brown"] = {165,42,42},
	["cyan"] = {0,255,255},
	["darkblue"] = {0,0,139},
	["darkred"] = {139,0,0},
	["fuchsia"] = {255,0,255},
	["gold"] = {255,215,0},
	["gray"] = {127,127,127},
	["grey"] = {127,127,127},
	["lightblue"] = {173,216,230},
	["lightgreen"] = {144,238,144},
	["magenta"] = {255,0,255},
	["maroon"] = {128,0,0},
	["navyblue"] = {159,175,223},
	["orange"] = {255,165,0},
	["palegreen"] = {152,251,152},
	["pink"] = {255,192,203},
	["purple"] = {128,0,128},
	["royalblue"] = {65,105,225},
	["salmon"] = {250,128,114},
	["seagreen"] = {46,139,87},
	["silver"] = {192,192,192},
	["turquoise"] = {64,224,208},
	["violet"] = {238,130,238},
	["yellow"] = {255,255,0}
}
Color.mt = {__index = function () return {0,0,0} end}
setmetatable(Color,Color.mt)

function copyTable(t)
  local t2 = {}
  for k,v in pairs(t) do
    t2[k] = v
  end
  return t2
end

function deepcopy(t) -- This function recursively copies a table's contents, and ensures that metatables are preserved. That is, it will correctly clone a pure Lua object.
	if type(t) ~= 'table' then return t end
	local mt = getmetatable(t)
	local res = {}
	for k,v in pairs(t) do
		if type(v) == 'table' then
		v = deepcopy(v)
		end
	res[k] = v
	end
	setmetatable(res,mt)
	return res
end -- from http://snippets.luacode.org/snippets/Deep_copy_of_a_Lua_Table_2

function utf8(nbr)
	return string.uchar(nbr)
end

function test(arg)
	return arg and 1 or 0
end

function screenRefresh()
	return platform.window:invalidate()
end

function pww()
	return platform.window:width()
end

function pwh()
	return platform.window:height()
end

function drawPoint(gc, x, y)
	gc:fillRect(x, y, 1, 1)
end

function drawCircle(gc, x, y, diameter)
	gc:drawArc(x - diameter/2, y - diameter/2, diameter,diameter,0,360)
end

function drawCenteredString(gc, str)
	gc:drawString(str, .5*(pww() - gc:getStringWidth(str)), .5*pwh(), "middle")
end

function drawXCenteredString(gc, str, y)
	gc:drawString(str, .5*(pww() - gc:getStringWidth(str)), y, "top")
end

function setColor(gc,theColor)
	if type(theColor) == "string" then
		theColor = string.lower(theColor)
		if type(Color[theColor]) == "table" then gc:setColorRGB(unpack(Color[theColor])) end
	elseif type(theColor) == "table" then
		gc:setColorRGB(unpack(theColor))
	end
end

function verticalBar(gc,x)
	gc:fillRect(gc,x,0,1,pwh())
end

function horizontalBar(gc,y)
	gc:fillRect(gc,0,y,pww(),1)
end


function nativeBar(gc, screen, y)
	gc:setColorRGB(128,128,128)
	gc:fillRect(screen.x+5, screen.y+y, screen.w-10, 2)
end


function drawSquare(gc,x,y,l)
	gc:drawPolyLine(gc,{(x-l/2),(y-l/2), (x+l/2),(y-l/2), (x+l/2),(y+l/2), (x-l/2),(y+l/2), (x-l/2),(y-l/2)})
end

function drawRoundRect(gc,x,y,wd,ht,rd)  -- wd = width, ht = height, rd = radius of the rounded corner
	x = x-wd/2  -- let the center of the square be the origin (x coord)
	y = y-ht/2 -- same for y coord
	if rd > ht/2 then rd = ht/2 end -- avoid drawing cool but unexpected shapes. This will draw a circle (max rd)
	gc:drawLine(x + rd, y, x + wd - (rd), y);
	gc:drawArc(x + wd - (rd*2), y + ht - (rd*2), rd*2, rd*2, 270, 90);
	gc:drawLine(x + wd, y + rd, x + wd, y + ht - (rd));
	gc:drawArc(x + wd - (rd*2), y, rd*2, rd*2,0,90);
	gc:drawLine(x + wd - (rd), y + ht, x + rd, y + ht);
	gc:drawArc(x, y, rd*2, rd*2, 90, 90);
	gc:drawLine(x, y + ht - (rd), x, y + rd);
	gc:drawArc(x, y + ht - (rd*2), rd*2, rd*2, 180, 90);
end

function fillRoundRect(gc,x,y,wd,ht,radius)  -- wd = width and ht = height -- renders badly when transparency (alpha) is not at maximum >< will re-code later
	if radius > ht/2 then radius = ht/2 end -- avoid drawing cool but unexpected shapes. This will draw a circle (max radius)
    gc:fillPolygon({(x-wd/2),(y-ht/2+radius), (x+wd/2),(y-ht/2+radius), (x+wd/2),(y+ht/2-radius), (x-wd/2),(y+ht/2-radius), (x-wd/2),(y-ht/2+radius)})
    gc:fillPolygon({(x-wd/2-radius+1),(y-ht/2), (x+wd/2-radius+1),(y-ht/2), (x+wd/2-radius+1),(y+ht/2), (x-wd/2+radius),(y+ht/2), (x-wd/2+radius),(y-ht/2)})
    x = x-wd/2  -- let the center of the square be the origin (x coord)
	y = y-ht/2 -- same
	gc:fillArc(x + wd - (radius*2), y + ht - (radius*2), radius*2, radius*2, 1, -91);
    gc:fillArc(x + wd - (radius*2), y, radius*2, radius*2,-2,91);
    gc:fillArc(x, y, radius*2, radius*2, 85, 95);
    gc:fillArc(x, y + ht - (radius*2), radius*2, radius*2, 180, 95);
end

function drawLinearGradient(color1,color2)
	-- syntax would be : color1 and color2 as {r,g,b}.
 	-- don't really know how to do that. probably converting to hue/saturation/light mode and change the hue.
 	-- todo with unpack(color1) and unpack(color2)
end
stdout	= print

function pprint(...)
	stdout(...)
	local out	= ""
	for _,v in ipairs({...}) do 
		out	=	out .. (_==1 and "" or "    ") .. tostring(v)
	end
	var.store("print", out)
end


function Pr(n, d, s, ex)
	local nc	= tonumber(n)
	if nc and nc<math.abs(nc) then
		return s-ex-(type(n)== "number" and math.abs(n) or (.01*s*math.abs(nc)))
	else
		return (type(n)=="number" and n or (type(n)=="string" and .01*s*nc or d))
	end
end

-- Apply an extension on a class, and return our new frankenstein 
function addExtension(oldclass, extension)
	local newclass	= class(oldclass)
	for key, data in pairs(extension) do
		newclass[key]	= data
	end
	return newclass
end

clipRectData	= {}

function gc_clipRect(gc, what, x, y, w, h)
	if what == "set" and clipRectData.current then
		clipRectData.old	= clipRectData.current
		
	elseif what == "subset" and clipRectData.current then
		clipRectData.old	= clipRectData.current
		x	= clipRectData.old.x<x and x or clipRectData.old.x
		y	= clipRectData.old.y<y and y or clipRectData.old.y
		h	= clipRectData.old.y+clipRectData.old.h > y+h and h or clipRectData.old.y+clipRectData.old.h-y
		w	= clipRectData.old.x+clipRectData.old.w > x+w and w or clipRectData.old.x+clipRectData.old.w-x
		what = "set"
		
	elseif what == "restore" and clipRectData.old then
		--gc:clipRect("reset")
		what = "set"
		x	= clipRectData.old.x
		y	= clipRectData.old.y
		h	= clipRectData.old.h
		w	= clipRectData.old.w
	elseif what == "restore" then
		what = "reset"
	end
	
	gc:clipRect(what, x, y, w, h)
	if x and y and w and h then clipRectData.current = {x=x,y=y,w=w,h=h} end
end

------------------------------------------------------------------
--                        Screen  Class                         --
------------------------------------------------------------------

Screen	=	class()

Screens	=	{}

function push_screen(screen, ...)
	table.insert(Screens, screen)
	platform.window:invalidate()
	current_screen():pushed(...)
end

function only_screen(screen, ...)
	Screens	=	{screen}
	platform.window:invalidate()
	screen:pushed(...)	
end

function remove_screen(screen)
	platform.window:invalidate()
	return table.remove(Screens)
end

function current_screen()
	return Screens[#Screens]
end

function Screen:init(xx,yy,ww,hh)
	self.yy	=	yy
	self.xx	=	xx
	self.hh	=	hh
	self.ww	=	ww
	
	
	self:ext()
	self:size(0)
end

function Screen:ext()
end

function Screen:size()
	local screenH	=	platform.window:height()
	local screenW	=	platform.window:width()

	if screenH	== 0 then screenH=212 end
	if screenW	== 0 then screenW=318 end

	self.x	=	math.floor(Pr(self.xx, 0, screenW)+.5)
	self.y	=	math.floor(Pr(self.yy, 0, screenH)+.5)
	self.w	=	math.floor(Pr(self.ww, screenW, screenW, 0)+.5)
	self.h	=	math.floor(Pr(self.hh, screenH, screenH, 0)+.5)
end


function Screen:pushed()
	
end


function Screen:draw(gc)
	self:size()
	self:paint(gc)
end

function Screen:paint(gc) end

function Screen:invalidate()
	platform.window:invalidate(self.x ,self.y , self.w, self.h)
end

function Screen:arrowKey()	end
function Screen:enterKey()	end
function Screen:backspaceKey()	end
function Screen:escapeKey()	end
function Screen:tabKey()	end
function Screen:backtabKey()	end
function Screen:charIn(char)	end


function Screen:mouseDown()	end
function Screen:mouseUp()	end
function Screen:mouseMove()	end

function Screen:appended() end

function Screen:destroy()
	self	= nil
end

------------------------------------------------------------------
--                   WidgetManager Extension                    --
------------------------------------------------------------------

WidgetManager	= {}

function WidgetManager:ext()
	self.widgets	=	{}
	self.focus	=	0
end

function WidgetManager:appendWidget(widget, xx, yy) 
	widget.xx	=	xx
	widget.yy	=	yy
	widget.parent	=	self
	widget:size()
	
	table.insert(self.widgets, widget)
	widget.pid	=	#self.widgets
	
	widget:appended(self)
	return self
end

function WidgetManager:getWidget()
	return self.widgets[self.focus]
end

function WidgetManager:drawWidgets(gc) 
	for _, widget in pairs(self.widgets) do
		widget:size()
		widget:draw(gc)
		
		gc:setColorRGB(0,0,0)
	end
end

function WidgetManager:postPaint(gc) 
end

function WidgetManager:draw(gc)
	self:size()
	self:paint(gc)
	self:drawWidgets(gc)
	self:postPaint(gc)
end


function WidgetManager:loop(n) end

function WidgetManager:stealFocus(n)
	local oldfocus=self.focus
	if oldfocus~=0 then
		local veto	= self:getWidget():loseFocus(n)
		if veto == -1 then
			return -1, oldfocus
		end
		self:getWidget().hasFocus	=	false
		self.focus	= 0
	end
	return 0, oldfocus
end

function WidgetManager:focusChange() end

function WidgetManager:switchFocus(n, b)
	if n~=0 and #self.widgets>0 then
		local veto, focus	= self:stealFocus(n)
		if veto == -1 then
			return -1
		end
		
		local looped
		self.focus	=	focus + n
		if self.focus>#self.widgets then
			self.focus	=	1
			looped	= true
		elseif self.focus<1 then
			self.focus	=	#self.widgets
			looped	= true
		end	
		if looped and self.noloop and not b then
			self.focus	= focus
			self:loop(n)
		else
			self:getWidget().hasFocus	=	true	
			self:getWidget():getFocus(n)
		end
	end
	self:focusChange()
end


function WidgetManager:arrowKey(arrow)	
	if self.focus~=0 then
		self:getWidget():arrowKey(arrow)
	end
	self:invalidate()
end

function WidgetManager:enterKey()	
	if self.focus~=0 then
		self:getWidget():enterKey()
	end
	self:invalidate()
end

function WidgetManager:backspaceKey()
	if self.focus~=0 then
		self:getWidget():backspaceKey()
	end
	self:invalidate()
end

function WidgetManager:escapeKey()	
	if self.focus~=0 then
		self:getWidget():escapeKey()
	end
	self:invalidate()
end

function WidgetManager:tabKey()	
	self:switchFocus(1)
	self:invalidate()
end

function WidgetManager:backtabKey()	
	self:switchFocus(-1)
	self:invalidate()
end

function WidgetManager:charIn(char)
	if self.focus~=0 then
		self:getWidget():charIn(char)
	end
	self:invalidate()
end

function WidgetManager:getWidgetIn(x, y)
	for n, widget in pairs(self.widgets) do
		local wox	= widget.ox or 0
		local woy	= widget.oy or 0
		if x>=widget.x-wox and y>=widget.y-wox and x<widget.x+widget.w-wox and y<widget.y+widget.h-woy then
			return n, widget
		end
	end 
end

function WidgetManager:mouseDown(x, y) 
	local n, widget	=	self:getWidgetIn(x, y)
	if n then
		if self.focus~=0 and self.focus~=n then self:getWidget().hasFocus = false self:getWidget():loseFocus()  end
		self.focus	=	n
		
		widget.hasFocus	=	true
		widget:getFocus()

		widget:mouseDown(x, y)
		self:focusChange()
	else
		if self.focus~=0 then self:getWidget().hasFocus = false self:getWidget():loseFocus() end
		self.focus	=	0
	end
end
function WidgetManager:mouseUp(x, y)
	if self.focus~=0 then
		self:getWidget():mouseUp(x, y)
	end
	self:invalidate()
end
function WidgetManager:mouseMove(x, y)
	if self.focus~=0 then
		self:getWidget():mouseMove(x, y)
	end
end

--------------------------
-- Our new frankenstein --
--------------------------

WScreen	= addExtension(Screen, WidgetManager)



--Dialog screen

Dialog	=	class(WScreen)

function Dialog:init(title,xx,yy,ww,hh)
	self.yy	=	yy
	self.xx	=	xx
	self.hh	=	hh
	self.ww	=	ww
	self.title	=	title
	self:size()
	
	self.widgets	=	{}
	self.focus	=	0
end

function Dialog:paint(gc)
	self.xx	= (pww()-self.w)/2
	self.yy	= (pwh()-self.h)/2
	self.x, self.y	= self.xx, self.yy
	
	gc:setFont("sansserif","r",10)
	gc:setColorRGB(224,224,224)
	gc:fillRect(self.x, self.y, self.w, self.h)

	for i=1, 14,2 do
		gc:setColorRGB(32+i*3, 32+i*4, 32+i*3)
		gc:fillRect(self.x, self.y+i, self.w,2)
	end
	gc:setColorRGB(32+16*3, 32+16*4, 32+16*3)
	gc:fillRect(self.x, self.y+15, self.w, 10)
	
	gc:setColorRGB(128,128,128)
	gc:drawRect(self.x, self.y, self.w, self.h)
	gc:drawRect(self.x-1, self.y-1, self.w+2, self.h+2)
	
	gc:setColorRGB(96,100,96)
	gc:fillRect(self.x+self.w+1, self.y, 1, self.h+2)
	gc:fillRect(self.x, self.y+self.h+2, self.w+3, 1)
	
	gc:setColorRGB(104,108,104)
	gc:fillRect(self.x+self.w+2, self.y+1, 1, self.h+2)
	gc:fillRect(self.x+1, self.y+self.h+3, self.w+3, 1)
	gc:fillRect(self.x+self.w+3, self.y+2, 1, self.h+2)
	gc:fillRect(self.x+2, self.y+self.h+4, self.w+2, 1)
			
	gc:setColorRGB(255,255,255)
	gc:drawString(self.title, self.x + 4, self.y+2, "top")
	
	self:postPaint(gc)
end

function Dialog:postPaint() end

------------------------------------------------------------------
--                   Bindings to the on events                  --
------------------------------------------------------------------


function on.paint(gc)	
	for _, screen in pairs(Screens) do
		screen:draw(gc)	
	end	
end

function on.resize(x, y)
	-- Global Ratio Constants for On-Calc (shouldn't be used often though...)
	kXRatio = x/320
	kYRatio = y/212
end

function on.timer()			current_screen():timer()		 end
function on.arrowKey(arrw)	current_screen():arrowKey(arrw)  end
function on.enterKey()		current_screen():enterKey()		 end
function on.escapeKey()		current_screen():escapeKey()	 end
function on.tabKey()		current_screen():tabKey()		 end
function on.backtabKey()	current_screen():backtabKey()	 end
function on.charIn(ch)		current_screen():charIn(ch)		 end
function on.backspaceKey()	current_screen():backspaceKey()  end
function on.mouseDown(x,y)	current_screen():mouseDown(x,y)	 end
function on.mouseUp(x,y)	current_screen():mouseUp(x,y)	 end
function on.mouseMove(x,y)	current_screen():mouseMove(x,y)  end

function uCol(col)
	return col[1] or 0, col[2] or 0, col[3] or 0
end

function textLim(gc, text, max)
	local ttext, out = "",""
	local width	= gc:getStringWidth(text)
	if width<max then
		return text, width
	else
		for i=1, #text do
			ttext	= text:usub(1, i)
			if gc:getStringWidth(ttext .. "..")>max then
				break
			end
			out = ttext
		end
		return out .. "..", gc:getStringWidth(out .. "..")
	end
end


------------------------------------------------------------------
--                        Widget  Class                         --
------------------------------------------------------------------

Widget	=	class(Screen)

function Widget:init()
	self.dw	=	10
	self.dh	=	10
	
	self:ext()
end

function Widget:setSize(w, h)
	self.ww	= w or self.ww
	self.hh	= h or self.hh
end

function Widget:setPos(x, y)
	self.xx	= x or self.xx
	self.yy	= y or self.yy
end

function Widget:size(n)
	if n then return end
	self.w	=	math.floor(Pr(self.ww, self.dw, self.parent.w, 0)+.5)
	self.h	=	math.floor(Pr(self.hh, self.dh, self.parent.h, 0)+.5)
	
	self.rx	=	math.floor(Pr(self.xx, 0, self.parent.w, self.w)+.5)
	self.ry	=	math.floor(Pr(self.yy, 0, self.parent.h, self.h)+.5)
	self.x	=	self.parent.x + self.rx
	self.y	=	self.parent.y + self.ry
end

function Widget:giveFocus()
	if self.parent.focus~=0 then
		local veto	= self.parent:stealFocus()
		if veto == -1 then
			return -1
		end		
	end
	
	self.hasFocus	=	true
	self.parent.focus	=	self.pid
	self:getFocus()
end

function Widget:getFocus() end
function Widget:loseFocus() end
function Widget:enterKey() 
	self.parent:switchFocus(1)
end
function Widget:arrowKey(arrow)
	if arrow=="up" then
		self.parent:switchFocus(-1)
	elseif arrow=="down" then
		self.parent:switchFocus(1)
	end
end


WWidget	= addExtension(Widget, WidgetManager)


------------------------------------------------------------------
--                        Sample Widget                         --
------------------------------------------------------------------

-- First, create a new class based on Widget
box	=	class(Widget)

-- Init. You should define self.dh and self.dw, in case the user doesn't supply correct width/height values.
-- self.ww and self.hh can be a number or a string. If it's a number, the width will be that amount of pixels.
-- If it's a string, it will be interpreted as % of the parent screen size.
-- These values will be used to calculate self.w and self.h (don't write to this, it will overwritten everytime the widget get's painted)
-- self.xx and self.yy will be set when appending the widget to a screen. This value support the same % method (in a string)
-- They will be used to calculate self.x and self.h 
function box:init(ww,hh,t)
	self.dh	= 10
	self.dw	= 10
	self.ww	= ww
	self.hh	= hh
	self.t	= t
end

-- Paint. Here you can paint your widget stuff
-- Variable you can use:
-- self.x, self.y	: numbers, x and y coordinates of the widget relative to screen. So it's the actual pixel position on the screen.
-- self.w, self.h	: numbers, w and h of widget
-- many others

function box:paint(gc)
	gc:setColorRGB(0,0,0)
	
	-- Do I have focus?
	if self.hasFocus then
		-- Yes, draw a filled black square
		gc:fillRect(self.x, self.y, self.w, self.h)
	else
		-- No, draw only the outline
		gc:drawRect(self.x, self.y, self.w, self.h)
	end
	
	gc:setColorRGB(128,128,128)
	if self.t then
		gc:drawString(self.t,self.x+2,self.y+2,"top")
	end
end


------------------------------------------------------------------
--                         Input Widget                         --
------------------------------------------------------------------


sInput	=	class(Widget)

function sInput:init()
	self.dw	=	100
	self.dh	=	20
	
	self.value	=	""	
	self.bgcolor	=	{255,255,255}
	self.disabledcolor	= {128,128,128}
	self.font	=	{"sansserif", "r", 10}
	self.disabled	= false
end

function sInput:paint(gc)
	self.gc	=	gc
	local x	=	self.x
	local y = 	self.y
	
	gc:setFont(uCol(self.font))
	gc:setColorRGB(uCol(self.bgcolor))
	gc:fillRect(x, y, self.w, self.h)

	gc:setColorRGB(0,0,0)
	gc:drawRect(x, y, self.w, self.h)
	
	if self.hasFocus then
		gc:drawRect(x-1, y-1, self.w+2, self.h+2)
	end
		
	local text	=	self.value
	local	p	=	0
	
	
	gc_clipRect(gc, "subset", x, y, self.w, self.h)
	
	--[[
	while true do
		if p==#self.value then break end
		p	=	p + 1
		text	=	self.value:sub(-p, -p) .. text
		if gc:getStringWidth(text) > (self.w - 8) then
			text	=	text:sub(2,-1)
			break 
		end
	end
	--]]
	
	if self.disabled or self.value == "" then
		gc:setColorRGB(uCol(self.disabledcolor))
	end
	if self.value == ""  then
		text	= self.placeholder or ""
	end
	
	local strwidth = gc:getStringWidth(text)
	
	if strwidth<self.w-4 or not self.hasFocus then
		gc:drawString(text, x+2, y+1, "top")
	else
		gc:drawString(text, x-4+self.w-strwidth, y+1, "top")
	end
	
	if self.hasFocus and self.value ~= "" then
		gc:fillRect(self.x+(text==self.value and strwidth+2 or self.w-4), self.y, 1, self.h)
	end
	
	gc_clipRect(gc, "restore")
end

function sInput:charIn(char)
	if self.disabled or (self.number and not tonumber(self.value .. char)) then
		return
	end
	self.value	=	self.value .. char
end

function sInput:backspaceKey()
	if not self.disabled then
		self.value	=	self.value:usub(1,-2)
	end
end

function sInput:enable()
	self.disabled	= false
end

function sInput:disable()
	self.disabled	= true
end




------------------------------------------------------------------
--                         Label Widget                         --
------------------------------------------------------------------

sLabel	=	class(Widget)

function sLabel:init(text, widget)
	self.widget	=	widget
	self.text	=	text
	self.ww		=	30
	
	self.hh		=	20
	self.lim	=	false
	self.color	=	{0,0,0}
	self.font	=	{"sansserif", "r", 10}
	self.p		=	"top"
	
end

function sLabel:paint(gc)
	gc:setFont(uCol(self.font))
	gc:setColorRGB(uCol(self.color))
	
	local text	=	""
	local ttext
	if self.lim then
		text, self.dw	= textLim(gc, self.text, self.w)
	else
		text = self.text
	end
	
	gc:drawString(text, self.x, self.y, self.p)
end

function sLabel:getFocus(n)
	if self.widget and not n then
		self.widget:giveFocus()
	elseif n then
		self.parent:switchFocus(n)
	end
end


------------------------------------------------------------------
--                        Button Widget                         --
------------------------------------------------------------------

sButton	=	class(Widget)

function sButton:init(text, action)
	self.text	=	text
	self.action	=	action
	
	self.dh	=	27
	self.dw	=	48
		
	self.bordercolor	=	{136,136,136}
	self.font	=	{"sansserif", "r", 10}
	
end

function sButton:paint(gc)
	gc:setFont(uCol(self.font))
	self.ww	=	gc:getStringWidth(self.text)+8
	self:size()

	gc:setColorRGB(248,252,248)
	gc:fillRect(self.x+2, self.y+2, self.w-4, self.h-4)
	gc:setColorRGB(0,0,0)
	
	gc:drawString(self.text, self.x+4, self.y+4, "top")
		
	gc:setColorRGB(uCol(self.bordercolor))
	gc:fillRect(self.x + 2, self.y, self.w-4, 2)
	gc:fillRect(self.x + 2, self.y+self.h-2, self.w-4, 2)
	
	gc:fillRect(self.x, self.y+2, 1, self.h-4)
	gc:fillRect(self.x+1, self.y+1, 1, self.h-2)
	gc:fillRect(self.x+self.w-1, self.y+2, 1, self.h-4)
	gc:fillRect(self.x+self.w-2, self.y+1, 1, self.h-2)
	
	if self.hasFocus then
		gc:setColorRGB(40, 148, 184)
		gc:drawRect(self.x-2, self.y-2, self.w+3, self.h+3)
		gc:drawRect(self.x-3, self.y-3, self.w+5, self.h+5)
	end
end

function sButton:enterKey()
	if self.action then self.action() end
end

sButton.mouseUp	=	sButton.enterKey


------------------------------------------------------------------
--                      Scrollbar Widget                        --
------------------------------------------------------------------


scrollBar	= class(Widget)

scrollBar.upButton=image.new("\011\0\0\0\010\0\0\0\0\0\0\0\022\0\0\0\016\0\001\0001\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\198\255\255\255\255\255\255\255\255\156\243\255\255\255\255\255\255\255\2551\1981\198\255\255\255\255\255\255\214\218\0\128\214\218\255\255\255\255\255\2551\1981\198\255\255\255\255\247\222B\136\0\128B\136\247\222\255\255\255\2551\1981\198\255\255\247\222B\136!\132\0\128!\132B\136\247\222\255\2551\1981\198\247\222B\136!\132B\136R\202B\136!\132B\136\247\2221\1981\198\132\144B\136B\136\247\222\255\255\247\222B\136B\136\132\1441\1981\198\156\243\132\144\247\222\255\255\255\255\255\255\247\222\132\144\189\2471\1981\198\255\255\222\251\255\255\255\255\255\255\255\255\255\255\222\251\255\2551\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\198")
scrollBar.downButton=image.new("\011\0\0\0\010\0\0\0\0\0\0\0\022\0\0\0\016\0\001\0001\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\198\255\255\222\251\255\255\255\255\255\255\255\255\255\255\222\251\255\2551\1981\198\156\243\132\144\247\222\255\255\255\255\255\255\247\222\132\144\189\2471\1981\198\132\144B\136B\136\247\222\255\255\247\222B\136B\136\132\1441\1981\198\247\222B\136!\132B\136R\202B\136!\132B\136\247\2221\1981\198\255\255\247\222B\136!\132\0\128!\132B\136\247\222\255\2551\1981\198\255\255\255\255\247\222B\136\0\128B\136\247\222\255\255\255\2551\1981\198\255\255\255\255\255\255\214\218\0\128\214\218\255\255\255\255\255\2551\1981\198\255\255\255\255\255\255\255\255\156\243\255\255\255\255\255\255\255\2551\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\198")

function scrollBar:init(h, top, visible, total)
	self.color1	= {96, 100, 96}
	self.color2	= {184, 184, 184}
	
	self.hh	= h or 100
	self.ww = 14
	
	self.visible = visible or 10
	self.total   = total   or 15
	self.top     = top     or 4
end

function scrollBar:paint(gc)
	gc:setColorRGB(255,255,255)
	gc:fillRect(self.x+1, self.y+1, self.w-1, self.h-1)
	
	gc:drawImage(self.upButton  , self.x+2, self.y+2)
	gc:drawImage(self.downButton, self.x+2, self.y+self.h-11)
	gc:setColorRGB(uCol(self.color1))
	gc:drawRect(self.x + 3, self.y + 14, 8, self.h - 28)
	
	if self.visible<self.total then
		local step	= (self.h-26)/self.total
		gc:fillRect(self.x + 3, self.y + 14  + step*self.top, 9, step*self.visible)
		gc:setColorRGB(uCol(self.color2))
		gc:fillRect(self.x + 2 , self.y + 14 + step*self.top, 1, step*self.visible)
		gc:fillRect(self.x + 12, self.y + 14 + step*self.top, 1, step*self.visible)
	end
end

function scrollBar:update(top, visible, total)
	self.top      = top     or self.top
	self.visible  = visible or self.visible
	self.total    = total   or self.total
end

function scrollBar:action(top) end

function scrollBar:mouseUp(x, y)
	local upX	= self.x+2
	local upY	= self.y+2
	local downX	= self.x+2
	local downY	= self.y+self.h-11
	local butH	= 10
	local butW	= 11
	
	if x>=upX and x<upX+butW and y>=upY and y<upY+butH and self.top>0 then
		self.top	= self.top-1
		self:action(self.top)
	elseif x>=downX and x<downX+butW and y>=downY and y<downY+butH and self.top<self.total-self.visible then
		self.top	= self.top+1
		self:action(self.top)
	end
end

function scrollBar:getFocus(n)
	if n==-1 or n==1 then
		self.parent:switchFocus(n)
	end
end


------------------------------------------------------------------
--                         List Widget                          --
------------------------------------------------------------------

sList	= class(WWidget)

function sList:init()
	Widget.init(self)
	self.dw	= 150
	self.dh	= 153

	self.ih	= 18

	self.top	= 0
	self.sel	= 1
	
	self.font	= {"sansserif", "r", 10}
	self.colors	= {50,150,190}
	self.items	= {}
end

function sList:appended()
	self.scrollBar	= scrollBar("100", self.top, #self.items,#self.items)
	self:appendWidget(self.scrollBar, -1, 0)
	
	function self.scrollBar:action(top)
		self.parent.top	= top
	end
end


function sList:paint(gc)
	local x	= self.x
	local y	= self.y
	local w	= self.w
	local h	= self.h
	
	
	local ih	= self.ih   
	local top	= self.top		
	local sel	= self.sel		
		      
	local items	= self.items			
	local visible_items	= math.floor(h/ih)	
	gc:setColorRGB(255, 255, 255)
	gc:fillRect(x, y, w, h)
	gc:setColorRGB(0, 0, 0)
	gc:drawRect(x, y, w, h)
	gc_clipRect(gc, "set", x, y, w, h)
	gc:setFont(unpack(self.font))

	
	
	local label, item
	for i=1, math.min(#items-top, visible_items+1) do
		item	= items[i+top]
		label	= textLim(gc, item, w-(5 + 12 + 2 + 1))
		
		if i+top == sel then
			gc:setColorRGB(unpack(self.colors))
			gc:fillRect(x+1, y + i*ih-ih + 1, w-(12 + 2 + 2), ih)
			
			gc:setColorRGB(255, 255, 255)
		end
		
		gc:drawString(label, x+5, y + i*ih-ih , "top")
		gc:setColorRGB(0, 0, 0)
	end
	
	self.scrollBar:update(top, visible_items, #items)
	
	gc_clipRect(gc, "reset")
end

function sList:arrowKey(arrow)	
	if arrow=="up" and self.sel>1 then
		self.sel	= self.sel - 1
		if self.top>=self.sel then
			self.top	= self.top - 1
		end
	end

	if arrow=="down" and self.sel<#self.items then
		self.sel	= self.sel + 1
		if self.sel>(self.h/self.ih)+self.top then
			self.top	= self.top + 1
		end
	end
end


function sList:mouseUp(x, y)
	if x>=self.x and x<self.x+self.w-16 and y>=self.y and y<self.y+self.h then
		
		local sel	= math.floor((y-self.y)/self.ih) + 1 + self.top
		if sel==self.sel then
			self:enterKey()
			return
		end
		if self.items[sel] then
			self.sel=sel
		else
			return
		end
		
		if self.sel>(self.h/self.ih)+self.top then
			self.top	= self.top + 1
		end
		if self.top>=self.sel then
			self.top	= self.top - 1
		end
						
	end 
	self.scrollBar:mouseUp(x, y)
end


function sList:enterKey()
	if self.items[self.sel] then
		self:action(self.sel, self.items[self.sel])
	end
end



function sList:action() end

function sList:reset()
	self.sel	= 1
	self.top	= 0
end

------------------------------------------------------------------
--                        Screen Widget                         --
------------------------------------------------------------------

sScreen	= class(WWidget)

function sScreen:init(w, h)
	Widget.init(self)
	self.ww	= w
	self.hh	= h
	self.oy	= 0
	self.ox	= 0
	self.noloop	= true
end

function sScreen:appended()
	self.oy	= 0
	self.ox	= 0
end

function sScreen:paint(gc)
	gc_clipRect(gc, "set", self.x, self.y, self.w, self.h)
	self.x	= self.x + self.ox
	self.y	= self.y + self.oy
end

function sScreen:postPaint(gc)
	gc_clipRect(gc, "reset")
end

function sScreen:setY(y)
	self.oy	= y or self.oy
end
						
function sScreen:setX(x)
	self.ox	= x or self.ox
end

function sScreen:showWidget()
	local w	= self:getWidget()
	if not w then print("bye") return end
	local y	= self.y - self.oy
	local wy = w.y - self.oy
	
	if w.y-2 < y then
		print("Moving up")
		self:setY(-(wy-y)+4)
	elseif w.y+w.h > y+self.h then
		print("moving down")
		self:setY(-(wy-(y+self.h)+w.h+2))
	end
	
	if self.focus == 1 then
		self:setY(0)
	end
end

function sScreen:getFocus(n)
	if n==-1 or n==1 then
		self:stealFocus()
		self:switchFocus(n, true)
	end
end

function sScreen:loop(n)
	self.parent:switchFocus(n)
	self:showWidget()
end

function sScreen:focusChange()
	self:showWidget()
end

function sScreen:loseFocus(n)
	if (n == 1 and self.focus<#self.widgets) or (n == -1 and self.focus>1) then
		self:switchFocus(n)
		return -1
	else
		self:stealFocus()
	end
	
end
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
CategorySel	= WScreen()
CategorySel.iconS	= 48

CategorySel.sublist	= sList()
CategorySel:appendWidget(CategorySel.sublist, 5, 5+24)
CategorySel.sublist:setSize(-10, -70)
CategorySel.sublist.cid	= 0

function CategorySel.sublist:action(sid)
	only_screen(SubCatSel, sid)
end

function CategorySel:paint(gc)
	gc:setColorRGB(255,255,255)
	gc:fillRect(self.x, self.y, self.w, self.h)
	
	gc:setColorRGB(0,0,0)
	gc:setFont("sansserif", "r", 16)
	gc:drawString("Select your category:", 5, 0, "top")
	
	gc:setColorRGB(220,220,220)
	gc:setFont("sansserif", "r", 8)	
	gc:drawRect(5, self.h-46+10, self.w-10, 25+6)
	gc:setColorRGB(128,128,128)
	gc:setFont("sansserif", "r", 8)
		
	local splinfo	= Categories[self.sublist.sel].info:split("\n")
	for i, str in ipairs(splinfo) do
		gc:drawString(str, 7, self.h-56+12 + i*10, "top")
	end
end

function CategorySel:pushed()
	local items	= {}
	for cid, cat in ipairs(Categories) do
		table.insert(items, cat.name)
	end

	self.sublist.items	= items
	self.sublist:giveFocus()
end



SubCatSel	= WScreen()
SubCatSel.sel	= 1

SubCatSel.sublist	= sList()
SubCatSel:appendWidget(SubCatSel.sublist, 5, 5+24)
SubCatSel.sublist:setSize(-10, -34)
SubCatSel.sublist.cid	= 0

function SubCatSel.sublist:action (sub)
	only_screen(manualSolver, self.parent.cid, sub)
end

function SubCatSel:paint(gc)
	gc:setColorRGB(0,0,0)
	gc:setFont("sansserif", "r", 16)
	gc:drawString(Categories[self.cid].name, 5, 0, "top")	
end

function SubCatSel:pushed(sel)
	self.cid	= sel
	local items	= {}
	for sid, subcat in ipairs(Categories[sel].sub) do
		table.insert(items, subcat.name)
	end

	if self.sublist.cid ~= sel then
		self.sublist.cid	= sel
		self.sublist:reset()
	end

	self.sublist.items	= items
	self.sublist:giveFocus()
end

function SubCatSel:escapeKey()
	only_screen(CategorySel)
end



-------------------
-- Manual solver --
-------------------

manualSolver	= WScreen()
manualSolver.pl	= sScreen(-20, -50)
manualSolver:appendWidget(manualSolver.pl, 2, 4)

manualSolver.sb	= scrollBar(-50)
manualSolver:appendWidget(manualSolver.sb, -2, 3)

manualSolver.back	=	sButton("Back")
manualSolver:appendWidget(manualSolver.back, 5, -5)
function manualSolver.back:action()
	manualSolver:escapeKey()
end


function manualSolver.sb:action(top)
	self.parent.pl:setY(4-top*30)
end

function manualSolver:paint(gc)
	gc:setColorRGB(224,224,224)
	gc:fillRect(self.x, self.y, self.w, self.h)
	gc:setColorRGB(128,128,128)
	gc:fillRect(self.x+5, self.y+self.h-42, self.w-10, 2)
	self.sb:update(math.floor(-(self.pl.oy-4)/30+.5))
end

function manualSolver:postPaint(gc)
	--gc:setColorRGB(128,128,128)
	--gc:drawRect(self.x, self.y, self.w, self.h-46)
end



function manualSolver:pushed(cid, sid)
	self.pl.widgets	= {}
	self.pl.focus	= 0
	self.cid	= cid
	self.sid	= sid
	self.sub	= Categories[cid].sub[sid]
	self.pl.oy = 0
	self.known	= {}
	self.inputs	= {}
	self.constants = {}
	
	local inp, lbl
	local i	= 0
	for variable,_ in pairs(self.sub.variables) do
		
		
		if not Constants[variable] or Categories[cid].varlink[variable] then
			i=i+1
			inp	= sInput()
			inp.value	= ""
			inp.number	= true
			
			function inp:enterKey() 
				manualSolver:solve()
				self.parent:switchFocus(1)
			end
			
			self.inputs[variable]	= inp
			inp.ww	= 200
			
			lbl	= sLabel(variable, inp)

			self.pl:appendWidget(inp, 60, i*30-28)		
			self.pl:appendWidget(lbl, 2, i*30-28)
			self.pl:appendWidget(sLabel(":", inp), 50, i*30-28)
			
			local variabledata	= Categories[cid].varlink[variable]
			inp.placeholder	= variabledata.info
			if variabledata.unit ~= "unitless" then
				unitlbl	= sLabel(variabledata.unit:gsub("([^%d]+)(%d)", numberToSub))
				self.pl:appendWidget(unitlbl, 265, i*30-28)
			end
			
			inp.getFocus = manualSolver.update
		else
			self.constants[variable]	= math.eval(Constants[variable].value)
			--var.store(variable, self.known[variable])
		end

	end
	
	manualSolver.sb:update(0, math.floor(self.pl.h/30+.5), i)
	self.pl:giveFocus()

	self.pl.focus	= 1
	self.pl:getWidget().hasFocus	= true
	self.pl:getWidget():getFocus()
	
end

function manualSolver.update()
	manualSolver:solve()
end

function manualSolver:solve()
	local inputed	= {}
	local disabled	= {}
	
	for variable, input in pairs(self.inputs) do
		
		if input.disabled then 
			inputed[variable] = nil
			input.value = ""
		end
		
		input:enable()
		if input.value	~= "" then
			inputed[variable]	= tonumber(input.value)
		end
	end
	
	local invs = copyTable(inputed)
	for k,v in pairs(self.constants) do
		invs[k]=v
	end
	self.known	= find_data(invs, self.cid, self.sid)
	
	for variable, value in pairs(self.known) do
		if (not inputed[variable] and self.inputs[variable]) then
			self.inputs[variable].value	= tostring(value)
			self.inputs[variable]:disable()
		end
	end
end

function manualSolver:escapeKey()
	only_screen(SubCatSel, self.cid)
end

icon	= {}
icon[1]	= image.new("\048\0\0\0\048\0\0\0\0\0\0\0\096\0\0\0\016\0\001\000wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwR\202\024\227wwwwwwwwwwwwww{\239s\206{\239wwwwwwwwwwwwwws\206\024\227wwwwwwwwwwwwww\156\243R\202{\239wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\222\251c\140k\173\156\243wwwwwwwwwwww1\198!\132\148\210wwwwwwwwwwwwww\132\144J\169{\239wwwwwwwwwwwwR\202!\132\181\214wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwR\202)\165\165\148\214\218wwwwwwwwww\222\251J\169\165\148\206\185{\239wwwwwwwwwws\206)\165\165\148\214\218wwwwwwwwww\222\251)\165\165\148\173\181{\239wwwwwwwwwwwwwwwwwwwwwwwwwwww\222\251\198\152\247\222\206\185\206\185{\239wwwwwwwwR\202\140\177\247\222k\173\148\210wwwwwwww\222\251\198\152\247\222\206\185\206\185{\239wwwwwwwws\206k\173\024\227)\165s\206wwwwwwwwww\156\243\156\243\156\243\156\243\222\251wwwwwwwws\206)\165\222\251{\239J\169s\206wwwwww\189\247\231\156\214\218ww\206\185\173\181\156\243wwwwwws\206\008\161\222\251{\239J\169R\202wwwwww\189\247\231\156\181\214ww\239\189k\173\024\227\189\247\156\243\156\243\189\247\016\194\239\189\239\189\239\189\239\189\024\227wwww\156\243\231\156\214\218\222\251ww\206\185\140\177\156\243ww\222\251\148\210\008\161\189\247ww9\231k\173R\202wwww\156\243\231\156\181\214\222\251ww\206\185\140\177\156\243wwww\181\214\231\156\189\247wwZ\235\140\177)\165\016\194\239\189\016\194\181\214\239\189\206\185\206\185\206\185\231\156\173\181\222\251ww\148\210\008\161\222\251wwww\024\227k\173s\206ww{\239\008\161\148\210wwwwww\206\185k\173\189\247ww\181\214\231\156\222\251wwww\024\227k\173R\202ww{\239)\165s\206wwwwww\247\222\206\185\206\185\206\185\239\189\181\214wwwwwwww\247\222k\173\148\210\156\243)\165\148\210wwwwwwww\239\189\140\177\222\251\214\218\231\156\222\251wwwwww\247\222k\173\148\210\156\243J\169s\206wwwwwwww\239\189\140\177\222\251\214\218\198\152\222\251wwwwwwwwwwwwwwwwwwwwwwwwwwww1\198J\169\181\214\008\161wwwwwwwwww\214\218\173\181\016\194\173\181R\202wwwwwwwwww1\198J\169\148\210\231\156\222\251wwwwwwww\247\222\173\181\016\194\206\1851\198wwwwwwwwwwwwwwwwwwwwwwwwwwwwww\024\227\231\156\132\144s\206wwwwwwwwwwwwR\202!\132)\165\222\251wwwwwwwwww9\231\231\156\132\144s\206wwwwwwwwwwwwR\202\0\128)\165\222\251wwwwwwwwwwwwwwwwwwwwwwwwwwwwww\222\251\016\194\198\152\222\251wwwwwwwwwwww\247\222\231\1561\198wwwwwwwwwwwwww\016\194\198\152\222\251wwwwwwwwwwww\247\222\008\161\239\189wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww{\239\247\222s\206\016\194\016\194\016\194\247\222\189\247wwwwwwwwwwwwwwwwwwww\189\247J\169\008\161\181\214wwwwwwww\181\214\016\194\008\161\008\161\206\185s\206\189\247wwwwww{\239\008\161\008\161{\239wwwwwwwwwwwwwwww\016\194\0\128\0\128\0\128\0\128\0\128\0\128B\136s\206wwwwwwwwwwwwwwwwwwJ\169\0\128\140\177wwwwww\247\222\132\144\0\128\0\128\132\144B\136\0\128\0\128\132\1449\231wwwwww\008\161\0\128\206\185wwwwwwwwwwwwwwww\008\161\0\128\198\152ww\189\247\181\214B\136\0\128B\136wwwwwwwwwwwwwwwwR\202\0\128\132\144\189\247wwwws\206\0\128\0\128\008\1619\231wwwwR\202\0\128\0\128\132\144\189\247wwwws\206\0\128\132\144wwwwwwwwwwwwwwww\132\144\0\128J\169wwwwww\016\194\0\128\0\128{\239wwwwwwwwwwww\189\247B\136\0\128\181\214wwww\247\222\0\128\0\128J\169wwwwwwwwww\140\177\0\128\0\128s\206wwww{\239\0\128\0\1289\231wwwwwwwwwwwwww\0\128\0\128\016\194wwwwww\206\185\0\128\0\128wwwwwwwwwwwwww\016\194\0\128\008\161wwwwww\132\144\0\128B\136\189\247wwwwwwwwww9\231\0\128\0\128\206\185wwwwww\0\128\0\128\247\222wwwwwwwwwwww\247\222\0\128\0\128\247\222wwww\189\247B\136\0\128\140\177wwwwwwwwwwwwwwB\136\0\128s\206wwww\181\214\0\128\0\128R\202wwwwwwwwwwwwww\0\128\0\128J\169wwwwww\198\152\0\128\247\222wwwwwwwwwwwwR\202\0\128\0\128s\206\247\222R\202B\136\0\128\198\152\189\247wwwwwwwwwwww\181\214\0\128\0\128\189\247wwww\206\185\0\128\0\128{\239wwwwwwwwwwwwww\0\128\0\128\016\194wwwwwwB\136\0\128\247\222wwwwwwwwwwww\206\185\0\128\0\128\0\128\0\128\0\128\0\128\140\177wwwwwwwwwwwwwwww\016\194\0\128\008\161wwwwww\008\161\0\128B\136wwwwwwwwwwwwww\247\222\0\128\0\128s\206wwwwww\0\128\0\128\247\222wwwwwwwwwwww\008\161\0\128\198\152\247\222s\206\132\144\0\128B\136\189\247wwwwwwwwwwwwww\008\161\0\128\016\194wwwwww\008\161\0\128\008\161wwwwwwwwwwwwww\206\185\0\128\0\128\189\247wwww{\239\0\128\0\128{\239wwwwwwwwwwwwB\136\0\128\206\185wwww\181\214\0\128\0\128\181\214wwwwwwwwwwwwww\132\144\0\128s\206wwwwww\140\177\0\128B\136wwwwwwwwwwww\189\247B\136\0\128\140\177wwwwwws\206\0\128B\136wwwwwwwwwwww{\239\0\128\0\128R\202wwwwww\0\128\0\128\016\194wwwwwwwwwwwwww\0\128\0\128\247\222wwwwwws\206\0\128\0\1289\231wwwwwwwwww\206\185\0\128B\136{\239wwwwww\140\177\0\128\140\177wwwwwwwwwwww\247\222\0\128\0\128\247\222wwwwww\0\128\0\128\016\194wwwwwwwwwwwwww\0\128\0\128\247\222wwwwww\189\247B\136\0\128\140\177wwwwwwwws\206\0\128\0\128\181\214wwwwww\189\247B\136\0\128s\206wwwwwwwwwwww\016\194\0\128\0\128\189\247wwwwww\0\128\0\128\016\194wwwwwwwwwwwwwwB\136\0\128\181\214wwww\247\222\247\222\140\177\0\128\0\128s\206wwww\016\194\0\128\0\128\140\177\247\2229\231wwwws\206\0\128\132\144wwwwwwwwwwwwww\140\177\0\128\132\144wwwwwwww\132\144\0\128\008\161wwwwwwwwwwwwww\008\161\0\128\016\194ww\189\247\0\128\0\128\0\128\0\128\0\128\008\161ww\247\222\0\128\0\128\0\128\0\128\0\128\140\177ww\189\247\132\144\0\128s\206wwwwwwwwwwwwww9\231\247\2229\231wwwwwwww9\231\247\2229\231wwwwwwwwwwwwww\016\194\0\128\008\161ww\189\247\247\222\247\222\247\222\247\222\247\2229\231ww\189\247\247\222\247\222\247\222\247\222\247\222{\239ww\016\194\0\128\198\152wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww{\239\0\128\0\128{\239wwwwwwwwwwwwwwwwwwwwwwwwwwwwww\247\222\0\128B\1369\231wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\016\194\008\161s\206wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwJ\169\008\161\181\214wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww7\239m\222\005\226\128\229`\221\166\205\199\205\162\217\162\221\231\213N\210\247\222\247\222\146\218\234\205c\144B\136\197\156+\214\011\210\011\210\011\210,\214F\197\195\188\227\188\200\205\200\201\170\193\246\226wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwz\243\140\230\173\234F\242\224\245\192\237)\222'\226\192\237\192\241&\230\176\226|\239\156\243\021\235*\218 \132\0\128\130\152\140\230k\226k\226k\226\140\230\135\209\004\201%\201*\222K\218\200\201&\177\247\222wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\209\234\205\242\015\247\134\250\0\250\224\241j\226G\234\224\245\0\250h\238\242\238\222\251\222\251W\243k\226A\136\0\128\163\152\173\234\173\234\173\234\173\234\205\238\200\217%\205%\205K\226l\226*\214f\185j\181wwwwwwwwwwwwwwwwwwwwwwwwwwwwww\156\247\141\230\238\246\183\255\202\254\0\250\224\241k\230G\238\0\250\0\250\170\246T\247\223\251\255\251\153\251\206\238A\136\0\128\163\156\240\246\239\242\239\242\239\242R\251+\226$\205%\205K\226\140\226+\214\168\193\228\164\024\231wwwwwwwwwwwwwwT\202u\206\150\210\183\214\183\214\150\210U\2022\202\140\230\015\247\252\255\203\254\224\249\224\241k\230G\238\0\246\0\250\236\254\151\255\222\251\223\251\153\255\016\247A\140\0\128\196\1561\251\016\247\016\247\016\247\181\255m\226$\205%\205K\226\140\226*\214\168\193\196\160K\169U\202T\2023\1983\198\018\194\018\194\240\189\141\177,\169m\173m\177m\177L\173+\165J\173\140\230\206\242s\251\167\254\224\245\224\237K\222'\230\224\241\224\245\137\238\019\239\189\247\190\247W\243\140\230A\136\0\128\163\152\206\238\173\234\173\234\173\234\239\242\234\221$\201%\201*\222l\222\010\210\136\189\195\160\133\148+\169\010\165\010\161\233\160\232\156\200\156\232\160\024\231\181\218\181\218\181\218\181\218\181\218\181\218R\210K\222\173\234\173\234$\242\192\241\192\229*\218\006\222\192\233\192\237'\226\176\226{\239|\239\021\235*\218!\136\0\128\131\148l\226k\222k\222k\226\140\226\168\209\004\197\004\197\009\214K\218\233\205g\181\195\156\206\193\181\218\181\222\181\218\181\218\181\218\181\222\247\226wwwwwwwwwwwwww\189\247M\214k\226l\226\004\230\160\229\128\221\232\205\198\213\128\225\160\225\230\217n\218\024\227\025\227\179\222\233\205!\136\0\128\130\148+\214*\214*\214*\214K\218g\201\228\192\004\193\201\209\010\206\168\193\004\169\230\164\024\231wwwwwwwwwwwwwwwwwwwwwwwwwwwwww\180\222\200\205\010\210\196\213`\217@\205\135\193e\193@\205@\205\133\201\235\197t\206\148\206/\206\135\193 \132\0\128b\144\201\197\168\197\168\197\168\197\201\201%\189\195\180\227\180\136\197\168\193&\177\162\152\205\189wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\189\247\014\202g\181#\189\0\189\224\180\227\168\195\164\160\172\192\172\226\168\006\169k\173k\173I\173\228\164\0\132\0\128A\140\005\169\005\169\004\169\004\169\005\169\162\164\129\164\130\164%\173\228\164\163\156J\1779\235wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\156\243R\210\139\189&\177\005\173I\177\173\189\015\198\016\202\016\198\016\198\016\198\016\198\016\202\016\202\016\198\016\198\016\198\016\202\016\202\016\202\016\202\016\202\206\193j\181\007\169\007\169J\177\016\2029\235wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww")
icon[2]	= image.new("\048\0\0\0\048\0\0\0\0\0\0\0\096\0\0\0\016\0\001\000wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwww\188\247\220\251wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128\0\128\0\128\0\128wwwwwwwwy\239+\198\012\227\150\243wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwww\154\243\010\198\203\218\241\255\174\247wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwww\252\243x\227+\186\138\210\208\255\238\255\171\247wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\222\255wwwwwwwwwwwwwwwwwwwwwwwwwwww\221\243\173\178\198\149\201\162\141\199\206\243\172\251q\239wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwQ\254g\253wwwwww8\255\212\254\146\254\146\254\180\254\246\2548\255z\255\189\255wwwwwwwwwwwwwwww\221\247O\186\166\153\201\166\238\187\236\171\170\195\174\247\253\255wwwwwwwwwwwwwwwwwwwwww\205\253\205\253\205\253\205\253\205\253\239\253\229\252\160\252\203\253wwk\253F\253\236\253\013\254\014\254\013\254\013\254\236\253\013\254\145\254\023\255{\255wwwwwwwwww\222\251\176\190\198\149\168\162\205\187\237\187\234\163\137\163\249\255wwwwwwwwwwwwwwwwwwwwwwww\128\252\128\252\128\252\128\252\128\252\128\252\128\252\128\252\160\252\226\252wwwwwwwwwwwwww\254\255z\255\179\254.\254/\254\213\254{\255wwww\254\251\210\202\198\149\136\162\205\187\238\187\202\167\169\163N\179\252\251wwwwwwwwwwwwwwwwwwwwwwww\023\255\023\255\023\255\023\255\023\255\023\255\013\254\128\252\226\252\245\254wwwwwwwwwwwwwwwwwwwwwwY\255P\254/\254\023\255\188\2514\207\232\153h\162\173\183\238\191\234\171\201\163k\175\186\235wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwO\254\194\2527\255wwwwww\221\255\188\255\221\255z\255{\255\188\255wwwwwwwwww8\251q\242\013\230\231\169\137\154\141\183\238\191\235\171\201\163k\175\185\231wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\221\255P\254\137\253/\254\013\254/\254p\254\179\254\022\255{\255wwwwwwW\211\005\193\195\204\137\194\239\187\236\175\201\167k\171\151\223wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\179\254\194\252\128\252\128\252\194\252\236\253\221\255wwww\189\255.\254F\253\014\254\246\254\022\255\212\254q\254.\254/\254\212\254\155\255X\231\140\154\137\154(\202e\237\168\194\234\163\236\163\150\215wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwq\254\128\252\170\253.\254\004\253\128\252.\254wwwwww\254\255\188\255wwwwwwwwww\254\255\246\250q\238\238\241h\197H\158\141\175\241\187\136\202C\213\168\186\019\223wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwq\254\128\252\179\254ww\155\255\128\252\004\253wwwwwwwwwwwwwwwwwwwwwwww\187\235\168\189\194\208\133\209\174\195\238\179\236\163G\194g\229\155\255wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwq\254\128\252\179\254ww\221\255\128\252F\253wwwwwwwwww\156\255\179\254\212\254\213\254\246\254\156\255\155\247\208\170i\146\170\178\167\229\166\221\138\175\236\151S\207\146\250\179\254\222\255wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwq\254\128\252.\254\023\255\136\253\128\252q\254wwwwwwwwww8\255\003\253\003\253\013\254p\254P\246\137\217\198\165+\167\240\183\206\187\164\209\196\2010\203\254\251ww\013\254\246\254wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwq\254\128\252\128\252\128\252\128\252\194\252Y\255wwwwwwwwww\189\255\179\254\180\254\222\255\188\247\011\190\003\193\003\213\170\206\238\187\236\167\138\171%\221\213\250wwwwY\255.\254\155\255wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwq\254\128\252.\254\023\255q\254\194\252\194\252\155\255wwwwwwwwwwwwwwww2\187)\150\234\162\138\206e\229\135\194\235\163\239\175\021\239P\254Y\255wwwwP\254\179\254\222\255wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwq\254\128\252\179\254wwww.\254\128\252\179\254wwwwwwwwwwwwww\019\199\006\154h\162\205\183\240\183\200\190C\217\203\190\250\227ww\145\254q\254\221\255ww\155\255\013\254z\255wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwq\254\128\252.\254\023\255\179\254\194\252\128\252Y\255wwwwwwwwwwww\020\207\199\157G\158\140\183\238\191\235\171\235\155\197\197/\238wwww\156\255\013\2548\255wwwwP\254\212\254\254\255wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwq\254\128\252\128\252\128\252\128\252\194\252\213\254wwwwwwwwwwww\022\215\232\157G\158l\179\238\191\235\175\201\163\205\163\242\218q\254Y\255wwww/\254\179\254wwwwY\255.\254\156\255wwwwwwwwwwwwwwwwwwwwwwwwwwwwww\221\255\023\255\023\255\023\255\155\255wwwwwwwwwwwwwwW\223\232\157'\154K\175\238\191\235\175\201\163\138\167\247\207wwq\254\245\254wwww\245\254.\254\155\255wwww\013\254X\255wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\189\255\188\255wwy\227\009\166\006\154+\175\238\191\235\179\201\167\202\159\245\195\254\255wwP\254\212\254wwwwz\255\013\254Y\255wwwwq\254\212\254\222\255wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\222\255\222\255wwwwY\255q\2547\231l\162\006\154\010\171\238\191\236\179\233\163\236\151\018\219\222\255ww\221\255\013\254\245\254wwww\188\255\013\2548\255wwww\245\254P\254\188\255wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwZ\255P\254wwww\222\255\146\234\168\173'\146\234\170\238\191\236\183\234\163\169\163\205\198\222\255ww\189\255\237\253\237\253\189\255wwww\188\255\013\2548\255wwwwY\255.\254\155\255wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\188\255P\254\146\254ww\221\247L\178\230\153\233\166\238\191\237\183\201\167\234\159j\198\014\246p\254q\254\013\254\014\254z\255wwwwwwY\255\013\254Y\255wwww{\255\013\254\155\255wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwz\255.\254\213\242\209\186\006\150\201\162\206\187\237\187\234\167\234\159\240\171\154\243\155\2557\255\023\2558\255\189\255wwwwwwwwq\254P\254\222\255wwwwz\255\013\254\155\255wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwz\243\136\193'\150\168\162\205\187\237\187\202\167\201\163\012\183\156\247wwwwwwwwwwwwwwwwwwX\255\170\253\023\255wwwwww\246\254\013\254\156\255wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\243\194\198\153\136\162\173\183\238\187\202\171\234\159\010\179\204\229P\254Y\255wwwwwwwwwwwwww\245\254g\253\146\254\222\255wwwwwwO\254q\254\222\255wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\243\202\007\154\136\158\140\183\238\191\202\171\233\159\237\155\151\227{\255\146\254\236\253\237\253q\254\246\2548\2557\255\179\254\236\253\170\253\212\254\222\255wwwwww\189\255\169\2537\255wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\245\214\007\154G\158\140\179\238\191\235\171\201\163I\171\244\234wwww\222\255z\255\023\255\179\254q\254P\254P\254\145\254\245\254z\255wwwwwwwwww\013\254.\254\222\255wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwv\215\201\161G\154k\175\238\191\235\175\233\159\138\167,\218\013\2548\255wwwwwwww\222\255\188\255\188\255\188\255\189\255wwwwwwwwwwwwO\254\170\253z\255wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwX\227\008\158'\154K\175\238\191\235\175\201\163\170\163\147\207\189\2519\255\013\254\237\2537\255wwwwwwwwwwwwwwwwwwwwww\222\255\013\254\170\253Y\255wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\154\235\009\162\006\154*\171\238\191\236\175\201\163\137\167\144\199\254\251ww>\2319\214R\242\202\253\170\253\146\254\155\255wwwwwwwwwwww\189\255\146\254\137\253/\254\155\255wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\187\239\010\166\006\154\010\171\238\191\236\179\201\163\169\163\174\191\222\247ww\031\223\252\148\127\161}\247\156\255\245\254.\254\169\253\170\253\013\254/\254P\254O\254\236\253\203\253O\2548\255\221\255wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\221\247+\170\006\154\233\166\238\191\236\183\201\163\138\167\172\183\253\247ww_\231\217\148\218\148\030\223wwwwww\189\255\156\255Y\255\245\254\179\254\179\254\245\2548\255\155\255\221\255wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\222\251m\178\006\154\201\162\238\187\237\183\202\163\201\163\140\183\221\247ww\127\235<\153\218\140\222\214wwwwwwwwwwwwwwww\222\255\222\255wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128\0\128\0\128\0\128\0\128\254\251\143\186\230\149\168\158\238\187\237\187\202\167\201\163\139\175\218\239ww\159\243[\165\186\140\157\206wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\243\202\199\165\008\182\170\178\172\179\234\171\201\163j\171{\231ww\191\247\156\169\154\136}\198wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwM\190(\198n\243\175\243\200\178\201\159\138\175\153\227^\235\254\177\188\173\186\140\092\198wwwwww\154\136\154\136\154\136wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww7\235)\198.\235\241\255\204\255\009\203\009\159\182\223ww\158\206\186\140\186\136\186\136<\194wwwwwwww\154\136wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwy\239\009\194-\231\241\255\205\251\171\243i\182u\215ww\223\251]\194\154\136\250\148=\194^\235wwwwwwww\154\136wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\254\255+\198\200\185j\206\205\251\204\251S\227z\231wwww\223\251\221\214|\202\191\247wwwwwwwwwwww\154\136wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwM\202\200\185\199\185\011\227\181\247wwwwwwwwwwwwwwwwwwwwwwwwww\154\136\154\136\154\136wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\155\243M\202\233\1893\231wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww")
icon[3]	= image.new("\048\0\0\0\048\0\0\0\0\0\0\0\096\0\0\0\016\0\001\0\022\255q\254\221\255\180\254\179\254Y\255\022\255\146\254\155\255\246\254q\254wwwwP\254wwwwz\255q\254\155\255wwwwwwwwwwwwwwwwwwwwww\022\255\179\254wwww\188\255\146\254wwwwq\254\179\254\222\255\146\254\189\255\212\254\146\254\146\254\221\255\179\254p\254Y\255\023\255\145\2548\255\022\255\245\254\146\254\179\254\188\255\179\254ww\146\254\188\255ww\180\254\246\254wwwwwwwwwwwwwwwwwwwwwwwwwwww\222\255q\254\155\255ww\022\255X\255ww\245\2547\255\023\255\146\254{\255\212\254\213\254\145\254\179\254\156\255z\255\213\254q\254\146\254\156\255\179\254\212\254q\254\146\254\212\254\189\255Y\255\246\254wwq\254{\255wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\179\254Y\255wwq\254\222\255\222\255\146\254\146\254q\254X\255\179\254\246\254\213\254q\254\146\254q\254q\254\179\254\246\2547\255q\254\146\254\146\254\146\254q\254wwP\254wwP\254\188\255wwwwwwwwwwwwwwww\221\255q\254\155\255wwwwwwwwwwwwwwww\179\254Y\255\222\255q\254wwq\254\146\254\146\254\022\255P\254\146\254\245\254\246\254\180\254\246\254\213\254q\254q\254q\254q\254\145\254q\254P\254\212\254\212\254\155\255P\254\188\255wwwwwwwwww\155\255\179\254\146\254\146\254\212\254\137\253O\254\146\254\146\254\179\254\156\255wwwwwwwwww\179\254Y\255\245\254z\255\213\254P\254\146\254\179\254q\254q\254P\254P\254\146\254\203\253q\254\146\254P\254O\254\145\254\145\254/\254\014\254\155\255\146\254q\254\156\255wwwwwwww\212\254q\254\246\254\222\255wwwwwwwwwwwwww\222\255\245\254q\254\246\254wwwwwwwwq\254\156\255P\254\221\255\203\253q\254\146\254P\254/\254P\254\179\254\146\254\179\254\170\253.\254.\254\014\254P\254.\254\013\254.\254\146\254\212\2548\255wwww\222\255\146\254\146\254\188\255wwwwwwwwwwwwwwwwwwwwwwwwwwz\255q\254\213\254wwwwwwO\254\023\2557\255\236\253P\254p\254\203\253.\254O\254O\254\169\253\014\254q\254\136\253\013\254\203\253.\254\170\253\203\253P\254/\254\179\254wwww\179\254\145\254\221\255wwwwwwwwwwww\221\255\156\255P\254Z\255\222\255wwwwwwwwwwwwz\255P\254X\255ww\221\255P\254p\254.\254\013\254\203\253\203\253\236\253\236\253\136\253q\254O\254\236\253\236\253F\253\170\253\137\253\169\253g\253\236\253.\254wwY\255P\254\156\255wwww\221\255\022\255\146\254\146\254\146\254\146\254\179\254\245\254\170\253q\254\179\254\146\254\146\254\145\254\146\2548\255\222\255wwww\022\255p\254\222\255Y\255/\254.\254\170\253g\253\137\253\169\253G\253\236\253\013\2548\255P\254\202\253h\253\004\253&\253\235\220\200\232\136\253z\255q\254\245\254\189\255\212\254q\254q\254\179\254z\255wwwwwwwwwwwwwwwwwwwwwwwwwwY\255\146\254q\254\146\254Z\255\222\255P\2548\255\145\254\203\253\003\249\002\245%\253%\253\136\253\203\253q\254\146\254q\254P\254\236\253'\253\246\176\024\157\027\157\208\188\014\254q\254q\254\179\254\188\255wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\254\255\023\255q\254\145\254\146\254q\254\194\245\192\254\160\254\192\233F\253\236\253P\254q\254\023\255\023\255\023\255\146\2541\209\248\156V\169\025\157\152\140\181\250\222\255wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\246\254\236\249\160\254\237\238@\238`\242\168\237\179\254\023\255\023\255\155\255\155\255Y\255\146\254Q\209\027\157\247\156\251\156\150\132r\254\156\255wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\221\255\179\254\236\249`\246`\246`\246 \226\169\241\180\254z\255\155\255q\254q\254O\254\203\253%\253q\160\152\136\151\128\239\200.\254\146\254q\254\146\254Y\255wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\189\255\212\254q\254\179\254\146\254\146\254c\233 \226\0\214@\221F\253\236\253P\254q\254\246\254/\254\170\253h\253\004\253&\253\009\233\007\241\137\253Z\255\179\254\179\254\222\255\023\255\145\254\145\254\145\254\023\255\222\255wwwwwwwwwwwwwwwwwwwwww\189\255\246\254\146\254q\254\212\254\188\255\188\255P\254z\255p\254\203\253%\253\227\248F\253%\253\136\253\203\253P\254O\254\203\253\236\253g\253\170\253\137\253\169\253h\253\013\254\014\254ww\155\255O\254Y\255wwwwwwZ\255\146\254\146\254\145\254\146\254\146\254\146\254g\253\014\254\146\254\146\254\145\254\146\254\180\254{\255wwwwww\212\254\146\254ww\023\255/\254.\254\202\253g\253\169\253\170\253G\253\237\253\236\253\014\254p\254\137\253\013\254\236\253\014\254\203\253\203\253P\254O\254\146\254wwww\246\254p\254\155\255wwwwwwwwwwwwwwww\212\254\222\255wwwwwwwwwwwwww7\255P\254\155\255ww\188\255q\254q\254.\254\013\254\236\253\236\253\236\253\237\253\136\253q\254q\254\203\253.\254/\254\014\254p\254/\254\013\254.\254\146\254\245\254\246\254wwwwww\212\254q\254Y\255wwwwwwwwwwwwwwwwwwwwwwwwww\023\255q\2548\255wwwwwwO\254\022\255Y\255\203\253p\254p\254\203\253/\254O\254/\254\170\253\236\253p\254\146\254P\254P\254q\254q\254O\254\014\254\155\255q\254\179\254z\255wwwwwwww\023\255q\254\179\254\188\255wwwwwwwwwwwwww\156\255\179\254q\254Y\255wwwwwwwwp\254\188\255P\254\188\255\236\253q\254\146\254P\254O\254p\254\179\254\146\254\212\254\245\254\146\254q\254\145\254\146\254\145\254q\254P\254\212\254\245\254z\255\146\254{\255wwwwwwwwww\222\255\245\254\145\254\146\254q\254F\253\013\254\146\254\146\254\245\254\222\255wwwwwwwwwwq\254\155\255\212\254\155\255\212\254P\254\146\254\179\254p\254q\254P\254p\254\180\254\146\254q\254\179\254\246\2548\255q\254\179\254\146\254\146\254q\254wwP\254wwq\254{\255wwwwwwwwwwwwwwwwww\246\254wwwwwwwwwwwwwwwwww\146\254{\255\221\255\146\254wwq\254\146\254\146\254\022\255p\254\179\254\022\255\245\254\146\254Y\255\022\255q\254q\254\155\255\180\254\212\254\146\254\145\254\213\254\156\255z\255\212\254ww\146\254Y\255wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwq\254z\255wwP\254\254\255\222\255\179\254\146\254q\254Y\255\179\254\022\255\212\254q\254\146\254p\2548\2558\255\146\2547\255\023\255\246\254\145\254\212\254\188\255\146\254ww\180\254\155\255ww\246\254\212\254wwwwwwwwwwwwwwwwwwwwwwwwwwww\156\255p\254\189\255ww\213\254z\255ww\212\254\023\255\023\255\146\254\155\255\212\254\212\254\146\254\212\254\156\2558\255q\254\189\255\212\254\179\254Y\255\022\255\145\254\188\255\213\254q\254wwwwq\254\222\255ww\188\255q\2548\255wwwwwwwwwwwwwwwwwwwwww\212\254\212\254wwww\155\255\180\254wwwwq\254\179\254\222\255\146\254\189\255\212\254\146\254\146\254\222\255\146\254\254\255\146\254\213\254\188\255\146\254z\2557\255\146\254ww\145\254\155\255\245\254wwwwP\254\222\255wwwwY\255\146\254\212\254\188\255wwww\188\255wwww\155\255\179\254\146\254\189\255wwww\189\255q\254wwwwY\255\023\255\146\254ww\146\254\189\255\212\254\146\254\023\255z\255q\254\245\254\155\255\146\254ww\146\254\155\255\246\254\022\255\155\255\146\254wwq\254wwww\222\255p\254\222\255wwwwww\189\255\213\254\146\254\146\254\004\253\237\253\146\254\246\254\222\255wwwwww\188\255\145\254wwwwwwq\254\222\255\179\254\155\255\246\254\156\255\212\254\145\254\222\255\179\254\022\255q\254ww\146\254ww\146\254\189\255\212\254\156\255\245\254\155\255\246\254\156\255\213\254wwwwww\146\254\155\255wwwwwwwwwwww\188\255wwwwwwww!\136!\136Z\255\179\254wwwwwwY\2558\255\213\254\188\255\022\255\155\255\156\255\246\254\146\254ww\146\254ww\146\254ww\146\254ww\145\254ww\146\254ww\146\254ww\146\254ww\179\254\221\255wwwwww\245\254\212\254wwww!\136!\136!\136!\136!\136!\136!\136!\136\0\128!\136!\136wwwwwwwwq\254ww\146\254ww\146\254wwz\255\023\255\146\254ww\146\254ww8\255\188\255\245\254wwq\254ww\146\254ww\146\254ww\246\254\155\255wwq\254wwwwwwww\189\255\146\254\179\254\0\128\0\128\0\128\0\128\0\128\0\128!\136!\136\0\128\0\128!\136wwwwww\179\254\189\255\155\255\246\254ww\146\254ww\022\255{\255\145\254ww\146\254wwww8\255Y\255ww\146\254ww\146\254ww\146\254wwww\146\254ww\155\255\213\254wwwwwwwwww\254\255\023\255\146\254\146\254\004\253\237\253\146\254\023\255ww\0\128!\136wwwwww8\2558\255ww\146\254wwww\146\254ww\179\254\222\255q\254ww\212\254\189\255ww\212\254\189\255wwq\254ww\146\254wwY\2558\255ww\023\255z\255wwY\255\022\255wwwwwwwwwwwwwwww\189\255wwwwwwwwwwwwwwwwz\255\246\254ww\156\255\245\254wwY\2558\255ww\146\254ww\146\254ww\023\255z\255ww\146\254wwww\146\254ww\146\254wwww\146\254wwww\146\254wwwwY\255\245\254wwwwwwwwwwwwwwwwwwwwwwwwwwwwww8\255\022\255wwww\146\254wwww\146\254wwww\145\254wwq\254wwz\255\023\255wwq\254wwww\146\254wwY\2558\255ww\146\254wwww\189\255\212\254wwww\156\255\146\254\188\255wwww\206\185\008\161\008\161\008\161\008\161\008\161\008\161\008\161\181\214\221\255\179\254Y\255wwww\246\254{\255wwww\146\254wwww\146\254ww\146\254ww\221\255\179\254wwq\254wwww\146\254wwww\146\254wwz\255\023\255wwwwY\2558\255wwwwww\213\254\146\254z\255\132\144\0\128\132\144\231\160\008\161\008\161\008\161\198\160\015\234\179\254\222\255wwwwz\255\023\255wwww\022\255{\255ww\155\255\022\255ww\146\254ww\222\255\146\254wwq\254wwww\245\254\156\255ww\146\254wwww\146\254wwwwww7\2558\255wwwwwwww\245\250\0\128\0\128)\193F\253\013\254\145\254\145\254\022\255\254\255wwwwww\155\255\245\254wwwwww\146\254wwww\179\254\254\255ww\146\254wwww\146\254ww\146\254wwwwY\2558\255ww\022\255\155\255wwY\2558\255wwwwwwY\255\212\254wwwwww\181\214\0\128\0\128\247\222\023\255wwwwwwwwwwwwwwY\255\245\254wwwwww\022\255{\255wwww\146\254ww\221\255\212\254wwww\146\254ww\146\254wwww\222\255\179\254wwww\146\254wwww\146\254wwwwwwww\188\255\145\254Y\255ww\016\194\0\128\0\128\189\247wwwwwwwwwwww\189\255\146\2548\255wwwwww\222\255\179\254wwww\156\255\245\254ww8\255Y\255wwww\146\254ww\146\254wwwwww\146\254wwww\179\254\222\255ww\221\255\212\254wwwwwwwwww7\255\146\254\164\160\0\128\0\128\0\128\0\128\0\128\0\128\0\1288\255\146\254\212\254wwwwwwwwww\146\254wwwwww\146\254wwww\146\254wwww\188\255\213\254ww\146\254wwwwww\146\254wwww\221\255\212\254wwww8\255Y\255wwwwwwwwwwww!\136\0\128\132\160(\193\130\196\230\196)\193)\193Y\255wwwwwwwwwwww\022\255{\255wwww\222\255\179\254wwww\146\254wwwwY\2558\255ww\245\254\156\255wwww\023\255z\255wwww\179\254\222\255wwww\023\255z\255wwwwwwww{\239\0\128\0\1281\198ww\156\255wwwwwwwwwwwwwwwwww\023\255Y\255wwwwww\179\254\254\255wwww\146\254wwww\022\255\155\255wwY\2558\255wwwwww\146\254wwwwww\146\254wwwwww\023\255\023\255wwwwww\181\214\0\128\0\128\247\222wwwwwwwwwwwwwwwwwwww\179\254z\255wwwwww\155\255\022\255wwwwz\255\023\255wwww\179\254\222\255ww\254\255\146\254wwwwww\146\254wwwwww8\255X\255wwwwwwz\255\146\254\188\255ww\016\194\0\128\0\128wwwwwwwwwwwwwwwwww\023\255\146\254\222\255wwwwwwww\146\254wwwwww\146\254wwwwww\146\254wwwwww\145\254wwwwwwY\2558\255wwwwww\245\254\188\255wwwwwwww\213\254\146\254\165\160\0\128B\136\016\194\016\194\206\193\016\194\016\194\247\222z\255\146\254q\254z\255wwwwwwwwww\179\254\222\255wwwwww\146\254wwwwww\146\254wwwwww\146\254wwwwwwww\146\254wwwwwwww\179\254\222\255wwwwwwwwww!\136\0\128\0\128\0\128\0\128\0\128\0\128\0\128)\193\023\255\222\255wwwwwwwwwwww\022\255{\255wwwwww7\255Y\255wwww\222\255\179\254wwwwww\213\254\188\255wwwwww8\255Y\255wwwwwwww\179\254\221\255wwwwwwwwwwwwwwwwww\155\255wwwwwwwwwwwwwwwwwwww\246\254{\255wwwwwwww\146\254wwwwww\023\255z\255wwwwww\222\255\179\254wwwwwwww\146\254wwwwwwwwww\212\254Y\255wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\179\254\155\255wwwwwwww{\255\022\255wwwwww\146\254wwwwwwwwww\146\254wwwwwwww\155\255\246\254wwwwwwwwww8\255\179\254\222\255wwwwwwwwwwwwwwwwwwwwwwwwwwww8\255\146\254\222\255wwwwwwwwww\146\254wwwwwwww\146\254wwwwwwwwww\022\255\155\255wwwwwwww\212\254\189\255wwwwwwwwww\222\255\179\254\179\254\189\255wwwwwwwwwwwwwwwwwwww\246\254q\254Y\255wwwwwwwwwwww\245\254\156\255wwwwww\246\254\155\255wwww")
icon[4]	= image.new("\048\0\0\0\048\0\0\0\0\0\0\0\096\0\0\0\016\0\001\000wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\147\2060\198\0\128\230\156\246\218wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\023\223\198\156\0\1283\162\175\141\165\140\147\206wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\139\177\0\128\249\178\255\199\223\195\183\170\140\1658\231wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwQ\198\0\128\017\154\255\199\191\191\191\191\223\195u\166\172\181wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww)\169\0\128\092\183\223\195\158\183\158\183\191\191]\183J\145wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128\0\128wwwwwwwwwwwwwwQ\198\0\128\175\141\223\195\191\187\158\183\158\183\191\187\191\191T\166(\173wwwwwwwwwwwwwwww\014\202\0\128\192\164wwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\132\140J\145\009\129\0\128\0\128\164\1520\198wwwwwwww\015\194\0\128\183\170\223\195\158\187\158\183\158\183\158\187\223\191\026\183c\128wwwwwwwwwwww\0\128k\173\207\177n\133\142\165\139\177wwwwwwwwwwwwwwwwwwwwwwwwww\132\148R\178\255\227\255\2279\199\238\1570\182\213\214\147\206k\169wwww)\169\0\128\092\183\223\191\158\183\158\183\158\187\158\183\191\191]\183\173\157wwwwwwww\238\189k\169N\129\211\129X\134\253\162\154\154,\129\0\136wwwwwwwwwwwwwwwwwwwwww\0\128)\161z\207\255\231\255\223\255\227\255\223\255\219z\207\198\128\0\128\238\189\023\223\0\136l\133\158\191\191\191\158\183\158\187\158\187\158\183\191\187\191\191\017\162\0\128ww(\173d\136N\129\244\129\187\154\030\167\253\162\220\158?\171\210\137\0\128wwwwwwwwwwwwwwwwwwwwww\0\128k\165z\207\255\227\254\215\254\215\255\219\255\223\255\2279\199\172\157\173\169\231\148\0\128\018\158\223\195\159\187\158\183\158\187\158\187\158\183\159\187\223\195u\166\0\136\172\181\142\153\244\129\187\154\030\167\221\158\187\154\187\154\220\158\253\162o\129\0\128wwwwwwwwwwwwwwwwwwwwwwww\198\156\247\194\255\227\254\215\254\215\254\215\254\215\255\219\255\223\255\223\254\219\206\165\0\128\207\153\255\199\223\191\158\183\158\187\158\187\158\183\191\191\223\195T\166d\136\244\145\187\150\030\163\253\158\187\154\187\154\188\154\187\154\253\158\187\162\233\128\0\128wwwwwwwwwwwwwwwwwwwwwwww\0\1320\170\255\227\255\219\254\215\254\215\255\215\254\215\255\215\255\223\255\231R\178\0\128\233\128\018\158\158\187\223\195\158\187\158\187\223\191\158\191u\166\167\128\235\128\253\162\030\163\187\154\187\154\188\154\188\154\188\154\187\154\254\162\022\138\0\128(\169wwwwwwwwwwwwwwwwwwwwwwww\165\160\231\140\156\211\255\223\254\215\254\215\254\215\254\215\254\215\255\219\255\223\140\161\0\128\249\178\018\158m\129;\183\223\195\223\195\092\183\175\141\178\1296\146N\129\154\154\220\158\188\154\188\154\188\154\188\154\188\154\220\158\220\158\144\129\230\156k\173wwwwwwwwwwwwwwwwwwwwwwwwww\0\128\148\182\255\227\255\219\254\215\254\215\254\215\254\215\255\223\254\219\133\128\0\128\191\195\255\199T\158\175\141;\183\249\178m\129\178\129\253\162\220\162-\1296\146\254\162\187\154\188\154\188\154\220\154\187\154\253\162\221\1583\162r\206wwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128c\128\156\211\255\227\254\215\255\215\254\215\254\215\255\223\156\211\0\128\011\129\191\195\191\195\255\199\026\183\0\128\002\128X\150\030\167\253\162\187\162N\1296\146\254\162\187\154\188\154\188\154\220\154\221\158\220\162\244\145*\137wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\1280\170\255\227\255\219\254\215\255\215\254\219\255\227\156\211\0\128n\137\255\199\255\199\158\1913\162\177\129\210\137V\154\252\162\030\167\253\162o\129\244\145\030\167\220\158\220\158\187\154\220\158\154\154n\129\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwI\173\0\1289\203\255\231\255\223\255\223\255\219\255\223z\207\0\128m\129\158\191\092\183\167\128\0\128\022\130\022\130%\128-\129y\146y\146\235\128o\129\188\142\154\130\187\150\220\154\030\163\187\162\167\128\0\128\199\148wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww8\231\007\165*\141z\2079\199\246\190\148\182\246\190R\178\0\1281\182s\182\0\128\205\177\214\202\181\190\181\190\214\202\238\173*\1419\2031\182\167\128\215\1823\162\177\129\211\129X\150\244\145\0\128\238\189\181\210wwwwwwwwwwwwwwwwwwwwwwwwwwww(\173\0\128\139\177\205\177\0\128\140\161z\215z\219z\215\254\235\023\207\0\128\205\177\231\148R\190\255\243\255\243\255\239\255\239\255\243\255\239\180\198\180\202\023\207\238\173\255\239\253\231z\219\155\223\214\202\0\128\132\140Q\194B\136\0\128wwwwwwwwwwwwwwwwwwwwww\164\152)\161R\190\246\206\155\223\254\2350\182\0\128\221\231\255\247\255\239\255\247Y\215\0\128\0\128\213\198\255\243\255\239\255\235\255\239\255\239\255\239\255\239\255\239\214\202c\128\173\169\255\243\255\243\255\243\255\247\238\173\0\128\155\223\254\235Y\215\246\206R\190B\128\0\128wwwwwwwwwwwwk\173\197\148\213\198\220\227\255\235\255\243\255\239\255\243\255\235\230\132)\153\255\239\255\243\255\243\180\198\0\128\016\182\255\243\255\239\255\235\255\239Y\231Y\215\255\235\255\239\255\239\255\243\016\182\0\128\221\231\255\243\255\243\213\198\0\128\023\207\255\243\255\239\255\243\255\239\255\235z\219\213\198Q\194\147\214wwwwww\173\181\205\177\188\227\255\239\255\239\255\235\255\235\255\235\254\231\255\243\155\223\0\128\016\182\255\247\188\227\001\128\0\1288\211\255\243\255\239\188\235\206\233C\232\0\216\140\193\220\227\255\239\255\243\221\227\0\128\238\173\255\247\155\223\0\128\015\178\255\243\255\235\254\231\255\235\255\235\255\235\255\239\255\239\221\227\180\202\015\194wwk\173\140\165\221\231\255\243\255\235\254\231\254\231\254\231\254\231\254\231\255\235\255\243\213\198\0\128Q\186k\161\0\128\0\1288\211\255\243\255\235\173\209\0\240D\240\0\240\0\204\015\178\255\239\255\243\188\227)\153\205\177\147\194\231\140\231\148\255\235\255\239\254\231\255\231\254\231\254\231\254\231\255\235\255\235\255\239\255\235R\190(\169\0\128\023\207\255\247\255\235\254\231\255\231\255\231\255\231\254\231\255\235\254\231\255\239\255\2431\182\0\128\173\173\173\173\0\128z\219\255\247\221\227\132\196\0\240\133\244\133\244\0\216\132\128\254\231\255\247z\215\238\173\188\227\165\132\0\128\254\231\255\243\254\231\255\235\254\231\255\231\255\231\255\231\254\231\254\231\255\235\255\247\214\202\015\194\0\128\147\194\255\247\255\239\255\235\254\231\254\231\254\231\254\231\255\231\254\231\255\239\255\235\140\165\0\128k\165J\157\0\128z\219\255\247\254\231\165\160\0\216d\244C\232\0\164\230\132\254\235\255\243\155\223\173\169\016\182\132\128k\161Y\215\255\243\255\235\255\231\255\231\254\231\254\231\254\231\254\231\255\235\255\243\255\243\016\178\173\181\172\181\132\140\214\202\255\243\255\243\255\239\255\235\255\235\254\231\254\231\255\239\255\239\140\161\0\128\246\206\016\182\0\128\0\128\155\223\255\243\255\239Q\186\0\128\0\164\0\128\0\128\213\198\255\239\255\243\253\231\0\128\0\128Y\215\220\227\140\161\155\223\255\239\254\231\254\231\255\235\255\235\255\235\255\239\255\239\255\235Q\186\0\128k\173ww\015\194\007\161\238\173\023\207\254\231\255\243\255\243\255\239\255\239\255\2431\182\0\128\016\182\255\247\255\235\231\148\0\128z\219\255\247\255\239\255\235\214\202k\149J\145\213\198\255\235\255\239\255\243\213\198\0\128\147\194\255\243\255\243\214\202\238\173\255\235\255\239\255\235\255\239\255\239\255\243\221\227\180\198\132\128\0\128k\173wwwwww\213\214\132\148\0\128\198\128Q\186Y\215\254\231\255\2478\215\0\128\140\165\255\239\255\247\255\247R\190\0\128)\153\188\227\255\243\255\239\255\239\255\239\255\239\255\239\255\239\255\243\023\207\0\128J\157\255\243\255\243\255\239\255\243\214\202\023\207\255\247\255\243\023\207\016\1780\182\180\198\016\190\0\128\206\181wwwwwwwwwwww0\198\0\132\0\128\0\128\165\1320\182c\128\0\1288\215\255\239\255\243\255\247R\190\0\128\0\128\199\136z\219\255\243\255\243\255\243\255\243\255\243\255\247Y\215)\153k\161Q\186\255\247\255\243\255\235\254\235Y\215k\161\016\182Q\186\0\128\0\128\0\128\213\214Y\231wwwwwwwwwwwwwwwwwwww)\165\0\132c\144\0\128\0\128\0\128\0\128\197\148\172\1730\182)\161\0\128)\161\0\128\0\128\246\206\188\227z\219z\219\188\2278\211\0\128\172\173\180\198\165\140\238\173\140\165)\153\0\128\0\128\0\128\0\128\0\128\173\181\206\181\147\206wwwwwwwwwwwwwwwwwwwwwwwwwwww\147\206\0\136\201\128V\154\144\129\137\128\008\128\008\128\002\128\0\128\0\128B\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128B\128\0\128\0\128B\128\009\129*\137\173\157R\1789\199s\182\173\181Y\231\023\223wwwwwwwwwwwwwwwwwwwwwwwwwwwwww\007\161\0\128\153\158?\171\253\162\253\166\253\166\030\1715\154\0\128\011\129\153\162x\158\201\128\0\128\167\128\011\129\009\129u\166;\183\026\183n\137\206\165\255\227\255\227\255\227\255\227\255\227\255\231\254\219\140\165\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwww\007\161\0\128o\129\253\166\220\158\188\154\220\158\220\158\030\167x\158\0\128n\133?\171\030\171\253\166n\137\0\128\134\128;\191\255\203\255\203\255\199\208\145s\182\255\231\255\219\255\219\255\219\255\219\254\215\255\227\247\194\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwww(\169\001\128\154\154\253\162\187\154\188\154\188\154\187\154\253\162x\158\0\128\011\129\253\166\030\167\154\154o\129\133\128\0\128m\145;\183\255\199\191\195m\129\148\182\255\227\254\215\254\215\254\215\254\215\254\215\255\223\255\219\206\165\172\181wwwwwwwwwwwwwwwwwwwwwwwwww\139\177c\144\178\129\030\167\220\154\188\154\188\154\188\154\187\154\253\162x\158\0\128\167\128\253\166y\146\201\128T\166}\191\017\162\0\128\0\128\215\182}\191l\133\024\199\255\227\254\215\254\215\254\215\254\215\255\215\254\215\255\227\024\199k\169wwwwwwwwwwwwwwwwwwwwwwwwwwi\177\167\128\154\154\253\162\187\154\220\154\188\154\188\154\187\154\253\158\153\158%\128\0\128\177\129\144\129\183\170\191\195\223\195\191\195\183\170\0\128\0\128\009\129J\145\221\219\255\227\254\215\254\215\255\215\254\215\254\215\254\215\255\223\255\219\140\161\0\128wwwwwwwwwwwwwwwwwwwwwwww\0\128\144\129\253\162\220\158\188\154\188\154\188\154\188\154\187\154\030\167\253\162\201\128\0\128\207\153\092\183\223\195\159\187\158\187\191\191\223\195\026\183\009\129\0\128\0\128\246\190\255\227\255\227\255\219\254\215\254\215\255\215\254\215\255\219\255\2270\170\0\128wwwwwwwwwwwwwwwwwwwwwwww\0\1285\154\030\163\187\154\188\154\188\154\187\154\220\158\254\162\187\154V\154\134\128\0\128\026\183\255\203\159\187\158\183\158\187\158\183\158\187\223\195}\191\142\153\0\128\0\128\173\157\156\211\255\227\255\227\255\219\254\215\254\215\254\215\255\227\181\190\197\148wwwwwwwwwwwwwwwwwwwwwwww\0\128\153\158\030\163\187\154\220\154\220\158\254\162\220\154X\134n\137k\169\173\181\0\128\018\158;\183\159\187\158\187\158\183\158\187\158\183\191\191\223\195\207\153\007\165\172\181\0\128\0\1280\170\156\211\255\227\255\227\255\223\255\223\255\231\148\182\173\181Y\235wwwwwwwwwwwwwwwwwwwwww\0\1286\146\031\163\253\158\253\158\220\154X\134\177\141J\157\194\160\022\227Q\198\0\128\0\128T\166\191\191\159\187\158\183\158\187\158\187\223\191;\183J\157\147\214ww\147\206(\169\0\128\0\1280\170z\207\254\219\255\227\221\219\133\128\172\181\254\251wwwwwwwwwwwwwwwwwwwwww)\169m\153\244\129x\158\211\129\175\141\173\173\228\164wwwwww\206\181\0\128\0\128\026\183\223\195\158\187\158\183\158\183\159\187\223\191u\166\0\128wwwwww\155\235Q\198\198\156\0\128\0\128\133\128*\141\0\128\0\128\173\181wwwwwwwwwwwwwwwwwwwwwwwwww\0\128B\136\206\181\198\156\0\128wwwwwwwwwwww\015\194\016\178\092\183\191\191\158\187\158\187\158\183\191\191\158\187L\129\165\160wwwwwwwwwwwwk\173\165\152)\169\172\181\139\177\015\194\016\190wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwY\2358\215\017\162]\183\191\191\158\183\158\187\223\195\250\174\0\128\164\152wwwwwwwwwwwwwwwwww\254\251\155\243wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\205\177\0\128u\166\223\195\158\187\191\191\191\195n\129\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\206\181\0\128\0\128}\191\255\199\255\199\183\170\0\128Q\198wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\173\181\0\128L\129}\191;\183\0\128(\169wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\246\218\172\181\0\128\0\128\0\128\007\165\180\210wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\139\177\238\1890\198\246\218wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww")
icon[5]	= image.new("\048\0\0\0\048\0\0\0\0\0\0\0\096\0\0\0\016\0\001\000wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\181\2141\198wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\181\2141\198wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\181\2141\198wwwwww)\165k\173wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\148\2101\198wwww9\231\198\152\198\152{\239wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\181\214R\202wwww\140\177\231\156\198\152\239\189wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\173\181\008\161ww\222\251\008\161R\2021\198\008\161wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\189\247\247\222\024\227wwwwwwwwwwwwwwwwwwwwwwwwZ\235\231\156\198\152\247\222ww\189\247wwww\189\247wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww1\198\231\156J\169\206\185wwwwwwwwwwwwwwwwwwwwZ\235\008\161\156\243ww\008\161\247\222ww\222\251wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwR\202\008\161J\169R\202wwwwwwwwwwwwwwwwwwZ\235\008\161\156\243wwww\222\251)\165\214\218wwwwwwwwwwwwww\156\243\148\210\181\214\222\251wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww1\198\231\156k\173\173\181wwwwwwwwwwwwwwwwZ\235\008\161\156\243wwwwwwwwww)\165\214\218wwwwwwwwwwww1\198\231\156k\173\140\177wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\214\218\214\218ww\239\189\148\210s\206wwwwwwwwww9\231\231\156\156\243wwwwwwwwwwww\222\251\008\161\214\218wwwwwwwwwwR\202\231\156)\165s\206wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww9\231\239\189wwww\156\243J\169\148\210J\169{\239wwwwwwwwwwwwwwww\222\251k\173s\206J\1699\231wwww\016\194\231\156\173\181k\173\222\251\156\243wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\247\222\206\185ww\189\247)\165\148\210\198\152\181\214wwwwwwwwwwwwwwwwwwww\024\227\132\144\181\214)\1659\231ww\247\222\247\222ww\016\194\024\227\140\177Z\235wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\189\247\008\161\024\227wws\206k\173wwwwwwwwwwwwwwwwwwww\206\185\239\189ww{\239\008\1619\231wwwwwwwwZ\235\008\1619\231wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\156\243\008\161\024\227ww\214\218J\169\222\251wwwwwwwwwwwwwwwwwwwwwwk\173R\202ww{\239\008\1619\231wwwwww9\231\214\218\222\251wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww{\239)\1659\231ww\214\218)\165\222\251wwwwwwwwwwwwwwwwwwwwwwwwwwJ\169R\202ww\156\243J\1699\231wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\214\218)\165ww\247\222)\165\222\251wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwJ\169s\206wwk\173\148\210wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww{\239\165\148\008\161J\169\222\251wwwwwwwwwwwwww\156\243\156\243wwwwwwwwwwwwwwww\140\177\008\161\165\148\024\227wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwZ\235\008\161\156\243\247\222\156\243wwwwwwwwwwwwR\202J\169)\165J\169)\165\016\194wwwwwwwwwwww\222\251\214\218\222\251)\165\214\218wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwZ\235\008\161\156\243wwwwwwwwwwwwwwww\140\177\206\185\156\243wwww\189\2471\198)\165\189\247wwwwwwwwwwwwww\222\251\008\161\214\218wwwwwwwwwwwwwwwwwwwwZ\235\214\218Z\235wwwwwwwwZ\235\008\161\156\243wwwwwwwwwwwwwwww\206\185\173\181wwwwZ\235\222\251wwww\214\218k\173wwwwwwwwwwwwwwwwww)\165\214\218wwwwwwww{\239\214\218Z\235wwww\198\152k\173\008\1611\198wwww9\231\008\161\156\243wwwwwwwwwwwwwwww\024\227\016\194\140\1771\198\189\247c\140\189\247ww\222\251ww\016\194\181\214wwwwwwwwwwwwwwww\222\251)\165\214\218wwwwww)\165)\165\198\152\247\222ww\231\156\156\243\222\251c\140ww9\231)\165\189\247wwwwwwwwwwwwwwwwwwR\2029\231\247\222)\1651\198k\173wwwwwwwwZ\235\016\194wwwwwwwwwwwwwwwwwwwwJ\169\214\218wwwwJ\169J\169\198\152\024\227ww\165\148s\206\239\189J\169\148\210\0\128k\173\239\189\140\177\173\181\173\181\173\181\173\181\173\181\173\181\173\181\173\181\231\156{\239ww\165\148\0\1289\231ww\222\251wwww\222\251\008\161\173\181\173\181\173\181\173\181\173\181\173\181\173\181\173\181\140\177\206\185\173\181\0\128\206\185ww\231\156\206\185\008\161\016\194ww1\198\140\177\239\189\189\247\189\247\140\177)\165\156\243{\239Z\235{\239{\239{\239{\239{\239Z\235\189\247\239\189\024\227ww\148\210\173\181ww\214\2181\198{\239ww{\239\173\181\156\243{\239{\239{\239{\239{\239{\239{\239{\239\189\247\140\177k\173Z\235wwR\202\140\177\239\189\156\243wwwwwwwwwwwwww1\198\173\181wwwwwwwwwwwwwwwwww\214\2181\198wwwwwwww\206\185\148\210R\202ww\148\210s\206wwwwwwwwwwwwwwwwww1\198\206\185wwwwwwwwwwwwwwwwwwwwwwwwwwwwww1\198\140\177wwwwwwwwwwwwwwwwwwJ\169{\239ww\222\251ww\024\227\239\1899\231wwJ\169\189\247wwwwwwwwwwwwwwww\239\189\173\181wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww1\198\140\177wwwwwwwwwwwwwwwwZ\235\008\161\024\227wwwwwwww\156\243\008\161\247\222wwwwwwwwwwwwwwww\239\189\173\181wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\016\194k\173wwwwwwwwwwwwwwwwZ\235J\169k\173\016\194\016\194\140\177\008\161\024\227wwwwwwwwwwww\222\251ww\206\185\173\181wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwR\202\140\177\008\161\239\189wwwwwwwwwwwwww\024\227R\202R\202\247\222wwwwwwwwwwwwwws\206\231\156\140\177\016\194wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\156\243\198\1529\231\239\189\239\189wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwR\202\140\177\156\243\231\156\024\227wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\214\218)\165wwww\206\185\239\189wwwwwwwwwwwwwwwwwwwwwwwwwwwwR\202k\173wwww\140\177R\202wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\148\210)\165wwww\173\181\239\189wwwwwwwwwwwwwwwwwwwwwwwwR\202k\173wwww\140\1771\198wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\156\243\156\243wwww\148\210J\169wwww\239\189\239\189wwwwwwwwwwwwwwwwwwwwR\202\140\177wwww\140\1771\198ww\156\243{\239wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\181\214\198\152J\169\239\189wwww\148\210J\169ww\173\181\016\194wwwwwwwwwwwwwwwwwwww\181\214)\165ww\140\177\016\194wwZ\235\165\148k\173k\173wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\148\210\008\161\206\185\140\177ww\222\251ww\181\214\198\152)\165\239\189wwwwwwwwwwwwwwwwwwww1\198)\165\198\1521\198wwww9\231\165\148\016\194\008\161wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\148\210\132\144\231\156\239\189wwwwwwww{\239ww1\198k\173wwwwwwwwwwwwwwww\239\189\173\181ww\156\243wwwwwwZ\235c\140)\165J\169wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\214\218\016\194ww)\165\214\2181\198\156\243wwwwwwww1\198\140\177wwwwwwwwwwww\239\189\173\181wwwwwwwwwwww{\239\140\177wwJ\169\181\214\156\243\222\251wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\156\243k\173{\239wwwwwwwwww1\198\140\177wwwwwwww\239\189\206\185wwwwwwwwwwwwwwwwwwwwww\016\194\198\152wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwws\206\173\181wwwwwwwwwwwwww1\198\140\177wwww\239\189\206\185wwwwwwwwwwwwwwwwwwwwwwww\181\214\016\194\222\251wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww1\198\173\181\239\189\206\185wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\231\156c\140wwww\189\247\206\185k\173\024\227wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\148\2101\198wwwwJ\169\173\181Z\235Z\235wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\181\2141\198wwww\165\1489\231wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\181\2141\198wwww1\198\231\156\016\194\214\218wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\181\2141\198wwwwww\024\227\148\210\189\247wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\181\2141\198wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\181\2141\198wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww")
icon[7]	= image.new("\048\0\0\0\048\0\0\0\0\0\0\0\096\0\0\0\016\0\001\000wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww!\132wwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128wwwwwwwwww\0\128B\136wwwwwwwwB\136\132\144\132\144wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww!\132B\136B\136c\140wwwwwwB\136\132\144c\140\165\148wwwwwwc\140\008\161\0\128!\132wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128!\132!\132wwwwc\140\132\144wwww\132\144wwwwc\140wwww\165\148\132\144wwwwB\136!\132\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\198\152c\140ww\132\144B\136wwww\132\144!\132wwc\140wwwwwwww\0\128wwwwwwwwww\0\128ww\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwc\140c\140B\136wwwwwwwwc\140c\140\0\128wwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128wwwwwwwwc\140\0\128wwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww!\132wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128\0\128\0\128\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwc\140\198\152c\140wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128\0\128ww\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128\0\128wwwwwwwwwwwwwwwwww\231\156c\140wwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128wwww\0\128\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128\0\128wwwwwwww)\165\239\189\198\152\0\128J\169\016\194)\165wwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128wwww\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128\0\128wwwwwwwws\206\206\185\165\148c\140)\165\239\189\016\194wwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128\0\128ww\0\128\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128wwwwwwwwww\239\189wwww!\132wwww\165\148wwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128\0\128\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128wwwwwwwwwwc\140wwww\0\128wwwwc\140wwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128\0\128\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128\0\128wwwwwwwwww1\198\206\185\165\148B\136J\169\239\189\016\194wwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128ww\0\128\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128\0\128wwwwwwwwwwR\202\016\194B\136c\140c\140\206\185)\165wwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128wwww\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128\0\128wwwwwwww1\198\0\128wwww\0\128wwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128\0\128wwww\0\128\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128wwwwwwwwwwww\016\194\239\189\198\152!\132k\173\206\185\206\185wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128\0\128\0\128\0\128\0\128wwwwwws\206\239\189c\140c\140\231\156\206\185\140\177wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\016\194\0\128wwww\0\128wwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\173\181\206\185\198\152\0\128k\173\206\185\140\177wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\148\210\239\189\132\144\132\144\008\161\206\185\239\189wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128\0\128\0\128\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwww\132\144wwww\0\128wwwwB\136wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128\0\128wwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwww\140\177\239\189\198\152\0\128\140\177\206\185\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\016\194\016\194\231\156B\136J\169k\173wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\132\144k\173)\165\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwww\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\008\161wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128ww\0\128\0\128ww\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwk\173\132\144wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128ww\0\128\0\128ww\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128ww\0\128\0\128ww\0\128\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128ww\0\128\0\128wwww\0\128\0\128\0\128\0\128\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128ww\0\128\0\128wwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128wwwwwwwwwwwwwwwwwwwwww\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128ww\0\128!\132c\140\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128ww\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128wwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128wwww!\132wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww")
icon[8]	= image.new("\048\0\0\0\048\0\0\0\0\0\0\0\096\0\0\0\016\0\001\000wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwww\0\128\0\128\0\128wwwwwwww\0\128\0\128wwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128wwwwww\0\128\0\128wwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128wwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128wwww\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128wwwwwwwwwwwwwwwwwwwwww\0\128\0\128\0\128ww\0\128wwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128wwwwwwwwwwwwwwwwwwww\0\128\0\128\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwww\0\128\0\128\0\128\0\128wwwwwwwwwwwwwwwwwwwwww\0\128\0\128\0\128ww\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128wwwwwwwwwwwwwwwwwwwwww\0\128\0\128wwwwwwwwwwwwwwwwwwwwww\0\128\0\128wwwwwwww\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128wwwwww\0\128\0\128wwwwwwwwwwwwww\0\128\0\128wwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwww\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwww\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128ww\0\128\0\128wwwwww\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128ww\0\128\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128ww\0\128\0\128\0\128wwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128\0\128ww\0\128\0\128\0\128wwwwwwwwwwwwwwwwwwww\0\128\0\128wwww\0\128\0\128\0\128\0\128\0\128\0\128\0\128wwwwww\0\128ww\0\128ww\0\128wwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128ww\0\128\0\128wwwwwwwwwwwwwwwwwwww\0\128\0\128\0\128ww\0\128\0\128wwwwwwwwww\0\128wwwwwwww\0\128ww\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128ww\0\128\0\128wwwwwwwwwwwwwwwwww\0\128\0\128\0\128\0\128ww\0\128\0\128wwwwwwwwww\0\128\0\128wwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128ww\0\128\0\128wwwwwwwwwwwwwwwwww\0\128\0\128\0\128\0\128ww\0\128\0\128wwwwwwwwww\0\128\0\128\0\128wwwwww\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128ww\0\128\0\128\0\128\0\128\0\128wwwwwwwwwwww\0\128\0\128wwww\0\128ww\0\128\0\128wwwwwwwwwwww\0\128\0\128\0\128\0\128\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwww\0\128wwwwww\0\128\0\128ww\0\128\0\128\0\128\0\128wwwwwwwwww\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128\0\128wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww")
icon[9]	= image.new("\048\0\0\0\048\0\0\0\0\0\0\0\096\0\0\0\016\0\001\000wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\156\243\156\243\156\243\189\247\222\251\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\222\247\189\247\156\247\189\247\222\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\221\251\189\247\157\243}\239\181\214\148\210\181\214\181\214\024\227\222\251ww\222\251\222\251\222\251\222\251\222\251\222\251\222\251\222\251\222\251\222\251\222\251\222\251\222\251\255\251\156\247\247\242\181\238\148\230\181\238\214\242\156\247ww\222\251\222\251\222\251\222\251\222\251\222\251\222\251\222\251\222\251\222\251\222\251\222\251\222\251\254\255\254\255?\231\223\214\189\210\156\210ww\189\247wwww9\231\214\218\221\251wwwwwwwwwwwwwwwwwwwwwwwwww9\251\214\246|\251ww\156\243\222\255\156\255\215\246\024\247wwwwwwwwwwwwwwwwwwwwwwwwww\223\251\223\214?\227ww\222\251\156\247ww\156\243\222\251wwww\189\247\148\210\156\243wwwwwwwwwwwwwwwwwwwwww\214\246\025\247wwwwww\156\243wwwwwwZ\251\181\242wwwwwwwwwwwwwwwwwwwwww\191\247\191\206\191\243wwww\222\251\156\243ww\156\243\222\251wwwwwwww\181\214\156\243wwwwwwwwwwwwwwwwww\182\242Z\251wwwwwwww\156\243wwwwwwww\156\251\181\242wwwwwwwwwwwwwwwwww\223\247\191\210\223\251wwwwww\222\251\156\243ww\156\243\222\251wwwwwwwwww\148\210\189\247wwwwwwwwwwwwww\247\246Z\251wwwwwwwwww\156\243wwwwwwwwww{\251\182\242wwwwwwwwwwwwwwww\191\210\223\247wwwwwwww\222\251\156\243ww\156\243\222\251wwwwwwwwww\222\251\181\214wwwwwwwwwwww9\247\024\247wwwwwwwwwwww\156\243wwwwwwwwwwwwZ\251\024\247wwwwwwwwwwww\223\218\159\243wwwwwwwwww\222\251\156\243ww\156\243\222\251wwwwwwwwwwww{\239\247\222wwwwwwww\156\251\182\242wwwwwwwwwwwwww\156\243wwwwwwwwwwwwww\247\246{\251wwwwwwww?\231?\227wwwwwwwwwwww\222\251\156\243ww\156\243\222\251wwwwwwwwwwwwww\247\222{\239wwwwww\181\242\222\255wwwwwwwwwwwwww\156\243wwwwwwwwwwwwwwww\149\242\222\255wwww\191\247\223\214wwwwwwwwwwwwww\222\251\156\243ww\156\243\222\251wwwwwwwwwwwwwwww\181\214\222\251ww\024\247Z\251wwwwwwwwwwwwwwww\156\243wwwwwwwwwwwwwwww\156\251\214\246wwww\223\214\191\247wwwwwwwwwwwwww\222\251\156\243ww\156\243\222\251wwwwwwwwwwwwwwww{\243\024\227\189\255\214\246wwwwwwwwwwwwwwwwww\156\243wwwwwwwwwwwwwwwwww\248\246\155\255\127\235?\231wwwwwwwwwwwwwwww\222\251\156\243\222\251{\239\189\247\222\251\222\251\222\251\222\251\222\251\222\251\222\251\222\251ww\215\218R\230\156\251\255\251\222\251\222\251\222\251\222\251\222\251\222\251\222\251\222\251{\239\222\251\222\251\222\251\222\251\222\251\222\251\222\251\222\251\222\251\189\251t\238\190\210\190\247\222\251\222\251\222\251\222\251\222\251\222\251\222\251\222\251\156\243Z\235\189\247Z\235\156\243\189\247\189\247\189\247\189\247\189\247\189\247\189\247\156\247\222\247\024\239\207\209\222\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247Z\235\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\222\251x\218\183\230\222\251\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\156\243Z\235ww\156\243wwwwwwwwwwwwwwwwwwww\247\250\247\226{\239wwwwwwwwwwwwwwwwww\189\247wwwwwwwwwwwwwwwwww\223\247\255\218\214\246\222\255wwwwwwwwwwwwwwww\222\251\156\243ww\156\243\222\251wwwwwwwwwwwwwwww9\247Z\251ww\181\214wwwwwwwwwwwwwwwwww\156\243wwwwwwwwwwwwwwwwww\223\218\191\247\155\255\248\246wwwwwwwwwwwwwwww\222\251|\243ww\156\243\222\251wwwwwwwwwwwwww\222\255\182\242wwww9\231Z\235wwwwwwwwwwwwwwww\156\243wwwwwwwwwwwwwwww\159\243\255\218wwww\214\246\189\255wwwwwwwwwwwwww\222\251\156\243ww\156\243\222\251wwwwwwwwwwwwww\024\247{\251wwwwww\181\214wwwwwwwwwwwwwwww\156\243wwwwwwwwwwwwwwww\223\218\191\247wwww\156\251\247\246wwwwwwwwwwwwww\222\251\156\243ww\156\243\222\251wwwwwwwwwwww\222\255\182\242wwwwwwwwZ\2359\231wwwwwwwwwwwwww\156\243wwwwwwwwwwwwww\159\239\031\223wwwwwwww\215\246\157\251wwwwwwwwwwww\222\251\156\243ww\156\243\222\251wwwwwwwwwwww\024\247{\251wwwwwwwwww\181\214\222\251wwwwwwwwwwww\156\243wwwwwwwwwwwwww\223\214\223\251wwwwwwww\157\251\215\246wwwwwwwwwwww\222\251\156\243ww\156\243\222\251wwwwwwwwww\190\255\214\242wwwwwwwwwwwwZ\2359\231wwwwwwwwwwww\156\243wwwwwwwwwwww\127\239\031\223wwwwwwwwwwww\247\246\156\251wwwwwwwwww\222\251\156\243ww\156\243\222\251wwwwwwwwww\247\246{\251wwwwwwwwwwwwww\181\214wwwwwwwwwwww\156\243wwwwwwwwwwww\223\214\223\247wwwwwwwwwwww\157\251\214\246wwwwwwwwww\222\251\156\243ww\156\243wwwwwwwwww\222\255\214\246wwwwwwwwwwwwwwww{\239s\206wwwwwwwwww\189\247wwwwwwwwww\159\239?\227wwwwww\189\247\156\243wwwwww\248\246\157\255wwwwwwwwww\156\243\189\247Z\235\156\243\189\247\156\243\156\243\189\247\214\234\024\239\189\247\156\243\156\243\156\243\156\243\156\243\156\243\156\243\189\247\239\189Z\235\190\251\189\247\156\243\156\2439\231\156\243\156\243\156\243\156\243\188\247\156\206\092\235\188\247\156\243\189\247\025\231\247\222\189\247\156\243\189\2439\239\149\234\189\243\156\243\156\243\156\243{\2399\231\155\239\021\215W\223y\231\189\247\222\251|\247\181\238\222\251\189\247\222\251\221\247\222\251\222\251\222\251\189\247\222\251\221\247X\231y\235\187\239\155\239\222\251\189\247Z\235\221\247\222\251\190\247\222\251^\231\254\222\254\255\190\247\222\251\189\247Y\231Y\231\188\247\155\243\189\247\222\251\214\238{\247\222\251\189\251\222\251\156\243{\239\220\243\018\211\152\231\254\251wwww\024\247|\251wwwwwwwwwwwwwwwwww\187\239v\223u\219\152\231\220\243wwww\156\243wwwwwwww\255\218\223\251wwwwww\219\243\153\231\153\231\151\227\186\235wwww\189\255\247\246wwwwww\222\251\156\243ww{\239\222\251wwww\189\255\214\242wwwwwwwwwwwwwwwwwwww\221\247\220\243\155\239z\235wwwwww\156\243wwwwww\127\239\031\223wwwwwwww\188\243\220\243\222\251\188\243wwwwwwww\247\246\156\251wwww\222\251\156\243ww\156\243\222\251wwww\248\246{\251wwwwwwwwwwwwwwwwwwwwwwwwww\182\218\222\251wwww\156\243wwwwww\223\214\223\251wwwwwwwwwwwwwwwwwwwwwwww\189\251\214\246wwww\222\251\156\243ww\156\243\222\251ww\189\255\214\246wwwwwwwwwwwwwwwwwwwwwwwwwwwwZ\235\024\227wwww\156\243wwww\127\239\031\227wwwwwwwwwwwwwwwwwwwwwwwwwwww\247\246\156\251ww\222\251\156\243ww\156\239\222\251ww\247\246\156\251wwwwwwwwwwwwwwwwwwwwwwwwwwwwww\214\218\222\251ww\156\243wwww\223\214\223\251wwwwwwwwwwwwwwwwwwwwwwwwwwww\189\255\214\242ww\222\251\156\243ww\156\243\255\251\189\255\214\246wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww{\239\024\227ww\156\243ww\127\235?\227wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\247\246\156\251\255\251\156\243_\235\156\247\255\251\247\246\156\251wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\214\218\189\247\189\247ww\223\214\223\251wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\189\255\214\246\222\251\156\243\191\214\157\239{\247\247\246wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww|\243\247\222\221\251?\231?\231wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\024\2479\243\222\247\159\239\189\210\213\246\190\255wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\246\222\025\223\255\218wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\223\255\149\2429\231\189\2477\206\149\230\189\247\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\189\247z\239\148\177=\231\188\247\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\189\247\156\243\156\243\156\243\156\243\189\247\189\247\156\243\189\247\024\239\173\197\254\255T\226\222\214ww\222\251\222\251wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\254\255\191\247\183\177z\243wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwZ\231\206\2179\251\246\238\031\219\127\239wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\255\218\027\223\213\218wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\222\251\148\2109\239\182\246\156\243\190\247\223\214\223\251wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\127\235\031\223\221\251Z\235\024\227wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\247\222Z\235\222\247\222\255\156\239\254\255\127\239\255\222wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\223\251\191\214ww\156\243ww\214\218\156\243wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww{\239\247\226ww\156\243ww\156\243\222\251ww\255\218\127\239wwwwwwwwwwwwwwwwwwwwwwwwwwwwww\223\214\159\243ww\156\243ww\222\251\181\214wwwwwwwwwwwwwwwwwwwwwwwwwwwwww\222\251\148\210ww\222\251\156\243ww\156\243\222\251wwww\191\210\223\251wwwwwwwwwwwwwwwwwwwwwwwwww?\231?\227wwww\156\243wwww{\239\247\222wwwwwwwwwwwwwwwwwwwwwwwwwwww\181\214\156\243ww\222\251\156\243ww\156\243\222\251wwww\191\247\191\210wwwwwwwwwwwwwwwwwwwwwwww\127\239\223\218wwwwww\156\243wwwwww\024\2279\231wwwwwwwwwwwwwwwwwwwwwwww\247\2229\231wwww\222\251\156\243ww\156\243\222\251wwwwww\159\239\223\214wwwwwwwwwwwwwwwwwwww\159\243\191\214wwwwwwww\156\243wwwwwwww\247\222Z\235wwwwwwwwwwwwwwwwwwww\024\231\024\227wwwwww\222\251\156\243ww\156\243\222\251wwwwwwww\127\239\191\210\223\251wwwwwwwwwwwwww_\235\223\214wwwwwwwwww\156\243wwwwwwwwww\214\2189\231wwwwwwwwwwwwwwww\247\222\247\226wwwwwwww\222\251\156\243ww\156\243wwwwwwwwwwww\191\247\223\214_\235wwwwwwww\223\247\031\223\031\223wwwwwwwwwwww\156\243wwwwwwwwwwww9\231\247\222\189\247wwwwwwww\189\247\214\218Z\235wwwwwwwwww\222\251\189\247\222\251{\239\189\247\222\251\222\251\222\251\222\251\222\251\254\255\222\251\030\223\190\210\222\214\222\218\190\214\190\210^\235\254\255\222\251\222\251\222\251\222\251\222\251\222\251{\239\222\251\222\251\222\251\222\251\222\251\222\251ww{\239\148\214\181\214\247\222\247\222\181\214\181\214{\239ww\222\251\222\251\222\251\222\251\222\251\156\243{\239\189\247Z\235\156\243\189\247\189\247\189\247\189\247\189\247\157\243\188\247\220\251\156\243}\239]\235\157\239\188\247\188\247\156\243\156\243\189\247\189\247\156\243\189\247\156\243Z\235\156\243\189\247\156\243\156\243\156\243\156\243\156\243\189\247\189\247{\239Z\235Z\235{\239\189\247\189\247\156\243\156\243\156\243\156\243\156\243\189\247{\239Z\235ww\156\243wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\156\243wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\222\251\189\247")
icon[11]	= image.new("\048\0\0\0\048\0\0\0\0\0\0\0\096\0\0\0\016\0\001\000wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\222\251wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\156\243\214\218wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww{\239\214\218wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww{\239\181\214wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww{\239\148\210wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\222\251\016\194\181\214\156\243wwwwwwwwwwwwwwwwwwwwww{\239s\206wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww{\2391\198{\239R\202\148\210{\239wwwwwwwwwwwwwwwwww{\239s\206wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwZ\2351\198wwww{\239s\206s\206{\239wwwwwwwwwwwwww{\239s\206wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\189\2471\198wwwwwwww{\239s\206R\202Z\235wwwwwwwwww{\239s\206wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\181\214s\206s\206s\206s\206\148\210\239\189\016\194wwwwwwwwwwww{\239\148\210R\2029\231wwwwww{\239s\206wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\222\251R\202wwwwwwwwwwwwZ\235\024\227\024\227\024\227\024\2279\231\148\2101\198wwwwwwwwwwwwwwww\189\247\148\210R\2029\231ww\189\247s\206wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\206\185\198\152wwwwwwwwwwwwwwwwwwwwwwww\156\2431\198wwwwwwwwwwwwwwwwwwww\189\247\148\210s\206\181\214s\206wwwwwwwwwwwwR\202\140\177\206\185\206\185wwR\202\198\152wws\206\198\1529\231c\140\198\152\247\222wwwwwwwwwwwwww\156\243\156\243wwwwZ\2351\198wwwwwwwwwwwwwwwwwwwwwwww\222\251\148\210\206\185\024\227wwwwwwww\181\214!\132\189\247\189\247\0\128Z\235J\169)\165ww\140\177\008\161wwB\136s\206wwwwwwwwwwwwwwww\016\194R\202wwww{\2391\198wwwwwwwwwwwwwwwwwwwwwwwwwwww\222\251\181\214R\202\247\222wwwwJ\169\008\161ww{\239\0\128\247\222\132\1441\198ww\165\148\239\189{\239\0\128Z\235wwwwwwwwwwwwww\222\251\016\194R\202\222\251ww{\2391\198wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\222\251\214\218R\202\214\218)\165\140\177wws\206B\136{\239\0\128\024\227Z\235\0\128\181\214\148\210!\132wwwwwwwwwwwwww\016\194\165\148B\136c\140\165\148R\202{\2391\198wwww\189\247R\202\222\251wwwwwwwwwwwwwwwwwwwwwwwwwwww\024\227\173\181\132\144\148\210\008\161\024\227\189\247B\136\008\161k\173\0\128{\239\247\222!\132\024\227wwwwwwwwwwwwwwww\016\194R\202wwww{\2391\198wwww\024\227B\136Z\235wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\024\227\016\194\181\214\189\247wwww\156\243wwwwwwww\189\247\222\251wwwwwwwwwwwwwwww\016\194R\202wwww{\2391\198wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww9\231R\202\148\210\156\243wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww{\2391\198wwwwk\173)\165ww)\165\173\181)\165B\136s\206wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwZ\235\148\210\148\2109\231Z\2359\231\222\251wwwwwwwwwwwwwwwwwwwwwwwwwwww{\2391\198wwwwB\136k\173ww\0\128\165\148\189\247\008\161\231\156wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww9\231\239\1891\198s\206R\202\156\243wwwwwwwwwwwwwwwwwwwwwwwwwwww{\2391\198ww\156\243\0\128R\2029\231\0\128\148\210ww\198\152k\173wwwwwwwwwwwwwwwwwwwwwwwwwwww\024\2271\198\181\214wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww{\2391\198ww\214\218\0\128\024\227s\206\0\128\189\247ww\0\1281\198wwwwwwwwwwwwwwwwwwwwwwww\247\222R\202\214\218\222\251wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww{\2391\198ww\016\194\0\128\222\251\173\181\132\144ww\024\227\0\128\024\227wwwwwwwwwwwwwwwwwwww\247\2221\198\214\218wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww{\2391\198ww\008\161c\140ww\165\148)\165ww\239\189\0\128\222\251wwwwwwwwwwwwww\222\251\214\218R\202\214\218wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww{\239\206\185\206\185\206\185ww{\2391\198wwwwwwwwwwwwwwwwwwwwwwwwwwwwww\222\251\181\2141\198\024\227wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\148\210B\136B\136\198\152ww{\2391\198wwwwwwwwwwwwwwwwwwwwwwwwww\222\251\214\218R\202\024\227wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww{\2391\198wwwwwwwwwwwwwwwwwwwwww\189\247\181\214\206\1851\198wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\222\251\189\247\189\247\189\247\189\247\222\2519\2311\198wwwwwwwwwwwwwwwwww\189\247\181\2141\198Z\235{\239\181\214wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwws\206\016\194\016\194\016\194\016\1941\198\140\1771\198wwwwwwwwwwwwww\189\247\148\210R\2029\231wwww{\239s\206wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww{\239R\202wwwwwwwwww\156\243\181\214R\2029\231wwwwwwww{\239s\206wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww{\239R\202wwwwww\156\243s\206s\2069\231wwwwwwwwwwww{\239s\206wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww{\239\148\210ww{\239\148\210R\202Z\235wwwwwwwwwwwwwwww{\239s\206wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\156\243\016\194\148\210s\206Z\235wwwwwwwwwwwwwwwwwwww\156\243s\206wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\181\214{\239wwwwwwwwwwwwwwwwwwwwwwww\156\243\148\210wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\156\243\181\214wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\156\243\214\218wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\189\247\247\222wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\189\247wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww")
icon[12]	= image.new("\048\0\0\0\048\0\0\0\0\0\0\0\096\0\0\0\016\0\001\000wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\156\243\222\251wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\240\185\024\223wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\142\165\214\210wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\174\173\149\206wwwwwwZ\231\214\214|\239wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\141\169t\198wwww\189\247\017\186\247\214R\198\247\218wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\141\165S\198wwww{\2392\186ww\156\243\174\177\156\243wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\142\165T\198wwww{\239\017\182wwww\140\169Z\231wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\142\165T\198wwww{\239\208\177\156\239\214\214S\198wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\142\165T\198wwww\222\251S\198\148\206\247\222\222\251wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\142\165T\198wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\142\165T\198wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww{\239\247\218:\231\208\177\181\210wwwwwwwwww\142\165T\194wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\149\206\142\165\181\210\202\136\175\173wwwwwwwwww\174\173t\198wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\182\206\176\165\182\214\202\136o\161\248\214\215\214\215\214\248\222\024\223+\153\149\206wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\182\210\176\169\182\210\202\136\012\141L\157L\157+\157L\157,\153m\165|\239wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\182\210\176\165\247\218\169\128\142\165wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\215\214\143\161\189\247\182\206\025\223wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\215\214n\157wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\215\214n\161wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\215\214n\161ww\156\243\222\251wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\215\214\176\165\214\218\233\1442\194wwww:\231\181\210wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\215\214\176\169\182\214\169\128\175\169\182\210\142\169\234\144\234\144\025\223\189\247wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\215\214\176\169\214\214\202\136\235\136\202\136\170\128\203\132\236\140\011\145\010\153\024\223wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\215\214\176\169\214\214\201\128L\157\142\169\235\144\203\132\202\132\150\202+\157R\194wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\214\214\176\169\214\214\233\140\240\181\255\251:\227\240\181*\153\222\251\208\181S\198wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww:\231\148\206\149\206\189\247wwwwwwwwwwwwwwwwwwwwwwww\215\218\143\165\189\247\247\222{\239wwwwww\156\243ww\143\169t\202wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\182\210t\202\189\247\248\222Z\235wwwwwwwwwwwwwwwwwwwwwwww\215\218\142\165wwwwwwwwwwwwwwww\142\169\149\202wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\239\181[\231ww\156\243wwwwwwwwwwwwwwwwwwwwwwwwww\215\218\142\165wwwwwwwwwwwwwwww\142\169\149\206wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\207\177:\227ww\207\181\181\210wwwwwwwwwwwwwwwwwwwwwwww\214\214\207\177|\239\018\190\182\210wwwwwwwwww\174\173\149\206wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\215\214R\194\189\2431\190\148\210wwwwwwwwwwwwwwwwwwwwwwww\214\214\241\181\024\223\169\128\142\169wwwwwwwwww\175\173\181\206wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\156\243:\231{\235wwwwwwwwwwwwwwwwwwwwww\222\251ww\182\214\207\177\248\218\202\132\142\161\024\219\248\214\248\218\248\218\025\219m\157\214\210wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\247\222\174\173\183\206\234\136\011\145,\153-\153,\157+\157M\153\234\136\247\218wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww{\235\214\218\149\210\182\210\215\210\215\214\247\218\247\218\248\218\247\2189\227\017\190\141\161\025\219\201\128\142\169wwww\222\251\222\251ww\175\173\214\210wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\223\2512\194\142\173\174\173\142\169\142\173\142\169\142\169\141\169\141\169m\165m\165K\161t\202ww\182\214:\231wwwwwwwwww\207\177\215\214wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\255\251\255\251\255\251\255\251wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\175\173\215\214wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\207\173\247\218wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\207\177\248\218wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\208\173\248\218wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\208\177\024\223wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\208\177\025\223wwwwww9\227R\198\181\210\222\251wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\208\1779\227wwww\156\239\239\181\156\239:\231\189\247wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\208\177:\231wwww\222\251R\1981\190:\231wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\208\177Z\231wwwwwwww{\239\174\177\025\223wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\240\185{\235wwww\189\247\181\210\025\2232\190|\235wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\156\243\255\251wwwwww{\239\182\210\156\239wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww")

--[[

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

--]]
Analysis	= Dialog("Note",50, 50, 200, 120)

txt	= sLabel ("Analysis is not yet done!")
but	= sButton("Okay..")
Analysis:appendWidget(txt,10,30)
Analysis:appendWidget(but,-10,-5)

function Analysis:postPaint(gc)
	nativeBar(gc, self, self.h-40)
end

but:giveFocus()

function but:action()
	only_screen(main)
end

RefBoolAlg = Screen()

RefBoolAlg.data = {
{"x+0=x","x.1=x","Identity"},
{"x+x'=1","x.x'=0","Inverse"},
{"x+x=x","x.x=x","Idempotent"},
{"x+1=1","x.0=0","Null Element"},
{"(x')'=x","(x')'=x","Involution"},
{"x+y=y+x","x.y=y.x","Commutative"},
{"x+(y+z)=(x+y)+z","x.(y.z)=(x.y).z","Associative"},
{"x.(y+z)=(x.y)+(x.z)","x+(y.z)=(x+y).(x+z)","Distributive"},
{"x+(x.y)=x","x.(x+y)=x","Absorption"},
{"(x+y+z)'=x'.y'.z'","(x.y.z)'=x'+y'+z'","DeMorgan's Law"},
{"(x.y)+(x'.z)+(y.z)=(x.y)+(x'.z)","(x+y).(x'+z).(y+z)=(x+y).(x'+z)","Consensus"}
}

RefBoolAlg.tmpScroll = 1
RefBoolAlg.dual = false

function RefBoolAlg:arrowKey(arrw)
  if pww()<330 then
	if arrw == "up" then
		RefBoolAlg.tmpScroll = RefBoolAlg.tmpScroll - test(RefBoolAlg.tmpScroll>1)
	end
	if arrw == "down" then
		RefBoolAlg.tmpScroll = RefBoolAlg.tmpScroll + test(RefBoolAlg.tmpScroll<(table.getn(RefBoolAlg.data)-7))
	end
	screenRefresh()
  end
end

function RefBoolAlg:enterKey()
	RefBoolAlg.dual = not RefBoolAlg.dual
	RefBoolAlg:invalidate()
end

function RefBoolAlg:escapeKey()
	remove_screen()
end

function RefBoolAlg:paint(gc)
	gc:setColorRGB(255,255,255)
	gc:fillRect(self.x, self.y, self.w, self.h)
	gc:setColorRGB(0,0,0)
	
	msg = "Boolean Algebra : "
	gc:setFont("sansserif","b",12)
	if RefBoolAlg.tmpScroll > 1 and pww()<330 then
		gc:drawString(utf8(9650),gc:getStringWidth(utf8(9664))+7,0,"top")
	end
	if RefBoolAlg.tmpScroll < table.getn(RefBoolAlg.data)-7 and pww()<330 then
		gc:drawString(utf8(9660),pww()-4*gc:getStringWidth(utf8(9654))-2,0,"top")
	end
	drawXCenteredString(gc,msg,0)
	gc:setFont("sansserif","i",12)
	drawXCenteredString(gc,"Press Enter for Dual ",15)
	gc:setFont("sansserif","r",12)
	
	local tmp = 0
	for k=RefBoolAlg.tmpScroll,table.getn(RefBoolAlg.data) do
		tmp = tmp + 1
		gc:setFont("sansserif","b",12)
		gc:drawString(RefBoolAlg.data[k][3], 3, 10+22*tmp, "top")
		gc:setFont("sansserif","r",12)
		gc:drawString(RefBoolAlg.data[k][1+test(RefBoolAlg.dual)], 125-32*test(k==11)*test(pww()<330)+30*test(pww()>330)+12, 10+22*tmp, "top")
	end
end

RefBoolExpr = Screen()

RefBoolExpr.data = {
{"F0","0","Null"},
{"F1","x.y","AND"},
{"F2","x.y'","Inhibition"},
{"F3","x","Transfer"},
{"F4","x'.y","Inhibition"},
{"F5","y","Transfer"},
{"F6","(x.y')+(x'.y)","Exclusive OR (XOR)"},
{"F7","x+y","OR"},
{"F8","(x+y)'","NOT OR (NOR)"},
{"F9","(x.y)+(x'.y')","Equivalence (XNOR)"},
{"F10","y'","Complement NOT"},
{"F11","x+y'","Implication"},
{"F12","x'","Complement (NOT)"},
{"F13","x'+y","Implication"},
{"F14","(x.y)'","NOT AND (NAND)"},
{"F15","1","Identity"}
}

RefBoolExpr.tmpScroll = 1

function RefBoolExpr:arrowKey(arrw)
	if arrw == "up" then
		RefBoolExpr.tmpScroll = RefBoolExpr.tmpScroll - test(RefBoolExpr.tmpScroll>1)
	end
	if arrw == "down" then
		RefBoolExpr.tmpScroll = RefBoolExpr.tmpScroll + test(RefBoolExpr.tmpScroll<(table.getn(RefBoolExpr.data)-7))
	end
	screenRefresh()
end

function RefBoolExpr:paint(gc)
	gc:setColorRGB(255,255,255)
	gc:fillRect(self.x, self.y, self.w, self.h)
	gc:setColorRGB(0,0,0)
	
	    msg = "Boolean Expressions : "
        gc:setFont("sansserif","b",12)
        if RefBoolExpr.tmpScroll > 1 then
        	gc:drawString(utf8(9650),gc:getStringWidth(utf8(9664))+7,0,"top")
        end
        if RefBoolExpr.tmpScroll < table.getn(RefBoolExpr.data)-7 then
        	gc:drawString(utf8(9660),pww()-4*gc:getStringWidth(utf8(9654))-2,0,"top")
        end
        drawXCenteredString(gc,msg,4)
        gc:setFont("sansserif","r",12)
        
       	local tmp = 0
       	for k=RefBoolExpr.tmpScroll,table.getn(RefBoolExpr.data) do
       		tmp = tmp + 1
       		gc:setFont("sansserif","b",12)
            gc:drawString(RefBoolExpr.data[k][1], 5, 5+22*tmp, "top")
        	gc:setFont("sansserif","r",12)
            gc:drawString(RefBoolExpr.data[k][2], 40+30*test(pww()>330)+15, 5+22*tmp, "top")
		    gc:drawString(RefBoolExpr.data[k][3], 134+50*test(pww()>330)+15, 5+22*tmp, "top")
		end
end

function RefBoolExpr:escapeKey()
	remove_screen()
end

RefConstants = Screen()

RefConstants.data = {
{"Acceleration due to gravity","g","9.81 m*s^-2"},
{"Atomic mass unit","mu or u","1.66 x 10^-27 kg"},
{"Avogadro's Number","N","6.022 x 10^23 mol^-1"},
{"Bohr radius","a0","0.529 x 10^-10 m"},
{"Boltzmann constant","k","1.38 x 10^-23 J K^-1"},
{"Electron charge to mass ratio","-e/me","-1.7588 x 10^11 C kg^-1"},
{"Electron classical radius","re","2.818 x 10^-15 m"},
{"Electron mass energy (J)","mec2","8.187 x 10^-14 J"},
{"Electron mass energy (MeV)","mec2","0.511 MeV"},
{"Electron rest mass","me","9.109 x 10^-31 kg"},
{"Faraday constant","F","9.649 x 10^4 C mol^-1"},
{"Fine-structure constant",utf8(945),"7.297 x 10^-3"},
{"Gas constant","R","8.314 J mol-1 K^-1"},
{"Gravitational constant","G","6.67 x 10^-11 Nm^2 kg^-2"},
{"Neutron mass energy (J)","mnc2","1.505 x 10^-10 J"},
{"Neutron mass energy (MeV)","mnc2","939.565 MeV"},
{"Neutron rest mass","mn","1.675 x 10^-27 kg"},
{"Neutron-electron mass ratio","mn/me","1838.68"},
{"Neutron-proton mass ratio","mn/mp","1.0014"},
{"Permeability of a vacuum",utf8(956).."0","4*pi x 10^-7 N A^-2"},
{"Permittivity of a vacuum",utf8(949).."0","8.854 x 10^-12 F m^-1"},
{"Planck constant","h","6.626 x 10^-34 J s"},
{"Proton mass energy (J)","mpc2","1.503 x 10^-10 J"},
{"Proton mass energy (MeV)","mpc2","938.272 MeV"},
{"Proton rest mass","mp","1.6726 x 10^-27 kg"},
{"Proton-electron mass ratio","mp/me","1836.15"},
{"Rydberg constant","r°","1.0974 x 10^7 m^-1"},
{"Speed of light in vacuum","C","2.9979 x 10^8 m/s"}
}

RefConstants.tmpScroll = 1
RefConstants.leftRight = 1

function RefConstants:arrowKey(arrw)
	if arrw == "up" then
		RefConstants.tmpScroll = RefConstants.tmpScroll - test(RefConstants.tmpScroll>1)
	end
	if arrw == "down" then
		RefConstants.tmpScroll = RefConstants.tmpScroll + test(RefConstants.tmpScroll<(table.getn(RefConstants.data)-7))
	end
	if arrw == "left" then
		RefConstants.leftRight = RefConstants.leftRight - 5*test(RefConstants.leftRight>1)
	end
	if arrw == "right" then
		RefConstants.leftRight = RefConstants.leftRight + 5*test(RefConstants.leftRight<150)
	end
	screenRefresh()
end

function RefConstants:paint(gc)
	gc:setColorRGB(255,255,255)
	gc:fillRect(self.x, self.y, self.w, self.h)
	gc:setColorRGB(0,0,0)
	
	    msg = "Physical Constants : "
        gc:setFont("sansserif","b",12)
        if RefConstants.leftRight > 1 then
        	gc:drawString(utf8(9664),4,0,"top")
        end
        if RefConstants.leftRight < 160 then
        	gc:drawString(utf8(9654),pww()-gc:getStringWidth(utf8(9660))-2,0,"top")
        end
        if RefConstants.tmpScroll > 1 then
        	gc:drawString(utf8(9650),gc:getStringWidth(utf8(9664))+7,0,"top")
        end
        if RefConstants.tmpScroll < table.getn(RefConstants.data)-7 then
        	gc:drawString(utf8(9660),pww()-4*gc:getStringWidth(utf8(9654))-2,0,"top")
        end
        drawXCenteredString(gc,msg,4)
        gc:setFont("sansserif","r",12)
        
       	local tmp = 0
       	for k=RefConstants.tmpScroll,table.getn(RefConstants.data) do
			tmp = tmp + 1
       		gc:setFont("sansserif","b",12)
            gc:drawString(RefConstants.data[k][1], 5-RefConstants.leftRight, 5+22*tmp, "top")
        	gc:setFont("sansserif","r",12)
            gc:drawString("  (" .. RefConstants.data[k][2] .. ") : " .. RefConstants.data[k][3] .. ". ", gc:getStringWidth(RefConstants.data[k][1])+15-RefConstants.leftRight, 5+22*tmp, "top")
		end
end

function RefConstants:escapeKey()
	remove_screen()
end
Greek = Screen()
 
Greek.font = "serif"
  
Greek.alphabet1 = {
 { utf8(913), utf8(945), "Alpha" },
 { utf8(914), utf8(946), "Beta" },
 { utf8(915), utf8(947), "Gamma" },
 { utf8(916), utf8(948), "Delta" },
 { utf8(917), utf8(949), "Epsilon" },
 { utf8(918), utf8(950), "Zeta" },
 { utf8(919), utf8(951), "Eta" },
 { utf8(920), utf8(952), "Theta" }
}
Greek.alphabet2 = {
 { utf8(921), utf8(953), "Iota" },
 { utf8(922), utf8(954), "Kappa" },
 { utf8(923), utf8(955), "Lambda" },
 { utf8(924), utf8(956), "Mu" },
 { utf8(925), utf8(957), "Nu" },
 { utf8(926), utf8(958), "Xi" },
 { utf8(927), utf8(959), "Omicron" },
 { utf8(928), utf8(960), "Pi" }
}
Greek.alphabet3 = {
 { utf8(929), utf8(961), "Rho" },
 { utf8(931), utf8(963), "Sigma" },
 { utf8(932), utf8(964), "Tau" },
 { utf8(933), utf8(965), "Upsilon" },
 { utf8(934), utf8(966), "Phi" },
 { utf8(935), utf8(967), "Chi" },
 { utf8(936), utf8(968), "Psi" },
 { utf8(937), utf8(969), "Omega" }
}
 
function Greek:paint(gc)
	gc:setColorRGB(255,255,255)
	gc:fillRect(self.x, self.y, self.w, self.h)
	gc:setColorRGB(0,0,0)
	
        local msg = "Greek Alphabet"
        gc:setFont("sansserif","b",12)
        drawXCenteredString(gc,msg,5)
        gc:setFont(Greek.font,"r",12)
        for k,v in ipairs(Greek.alphabet1) do
                gc:drawString(v[3] .. " : " .. v[1] .. " " .. v[2], 5, 10+22*k, "top")
        end
        for k,v in ipairs(Greek.alphabet2) do
                gc:drawString(v[3] .. " : " .. v[1] .. " " .. v[2], 5+.34*pww(), 10+22*k, "top")
        end
        for k,v in ipairs(Greek.alphabet3) do
                gc:drawString(v[3] .. " : " .. v[1] .. " " .. v[2], 5+.67*pww(), 10+22*k, "top")
        end
end
 
function Greek:enterKey()
    Greek.font = Greek.font == "serif" and "sansserif" or "serif"
    Greek:invalidate()
end

function Greek:escapeKey()
	remove_screen()
end
ResColor = Screen()

ResColor.colors = {
["silver"] = {217,217,217},
["gold"] = {255,211,76},
["black"] = {0,0,0},
["brown"] = {153,115,0},
["red"] = {255,0,0},
["orange"] = {255,102,0},
["yellow"] = {255,255,0},
["green"] = {0,204,0},
["blue"] = {3,69,218},
["pink"] = {204,0,204},
["grey"] = {140,140,140},
["white"] = {255,255,255}
}

resistor = class()

function resistor:init(value,colors,selection)
	self.value = value
	self.colors = colors
	self.selection = selection
end

-- Resistor = resistor({238,1,3},{5,6,11,3,2},1)
Resistor = resistor({23,1,3},{5,6,3,2},1)

ResColor.tolerance = {
["0.1"] = 10,
["0.25"] = 9,
["0.5"] = 8,
["2"] = 5,
["1"] = 4,
["5"] = 2,
["10"] = 1
}
ResColor.tolerancenr = {0.1,0.25,0.5,1,2,5,10}

ResColor.colortable = {"silver","gold","black","brown","red","orange","yellow","green","blue","pink","grey","white"}

function ResColor:paint(gc)
	gc:setColorRGB(255,255,255)
	gc:fillRect(self.x, self.y, self.w, self.h)
	gc:setColorRGB(0,0,0)
	
	Resistor:paint(gc)
end

function Resistor:paint(gc)
	local w,h = pww(),pwh()
	
	--------------
	-- resistor --
	--------------
	gc:setColorRGB(170,170,170)
	gc:fillRect((w-(w/4+w/3))/2,(h/2-h/5)/2+((h/2-h/5)/2+h/40)/2,w/4+w/3,h/40)
	
	gc:setColorRGB(230,206,170)
	gc:fillRect((w-w/2)/2-1,(h/2-h/5)/2-1,w/2+2,h/5+2)
	
	------------
	-- colors --
	------------
	for i=1,#self.colors do
		gc:setColorRGB(unpack(ResColor.colors[ResColor.colortable[self.colors[i]]]))
		gc:fillRect((w-w/2)/2+w/2/(#self.colors)*(i-0.85),(h/2-h/5)/2,w/2/(#self.colors+2),h/5)
	end
	
	-----------
	-- value --
	-----------
	gc:setColorRGB(0,0,0)
	gc:setFont("sansserif","b","11")
	local printstring = "Resistance: "..self.value[1]*self.value[2].." Ohm "..string.uchar(177).." "..ResColor.tolerancenr[self.value[3]].."%"
	gc:drawString(printstring,(w-gc:getStringWidth(printstring))/2,h/2,"top")
	
	---------------
	-- selection --
	---------------
	gc:setColorRGB(230,206,170)
	gc:setPen("medium","smooth")
	gc:drawRect((w-w/2)/2+w/2/(#self.colors)*(self.selection-0.85)+1,(h/2-h/5)/2+1,w/2/(#self.colors+2)-3,h/5-3)
end

function ResColor:arrowKey(arrow)
	Resistor:arrowKey(arrow)
end

function ResColor:charIn(char)
	Resistor:charIn(char)
end

function Resistor:arrowKey(arrow)
	---------------------
	-- color selection --
	---------------------
	if arrow=='right' and self.selection<#self.colors then
		self.selection = self.selection + 1
	elseif arrow=='left' and self.selection>1 then
		self.selection = self.selection - 1
	-----------
	-- value --
	-----------
	elseif arrow=='up' and self.selection<=#self.colors-2 and self.colors[self.selection]<12 then
		self.value[1] = self.value[1]+10^(#self.colors-2-self.selection)
		self.colors[self.selection] = self.colors[self.selection] + 1
	elseif arrow=='down' and self.selection<=#self.colors-2  and self.colors[self.selection]>3 then
		self.value[1] = self.value[1]-10^(#self.colors-2-self.selection)
		self.colors[self.selection] = self.colors[self.selection] - 1
	----------------
	-- multiplier --
	----------------
	elseif arrow=='up' and self.selection==#self.colors-1 and self.value[2] < 10000000 then
		self.value[2] = self.value[2]*10
		self.colors[self.selection] = self.colors[self.selection] + 1
	elseif arrow=='down' and self.selection==#self.colors-1 and self.value[2] > 0.01 then
		self.value[2] = self.value[2]/10
		self.colors[self.selection] = self.colors[self.selection] - 1
	---------------
	-- tolerance --
	---------------
	elseif arrow=='up' and self.selection==#self.colors and self.value[3]<7 then
		self.value[3] = self.value[3] + 1
		self.colors[self.selection] = ResColor.tolerance[tostring(ResColor.tolerancenr[self.value[3]])]
	elseif arrow=='down' and self.selection==#self.colors  and self.value[3]>1 then
		self.value[3] = self.value[3] - 1
		self.colors[self.selection] = ResColor.tolerance[tostring(ResColor.tolerancenr[self.value[3]])]
	end
	platform.window:invalidate()
end

function Resistor:charIn(char)
	if char=='+' and #self.colors==4 then
		table.insert(self.colors,3,3)
		self.value[1] = self.value[1]*10
	elseif char=='-' and #self.colors==5 then
		local deletenr = (self.colors[3]-3)*self.value[2]
		self.value[1] = self.value[1]-deletenr
		table.remove(self.colors,3)
		self.value[1] = self.value[1]/10
	end
	platform.window:invalidate()
end

function ResColor:escapeKey()
	remove_screen()
end

SIPrefixes = Screen()

SIPrefixes.prefixes1 = {
	{"Y", "Yotta", "24"},
	{"Z", "Zetta", "21"},
	{"E", "Exa", "18"},
	{"P", "Peta", "15"},
	{"T", "Tera", "12"},
	{"G", "Giga", "9"},
	{"M", "Mega", "6"},
	{"k", "Kilo", "3"},
	{"h", "Hecto", "2"},
	{"da", "Deka", "1"}
}

SIPrefixes.prefixes2 = {
	{"d", "Deci", "-1"},
	{"c", "Centi", "-2"},
	{"m", "Milli", "-3"},
	{utf8(956), "Micro", "-6"},
	{"n", "Nano", "-9"},
	{"p", "Pico", "-12"},
	{"f", "Femto", "-15"},
	{"a", "Atto", "-18"},
	{"z", "Zepto", "-21"},
	{"y", "Yocto", "-24"}
}

function SIPrefixes:paint(gc)
	gc:setColorRGB(255,255,255)
	gc:fillRect(self.x, self.y, self.w, self.h)
	gc:setColorRGB(0,0,0)
	
	    local msg = "SI Prefixes  "
        gc:setFont("sansserif","b",12)
        drawXCenteredString(gc,msg,0)
        gc:setFont("sansserif","r",12)
        for k,v in ipairs(SIPrefixes.prefixes1) do
                gc:drawString("10", 5+.03*self.w, 3+19*k, "top")
                gc:drawString(v[3], 23+.03*self.w, 19*k-3, "top")
                gc:drawString(" : " .. v[2], 45+.03*self.w, 3+19*k, "top")
                gc:drawString("  (" .. v[1] .. ")", 98+.03*self.w, 3+19*k, "top")
        end
        for k,v in ipairs(SIPrefixes.prefixes2) do
                gc:drawString("10", 5+.52*self.w, 3+19*k, "top")
                gc:drawString(v[3], 23+.52*self.w, 19*k-3, "top")
                gc:drawString("  : " .. v[2], 45+.52*self.w, 3+19*k, "top")
                gc:drawString("  (" .. v[1] .. ")", 100+.52*self.w, 3+19*k, "top")
        end
end

function SIPrefixes:escapeKey()
	remove_screen()
end
References	= {
	{title="Resistor color chart"     , info="", screen=ResColor    },
	{title="Standard Component Values", info="", screen=nil         },
	{title="Semiconductor Data",        info="", screen=nil         },
	{title="Boolean Expressions",       info="", screen=RefBoolExpr },
	{title="Boolean Algebra",           info="", screen=RefBoolAlg  },
	{title="Transforms",                info="", screen=nil         },
	{title="Constants",                 info="", screen=RefConstants},
	{title="SI Prefixes",               info="", screen=SIPrefixes  },
	{title="Greek Alphabet",            info="", screen=Greek       },
}

Ref	= WScreen()

RefList	= sList()
RefList:setSize(-4, -4)

Ref:appendWidget(RefList, 2, 2)

function Ref.addRefs()
	for n, ref in ipairs(References) do
		if ref.screen then
			table.insert(RefList.items, ref.title)
		else
			table.insert(RefList.items, ref.title .. " (not yet done)")
		end
	end
end

function RefList:action(ref)
	if References[ref].screen then
		push_screen(References[ref].screen)
	end
end

function Ref:pushed()
	RefList:giveFocus()
end

function Ref:escapeKey()
	only_screen(main)
end


Ref.addRefs()
only_screen(CategorySel)

----------------------------------------

aboutWindow	= Dialog("About FormulaPro :", 50, 20, 280, 180)

local aboutText	= sLabel ([[FormulaPro v1.0  -  Standalone version
-----------------------------
Authors : Jim Bauwens, Adrien Bertrand
(Adriweb). Credits also to Levak.
LGPL License. More info and contact : 
http://tiplanet.org  and  www.inspired-lua.org]])

local aboutButton	= sButton("OK")
aboutWindow:appendWidget(aboutText,10,27)
aboutWindow:appendWidget(aboutButton,-10,-5)

function aboutWindow:postPaint(gc)
	nativeBar(gc, self, self.h-40)
	on.help = function() return 0 end
end

aboutButton:giveFocus()

function aboutButton:action()
	remove_screen(aboutWindow)
	on.help = function() push_screen(aboutWindow) end
end

----------------------------------------

function on.help()
	push_screen(aboutWindow)
end