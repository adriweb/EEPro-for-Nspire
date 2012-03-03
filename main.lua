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

function showFormulaPro()
		remove_screen()
		only_screen(CategorySel)
end

function showSIPref()
		remove_screen()
		push_screen(SIPrefixes)
end

function showBoolExpr()
		remove_screen()
		push_screen(RefBoolExpr)
end

function showBoolAlg()
		remove_screen()
		push_screen(RefBoolAlg)
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
	   {"Formula Pro", showFormulaPro}
	},
	{"Reference",
	   {"Resistor Color Code", showResColor},
	   {"Boolean Expressions", showBoolExpr},
	   {"Boolean Algebra", showBoolAlg},
	   {"Greek Alphabet", showGreek},
	   {"Physical Constants", showPhysConst},
	   {"SI Prefixes", showSIPref}
	}
}
 
toolpalette.register(menu)

--Push the main screen into the Screens table so that it will be displayed
push_screen(main)
