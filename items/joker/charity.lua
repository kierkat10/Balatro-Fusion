return {
    fusion = {
        id = "joker_fusion",
        key = "charity",
        name = "Charity Joker",
        input = {
            "j_greedy_joker",
            "j_greedy_joker",
        },
        output = "j_bfs_charity"
    },
    joker = {
        key = "charity",
        name = "Charity Joker",
        config = { extra = { xmult = 1.5 } },
        pos = { x = 6, y = 2 },
        cost = 10,
        rarity = "bfs_fused",
        blueprint_compat = true,
        atlas = "joker",
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.xmult } }
        end,
        calculate = function(self, card, context)
            if context.individual and context.cardarea == G.play then
                if context.other_card:is_suit("Diamonds") then
                    return {
                        xmult = 1.5
                    }
                end
            end
        end,
        bfs_credits = {
            idea = { "The Wheel" },
            code = { "ButterStutter" },
            art = { "The Wheel" }
        }
    }
}