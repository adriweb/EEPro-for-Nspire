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
Constants[utf8(956).."0"]	= {info="Magnetic permeability constant"     , value="4*pi*10^-7"           , unit=nil                  }
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
c_u  = utf8(956)
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
aF(2, 4, "C=("..c_e.."0*"..c_e.."r*A)/d",         U("C",c_e.."0",c_e.."r","A","d") )
aF(2, 4, "Q=C*V",                 U("Q","C","V")           )
aF(2, 4, "F=-0.5*(V*V*C)/d",      U("F","V","C","d")       )
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
addCatVar(5, utf8(969), "Radian frequency", "rad/s")

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
addCatVar(6, utf8(969), "Radian frequency", "rad/s")
addCatVar(6, "W", "Energy dissipated", "J")

addSubCat(6, 1, "RL Natural Response", "")
aF(6, 1, c_t.."=L/R",                           U(c_t,"L","R")                )
aF(6, 1, "vL=I0*R*exp(-t/"..c_t..")",               U("vL","I0","R","t",c_t)      )
aF(6, 1, "iL=I0*exp(-t/"..c_t..")",                 U("iL","I0","t",c_t)          )
aF(6, 1, "W=1/2*L*I0*I0*(1-exp(-2*t/"..c_t.."))",   U("W","L","I0","t",c_t)       )

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
-- 11 formulas here :o --

addSubCat(6, 6, "RC Series to Parallel", "")
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
addCatVar(16, utf8(969).."m", "Mechanical radian frequency", "rad/s")
addCatVar(16, utf8(969).."me", "Electrical radian frequency", "rad/s")
addCatVar(16, utf8(969).."r", "Electrical rotor speed", "rad/s")
addCatVar(16, utf8(969).."s", "Electrical stator speed", "rad/s")
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

Mt.us	= utf8(181)


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
Units["rad/s"]["RPM"]	= {1/(2*math.pi/60), 0}


Units["A/m"]	= {}
Units["A/m"]["mA/m"]	= {Mt.m, 0}

Units["V/s"]	= {}
Units["V/s"]["mV/s"]	= {Mt.m, 0}

Units["C/m"]	= {}
Units["C/m"][Mt.us.."C/m"]	= {Mt.u  , 0}
Units["C/m"]["C/mm"      ]	= {1/Mt.m, 0}

Units["m2/s"]	= {}

Units[utf8(937)]	= {}
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

Units["A/V^2"]	= {}

Units["N/m"]	= {}
Units["N/m"]["daN"]	= {Mt.da, 0}

Units["rad"]	= {}
Units["rad"]["degree"]	= {180/math.pi, 0}

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
Units["K"]["°C"]	= {1, 273.15}
Units["K"]["°F"]	= {9/5, -459.67}
Units["K"]["°R"]	= {9/5, 0}

Units["J"]	= {}
Units["J"]["GJ"]	= {Mt.G, 0} 
Units["J"]["MJ"]	= {Mt.M, 0}
Units["J"]["kJ"]	= {Mt,k, 0}	
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
Units["m2"]["cm2"]	= {Mt.c^2}
Units["m2"]["mm2"]	= {Mt.m^2}
Units["m2"]["km2"]	= {Mt.k^2}

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
		self.parent:switchFocus(self.focusUp or -1)
	elseif arrow=="down"  then
		self.parent:switchFocus(self.focusDown or 1)
	elseif arrow=="left" then 
		self.parent:switchFocus(self.focusLeft or -1)
	elseif arrow=="right"  then
		self.parent:switchFocus(self.focusRight or 1)	
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
	if n then
		n	= n < 0 and -1 or (n > 0 and 1 or 0)
	end
	
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
		self:change(self.sel, self.items[self.sel])
		if self.top>=self.sel then
			self.top	= self.top - 1
		end
	end

	if arrow=="down" and self.sel<#self.items then
		self.sel	= self.sel + 1
		self:change(self.sel, self.items[self.sel])
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
			self:change(self.sel, self.items[self.sel])
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


