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
