
CategorySel = WScreen()
CategorySel.iconS = 48

CategorySel.sublist = sList()
CategorySel:appendWidget(CategorySel.sublist, 5, 5 + 24)
CategorySel.sublist:setSize(-10, -70)
CategorySel.sublist.cid = 0

function CategorySel.sublist:action(sid)
    push_screen(SubCatSel, sid)
end

function CategorySel:charIn(ch)
    if ch == "l" then
        loadExtDB()
        self:pushed() -- refresh list
        self:invalidate() -- asks for screen repaint
    end
end

function CategorySel:paint(gc)
    gc:setColorRGB(255, 255, 255)
    gc:fillRect(self.x, self.y, self.w, self.h)

    if not kIsInSubCatScreen then
        gc:setColorRGB(0, 0, 0)
        gc:setFont("sansserif", "r", 16)
        gc:drawString("FormulaPro", self.x + 5, 0, "top")

        gc:setFont("sansserif", "r", 12)
        gc:drawString("v1.4a", self.x + .4 * self.w, 4, "top")

        gc:setFont("sansserif", "r", 12)
        gc:drawString("by TI-Planet", self.x + self.w - gc:getStringWidth("by TI-Planet") - 5, 4, "top")

        gc:setColorRGB(220, 220, 220)
        gc:setFont("sansserif", "r", 8)
        gc:drawRect(5, self.h - 46 + 10, self.w - 10, 25 + 6)
        gc:setColorRGB(128, 128, 128)
    end

    local splinfo = Categories[self.sublist.sel].info:split("\n")
    for i, str in ipairs(splinfo) do
        gc:drawString(str, self.x + 7, self.h - 56 + 12 + i * 10, "top")
    end
    self.sublist:giveFocus()
end

function CategorySel:pushed()
    local items = {}
    for cid, cat in ipairs(Categories) do
        table.insert(items, cat.name)
    end

    self.sublist.items = items
    self.sublist:giveFocus()
end

function CategorySel:tabKey()
    push_screen_back(Ref)
end



SubCatSel = WScreen()
SubCatSel.sel = 1

SubCatSel.sublist = sList()
SubCatSel:appendWidget(SubCatSel.sublist, 5, 5 + 24)
SubCatSel.back = sButton(utf8(9664) .. " Back")
SubCatSel:appendWidget(SubCatSel.back, 5, -5)
SubCatSel.sublist:setSize(-10, -66)
SubCatSel.sublist.cid = 0

function SubCatSel.back:action()
    SubCatSel:escapeKey()
end

function SubCatSel.sublist:action(sub)
    local cid = self.parent.cid
    if #Categories[cid].sub[sub].formulas > 0 then
        push_screen(manualSolver, cid, sub)
    end
end

function SubCatSel:paint(gc)
    gc:setColorRGB(255, 255, 255)
    gc:fillRect(self.x, self.y, self.w, self.h)
    gc:setColorRGB(0, 0, 0)
    gc:setFont("sansserif", "r", 16)
    gc:drawString(Categories[self.cid].name, self.x + 5, 0, "top")
end

