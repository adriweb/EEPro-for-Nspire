--------------------------
---- FormulaPro v1.4b ----
---- (Jan 18th, 2013) ----
----  LGLP 3 License  ----
--------------------------
----   Jim Bauwens    ----
---- Adrien Bertrand  ----
--------------------------
----  TI-Planet.org   ----
---- Inspired-Lua.org ----
--------------------------

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
Constants["q"      ]	= {info="e elementary charge"                , value="1.60218 * 10^-19"      , unit="C"                  }
Constants["pi"     ]	= {info="PI"                                 , value="pi"                    , unit=nil                  }
Constants[utf8(956).."0"]	= {info="Magnetic permeability constant" , value="4*pi*10^-7"            , unit=nil                  }
Constants[utf8(960)]	= Constants["pi"]

function checkIfExists(table, name)
    for k,v in pairs(table) do
        if (v.name == name) or (v == name) then -- lulz lua powa
            print("Conflict (i.e elements appearing twice) detected when loading Database. Skipping the item.")
            return true
        end
    end
    return false
end

function checkIfFormulaExists(table, formula)
    for k,v in pairs(table) do
        if (v.formula == formula)  then -- lulz lua powa
            print("Conflict (i.e formula appearing twice) detected when loading Database. Skipping formula.")
            return true
        end
    end
    return false
end

Categories	=	{}
Formulas	=	{}

function addCat(id,name,info)
    if checkIfExists(Categories, name) then
        print("Warning ! This category appears to exist already ! Adding anyway....")
    end
    return table.insert(Categories, id, {id=id, name=name, info=info, sub={}, varlink={}})
end

function addCatVar(cid, var, info, unit)
    Categories[cid].varlink[var] = {unit=unit, info=info }
end

function addSubCat(cid, id, name, info)
    if checkIfExists(Categories[cid].sub, name) then
        print("Warning ! This subcategory appears to exist already ! Adding anyway....")
    end
    return table.insert(Categories[cid].sub, id, {category=cid, id=id, name=name, info=info, formulas={}, variables={}})
end

function aF(cid, sid, formula, variables) --add Formula
	local fr	=	{category=cid, sub=sid, formula=formula, variables=variables}
	-- In times like this we are happy that inserting tables just inserts a reference

    -- commented out this check because only the subcategory duplicates should be avoided, and not on the whole db.
    --if not checkIfFormulaExists(Formulas, fr.formula) then
        table.insert(Formulas, fr)
    --end
    if not checkIfFormulaExists(Categories[cid].sub[sid].formulas, fr.formula) then
        table.insert(Categories[cid].sub[sid].formulas, fr)
    end
	
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

c_O = utf8(963)
c_alpha = utf8(945)
c_beta = utf8(946)
c_delta = utf8(948)
c_epsilon = utf8(949)
c_e = c_epsilon
c_Pi = utf8(960)
c_pi = c_Pi
c_mu = utf8(956)
c_tau = utf8(964)
c_rho = utf8(961)
c_phi = utf8(966)
c_omega = utf8(969)
c_CAPomega = utf8(937)
c_Ohm = c_CAPomega
c_theta = utf8(952)

addCat(1, "Resistive Circuits", "Performs routine calculations of resistive circuits")

addCatVar(1, "A", "Area", "m2")
addCatVar(1, "G", "Conductance", "S")
addCatVar(1, "I", "Current", "A")
addCatVar(1, "Il", "Load current", "A")
addCatVar(1, "Is", "Current source", "A")
addCatVar(1, "len", "Length", "m")
addCatVar(1, "P", "Power", "W")
addCatVar(1, "Pmax", "Maximum power in load", "W")
addCatVar(1, "R", "Resistance", c_CAPomega)
addCatVar(1, "Rl", "Load resistance", c_CAPomega)
addCatVar(1, "Rlm", "Match load resistance", c_CAPomega)
addCatVar(1, "RR1", "Resistance, T1", c_CAPomega)
addCatVar(1, "RR2", "Resistance, T2", c_CAPomega)
addCatVar(1, "Rs", "Source resistance", c_CAPomega)
addCatVar(1, "T1", "Temperature 1", "K")
addCatVar(1, "T2", "Temperature 2", "K")
addCatVar(1, "U", "Voltage", "V")
addCatVar(1, "Vl", "Load voltage", "V")
addCatVar(1, "Vs", "Source voltage", "V")
addCatVar(1, c_alpha, "Temperature coefficient", "1/"..utf8(176).."K")
addCatVar(1, c_rho, "Resistivity", c_CAPomega.."*m")
addCatVar(1, utf8(963), "Conductivity", "S/m")

addSubCat(1, 1, "Resistance Formulas", "")
aF(1, 1, "R=("..c_rho.."*len)/A",U("R",c_rho,"len","A") )
aF(1, 1, "G=("..c_O.."*A)/len",U("G",c_O,"len","A") )
aF(1, 1, "G=1/R", U("G","R"))
aF(1, 1, c_O.."=1/"..c_rho, U(c_O,c_P))

addSubCat(1, 2, "Ohm\'s Law and Power", "")
aF(1, 2, "U=I*R", U("R","U","I") )
aF(1, 2, "P=I*U", U("P","U","I") )
aF(1, 2, "P=(U*U)/R", U("P","U","R") )
aF(1, 2, "P=U*U*G", U("P","U","G") )
aF(1, 2, "R=1/G", U("R","G") )

addSubCat(1, 3, "Temperature Effect", "")
aF(1, 3, "RR2=RR1*(1+"..c_alpha.."*(T2-T1))", U("RR2","RR1","T1", "T2", c_alpha) )

addSubCat(1, 4, "Maximum DC Power Transfer", "")
aF(1, 4, "Vl=(Vs*Rl)/(Rs+Rl)", U("Vl","Vs","Rl","Rs") )
aF(1, 4, "Il=Vs/(Rs+Rl)", U("Il","Rs","Rs","Rl") )
aF(1, 4, "P=Il*Vl", U("P","Il", "Vl") )
aF(1, 3, "Pmax=(Vs*Vs)/(4*Rs)",  U("Pmax","Vs","Rs") )
aF(1, 3, "Rlm=Rs", U("Rlm","Rs") )

addSubCat(1, 5, "Voltage and Current Source Equivalence", "") 
aF(1, 5, "Is=Vs/Rs", U("Is","Vs","Rs")) 
aF(1, 5, "Vs=Is*Rs", U("Vs","Is","Rs")) 


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
addCatVar(2, c_epsilon.."r", "Relative permittivity", "unitless")
addCatVar(2, c_rho.."l", "Line charge", "C/m")
addCatVar(2, c_rho.."s", "Charge density", "C/m2")

addSubCat(2, 1, "Point Charge", "")
aF(2, 1, "Er=Q/(4*"..c_Pi.."*"..c_e.."0*"..c_e.."r*r^2)", U("Er","Q",c_e.."0",c_e.."r", "r") )
aF(2, 1, "V=Q/(4*"..c_Pi.."*"..c_e.."0*"..c_e.."r*r)", U("V","Q",c_e.."0",c_e.."r", "r") )

addSubCat(2, 2, "Long Charged Line", "")
aF(2, 2, "Er="..c_rho.."l/(2*"..c_Pi.."*"..c_e.."0*"..c_e.."r)", U("Er",c_rho.."l",c_e.."0",c_e.."r") )

addSubCat(2, 3, "Charged Disk", "")
aF(2, 3, "Ez=("..c_rho.."s/(2*"..c_e.."0*"..c_e.."r))*(1-abs(z)/sqrt(ra^2+z^2))", U("Ez",c_rho.."s",c_e.."0",c_e.."r","z","ra") )
aF(2, 3, "Vz=("..c_rho.."s/(2*"..c_e.."0*"..c_e.."r))*(sqrt(ra^2+z^2)-abs(z))", U("Vz",c_rho.."s",c_e.."0",c_e.."r","z","ra") )

addSubCat(2, 4, "Parallel Plates", "")
aF(2, 4, "E=V/d", U("E","V","d"))
aF(2, 4, "C=("..c_e.."0*"..c_e.."r*A)/d", U("C",c_e.."0",c_e.."r","A","d") )
aF(2, 4, "Q=C*V", U("Q","C","V"))
aF(2, 4, "F=-1/2*(V^2*C)/d", U("F","V","C","d") )
aF(2, 4, "W=1/2*V^2*C",U("W","V","C"))

addSubCat(2, 5, "Parallel Wires", "")
aF(2, 5, "cl="..c_Pi.."*"..c_e.."0*"..c_e.."r/arccosh(d/(2*ra))", U("cl",c_e.."0",c_e.."r","d","ra") )

addSubCat(2, 6, "Coaxial Cable", "")
aF(2, 6, "V=("..c_rho.."l/(2*"..c_Pi.."*"..c_e.."0*"..c_e.."r))*ln(rb/ra)", U("V",c_rho.."l",c_e.."0",c_e.."r","ra") )
aF(2, 6, "Er=V/(r*ln(rb/ra))", U("Er","V","r","rb","ra") )
aF(2, 6, "cl=(2*"..c_Pi.."*"..c_e.."0*"..c_e.."r)/ln(rb/ra)", U("cl",c_e.."0",c_e.."r","rb","ra") )

addSubCat(2, 7, "Sphere", "")
aF(2, 7, "V=(Q/(4*"..c_Pi.."*"..c_e.."0*"..c_e.."r))*(1/ra-1/rb)", U("V","Q",c_e.."0",c_e.."r","ra","rb") )
aF(2, 7, "Er=Q/(4*"..c_Pi.."*"..c_e.."0*"..c_e.."r*r^2)", U("Er","Q","r",c_e.."0",c_e.."r") )
aF(2, 7, "C=(4*"..c_Pi.."*"..c_e.."0*"..c_e.."r*ra*rb)/(rb-ra)", U("C",c_e.."0",c_e.."r","rb","ra") )

addCat(3, "Inductors and Magnetism", "Calculate electrical and magnetic properties of physical elements")

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
addCatVar(3, "Reff", "Effective resistance", c_CAPomega) -- in Ohms
addCatVar(3, "rr0", "Wire radius", "m")
addCatVar(3, "T12", "Torque", "N*m")
addCatVar(3, "x", "x axis distance", "m")
addCatVar(3, "y", "y axis distance", "m")
addCatVar(3, "z", "Distance to loop z axis", "m")
addCatVar(3, c_delta, "Skin depth", "m") -- delta
addCatVar(3, c_rho, "Resistivity", c_CAPomega.."*m") -- rho

addSubCat(3, 1, "Long Line", "")
aF(3, 1, "B=("..c_mu.."0*I)/(2*"..c_Pi.."*r)", U("B",c_mu.."0","I","r",c_Pi) )

addSubCat(3, 2, "Long Strip", "")
aF(3, 2, "Bx=((-"..c_mu.."0*Is)/(2*"..c_Pi.."))*(arctan((x+d/2)/y)-arctan((x-d/2)/y))", U("Bx",c_mu.."0","Is","x","d","y") )
aF(3, 2, "By=(("..c_mu.."0*Is)/(4*"..c_Pi.."))*ln((y^2-(x+d/2)^2)/(y^2-(x-d/2)^2))", U("By",c_mu.."0","Is","x","d","y") )

addSubCat(3, 3, "Parallel Wires", "")
aF(3, 3, "Fw=("..c_mu.."0*I1*I2)/(2*"..c_Pi.."*D)", U("Fw",c_mu.."0","I1","I2","D"))
aF(3, 3, "Bx=("..c_mu.."0/(2*"..c_Pi.."))*(I1/x-I2/(D-x))", U("Bx",c_mu.."0","I1","I2","D","x" ))
aF(3, 3, "L=("..c_mu.."0/(4*"..c_Pi.."))+("..c_mu.."0/("..c_Pi.."))*arccosh(D/(2*a))", U("L",c_mu.."0","a","D" ))

addSubCat(3, 4, "Loop", "")
aF(3, 4, "B=("..c_mu.."0*I*a^2)/(2*(sqrt(a^2+z^2))^3)", U("B", c_mu.."0", "I", "a", "z") )
aF(3, 4, "Ls=("..c_mu.."0*a)*(ln(8*a/rr0)-2)", U(c_mu.."0", "a", "rr0") )
aF(3, 4, "L12=("..c_mu.."0*a)*cos("..c_theta..")/(2*"..c_pi..")*ln((bl+d)/d)", U("L12", c_mu.."0", "a", c_theta, c_pi, "bl", "d") )
aF(3, 4, "T12=("..c_mu.."0*a)*sin("..c_theta..")/(2*"..c_pi..")*I1*I2*ln((bl+d)/d)", U("T12", c_mu.."0", "a", c_theta, c_pi, "I1", "I2", "bl", "d") )

addSubCat(3, 5, "Coaxial Cable", "")
aF(3, 5, "L="..c_mu.."0/(8*"..c_pi..")+"..c_mu.."0/(2*"..c_pi..")*ln(rb/ra)", U("L", c_mu.."0", c_pi, "rb", "ra"))

addSubCat(3, 6, "Skin Effect", "")
aF(3, 6, c_delta.."=1/(sqrt(("..c_pi.."*f*"..c_mu.."0*"..c_mu.."r)/"..c_rho.."))", U(c_delta, c_mu.."0", c_mu.."r", c_pi, "f", c_rho))
aF(3, 6, "Reff=sqrt(("..c_pi.."*f*"..c_mu.."0*"..c_mu.."r*"..c_rho.."))", U("Reff", c_mu.."0", c_mu.."r", c_pi, "f", c_rho))


addCat(4, "Electron Motion", "Investigate the trajectories of electrons under the influence \nof electric and magnetic fields")

addCatVar(4, "A0", "Richardson\'s constant", "A/(m2*K2)")
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
addCatVar(4, c_phi, "Work function", "V")

addSubCat(4, 1, "Beam Deflection", "") 
aF(4, 1, "v=sqrt(2*(q/me)*Va)", U("v","q","me","Va")) 
aF(4, 1, "r=me*v/(q*B)", U("r","me","v","q","B")) 
aF(4, 1, "yd=L*Ls/(2*d*Va)*Vd", U("yd","L","Ls","d","Va","Vd")) 
aF(4, 1, "y=q*Vd/(2*me*d*v^2)*z^2", U("y","q","Vd","me","d","v","z")) 

addSubCat(4, 2, "Thermionic Emission", "") 
aF(4, 2, "I=A0*S*T^2*exp(-q*"..c_phi.."/(k*T))", U("I","A0","S","T","q",c_phi,"k")) 

addSubCat(4, 3, "Photoemission", "") 
aF(4, 3, "h*f=q*"..c_phi.."+1/2*me*v^2", U("h","f","q",c_phi,"me","v")) 
aF(4, 3, "f0=q*"..c_phi.."/h", U("f0","q",c_phi,"h")) 


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
addCatVar(5, "Radj", "Adjustable resistor", c_CAPomega)
addCatVar(5, "Rg", "Galvanometer resistance", c_CAPomega)
addCatVar(5, "Rj", "Resistance in L pad", c_CAPomega)
addCatVar(5, "Rk", "Resistance in L pad", c_CAPomega)
addCatVar(5, "Rl", "Resistance from left", c_CAPomega)
addCatVar(5, "Rm", "Meter resistance", c_CAPomega)
addCatVar(5, "Rr", "Resistance from right", c_CAPomega)
addCatVar(5, "RR1", "Resistance, arm 1", c_CAPomega)
addCatVar(5, "RR2", "Resistance, arm 2", c_CAPomega)
addCatVar(5, "RR3", "Resistance, arm 3", c_CAPomega)
addCatVar(5, "RR4", "Resistance, arm 4", c_CAPomega)
addCatVar(5, "Rs", "Series resistance", c_CAPomega)
addCatVar(5, "Rse", "Series resistance", c_CAPomega)
addCatVar(5, "Rsh", "Shunt resistance", "A")
addCatVar(5, "Rx", "Unknown resistance", c_CAPomega)
addCatVar(5, "Vm", "Voltage across meter", "V")
addCatVar(5, "Vmax", "Maximum voltage", "V")
addCatVar(5, "Vs", "Source voltage", "V")
addCatVar(5, "Vsen", "Voltage sensitivity", "V")
addCatVar(5, c_omega, "Radian frequency", "rad/s")

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
aF(5, 3, "Cx=1/("..c_omega.."^2*Rs*Rx*Cs)", U("Cx",c_omega,"Rs","Rx","Cs")) 
aF(5, 3, "f=1/(2/"..c_Pi.."*Cs*Rs)", U("f","Cs","Rs")) 
aF(5, 3, c_omega.."=2*"..c_Pi.."*f", U(c_omega,"f")) 

addSubCat(5, 4, "Maxwell Bridge", "") 
aF(5, 4, "Cx=((RR3/RR1)-(Rs/Rx))*Cs", U("Cx","RR3","RR1","Rs","Rx","Cs")) 
aF(5, 4, "Cx=1/("..c_omega.."^2*Rs*Rx*Cs)", U("Cx",c_omega,"Rs","Rx","Cs")) 
aF(5, 4, "f=1/(2/"..c_Pi.."*Cs*Rs)", U("f","Cs","Rs")) 
aF(5, 4, c_omega.."=2*"..c_Pi.."*f", U(c_omega,"f")) 

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
addCatVar(6, "R", "Resistance", c_CAPomega)
addCatVar(6, "Rp", "Parallel resistance", c_CAPomega)
addCatVar(6, "Rs", "Series resistance", c_CAPomega)
addCatVar(6, c_tau, "Time constant", "s")
addCatVar(6, "t", "Time", "s")
addCatVar(6, "vC", "Capacitor voltage", "V")
addCatVar(6, "vL", "Inductor voltage", "V")
addCatVar(6, "V0", "Initial capacitor voltage", "V")
addCatVar(6, "Vs", "Voltage stimulus", "V")
addCatVar(6, c_omega, "Radian frequency", "rad/s") -- lowercase omega
addCatVar(6, "W", "Energy dissipated", "J")

addSubCat(6, 1, "RL Natural Response", "") 
aF(6, 1, c_tau.."=L/R", U(c_tau,"L","R")) 
aF(6, 1, "vL=I0*R*exp(-t/"..c_tau..")", U("vL","I0","R","t",c_tau)) 
aF(6, 1, "iL=I0*exp(-t/"..c_tau..")", U("iL","I0","t",c_tau)) 
aF(6, 1, "W=1/2*L*I0^2*(1-exp(-2*t/"..c_tau.."))", U("W","L","I0","t",c_tau)) 

