FormulaPro	=	Screen()
FormulaPro.known	=	{}

function FormulaPro:paint(gc)
	for i=1,100 do
		gc:setColorRGB(255,255,255-i)
		gc:fillRect(0,(i-1)*2.12,318,3)
	end
end


add_unit_button	=	sButton("Add unit...", function () push_screen(add_unit) end)
FormulaPro:appendWidget(add_unit_button, "5", "5")
add_unit_button:focus()

user_added	=	sList()
FormulaPro:appendWidget(user_added, "5", "25")

user_added.hh	=	"70"
user_added.ww	=	"40"

user_added.items	=	{}


computer_computed	=	sList()
FormulaPro:appendWidget(computer_computed, "55", "5")

computer_computed.hh	=	"90"
computer_computed.ww	=	"40"

----

function compute()
	remove_screen()
	FormulaPro.known[units[units_list.sel][1]]	=	tonumber(unit_value.value)
	user_added.items	=	{}
	for i,v in pairs(FormulaPro.known) do
		table.insert(user_added.items, i .. ": " .. v)
	end
	local res=find_data(FormulaPro.known)
	computer_computed.items	=	{}
	for i,v in pairs(res) do
		
		table.insert(computer_computed.items, i .. ": " .. v)
	end	
end


add_unit	=	Dialog("Add unit","10","10","80","85")

unit_value	=	sInput()
unit_value.ww	=	"77"
unit_value.number	=	true

units_list	=	sList()
units_list.hh	=	"50"
units_list.ww	=	"77"

lbl1	=	sLabel("Value:", addD)
lbl2	=	sLabel("Unit:", addU)

button_ok	=	sButton("OK", compute)
button_esc	=	sButton("Cancel", remove_screen)

add_unit:appendWidget(lbl1, "2", "18")
add_unit:appendWidget(lbl2, "2", "38")
add_unit:appendWidget(unit_value, "20", "18")
add_unit:appendWidget(units_list, "20", "38")
add_unit:appendWidget(button_ok, "60", "82")
add_unit:appendWidget(button_esc, "75", "82")

function Dialog:pushed()
	unit_value:focus()
end

function Dialog:escapeKey()
	remove_screen()
end


--add items to list
for unit, val in pairs(units) do
	table.insert(units_list.items, val[3][1][3] .. " (" .. val[3][1][2] .. ")")
end
