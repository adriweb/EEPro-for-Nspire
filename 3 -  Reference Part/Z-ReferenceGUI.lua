
References	= {
	{title="Resistor color chart"     , info="", screen=ResColor    },
	{title="Standard Component Values", info="", screen=nil         },
	{title="Semiconductor Data",        info="", screen=nil         },
	{title="Boolean Expressions",       info="", screen=RefBoolExpr },
	{title="Boolean Algebra",           info="", screen=RefBoolAlg  },
	{title="Transforms",                info="", screen=nil         },
	{title="Constants",                 info="", screen=RefConstants},
	{title="SI Prefixes",               info="", screen=SIPrefixes  },
	{title="Greek Alphabet",            info="", screen=Greek       },
}

Ref	= WScreen()

RefList	= sList()
RefList:setSize(-4, -4)

Ref:appendWidget(RefList, 2, 2)

function Ref.addRefs()
	for n, ref in ipairs(References) do
		if ref.screen then
			table.insert(RefList.items, ref.title)
		else
			table.insert(RefList.items, ref.title .. " (not yet done)")
		end
	end
end

function RefList:action(ref)
	if References[ref].screen then
		push_screen(References[ref].screen)
	end
end

function Ref:pushed()
	RefList:giveFocus()
end

function Ref:tabKey()
    push_screen(CategorySel)
end

function Ref:escapeKey()
    push_screen(CategorySel)
end


Ref.addRefs()

