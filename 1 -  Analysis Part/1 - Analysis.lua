Analysis	= Dialog("Note",50, 50, 200, 120)

txt	= sLabel ("Analysis is not yet done!")
but	= sButton("Okay..")
Analysis:appendWidget(txt,10,30)
Analysis:appendWidget(but,-10,-5)

function Analysis:postPaint(gc)
	nativeBar(gc, self, self.h-40)
end

but:giveFocus()

function but:action()
	only_screen(main)
end
