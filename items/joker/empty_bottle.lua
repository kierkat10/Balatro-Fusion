return {
    key = "empty_bottle",
    name = "Empty Bottle",
    input = {
        "j_stencil",
        "j_diet_cola",
    },
    joker = { 
        config = {
            extra = {
                scaling = 0,
                xmult = 0.2
            }
        },
        pos = { x = 0, y = 0 },
        blueprint_compat = true,
        atlas = "placeholder",
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    1 + card.ability.extra.scaling * card.ability.extra.xmult,
                    card.ability.extra.xmult
                }
            }
        end,
        calculate = function(self, card, context)
            if context.joker_main then
                card.ability.extra.scaling = card.ability.extra.scaling + (#G.GAME.tags or 0)
                local xmult = 1 + card.ability.extra.scaling * card.ability.extra.xmult
                if xmult > 1 then
                    return {
                        xmult = xmult,
                    }
                end
            end
        end,
        bfs_credits = {
            idea = { "ButterStutter" },
            code = { "ButterStutter"}
        }
    }
}