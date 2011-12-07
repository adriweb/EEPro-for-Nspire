font = "serif"

alphabet1 = {
 { "Α", "α", "Alpha" },
 { "Β", "β", "Beta" },
 { "Γ", "γ", "Gamma" },
 { "Δ", "δ", "Delta" },
 { "Ε", "ε", "Epsilon" },
 { "Ζ", "ζ", "Zeta" },
 { "Η", "η", "Eta" },
 { "Θ", "θ", "Theta" }
}
alphabet2 = {
 { "Ι", "ι", "Iota" },
 { "Κ", "κ", "Kappa" },
 { "Λ", "λ", "Lambda" },
 { "Μ", "μ", "Mu" },
 { "Ν", "ν", "Nu" },
 { "Ξ", "ξ", "Xi" },
 { "Ο", "ο", "Omicron" },
 { "Π", "π", "Pi" }
}
alphabet3 = {
 { "Ρ", "ρ", "Rho" },
 { "Σ", "σ", "Sigma" },
 { "Τ", "τ", "Tau" },
 { "Υ", "υ", "Upsilon" },
 { "Φ", "φ", "Phi" },
 { "Χ", "χ", "Chi" },
 { "Ψ", "ψ", "Psi" },
 { "Ω", "ω", "Omega" }
}

function on.paint(gc)
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

function on.enterKey()
    font = font == "serif" and "sansserif" or "serif"
end