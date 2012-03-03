------------------------------------------------------------------
--                        Widget  Class                         --
------------------------------------------------------------------

Widget	=	class()

function Widget:init()
	self.dw	=	10
	self.dh	=	10
end


function Widget:size()
	self.rx	=	math.floor(Pr(self.xx, 0, self.parent.w)+.5)
	self.ry	=	math.floor(Pr(self.yy, 0, self.parent.h)+.5)
	self.x	=	self.parent.x + self.rx
	self.y	=	self.parent.y + self.ry
	
	self.w	=	math.floor(Pr(self.ww, self.dw, self.parent.w)+.5)
	self.h	=	math.floor(Pr(self.hh, self.dh, self.parent.h)+.5)
end

function Widget:prePaint()

end

function Widget:paint(gc) 
	--gc:drawRect(self.x, self.y, self.w, self.h)
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
function Widget:arrowKey(key)end
function Widget:mouseDown(x, y) end
function Widget:mouseUp(x, y) end
function Widget:mouseMove(x, y) end
function Widget:enterKey() 
	self.parent:switchFocus(1)
end
function Widget:charIn() end
function Widget:escapeKey() end
function Widget:backspaceKey() end




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
--                         List Widget                          --
------------------------------------------------------------------

sList	=	class(Widget)

function sList:init()
	self.dw	=	100
	self.dh	=	10
	
	self.items	=	{}
	self.sel	=	1
	self.font	=	{"sansserif", "r", 10}
	self.itemh	=	18
	self.hitems	=	4
	
	self.dh	=	4 * self.itemh + 1
	
	self.color1	=	{160,160,160} 
	self.color2	=	{200,200,200}
	self.scolor	=	{40,40,40}
	self.bgcolor	=	{240,240,245}
	self.textc	=	{0,0,0}
	self.texts	=	{220,220,220}
	
	self.shrink	=	false
	self.offset	=	0
end

function sList:prePaint(gc)
	self.hitems	=	math.floor((self.h-1)/self.itemh)
	local height	=	self.hitems*self.itemh+1
	self.he	=	self.h-height
	if self.shrink then
		self.h	=	height
	end
end

function sList:paint(gc)
	local x	=	self.x
	local y = 	self.y
	local n	=	#self.items
	
	gc:setColorRGB(unpack(self.bgcolor))
	gc:setFont(unpack(self.font))
	gc:fillRect(self.x, self.y, self.w, self.h)
	gc:setColorRGB(0,0,0)
	gc:drawRect(x, y, self.w, self.h)
	
	for i=1, math.min(n, self.hitems) do
		local color	= ((i+self.offset)%2==0) and self.color1 or self.color2
		
		if i + self.offset	==	self.sel and self.hasFocus then color = self.scolor end
		gc:setColorRGB(unpack(color))
		gc:fillRect(x+1, y + 1 + i*self.itemh-self.itemh , self.w-1, self.itemh)
		
		local tcolor	=	self.textc
		if i + self.offset	==	self.sel and self.hasFocus then tcolor = self.texts end		
		gc:setColorRGB(unpack(tcolor))
		gc:drawString(self.items[i+self.offset], x+1, y+1 + i*self.itemh-self.itemh*1.15, "top")
	end
	local i	=	math.min(n, self.hitems)+1
	local color	= ((i+self.offset)%2==0) and self.color1 or self.color2
	if n>self.hitems and not self.shrink then
		gc:setColorRGB(unpack(color))
		gc:fillRect(x+1, y + 1 + i*self.itemh-self.itemh , self.w-1, self.he)
	end
	
	gc:setColorRGB(0,0,0)
	local selp	=	math.max(n/self.hitems,1)
	gc:fillRect(x+self.w+2, 2 + y + (self.offset*self.itemh)/selp, 3, (self.hitems*18)/selp)
end

function sList:arrowKey(arrow)
	if #self.items==0 then return end
	
	if arrow	==	"up" and self.sel>1 then
		self.sel	=	self.sel - 1
		if self.offset==self.sel then
			self.offset	=	self.offset - 1
		end
		
	elseif arrow	==	"down" and self.sel<#self.items then
		self.sel	=	self.sel + 1
		if self.offset + self.hitems < self.sel then
			self.offset	=	self.offset + 1
		end
	end
	
end

function sList:mouseUp(xx, yy)
	if xx>=self.x and yy>=self.y and xx<self.x+self.w and yy<self.y+self.h then
		self.sel	=	self.offset + math.ceil((yy-self.y)/self.itemh)
		if self.sel>#self.items then self.sel=#self.items end
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
	self.font	=	{"sansserif", "r", 10}
	
end

function sInput:paint(gc)
	self.gc	=	gc
	local x	=	self.x
	local y = 	self.y
	
	gc:setFont(unpack(self.font))
	gc:setColorRGB(unpack(self.bgcolor))
	gc:fillRect(x, y, self.w, self.h)

	gc:setColorRGB(0,0,0)
	gc:drawRect(x, y, self.w, self.h)
	if self.hasFocus then
		gc:drawRect(x-1, y-1, self.w+2, self.h+2)
	end
		
	local text	=	""
	local	p	=	0
	
	while true do
		if p==#self.value then break end
		p	=	p + 1
		text	=	self.value:sub(-p, -p) .. text
		if gc:getStringWidth(text) > (self.w - 8) then
			text	=	text:sub(2,-1)
			break 
		end
	end
	
	if text==self.value then
		gc:drawString(text, x+2, y+1, "top")
	else
		gc:drawString(text, x-4+self.w-gc:getStringWidth(text), y+1, "top")
	end
	if self.hasFocus then
		gc:fillRect(self.x+(text==self.value and gc:getStringWidth(text)+2 or self.w-4), self.y, 1, self.h)
	end
	
end

function sInput:charIn(char)
	if self.number and not tonumber(self.value .. char) then
		return
	end
	self.value	=	self.value .. char
end

function sInput:backspaceKey()
	self.value	=	self.value:usub(1,-2)
end

--Label

sLabel	=	class(Widget)

function sLabel:init(text, widget)
	self.widget	=	widget
	self.text	=	text
	self.dw		=	30
	self.dh		=	20
	self.lim	=	false
	self.color	=	{0,0,0}
	self.font	=	{"sansserif", "r", 10}
	self.p		=	"top"
	
end

function sLabel:paint(gc)
	local text	=	""
	local ttext
	if self.lim then
		if gc:getStringWidth(self.text)<self.w then
			self.dw	= gc:getStringWidth(self.text)
			text = self.text
		else
			for i=1, #self.text do
				ttext	=	self.text:sub(1,i)
				if gc:getStringWidth(ttext .. "..")>self.w then
					break
				end
				text = ttext
			end
			text = text .. ".."
		end
	else
		text = self.text
	end
	
	gc:setFont(unpack(self.font))
	gc:setColorRGB(unpack(self.color))
	gc:drawString(text, self.x, self.y, self.p)
end

function sLabel:getFocus()
	if self.widget then
		self.widget:focus()
	end
end


--Button widget

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
	gc:setFont(unpack(self.font))
	self.w	=	gc:getStringWidth(self.text)+8
	gc:setColorRGB(248,252,248)
	gc:fillRect(self.x+2, self.y+2, self.w-4, self.h-4)
	gc:setColorRGB(0,0,0)
	
	gc:drawString(self.text, self.x+4, self.y+4, "top")
		
	gc:setColorRGB(unpack(self.bordercolor))
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
