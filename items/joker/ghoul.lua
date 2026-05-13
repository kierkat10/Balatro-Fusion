return {
    key = "ghoul",
    name = "Ghoul",
    input = {
        "j_vampire",
        "j_hallucination",
    },
    joker = {
        config = { extra = { xmult = 1, xmult_gain = 1 } },
        pos = { x = 0, y = 0 },
        blueprint_compat = true,
        atlas = "placeholder",
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    card.ability.extra.xmult_gain,
                    card.ability.extra.xmult
                }
            }
        end,
        calculate = function(self, card, context)
            if context.open_booster and not context.blueprint then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local wiped_cards = 0
                        for _, other_card in pairs(G.pack_cards.cards) do
                            if other_card.config.center.set == "Enhanced" then
                                wiped_cards = wiped_cards + 1
                                other_card:set_ability(G.P_CENTERS.c_base, nil, true)
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        other_card:juice_up()
                                        return true
                                    end
                                }))
                            end
                        end

                        if wiped_cards > 0 then
                            card_eval_status_text(card, "extra", nil, nil, nil, {message = "Wiped!", colour = G.C.ORANGE})
                        end

                        if context.card.config.center.kind == "Standard" then
                            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
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