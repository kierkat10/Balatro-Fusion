SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "wandering_trader",
    name = "Wandering Trader",
    input = {
        "j_todo_list",
        "j_vagabond",
    },
    output = "j_bfs_wandering_trader",
})
SMODS.Joker {
    key = "wandering_trader",
    name = "Wandering Trader",
    config = {
        to_do_poker_hand="High Card",
        extra={
            dollars=4,
        },
    },
    pos = { x = 0, y = 0 },
    cost = 14,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "placeholder",
    loc_vars = function(self, info_queue, card)
        return {
            vars={
                card.ability.extra.dollars,
                localize(card.ability.to_do_poker_hand,"poker_hands"),
            }
        }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.blueprint then
            local _poker_hands = {}
            for k, v in pairs(G.GAME.hands) do
                if SMODS.is_poker_hand_visible(k) and k ~= self.ability.to_do_poker_hand then _poker_hands[#_poker_hands+1] = k end
            end
            card.ability.to_do_poker_hand = pseudorandom_element(_poker_hands, pseudoseed("bfs_wandering_trader"))
        end
        if context.joker_main and context.scoring_name == card.ability.to_do_poker_hand then
            local card_limit = G.consumeables.config.card_limit
            for i = 1, card_limit - #G.consumeables.cards do
                local created_card = create_card("Tarot",G.consumeables, nil, nil, nil, nil, nil, "bfs_wandering_trader")
                G.consumeables:emplace(created_card)
                created_card:add_to_deck()
            end
            return {
                dollars = card.ability.extra.dollars
            }
        end
    end,
	bfs_credits = {
        idea = { "Glitchkat10" },
		code = { "TheRealLact4" },
	}
}
