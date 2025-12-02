SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "perkeo_king",
    name = "Perkeo - King of Kings",
    input = {
        "j_baron",
        "j_perkeo"
    },
    output = "j_bfs_perkeo_king"
})

SMODS.Joker{
    key = "perkeo_king",
    name = "Perkeo - Kings of Kings",
    config = { extra = { xmult = 2 } },
    pos = { x = 5, y = 0 },
    soul_pos = { x = 6, y = 0 },
    cost = 28,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.ending_shop and G.consumeables.cards[1] then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local card_to_copy, _ = pseudorandom_element(G.consumeables.cards, 'p_bfs_perkeo_king')
                    local copied_card = copy_card(card_to_copy)
                    copied_card:set_edition("e_negative", true)
                    copied_card:add_to_deck()
                    G.consumeables:emplace(copied_card)
                    return true
                end
            }))
            return {
                message = localize("k_duplicated_ex")
            }
        end
        if context.other_consumeable then
            return {
                xmult = card.ability.extra.xmult,
                message_card = context.other_consumeable
            }
        end
    end,
	bfs_credits = {
		code = { "Glitchkat10" }
	}
}