addSubCat(6, 2, "RC Natural Response", "") 
aF(6, 2, c_tau.."=R*C", U(c_tau,"R","C")) 
aF(6, 2, "vC=V0*exp(-t/"..c_tau..")", U("vC","V0","t",c_tau)) 
aF(6, 2, "iC=V0/R*exp(-t/"..c_tau..")", U("iC","V0","R","t",c_tau)) 
aF(6, 2, "W=1/2*C*V0^2*(1-exp(-2*t/"..c_tau.."))", U("W","C","V0","t",c_tau)) 

addSubCat(6, 3, "RL Step Response", "") 
aF(6, 3, c_tau.."=L/R", U(c_tau,"L","R")) 
aF(6, 3, "vL=(Vs-I0*R)*exp(-t/"..c_tau..")", U("vL","Vs","I0","R","t",c_tau)) 
aF(6, 3, "iL=Vs/R+(I0-Vs/R)*exp(-t/"..c_tau..")", U("iL","Vs","R","I0","t",c_tau)) 

addSubCat(6, 4, "RC Step Response", "") 
aF(6, 4, c_tau.."=R*C", U(c_tau,"R","C")) 
aF(6, 4, "vC=Vs+(V0-Vs)*exp(-t/"..c_tau..")", U("vC","Vs","V0","t",c_tau)) 
aF(6, 4, "iC=(Vs-V0)/R*exp(-t/"..c_tau..")", U("iC","Vs","V0","R","t",c_tau)) 

addSubCat(6, 5, "RL Series-Parallel", "") 
aF(6, 5, c_omega.."=2*"..c_Pi.."*f", U(c_omega,"f")) 
aF(6, 5, "Qs="..c_omega.."*Ls/Rs", U("Qs",c_omega,"Ls","Rs")) 
aF(6, 5, "Rp=(Rs^2+"..c_omega.."^2*Ls^2)/Rs", U("Rp","Rs",c_omega,"Ls")) 
aF(6, 5, "Lp=(Rs^2+"..c_omega.."^2*Ls^2)/("..c_omega.."^2*Ls)", U("Lp","Rs",c_omega,"Ls")) 
aF(6, 5, "Qp=Rp/("..c_omega.."*Lp)", U("Qp","Rp",c_omega,"Lp")) 
aF(6, 5, "Rs="..c_omega.."^2*Lp^2*Rp/(Rp^2+"..c_omega.."^2*Lp^2)", U("Rs",c_omega,"Lp","Rp")) 
aF(6, 5, "Ls=Rp^2*Lp/(Rp^2+"..c_omega.."^2*Lp^2)", U("Ls","Rp","Lp",c_omega)) 
aF(6, 5, "Rp=Rs*(1+Qs^2)", U("Rp","Rs","Qs")) 
aF(6, 5, "Lp=Ls*(1+1/Qs^2)", U("Lp","Ls","Qs")) 
aF(6, 5, "Rs=Rp/(1+Qp^2)", U("Rs","Rp","Qp")) 
aF(6, 5, "Ls=Qp^2*Lp/(1+Qp^2)", U("Ls","Qp","Lp")) 

addSubCat(6, 6, "RC Series-Parallel", "") 
aF(6, 6, c_omega.."=2*"..c_Pi.."*f", U(c_omega,"f")) 
aF(6, 6, "Qs=1/("..c_omega.."*Rs*Cs)", U("Qs",c_omega,"Rs","Cs")) 
aF(6, 6, "Rp=Rs*(1+1/("..c_omega.."^2*Rs^2*Cs^2))", U("Rp","Rs",c_omega,"Cs")) 
aF(6, 6, "Cp=Cs/(1+"..c_omega.."^2*Cs^2*Rs^2)", U("Cp","Cs",c_omega,"Rs")) 
aF(6, 6, "Qp="..c_omega.."*Rp*Cp", U("Qp",c_omega,"Rp","Cp")) 
aF(6, 6, "Rs=Rp/(1+"..c_omega.."^2*Rp^2*Cp^2)", U("Rs","Rp",c_omega,"Cp")) 
aF(6, 6, "Cs=(1+"..c_omega.."^2*Rp^2*Cp^2)/("..c_omega.."^2*Rp^2*Cp)", U("Cs",c_omega,"Rp","Cp")) 
aF(6, 6, "Rp=Rs*(1+Qs^2)", U("Rp","Rs","Qs")) 
aF(6, 6, "Cp=Cs/(1+1/Qs^2)", U("Cp","Cs","Qs")) 
aF(6, 6, "Rs=Rp/(1+Qp^2)", U("Rs","Rp","Qp")) 
aF(6, 6, "Cs=Cp*(1+Qp^2)/Qp^2", U("Cs","Cp","Qp")) 


addCat(7, "RLC Circuits", "Compute the impedance, admittance, natural response and\ntransient behavior of RLC circuits")

addCatVar(7, c_alpha, "Neper\'s frequency", "rad/s") --alpha, apostrophe
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
addCatVar(7, c_theta, "Phase angle", "rad") --theta
addCatVar(7, "R", "Resistance", c_CAPomega)
addCatVar(7, "s1", "Characteristic frequency", "rad/s")
addCatVar(7, "s2", "Characteristic frequency", "rad/s")
addCatVar(7, "s1i", "Characteristic frequency (imaginary)", "rad/s")
addCatVar(7, "s1r", "Characteristic frequency (real)", "rad/s")
addCatVar(7, "s2i", "Characteristic frequency (imaginary)", "rad/s")
addCatVar(7, "s2r", "Characteristic frequency (real)", "rad/s")
addCatVar(7, "t", "Time", "s")
addCatVar(7, "v", "Capacitor voltage", "V")
addCatVar(7, "V0", "Initial capacitor voltage", "V")
addCatVar(7, c_omega, "Radian Frequency", "rad/s") -- lowercase omega
addCatVar(7, c_omega.."d", "Damped radian frequency", "rad/s")
addCatVar(7, c_omega.."0", "Classical radian frequency", "rad/s")
addCatVar(7, "X", "Reactance", c_CAPomega)
addCatVar(7, "XXC", "Capacitive reactance", c_CAPomega)
addCatVar(7, "XL", "Inductive reactance", c_CAPomega)
addCatVar(7, "Ym", "Admittance "..utf8(8211).." magnitude", "S")
addCatVar(7, "Zm", "Impedance "..utf8(8211).." magnitude", "S")

addSubCat(7, 1, "Series Impedance", "") 
aF(7, 1, "abs(Zm)^2=R^2+X^2", U("Zm","R","X")) 
aF(7, 1, c_theta.."=arctan(X/R)", U(c_theta,"X","R")) 
aF(7, 1, "X=XL+XXC", U("X","XL","XXC")) 
aF(7, 1, "XL="..c_omega.."*L", U("XL",c_omega,"L")) 
aF(7, 1, "XXC=-1/("..c_omega.."*C)", U("XXC",c_omega,"C")) 
aF(7, 1, c_omega.."=2*"..c_Pi.."*f", U(c_omega,"f")) 

addSubCat(7, 2, "Parallel Admittance", "") 
aF(7, 2, "abs(Ym)^2=G^2+B^2", U("Ym","G","B")) 
aF(7, 2, c_theta.."=arctan(G/B)", U(c_theta,"G","B")) 
aF(7, 2, "G=1/R", U("G","R")) 
aF(7, 2, "B=BL+BC", U("B","BL","BC")) 
aF(7, 2, "BL=-1/("..c_omega.."*L)", U("BL",c_omega,"L")) 
aF(7, 2, "BC="..c_omega.."*C", U("BC",c_omega,"C")) 
aF(7, 2, c_omega.."=2*"..c_Pi.."*f", U(c_omega,"f")) 

addSubCat(7, 3, "RLC Natural Response", "") 
aF(7, 3, "s1r=real(-"..c_alpha.."+sqrt("..c_alpha.."^2-"..c_omega.."0^2))", U("s1r",c_alpha,c_omega.."0")) 
aF(7, 3, "s1i=imag(-"..c_alpha.."+sqrt("..c_alpha.."^2-"..c_omega.."0^2))", U("s1i",c_alpha,c_omega.."0")) 
aF(7, 3, "s2r=real(-"..c_alpha.."-sqrt("..c_alpha.."^2-"..c_omega.."0^2))", U("s2r",c_alpha,c_omega.."0")) 
aF(7, 3, "s2i=imag(-"..c_alpha.."-sqrt("..c_alpha.."^2-"..c_omega.."0^2))", U("s2i",c_alpha,c_omega.."0")) 
aF(7, 3, c_omega.."0=sqrt(1/(L*C))", U(c_omega.."0","L","C")) 
aF(7, 3, c_alpha.."=1/(2*R*C)", U(c_alpha,"R","C")) 

addSubCat(7, 4, "Underdamped Transient Case", "") 
aF(7, 4, c_omega.."0=sqrt(1/(L*C))", U(c_omega.."0","L","C")) 
aF(7, 4, c_alpha.."=1/(2*R*C)", U(c_alpha,"R","C")) 
aF(7, 4, c_omega.."d=sqrt("..c_omega.."0^2-"..c_alpha.."^2)", U(c_omega.."d",c_omega.."0",c_alpha)) 
aF(7, 4, "v=B1*exp(-"..c_alpha.."*t)*cos("..c_omega.."d*t)+B2*exp(-"..c_alpha.."*t)*sin("..c_omega.."d*t)", U("v","B1",c_alpha,"t",c_omega.."d","B2")) 
aF(7, 4, "B1=V0", U("B1","V0")) 
aF(7, 4, "B2=-"..c_alpha.."/"..c_omega.."d*(V0-2R*I0)", U("B2",c_alpha,c_omega.."d","V0","R","I0")) 

addSubCat(7, 5, "Critically-Damped Transient Case", "") 
aF(7, 5, c_alpha.."=1/(2*R*C)", U(c_alpha,"R","C")) 
aF(7, 5, c_omega.."0=sqrt(1/(L*C))", U(c_omega.."0","L","C")) 
aF(7, 5, "v=D1*t*exp(-"..c_alpha.."*t)+D2*exp(-"..c_alpha.."*t)", U("v","D1","t",c_alpha,"D2")) 
aF(7, 5, "D1=I0/C+"..c_alpha.."*V0", U("D1","I0","C",c_alpha,"V0")) 
aF(7, 5, "D2=V0", U("D2","V0")) 

addSubCat(7, 6, "Overdamped Transient Case", "") 
aF(7, 6, "s1=-"..c_alpha.."+sqrt("..c_alpha.."^2-"..c_omega.."0^2)", U("s1",c_alpha,c_omega.."0")) 
aF(7, 6, "s2=-"..c_alpha.."-sqrt("..c_alpha.."^2-"..c_omega.."0^2)", U("s2",c_alpha,c_omega.."0")) 
aF(7, 6, c_omega.."0=1/sqrt(L*C)", U(c_omega.."0","L","C")) 
aF(7, 6, c_alpha.."=1/(2*R*C)", U(c_alpha,"R","C")) 
aF(7, 6, "v=A1*exp(s1*t)+A2*exp(s2*t)", U("v","A1","s1","t","A2","s2")) 
aF(7, 6, "A1=(V0*s2+1/C*(V0/R+I0))/(s2-s1)", U("A1","V0","s2","C","R","I0","s1")) 
aF(7, 6, "A2=-(V0*s1+1/C*(V0/R+I0))/(s2-s1)", U("A2","V0","s1","C","R","I0","s2")) 


addCat(8, "AC Circuits", "Calculate properties of AC circuits")

addCatVar(8, "C", "Capacitance", "F")
addCatVar(8, "f", "Frequency", "Hz")
addCatVar(8, "I", "Instantaneous current", "A")
addCatVar(8, "Im", "Current amplitude", "A")
addCatVar(8, "L", "Inductance", "H")
addCatVar(8, c_theta, "Impedance phase angle", "rad")
addCatVar(8, c_theta.."1", "Phase angle 1", "rad")
addCatVar(8, c_theta.."2", "Phase angle 2", "rad")
addCatVar(8, "R", "Resistance", c_CAPomega)
addCatVar(8, "RR1", "Resistance 1", c_CAPomega)
addCatVar(8, "RR2", "Resistance 2", c_CAPomega)
addCatVar(8, "t", "Time", "s")
addCatVar(8, "V", "Total voltage", "V")
addCatVar(8, "VC", "Voltage across capacitor", "V")
addCatVar(8, "VL", "Voltage across inductor", "V")
addCatVar(8, "Vm", "Maximum voltage", "V")
addCatVar(8, "VR", "Voltage across resistor", "V")
addCatVar(8, c_omega, "Radian frequency", "rad/s")
addCatVar(8, "X", "Reactance", c_CAPomega)
addCatVar(8, "XX1", "Reactance 1", c_CAPomega)
addCatVar(8, "XX2", "Reactance 2", c_CAPomega)
addCatVar(8, "Yc", "Admittance", "S")
addCatVar(8, "Z1m", "Impedance 1 magnitude", c_CAPomega)
addCatVar(8, "Z2m", "Impedance 2 magnitude", c_CAPomega)
addCatVar(8, "Zc", "Complex impedance", c_CAPomega)
addCatVar(8, "Zm", "Impedance magnitude", c_CAPomega)

addSubCat(8, 1, "RL Series Impedance", "") 
aF(8, 1, "I=Im*sin("..c_omega.."*t)", U("I","Im",c_omega,"t")) 
aF(8, 1, "abs(Zm)^2=R^2+"..c_omega.."^2*L^2", U("Zm","R",c_omega,"L")) 
aF(8, 1, "VR=Zm*Im*sin("..c_omega.."*t)*cos("..c_theta..")", U("VR","Zm","Im",c_omega,"t",c_theta)) 
aF(8, 1, "VL=Zm*Im*cos("..c_omega.."*t)*sin("..c_theta..")", U("VL","Zm","Im",c_omega,"t",c_theta)) 
aF(8, 1, "V=VR+VL", U("V","VR","VL")) 
aF(8, 1, "Vm=Im*Zm", U("Vm","Im","Zm")) 
aF(8, 1, c_theta.."=arctan("..c_omega.."*L/R)", U(c_theta,c_omega,"L","R")) 
aF(8, 1, c_omega.."=2*"..c_Pi.."*f", U(c_omega,"f")) 

addSubCat(8, 2, "RC Series Impedance", "") 
aF(8, 2, "I=Im*sin("..c_omega.."*t)", U("I","Im",c_omega,"t")) 
aF(8, 2, "abs(Zm)^2=R^2+1/("..c_omega.."*C)^2", U("Zm","R",c_omega,"C")) 
aF(8, 2, "VR=Zm*Im*sin("..c_omega.."*t)*cos("..c_theta..")", U("VR","Zm","Im",c_omega,"t",c_theta)) 
aF(8, 2, "VC=Zm*Im*cos("..c_omega.."*t)*sin("..c_theta..")", U("VC","Zm","Im",c_omega,"t",c_theta)) 
aF(8, 2, "V=VR+VC", U("V","VR","VC")) 
aF(8, 2, "Vm=Im*Zm", U("Vm","Im","Zm")) 
aF(8, 2, c_theta.."=arctan(-1/("..c_omega.."*C*R))", U(c_theta,c_omega,"C","R")) 
aF(8, 2, c_omega.."=2*"..c_Pi.."*f", U(c_omega,"f")) 

addSubCat(8, 3, "Impedance <-> Admittance", "") 
aF(8, 3, "Yc=1/Zc", U("Yc", "Zc"))

addSubCat(8, 4, "Two Impedances in Series", "") 
aF(8, 4, "abs(Zm)^2=R^2+X^2", U("Zm","R","X")) 
aF(8, 4, c_theta.."=arctan(X/R)", U(c_theta,"X","R")) 
aF(8, 4, "R=RR1+RR2", U("R","RR1","RR2")) 
aF(8, 4, "X=XX1+XX2", U("X","XX1","XX2")) 
aF(8, 4, "abs(Z1m)^2=RR1^2+XX1^2", U("Z1m","RR1","XX1")) 
aF(8, 4, "abs(Z2m)^2=RR2^2+XX2^2", U("Z2m","RR2","XX2")) 
aF(8, 4, c_theta.."1=arctan(XX1/RR1)", U(c_theta.."1","XX1","RR1")) 
aF(8, 4, c_theta.."2=arctan(XX2/RR2)", U(c_theta.."2","XX2","RR2")) 

addSubCat(8, 5, "Two Impedances in Parallel", "") 
aF(8, 5, "abs(Zm)^2=((RR1*RR2-XX1*XX2)^2+(RR1*XX2+RR2*XX1)^2)/((RR1+RR2)^2+(XX1+XX2)^2)", U("Zm","RR1","RR2","XX1","XX2")) 
aF(8, 5, c_theta.."=arctan((XX1*RR2+RR1*XX2)/(RR1*RR2-XX1*XX2))-arctan((XX1+XX2)/(RR1+RR2))", U(c_theta,"XX1","RR2","RR1","XX2")) 
aF(8, 5, "R=Zm*cos("..c_theta..")", U("R","Zm",c_theta)) 
aF(8, 5, "X=Zm*sin("..c_theta..")", U("X","Zm",c_theta)) 
aF(8, 5, "abs(Z1m)^2=RR1^2+XX1^2", U("Z1m","RR1","XX1")) 
aF(8, 5, "abs(Z2m)^2=RR2^2+XX2^2", U("Z2m","RR2","XX2")) 
aF(8, 5, c_theta.."1=arctan(XX1/RR1)", U(c_theta.."1","XX1","RR1")) 
aF(8, 5, c_theta.."2=arctan(XX2/RR2)", U(c_theta.."2","XX2","RR2")) 


addCat(9, "Polyphase Circuits", "") 

addCatVar(9, "IL", "Line current", "A")
addCatVar(9, "Ip", "Phase current", "A")
addCatVar(9, "P", "Power per phase", "W")
addCatVar(9, "PT", "Total power", "W")
addCatVar(9, c_theta, "Impedance angle", "rad")
addCatVar(9, "VL", "Line voltage", "V")
addCatVar(9, "Vp", "Phase voltage", "V")
addCatVar(9, "W1", "Wattmeter 1", "W")
addCatVar(9, "W2", "Wattmeter 2", "W")

addSubCat(9, 1, "Balanced Delta Network", "") 
aF(9, 1, "VL=Vp", U("VL","Vp")) 
aF(9, 1, "IL=sqrt(3)*Ip", U("IL","Ip")) 
aF(9, 1, "P=Vp*Ip*cos("..c_theta..")", U("P","Vp","Ip",c_theta)) 
aF(9, 1, "PT=3*Vp*Ip*cos("..c_theta..")", U("PT","Vp","Ip",c_theta)) 
aF(9, 1, "PT=sqrt(3)*VL*IL*cos("..c_theta..")", U("PT","VL","IL",c_theta)) 

