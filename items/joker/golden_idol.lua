SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "golden_idol",
    name = "Golden Idol",
    input = {
        "j_idol",
        "j_golden",
    },
    output = "j_bfs_golden_idol"
})

SMODS.Joker {
    key = "golden_idol",
    name = "Golden Idol",
    config = { extra = { dollars = 4 } },
    pos = { x = 7, y = 9 },
    cost = 13,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "joker",
    set_ability = function(self, card, initial)
        G.GAME.current_round.golden_idol_card = { suit = "Diamonds", rank = "Jack", id = "11" }
    end,
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                localize((G.GAME.current_round.golden_idol_card or {}).suit or "Diamonds", "suits_plural"),
                localize((G.GAME.current_round.golden_idol_card or {}).rank or "Jack", "ranks"),
                card.ability.extra.dollars,
                colours = {G.C.SUITS[(G.GAME.current_round.golden_idol_card or {}).suit or "Diamonds"]},
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.card_area == G.play and context.other_card:get_id() == G.GAME.current_round.golden_idol_card.id and context.other_card:is_suit(G.GAME.current_round.golden_idol_card.suit) then
            return {
                dollars = card.ability.extra.dollars
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and G.playing_cards then
            local valid_suit_cards = {}
            local valid_rank_cards = {}
            for _, v in ipairs(G.playing_cards) do
                if not SMODS.has_no_suit(v) then
                    valid_suit_cards[#valid_suit_cards + 1] = v
                end
                if not SMODS.has_no_rank(v) then
                    valid_rank_cards[#valid_rank_cards + 1] = v
                end
            end
            if valid_suit_cards[1] then
                local suit_card = pseudorandom_element(valid_suit_cards, pseudoseed("golden_idol_suit" .. G.GAME.round_resets.ante))
                G.GAME.current_round.golden_idol_card.suit = suit_card and suit_card.base.suit
            end
            if valid_rank_cards[1] then
                local rank_card = pseudorandom_element(valid_rank_cards, pseudoseed("golden_idol_rank" .. G.GAME.round_resets.ante))
                G.GAME.current_round.golden_idol_card.rank = rank_card and rank_card.base.value
                G.GAME.current_round.golden_idol_card.id = rank_card and rank_card.base.id
            end
        end
    end,
	bfs_credits = {
        art = { "ButterStutter" },
        idea = { "ButterStutter" },
		code = { "ButterStutter" }
	}
}