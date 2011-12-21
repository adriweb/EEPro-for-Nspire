--This document should contain the glue for all the plugins

main	=	Screen()

function notDone()
		print("Not Done Yet")
end
 
function showGreek()
		remove_screen()
		push_screen(Greek)
end

function showPro()
		remove_screen()
		push_screen(Greek)
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
	   {"GreekAlphabet", showGreek}
	}
 
}
 
toolpalette.register(menu)

--Push the main screen into the Screens table so that it will be displayed
push_screen(main)
