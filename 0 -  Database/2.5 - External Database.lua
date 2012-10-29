
-- This part is supposed to load external formulas stored in a string
-- (or else, if a better way of storing is found) from a file in MyLib.

function loadExtDB()
    local err
    _, err = pcall(function()
        loadstring(math.eval("formulaproextdb\\categories()"))()
        loadstring(math.eval("formulaproextdb\\variables()"))()
        loadstring(math.eval("formulaproextdb\\subcategories()"))()
        loadstring(math.eval("formulaproextdb\\equations()"))()
    end)

    if err then
        print("no external db loaded")
        -- Display something ?
        -- or it simply means there is nothing to be loaded.
    else
        -- display something that tells the user the external DB has been successfully loaded.
        print("external db succesfully loaded")
    end
end
