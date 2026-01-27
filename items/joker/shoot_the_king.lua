return {
    key = "shoot_the_king",
    name = "Shoot the King",
    input = {
        "j_baron",
        "j_shoot_the_moon",
    },
    joker = {
        config = {
            extra = {
                mult = 20,
                xmult = 2
            }
        },
        pos = { x = 0, y = 0 },
        blueprint_compat = true,
        atlas = "placeholder",
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    card.ability.extra.mult,
                    card.ability.extra.xmult
                }
            }
        end,
        calculate = function(self, card, context)
            if context.individual and context.cardarea == G.hand and not context.end_of_round and context.other_card:is_face() then
                return {
                    mult = card.ability.extra.mult,
                    extra = {
                        xmult = card.ability.extra.xmult 
                    }
                }
            end
        end,
        bfs_credits = {
            idea = { "Glitchkat10" },
            code = { "Glitchkat10" }
        }
    }
}