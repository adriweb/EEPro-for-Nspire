
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

