
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

