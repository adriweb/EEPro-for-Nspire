------------------------------------------------------------------
--                        Widget  Class                         --
------------------------------------------------------------------

Widget	=	class(Screen)

function Widget:init()
	self.dw	=	10
	self.dh	=	10
end


function Widget:size()
	self.w	=	math.floor(Pr(self.ww, self.dw, self.parent.w)+.5)
	self.h	=	math.floor(Pr(self.hh, self.dh, self.parent.h)+.5)
	
	self.rx	=	math.floor(Pr(self.xx, 0, self.parent.w, self.w)+.5)
	self.ry	=	math.floor(Pr(self.yy, 0, self.parent.h, self.h)+.5)
	self.x	=	self.parent.x + self.rx
	self.y	=	self.parent.y + self.ry
	
end


function Widget:focus()
	if self.parent.focus~=0 then
		self.parent:getWidget().hasFocus	=	false
		self.parent:getWidget():loseFocus()
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

