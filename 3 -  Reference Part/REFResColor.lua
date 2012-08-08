
ResColor = Screen()

ResColor.colors = {
["silver"] = {217,217,217},
["gold"] = {255,211,76},
["black"] = {0,0,0},
["brown"] = {153,115,0},
["red"] = {255,0,0},
["orange"] = {255,102,0},
["yellow"] = {255,255,0},
["green"] = {0,204,0},
["blue"] = {3,69,218},
["pink"] = {204,0,204},
["grey"] = {140,140,140},
["white"] = {255,255,255}
}

resistor = class()

function resistor:init(value,colors,selection)
	self.value = value
	self.colors = colors
	self.selection = selection
end

-- Resistor = resistor({238,1,3},{5,6,11,3,2},1)
Resistor = resistor({23,1,3},{5,6,3,2},1)

ResColor.tolerance = {
["0.1"] = 10,
["0.25"] = 9,
["0.5"] = 8,
["2"] = 5,
["1"] = 4,
["5"] = 2,
["10"] = 1
}
ResColor.tolerancenr = {0.1,0.25,0.5,1,2,5,10}

ResColor.colortable = {"silver","gold","black","brown","red","orange","yellow","green","blue","pink","grey","white"}

function ResColor:paint(gc)
	gc:setColorRGB(255,255,255)
	gc:fillRect(self.x, self.y, self.w, self.h)
	gc:setColorRGB(0,0,0)
	
	Resistor:paint(gc)
end

function Resistor:paint(gc)
	local w,h = pww(),pwh()
	
	--------------
	-- resistor --
	--------------
	gc:setColorRGB(170,170,170)
	gc:fillRect((w-(w/4+w/3))/2,(h/2-h/5)/2+((h/2-h/5)/2+h/40)/2,w/4+w/3,h/40)
	
	gc:setColorRGB(230,206,170)
	gc:fillRect((w-w/2)/2-1,(h/2-h/5)/2-1,w/2+2,h/5+2)
	
	------------
	-- colors --
	------------
	for i=1,#self.colors do
		gc:setColorRGB(unpack(ResColor.colors[ResColor.colortable[self.colors[i]]]))
		gc:fillRect((w-w/2)/2+w/2/(#self.colors)*(i-0.85),(h/2-h/5)/2,w/2/(#self.colors+2),h/5)
	end
	
	-----------
	-- value --
	-----------
	gc:setColorRGB(0,0,0)
	gc:setFont("sansserif","b","11")
	local printstring = "Resistance: "..self.value[1]*self.value[2].." Ohm "..string.uchar(177).." "..ResColor.tolerancenr[self.value[3]].."%"
	gc:drawString(printstring,(w-gc:getStringWidth(printstring))/2,h/2,"top")
	
	---------------
	-- selection --
	---------------
	gc:setColorRGB(230,206,170)
	gc:setPen("medium","smooth")
	gc:drawRect((w-w/2)/2+w/2/(#self.colors)*(self.selection-0.85)+1,(h/2-h/5)/2+1,w/2/(#self.colors+2)-3,h/5-3)
end

function ResColor:arrowKey(arrow)
	Resistor:arrowKey(arrow)
end

function ResColor:charIn(char)
	Resistor:charIn(char)
end

function Resistor:arrowKey(arrow)
	---------------------
	-- color selection --
	---------------------
	if arrow=='right' and self.selection<#self.colors then
		self.selection = self.selection + 1
	elseif arrow=='left' and self.selection>1 then
		self.selection = self.selection - 1
	-----------
	-- value --
	-----------
	elseif arrow=='up' and self.selection<=#self.colors-2 and self.colors[self.selection]<12 then
		self.value[1] = self.value[1]+10^(#self.colors-2-self.selection)
		self.colors[self.selection] = self.colors[self.selection] + 1
	elseif arrow=='down' and self.selection<=#self.colors-2  and self.colors[self.selection]>3 then
		self.value[1] = self.value[1]-10^(#self.colors-2-self.selection)
		self.colors[self.selection] = self.colors[self.selection] - 1
	----------------
	-- multiplier --
	----------------
	elseif arrow=='up' and self.selection==#self.colors-1 and self.value[2] < 10000000 then
		self.value[2] = self.value[2]*10
		self.colors[self.selection] = self.colors[self.selection] + 1
	elseif arrow=='down' and self.selection==#self.colors-1 and self.value[2] > 0.01 then
		self.value[2] = self.value[2]/10
		self.colors[self.selection] = self.colors[self.selection] - 1
	---------------
	-- tolerance --
	---------------
	elseif arrow=='up' and self.selection==#self.colors and self.value[3]<7 then
		self.value[3] = self.value[3] + 1
		self.colors[self.selection] = ResColor.tolerance[tostring(ResColor.tolerancenr[self.value[3]])]
	elseif arrow=='down' and self.selection==#self.colors  and self.value[3]>1 then
		self.value[3] = self.value[3] - 1
		self.colors[self.selection] = ResColor.tolerance[tostring(ResColor.tolerancenr[self.value[3]])]
	end
	platform.window:invalidate()
end

function Resistor:charIn(char)
	if char=='+' and #self.colors==4 then
		table.insert(self.colors,3,3)
		self.value[1] = self.value[1]*10
	elseif char=='-' and #self.colors==5 then
		local deletenr = (self.colors[3]-3)*self.value[2]
		self.value[1] = self.value[1]-deletenr
		table.remove(self.colors,3)
		self.value[1] = self.value[1]/10
	end
	platform.window:invalidate()
end

function ResColor:escapeKey()
	only_screen_back(Ref)
end