addSubCat(9, 2, "Balanced Wye Network", "") 
aF(9, 2, "VL=sqrt(3)*Vp", U("VL","Vp")) 
aF(9, 2, "IL=Ip", U("IL","Ip")) 
aF(9, 2, "P=Vp*Ip*cos("..c_theta..")", U("P","Vp","Ip",c_theta)) 
aF(9, 2, "PT=3*Vp*Ip*cos("..c_theta..")", U("PT","Vp","Ip",c_theta)) 
aF(9, 2, "PT=sqrt(3)*VL*IL*cos("..c_theta..")", U("PT","VL","IL",c_theta)) 

addSubCat(9, 3, "Power Measurements", "") 
aF(9, 3, "W1=VL*IL*cos("..c_theta.."+"..c_Pi.."/6)", U("W1","VL","IL",c_theta,c_Pi)) 
aF(9, 3, "W2=VL*IL*cos("..c_theta.."-"..c_Pi.."/6)", U("W2","VL","IL",c_theta,c_Pi)) 
aF(9, 3, "PT=sqrt(3)*VL*IL*cos("..c_theta..")", U("PT","VL","IL",c_theta)) 


addCat(10, "Electrical Resonance", "") 

addCatVar(10, c_alpha, "Damping coefficient", "rad/s")
addCatVar(10, c_beta, "Bandwidth", "rad/s")
addCatVar(10, "C", "Capacitance", "F")
addCatVar(10, "Im", "Current", "A")
addCatVar(10, "L", "Inductance", "H")
addCatVar(10, c_theta, "Phase angle", "rad")
addCatVar(10, "Q", "Quality factor", "unitless")
addCatVar(10, "R", "Resistance", c_CAPomega)
addCatVar(10, "Rg", "Generator resistance", c_CAPomega)
addCatVar(10, "Vm", "Maximum voltage", "V")
addCatVar(10, c_omega, "Radian frequency", "rad/s")
addCatVar(10, c_omega.."0", "Resonant frequency", "rad/s")
addCatVar(10, c_omega.."1", "Lower cutoff frequency", "rad/s")
addCatVar(10, c_omega.."2", "Upper cutoff frequency", "rad/s")
addCatVar(10, c_omega.."d", "Damped resonant frequency", "rad/s")
addCatVar(10, c_omega.."m", "Frequency for maximum amplitude", "rad/s")
addCatVar(10, "Yres", "Admittance at resonance", "S")
addCatVar(10, "Z", "Impedance", c_CAPomega)
addCatVar(10, "Zres", "Impedance at resonance", c_CAPomega)

addSubCat(10, 1, "Parallel Resonance I", "") 
aF(10, 1, "Vm=Im/sqrt(1/R^2+("..c_omega.."*C-1/("..c_omega.."*L))^2)", U("Vm","Im","R",c_omega,"C","L")) 
aF(10, 1, c_theta.."=arctan(("..c_omega.."*C-1/("..c_omega.."*L))*R)", U(c_theta,c_omega,"C","L","R")) 
aF(10, 1, c_omega.."0=1/sqrt(L*C)", U(c_omega.."0","L","C")) 
aF(10, 1, c_omega.."1=-1/(2*R*C)+sqrt(1/(2*R*C)^2+1/(L*C))", U(c_omega.."1","R","C","L")) 
aF(10, 1, c_omega.."2= 1/(2*R*C)+sqrt(1/(2*R*C)^2+1/(L*C))", U(c_omega.."2","R","C","L")) 
aF(10, 1, c_beta.."="..c_omega.."2-"..c_omega.."1", U(c_beta,c_omega.."2",c_omega.."1")) 
aF(10, 1, "Q="..c_omega.."0/"..c_beta, U("Q",c_omega.."0",c_beta)) 
aF(10, 1, "Q=R*sqrt(C/L)", U("Q","R","C","L")) 
aF(10, 1, "Q="..c_omega.."0*R*C", U("Q",c_omega.."0","R","C")) 

addSubCat(10, 2, "Parallel Resonance II", "") 
aF(10, 2, "Q="..c_omega.."0/"..c_beta, U("Q",c_omega.."0",c_beta)) 
aF(10, 2, c_omega.."1="..c_omega.."0*(-1/(2*Q)+sqrt(1/(2*Q)^2+1))", U(c_omega.."1",c_omega.."0","Q")) 
aF(10, 2, c_omega.."2="..c_omega.."0*( 1/(2*Q)+sqrt(1/(2*Q)^2+1))", U(c_omega.."2",c_omega.."0","Q")) 
aF(10, 2, c_alpha.."=1/(2*R*C)", U(c_alpha,"R","C")) 
aF(10, 2, c_alpha.."="..c_omega.."0/(2*Q)", U(c_alpha,c_omega.."0","Q")) 
aF(10, 2, c_omega.."d=sqrt("..c_omega.."0^2-"..c_alpha.."^2)", U(c_omega.."d",c_omega.."0",c_alpha)) 
aF(10, 2, c_omega.."d="..c_omega.."0*sqrt(1-1/(4*Q^2))", U(c_omega.."d",c_omega.."0","Q")) 

addSubCat(10, 3, "Resonance in a Lossy Inductor", "") 
aF(10, 3, c_omega.."0=sqrt(1/(L*C)-(R/L)^2)", U(c_omega.."0","L","C","R")) 
aF(10, 3, "Yres=(L+Rg*R*C)/(L*Rg)", U("Yres","L","Rg","R","C")) 
aF(10, 3, "Zres=1/Yres", U("Zres","Yres")) 
aF(10, 3, c_omega.."m=sqrt(sqrt((1/(L*C))^2*(1+2*R/Rg)+(R/L)^2*(2/(L*C)))-(R/L)^2)", U(c_omega.."m","L","C","R","Rg")) 

addSubCat(10, 4, "Series Resonance", "") 
aF(10, 4, c_omega.."0=(1/sqrt(L*C))", U(c_omega.."0","L","C")) 
aF(10, 4, "Z=sqrt(R^2+("..c_omega.."*L-1/("..c_omega.."*C))^2)", U("Z","R",c_omega,"L","C")) 
aF(10, 4, c_theta.."=arctan(("..c_omega.."*L-1/("..c_omega.."*C))/R)", U(c_theta,c_omega,"L","C","R")) 
aF(10, 4, c_omega.."1=-R/(2*L)+sqrt((R/(2*L))^2+1/(L*C))", U(c_omega.."1","R","L","C")) 
aF(10, 4, c_omega.."2=R/(2*L)+sqrt((R/(2*L))^2+1/(L*C))", U(c_omega.."2","R","L","C")) 
aF(10, 4, c_beta.."="..c_omega.."2-"..c_omega.."1", U(c_beta,c_omega.."2",c_omega.."1")) 
aF(10, 4, c_beta.."=R/L", U(c_beta,"R","L")) 
aF(10, 4, "Q="..c_omega.."0*L/R", U("Q",c_omega.."0","L","R")) 
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
addCatVar(11, "RR1", "Input resistor", c_CAPomega)
addCatVar(11, "RR2", "Current stabilizor", c_CAPomega)
addCatVar(11, "RR3", "Feedback resistor", c_CAPomega)
addCatVar(11, "RR4", "Resistor", c_CAPomega)
addCatVar(11, "Rf", "Feedback resistor", c_CAPomega)
addCatVar(11, "Rin", "Input resistance", c_CAPomega)
addCatVar(11, "Rl", "Load resistance", c_CAPomega)
addCatVar(11, "Ro", "Output resistance, OpAmp", c_CAPomega)
addCatVar(11, "Rout", "Output resistance", c_CAPomega)
addCatVar(11, "Rp", "Bias current resistor", c_CAPomega)
addCatVar(11, "Rs", "Voltage divide resistor", c_CAPomega)
addCatVar(11, "tr", "10-90% rise time", "s")
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
aF(11, 5, "dVH=(Vz1+Vz2)*Rp/(Rp+Rf)", U("dVH","Vz1","Vz2","Rp","Rf")) 
aF(11, 5, "VU=(VR*Rf+Rp*Vz1)/(Rf+Rp)", U("VU","VR","Rf","Rp","Vz1")) 
aF(11, 5, "VL=(VR*Rf-Rp*Vz2)/(Rf+Rp)", U("VL","VR","Rf","Rp","Vz2")) 

addSubCat(11, 6, "Level Detector (Non-inverting)", "") 
aF(11, 6, "RR1=Rp*Rf/(Rp+Rf)", U("RR1","Rp","Rf")) 
aF(11, 6, "dVH=(Vz1+Vz2)*Rp/(Rp+Rf)", U("dVH","Vz1","Vz2","Rp","Rf")) 
aF(11, 6, "VU=(VR*(Rf+Rp)+Rp*Vz2)/Rf", U("VU","VR","Rf","Rp","Vz2")) 
aF(11, 6, "VL=(VR*(Rp+Rf)-Rp*Vz1)/Rf", U("VL","VR","Rp","Rf","Vz1")) 

addSubCat(11, 7, "Differentiator", "") 
aF(11, 7, "Rf=Vomax/IIf", U("Rf","Vomax","IIf")) 
aF(11, 7, "Rp=Rf", U("Rp","Rf")) 
aF(11, 7, "CC1=Vomax/(Rf*Vrate)", U("CC1","Vomax","Rf","Vrate")) 
aF(11, 7, "RR1=1/(2*"..c_Pi.."*fd*CC1)", U("RR1","fd","CC1")) 
aF(11, 7, "fd=1/(2*"..c_Pi.."*Rf*CC1)", U("fd","Rf","CC1")) 
aF(11, 7, "Cp=10/(2*"..c_Pi.."*f0*Rp)", U("Cp","f0","Rp")) 
aF(11, 7, "Cf=1/(4*"..c_Pi.."*f0*Rf)", U("Cf","f0","Rf")) 

addSubCat(11, 8, "Differential Amplifier", "") 
aF(11, 8, "Ad=RR3/RR1", U("Ad","RR3","RR1")) 
aF(11, 8, "Aco=RR3^2/(RR1*(RR1+RR3)*CMRR)", U("Aco","RR3","RR1","CMRR")) 
aF(11, 8, "Ad=(Av*RR3)/sqrt(RR1^2*Av^2+RR3^2)", U("Ad","Av","RR3","RR1")) 
aF(11, 8, "Acc=(RR4*RR1-RR2*RR3)/(RR1*(RR2+RR4))", U("Acc","RR4","RR1","RR2","RR3")) 


addCat(12, "Solid State Devices", "") 

addCatVar(12, c_alpha, "CB current gain", "unitless")
addCatVar(12, "aLGJ", "Linearly graded junction parameter", "1/m4")
addCatVar(12, "A", "Area", "m2")
addCatVar(12, "A1", "EB junction area", "m2")
addCatVar(12, "A2", "CB junction area", "m2")
addCatVar(12, c_alpha.."f", "Forward "..c_alpha, "unitless")
addCatVar(12, "Aj", "Junction area", "m2")
addCatVar(12, c_alpha.."r", "Reverse "..c_alpha, "unitless")
addCatVar(12, c_beta, "CE current gain", "unitless")
addCatVar(12, "b", "Channel width", "m")
addCatVar(12, c_beta.."f", "Forward "..c_beta, "unitless")
addCatVar(12, c_beta.."r", "Reverse "..c_beta, "unitless")
addCatVar(12, "Cj", "Junction capacitance", "F")
addCatVar(12, "CL", "Load capacitance", "F")
addCatVar(12, "Cox", "Oxide capacitance per unit area", "F/m2")
addCatVar(12, "D", "Diffusion coefficient", "m2/s")
addCatVar(12, "DB", "Base diffusion coefficient", "m2/s")
addCatVar(12, "DC", "Collector diffusion coefficient", "m2/s")
addCatVar(12, "DE", "Emitter diffusion coefficient", "m2/s")
addCatVar(12, "Dn", "n diffusion coefficient", "m2/s")
addCatVar(12, "Dp", "p diffusion coefficient", "m2/s")
addCatVar(12, c_epsilon.."ox", "Oxide permittivity", "unitless")
addCatVar(12, c_epsilon.."s", "Silicon Permittivity", "unitless")
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
addCatVar(12, c_mu.."n", "n (electron) mobility", "m2/(V*s)")
addCatVar(12, c_mu.."p", "p (positive charge) mobility", "m2/(V*s)")
addCatVar(12, "mn", "n effective mass", "unitless")
addCatVar(12, "mp", "p effective mass", "unitless")
addCatVar(12, "N", "Doping concentration", "1/m3")
addCatVar(12, "Na", "Acceptor density", "1/m3")
addCatVar(12, "nC", "n density, collector", "1/m3")
addCatVar(12, "Nd", "Donor density", "1/m3")
addCatVar(12, "nE", "n density, emitter", "1/m3")
addCatVar(12, "ni", "Intrinsic density", "1/m3")
addCatVar(12, "N0", "Surface concentration", "1/m3")
addCatVar(12, "npo", "n density in p material", "1/m3")
addCatVar(12, "p", "p density", "1/m3")
addCatVar(12, "pB", "p density, base", "1/m3")
addCatVar(12, c_phi.."F", "Fermi potential", "V")
addCatVar(12, c_phi.."GC", "Work function potential", "V")
addCatVar(12, "pno", "p density in n material", "1/m3")
addCatVar(12, "Qtot", "Total surface impurities", "unitless")
addCatVar(12, "Qb", "Bulk charge at bias", "C/m2")
addCatVar(12, "Qb0", "Bulk charge at 0 bias", "C/m2")
addCatVar(12, "Qox", "Oxide charge density", "C/m2")
addCatVar(12, "Qsat", "Base Q, transition edge", "C")
addCatVar(12, c_rho.."n", "n resistivity", c_CAPomega.."*m")
addCatVar(12, c_rho.."p", "p resistivity", c_CAPomega.."*m")
addCatVar(12, "Rl", "Load resistance", c_CAPomega)
addCatVar(12, c_tau.."B", "lifetime in base", "s")
addCatVar(12, c_tau.."D", "Time constant", "s")
addCatVar(12, c_tau.."L", "Time constant", "s")
addCatVar(12, c_tau.."o", "Lifetime", "s")
addCatVar(12, c_tau.."p", "Minority carrier lifetime", "s")
addCatVar(12, c_tau.."t", "Base transit time", "s")
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
aF(12, 1, c_rho.."n=1/(q*"..c_mu.."n*Nd)", U(c_rho.."n","q",c_mu.."n","Nd")) 
aF(12, 1, c_rho.."p=1/(q*"..c_mu.."p*Na)", U(c_rho.."p","q",c_mu.."p","Na")) 
aF(12, 1, "Dn=((k*TT)/q)*"..c_mu.."n", U("Dn","k","TT","q",c_mu.."n")) 
aF(12, 1, "Dp=((k*TT)/q)*"..c_mu.."p", U("Dp","k","TT","q",c_mu.."p")) 
aF(12, 1, "Ei=EF+(k*TT*ln(Na/ni(TT)))", U("Ei","EF","k","TT","Na")) 
aF(12, 1, "EF=Ei+(k*TT*ln(Nd/ni(TT)))", U("EF","Ei","k","TT","Nd")) 
aF(12, 1, "Ei=(Ec+Ev)/2+3/4*(k*TT)*ln(mp/mn)", U("Ei","Ec","Ev","k","TT","mp","mn")) 
aF(12, 1, "N/N0=erfc(x/(2*sqrt(D*t)))", U("N","N0","x","D","t")) 
aF(12, 1, "N=Qtot/(A*sqrt("..c_Pi.."*D*t))*exp(-x^2/(4*D*t))", U("N","Qtot","A","D","t","x")) 

addSubCat(12, 2, "PN Junctions", "") 
aF(12, 2, "Vbi=k*TT/q*ln(Nd*Na/ni(TT)^2)", U("Vbi","k","TT","q","Nd","Na")) 
aF(12, 2, "xn=sqrt(2*"..c_epsilon.."s*"..c_epsilon.."0*abs(Vbi-Va)*Na/(q*Nd*(Na+Nd)))", U("xn",c_epsilon.."s",c_epsilon.."0","Vbi","Va","Na","q","Nd")) 
aF(12, 2, "xp=(Nd/Na)*xn", U("xp","Nd","Na","xn")) 
aF(12, 2, "xd=xn+xp", U("xd","xn","xp")) 
aF(12, 2, "Cj="..c_epsilon.."s*"..c_epsilon.."0*Aj/xd", U("Cj",c_epsilon.."s",c_epsilon.."0","Aj","xd")) 
aF(12, 2, "Vbi=2*k*TT/q*ln(aLGJ*xd/(2*ni(TT)))", U("Vbi","k","TT","q","aLGJ","xd")) 
aF(12, 2, "xd=(12*"..c_epsilon.."s*"..c_epsilon.."0/(q*aLGJ)*abs(Vbi-Va))^(1/3)", U("xd",c_epsilon.."s",c_epsilon.."0","q","aLGJ","Vbi","Va")) 

addSubCat(12, 3, "PN Junction Currents", "") 
aF(12, 3, "I=q*Aj*(Dn/LLn*npo+Dp/Lp*pno)*(exp(q*Va/(k*TT))-1)", U("I","q","Aj","Dn","LLn","npo","Dp","Lp","pno","Va","k","TT")) 
aF(12, 3, "I=I0*(exp(q*Va/(k*TT))-1)", U("I","I0","q","Va","k","TT")) 
aF(12, 3, "I0=q*Aj*(Dn/LLn*npo+Dp/Lp*pno)", U("I0","q","Aj","Dn","LLn","npo","Dp","Lp","pno")) 
aF(12, 3, "IRG0=-q*Aj*ni(TT)*xd/(2*"..c_tau.."o)", U("IRG0","q","Aj","TT","xd",c_tau.."o")) 
aF(12, 3, "IRG=q*Aj*ni(TT)*xd/(2*"..c_tau.."o)*(exp(q*Va/(2*k*TT))-1)", U("IRG","q","Aj","TT","xd",c_tau.."o","Va","k")) 
aF(12, 3, "Go=q/(k*TT)*(I+I0)", U("Go","q","k","TT","I","I0")) 
aF(12, 3, "ts="..c_tau.."p*ln(1+IIf/Ir)", U("ts",c_tau.."p","IIf","Ir")) 
aF(12, 3, "1/(1+Ir/IIf)=erf(sqrt(ts/"..c_tau.."p))", U("Ir","IIf","ts",c_tau.."p")) 

