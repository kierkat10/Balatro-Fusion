SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "steel_card",
    name = "Steel Card",
    input = {
        "j_steel_joker",
        "j_red_card",
    },
    output = "j_bfs_steel_card"
})

SMODS.Joker {
    key = "steel_card",
    name = "Steel Card",
    config = {
        extra = {
            xmult = 1,
            increase = 1.25,
        }
    },
    pos = { x = 1, y = 3 },
    cost = 13,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
        return {
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.increase
            }
        }
    end,
    calculate = function(self, card, context)
        if context.skipping_booster and context.booster and context.booster.kind and context.booster.kind == "Standard" then
            if (function() 
                for _, other_card in pairs (G.pack_cards.cards) do 
                    if SMODS.has_enhancement(other_card, "m_steel") then
                        return true
                    end
                end
                return false
            end)() then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.increase
                return {
                    message = "X"..card.ability.extra.xmult.." Mult!",
                    colour = G.C.RED
                }
            end
        end
        if context.joker_main and card.ability.extra.xmult > 1 then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
    bfs_credits = {
        idea = { "GeorgeTheRat" },
        art = { "ButterStutter" },
		code = { "ButterStutter" }
	}
}