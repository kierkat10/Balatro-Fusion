local fused_gradient = SMODS.Gradient({
    key = "fused",
    colours = {
        HEX("99cb4e"), 
        HEX("e15e8c")
    }
})

SMODS.Rarity {
    key = "fused",
    badge_colour = fused_gradient,
    pools = { ["Joker"] = true },
}