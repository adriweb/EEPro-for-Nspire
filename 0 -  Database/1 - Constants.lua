--------------------------
---- FormulaPro v1.1b ----
----- LGLP 3 License -----
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
