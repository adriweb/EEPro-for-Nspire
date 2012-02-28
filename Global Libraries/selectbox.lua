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


upButton=image.new("\011\0\0\0\010\0\0\0\0\0\0\0\022\0\0\0\016\0\001\0001\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\198\255\255\255\255\255\255\255\255\156\243\255\255\255\255\255\255\255\2551\1981\198\255\255\255\255\255\255\214\218\0\128\214\218\255\255\255\255\255\2551\1981\198\255\255\255\255\247\222B\136\0\128B\136\247\222\255\255\255\2551\1981\198\255\255\247\222B\136!\132\0\128!\132B\136\247\222\255\2551\1981\198\247\222B\136!\132B\136R\202B\136!\132B\136\247\2221\1981\198\132\144B\136B\136\247\222\255\255\247\222B\136B\136\132\1441\1981\198\156\243\132\144\247\222\255\255\255\255\255\255\247\222\132\144\189\2471\1981\198\255\255\222\251\255\255\255\255\255\255\255\255\255\255\222\251\255\2551\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\198")
downButton=image.new("\011\0\0\0\010\0\0\0\0\0\0\0\022\0\0\0\016\0\001\0001\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\198\255\255\222\251\255\255\255\255\255\255\255\255\255\255\222\251\255\2551\1981\198\156\243\132\144\247\222\255\255\255\255\255\255\247\222\132\144\189\2471\1981\198\132\144B\136B\136\247\222\255\255\247\222B\136B\136\132\1441\1981\198\247\222B\136!\132B\136R\202B\136!\132B\136\247\2221\1981\198\255\255\247\222B\136!\132\0\128!\132B\136\247\222\255\2551\1981\198\255\255\255\255\247\222B\136\0\128B\136\247\222\255\255\255\2551\1981\198\255\255\255\255\255\255\214\218\0\128\214\218\255\255\255\255\255\2551\1981\198\255\255\255\255\255\255\255\255\156\243\255\255\255\255\255\255\255\2551\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\198")

scroll1	= {96, 100, 96}
scroll2	= {184, 184, 184}

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
	
	gc:setColorRGB(unpack(scroll1))
	gc:drawImage(upButton, x + w - 13, y + 3)
	gc:drawImage(downButton, x + w - 13, y + h - 12)
	
	gc:drawRect(x + w - 12, y + 15, 8, h - 30)
	
	if visible_items<#items then
		local step	= (h-28)/#items
		gc:fillRect(x + w - 12, y + 15 + step*top, 9, step*visible_items)
		gc:setColorRGB(unpack(scroll2))
		gc:fillRect(x + w - 13, y + 15 + step*top, 1, step*visible_items)
		gc:fillRect(x + w - 3, y + 15 + step*top, 1, step*visible_items)
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
