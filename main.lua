--This document should contain the glue for all the plugins


------------------------------------------------------------------
--                        Example usage                         --
------------------------------------------------------------------



--Create main screen
main	=	Screen(0,0)

--Main's paint event, draws msg to the screen
function main:paint(gc)
	if msg then
		gc:drawString(msg, 0, 0, "top")
	end
end

--Create a List widget
llist	=	sList()
llist.items = {"Adriweb","and","Levak","...","Lost","The","Game"}

--Add an action to the list
function llist:action(n, item)
	msg	=	"You pressed item n." .. tostring(n) .. " with \"" .. item .. "\" as value"
end

--Create a sample widget
box1	=	box()

--Create a input that only accepts numbers
inp1	=	sInput()
inp1.number	=	true
inp1.value	=	"42"

--Create two other inputs that accept anything
inp2	=	sInput()
inp2.value	=	"Hello"

inp3	=	sInput()


--Append all the widgets to the main screen
main:appendWidget(llist, 40, 40)
main:appendWidget(box1, 80, 150)
main:appendWidget(inp1, 200, 40)
main:appendWidget(inp2, 200, 70)
main:appendWidget(inp3, 200, 100)

--Push the main screen into the Screens table so that it will be displayed
push_screen(main)
