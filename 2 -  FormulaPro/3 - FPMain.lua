--------------------------
---- FormulaPro v1.1b ----
----- LGLP 3 License -----
--------------------------

--[[

function on.create()
	known={U=5, I=2} -- START VALUE'S
	find_data(known)
end

function on.paint(gc)
	gc:setColorRGB(0,0,0)
	for i,v in pairs(pr) do
		gc:drawString(v, 2,14*i-14,"top")
	end
end

--]]
