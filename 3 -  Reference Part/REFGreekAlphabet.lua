Greek=Screen()
 
font = "serif"
 
function utf8(nbr)
        return string.uchar(nbr)
end
 
alphabet1 = {
 { utf8(913), utf8(945), "Alpha" },
 { utf8(914), utf8(946), "Beta" },
 { utf8(915), utf8(947), "Gamma" },
 { utf8(916), utf8(948), "Delta" },
 { utf8(917), utf8(949), "Epsilon" },
 { utf8(918), utf8(950), "Zeta" },
 { utf8(919), utf8(951), "Eta" },
 { utf8(920), utf8(952), "Theta" }
}
alphabet2 = {
 { utf8(921), utf8(953), "Iota" },
 { utf8(922), utf8(954), "Kappa" },
 { utf8(923), utf8(955), "Lambda" },
 { utf8(924), utf8(956), "Mu" },
 { utf8(925), utf8(957), "Nu" },
 { utf8(926), utf8(958), "Xi" },
 { utf8(927), utf8(959), "Omicron" },
 { utf8(928), utf8(960), "Pi" }
}
alphabet3 = {
 { utf8(929), utf8(961), "Rho" },
 { utf8(931), utf8(963), "Sigma" },
 { utf8(932), utf8(964), "Tau" },
 { utf8(933), utf8(965), "Upsilon" },
 { utf8(934), utf8(966), "Phi" },
 { utf8(935), utf8(967), "Chi" },
 { utf8(936), utf8(968), "Psi" },
 { utf8(937), utf8(969), "Omega" }
}
 
function Greek:paint(gc)
        msg = "Greek Alphabet"
        gc:setFont("sansserif","b",12)
        gc:drawString(msg,.5*(platform.window:width()-gc:getStringWidth(msg)),5,"top")
        gc:setFont(font,"r",12)
        for k,v in pairs(alphabet1) do
                gc:drawString(v[3] .. " : " .. v[1] .. " " .. v[2], 5, 10+22*k, "top")
        end
        for k,v in pairs(alphabet2) do
                gc:drawString(v[3] .. " : " .. v[1] .. " " .. v[2], 5+.34*platform.window:width(), 10+22*k, "top")
        end
        for k,v in pairs(alphabet3) do
                gc:drawString(v[3] .. " : " .. v[1] .. " " .. v[2], 5+.67*platform.window:width(), 10+22*k, "top")
        end
end
 
function Greek:enterKey()
    font = font == "serif" and "sansserif" or "serif"
    Greek:invalidate()
end