addSubCat(12, 4, "Transistor Currents", "") 
aF(12, 4, c_alpha.."=IC/IE", U(c_alpha,"IC","IE")) 
aF(12, 4, c_beta.."="..c_alpha.."/(1-"..c_alpha..")", U(c_beta,c_alpha)) 
aF(12, 4, "IE=IB+IC", U("IE","IB","IC")) 
aF(12, 4, "IC="..c_alpha.."*IE+ICB0", U("IC",c_alpha,"IE","ICB0")) 
aF(12, 4, "IC="..c_alpha.."/(1-"..c_alpha..")*IB+ICB0/(1-"..c_alpha..")", U("IC",c_alpha,"IB","ICB0")) 
aF(12, 4, "IC="..c_beta.."*IB+ICE0", U("IC",c_beta,"IB","ICE0")) 
aF(12, 4, "ICE0=ICB0*("..c_beta.."+1)", U("ICE0","ICB0",c_beta)) 

addSubCat(12, 5, "Ebers-Moll Equations", "") 
aF(12, 5, "IE=IIf-"..c_alpha.."r*Ir", U("IE","IIf",c_alpha.."r","Ir")) 
aF(12, 5, "IC="..c_alpha.."f*IIf-Ir", U("IC",c_alpha.."f","IIf","Ir")) 
aF(12, 5, "IB=(1-"..c_alpha.."f)*IIf+(1-"..c_alpha.."r)*Ir", U("IB",c_alpha.."f","IIf",c_alpha.."r","Ir")) 
aF(12, 5, c_beta.."f="..c_alpha.."f/(1-"..c_alpha.."f)", U(c_beta.."f",c_alpha.."f")) 
aF(12, 5, c_beta.."r="..c_alpha.."r/(1-"..c_alpha.."r)", U(c_beta.."r",c_alpha.."r")) 
aF(12, 5, c_alpha.."f*IIf=Is", U(c_alpha.."f","IIf","Is")) 
aF(12, 5, c_alpha.."r*Ir=Is", U(c_alpha.."r","Ir","Is")) 
aF(12, 5, "ICB0=(1-"..c_alpha.."r*"..c_alpha.."f)*Ir0", U("ICB0",c_alpha.."r",c_alpha.."f","Ir0")) 
aF(12, 5, "ICE0=ICB0*("..c_beta.."f+1)", U("ICE0","ICB0",c_beta.."f")) 
aF(12, 5, "ICE0=Ir0*(1-"..c_alpha.."f*"..c_alpha.."r)/(1-"..c_alpha.."f)", U("ICE0","Ir0",c_alpha.."f",c_alpha.."r")) 

addSubCat(12, 6, "Ideal Currents - pnp", "") 
aF(12, 6, "IE=q*A1*(DE*nE/LE+DB*pB/WB)*(exp((q*VEB)/(k*TT))-1)-q*A2*DB/WB*pB*(exp((q*VCB)/(k*TT))-1)", U("IE","q","A1","DE","nE","LE","DB","pB","WB","VEB","k","TT","A2","VCB")) 
aF(12, 6, "IC=q*A1*DB*pB/WB*(exp((q*VEB)/(k*TT))-1)-q*A2*(DC*nC/LC+DB*pB/WB)*(exp((q*VCB)/(k*TT))-1)", U("IC","q","A1","DB","pB","WB","VEB","k","TT","A2","DC","nC","LC","VCB")) 
aF(12, 6, "IB=q*A1*DE/LE*nE*(exp((q*VBE)/(k*TT))-1)+q*A2*DC/LC*nC*(exp((q*VCB)/(k*TT))-1)", U("IB","q","A1","DE","LE","nE","VBE","k","TT","A2","DC","LC","nC","VCB")) 
aF(12, 6, c_alpha.."=((DB*pB)/WB)/(DB*pB/WB+DE*nE/LE)", U(c_alpha,"DB","pB","WB","DE","nE","LE")) 

addSubCat(12, 7, "Switching Transients", "") 
aF(12, 7, "Qsat=ICsat*"..c_tau.."t", U("Qsat","ICsat",c_tau.."t")) 
aF(12, 7, "ICsat=VCC/Rl", U("ICsat","VCC","Rl")) 
aF(12, 7, "tr="..c_tau.."B*ln(1/(1-(ICsat*"..c_tau.."t)/(IB*"..c_tau.."B)))", U("tr",c_tau.."B","ICsat",c_tau.."t","IB")) 
aF(12, 7, "tsd1="..c_tau.."B*ln(IB*"..c_tau.."B/(ICsat*"..c_tau.."t))", U("tsd1",c_tau.."B","IB","ICsat",c_tau.."t")) 
aF(12, 7, "tsd2="..c_tau.."B*ln(2*IB*"..c_tau.."B/(ICsat*"..c_tau.."t*(1+IB*"..c_tau.."B/(ICsat*"..c_tau.."t))))", U("tsd2",c_tau.."B","IB","ICsat",c_tau.."t")) 
aF(12, 7, "VCEs=k*TT/q*ln(1+IC/IB*(1-"..c_alpha.."r)/("..c_alpha.."r*(1-IC/IB*(1-"..c_alpha.."f)/"..c_alpha.."f)))", U("VCEs","k","TT","q","IC","IB",c_alpha.."r",c_alpha.."f")) 

addSubCat(12, 8, "MOS Transistor I", "") 
aF(12, 8, c_phi.."F=k*TT/q*ln(ni(TT)/p)", U(c_phi.."F","k","TT","q","p")) 
aF(12, 8, "xd=sqrt(2*"..c_epsilon.."s*"..c_epsilon.."0*(2*"..c_phi.."F)/(q*Na))", U("xd",c_epsilon.."s",c_epsilon.."0",c_phi.."F","q","Na")) 
aF(12, 8, "Qb0=-sqrt(2*q*Na*"..c_epsilon.."s*"..c_epsilon.."0*abs(2*"..c_phi.."F))", U("Qb0","q","Na",c_epsilon.."s",c_epsilon.."0",c_phi.."F")) 
aF(12, 8, "Qb=-sqrt(2*q*Na*"..c_epsilon.."s*"..c_epsilon.."0*abs(-2*"..c_phi.."F+VSB))", U("Qb","q","Na",c_epsilon.."s",c_epsilon.."0",c_phi.."F","VSB")) 
aF(12, 8, "Cox="..c_epsilon.."ox*"..c_epsilon.."0/tox", U("Cox",c_epsilon.."ox",c_epsilon.."0","tox")) 
aF(12, 8, "f=1/Cox*sqrt(2*q*Na*"..c_epsilon.."s*"..c_epsilon.."0)", U("Cox","q","Na",c_epsilon.."s",c_epsilon.."0")) 
aF(12, 8, "VT0="..c_phi.."GC-2*"..c_phi.."F-Qb0/Cox-Qox/Cox", U("VT0",c_phi.."GC",c_phi.."F","Qb0","Cox","Qox")) 

addSubCat(12, 9, "MOS Transistor II", "") 
aF(12, 9, "kn1="..c_mu.."n*Cox", U("kn1",c_mu.."n","Cox")) 
aF(12, 9, "kn1="..c_mu.."n*"..c_epsilon.."ox*"..c_epsilon.."0/tox", U("kn1",c_mu.."n",c_epsilon.."ox",c_epsilon.."0","tox")) 
aF(12, 9, "kn=kn1*W/L", U("kn","kn1","W","L")) 
aF(12, 9, "IDmod=kn/2*(VGS-VT)^2*(1+"..utf8(137).."*VDS)", U("IDmod","kn","VGS","VT","VDS")) 
aF(12, 9, "ID=when(VGS-VT"..utf8(156).."VDS,kn/2*(2*(VGS-VT)*VDS-VDS^2),kn/2*(VGS-VT)^2)", U("ID","VGS","VT","VDS","kn")) 
aF(12, 9, "VT=VT0+f*(sqrt(abs(-2*"..c_phi.."F+VSB))-sqrt(2*"..c_phi.."F))", U("VT","VT0",c_phi.."F","VSB")) 
aF(12, 9, "gm=kn*(VGS-VT)", U("gm","kn","VGS","VT")) 
aF(12, 9, "Ttr=4/3*L^2/("..c_mu.."n*(VGS-VT))", U("Ttr","L",c_mu.."n","VGS","VT")) 
aF(12, 9, "ffmax=gm/(2*"..c_Pi.."*Cox*W*L)", U("ffmax","gm","Cox","W","L")) 
aF(12, 9, "gd=kn*(VGS-VT)", U("gd","kn","VGS","VT")) 

addSubCat(12, 10, "MOS Inverter (Resistive Load)", "") 
aF(12, 10, "kD="..c_mu.."n*Cox*WD/LD", U("kD",c_mu.."n","Cox","WD","LD")) 
aF(12, 10, "VOH=VDD", U("VOH","VDD")) 
aF(12, 10, "VOL^2-2*(1/(kD*Rl)+VDD-VT)*VOL+2*VDD/(kD*Rl)=0", U("VOL","kD","Rl","VDD","VT")) 
aF(12, 10, "kD/2*(2*(VIH-VT)*Vo-Vo^2)=(VDD-Vo)/Rl", U("kD","VIH","VT","Vo","VDD","Rl")) 
aF(12, 10, "kD/2*(VM-VT)^2=(VDD-VM)/Rl", U("kD","VM","VT","VDD","Rl")) 

addSubCat(12, 11, "MOS Inverter (Saturated Load)", "") 
aF(12, 11, "kL="..c_mu.."n*Cox*WL/LL", U("kL",c_mu.."n","Cox","WL","LL")) 
aF(12, 11, "kD="..c_mu.."n*Cox*WD/LD", U("kD",c_mu.."n","Cox","WD","LD")) 
aF(12, 11, "KR=kD/kL", U("KR","kD","kL")) 
aF(12, 11, "VOH=VDD-(VT0+f*(sqrt(VOH+2*"..c_phi.."F)-sqrt(2*"..c_phi.."F)))", U("VOH","VDD","VT0",c_phi.."F")) 
aF(12, 11, "KR*(2*(Vin-VTD)*Vo-Vo^2)=(VDD-Vo-VTL)^2", U("KR","Vin","VTD","Vo","VDD","VTL")) 
aF(12, 11, "VTL=VT0+f*(sqrt(Vo+2*"..c_phi.."F)-sqrt(2*"..c_phi.."F))", U("VTL","VT0","Vo",c_phi.."F")) 
aF(12, 11, "VIH=(2*(VDD-VTL))/(sqrt(3*KR)+1)+VT0", U("VIH","VDD","VTL","KR","VT0")) 
aF(12, 11, "Vo=(VDD-VTL+VT0+VT0*sqrt(KR))/(1+sqrt(KR))", U("Vo","VDD","VTL","VT0","KR")) 
aF(12, 11, "gmL=kL*(VDD-VTL)", U("gmL","kL","VDD","VTL")) 
aF(12, 11, c_tau.."L=CL/gmL", U(c_tau.."L","CL","gmL")) 
aF(12, 11, "tch="..c_tau.."L*(V1/Vo-1)", U("tch",c_tau.."L","V1","Vo")) 
aF(12, 11, c_tau.."D=CL/(kD*(V1-VT0))", U(c_tau.."D","CL","kD","V1","VT0")) 
aF(12, 11, "tdis="..c_tau.."D*((2*VTD)/(V1-VTD)+ln(2*(V1-VTD)/Vo-1))", U("tdis",c_tau.."D","VTD","V1","Vo")) 

addSubCat(12, 12, "MOS Inverter (Depletion Load)", "") 
aF(12, 12, "kL="..c_mu.."n*Cox*WL/LL", U("kL",c_mu.."n","Cox","WL","LL")) 
aF(12, 12, "kD="..c_mu.."n*Cox*WD/LD", U("kD",c_mu.."n","Cox","WD","LD")) 
aF(12, 12, "kD/2*(2*(VOH-VT0)*VOL-VOL^2)=kL/2*VTL^2", U("kD","VOH","VT0","VOL","kL","VTL")) 
aF(12, 12, "VTL=VTL0+f*(sqrt(Vo+2*"..c_phi.."F)-sqrt(2*"..c_phi.."F))", U("VTL","VTL0","Vo",c_phi.."F")) 
aF(12, 12, "tch=CL*VL/I0", U("tch","CL","VL","I0")) 
aF(12, 12, "I0=kL*VTL^2", U("I0","kL","VTL")) 

addSubCat(12, 13, "CMOS Transistor Pair", "") 
aF(12, 13, "kP="..c_mu.."p*Cox*WP/lP", U("kP",c_mu.."p","Cox","WP","lP")) 
aF(12, 13, "kN="..c_mu.."n*Cox*WN/lNN", U("kN",c_mu.."n","Cox","WN","lNN")) 
aF(12, 13, "VIH=2*Vo+VTN+(kP/kN)*(VDD-abs(VTP))/(1+kP/kN)", U("VIH","Vo","VTN","kP","kN","VDD","VTP")) 
aF(12, 13, "VIL=(2*Vo-VDD-VTP+kN/kP*VTN)/(1+kN/kP)", U("VIL","Vo","VDD","VTP","kN","kP","VTN")) 
aF(12, 13, "kN/2*(Vin-VTN)^2=kP/2*(VDD-Vin-abs(VTP))^2", U("kN","Vin","VTN","kP","VDD","VTP")) 

addSubCat(12, 14, "Junction FET", "") 
aF(12, 14, "ID=2*q*Z*"..c_mu.."n*Nd*b/L*(VDD-2/3*(Vbi-Vp)*(((VDD+Vbi-VG)/(Vbi-Vp))^1.5-((Vbi-VG)/(Vbi-Vp))^1.5))", U("ID","q","Z",c_mu.."n","Nd","b","L","VDD","Vbi","Vp","VG")) 
aF(12, 14, "IDsat=2*q*Z*"..c_mu.."n*Nd*b/L*(VDsat-2/3*(Vbi-Vp)*(((VDD+Vbi-VG)/(Vbi-Vp))^1.5-((Vbi-VG)/(Vbi-Vp))^1.5))", U("IDsat","q","Z",c_mu.."n","Nd","b","L","VDsat","Vbi","Vp","VDD","VG")) 
aF(12, 14, "b=sqrt(2*"..c_epsilon.."0*"..c_epsilon.."s/(q*Nd)*(Vbi+VDsat-VG))", U("b",c_epsilon.."0",c_epsilon.."s","q","Nd","Vbi","VDsat","VG")) 
aF(12, 14, "VDsat=VG-Vp", U("VDsat","VG","Vp")) 
aF(12, 14, "IDsat=ID0*(1-VG/Vp)^2", U("IDsat","ID0","VG","Vp")) 


addCat(13, "Linear Amplifiers", "") 

addCatVar(13, c_alpha.."0", "Current gain, CE", "unitless")
addCatVar(13, "Ac", "Common mode gain", "unitless")
addCatVar(13, "Ad", "Differential mode gain", "unitless")
addCatVar(13, "Ai", "Current gain, CB", "unitless")
addCatVar(13, "Aov", "Overall voltage gain", "unitless")
addCatVar(13, "Av", "Voltage gain, CC/CD", "unitless")
addCatVar(13, c_beta.."0", "Current gain, CB", "unitless")
addCatVar(13, "CMRR", "Common mode reject ratio", "unitless")
addCatVar(13, "gm", "Transconductance", "S")
addCatVar(13, c_mu, "Amplification factor", "unitless")
addCatVar(13, "rb", "Base resistance", c_CAPomega)
addCatVar(13, "rrc", "Collector resistance", c_CAPomega)
addCatVar(13, "rd", "Drain resistance", c_CAPomega)
addCatVar(13, "re", "Emitter resistance", c_CAPomega)
addCatVar(13, "RBA", "External base resistance", c_CAPomega)
addCatVar(13, "RCA", "External collector resistance", c_CAPomega)
addCatVar(13, "RDA", "External drain resistance", c_CAPomega)
addCatVar(13, "REA", "External emitter resistance", c_CAPomega)
addCatVar(13, "RG", "External gate resistance", c_CAPomega)
addCatVar(13, "Ric", "Common mode input resistance", c_CAPomega)
addCatVar(13, "Rid", "Differential input resistance", c_CAPomega)
addCatVar(13, "Rin", "Input resistance", c_CAPomega)
addCatVar(13, "Rl", "Load resistance", c_CAPomega)
addCatVar(13, "Ro", "Output resistance", c_CAPomega)
addCatVar(13, "Rs", "Source resistance", c_CAPomega)

addSubCat(13, 1, "BJT (Common Base)", "") 
aF(13, 1, c_beta.."0="..c_alpha.."0/(1-"..c_alpha.."0)", U(c_beta.."0",c_alpha.."0")) 
aF(13, 1, "Rin=re+rb/"..c_beta.."0", U("Rin","re","rb",c_beta.."0")) 
aF(13, 1, "Ro=rrc", U("Ro","rrc")) 
aF(13, 1, "Ai="..c_alpha.."0", U("Ai",c_alpha.."0")) 
aF(13, 1, "Av="..c_alpha.."0*Rl/(re+rb/"..c_beta.."0)", U("Av",c_alpha.."0","Rl","re","rb",c_beta.."0")) 
aF(13, 1, "Aov=("..c_alpha.."0*rrc)*(Rin/(Rin+Rs))/(re+rb/"..c_beta.."0)", U("Aov",c_alpha.."0","rrc","Rin","Rs","re","rb",c_beta.."0")) 

addSubCat(13, 2, "BJT (Common Emitter)", "") 
aF(13, 2, c_beta.."0="..c_alpha.."0/(1-"..c_alpha.."0)", U(c_beta.."0",c_alpha.."0")) 
aF(13, 2, "Rin=rb+"..c_beta.."0*re", U("Rin","rb",c_beta.."0","re")) 
aF(13, 2, "Ro=rrc", U("Ro","rrc")) 
aF(13, 2, "Ai=-"..c_beta.."0", U("Ai",c_beta.."0")) 
aF(13, 2, "Av=-"..c_beta.."0*Rl/("..c_beta.."0*re+rb)", U("Av",c_beta.."0","Rl","re","rb")) 
aF(13, 2, "Aov=-"..c_beta.."0*Rl/(Rs+Rin)", U("Aov",c_beta.."0","Rl","Rs","Rin")) 

addSubCat(13, 3, "BJT (Common Collector)", "") 
aF(13, 3, c_beta.."0="..c_alpha.."0/(1-"..c_alpha.."0)", U(c_beta.."0",c_alpha.."0")) 
aF(13, 3, "Rin=rb+"..c_beta.."0*re+("..c_beta.."0+1)*Rl", U("Rin","rb",c_beta.."0","re","Rl")) 
aF(13, 3, "Ro=re+(Rs+rb)/"..c_beta.."0", U("Ro","re","Rs","rb",c_beta.."0")) 
aF(13, 3, "Ai=rrc/(rrc*(1-"..c_alpha.."0)+Rl+re)", U("Ai","rrc",c_alpha.."0","Rl","re")) 
aF(13, 3, "Av="..c_alpha.."0*Rl/(re+Rl)", U("Av",c_alpha.."0","Rl","re")) 
aF(13, 3, "Aov=("..c_beta.."0+1)*Rl/(Rs+Rin+("..c_beta.."0+1)*Rl)", U("Aov",c_beta.."0","Rl","Rs","Rin")) 

