--This document should contain the glue for all the plugins


------------------------------------------------------------------
--                        Example usage                         --
------------------------------------------------------------------



--Create main screen
main	=	Screen(0,0)

function main:paint(gc)
	gc:setColorRGB(230,230,255)
	gc:fillRect(self.x, self.y, self.w, self.h)
end

inp1	=	sInput()
inp2	=	sInput()
inp3	=	sInput()
inp4	=	sInput()

main:appendWidget(inp1, 10, "10")
main:appendWidget(inp2, 10, "30")
main:appendWidget(inp3, 10, "50")
main:appendWidget(inp4, 10, "70")

--Push the main screen into the Screens table so that it will be displayed
push_screen(main)
