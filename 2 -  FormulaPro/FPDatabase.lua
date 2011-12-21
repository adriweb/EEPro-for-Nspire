platform.apilevel = "1.0"

formulas	=	{}
units	=	{}

function f(t)
	table.insert(formulas, t)
end

function u(t)
	table.insert(units, t)
end

-- syntax :  {{category,subcategory}, equationString, {var1=true, var2=true, var3=true...}}

f{{1,1}, "P=I*U", {U=true,I=true, P=true}}
f{{1,1}, "U=R*I", {U=true, R=true, I=true}}

-- Units, NEEDS FIXING OR ADRIWEB IS GOING TO KILL ME
u{"I", "Current", {{"val", "A", "Ampere"}, {"val/1000", "mA"}}}
u{"U", "Voltage", {{"val", "V", "Volt"}, {"val/1000", "mV"}}}
u{"P", "Power", {{"val", "W" ,"Watt"}, {"val*1000", "kW"}, {"val*750", "hp"}}}
u{"R", "Resistance", {{"val", string.uchar(937), "Ohm"}, {"val*1000", "kO"}}} -- replace O by the Ohm symbol  ("omega" constant defined in globals.lua)...