addSubCat(13, 4, "FET (Common Gate)", "") 
aF(13, 4, c_mu.."=gm*rd", U(c_mu,"gm","rd")) 
aF(13, 4, "Rin=(Rl+rd)/("..c_mu.."+1)", U("Rin","Rl","rd",c_mu)) 
aF(13, 4, "Av=("..c_mu.."+1)*Rl/(rd+Rl)", U("Av",c_mu,"Rl","rd")) 
aF(13, 4, "Ro=rd+("..c_mu.."+1)*RG", U("Ro","rd",c_mu,"RG")) 

addSubCat(13, 5, "FET (Common Source)", "") 
aF(13, 5, c_mu.."=gm*rd", U(c_mu,"gm","rd")) 
aF(13, 5, "Rin=(Rl+rd)/("..c_mu.."+1)", U("Rin","Rl","rd",c_mu)) 
aF(13, 5, "Av=-gm*(rd*Rl/(rd+Rl))", U("Av","gm","rd","Rl")) 
aF(13, 5, "Ro=rd", U("Ro","rd")) 

addSubCat(13, 6, "FET (Common Drain)", "") 
aF(13, 6, c_mu.."=gm*rd", U(c_mu,"gm","rd")) 
aF(13, 6, "Rin=(Rl+rd)/("..c_mu.."+1)", U("Rin","Rl","rd",c_mu)) 
aF(13, 6, "Av="..c_mu.."*Rl/(("..c_mu.."+1)*Rl+rd)", U("Av",c_mu,"Rl","rd")) 
aF(13, 6, "Ro=rd/("..c_mu.."+1)", U("Ro","rd",c_mu)) 

addSubCat(13, 7, "Darlington (CC-CC)", "") 
aF(13, 7, "Rin="..c_beta.."0*(re+"..c_beta.."0*(re+Rl))", U("Rin",c_beta.."0","re","Rl")) 
aF(13, 7, "Ro=re+("..c_beta.."0*(re+rb)+Rs)/"..c_beta.."0^2", U("Ro","re",c_beta.."0","rb","Rs")) 
aF(13, 7, "Ai="..c_beta.."0^2*RBA/(RBA+"..c_beta.."0*(Rl+re))", U("Ai",c_beta.."0","RBA","Rl","re")) 

addSubCat(13, 8, "Darlington (CC-CE)", "") 
aF(13, 8, "Rin=rb+"..c_beta.."0*re", U("Rin","rb",c_beta.."0","re")) 
aF(13, 8, "Ro=rrc/"..c_beta.."0", U("Ro","rrc",c_beta.."0")) 
aF(13, 8, "Av=-Rl/(re+Rs/"..c_beta.."0^2)", U("Av","Rl","re","Rs",c_beta.."0")) 

addSubCat(13, 9, "Emitter-Coupled Amplifier", "") 
aF(13, 9, c_beta.."0="..c_alpha.."0/(1-"..c_alpha.."0)", U(c_beta.."0",c_alpha.."0")) 
aF(13, 9, "Av=Rl*("..c_beta.."0/(2*"..c_beta.."0*re+Rl))", U("Av","Rl",c_beta.."0","re")) 
aF(13, 9, "Ai=-"..c_alpha.."0*"..c_beta.."0", U("Ai",c_alpha.."0",c_beta.."0")) 
aF(13, 9, "Rin="..c_beta.."0*re+rb", U("Rin",c_beta.."0","re","rb")) 
aF(13, 9, "Ro=rrc", U("Ro","rrc")) 

addSubCat(13, 10, "Differential Amplifier", "") 
aF(13, 10, "Ad=-1/2*gm*RCA", U("Ad","gm","RCA")) 
aF(13, 10, "Ac=-"..c_alpha.."0*RCA/(2*REA+re)", U("Ac",c_alpha.."0","RCA","REA","re")) 
aF(13, 10, "Rid=2*(rb+"..c_beta.."0*re)", U("Rid","rb",c_beta.."0","re")) 
aF(13, 10, "Ric="..c_beta.."0*REA", U("Ric",c_beta.."0","REA")) 

addSubCat(13, 11, "Source-Coupled JFET Pair", "") 
aF(13, 11, "Ad=-1/2*gm*(rd*RDA)/(rd+RDA)", U("Ad","gm","rd","RDA")) 
aF(13, 11, "Ac=-"..c_mu.."*RDA/(("..c_mu.."+1)*2*Rs+rd+RDA)", U("Ac",c_mu,"RDA","Rs","rd")) 
aF(13, 11, c_mu.."=gm*rd", U(c_mu,"gm","rd")) 
aF(13, 11, "CMRR=gm*Rs", U("CMRR","gm","Rs")) 


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
addCatVar(14, c_theta.."JA", "Thermal resistance", "W/K")
addCatVar(14, "R", "Equivalent resistance", c_CAPomega)
addCatVar(14, "Rl", "Load resistance", c_CAPomega)
addCatVar(14, "RR0", "Internal circuit loss", c_CAPomega)
addCatVar(14, "RR2", "Load resistance", c_CAPomega)
addCatVar(14, "RB", "External base resistance", c_CAPomega)
addCatVar(14, "Rrc", "Coupled load resistance", c_CAPomega)
addCatVar(14, "Rxt", "External emitter resistance", c_CAPomega)
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
addCatVar(14, "XXC", "Tuned circuit parameter", c_CAPomega)
addCatVar(14, "XC1", c_Pi.." equivalent circuit parameter", c_CAPomega)
addCatVar(14, "XC2", c_Pi.." equivalent circuit parameter", c_CAPomega)
addCatVar(14, "XL", c_Pi.." series reactance", c_CAPomega)

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
aF(14, 2, "TJ=TA+"..c_theta.."JA*Pd", U("TJ","TA",c_theta.."JA","Pd")) 
aF(14, 2, "IC=hFE*IB+(1+hFE)*ICBO", U("IC","hFE","IB","ICBO")) 
aF(14, 2, "IB=-(IC*Rxt-VBE)/(Rxt+RB)", U("IB","IC","Rxt","VBE","RB")) 
aF(14, 2, "IC=-hFE*VBE/(hFE*Rxt+RB)+hFE*(Rxt+RB)/(hFE*Rxt+RB)*ICBO", U("IC","hFE","VBE","Rxt","RB","ICBO")) 
aF(14, 2, "S=(1+RB/Rxt)*hFE/(hFE+RB/Rxt)", U("S","RB","Rxt","hFE")) 
aF(14, 2, "IC=-hFE*IB+S*ICBO*(1+m*dTj)", U("IC","hFE","IB","S","ICBO","m","dTj")) 

addSubCat(14, 3, "Push-Pull Principle", "") 
aF(14, 3, "R=VCC/Imax", U("R","VCC","Imax")) 
aF(14, 3, "Po=VCC^2/(2*R)", U("Po","VCC","R")) 
aF(14, 3, "Po=(N2/(2*N1))^2*VCC^2/(2*RR2)", U("Po","N2","N1","VCC","RR2")) 

addSubCat(14, 4, "Class B Amplifier", "") 
aF(14, 4, "Po=K^2*VCC^2/(2*R)", U("Po","K","VCC","R")) 
aF(14, 4, "Idc=2*K*Imax/"..c_Pi, U("Idc","K","Imax",c_Pi)) 
aF(14, 4, "Pdc=2*K*Imax*VCC/"..c_Pi, U("Pdc","K","Imax","VCC",c_Pi)) 
aF(14, 4, "Pdc=2*K*VCC^2/("..c_Pi.."*R)", U("Pdc","K","VCC","R")) 
aF(14, 4, "x=Po/Pdc", U("Po","Pdc")) 
aF(14, 4, "x="..c_Pi.."*K/4", U(c_Pi,"K")) 
aF(14, 4, "Pd=2*VCC^2/("..c_Pi.."*R)*(K-K^2*"..c_Pi.."/4)", U("Pd","VCC","R","K")) 
aF(14, 4, "V1=gm*Rl*Vm/(2*sqrt(2))*(1/(1+hOE*Rl/2))", U("V1","gm","Rl","Vm","hOE")) 
aF(14, 4, "IC=gm*Vm/"..c_Pi.."*(1/(1+hOE*Rl/2))", U("IC","gm","Vm","hOE","Rl")) 

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
addCatVar(15, "RR1", "Primary resistance", c_CAPomega)
addCatVar(15, "RR2", "Secondary resistance", c_CAPomega)
addCatVar(15, "Rin", "Equiv. primary resistance", c_CAPomega)
addCatVar(15, "Rl", "Resistive part of load", c_CAPomega)
addCatVar(15, "V1", "Primary voltage", "V")
addCatVar(15, "V2", "Secondary voltage", "V")
addCatVar(15, "XX1", "Primary reactance", c_CAPomega)
addCatVar(15, "XX2", "Secondary reactance", c_CAPomega)
addCatVar(15, "Xin", "Equivalent primary reactance", c_CAPomega)
addCatVar(15, "Xl", "Reactive part of load", c_CAPomega)
addCatVar(15, "Zin", "Primary impedance", c_CAPomega)
addCatVar(15, "ZL", "Secondary load", c_CAPomega)

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
addCatVar(16, c_theta, "Phase delay", "rad")
addCatVar(16, "N", "Total # armature coils", "unitless")
addCatVar(16, "Ns","# stator coils", "unitless")
addCatVar(16, c_rho, "Resistivity", c_CAPomega.."/m")
addCatVar(16, c_phi, "Flux", "Wb")
addCatVar(16, "p","# poles", "unitless")
addCatVar(16, "P", "Power", "W")
addCatVar(16, "Pa", "Mechanical power", "W")
addCatVar(16, "Pma", "Power in rotor per phase", "W")
addCatVar(16, "Pme", "Mechanical power", "W")
addCatVar(16, "Pr", "Rotor power per phase", "W")
addCatVar(16, "RR1", "Rotor resistance per phase", c_CAPomega)
addCatVar(16, "Ra", "Armature resistance", c_CAPomega)
addCatVar(16, "Rd", "Adjustable resistance", c_CAPomega)
addCatVar(16, "Re", "Ext. shunt resistance", c_CAPomega)
addCatVar(16, "Rel", "Magnetic reluctance", "A/Wb")
addCatVar(16, "Rf", "Field coil resistance", c_CAPomega)
addCatVar(16, "Rl", "Load resistance", c_CAPomega)
addCatVar(16, "Rr", "Equivalent rotor resistance", c_CAPomega)
addCatVar(16, "Rs", "Series field resistance", c_CAPomega)
addCatVar(16, "Rst", "Stator resistance", c_CAPomega)
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
addCatVar(16, c_omega.."m", "Mechanical radian frequency", "rad/s")
addCatVar(16, c_omega.."me", "Electrical radian frequency", "rad/s")
addCatVar(16, c_omega.."r", "Electrical rotor speed", "rad/s")
addCatVar(16, c_omega.."s", "Electrical stator speed", "rad/s")
addCatVar(16, "Wf", "Magnetic energy", "J")
addCatVar(16, "XL", "Inductive reactance", c_CAPomega)

addSubCat(16, 1, "Energy Conversion", "") 
aF(16, 1, "Wf=1/2*H*B*L*A", U("Wf","H","B","L","A")) 
aF(16, 1, "Wf=1/2*Rel*"..c_phi.."^2", U("Wf","Rel",c_phi)) 
aF(16, 1, "F=B^2/(2*"..c_mu.."0)", U("F","B",c_mu.."0")) 
aF(16, 1, "Es=Ns*"..c_omega.."s*"..c_phi.."/sqrt(2)", U("Es","Ns",c_omega.."s",c_phi)) 

addSubCat(16, 2, "DC Generator", "") 
aF(16, 2, c_omega.."me=p/2*"..c_omega.."m", U(c_omega.."me","p",c_omega.."m")) 
aF(16, 2, "Eta=p/"..c_Pi.."*"..c_omega.."m*"..c_phi, U("Eta","p",c_omega.."m",c_phi)) 
aF(16, 2, "Ea=N/ap*(p/"..c_Pi..")*"..c_omega.."m*"..c_phi, U("Ea","N","ap","p",c_omega.."m",c_phi)) 
aF(16, 2, "Ea=K*"..c_omega.."m*"..c_phi, U("Ea","K",c_omega.."m",c_phi)) 
aF(16, 2, "K=N*p/(ap*"..c_Pi..")", U("K","N","p","ap",c_Pi)) 
aF(16, 2, "T*"..c_omega.."m=Ea*Ia+Ef*IIf", U("T",c_omega.."m","Ea","Ia","Ef","IIf")) 
aF(16, 2, "T=K*"..c_phi.."*Ia", U("T","K",c_phi,"Ia")) 
aF(16, 2, "Ra="..c_rho.."*N/ap^2*(L/A)", U("Ra",c_rho,"N","ap","L","A")) 
aF(16, 2, "Vf=Rf*IIf", U("Vf","Rf","IIf")) 
aF(16, 2, "Vt=K*"..c_omega.."m*"..c_phi.."-Ra*Ia", U("Vt","K",c_omega.."m",c_phi,"Ra","Ia")) 
aF(16, 2, "Ts=K*"..c_phi.."*Ia+Tloss", U("Ts","K",c_phi,"Ia","Tloss")) 

addSubCat(16, 3, "Separately-Excited DC Generator", "") 
aF(16, 3, "IIf=Vfs/(Re+Rf)", U("IIf","Vfs","Re","Rf")) 
aF(16, 3, "Ea=K*"..c_omega.."m*"..c_phi, U("Ea","K",c_omega.."m",c_phi)) 
aF(16, 3, "Vt=IL*Rl", U("Vt","IL","Rl")) 
aF(16, 3, "Vt=Ea-Ra*IL", U("Vt","Ea","Ra","IL")) 
aF(16, 3, "IL=K*"..c_phi.."*"..c_omega.."m/(Ra+Rl)", U("IL","K",c_phi,c_omega.."m","Ra","Rl")) 

addSubCat(16, 4, "DC Shunt Generator", "") 
aF(16, 4, "Ea=K*"..c_omega.."m*"..c_phi, U("Ea","K",c_omega.."m",c_phi)) 
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
aF(16, 6, "Vt=K*"..c_phi.."*"..c_omega.."m+Ra*Ia", U("Vt","K",c_phi,c_omega.."m","Ra","Ia")) 
aF(16, 6, "TL=K*"..c_phi.."*Ia-Tloss", U("TL","K",c_phi,"Ia","Tloss")) 
aF(16, 6, "Ea=K*"..c_omega.."m*"..c_phi, U("Ea","K",c_omega.."m",c_phi)) 
aF(16, 6, "T=K*Ia*"..c_phi, U("T","K","Ia",c_phi)) 
aF(16, 6, c_omega.."m=Vt/(K*"..c_phi..")-Ra*T/(K*"..c_phi..")^2", U(c_omega.."m","Vt","K",c_phi,"Ra","T")) 
aF(16, 6, "T=Tloss+TL", U("T","Tloss","TL")) 
aF(16, 6, "P=T*"..c_omega.."m", U("P","T",c_omega.."m")) 

addSubCat(16, 7, "DC Shunt Motor", "") 
aF(16, 7, "Vt=(Re+Rf)*IIf", U("Vt","Re","Rf","IIf")) 
aF(16, 7, "Vt=K*"..c_phi.."*"..c_omega.."m+Ra*Ia", U("Vt","K",c_phi,c_omega.."m","Ra","Ia")) 
aF(16, 7, "TL=K*"..c_phi.."*Ia-Tloss", U("TL","K",c_phi,"Ia","Tloss")) 
aF(16, 7, "Ea=K*"..c_omega.."m*"..c_phi, U("Ea","K",c_omega.."m",c_phi)) 
aF(16, 7, c_omega.."m=Vt/(K*"..c_phi..")-(Ra+Rd)*T/(K*"..c_phi..")^2", U(c_omega.."m","Vt","K",c_phi,"Ra","Rd","T")) 
aF(16, 7, "T=Tloss+TL", U("T","Tloss","TL")) 
aF(16, 7, "T=K*"..c_phi.."*Ia", U("T","K",c_phi,"Ia")) 

addSubCat(16, 8, "DC Series Motor", "") 
aF(16, 8, "Vt=K*"..c_phi.."*"..c_omega.."m+(Ra+Rs+Rd)*IL", U("Vt","K",c_phi,c_omega.."m","Ra","Rs","Rd","IL")) 
aF(16, 8, "TL=K*"..c_phi.."*IL-Tloss", U("TL","K",c_phi,"IL","Tloss")) 
aF(16, 8, "Ea=K*"..c_omega.."m*"..c_phi, U("Ea","K",c_omega.."m",c_phi)) 
aF(16, 8, "T=K*"..c_phi.."*IL", U("T","K",c_phi,"IL")) 
aF(16, 8, c_omega.."m=Vt/(K*"..c_phi..")-(Ra+Rs+Rd)*T/(K*"..c_phi..")^2", U(c_omega.."m","Vt","K",c_phi,"Ra","Rs","Rd","T")) 
aF(16, 8, "T=Tloss+TL", U("T","Tloss","TL")) 
aF(16, 8, "K*"..c_phi.."=Kf*IL", U("K",c_phi,"Kf","IL")) 
aF(16, 8, "T=Kf*IL^2", U("T","Kf","IL")) 

addSubCat(16, 9, "Permanent Magnet Motor", "") 
aF(16, 9, "Ea=K*"..c_phi.."*"..c_omega.."m", U("Ea","K",c_phi,c_omega.."m")) 
aF(16, 9, "T=K*"..c_phi.."*Ia", U("T","K",c_phi,"Ia")) 
aF(16, 9, "Vt=Ea+Ra*Ia", U("Vt","Ea","Ra","Ia")) 
aF(16, 9, "T=Tloss+TL", U("T","Tloss","TL")) 
aF(16, 9, c_omega.."m=Vt/(K*"..c_phi..")-Ra*T/(K*"..c_phi..")^2", U(c_omega.."m","Vt","K",c_phi,"Ra","T")) 

