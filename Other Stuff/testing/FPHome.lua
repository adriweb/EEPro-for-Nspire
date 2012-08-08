 platform.apilevel = "1.0"

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
	gc:drawString(str, (pww() - gc:getStringWidth(str)) / 2, pwh() / 2, "middle")
end

function drawXCenteredString(gc, str,y)
	gc:drawString(str, (pww() - gc:getStringWidth(str)) / 2, y, "top")
end

function verticalBar(gc,x)
	gc:fillRect(x,0,1,pwh())
end

function horizontalBar(gc,y)
	gc:fillRect(0,y,pww(),1)
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
	y = y-ht/2 -- sameefz, radius*2, radius*2, 1, -91);
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

function on.create()
	
	
end


function on.paint(gc)
	gc:setFont("sansserif","b",18)
	gc:drawString("EEProNspire",5,-8,"top")
	gc:setFont("sansserif","b",10)
	gc:drawString("Welcome !",pww()-gc:getStringWidth("Welcome !")-5,4,"top")
	gc:setFont("serif","r",12)
	horizontalBar(gc,30)
	gc:setColorRGB(65,85,255)
	gc:fillRect(0,31,pww(),pwh())
	gc:setColorRGB(0,0,0)
	horizontalBar(gc,pwh()-25)
	drawXCenteredString(gc,"v0.1 The EEProNspire Team - TI-Planet.org",pwh()-22)
	
	
    gc:setColorRGB(0,0,0)
	drawRoundRect(gc,pww()/6+2,pwh()/3.3+50,pww()/4.5,pwh()/2.5,8)
	drawRoundRect(gc,3*pww()/6+2,pwh()/3.3+50,pww()/4.5,pwh()/2.5,8)
	drawRoundRect(gc,5*pww()/6+2,pwh()/3.3+50,pww()/4.5,pwh()/2.5,8)
	gc:setColorRGB(0xd6,0xba,0x00)
	fillRoundRect(gc,pww()/6+3,pwh()/3.3+50,pww()/4.5,pwh()/2.5-1,7)
	fillRoundRect(gc,3*pww()/6+3,pwh()/3.3+50,pww()/4.5,pwh()/2.5-1,7)
	fillRoundRect(gc,5*pww()/6+3,pwh()/3.3+50,pww()/4.5,pwh()/2.5-1,7)
	
    gc:setColorRGB(0,0,0)
	drawRoundRect(gc,pww()/6+1,pwh()/3.3,pww()/3.5-6,pwh()/10,8)
	drawRoundRect(gc,3*pww()/6+1,pwh()/3.3,pww()/3.5-6,pwh()/10,8)
	drawRoundRect(gc,5*pww()/6+1,pwh()/3.3,pww()/3.5-6,pwh()/10,8)
	gc:setColorRGB(0,180,0)
	fillRoundRect(gc,pww()/6+1.5,pwh()/3.3,pww()/3.5-7,pwh()/10-1,7)
	fillRoundRect(gc,3*pww()/6+1.5,pwh()/3.3,pww()/3.5-7,pwh()/10-1,7)
	fillRoundRect(gc,5*pww()/6+1.5,pwh()/3.3,pww()/3.5-7,pwh()/10-1,7)
end
