------------------------------------------------------------------
--                        Screen  Class                         --
------------------------------------------------------------------
function Pr(n, d, s)
	local t	=	type(n)
	if t == "number" then
		return n
	elseif t == "string" then
		return s*n/100
	else
		return d
	end
end


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

function Screen:init(yy,xx,hh,ww)
	self.yy	=	yy
	self.xx	=	xx
	self.hh	=	hh
	self.ww	=	ww
	
	self:size()
	
	self.widgets	=	{}
	self.focus	=	0
end

function Screen:size()
	local screenH	=	platform.window:height()
	local screenW	=	platform.window:width()

	self.x	=	Pr(self.xx, 0, screenW)
	self.y	=	Pr(self.yy, 0, screenH)
	self.w	=	Pr(self.ww, screenW, screenW)
	self.h	=	Pr(self.hh, screenH, screenH)
end

function Screen:drawWidgets(gc) 
	for _, widget in pairs(self.widgets) do
		widget:size()
		widget:prePaint()
		widget:paint(gc)
		
		gc:setColorRGB(0,0,0)
	end
end

function Screen:appendWidget(widget, xx, yy) 
	widget.xx	=	xx
	widget.yy	=	yy
	widget.parent	=	self
	widget:size()
	
	table.insert(self.widgets, widget)
end

function Screen:getWidget()
	return self.widgets[self.focus]
end

function Screen:draw(gc)
	self:size()
	self:paint(gc)
	self:drawWidgets(gc)
end

function Screen:switchFocus(n)
	if n~=0 or #self.widgets>0 then
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

function Screen:paint(gc)
	
end

function Screen:invalidate()
	platform.window:invalidate(self.x ,self.y , self.w, self.h)
end

function Screen:timer()		end

function Screen:arrowKey(arrow)	
	if self.focus~=0 then
		self:getWidget():arrowKey(arrow)
	end
	self:invalidate()
end

function Screen:enterKey()	
	if self.focus~=0 then
		self:getWidget():enterKey()
	end
	self:invalidate()
end

function Screen:backspaceKey()
	if self.focus~=0 then
		self:getWidget():backspaceKey()
	end
	self:invalidate()
end

function Screen:escapeKey()	
	if self.focus~=0 then
		self:getWidget():escapeKey()
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
		self:getWidget():charIn(char)
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
		if self.focus~=0 then self:getWidget().hasFocus = false self:getWidget():loseFocus()  end
		self.focus	=	n
		
		widget.hasFocus	=	true
		widget:getFocus()

		widget:mouseDown(x-self.x, y-self.y)
	else
		if self.focus~=0 then self:getWidget().hasFocus = false self:getWidget():loseFocus()  end
		self.focus	=	0
	end
end
function Screen:mouseUp(x, y)
	if self.focus~=0 then
		self:getWidget():mouseUp(x-self.x, y-self.y)
	end
	self:invalidate()
end
function Screen:mouseMove(x, y)
	if self.focus~=0 then
		self:getWidget():mouseMove(x-self.x, y-self.y)
	end
end


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
