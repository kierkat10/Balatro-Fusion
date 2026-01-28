return {
    key = "tempered",
    name = "Tempered Joker",
    input = {
        "j_gluttenous_joker",
        "j_gluttenous_joker",
    },
    joker = {
        config = { extra = { xchips = 1.5 } },
        pos = { x = 7, y = 2 },
        blueprint_compat = true,
        atlas = "joker",
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.xchips } }
        end,
        calculate = function(self, card, context)
            if context.individual and context.cardarea == G.play and context.other_card:is_suit("Clubs") then
                return {
                    xchips = card.ability.extra.xchips
                }
            end
        end,
        bfs_credits = {
            idea = { "The Wheel" },
            art = { "The Wheel" },
            code = { "ButterStutter" }
        }
    }
}