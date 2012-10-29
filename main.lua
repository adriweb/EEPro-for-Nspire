

aboutWindow	= Dialog("About FormulaPro :", 50, 20, 280, 180)

local aboutstr	= [[FormulaPro v1.4a
--------------------
Jim Bauwens, Adrien "Adriweb" Bertrand
Thanks also to Levak.
LGPL3 License.
More info and contact : 
tiplanet.org  -  inspired-lua.org]]

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
	on.help = function() push_screen_direct(aboutWindow) end
end

----------------------------------------

function on.help()
	push_screen_direct(aboutWindow)
end

----------------------------------------


function errorPopup(gc)
    
    errorHandler.display = false

    errorDialog = Dialog("Oops...", 50, 20, "85", "80")

    local textMessage	= [[FormulaPro has encountered an error
-----------------------------
Sorry for the inconvenience.
Please report this bug to info@tiplanet.org
How/where/when it happened etc.
 (bug at line ]] .. errorHandler.errorLine .. ")"
    
    local errorOKButton	= sButton("OK")
    
    for i, line in ipairs(textMessage:split("\n")) do
        local errorLabel = sLabel(line)
        errorDialog:appendWidget(errorLabel, 10, 27 + i*14-12)
    end
    
    errorDialog:appendWidget(errorOKButton,-10,-5)
    
    function errorDialog:postPaint(gc)
        nativeBar(gc, self, self.h-40)
    end
    
    errorOKButton:giveFocus()
    
    function errorOKButton:action()
        remove_screen(errorDialog)
        errorHandler.errorMessage = nil
    end
    
    push_screen_direct(errorDialog)
end

---------------------------------------------------------------

function on.create()
	platform.os = "3.1"
end

function on.construction()
	platform.os = "3.2"
end

errorHandler = {}

function handleError(line, errMsg, callStack, locals)
    print("Error handled !", errMsg)
    errorHandler.display = true
    errorHandler.errorMessage = errMsg
    errorHandler.errorLine = line
    errorHandler.callStack = callStack
    errorHandler.locals = locals
    platform.window:invalidate()
    return true -- go on....
end

if platform.registerErrorHandler then
    platform.registerErrorHandler( handleError )
end



----------------------------------------------  Launch !

push_screen_direct(CategorySel)

