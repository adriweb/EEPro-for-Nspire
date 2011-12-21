FormulaPro	=	Screen()
FormulaPro.known	=	{}

function FormulaPro:paint(gc)
	for i=1,100 do
		gc:setColorRGB(255,255,255-i)
		gc:fillRect(0,(i-1)*2.12,318,3)
	end
end


boxx	=	box("40","18","Add var")
FormulaPro:appendWidget(boxx, "5", "5")

userAv	=	sList()
FormulaPro:appendWidget(userAv, "5", "25")

userAv.hh	=	"70"
userAv.ww	=	"40"

function boxx:enterKey()
	push_screen(addV)
end	

function boxx:mouseDown()
	push_screen(addV)
end	

userAv.items	=	{}


knownV	=	sList()
FormulaPro:appendWidget(knownV, "55", "5")

knownV.hh	=	"90"
knownV.ww	=	"40"

----

addV	=	Screen("10","30","80","40")

function addV:paint(gc)
	gc:setColorRGB(240,240,240)
	gc:fillRect(self.x, self.y, self.w, self.h)
	gc:setColorRGB(0,0,0)
	gc:drawRect(self.x, self.y, self.w, self.h)
end

addD	=	sInput()
addV:appendWidget(addD, "10", "10")
addD.ww	=	"80"
addD.number	=	true
addD.value	=	"0"

addU	=	sList()
addV:appendWidget(addU, "10", "40")
addU.hh	=	2*18+1
addU.ww	=	"80"

for unit, val in pairs(units) do
	table.insert(addU.items, val[3][1][3] .. " (" .. val[3][1][2] .. ")")
end

function addU:enterKey()
	remove_screen()
	FormulaPro.known[units[self.sel][1]]	=	tonumber(addD.value)
	userAv.items	=	{}
	for i,v in pairs(FormulaPro.known) do
		table.insert(userAv.items, i .. ": " .. v)
	end
	local res=find_data(FormulaPro.known)
	knownV.items	=	{}
	for i,v in pairs(res) do
		
		table.insert(knownV.items, i .. ": " .. v)
	end	
end
