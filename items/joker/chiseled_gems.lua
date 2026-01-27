return {
    fusion = {
        id = "joker_fusion",
        key = "chiseled_gems",
        name = "Chiseled Gems",
        input = {
            "j_arrowhead",
            "j_onyx_agate",
        },
        output = "j_bfs_chiseled_gems"
    },
    joker = {
        key = "chiseled_gems",
        name = "Chiseled Gems",
        config = { extra = { xmult = 1.5 } },
        pos = { x = 0, y = 0 },
        cost = 14,
        rarity = "bfs_fused",
        blueprint_compat = true,
        atlas = "placeholder",
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.xmult } }
        end,
        calculate = function(self, card, context)
            if context.individual and context.cardarea == G.play and (context.other_card:is_suit("Spades") or context.other_card:is_suit("Clubs")) then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end,
        bfs_credits = {
            idea = { "Jesus" },
            code = { "Glitchkat10" }
        }
    }
}