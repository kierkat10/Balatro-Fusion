return {
    key = "tavern",
    name = "Tavern",
    input = {
        "j_castle",
        "j_drunkard",
    },
    joker = {
        config = {
            extra = {
                discard_gain = 1,
                discard_req = 3,
            }
        },
        pos = { x = 0, y = 0 },
        blueprint_compat = true,
        atlas = "placeholder",
        set_ability = function(self, card, initial)
            G.GAME.current_round.tavern_card = { suit = "Diamonds" }
        end,
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    card.ability.extra.discard_gain,
                    card.ability.extra.discard_req,
                    localize((G.GAME.current_round.golden_idol_card or {}).suit or "Diamonds", "suits_plural"),
                    colours = {G.C.SUITS[(G.GAME.current_round.golden_idol_card or {}).suit or "Diamonds"]},
                }
            }
        end,
        calculate = function(self, card, context)
            if context.pre_discard then
                local suit_counter = 0
                for _, other_card in pairs(G.hand.highlighted) do
                    if other_card:is_suit(G.GAME.current_round.tavern_card.suit) then
                        suit_counter = suit_counter + 1
                    end
                end
                if suit_counter >= card.ability.extra.discard_req then
                    ease_discard(card.ability.extra.discard_gain)
                    return {
                        message = "+"..card.ability.extra.discard_gain.." Discard"..(card.ability.extra.discard_gain ~= 1 and "s" or "").."!",
                        colour = G.C.RED
                    }
                end
            end
            if context.end_of_round and context.game_over == false and context.main_eval and G.playing_cards then
                local valid_suit_cards = {}
                for _, v in ipairs(G.playing_cards) do
                    if not SMODS.has_no_suit(v) then
                        valid_suit_cards[#valid_suit_cards + 1] = v
                    end
                end
                if valid_suit_cards[1] then
                    local suit_card = pseudorandom_element(valid_suit_cards, pseudoseed("tavern_suit" .. G.GAME.round_resets.ante))
                    G.GAME.current_round.tavern_card.suit = suit_card and suit_card.base.suit
                end
            end
        end,
        bfs_credits = {
            idea = { "ButterStutter" },
            art = { },
            code = { "ButterStutter" }
        }
    }
}