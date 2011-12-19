------------------------------------------------------------------
--                        Widget  Class                         --
------------------------------------------------------------------

Widget	=	class()

function Widget:init()
	self.dw	=	10
	self.dh	=	10
end


function Widget:size()
	self.rx	=	Pr(self.xx, 0, self.parent.w)
	self.ry	=	Pr(self.yy, 0, self.parent.h)
	self.x	=	self.parent.x + self.rx
	self.y	=	self.parent.y + self.ry
	
	self.w	=	Pr(self.ww, self.dw, self.parent.w)
	self.h	=	Pr(self.hh, self.dh, self.parent.h)
end

function Widget:prePaint()

end

function Widget:paint(gc) 
	--gc:drawRect(self.x, self.y, self.w, self.h)
end

function Widget:getFocus() end
function Widget:loseFocus() end
function Widget:arrowKey(key)end
function Widget:mouseDown(x, y) end
function Widget:mouseUp(x, y) end
function Widget:mouseMove(x, y) end
function Widget:enterKey() end
function Widget:charIn() end
function Widget:escapeKey() end
function Widget:backspaceKey() end




------------------------------------------------------------------
--                        Sample Widget                         --
------------------------------------------------------------------


box	=	class(Widget)
function box:init(ww,hh)
	self.dy	=	10
	self.dx	=	10
	self.ww	=	ww
	self.hh	=	hh
end

function box:paint(gc)
	if self.hasFocus then
		gc:fillRect(self.x, self.y, self.w, self.h)
	else
		gc:drawRect(self.x, self.y, self.w, self.h)
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
	self.font	=	{"sansserif", "r", 11}
	self.itemh	=	18
	self.hitems	=	4
	
	self.dh	=	self.hitems * 18 + 1
	
	self.color1	=	{160,160,160} 
	self.color2	=	{200,200,200}
	self.scolor	=	{40,40,40}
	
	self.textc	=	{0,0,0}
	self.texts	=	{220,220,220}
	
	self.offset	=	0
end

function sList:prePaint()
	self.dh	=	self.hitems * 18 + 1
end

function sList:paint(gc)
	local x	=	self.x
	local y = 	self.y
	local n	=	#self.items
	
	gc:setFont(unpack(self.font))
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

function sList:enterKey()
	self:action(self.sel, self.items[self.sel])
end

function sList:action(n, item)

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
end

function sInput:paint(gc)
	self.gc	=	gc
	local x	=	self.x
	local y = 	self.y
	
	gc:setColorRGB(unpack(self.bgcolor))
	gc:fillRect(x, y, self.w, self.h)
	if self.hasFocus then
		gc:setPen("medium", "smooth")
	end
	gc:setColorRGB(0,0,0)
	gc:drawRect(x, y, self.w, self.h)
	gc:setPen("thin", "smooth")
	
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
		gc:drawString(text, x+2, y-2, "top")
	else
		gc:drawString(text, x-4+self.w-gc:getStringWidth(text), y-2, "top")
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

