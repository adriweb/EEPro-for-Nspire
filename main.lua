--This document should contain the glue for all the plugins



main	=	Screen()
main.items	=    {
{title="Analysis"  , info="Line1\nLine2\nLine3"},
{title="FormulaPro", info="Line1\nLine2\nLine3"},
{title="Reference" , info="Line1\nLine2\nLine3"}
}

function main:paint(gc)
	gc:setFont("sansserif", "b", 12)
	gc:drawString("EEPro for the Nspire", 5, 2, "top")
	gc:drawString("v0.0.2", 170, 2, "top")

	gc:setFont("sansserif", "r", 10)
	
	local number_items	= #self.items
	local item_H	= 48
	local item_W	= 270
	local item_S	= 5
	local startY	= (self.h - (item_H + item_S) * number_items)/2 + 3
	local startX	= (self.w - item_W)/2
	
	for n, item in ipairs(self.items) do
		local y	= startY + (item_H + item_S) * (n - 1)
		gc:setColorRGB(220, 220, 220)
		gc:drawRect(startX, y, item_W, item_H)
		
		gc:setColorRGB(0, 0, 0)
		gc:setFont("sansserif", "r", 10)
		gc:drawString(self.items[n].title, startX+item_H+2, y, "top")
		
		gc:setFont("sansserif", "r", 8)

		local splinfo	= self.items[n].info:split("\n")
		
		for i, str in ipairs(splinfo) do
			gc:drawString(str, startX+item_H+2, y + 15 + i*10-10, "top")
		end

	end
	
	nativeBar(gc, self, 25)
	nativeBar(gc, self, self.h-26)
end


push_screen(main)