addSubCat(16, 10, "Induction Motor I", "") 
aF(16, 10, c_omega.."r="..c_omega.."s-p/2*"..c_omega.."m", U(c_omega.."r",c_omega.."s","p",c_omega.."m")) 
aF(16, 10, "s=1-p/2*("..c_omega.."m/"..c_omega.."s)", U("s","p",c_omega.."m",c_omega.."s")) 
aF(16, 10, "Pr/Pma=s", U("Pr","Pma","s")) 
aF(16, 10, c_omega.."r=s*"..c_omega.."s", U(c_omega.."r","s",c_omega.."s")) 
aF(16, 10, "Pma=3*Ir*Ema", U("Pma","Ir","Ema")) 
aF(16, 10, "Pme=3*(p/2)*("..c_omega.."m/"..c_omega.."s)*Pma", U("Pme","p",c_omega.."m",c_omega.."s","Pma")) 
aF(16, 10, "Pme=T*"..c_omega.."m", U("Pme","T",c_omega.."m")) 
aF(16, 10, "T=3*(p/2)*(Pma/"..c_omega.."s)", U("T","p","Pma",c_omega.."s")) 
aF(16, 10, "Pma=Rr*Ir^2+(1-s)/s*Rr*Ir^2", U("Pma","Rr","Ir","s")) 
aF(16, 10, "Pa=(1-s)/s*Rr*Ir^2", U("Pa","s","Rr","Ir")) 
aF(16, 10, "Rr=RR1/KM^2", U("Rr","RR1","KM")) 

addSubCat(16, 11, "Induction Motor II", "") 
aF(16, 11, "Pma=Rr/s*Ir^2", U("Pma","Rr","s","Ir")) 
aF(16, 11, "T=3/2*(p*Pma/"..c_omega.."s)", U("T","p","Pma",c_omega.."s")) 
aF(16, 11, "T=3/2*(p/"..c_omega.."s)*(Rr/s)*(Va^2/((Rst+Rr/s)^2+XL^2))", U("T","p",c_omega.."s","Rr","s","Va","Rst","XL")) 
aF(16, 11, "Tmmax=3/4*(p/"..c_omega.."s)*(Va^2/(sqrt(Rst^2+XL^2)+Rst))", U("Tmmax","p",c_omega.."s","Va","Rst","XL")) 
aF(16, 11, "sm=Rr/sqrt(Rs^2+XL^2)", U("sm","Rr","Rs","XL")) 
aF(16, 11, "Tgmax=-(3/4)*(p/"..c_omega.."s)*(Va^2/(sqrt(Rs^2+XL^2)-Rst))", U("Tgmax","p",c_omega.."s","Va","Rs","XL","Rst")) 
aF(16, 11, "Rr=RR1/KM^2", U("Rr","RR1","KM")) 

addSubCat(16, 12, "Single-Phase Induction Motor", "") 
aF(16, 12, "sf=1-p/2*("..c_omega.."m/"..c_omega.."s)", U("sf","p",c_omega.."m",c_omega.."s")) 
aF(16, 12, "Tf=p/2*(1/"..c_omega.."s)*(Isf^2*Rr/(2*sf))", U("Tf","p",c_omega.."s","Isf","Rr","sf")) 
aF(16, 12, "Tb=-(p/2)*(1/"..c_omega.."s)*(Isb^2*Rr/(2*(2-sf)))", U("Tb","p",c_omega.."s","Isb","Rr","sf")) 

addSubCat(16, 13, "Synchronous Machines", "") 
aF(16, 13, c_omega.."m=2/p*"..c_omega.."s", U(c_omega.."m","p",c_omega.."s")) 
aF(16, 13, "TTmax=3*(p/2)*(IIf*Va/"..c_omega.."s)", U("TTmax","p","IIf","Va",c_omega.."s")) 
aF(16, 13, "Pma=Va*Ia*cos("..c_theta..")", U("Pma","Va","Ia",c_theta)) 
aF(16, 13, "T=Pme/"..c_omega.."m", U("T","Pme",c_omega.."m")) 
aF(16, 13, "T=3*(p/2)*(Pma/"..c_omega.."s)", U("T","p","Pma",c_omega.."s"))

-- This part is supposed to load external formulas stored in a string
-- (or else, if a better way of storing is found) from a file in MyLib.

function loadExtDB()
    local err
    _, err = pcall(function()
        loadstring(math.eval("formulaproextdb\\categories()"))()
        loadstring(math.eval("formulaproextdb\\variables()"))()
        loadstring(math.eval("formulaproextdb\\subcategories()"))()
        loadstring(math.eval("formulaproextdb\\equations()"))()
    end)

    if err then
        print("no external db loaded")
        -- Display something ?
        -- or it simply means there is nothing to be loaded.
    else
        -- display something that tells the user the external DB has been successfully loaded.
        print("external db succesfully loaded")
    end
end

local mathpi = math.pi

Units = {}

function Units.mainToSub(main, sub, n)
    local c = Units[main][sub]
    return n * c[1] + c[2]
end

function Units.subToMain(main, sub, n)
    local c = Units[main][sub]
    return (n - c[2]) / c[1]
end

--[[

Units["mainunit"]	= {}
Units["mainunit"]["subunit"]	= {a, b}

meaning: n mainunit = n*a+b subunit
or
n subunit = (n-b)/a mainunit

--]]


Mt = {}

Mt.G = 1 / 1000000000
Mt.M = 1 / 1000000
Mt.k = 1 / 1000
Mt.h = 1 / 100
Mt.da = 1 / 10
Mt.d = 10
Mt.c = 100
Mt.m = 1000
Mt.u = 1000000
Mt.n = 1000000000

Mt.us = utf8(956)


Units["W/K"] = {}
Units["W/K"]["kW/K"] = { Mt.k, 0 }
Units["W/K"]["mW/K"] = { Mt.m, 0 }

Units["1/" .. utf8(176) .. "K"] = {}

Units["m/s"] = {}
Units["m/s"]["km/s"] = { Mt.k, 0 }
Units["m/s"]["cm/s"] = { Mt.c, 0 }
Units["m/s"]["mm/s"] = { Mt.m, 0 }
Units["m/s"]["m/h"] = { 3600, 0 }
Units["m/s"]["km/h"] = { 3.6, 0 }


Units["m"] = {}
Units["m"]["km"] = { Mt.k, 0 }
Units["m"]["dm"] = { Mt.d, 0 }
Units["m"]["cm"] = { Mt.c, 0 }
Units["m"]["mm"] = { Mt.m, 0 }
Units["m"][Mt.us .. "m"] = { Mt.u, 0 }
Units["m"]["nm"] = { Mt.n, 0 }



-- these are actually the same type
Units["Hz"] = {}
Units["Hz"]["kHz"] = { Mt.k, 0 }
Units["Hz"]["MHz"] = { Mt.M, 0 }
Units["Hz"]["GHz"] = { Mt.G, 0 }

Units["rad/s"] = {}
Units["rad/s"]["RPM"] = { 1 / (2 * mathpi / 60), 0 }

Units["A/m"] = {}
Units["A/m"]["mA/m"] = { Mt.m, 0 }

Units["V/s"] = {}
Units["V/s"]["mV/s"] = { Mt.m, 0 }

Units["C/m"] = {}
Units["C/m"][Mt.us .. "C/m"] = { Mt.u, 0 }
Units["C/m"]["C/mm"] = { 1 / Mt.m, 0 }

Units["m2/s"] = {}

Units[utf8(937)] = {} --Ohm
Units[utf8(937)]["m" .. utf8(937)] = { Mt.m, 0 }
Units[utf8(937)]["k" .. utf8(937)] = { Mt.k, 0 }
Units[utf8(937)]["M" .. utf8(937)] = { Mt.M, 0 }

Units["s"] = {}
Units["s"]["ms"] = { Mt.m, 0 }
Units["s"][Mt.us .. "s"] = { Mt.u, 0 }
Units["s"]["ns"] = { Mt.n, 0 }

Units[utf8(937) .. "/m"] = {}
Units[utf8(937) .. "/m"][utf8(937) .. "/cm"] = { 1 / Mt.c, 0 }
Units[utf8(937) .. "/m"][utf8(937) .. "/mm"] = { 1 / Mt.m, 0 }

Units["1/m3"] = {}

Units["N"] = {}
Units["N"]["daN"] = { Mt.da, 0 }

Units["Wb"] = {}
Units["Wb"]["mWb"] = { Mt.m, 0 }

Units["A"] = {}
Units["A"]["kA"] = { Mt.k, 0 }
Units["A"]["mA"] = { Mt.m, 0 }
Units["A"][Mt.us .. "A"] = { Mt.u, 0 }

Units["S/m"] = {}
Units["S/m"]["mS/m"] = { Mt.m, 0 }
Units["S/m"]["S/mm"] = { 1 / Mt.m, 0 }

Units["C"] = {}
Units["C"]["mC"] = { Mt.m, 0 }
Units["C"][Mt.us .. "C"] = { Mt.u, 0 }

Units["m2/(V*s)"] = {}

Units["A/V2"] = {}
Units["A/V2"]["mA/V2"] = { Mt.m, 0 }


Units["N/m"] = {}
Units["N/m"]["daN"] = { Mt.da, 0 }

Units["rad"] = {}
Units["rad"]["degree"] = { 180 / mathpi, 0 }

Units["F"] = {}
Units["F"]["kF"] = { Mt.k, 0 }
Units["F"]["mF"] = { Mt.m, 0 }
Units["F"][Mt.us .. "F"] = { Mt.u, 0 }
Units["F"]["nF"] = { Mt.n, 0 }


Units[utf8(937) .. "*m"] = {}
Units[utf8(937) .. "*m"][utf8(937) .. "*cm"] = { Mt.c, 0 }
Units[utf8(937) .. "*m"][utf8(937) .. "*mm"] = { Mt.m, 0 }

Units["H"] = {}
Units["H"]["mH"] = { Mt.m, 0 }
Units["H"][Mt.us .. "H"] = { Mt.u, 0 }
Units["H"]["nH"] = { Mt.n, 0 }

Units["K"] = {}
Units["K"]["°C"] = { 1, -273.15 }
Units["K"]["°F"] = { 9 / 5, -459.67 }
Units["K"]["°R"] = { 9 / 5, 0 }

Units["J"] = {}
Units["J"]["GJ"] = { Mt.G, 0 }
Units["J"]["MJ"] = { Mt.M, 0 }
Units["J"]["kJ"] = { Mt.k, 0 }
Units["J"]["kWh"] = { 1 / 3600000, 0 }

Units["1/V"] = {}

Units["F/m"] = {}
Units["F/m"]["F/cm"] = { 1 / Mt.c, 0 }
Units["F/m"]["F/mm"] = { 1 / Mt.m, 0 }
Units["F/m"][Mt.us .. "F/m"] = { Mt.u, 0 }

Units["V5"] = {}

Units["H/m"] = {}
Units["H/m"]["mH/m"] = { Mt.m, 0 }
Units["H/m"]["H/mm"] = { 1 / Mt.m, 0 }
Units["H/m"][Mt.us .. "H/m"] = { Mt.u, 0 }

Units["F/m2"] = {}
Units["F/m2"]["F/cm2"] = { 1 / Mt.c ^ 2, 0 }
Units["F/m2"]["mF/m2"] = { Mt.m, 0 }
Units["F/m2"][Mt.us .. "F/m2"] = { Mt.u, 0 }

Units["N*m"] = {}
Units["N*m"]["daN*m"] = { Mt.da, 0 }
Units["N*m"]["N*cm"] = { Mt.c, 0 }
Units["N*m"]["N*mm"] = { Mt.m, 0 }

Units["S"] = {}
Units["S"]["mS"] = { Mt.m, 0 }
Units["S"][Mt.us .. "S"] = { Mt.u, 0 }

Units["1/m4"] = {}

Units["A/(m2*K2)"] = {}

Units["T"] = {}
Units["T"]["mT"] = { Mt.m, 0 }
Units["T"][Mt.us .. "T"] = { Mt.u, 0 }
Units["T"]["nT"] = { Mt.n, 0 }

Units["W"] = {}
Units["W"]["GW"] = { Mt.G, 0 }
Units["W"]["MW"] = { Mt.M, 0 }
Units["W"]["kW"] = { Mt.k, 0 }
Units["W"]["mW"] = { Mt.m, 0 }
Units["W"][Mt.us .. "W"] = { Mt.u, 0 }

Units["V"] = {}
Units["V"]["MV"] = { Mt.M, 0 }
Units["V"]["kV"] = { Mt.k, 0 }
Units["V"]["mV"] = { Mt.m, 0 }
Units["V"][Mt.us .. "V"] = { Mt.u, 0 }

Units["m2"] = {}
Units["m2"]["cm2"] = { Mt.c ^ 2, 0 }
Units["m2"]["mm2"] = { Mt.m ^ 2, 0 }
Units["m2"]["km2"] = { Mt.k ^ 2, 0 }

Units["A/Wb"] = {}

Units["Pa"] = {}
Units["Pa"]["hPa"] = { Mt.h, 0 }
Units["Pa"]["bar"] = { 1 / 100000, 0 }
Units["Pa"]["atm"] = { 1.01325, 0 }

Units["1/K"] = {}

Units["V/m"] = {}
Units["V/m"]["mV/m"] = { Mt.m, 0 }
Units["V/m"]["V/mm"] = { 1 / Mt.m, 0 }
Units["V/m"]["V/cm"] = { 1 / Mt.c, 0 }

Units["C/m2"] = {}
Units["C/m2"]["mC/m2"] = { Mt.m, 0 }
Units["C/m2"][Mt.us .. "C/m2"] = { Mt.u, 0 }
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


-- Fullscreen 'Library'

doNotDisplayIcon = false

icon=image.new("\020\0\0\0\020\0\0\0\0\0\0\0\040\0\0\0\016\0\001\000wwwwwwwwwwwwww\223\251\222\251\189\251\188\251\188\251\221\255\221\255\254\255wwwwwwwwwwwwwwwwwwww\156\243\024\227\215\218\214\218\247\222\025\227Z\235\156\243wwwwwwwwwwwwwwwwwwwwww\024\227S\202s\206\181\214\214\218\248\2229\2279\231Z\235Z\235wwwwwwwwwwwwwwwwwwZ\235\207\185\016\194R\202s\206\148\210\214\218\214\218\214\2229\231Z\235:\231wwwwwwwwwwwwww\190\251\239\189\239\189\148\210\148\210\156\247\148\214\214\218\147\210\181\218{\239\025\227Z\235|\239wwwwwwwwwwww\149\214\239\189\239\189\239\189\206\185{\239\206\185R\202R\202\148\214{\239\247\2229\227Z\231wwwwwwwwww\189\255\016\194\239\189\239\189\239\189\206\185{\239\173\181\016\194\016\194s\210Z\235\214\218\247\222\025\227\189\247wwwwwwww8\243\016\194\239\189\239\189\240\189\206\189{\239\206\185\016\194\207\185s\2109\235\148\210\214\218\024\223{\239wwwwww\254\255\244\238\239\189\206\185\207\185\206\185\140\177z\239\008\161\008\161\198\152\016\194\214\218\173\181\017\194t\206:\231wwwwww\188\2556\247\016\194\206\185k\173)\165\231\156{\239\132\144\133\144c\140\239\193\148\210\008\161l\173\239\1899\231wwwwwwx\255\154\255\240\189\231\156\132\144C\136B\136k\173\0\128B\136!\132\165\148\231\156B\136\165\148K\173\156\243wwwwww6\255\154\255\024\227\198\152c\140\206\185\206\185\173\181\207\185k\173)\165\206\185\239\189J\169c\140\173\181\222\251wwwwww6\255x\255ww\140\177\0\128\148\210\016\194\173\181R\202\173\181\206\185R\202\239\189\231\156\164\152\213\218wwwwwwwwx\2556\255ww\222\251J\169\008\161c\140c\140c\140c\140c\140c\140\008\169O\230o\234\178\242z\251wwwwww\221\255\209\250wwwwww\239\189\132\144d\140B\136d\140\132\144B\136\202\213\012\234\012\230\012\230-\234\189\251wwwwww\242\2506\255wwwwww\156\243\149\210\016\194\240\1892\202\247\222\236\221\147\222r\2220\214\146\222\245\238wwwwww\188\255\141\250\243\250wwwwwwwwwwwwww\021\251\168\221\136\217\169\213\236\213O\222Y\243wwwwwwww\188\255\142\250m\250\244\250X\255y\2557\255\177\250)\246(\246K\242\168\229\134\229\134\229\178\238wwwwwwwwwwwwwwW\255\175\250k\250J\250K\250\141\250\242\250y\255ww\188\2557\251z\251wwwwwwwwwwwwwwwwwwww\222\255\222\255\222\255wwwwwwwwwwwwwwwwwwwwww")

local pw	= getmetatable(platform.window)
function pw:invalidateAll()
	if self.setFocus then
		self:setFocus(false)
		self:setFocus(true)
	end
end

function on.draw(gc)
	gc:setColorRGB(255, 255, 255)
	gc:fillRect(18, 5, 20, 20)
	gc:drawImage(icon, 18, 5)
end

if not platform.withGC then
    function platform.withGC(func, ...)
        local gc = platform.gc()
        gc:begin()
        func(..., gc)
        gc:finish()
    end
end


----------

local tstart = timer.start
function timer.start(ms)
    if not timer.isRunning then
        tstart(ms)
    end
    timer.isRunning = true
end

local tstop = timer.stop
function timer.stop()
    timer.isRunning = false
    tstop()
end


if platform.hw then
    timer.multiplier = platform.hw() < 4 and 3.2 or 1
else
    timer.multiplier = platform.isDeviceModeRendering() and 3.2 or 1
end

function on.timer()
    --current_screen():timer()
    local j = 1
    while j <= #timer.tasks do -- for each task
        if timer.tasks[j][2]() then -- delete it if has ended
            table.remove(timer.tasks, j)
            sj = j - 1
        end
        j = j + 1
    end
    if #timer.tasks > 0 then
        platform.window:invalidate()
    else
        --for _,screen in pairs(Screens) do
        --	screen:size()
        --end
        timer.stop()
    end
end

timer.tasks = {}

timer.addTask = function(object, task) timer.start(0.01) table.insert(timer.tasks, { object, task }) end

function timer.purgeTasks(object)
    local j = 1
    while j <= #timer.tasks do
        if timer.tasks[j][1] == object then
            table.remove(timer.tasks, j)
            j = j - 1
        end
        j = j + 1
    end
end


---------- Animable Object class
Object = class()
function Object:init(x, y, w, h, r)
    self.tasks = {}
    self.x = x
    self.y = y
    self.w = w
    self.h = h
    self.r = r
    self.visible = true
end

function Object:PushTask(task, t, ms, callback)
    table.insert(self.tasks, { task, t, ms, callback })
    timer.start(0.01)
    if #self.tasks == 1 then
        local ok = task(self, t, ms, callback)
        if not ok then table.remove(self.tasks, 1) end
    end
end

function Object:PopTask()
    table.remove(self.tasks, 1)
    if #self.tasks > 0 then
        local task, t, ms, callback = unpack(self.tasks[1])
        local ok = task(self, t, ms, callback)
        if not ok then table.remove(self.tasks, 1) end
    end
end

