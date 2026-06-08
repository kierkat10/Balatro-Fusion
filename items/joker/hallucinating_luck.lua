return {
    key = "hallucinating_luck",
    name = "Hallucinating Luck",
    input = {
        "j_lucky_cat",
        "j_hallucination",
    },
    joker = {
        config = { extra = { odds = 2 } },
        pos = { x = 0, y = 0 },
        blueprint_compat = true,
        atlas = "placeholder",
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky
            local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "j_bfs_hallucinating_luck")
            return {
                vars = {
                    numerator,
                    denominator
                }
            }
        end,
        calculate = function(self, card, context)
            if context.open_booster and not context.blueprint then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local lucky_cards = 0
                        for _, other_card in pairs(G.pack_cards.cards) do
                            if (other_card.config.center.set == "Enhanced" or other_card.config.center.set == "Default") and G.P_CENTERS.m_lucky and SMODS.pseudorandom_probability(card, "j_bfs_apophenia", 1, card.ability.extra.odds) then
                                lucky_cards = lucky_cards + 1
                                other_card:set_ability(G.P_CENTERS.m_lucky, nil, true)
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        other_card:juice_up()
                                        return true
                                    end
                                }))
                            end
                        end

                        if lucky_cards > 0 then
                            card_eval_status_text(card, "extra", nil, nil, nil, {message = "Lucky!", colour = G.C.PURPLE})
                        end

                        return true
                    end
                }))
            end
        end,
        bfs_credits = {
            art = { "" },
            idea = { "ButterStutter" },
            code = { "ButterStutter" }
        }
    }
}