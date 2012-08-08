
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

