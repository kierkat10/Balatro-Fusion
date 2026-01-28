return {
    key = "split_greed",
    name = "Split Greed",
    input = {
        "j_greedy_joker",
        "j_half",
    },
    joker = {
        config = {
            extra = {
                xmult = 2,
                size = 3
            }
        },
        pos = { x = 2, y = 1 },
        pixel_size = { h = 95 / 1.7 },
        blueprint_compat = true,
        atlas = "joker",
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    card.ability.extra.xmult,
                    card.ability.extra.size
                }
            }
        end,
        calculate = function(self, card, context)
            if context.individual and context.cardarea == G.play and context.other_card:is_suit("Diamonds") and #context.full_hand <= card.ability.extra.size then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end,
        bfs_credits = {
            idea = { "The Wheel" },
            art = { "The Wheel" },
            code = { "Glitchkat10" }
        }
    }
}