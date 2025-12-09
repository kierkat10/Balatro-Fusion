SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "stone_card",
    name = "Stone Card",
    input = {
        "j_stone",
        "j_red_card",
    },
    output = "j_bfs_stone_card"
})

SMODS.Joker {
    key = "stone_card",
    name = "Stone Card",
    config = {
        extra = {
            chips = 0,
            increase = 65,
        }
    },
    pos = { x = 0, y = 3 },
    cost = 13,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.increase
            }
        }
    end,
    calculate = function(self, card, context)
        if context.skipping_booster and context.booster and context.booster.kind and context.booster.kind == "Standard" then
            if (function() 
                for _, other_card in pairs(G.pack_cards.cards) do
                    if SMODS.has_enhancement(other_card, "m_stone") then
                        return true
                    end
                end
                return false
            end)() then
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.increase
                return {
                    message = "+"..card.ability.extra.chips.." Chips!",
                    colour = G.C.BLUE
                }
            end
        end
        if context.joker_main and card.ability.extra.chips > 0 then
            return {
                chips = card.ability.extra.chips
            }
        end
    end,
    bfs_credits = {
        idea = { "ButterStutter" },
        art = { "ButterStutter" },
		code = { "ButterStutter" }
	}
}