function Object:purgeTasks()
    for i = 1, #self.tasks do
        self.tasks[i] = nil
    end
    collectgarbage()
    timer.purgeTasks(self)
    self.tasks = {}
    return self
end

function Object:paint(gc)
    -- to override
end

speed = 1

function Object:__Animate(t, ms, callback)
    if not ms then ms = 50 end
    if ms < 0 then print("Error: Invalid time divisor (must be >= 0)") return end
    ms = ms / timer.multiplier
    if ms == 0 then ms = 1 end
    if not t or type(t) ~= "table" then print("Error: Target position is " .. type(t)) return end
    if not t.x then t.x = self.x end
    if not t.y then t.y = self.y end
    if not t.w then t.w = self.w end
    if not t.h then t.h = self.h end
    if not t.r then t.r = self.r else t.r = math.pi * t.r / 180 end
    local xinc = (t.x - self.x) / ms
    local xside = xinc >= 0 and 1 or -1
    local yinc = (t.y - self.y) / ms
    local yside = yinc >= 0 and 1 or -1
    local winc = (t.w - self.w) / ms
    local wside = winc >= 0 and 1 or -1
    local hinc = (t.h - self.h) / ms
    local hside = hinc >= 0 and 1 or -1
    local rinc = (t.r - self.r) / ms
    local rside = rinc >= 0 and 1 or -1
    timer.addTask(self, function()
        local b1, b2, b3, b4, b5 = false, false, false, false, false
        if (self.x + xinc * speed) * xside < t.x * xside then self.x = self.x + xinc * speed else b1 = true end
        if self.y * yside < t.y * yside then self.y = self.y + yinc * speed else b2 = true end
        if self.w * wside < t.w * wside then self.w = self.w + winc * speed else b3 = true end
        if self.h * hside < t.h * hside then self.h = self.h + hinc * speed else b4 = true end
        if self.r * rside < t.r * rside then self.r = self.r + rinc * speed else b5 = true end
        if self.w < 0 then self.w = 0 end
        if self.h < 0 then self.h = 0 end
        if b1 and b2 and b3 and b4 and b5 then
            self.x, self.y, self.w, self.h, self.r = t.x, t.y, t.w, t.h, t.r
            self:PopTask()
            if callback then callback(self) end
            return true
        end
        return false
    end)
    return true
end

function Object:__Delay(_, ms, callback)
    if not ms then ms = 50 end
    if ms < 0 then print("Error: Invalid time divisor (must be >= 0)") return end
    ms = ms / timer.multiplier
    if ms == 0 then ms = 1 end
    local t = 0
    timer.addTask(self, function()
        if t < ms then
            t = t + 1
            return false
        else
            self:PopTask()
            if callback then callback(self) end
            return true
        end
    end)
    return true
end

function Object:__setVisible(t, _, _)
    timer.addTask(self, function()
        self.visible = t
        self:PopTask()
        return true
    end)
    return true
end

function Object:Animate(t, ms, callback)
    self:PushTask(self.__Animate, t, ms, callback)
    return self
end

function Object:Delay(ms, callback)
    self:PushTask(self.__Delay, false, ms, callback)
    return self
end

function Object:setVisible(t)
    self:PushTask(self.__setVisible, t, 1, false)
    return self
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

Screen	=	class(Object)

Screens	=	{}