function SubCatSel:pushed(sel)

    kIsInSubCatScreen = true
    self.cid = sel
    local items = {}
    for sid, subcat in ipairs(Categories[sel].sub) do
        table.insert(items, subcat.name .. (#subcat.formulas == 0 and " (Empty)" or ""))
    end

    if self.sublist.cid ~= sel then
        self.sublist.cid = sel
        self.sublist:reset()
    end

    self.sublist.items = items
    self.sublist:giveFocus()
end

function SubCatSel:escapeKey()
    kIsInSubCatScreen = false
    only_screen_back(CategorySel)
end



-------------------
-- Manual solver --
-------------------

manualSolver = WScreen()
manualSolver.pl = sScreen(-20, -50)
manualSolver:appendWidget(manualSolver.pl, 2, 4)

manualSolver.sb = scrollBar(-50)
manualSolver:appendWidget(manualSolver.sb, -2, 3)

manualSolver.back = sButton(utf8(9664) .. " Back")
manualSolver:appendWidget(manualSolver.back, 5, -5)

manualSolver.usedFormulas = sButton("Formulas")
manualSolver:appendWidget(manualSolver.usedFormulas, -5, -5)

function manualSolver.back:action()
    manualSolver:escapeKey()
end

function manualSolver.usedFormulas:action()
    push_screen_direct(usedFormulas)
end

function manualSolver.sb:action(top)
    self.parent.pl:setY(4 - top * 30)
end

function manualSolver:paint(gc)
    gc:setColorRGB(224, 224, 224)
    gc:fillRect(self.x, self.y, self.w, self.h)
    gc:setColorRGB(128, 128, 128)
    gc:fillRect(self.x + 5, self.y + self.h - 42, self.w - 10, 2)
    self.sb:update(math.floor(-(self.pl.oy - 4) / 30 + .5))

    gc:setFont("sansserif", "r", 10)
    local name = self.sub.name
    local len = gc:getStringWidth(name)
    local x = self.x + (self.w - len) / 2

    --gc:setColorRGB(255,255,255)
    --gc:fillRect(x-3, 10, len+6, 18)

    gc:setColorRGB(0, 0, 0)
    gc:drawString(name, x, self.h - 28, "top")
    --gc:drawRect(x-3, 10, len+6, 18)
end

function manualSolver:postPaint(gc)
    --gc:setColorRGB(128,128,128)
    --gc:drawRect(self.x, self.y, self.w, self.h-46)
end

basicFuncsInited = false

function manualSolver:pushed(cid, sid)

    if not basicFuncsInited then
        initBasicFunctions()
        basicFuncsInited = true
    end

    self.pl.widgets = {}
    self.pl.focus = 0
    self.cid = cid
    self.sid = sid
    self.sub = Categories[cid].sub[sid]
    self.pl.oy = 0
    self.known = {}
    self.inputs = {}
    self.constants = {}

    local inp, lbl
    local i = 0
    local nodropdown, lastdropdown
    for variable, _ in pairs(self.sub.variables) do


        if not Constants[variable] or Categories[cid].varlink[variable] then
            i = i + 1
            inp = sInput()
            inp.value = ""
            --inp.number	= true

            function inp:enterKey()
                if not tonumber(self.value) and #self.value > 0 then
                    if not manualSolver:preSolve(self) then
                        self.value = self.value .. "   " .. utf8(8658) .. " Invalid input"
                    end
                end
                manualSolver:solve()
                self.parent:switchFocus(1)
            end

            self.inputs[variable] = inp
            inp.ww = -145
            inp.focusDown = 4
            inp.focusUp = -2
            lbl = sLabel(variable, inp)

            self.pl:appendWidget(inp, 60, i * 30 - 28)
            self.pl:appendWidget(lbl, 2, i * 30 - 28)
            self.pl:appendWidget(sLabel(":", inp), 50, i * 30 - 28)

            print(variable)
            local variabledata = Categories[cid].varlink[variable]
            inp.placeholder = variabledata.info

            if nodropdown then
                inp.focusUp = -1
            end

            if variabledata then
                if variabledata.unit ~= "unitless" then
                    --unitlbl	= sLabel(variabledata.unit:gsub("([^%d]+)(%d)", numberToSub))
                    local itms = { variabledata.unit }
                    for k, _ in pairs(Units[variabledata.unit]) do
                        table.insert(itms, k)
                    end
                    inp.dropdown = sDropdown(itms)
                    inp.dropdown.unitmode = true
                    inp.dropdown.change = self.update
                    inp.dropdown.focusUp = nodropdown and -5 or -4
                    inp.dropdown.focusDown = 2
                    self.pl:appendWidget(inp.dropdown, -2, i * 30 - 28)
                    nodropdown = false
                    lastdropdown = inp.dropdown
                else
                    self.pl:appendWidget(sLabel("Unitless"), -32, i * 30 - 28)
                end
            else
                nodropdown = true
                inp.focusDown = 1
                if lastdropdown then
                    lastdropdown.focusDown = 1
                    lastdropdown = false
                end
            end

            inp.getFocus = manualSolver.update
        else
            self.constants[variable] = math.eval(Constants[variable].value)
            --var.store(variable, self.known[variable])
        end
    end
    inp.focusDown = 1

    manualSolver.sb:update(0, math.floor(self.pl.h / 30 + .5), i)
    self.pl:giveFocus()

    self.pl.focus = 1
    self.pl:getWidget().hasFocus = true
    self.pl:getWidget():getFocus()
end

function manualSolver.update()
    manualSolver:solve()
end

function manualSolver:preSolve(input)
    local res, err
    res, err = math.eval(input.value)
    res = res and round(res, 4)
    print("Presolve : ", input.value .. " = " .. tostring(res), "(err ? = " .. tostring(err) .. ")")
    input.value = res and tostring(res) or input.value
    return res and 1 or false
end

function manualSolver:solve()
    local inputed = {}
    local disabled = {}

    for variable, input in pairs(self.inputs) do
        local variabledata = Categories[self.cid].varlink[variable]
        if input.disabled then
            inputed[variable] = nil
            input.value = ""
        end

        input:enable()
        if input.value ~= "" then
            local tmpstr = input.value:gsub(utf8(8722), "-")
            inputed[variable] = tonumber(tmpstr)
            if input.dropdown and input.dropdown.rvalue ~= variabledata.unit then
                inputed[variable] = Units.subToMain(variabledata.unit, input.dropdown.rvalue, inputed[variable])
            end
        end
    end

    local invs = copyTable(inputed)
    for k, v in pairs(self.constants) do
        invs[k] = v
    end
    self.known = find_data(invs, self.cid, self.sid)

    for variable, value in pairs(self.known) do
        if (not inputed[variable] and self.inputs[variable]) then
            local variabledata = Categories[self.cid].varlink[variable]
            local result = tostring(value)
            local input = self.inputs[variable]

            if input.dropdown and input.dropdown.rvalue ~= variabledata.unit then
                result = Units.mainToSub(variabledata.unit, input.dropdown.rvalue, result)
            end

            input.value = result
            input:disable()
        end
    end
end

function manualSolver:escapeKey()
    only_screen_back(SubCatSel, self.cid)
end

function manualSolver:contextMenu()
    push_screen_direct(usedFormulas)
end

usedFormulas = Dialog("Used formulas", 10, 10, -20, -20)

usedFormulas.but = sButton("Close")

usedFormulas:appendWidget(usedFormulas.but, -10, -5)

function usedFormulas:postPaint(gc)
    if self.ed then
        self.ed:move(self.x + 5, self.y + 30)
        self.ed:resize(self.w - 9, self.h - 74)
    end

    nativeBar(gc, self, self.h - 40)
end

function usedFormulas:pushed()
    doNotDisplayIcon = true
    self.ed = D2Editor.newRichText()
    self.ed:setReadOnly(true)
    local cont = ""

    local fmls = #manualSolver.sub.formulas
    for k, v in ipairs(manualSolver.sub.formulas) do
        cont = cont .. k .. ": \\0el {" .. v.formula .. "} " .. (k < fmls and "\n" or "")
    end

    if self.ed.setExpression then
        self.ed:setExpression(cont, 1)
        self.ed:registerFilter{ escapeKey = usedFormulas.closeEditor, enterKey = usedFormulas.closeEditor, tabKey = usedFormulas.leaveEditor }
        self.ed:setFocus(true)
    else
        self.ed:setText(cont, 1)
    end

    self.but:giveFocus()
end

function usedFormulas.leaveEditor()
    platform.window:setFocus(true)
    usedFormulas.but:giveFocus()
    return true
end

function usedFormulas.closeEditor()
    platform.window:setFocus(true)
    if current_screen() == usedFormulas then
        remove_screen()
    end
    doNotDisplayIcon = false
    return true
end

function usedFormulas:screenLoseFocus()
    self:removed()
end

function usedFormulas:screenGetFocus()
    self:pushed()
end

function usedFormulas:removed()
    if usedFormulas.ed.setVisible then
        usedFormulas.ed:setVisible(false)
    else
        usedFormulas.ed:setText("")
        usedFormulas.ed:resize(1, 1)
        usedFormulas.ed:move(-10, -10)
    end
    usedFormulas.ed = nil
    doNotDisplayIcon = false
end

function usedFormulas.but.action(self)
    remove_screen()
end	

