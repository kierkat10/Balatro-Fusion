SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "stop_sign",
    name = "Stop Sign",
    input = {
        "j_red_card",
        "j_reserved_parking",
    },
    output = "j_bfs_stop_sign",
})
SMODS.Joker {
    key = "stop_sign",
    name = "Stop Sign",
    config = {
        extra = {
            booster_count = 0,
            booster_increase = 1,
            odds = 2,
        },
    },
    pos = { x = 2, y = 11 },
    cost = 14,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "j_bfs_stop_sign")
        return {
            vars = { 
                numerator,
                denominator,
                card.ability.extra.booster_count,
                card.ability.extra.booster_increase,
            } 
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and context.other_card:is_face() and not context.end_of_round and SMODS.pseudorandom_probability(card, "j_bfs_stop_sign", 1, card.ability.extra.odds) then
            card.ability.extra.booster_count = card.ability.extra.booster_count + card.ability.extra.booster_increase
            return {
                message = "+"..card.ability.extra.booster_increase.." Booster!"
            }
        end
        if context.starting_shop and card.ability.extra.booster_count > 0 then
            G.E_MANAGER:add_event(Event({
                func = function()
                    for _ = 1, card.ability.extra.booster_count do
                        SMODS.add_booster_to_shop()
                    end
                    card.ability.extra.booster_count = 0
                    return true
                end
            }))
        end
    end,
	bfs_credits = {
        art = { "Jammuu" },
        idea = { "mechaclownking" },
		code = { "ButterStutter" },
	}
}
