-- Adriweb 2012
-- Creation of public functions for MyLib things that return the strings later loaded by the formulapro lua script.
platform.apilevel = "1.0"



-------------------------
--Put your things here---
-------------------------

categories = [[addCat(17, ""My Custom Cat"", ""Essai de texte"")]]

subcategories = [[addSubCat(17, 1, ""Custom subcat 1"", ""text123"")]]

variables = [[addCatVar(17, ""A"", ""Area"", ""m2"")
addCatVar(17, ""B"", ""Trollastic induction"", ""T"")]]

equations = [[aF(17, 1, ""A=2*B"", U(""A"",""B"")) ]]















-------------------------
--- Don't touch below ---
-------------------------

inited = false

FuncStart = [[
Func
:Return "]]

FuncEnd = [["
:EndFunc]]

function CreateFunc(name)
    local bigStr = [[Define LibPub ]] .. name .. "()=" .. FuncStart .. _G[name] .. FuncEnd
    math.eval(bigStr)
end

function init()
    CreateFunc("categories")
    CreateFunc("subcategories")
    CreateFunc("variables")
    CreateFunc("equations")
    inited = true
end

function on.create()
    if not inited then
        init()
        print("inited")
    end
end