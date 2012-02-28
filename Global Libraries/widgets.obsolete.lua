
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
