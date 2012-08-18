function uCol(col)
	return col[1] or 0, col[2] or 0, col[3] or 0
end

function textLim(gc, text, max)
	local ttext, out = "",""
	if gc:getStringWidth(text)<max then
		return text
	else
		for i=1, #text do
			ttext	= text:usub(1, i)
			if gc:getStringWidth(ttext .. "..")>max then
				break
			end
			out = ttext
		end
		return out .. ".."
	end
end

scrollBar	= class(Widget)

scrollBar.upButton=image.new("\011\0\0\0\010\0\0\0\0\0\0\0\022\0\0\0\016\0\001\0001\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\198\255\255\255\255\255\255\255\255\156\243\255\255\255\255\255\255\255\2551\1981\198\255\255\255\255\255\255\214\218\0\128\214\218\255\255\255\255\255\2551\1981\198\255\255\255\255\247\222B\136\0\128B\136\247\222\255\255\255\2551\1981\198\255\255\247\222B\136!\132\0\128!\132B\136\247\222\255\2551\1981\198\247\222B\136!\132B\136R\202B\136!\132B\136\247\2221\1981\198\132\144B\136B\136\247\222\255\255\247\222B\136B\136\132\1441\1981\198\156\243\132\144\247\222\255\255\255\255\255\255\247\222\132\144\189\2471\1981\198\255\255\222\251\255\255\255\255\255\255\255\255\255\255\222\251\255\2551\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\198")
scrollBar.downButton=image.new("\011\0\0\0\010\0\0\0\0\0\0\0\022\0\0\0\016\0\001\0001\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\198\255\255\222\251\255\255\255\255\255\255\255\255\255\255\222\251\255\2551\1981\198\156\243\132\144\247\222\255\255\255\255\255\255\247\222\132\144\189\2471\1981\198\132\144B\136B\136\247\222\255\255\247\222B\136B\136\132\1441\1981\198\247\222B\136!\132B\136R\202B\136!\132B\136\247\2221\1981\198\255\255\247\222B\136!\132\0\128!\132B\136\247\222\255\2551\1981\198\255\255\255\255\247\222B\136\0\128B\136\247\222\255\255\255\2551\1981\198\255\255\255\255\255\255\214\218\0\128\214\218\255\255\255\255\255\2551\1981\198\255\255\255\255\255\255\255\255\156\243\255\255\255\255\255\255\255\2551\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\198")

function scrollBar:init(h)
	self.color1	= {96, 100, 96}
	self.color2	= {184, 184, 184}
	
	self.dh	= h
	self.dw = 15
	
	self.visible = 10
	self.total   = 10
	self.top     = 0
end

function scrollBar:paint(gc)
	gc:setColorRGB(uCol(self.color1))
	gc:drawImage(self.upButton  , self.x+2, self.y+2)
	gc:drawImage(self.downButton, self.x+2, self.y+self.h-15)
	
	gc:drawRect(x + 3, y + 15, 8, h - 30)
	
	if self.visible<self.total then
		local step	= (self.h-28)/self.total
		gc:fillRect(x + 4, y + 15  + step*self.top, 9, step*self.visible)
		gc:setColorRGB(uCol(scroll2))
		gc:fillRect(x + 3 , y + 15 + step*self.top, 1, step*self.visible)
		gc:fillRect(x + 13, y + 15 + step*self.top, 1, step*self.visible)
	end
end



sList	= class(Widget)

function sList:init()
	self.dw	= 150
	self.dh	= 153

	self.ih	= 18

	self.top	= 0
	self.sel	= 1
	
	self.font	= {"sansserif", "r", 10}
	self.colors	= {50,150,190}
	self.items	= {}
end


function sList:paint(gc)
	local x	= self.x
	local y	= self.y
	local w	= self.w
	local h	= self.h
	
	
	local ih	= self.ih   
	local top	= self.top		
	local sel	= self.sel		
		      
	local items	= self.items			
	
	gc:setColorRGB(0, 0, 0)
	gc:drawRect(x, y, w, h)
	gc:clipRect("set", x, y, w, h)
	gc:setFont(unpack(self.font))

	local visible_items	= math.floor(h/ih)	
	local label, item
	for i=1, math.min(#items-top, visible_items+1) do
		item	= items[i+top]
		label	= textLim(gc, item, w-(5 + 12 + 2 + 1))
		
		if i+top == sel then
			gc:setColorRGB(unpack(self.colors))
			gc:fillRect(x+1, y + i*ih-ih + 1, w-(12 + 2 + 2), ih)
			
			gc:setColorRGB(255, 255, 255)
		end
		
		gc:drawString(label, x+5, y + i*ih-ih , "top")
		gc:setColorRGB(0, 0, 0)
	end
	

	gc:clipRect("reset")
end

function sList:arrowKey(arrow)	
	if arrow=="up" and self.sel>1 then
		self.sel	= self.sel - 1
		if self.top>=self.sel then
			self.top	= self.top - 1
		end
	end

	if arrow=="down" and self.sel<#self.items then
		self.sel	= self.sel + 1
		if self.sel>(self.h/self.ih)+self.top then
			self.top	= self.top + 1
		end
	end
end

home	= WScreen()
list	= sList()
list.items	= {"I", "lost", "the", "game", "abcdefghijklmnopqrstuvwxyz","rawr","meh","Again","Adriweb","is","a","baby"}
home:appendWidget(list, 10, 10)
list:focus()

push_screen(home)
