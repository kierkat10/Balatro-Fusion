return {
    key = "kaleidoscope",
    name = "Kaleidoscope",
    input = {
        "j_glass",
        "j_hallucination",
    },
    joker = {
        config = { extra = { xmult = 1, xmult_gain = 0.5, odds = 3 } },
        pos = { x = 0, y = 0 },
        blueprint_compat = true,
        atlas = "placeholder",
        loc_vars = function(self, info_queue, card)
            local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "j_bfs_kaleidoscope")
            return {
                vars = {
                    numerator,
                    denominator,
                    card.ability.extra.xmult_gain,
                    card.ability.extra.xmult
                }
            }
        end,
        calculate = function(self, card, context)
            if context.open_booster and not context.blueprint then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local destroyed_cards = {}
                        for _, other_card in pairs(G.pack_cards.cards) do
                            if SMODS.pseudorandom_probability(card, "j_bfs_apophenia", 1, card.ability.extra.odds) then
                                destroyed_cards[#destroyed_cards+1] = other_card
                                G.E_MANAGER:add_event(Event({
                                    trigger = 'after',
                                    delay = 0.1,
                                    func = function() 
                                        for i=#destroyed_cards, 1, -1 do
                                            local destroy_card = destroyed_cards[i]
                                            if SMODS.shatters(destroy_card) then
                                                destroy_card:shatter()
                                            else
                                                destroy_card:start_dissolve(nil, i ~= #destroyed_cards)
                                            end
                                        end
                                        return true
                                    end
                                }))
                            end
                        end

                        local total_mult_gain = card.ability.extra.xmult_gain * #destroyed_cards
                        if total_mult_gain > 0 then
                            card_eval_status_text(card, "extra", nil, nil, nil, {message = "Shattered!", colour = G.C.ORANGE})
                            card.ability.extra.xmult = card.ability.extra.xmult + total_mult_gain
                            card_eval_status_text(card, "extra", nil, nil, nil, {message = "X"..card.ability.extra.xmult.." Mult!", colour = G.C.RED})
                        end

                        return true
                    end

                }))

                return
            elseif context.joker_main then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end,
        bfs_credits = {
            art = { "" },
            idea = { "ButterStutter" },
            code = { "ButterStutter" }
        }
    }
}