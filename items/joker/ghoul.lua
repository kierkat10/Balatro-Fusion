return {
    key = "ghoul",
    name = "Ghoul",
    input = {
        "j_vampire",
        "j_hallucination",
    },
    joker = {
        config = { extra = { xmult = 1, xmult_gain = 1 } },
        pos = { x = 0, y = 0 },
        blueprint_compat = true,
        atlas = "placeholder",
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    card.ability.extra.xmult_gain,
                    card.ability.extra.xmult
                }
            }
        end,
        calculate = function(self, card, context)
            if context.open_booster and SMODS.OPENED_BOOSTER.ability.name:find('Standard') and not context.blueprint then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                return {
                    message = "X"..card.ability.extra.xmult.." Mult!",
                    colour = G.C.RED
                }
            elseif context.joker_main then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end,
        bfs_credits = {
            art = { "" },
            idea = { "ButterStutter" },
            code = { "ButterStutter" }
        }
    }
}