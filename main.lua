--This document should contain the glue for all the plugins

main	=	Screen()

function main:paint(gc)
	gc:drawString("Press menu...",10,10,"top")
end

function notDone()
		print("Not Done Yet")
end
 
function showGreek()
		remove_screen()
		push_screen(Greek)
end

function showPro()
		remove_screen()
		push_screen(FormulaPro)
end

function showSIPref()
		remove_screen()
		push_screen(SIPrefixes)
end

function showPhysConst()
		remove_screen()
		push_screen(RefConstants)
end
 
 function showResColor()
		remove_screen()
		push_screen(ResColor)
end
 
menu = {
 
	{"Analysis",
	   {"Not done Yet", notDone},
	   "-",
	   {"Not done Yet", notDone}
	},
	{"FormulaPro",
	   {"Formula Pro", showPro}
	},
	{"Reference",
	   {"Resistor Color Code", showResColor},
	   {"Greek Alphabet", showGreek},
	   {"Physical Constants", showPhysConst},
	   {"SI Prefixes", showSIPref}
	}
 
}
 
toolpalette.register(menu)

--Push the main screen into the Screens table so that it will be displayed
push_screen(main)
