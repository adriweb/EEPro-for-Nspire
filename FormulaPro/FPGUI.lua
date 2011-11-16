------------------------------------------------------------------
--                        Screen  Class                         --
------------------------------------------------------------------
Screen	=	class()

Screens	=	{}

function push_screen(screen)
	table.insert(Screens, screen)
end

function remove_screen(screen)
	return table.remove(Screens)
end

function current_screen()
	return Screens[#Screens]
end

function Screen:init(y,x,h,w)
	self.x	=	x or 0
	self.y	=	y or 0
	self.h	=	h or 212
	self.w	=	w or 318
	self.widgets	=	{}
	self.focus	=	0
end

function Screen:drawWidgets(gc) 
	for _, widget in pairs(self.widgets) do
		widget.widget:paint(gc)
		gc:setColorRGB(0,0,0)
	end
end

function Screen:appendWidget(widget, x, y) 
	local wt	=	{}
	wt.widget	=	widget
	wt.x	=	x
	wt.y	=	y
	wt.h	=	widget.h
	wt.w	=	widget.w
	
	widget.x	=	x
	widget.y	=	y
	widget.parent	=	self
	
	table.insert(self.widgets, wt)
end

function Screen:getWidget()
	return self.widgets[self.focus]
end

function Screen:draw(gc)
	self:drawWidgets(gc)
	self:paint(gc)
end

function Screen:switchFocus(n)
	if n~=0 or #self.widgets>0 then
		if self.focus~=0 then
			self:getWidget().widget.hasFocus	=	false
			self:getWidget().widget:loseFocus()
		end
		
		self.focus	=	self.focus + n
		if self.focus>#self.widgets then
			self.focus	=	1
		elseif self.focus<1 then
			self.focus	=	#self.widgets
		end	
		self:getWidget().widget.hasFocus	=	true	
		self:getWidget().widget:getFocus()
	end
end

function Screen:paint(gc)
	
end

function Screen:invalidate()
	platform.window:invalidate(self.x ,self.y , self.w, self.h)
end

function Screen:timer()		end

function Screen:arrowKey(arrow)	
	if self.focus~=0 then
		self:getWidget().widget:arrowKey(arrow)
	end
	self:invalidate()
end

function Screen:enterKey()	
	if self.focus~=0 then
		self:getWidget().widget:enterKey()
	end
	self:invalidate()
end

function Screen:backspaceKey()
	if self.focus~=0 then
		self:getWidget().widget:backspaceKey()
	end
	self:invalidate()
end

function Screen:escapeKey()	
	if self.focus~=0 then
		self:getWidget().widget:escapeKey()
	end
	self:invalidate()
end

function Screen:tabKey()	
	self:switchFocus(1)
	self:invalidate()
end

function Screen:backtabKey()	
	self:switchFocus(-1)
	self:invalidate()
end

function Screen:charIn(char)
	if self.focus~=0 then
		self:getWidget().widget:charIn(char)
	end
	self:invalidate()
end

function Screen:getWidgetIn(x, y)
	for n, widget in pairs(self.widgets) do
		if x>=widget.x and y>=widget.y and x<widget.x+widget.w and y<widget.y+widget.h then
			return n, widget
		end
	end 
end

function Screen:mouseDown(x, y) 
	local n, widget	=	self:getWidgetIn(x-self.x, y-self.y)
	if n then
		if self.focus~=0 then self:getWidget().widget.hasFocus = false self:getWidget().widget:loseFocus()  end
		self.focus	=	n
		
		widget.widget.hasFocus	=	true
		widget.widget:getFocus()

		widget.widget:mouseDown(x-self.x, y-self.y)
	else
		if self.focus~=0 then self:getWidget().widget.hasFocus = false self:getWidget().widget:loseFocus()  end
		self.focus	=	0
	end
end
function Screen:mouseUp(x, y)
	if self.focus~=0 then
		self:getWidget().widget:mouseUp(x-self.x, y-self.y)
	end
	self:invalidate()
end
function Screen:mouseMove(x, y)
	if self.focus~=0 then
		self:getWidget().widget:mouseMove(x-self.x, y-self.y)
	end
end



------------------------------------------------------------------
--                        Widget  Class                         --
------------------------------------------------------------------

Widget	=	class()

function Widget:init()
	self.x	=	0
	self.y	=	0
	self.w	=	10
	self.h	=	10
	
	self.parent	=	nil
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

function Widget:tx() return self.parent.x + self.x end
function Widget:ty() return self.parent.y + self.y end

------------------------------------------------------------------
--                   Bindings to the on events                  --
------------------------------------------------------------------


function on.paint(gc)	
	for _, screen in pairs(Screens) do
		screen:draw(gc)	
	end	
end

function on.timer()			current_screen():timer()		end
function on.arrowKey(arrw)	current_screen():arrowKey(arrw)	end
function on.enterKey()		current_screen():enterKey()		end
function on.escapeKey()		current_screen():escapeKey()	end
function on.tabKey()		current_screen():tabKey()		end
function on.backtabKey()	current_screen():backtabKey()	end
function on.charIn(ch)		current_screen():charIn(ch)		end
function on.backspaceKey()	current_screen():backspaceKey() end
function on.mouseDown(x,y)	current_screen():mouseDown(x,y)	end
function on.mouseUp(x,y)	current_screen():mouseUp(x,y)	end
function on.mouseMove(x,y)	current_screen():mouseMove(x,y)	end


------------------------------------------------------------------
--                        Sample Widget                         --
------------------------------------------------------------------


box	=	class(Widget)
function box:paint(gc)
	if self.hasFocus then
		gc:fillRect(self:tx(), self:ty(), self.w, self.h)
	else
		gc:drawRect(self:tx(), self:ty(), self.w, self.h)
	end
end

------------------------------------------------------------------
--                         List Widget                          --
------------------------------------------------------------------

sList	=	class(Widget)

function sList:init()
	self.x	=	0
	self.y	=	0
	self.w	=	100
	self.h	=	10
	
	self.parent	=	nil
	
	self.items	=	{}
	self.sel	=	1
	self.font	=	{"sansserif", "r", 11}
	self.itemh	=	18
	self.hitems	=	4
	
	self.h	=	self.hitems * 18 + 1
	
	self.color1	=	{160,160,160} 
	self.color2	=	{200,200,200}
	self.scolor	=	{40,40,40}
	
	self.textc	=	{0,0,0}
	self.texts	=	{220,220,220}
	
	self.offset	=	0
end

function sList:paint(gc)
	local x	=	self:tx()
	local y = 	self:ty()
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
	self.x	=	0
	self.y	=	0
	self.w	=	100
	self.h	=	20
	
	self.parent	=	nil

	self.value	=	""	
	self.bgcolor	=	{255,255,255}
end

function sInput:paint(gc)
	self.gc	=	gc
	local x	=	self:tx()
	local y = 	self:ty()
	
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
	self.value	=	self.value:sub(1,-2)
end

------------------------------------------------------------------
--                        Example usage                         --
------------------------------------------------------------------



--Create main screen
main	=	Screen(0,0)

--Main's paint event, draws msg to the screen
function main:paint(gc)
	if msg then
		gc:drawString(msg, 0, 0, "top")
	end
end

--Create a List widget
llist	=	sList()
llist.items = {"Adriweb","and","Levak","...","Lost","The","Game"}

--Add an action to the list
function llist:action(n, item)
	msg	=	"You pressed item n." .. tostring(n) .. " with \"" .. item .. "\" as value"
end

--Create a sample widget
box1	=	box()

--Create a input that only accepts numbers
inp1	=	sInput()
inp1.number	=	true
inp1.value	=	"42"

--Create two other inputs that accept anything
inp2	=	sInput()
inp2.value	=	"Hello"

inp3	=	sInput()


--Append all the widgets to the main screen
main:appendWidget(llist, 40, 40)
main:appendWidget(box1, 80, 150)
main:appendWidget(inp1, 200, 40)
main:appendWidget(inp2, 200, 70)
main:appendWidget(inp3, 200, 100)

--Push the main screen into the Screens table so that it will be displayed
push_screen(main)
