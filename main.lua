--------------------------
---- FormulaPro v1.1b ----
----- LGLP 3 License -----
--------------------------

only_screen(CategorySel)

----------------------------------------

aboutWindow	= Dialog("About FormulaPro :", 50, 20, 280, 180)

local aboutstr	= [[FormulaPro v1.1b  -  Standalone version
-----------------------------
Authors : Jim Bauwens, Adrien Bertrand
(Adriweb). Credits also to Levak.
LGPL3 License.
More info and contact : 
http://tiplanet.org  and  www.inspired-lua.org]]

local aboutButton	= sButton("OK")

for i, line in ipairs(aboutstr:split("\n")) do
	local aboutlabel	= sLabel(line)
	aboutWindow:appendWidget(aboutlabel, 10, 27 + i*14-12)
end


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


-- Still has to be worked on with Luna :

function on.create()
	platform.os = "3.1"
end

function on.construction()
	platform.os = "3.2"
end