function scrollScreen(screen, d, callback)
  --  print("scrollScreen.  number of screens : ", #Screens)
    local dir = d or 1
    screen.x=dir*kXSize
    screen:Animate( {x=0}, 10, callback )
end

function insertScreen(screen, ...)
  --  print("insertScreen")
	screen:size()
    if current_screen() ~= DummyScreen then
        current_screen():screenLoseFocus()
        local coeff = pushFromBack and 1 or -1
	    current_screen():Animate( {x=coeff*kXSize}, 10)
    end
	table.insert(Screens, screen)

	platform.window:invalidate()
	current_screen():pushed(...)
end

function insertScreen_direct(screen, ...)
  --  print("insertScreen_direct")
	screen:size()
	table.insert(Screens, screen)
	platform.window:invalidate()
	current_screen():pushed(...)
end

function push_screen(screen, ...)
    --print("push_screen")
    local args = ...
    local theScreen = current_screen()
    pushFromBack = false
    insertScreen(screen, ...)
    scrollScreen(screen, 1, function() remove_screen_previous(theScreen) end)
end

function push_screen_back(screen, ...)
    --print("push_screen_back")
    local theScreen = current_screen()
    pushFromBack = true
    insertScreen(screen, ...)
    scrollScreen(screen, -1, function() remove_screen_previous(theScreen) end)
end

function push_screen_direct(screen, ...)
   -- print("push_screen_direct")
	table.insert(Screens, screen)
	platform.window:invalidate()
	current_screen():pushed(...)
end

function only_screen(screen, ...)
   -- print("only_screen")
    remove_screen(current_screen())
	Screens	=	{}
	push_screen(screen, ...)
	platform.window:invalidate()
end

function only_screen_back(screen, ...)
 --   print("only_screen_back")
    --Screens	=	{}
	push_screen_back(screen, ...)
	platform.window:invalidate()
end

function remove_screen_previous(...)
  --  print("remove_screen_previous")
	platform.window:invalidate()
	current_screen():removed(...)
	res=table.remove(Screens, #Screens-1)
	current_screen():screenGetFocus()
	return res
end

function remove_screen(...)
  --  print("remove_screen")
	platform.window:invalidate()
	current_screen():removed(...)
	res=table.remove(Screens)
	current_screen():screenGetFocus()
	return res
end

function current_screen()
	return Screens[#Screens] or DummyScreen
end

function Screen:init(xx,yy,ww,hh)

	self.yy	=	yy
	self.xx	=	xx
	self.hh	=	hh
	self.ww	=	ww
	
	self:ext()
	self:size(0)
	
	Object.init(self, self.x, self.y, self.w, self.h, 0)
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


function Screen:pushed() end
function Screen:removed() end
function Screen:screenLoseFocus() end
function Screen:screenGetFocus() end

function Screen:draw(gc)
	--self:size()
	self:paint(gc)
end

function Screen:paint(gc) end

function Screen:invalidate()
	platform.window:invalidate(self.x ,self.y , self.w, self.h)
end

function Screen:arrowKey()	end
function Screen:enterKey()	end
function Screen:backspaceKey()	end
function Screen:clearKey() 	end
function Screen:escapeKey()	end
function Screen:tabKey()	end
function Screen:backtabKey()	end
function Screen:charIn(char)	end


function Screen:mouseDown()	end
function Screen:mouseUp()	end
function Screen:mouseMove()	end
function Screen:contextMenu()	end

function Screen:appended() end

function Screen:resize(w,h) end

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

function WidgetManager:resize(w,h)
    if self.x then  --already inited
        self:size()
    end
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
	--self:size()
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
    else
        if self.widgets and self.widgets[1] then   -- ugh, quite a bad hack for the mouseUp at (0,0) when cursor isn't shown (grrr TI) :/
            self.widgets[1]:enterKey()
        end
    end
    self:invalidate()
end

function WidgetManager:clearKey()	
	if self.focus~=0 then
		self:getWidget():clearKey()
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
        --self:getWidget():mouseUp(x, y)
    end
    for _, widget in pairs(self.widgets) do
        widget:mouseUp(x,y) -- well, mouseUp is a release of a button, so everything previously "clicked" should be released, for every widget, even if the mouse has moved (and thus changed widget)
        -- eventually, a better way for this would be to keep track of the last widget active and do it to this one only...
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



---
-- The dummy screen
---

DummyScreen	= Screen()


------------------------------------------------------------------
--                   Bindings to the on events                  --
------------------------------------------------------------------


function on.paint(gc)	
    allWentWell, generalErrMsg = pcall(onpaint, gc)
    if not allWentWell and errorHandler then
        errorHandler.display = true
        errorHandler.errorMessage = generalErrMsg
    end
    if platform.hw and platform.hw() < 4 and not doNotDisplayIcon then 
    	platform.withGC(on.draw)
    end
end

function onpaint(gc)
	for _, screen in pairs(Screens) do
		screen:draw(gc)	
	end
	if errorHandler.display then
	    errorPopup(gc)
	end
end

function on.resize(w, h)
	-- Global Ratio Constants for On-Calc (shouldn't be used often though...)
	kXRatio = w/320
	kYRatio = h/212
	
	kXSize, kYSize = w, h
	
	for _,screen in pairs(Screens) do
		screen:resize(w,h)
	end
end

function on.arrowKey(arrw)	current_screen():arrowKey(arrw)  end
function on.enterKey()		current_screen():enterKey()		 end
function on.escapeKey()		current_screen():escapeKey()	 end
function on.tabKey()		current_screen():tabKey()		 end
function on.backtabKey()	current_screen():backtabKey()	 end
function on.charIn(ch)		current_screen():charIn(ch)		 end
function on.backspaceKey()	current_screen():backspaceKey()  end
function on.contextMenu()	current_screen():contextMenu()   end
function on.mouseDown(x,y)	current_screen():mouseDown(x,y)	 end
function on.mouseUp(x,y)	if (x == 0 and y == 0) then current_screen():enterKey() else current_screen():mouseUp(x,y) end	 end
function on.mouseMove(x,y)	current_screen():mouseMove(x,y)  end
function on.clearKey()    	current_screen():clearKey()      end

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
function Widget:clearKey() 	end

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
        gc:setColorRGB(40, 148, 184)
        gc:drawRect(x-1, y-1, self.w+2, self.h+2)
        gc:setColorRGB(0, 0, 0)
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
	if self.disabled or (self.number and not tonumber(self.value .. char)) then --or char~="," then
		return
	end
	--char = (char == ",") and "." or char
	self.value	=	self.value .. char
end

function sInput:clearKey()
    if self:deleteInvalid() then return 0 end
    self.value	=	""
end

function sInput:backspaceKey()
    if self:deleteInvalid() then return 0 end
	if not self.disabled then
		self.value	=	self.value:usub(1,-2)
	end
end

function sInput:deleteInvalid()
    local isInvalid = string.find(self.value, "Invalid input")
    if isInvalid then
        self.value = self.value:usub(1, -19)
        return true
    end
    return false
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
    self.pushed = false

    self.dh	=	27
    self.dw	=	48

    self.bordercolor	=	{136,136,136}
    self.font	=	{"sansserif", "r", 10}
end

function sButton:paint(gc)
    gc:setFont(uCol(self.font))
    self.ww	=	gc:getStringWidth(self.text)+8
    self:size()

    if self.pushed and self.forcePushed then
        self.y = self.y + 2
    end

    gc:setColorRGB(248,252,248)
    gc:fillRect(self.x+2, self.y+2, self.w-4, self.h-4)
    gc:setColorRGB(0,0,0)

    gc:drawString(self.text, self.x+4, self.y+4, "top")

    if self.hasFocus then
        gc:setColorRGB(40, 148, 184)
        gc:setPen("medium", "smooth")
    else
        gc:setColorRGB(uCol(self.bordercolor))
        gc:setPen("thin", "smooth")
    end
    gc:fillRect(self.x + 2, self.y, self.w-4, 2)
    gc:fillRect(self.x + 2, self.y+self.h-2, self.w-4, 2)
    gc:fillRect(self.x, self.y+2, 1, self.h-4)
    gc:fillRect(self.x+1, self.y+1, 1, self.h-2)
    gc:fillRect(self.x+self.w-1, self.y+2, 1, self.h-4)
    gc:fillRect(self.x+self.w-2, self.y+1, 1, self.h-2)

    if self.hasFocus then
        gc:setColorRGB(40, 148, 184)
        -- old way of indicating focus :
        --gc:drawRect(self.x-2, self.y-2, self.w+3, self.h+3)
        --gc:drawRect(self.x-3, self.y-3, self.w+5, self.h+5)
    end
end

function sButton:mouseMove(x,y)
    local isIn = (x>self.x and x<(self.x+self.w) and y>self.y and y<(self.y+self.h))
    self.pushed = self.forcePushed and isIn
    platform.window:invalidate()
end

function sButton:enterKey()
    if self.action then self.action() end
end

function sButton:mouseDown(x,y)
    if (x>self.x and x<(self.x+self.w) and y>self.y and y<(self.y+self.h)) then
        self.pushed = true
        self.forcePushed = true
    end
    platform.window:invalidate()
end

function sButton:mouseUp(x,y)
    self.pushed = false
    self.forcePushed = false
    if (x>self.x and x<(self.x+self.w) and y>self.y and y<(self.y+self.h)) then
        self:enterKey()
    end
    platform.window:invalidate()
end


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
	if self.h > 28 then
		gc:drawRect(self.x + 3, self.y + 14, 8, self.h - 28)
	end
	
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
    
	if arrow=="up" then
	    if self.sel>1 then
            self.sel	= self.sel - 1
            if self.top>=self.sel then
                self.top	= self.top - 1
            end
        else
            self.top = self.h/self.ih < #self.items and math.ceil(#self.items - self.h/self.ih) or 0
            self.sel = #self.items
        end
        self:change(self.sel, self.items[self.sel])
	end

	if arrow=="down" then
	    if self.sel<#self.items then
            self.sel	= self.sel + 1
            if self.sel>(self.h/self.ih)+self.top then
                self.top	= self.top + 1
            end
        else
            self.top = 0
            self.sel = 1
        end
        self:change(self.sel, self.items[self.sel])
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
--									sDropdown							     --
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
	
	local py	= self.parent.oy and self.parent.y-self.parent.oy or self.parent.y
	local ph	= self.parent.h
	
	self.screen.hh	= self.y+self.h+h>ph+py-10 and ph-py-self.y-self.h-10 or h
	if self.y+self.h+h>ph+py-10  and self.screen.hh<40 then
		self.screen.hh = h < self.y and h or self.y-5
		self.screen.yy = self.y-self.screen.hh
	end
	
	self.sList.ww = self.w + 13
	self.sList.hh = self.screen.hh-2
	self.sList.yy =self.sList.yy+1
	self.sList:giveFocus()
	
    self.screen:size()
	push_screen_direct(self.screen)
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
        gc:setColorRGB(40, 148, 184)
        gc:drawRect(self.x-1, self.y-1, self.w+1, self.h+1)
        gc:setColorRGB(0, 0, 0)
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
    --local eq="max(exp" .. string.uchar(9654) .. "list(solve(" .. formula .. ", " .. tosolve ..")," .. tosolve .."))"
    local eq = "nsolve(" .. formula .. ", " .. tosolve .. ")"
    local res = tostring(math.eval(eq)):gsub(utf8(8722), "-")
    --print("-", eq, math.eval(eq), tostring(math.eval(eq)), tostring(math.eval(eq)):gsub(utf8(8722), "-"))
    return tonumber(res)
end

function round(num, idp)
    if num >= 0.001 or num <= -0.001 then
        local mult = 10 ^ (idp or 0)
        if num >= 0 then
            return math.floor(num * mult + 0.5) / mult
        else
            return math.ceil(num * mult - 0.5) / mult
        end
    else
        return tonumber(string.format("%.0" .. (idp + 1) .. "g", num))
    end
end

math.round = round -- just in case

function find_data(known, cid, sid)
    local done = {}

    for _, var in ipairs(var.list()) do
        math.eval("delvar " .. var)
    end

    for key, value in pairs(known) do
        var.store(key, value)
    end

    local no
    local dirty_exit = true
    local tosolve
    local couldnotsolve = {}

    local loops = 0
    while dirty_exit do
        loops = loops + 1
        if loops == 100 then error("too many loops!") end
        dirty_exit = false

        for i, formula in ipairs(Formulas) do

            local skip = false
            if couldnotsolve[formula] then
                skip = true
                for k, v in pairs(known) do
                    if not couldnotsolve[formula][k] then
                        skip = false
                        couldnotsolve[formula] = nil
                        break
                    end
                end
            end

            if ((not cid) or (cid and formula.category == cid)) and ((not sid) or (formula.category == cid and formula.sub == sid)) and not skip then
                no = 0

                for var in pairs(formula.variables) do
                    if not known[var] then
                        no = no + 1
                        tosolve = var
                        if no == 2 then break end
                    end
                end

                if no == 1 then
                    print("I can solve " .. tosolve .. " for " .. formula.formula)

                    local sol, r = math.solve(formula.formula, tosolve)
                    if sol then
                        sol = round(sol, 4)
                        known[tosolve] = sol
                        done[formula] = true
                        var.store(tosolve, sol)
                        couldnotsolve[formula] = nil
                        print(tosolve .. " = " .. sol)
                    else
                        print("Oops! Something went wrong:", r)
                        -- Need to issue a warning dialog
                        couldnotsolve[formula] = copyTable(known)
                    end
                    dirty_exit = true
                    break

                elseif no == 2 then
                    print("I cannot solve " .. formula.formula .. " because I don't know the value of multiple variables")
                end
            end
        end
    end

    return known
end


CategorySel = WScreen()
CategorySel.iconS = 48

CategorySel.sublist = sList()
CategorySel:appendWidget(CategorySel.sublist, 5, 5 + 24)
CategorySel.sublist:setSize(-10, -70)
CategorySel.sublist.cid = 0

function CategorySel.sublist:action(sid)
    push_screen(SubCatSel, sid)
end

function CategorySel:charIn(ch)
    if ch == "l" then
        loadExtDB()
        self:pushed() -- refresh list
        self:invalidate() -- asks for screen repaint
    end
end

function CategorySel:paint(gc)
    gc:setColorRGB(255, 255, 255)
    gc:fillRect(self.x, self.y, self.w, self.h)

    if not kIsInSubCatScreen then
        gc:setColorRGB(0, 0, 0)
        gc:setFont("sansserif", "r", 16)
        gc:drawString("FormulaPro", self.x + 5, 0, "top")

        gc:setFont("sansserif", "r", 12)
        gc:drawString("v1.4b", self.x + .4 * self.w, 4, "top")

        gc:setFont("sansserif", "r", 12)
        gc:drawString("by TI-Planet", self.x + self.w - gc:getStringWidth("by TI-Planet") - 5, 4, "top")

        gc:setColorRGB(220, 220, 220)
        gc:setFont("sansserif", "r", 8)
        gc:drawRect(5, self.h - 46 + 10, self.w - 10, 25 + 6)
        gc:setColorRGB(128, 128, 128)
    end

    local splinfo = Categories[self.sublist.sel].info:split("\n")
    for i, str in ipairs(splinfo) do
        gc:drawString(str, self.x + 7, self.h - 56 + 12 + i * 10, "top")
    end
    self.sublist:giveFocus()
end

function CategorySel:pushed()
    local items = {}
    for cid, cat in ipairs(Categories) do
        table.insert(items, cat.name)
    end

    self.sublist.items = items
    self.sublist:giveFocus()
end

function CategorySel:tabKey()
    push_screen_back(Ref)
end



SubCatSel = WScreen()
SubCatSel.sel = 1

SubCatSel.sublist = sList()
SubCatSel:appendWidget(SubCatSel.sublist, 5, 5 + 24)
SubCatSel.back = sButton(utf8(9664) .. " Back")
SubCatSel:appendWidget(SubCatSel.back, 5, -5)
SubCatSel.sublist:setSize(-10, -66)
SubCatSel.sublist.cid = 0

function SubCatSel.back:action()
    SubCatSel:escapeKey()
end

function SubCatSel.sublist:action(sub)
    local cid = self.parent.cid
    if #Categories[cid].sub[sub].formulas > 0 then
        push_screen(manualSolver, cid, sub)
    end
end

function SubCatSel:paint(gc)
    gc:setColorRGB(255, 255, 255)
    gc:fillRect(self.x, self.y, self.w, self.h)
    gc:setColorRGB(0, 0, 0)
    gc:setFont("sansserif", "r", 16)
    gc:drawString(Categories[self.cid].name, self.x + 5, 0, "top")
end

function SubCatSel:pushed(sel)

    kIsInSubCatScreen = true
    self.cid = sel
    local items = {}
    for sid, subcat in ipairs(Categories[sel].sub) do
        table.insert(items, subcat.name .. (#subcat.formulas == 0 and " (Empty)" or ""))
    end

    if self.sublist.cid ~= sel then
        self.sublist.cid = sel
        self.sublist:reset()
    end

    self.sublist.items = items
    self.sublist:giveFocus()
end

function SubCatSel:escapeKey()
    kIsInSubCatScreen = false
    only_screen_back(CategorySel)
end



-------------------
-- Manual solver --
-------------------

manualSolver = WScreen()
manualSolver.pl = sScreen(-20, -50)
manualSolver:appendWidget(manualSolver.pl, 2, 4)

manualSolver.sb = scrollBar(-50)
manualSolver:appendWidget(manualSolver.sb, -2, 3)

manualSolver.back = sButton(utf8(9664) .. " Back")
manualSolver:appendWidget(manualSolver.back, 5, -5)

manualSolver.usedFormulas = sButton("Formulas")
manualSolver:appendWidget(manualSolver.usedFormulas, -5, -5)

function manualSolver.back:action()
    manualSolver:escapeKey()
end

function manualSolver.usedFormulas:action()
    push_screen_direct(usedFormulas)
end

function manualSolver.sb:action(top)
    self.parent.pl:setY(4 - top * 30)
end

function manualSolver:paint(gc)
    gc:setColorRGB(224, 224, 224)
    gc:fillRect(self.x, self.y, self.w, self.h)
    gc:setColorRGB(128, 128, 128)
    gc:fillRect(self.x + 5, self.y + self.h - 42, self.w - 10, 2)
    self.sb:update(math.floor(-(self.pl.oy - 4) / 30 + .5))

    gc:setFont("sansserif", "r", 10)
    local name = self.sub.name
    local len = gc:getStringWidth(name)
    if len >= .7*self.w then name = string.sub(name, 1, -10) .. ". " end
    local len = gc:getStringWidth(name)
    local x = self.x + (self.w - len) / 2

    --gc:setColorRGB(255,255,255)
    --gc:fillRect(x-3, 10, len+6, 18)

    gc:setColorRGB(0, 0, 0)
    gc:drawString(name, x, self.h - 28, "top")
    --gc:drawRect(x-3, 10, len+6, 18)
end

function manualSolver:postPaint(gc)
    --gc:setColorRGB(128,128,128)
    --gc:drawRect(self.x, self.y, self.w, self.h-46)
end

basicFuncsInited = false

function manualSolver:pushed(cid, sid)

    if not basicFuncsInited then
        initBasicFunctions()
        basicFuncsInited = true
    end

    self.pl.widgets = {}
    self.pl.focus = 0
    self.cid = cid
    self.sid = sid
    self.sub = Categories[cid].sub[sid]
    self.pl.oy = 0
    self.known = {}
    self.inputs = {}
    self.constants = {}

    local inp, lbl
    local i = 0
    local nodropdown, lastdropdown
    for variable, _ in pairs(self.sub.variables) do


        if not Constants[variable] or Categories[cid].varlink[variable] then
            i = i + 1
            inp = sInput()
            inp.value = ""
            --inp.number	= true

            function inp:enterKey()
                if not tonumber(self.value) and #self.value > 0 then
                    if not manualSolver:preSolve(self) then
                        self.value = self.value .. "   " .. utf8(8658) .. " Invalid input"
                    end
                end
                manualSolver:solve()
                self.parent:switchFocus(1)
            end

            self.inputs[variable] = inp
            inp.ww = -145
            inp.focusDown = 4
            inp.focusUp = -2
            lbl = sLabel(variable, inp)

            self.pl:appendWidget(inp, 60, i * 30 - 28)
            self.pl:appendWidget(lbl, 2, i * 30 - 28)
            self.pl:appendWidget(sLabel(":", inp), 50, i * 30 - 28)

            print(variable)
            local variabledata = Categories[cid].varlink[variable]
            inp.placeholder = variabledata.info

            if nodropdown then
                inp.focusUp = -1
            end

            if variabledata then
                if variabledata.unit ~= "unitless" then
                    --unitlbl	= sLabel(variabledata.unit:gsub("([^%d]+)(%d)", numberToSub))
                    local itms = { variabledata.unit }
                    for k, _ in pairs(Units[variabledata.unit]) do
                        table.insert(itms, k)
                    end
                    inp.dropdown = sDropdown(itms)
                    inp.dropdown.unitmode = true
                    inp.dropdown.change = self.update
                    inp.dropdown.focusUp = nodropdown and -5 or -4
                    inp.dropdown.focusDown = 2
                    self.pl:appendWidget(inp.dropdown, -2, i * 30 - 28)
                    nodropdown = false
                    lastdropdown = inp.dropdown
                else
                    self.pl:appendWidget(sLabel("Unitless"), -32, i * 30 - 28)
                end
            else
                nodropdown = true
                inp.focusDown = 1
                if lastdropdown then
                    lastdropdown.focusDown = 1
                    lastdropdown = false
                end
            end

            inp.getFocus = manualSolver.update
        else
            self.constants[variable] = math.eval(Constants[variable].value)
            --var.store(variable, self.known[variable])
        end
    end
    inp.focusDown = 1

    manualSolver.sb:update(0, math.floor(self.pl.h / 30 + .5), i)
    self.pl:giveFocus()

    self.pl.focus = 1
    self.pl:getWidget().hasFocus = true
    self.pl:getWidget():getFocus()
end

function manualSolver.update()
    manualSolver:solve()
end

function manualSolver:preSolve(input)
    local res, err
    res, err = math.eval(input.value)
    res = res and round(res, 4)
    print("Presolve : ", input.value .. " = " .. tostring(res), "(err ? = " .. tostring(err) .. ")")
    input.value = res and tostring(res) or input.value
    return res and 1 or false
end

function manualSolver:solve()
    local inputed = {}
    local disabled = {}

    for variable, input in pairs(self.inputs) do
        local variabledata = Categories[self.cid].varlink[variable]
        if input.disabled then
            inputed[variable] = nil
            input.value = ""
        end

        input:enable()
        if input.value ~= "" then
            local tmpstr = input.value:gsub(utf8(8722), "-")
            inputed[variable] = tonumber(tmpstr)
            if input.dropdown and input.dropdown.rvalue ~= variabledata.unit then
                inputed[variable] = Units.subToMain(variabledata.unit, input.dropdown.rvalue, inputed[variable])
            end
        end
    end

    local invs = copyTable(inputed)
    for k, v in pairs(self.constants) do
        invs[k] = v
    end
    self.known = find_data(invs, self.cid, self.sid)

    for variable, value in pairs(self.known) do
        if (not inputed[variable] and self.inputs[variable]) then
            local variabledata = Categories[self.cid].varlink[variable]
            local result = tostring(value)
            local input = self.inputs[variable]

            if input.dropdown and input.dropdown.rvalue ~= variabledata.unit then
                result = Units.mainToSub(variabledata.unit, input.dropdown.rvalue, result)
            end

            input.value = result
            input:disable()
        end
    end
end

function manualSolver:escapeKey()
    only_screen_back(SubCatSel, self.cid)
end

function manualSolver:contextMenu()
    push_screen_direct(usedFormulas)
end

usedFormulas = Dialog("Used formulas", 10, 10, -20, -20)

usedFormulas.but = sButton("Close")

usedFormulas:appendWidget(usedFormulas.but, -10, -5)

function usedFormulas:postPaint(gc)
    if self.ed then
        self.ed:move(self.x + 5, self.y + 30)
        self.ed:resize(self.w - 9, self.h - 74)
    end

    nativeBar(gc, self, self.h - 40)
end

function usedFormulas:pushed()
    doNotDisplayIcon = true
    self.ed = D2Editor.newRichText()
    self.ed:setReadOnly(true)
    local cont = ""

    local fmls = #manualSolver.sub.formulas
    for k, v in ipairs(manualSolver.sub.formulas) do
        cont = cont .. k .. ": \\0el {" .. v.formula .. "} " .. (k < fmls and "\n" or "")
    end

    if self.ed.setExpression then
        self.ed:setExpression(cont, 1)
        self.ed:registerFilter{ escapeKey = usedFormulas.closeEditor, enterKey = usedFormulas.closeEditor, tabKey = usedFormulas.leaveEditor }
        self.ed:setFocus(true)
    else
        self.ed:setText(cont, 1)
    end

    self.but:giveFocus()
end

function usedFormulas.leaveEditor()
    platform.window:setFocus(true)
    usedFormulas.but:giveFocus()
    return true
end

function usedFormulas.closeEditor()
    platform.window:setFocus(true)
    if current_screen() == usedFormulas then
        remove_screen()
    end
    doNotDisplayIcon = false
    return true
end

function usedFormulas:screenLoseFocus()
    self:removed()
end

function usedFormulas:screenGetFocus()
    self:pushed()
end

function usedFormulas:removed()
    if usedFormulas.ed.setVisible then
        usedFormulas.ed:setVisible(false)
    else
        usedFormulas.ed:setText("")
        usedFormulas.ed:resize(1, 1)
        usedFormulas.ed:move(-10, -10)
    end
    usedFormulas.ed = nil
    doNotDisplayIcon = false
end

function usedFormulas.but.action(self)
    remove_screen()
end	


function initBasicFunctions()
    local basicFunctions = {
        ["erf"] = [[Define erf(x)=Func:2/sqrt(pi)*integral(exp(-t*t),t,0,x):EndFunc]],
        ["erfc"] = [[Define erfc(x)=Func:1-erf(x):EndFunc]],
        ["ni"] = [[Define ni(ttt)=Func:7.7835*10^21*ttt^(3/2)*exp((4.73*10^-4*ttt^2/(ttt+636)-1.17)/(1.72143086667*10^-4*ttt)):EndFunc]],
        ["eegalv"] = [[Define eegalv(rrx,rr2,rr3,rr4,rrg,rrs,vs)=Func:Local rra,rrb,rrc,vb,rg34,rx2ab: rg34:=rrg+rr3+rr4:  rra:=((rrg*rr3)/(rg34)): rrb:=((rrg*rr4)/(rg34)): rrc:=((rr3*rr4)/(rg34)): rx2ab:=rrx+rr2+rra+rrb: rra:=((rrg*rr3)/(rg34)): vb:=((((vs*(rrx+rra)*(rr2+rrb))/(rx2ab)))/(rrs+rrc+(((rrx+rra)*(rr2+rrb))/(rx2ab)))): vb*(((rx)/(rrx+rra))-((rr2)/(rr2+rrb))):Return :EndFunc]],
    }
    for var, func in pairs(basicFunctions) do
        math.eval(func .. ":Lock " .. var) -- defines and prevents against delvar.
    end
end

RefBoolAlg = Screen()

RefBoolAlg.data = {
    { "x+0=x", "x.1=x", "Identity" },
    { "x+x'=1", "x.x'=0", "Inverse" },
    { "x+x=x", "x.x=x", "Idempotent" },
    { "x+1=1", "x.0=0", "Null Element" },
    { "(x')'=x", "(x')'=x", "Involution" },
    { "x+y=y+x", "x.y=y.x", "Commutative" },
    { "x+(y+z)=(x+y)+z", "x.(y.z)=(x.y).z", "Associative" },
    { "x.(y+z)=(x.y)+(x.z)", "x+(y.z)=(x+y).(x+z)", "Distributive" },
    { "x+(x.y)=x", "x.(x+y)=x", "Absorption" },
    { "(x+y+z)'=x'.y'.z'", "(x.y.z)'=x'+y'+z'", "DeMorgan's Law" },
    { "(x.y)+(x'.z)+(y.z)=(x.y)+(x'.z)", "(x+y).(x'+z).(y+z)=(x+y).(x'+z)", "Consensus" }
}

RefBoolAlg.tmpScroll = 1
RefBoolAlg.dual = false

function RefBoolAlg:arrowKey(arrw)
    if pww() < 330 then
        if arrw == "up" then
            RefBoolAlg.tmpScroll = RefBoolAlg.tmpScroll - test(RefBoolAlg.tmpScroll > 1)
        end
        if arrw == "down" then
            RefBoolAlg.tmpScroll = RefBoolAlg.tmpScroll + test(RefBoolAlg.tmpScroll < (table.getn(RefBoolAlg.data) - 7))
        end
        screenRefresh()
    end
end

function RefBoolAlg:enterKey()
    RefBoolAlg.dual = not RefBoolAlg.dual
    RefBoolAlg:invalidate()
end

function RefBoolAlg:escapeKey()
    only_screen_back(Ref)
end

function RefBoolAlg:paint(gc)
    gc:setColorRGB(255, 255, 255)
    gc:fillRect(self.x, self.y, self.w, self.h)
    gc:setColorRGB(0, 0, 0)

    msg = "Boolean Algebra : "
    gc:setFont("sansserif", "b", 12)
    if RefBoolAlg.tmpScroll > 1 and pww() < 330 then
        gc:drawString(utf8(9650), gc:getStringWidth(utf8(9664)) + 7, 0, "top")
    end
    if RefBoolAlg.tmpScroll < table.getn(RefBoolAlg.data) - 7 and pww() < 330 then
        gc:drawString(utf8(9660), pww() - 4 * gc:getStringWidth(utf8(9654)) - 2, 0, "top")
    end
    drawXCenteredString(gc, msg, 0)
    gc:setFont("sansserif", "i", 12)
    drawXCenteredString(gc, "Press Enter for Dual ", 15)
    gc:setFont("sansserif", "r", 12)

    local tmp = 0
    for k = RefBoolAlg.tmpScroll, table.getn(RefBoolAlg.data) do
        tmp = tmp + 1
        gc:setFont("sansserif", "b", 12)
        gc:drawString(RefBoolAlg.data[k][3], 3, 10 + 22 * tmp, "top")
        gc:setFont("sansserif", "r", 12)
        gc:drawString(RefBoolAlg.data[k][1 + test(RefBoolAlg.dual)], 125 - 32 * test(k == 11) * test(pww() < 330) + 30 * test(pww() > 330) + 12, 10 + 22 * tmp, "top")
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
	only_screen_back(Ref)
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
{"Rydberg constant","r","1.0974 x 10^7 m^-1"},
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
	only_screen_back(Ref)
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
	only_screen_back(Ref)
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
	only_screen_back(Ref)
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
	only_screen_back(Ref)
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
RefList:setSize(-8, -32)

Ref:appendWidget(RefList, 4, Ref.y+28)

function Ref.addRefs()
	for n, ref in ipairs(References) do
		if ref.screen then
			table.insert(RefList.items, ref.title)
		else
			table.insert(RefList.items, ref.title .. " (not yet done)")  -- TODO !
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

function Ref:paint(gc)
    gc:setFont("serif", "b", 16)
    gc:drawString("Reference", self.x+6, -2, "top")
    gc:setFont("serif", "r", 12)
end

function Ref:tabKey()
    push_screen(CategorySel)
end

Ref.escapeKey = Ref.tabKey

Ref.addRefs()



aboutWindow	= Dialog("About FormulaPro :", 50, 20, 280, 180)

local aboutstr	= [[FormulaPro v1.4b
--------------------
Jim Bauwens, Adrien "Adriweb" Bertrand
Thanks also to Levak.
LGPL3 License.
More info and contact : 
tiplanet.org  -  inspired-lua.org


Tip : Press [Tab] for Reference !]]

local aboutButton	= sButton("OK")

for i, line in ipairs(aboutstr:split("\n")) do
	local aboutlabel	= sLabel(line)
	aboutWindow:appendWidget(aboutlabel, 10, 27 + i*14-12)
end

aboutWindow:appendWidget(aboutButton,-10,-5)

function aboutWindow:postPaint(gc)
	nativeBar(gc, self, self.h-40)
	on.help = function() return 0 end
end

aboutButton:giveFocus()

function aboutButton:action()
	remove_screen(aboutWindow)
	on.help = function() push_screen_direct(aboutWindow) end
end

----------------------------------------

function on.help()
	push_screen_direct(aboutWindow)
end

----------------------------------------


function errorPopup(gc)
    
    errorHandler.display = false

    errorDialog = Dialog("Oops...", 50, 20, "85", "80")

    local textMessage	= [[FormulaPro has encountered an error
-----------------------------
Sorry for the inconvenience.
Please report this bug to info@tiplanet.org
How/where/when it happened etc.
 (bug at line ]] .. errorHandler.errorLine .. ")"
    
    local errorOKButton	= sButton("OK")
    
    for i, line in ipairs(textMessage:split("\n")) do
        local errorLabel = sLabel(line)
        errorDialog:appendWidget(errorLabel, 10, 27 + i*14-12)
    end
    
    errorDialog:appendWidget(errorOKButton,-10,-5)
    
    function errorDialog:postPaint(gc)
        nativeBar(gc, self, self.h-40)
    end
    
    errorOKButton:giveFocus()
    
    function errorOKButton:action()
        remove_screen(errorDialog)
        errorHandler.errorMessage = nil
    end
    
    push_screen_direct(errorDialog)
end

---------------------------------------------------------------

function on.create()
	platform.os = "3.1"
end

function on.construction()
	platform.os = "3.2"
end

errorHandler = {}

function handleError(line, errMsg, callStack, locals)
    print("Error handled !", errMsg)
    errorHandler.display = true
    errorHandler.errorMessage = errMsg
    errorHandler.errorLine = line
    errorHandler.callStack = callStack
    errorHandler.locals = locals
    platform.window:invalidate()
    return true -- go on....
end

if platform.registerErrorHandler then
    platform.registerErrorHandler( handleError )
end



----------------------------------------------  Launch !

push_screen_direct(CategorySel)

