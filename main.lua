only_screen(CategorySel)

----------------------------------------

aboutWindow	= Dialog("About FormulaPro :", 50, 20, 280, 180)

local aboutText	= sLabel([[FormulaPro v1.0  -  Standalone version
-----------------------------
Authors : Jim Bauwens, Adrien Bertrand
(Adriweb). Credits also to Levak.
LGPL License. More info and contact : 
http://tiplanet.org  and  www.inspired-lua.org]])

local aboutButton	= sButton("OK")
aboutWindow:appendWidget(aboutText,10,27)
aboutWindow:appendWidget(aboutButton,-10,-5)

function aboutWindow:postPaint(gc)
	nativeBar(gc, self, self.h-40)
	on.help = function() return 0 end
end

aboutButton:giveFocus()

function aboutButton:action()
	remove_screen(aboutWindow)
	on.help = function() push_screen(aboutWindow) end
end

----------------------------------------

function on.help()
	push_screen(aboutWindow)
end