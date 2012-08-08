
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