function sList:change() end
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
	if n and ((n >= 1 and self.focus+n<=#self.widgets) or (n <= -1 and self.focus+n>=1)) then
		self:switchFocus(n)
		return -1
	else
		self:stealFocus()
	end
	
end


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

sDropdown	=	class(Widget)


function sDropdown:init(items)
	self.dh	= 21
	self.dw	= 75
	self.screen	= WScreen()
	self.sList	= sList()
	self.sList.items	= items or {}
	self.screen:appendWidget(self.sList,0,0)
	self.sList.action	= self.listAction
	self.sList.loseFocus	= self.screenEscape
	self.sList.change	= self.listChange
	self.screen.escapeKey	= self.screenEscape
	self.lak	= self.sList.arrowKey	
	self.sList.arrowKey	= self.listArrowKey
	self.value	= items[1] or ""
	self.valuen	= #items>0 and 1 or 0
	self.rvalue	= items[1] or ""
	self.rvaluen=self.valuen
	
	self.sList.parentWidget = self
	self.screen.parentWidget = self
	--self.screen.focus=1
end

function sDropdown:screenpaint(gc)
	gc:setColorRGB(255,255,255)
	gc:fillRect(self.x, self.y, self.h, self.w)
	gc:setColorRGB(0,0,0)
	gc:drawRect(self.x, self.y, self.h, self.w)
end

function sDropdown:mouseDown()
	self:open()
end


sDropdown.img = image.new("\14\0\0\0\7\0\0\0\0\0\0\0\28\0\0\0\16\0\1\000{\239{\239{\239{\239{\239{\239{\239{\239{\239{\239{\239{\239{\239{\239al{\239{\239{\239{\239{\239{\239{\239{\239{\239{\239{\239{\239alalal{\239{\239\255\255\255\255\255\255\255\255\255\255\255\255{\239{\239alalalalal{\239{\239\255\255\255\255\255\255\255\255{\239{\239alalalalalalal{\239{\239\255\255\255\255{\239{\239alalalalalalalalal{\239{\239{\239{\239alalalalalalalalalalal{\239{\239alalalalalal")

function sDropdown:arrowKey(arrow)	
	if arrow=="up" then
		self.parent:switchFocus(self.focusUp or -1)
	elseif arrow=="down" then
		self.parent:switchFocus(self.focusDown or 1)
	elseif arrow=="left" then 
		self.parent:switchFocus(self.focusLeft or -1)
	elseif arrow == "right" then
		self:open()
	end
end

function sDropdown:listArrowKey(arrow)
	if arrow == "left" then
		self:loseFocus()
	else
		self.parentWidget.lak(self, arrow)
	end
end

function sDropdown:listChange(a, b)
	self.parentWidget.value  = b
	self.parentWidget.valuen = a
end

function sDropdown:open()
	self.screen.yy	= self.y+self.h
	self.screen.xx	= self.x-1
	self.screen.ww	= self.w + 13
	local h = 2+(18*#self.sList.items)
	self.screen.hh	= self.y+self.h+h>self.parent.h+self.parent.y-10 and self.parent.h-self.parent.y-self.y-self.h-10 or h
	if self.screen.hh < 40 then
		self.screen.hh = h < 100 and h or 100
		self.screen.yy = self.y-self.screen.hh
	end
	
	self.sList.ww = self.w + 13
	self.sList.hh = self.screen.hh-2
	self.sList:giveFocus()
	push_screen(self.screen)
end

function sDropdown:listAction(a,b)
	self.parentWidget.value  = b
	self.parentWidget.valuen = a
	self.parentWidget.rvalue  = b
	self.parentWidget.rvaluen = a
	self.parentWidget:change(a, b)
	remove_screen()
end

function sDropdown:change() end

function sDropdown:screenEscape()
	self.parentWidget.sList.sel = self.parentWidget.rvaluen
	self.parentWidget.value	= self.parentWidget.rvalue
	if current_screen() == self.parentWidget.screen then
		remove_screen()
	end
end

function sDropdown:paint(gc)
	gc:setColorRGB(255, 255, 255)
	gc:fillRect(self.x, self.y, self.w-1, self.h-1)
	
	gc:setColorRGB(0,0,0)
	gc:drawRect(self.x, self.y, self.w-1, self.h-1)
	
	if self.hasFocus then
		gc:drawRect(self.x-1, self.y-1, self.w+1, self.h+1)
	end
	
	gc:setColorRGB(192, 192, 192)
	gc:fillRect(self.x+self.w-21, self.y+1, 20, 19)
	gc:setColorRGB(224, 224, 224)
	gc:fillRect(self.x+self.w-22, self.y+1, 1, 19)
	
	gc:drawImage(self.img, self.x+self.w-18, self.y+9)
	
	gc:setColorRGB(0,0,0)
	local text = self.value
	if self.unitmode then
		text=text:gsub("([^%d]+)(%d)", numberToSub)
	end
	
	gc:drawString(textLim(gc, text, self.w-5-22), self.x+5, self.y, "top")
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
	local cid	= self.parent.cid
	if #Categories[cid].sub[sub].formulas>0 then
		only_screen(manualSolver, cid, sub)
	end
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
		table.insert(items, subcat.name .. (#subcat.formulas == 0 and " (Empty)" or ""))
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
	local nodropdown, lastdropdown
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
			inp.ww	= 155
			inp.focusDown	= 4
			inp.focusUp	= -2
			lbl	= sLabel(variable, inp)

			self.pl:appendWidget(inp, 60, i*30-28)		
			self.pl:appendWidget(lbl, 2, i*30-28)
			self.pl:appendWidget(sLabel(":", inp), 50, i*30-28)
			
			print(variable)
			local variabledata	= Categories[cid].varlink[variable]
			inp.placeholder	= variabledata.info
			
			if nodropdown then
				inp.focusUp	= -1
			end
			
			if variabledata.unit ~= "unitless" then
				--unitlbl	= sLabel(variabledata.unit:gsub("([^%d]+)(%d)", numberToSub))
				local itms	= {variabledata.unit}
				for k,_ in pairs(Units[variabledata.unit]) do 
					table.insert(itms, k)
				end
				inp.dropdown	= sDropdown(itms)
				inp.dropdown.unitmode	= true
				inp.dropdown.change	= self.update
				inp.dropdown.focusUp	= nodropdown and -5 or -4
				inp.dropdown.focusDown	= 2
				self.pl:appendWidget(inp.dropdown, 220, i*30-28)
				nodropdown	= false
				lastdropdown	= inp.dropdown
			else 
				nodropdown	= true
				inp.focusDown	= 1
				if lastdropdown then 
					lastdropdown.focusDown = 1
					lastdropdown = false
				end			
			end
			
			
			
			inp.getFocus = manualSolver.update
		else
			self.constants[variable]	= math.eval(Constants[variable].value)
			--var.store(variable, self.known[variable])
		end

	end
	inp.focusDown	= 1
	
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
		local variabledata	= Categories[self.cid].varlink[variable]
		if input.disabled then 
			inputed[variable] = nil
			input.value = ""
		end
		
		input:enable()
		if input.value	~= "" then
			inputed[variable]	= tonumber(input.value)
			if input.dropdown and input.dropdown.rvalue ~= variabledata.unit then
				inputed[variable]	= Units.subToMain(variabledata.unit, input.dropdown.rvalue, inputed[variable])
			end
		end
	end
	
	local invs = copyTable(inputed)
	for k,v in pairs(self.constants) do
		invs[k]=v
	end
	self.known	= find_data(invs, self.cid, self.sid)
	
	for variable, value in pairs(self.known) do
		if (not inputed[variable] and self.inputs[variable]) then
			local variabledata	= Categories[self.cid].varlink[variable]
			local result	= tostring(value)
			local input	= self.inputs[variable]
			
			if input.dropdown and input.dropdown.rvalue ~= variabledata.unit then
				result	= Units.mainToSub(variabledata.unit, input.dropdown.rvalue, result)
			end
			
			input.value	= result
			input:disable()
		end
	end
end

function manualSolver:escapeKey()
	only_screen(SubCatSel, self.cid)
end

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

local aboutText	= sLabel([[FormulaPro v1.0  -  Standalone version
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