return {
    key = "chastity",
    name = "Chastity Joker",
    input = {
        "j_lusty_joker",
        "j_lusty_joker",
    },
    joker = {
        config = { extra = { xmult = 1.5 } },
        pos = { x = 8, y = 2 },
        blueprint_compat = true,
        atlas = "joker",
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.xmult } }
        end,
        calculate = function(self, card, context)
            if context.individual and context.cardarea == G.play and context.other_card:is_suit("Hearts") then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end,
        bfs_credits = {
            idea = { "The Wheel" },
            code = { "ButterStutter" },
            art = { "The Wheel" }
        }
    }
}