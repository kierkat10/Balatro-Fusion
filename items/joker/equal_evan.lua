return {
    key = "equal_evan",
    name = "Equal Evan",
    input = {
        "j_even_steven",
        "j_odd_todd"
    },
    joker = {
        config = {
            extra = {
                chips = 53,
                mult = 8
            }
        },
        pos = { x = 0, y = 0 },
        blueprint_compat = true,
        atlas = "joker",
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    card.ability.extra.chips,
                    card.ability.extra.mult
                }
            }
        end,
        calculate = function(self, card, context)
            if context.individual and context.cardarea == G.play then
                return {
                    chips = card.ability.extra.chips,
                    extra = {
                        mult = card.ability.extra.mult
                    }
                }
            end
        end,
        bfs_credits = {
            idea = { "SnowPickle" },
            art = { "SnowPickle" },
            code = { "Glitchkat10" }
        }
    }
}