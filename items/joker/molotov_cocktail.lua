return {
    key = "molotov_cocktail",
    name = "Molotov's Cocktail",
    input = {
        "j_burnt",
        "j_diet_cola",
    },
    joker = {
        config = {},
        pos = { x = 0, y = 0 },
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
}