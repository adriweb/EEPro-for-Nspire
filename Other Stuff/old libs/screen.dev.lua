function Pr(n, d, s, ex)
	local nc	= tonumber(n)
	if nc and nc<math.abs(nc) then
		return s-ex-(type(n)== "number" and math.abs(n) or (.01*s*math.abs(nc))
	else
		return (type(n)=="number" and n or (type(n)=="string" and .01*s*nc or d))
	end
end

-- Apply an extension on a class, and return our new frankenstein 
function addExtension(oldclass, extension)
	local newclass	= class(oldclass)
	for key, data in pairs(extension) do
		newclass[key]	= data
	end
	return newclass
end

------------------------------------------------------------------
--                        Screen  Class                         --
------------------------------------------------------------------

Screen	=	class()

Screens	=	{}

function push_screen(screen)
	table.insert(Screens, screen)
	platform.window:invalidate()
	current_screen():pushed()
end

function remove_screen(screen)
	platform.window:invalidate()
	return table.remove(Screens)
end

function current_screen()
	return Screens[#Screens]
end

function Screen:init(xx,yy,ww,hh)
	self.yy	=	yy
	self.xx	=	xx
	self.hh	=	hh
	self.ww	=	ww
	
	self:size()
	self:ext()
end

function Screen:ext() end

function Screen:size()
	local screenH	=	platform.window:height()
	local screenW	=	platform.window:width()

	self.x	=	math.floor(Pr(self.xx, 0, screenW)+.5)
	self.y	=	math.floor(Pr(self.yy, 0, screenH)+.5)
	self.w	=	math.floor(Pr(self.ww, screenW, screenW)+.5)
	self.h	=	math.floor(Pr(self.hh, screenH, screenH)+.5)
end


function Screen:pushed() end


function Screen:draw(gc)
	self:size()
	self:paint(gc)
end

function Screen:paint(gc) end

function Screen:invalidate()
	platform.window:invalidate(self.x ,self.y , self.w, self.h)
end

function Screen:arrowKey()	end
function Screen:enterKey()	end
function Screen:backspaceKey()	end
function Screen:escapeKey()	end
function Screen:tabKey()	end
function Screen:backtabKey()	end
function Screen:charIn(char)	end


function Screen:mouseDown()	end
function Screen:mouseUp()	end
function Screen:mouseMove()	end

function Screen:appended() end

------------------------------------------------------------------
--                   WidgetManager Extension                    --
------------------------------------------------------------------

WidgetManager	= {}

function WidgetManager:ext()
	self.widgets	=	{}
	self.focus	=	0
end

function WidgetManager:appendWidget(widget, xx, yy) 
	widget.xx	=	xx
	widget.yy	=	yy
	widget.parent	=	self
	widget:size()
	
	table.insert(self.widgets, widget)
	widget.pid	=	#self.widgets
	
	widget:appended(self)
end

function WidgetManager:getWidget()
	return self.widgets[self.focus]
end

function WidgetManager:drawWidgets(gc) 
	for _, widget in pairs(self.widgets) do
		widget:size()
		widget:draw(gc)
		
		gc:setColorRGB(0,0,0)
	end
end


function WidgetManager:draw(gc)
	self:size()
	self:paint(gc)
	self:drawWidgets(gc)
end

function WidgetManager:switchFocus(n)
	if n~=0 and #self.widgets>0 then
		if self.focus~=0 then
			self:getWidget().hasFocus	=	false
			self:getWidget():loseFocus()
		end
		
		self.focus	=	self.focus + n
		if self.focus>#self.widgets then
			self.focus	=	1
		elseif self.focus<1 then
			self.focus	=	#self.widgets
		end	
		self:getWidget().hasFocus	=	true	
		self:getWidget():getFocus()
	end
end


function WidgetManager:arrowKey(arrow)	
	if self.focus~=0 then
		self:getWidget():arrowKey(arrow)
	end
	self:invalidate()
end

function WidgetManager:enterKey()	
	if self.focus~=0 then
		self:getWidget():enterKey()
	end
	self:invalidate()
end

function WidgetManager:backspaceKey()
	if self.focus~=0 then
		self:getWidget():backspaceKey()
	end
	self:invalidate()
end

function WidgetManager:escapeKey()	
	if self.focus~=0 then
		self:getWidget():escapeKey()
	end
	self:invalidate()
end

function WidgetManager:tabKey()	
	self:switchFocus(1)
	self:invalidate()
end

function WidgetManager:backtabKey()	
	self:switchFocus(-1)
	self:invalidate()
end

function WidgetManager:charIn(char)
	if self.focus~=0 then
		self:getWidget():charIn(char)
	end
	self:invalidate()
end

function WidgetManager:getWidgetIn(x, y)
	for n, widget in pairs(self.widgets) do
		if x>=widget.x and y>=widget.y and x<widget.x+widget.w and y<widget.y+widget.h then
			return n, widget
		end
	end 
end

function WidgetManager:mouseDown(x, y) 
	local n, widget	=	self:getWidgetIn(x, y)
	if n then
		if self.focus~=0 then self:getWidget().hasFocus = false self:getWidget():loseFocus()  end
		self.focus	=	n
		
		widget.hasFocus	=	true
		widget:getFocus()

		widget:mouseDown(x, y)
	else
		if self.focus~=0 then self:getWidget().hasFocus = false self:getWidget():loseFocus()  end
		self.focus	=	0
	end
end
function WidgetManager:mouseUp(x, y)
	if self.focus~=0 then
		self:getWidget():mouseUp(x, y)
	end
	self:invalidate()
end
function WidgetManager:mouseMove(x, y)
	if self.focus~=0 then
		self:getWidget():mouseMove(x, y)
	end
end

--------------------------
-- Our new frankenstein --
--------------------------

WScreen	= addExtension(Screen, WidgetManager)



--Dialog screen

Dialog	=	class(Screen)

function Dialog:init(title,xx,yy,ww,hh)
	self.yy	=	yy
	self.xx	=	xx
	self.hh	=	hh
	self.ww	=	ww
	self.title	=	title
	self:size()
	
	self.widgets	=	{}
	self.focus	=	0
end

function Dialog:paint(gc)
	gc:setFont("sansserif","r",10)
	gc:setColorRGB(224,224,224)
	gc:fillRect(self.x, self.y, self.w, self.h)

	for i=1, 14,2 do
		gc:setColorRGB(32+i*3, 32+i*4, 32+i*3)
		gc:fillRect(self.x, self.y+i, self.w,2)
	end
	gc:setColorRGB(32+16*3, 32+16*4, 32+16*3)
	gc:fillRect(self.x, self.y+15, self.w, 10)
	
	gc:setColorRGB(128,128,128)
	gc:drawRect(self.x, self.y, self.w, self.h)
	gc:drawRect(self.x-1, self.y-1, self.w+2, self.h+2)
	
	gc:setColorRGB(96,100,96)
	gc:fillRect(self.x+self.w+1, self.y, 1, self.h+2)
	gc:fillRect(self.x, self.y+self.h+2, self.w+3, 1)
	
	gc:setColorRGB(104,108,104)
	gc:fillRect(self.x+self.w+2, self.y+1, 1, self.h+2)
	gc:fillRect(self.x+1, self.y+self.h+3, self.w+3, 1)
	gc:fillRect(self.x+self.w+3, self.y+2, 1, self.h+2)
	gc:fillRect(self.x+2, self.y+self.h+4, self.w+2, 1)
			
	gc:setColorRGB(255,255,255)
	gc:drawString(self.title, self.x + 4, self.y+2, "top")
end

------------------------------------------------------------------
--                   Bindings to the on events                  --
------------------------------------------------------------------


function on.paint(gc)	
	for _, screen in pairs(Screens) do
		screen:draw(gc)	
	end	
end

function on.resize(x, y)
	-- Global Ratio Constants for On-Calc (shouldn't be used often though...)
	kXRatio = x/320
	kYRatio = y/212
end

function on.timer()			current_screen():timer()		 end
function on.arrowKey(arrw)	current_screen():arrowKey(arrw)  end
function on.enterKey()		current_screen():enterKey()		 end
function on.escapeKey()		current_screen():escapeKey()	 end
function on.tabKey()		current_screen():tabKey()		 end
function on.backtabKey()	current_screen():backtabKey()	 end
function on.charIn(ch)		current_screen():charIn(ch)		 end
function on.backspaceKey()	current_screen():backspaceKey()  end
function on.mouseDown(x,y)	current_screen():mouseDown(x,y)	 end
function on.mouseUp(x,y)	current_screen():mouseUp(x,y)	 end
function on.mouseMove(x,y)	current_screen():mouseMove(x,y)  end

