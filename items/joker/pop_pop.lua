SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "pop_pop",
    name = "Pop-Pop-Pop-Pop",
    input = {
        "j_popcorn",
        "j_riff_raff",
    },
    output = "j_bfs_pop_pop"
})

SMODS.Joker {
    key = "pop_pop",
    name = "Pop-Pop-Pop-Pop",
    config = {
        extra = {
            mult = 40,
            mult_decrease = 8,
            reduction = 2,
        }
    },
    pos = { x = 7, y = 9 },
    cost = 12,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "riff-raff",
    loc_vars = function(self, info_queue, card)
        local reduction = 0
        for _, v in pairs(G.jokers and G.jokers.cards or {}) do
            if v.config.center.rarity == 1 then
                reduction = reduction + card.ability.extra.reduction
            end
        end
        local mult_decrease = card.ability.extra.mult_decrease - reduction
        return {
            vars = {
                card.ability.extra.mult,
                math.abs(mult_decrease),
                card.ability.extra.reduction,
                (function()
                    if mult_decrease > 0 then
                        return "decreases"
                    else
                        return "increases"
                    end
                end)(),
                (function()
                    if mult_decrease > 0 then
                        return "-"
                    else
                        return "+"
                    end
                end)(),
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
        if context.after then
            local decrease = card.ability.extra.mult_decrease
            for _, v in pairs(G.jokers.cards) do 
                if v.config.center.rarity == 1 then
                    decrease = decrease - card.ability.extra.reduction
                end
            end
            card.ability.extra.mult = card.ability.extra.mult - decrease
            return {
                message = (function()
                    if decrease >= 0 then
                        return "-"
                    else
                        return "+"
                    end
                end)()..math.abs(decrease).." Mult!",
                colour = G.C.RED
            }
        end
    end,
    bfs_credits = {
        art = { "StellarBlue" },
        idea = { "ButterStutter" },
		code = { "ButterStutter" }
	}
}