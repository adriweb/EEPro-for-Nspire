FormulaPro	=	Screen()

function FormulaPro:paint(gc)
	for i=1,100 do
		gc:setColorRGB(255,255,255-i)
		gc:fillRect(0,(i-1)*2.12,318,3)
	end
end

boxx	=	box("40","18")
FormulaPro:appendWidget(boxx, "5", "5")

userAv	=	sList()
FormulaPro:appendWidget(userAv, "5", "25")

userAv.hh	=	"70"
userAv.ww	=	"40"

userAv.items	=	{"+ Add variable +"}


knownV	=	sList()
FormulaPro:appendWidget(knownV, "55", "5")

knownV.hh	=	"90"
knownV.ww	=	"40"


