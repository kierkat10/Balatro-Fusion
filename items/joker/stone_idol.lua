return {
    key = "stone_idol",
    name = "Stone Idol",
    input = {
        "j_idol",
        "j_stone",
    },
    joker = {
        config = { extra = { xchips = 2 } },
        pos = { x = 6, y = 10 },
        blueprint_compat = true,
        atlas = "joker",
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
            return { vars = { card.ability.extra.xchips } }
        end,
        calculate = function(self, card, context)
            if context.individual and context.card_area == G.play and SMODS.has_enhancement(context.other_card, "m_stone") then
                return {
                    xchips = card.ability.extra.xchips
                }
            end
        end,
        bfs_credits = {
            art = { "ButterStutter" },
            idea = { "ButterStutter" },
            code = { "ButterStutter" }
        }
    }
}