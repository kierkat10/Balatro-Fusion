SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "molotov_cocktail",
    name = "Molotov's Cocktail",
    input = {
        "j_burnt",
        "j_diet_cola",
    },
    output = "j_bfs_molotov_cocktail",
})
SMODS.Joker {
    key = "molotov_cocktail",
    name = "Molotov Cocktail",
    config = {
        
    },
    pos = { x = 0, y = 0 },
    cost = 14,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "placeholder",
    calculate = function(self, card, context)
        if context.selling_self then
            local most_played_hand = G.GAME.current_round.most_played_poker_hand
            local level_up_amount = G.GAME.bfs_cards_sold_len
            if level_up_amount <=0 then level_up_amount = 1 end
            SMODS.smart_level_up_hand(card,most_played_hand,false,level_up_amount)
        end
    end,
	bfs_credits = {
        idea = { "Dima" },
		code = { "TheFalseLact4" },
	}
}
