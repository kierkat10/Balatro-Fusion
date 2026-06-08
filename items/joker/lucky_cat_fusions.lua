function BalatroFusion.check_lucky_card(card)
    if next(SMODS.find_card("j_bfs_apophenia")) then
        return true
    end
    if next(SMODS.find_card("j_bfs_clover")) and SMODS.has_enhancement(card, "m_wild") then
        return true
    end
    if next(SMODS.find_card("j_bfs_lucky_guess")) and card:get_id() == 6 then
        return true
    end
    if SMODS.has_enhancement(card, "m_lucky") then
        return true
    end
    return false
end

function BalatroFusion.get_lucky_reward(card, reward_type)
    if reward_type == "mult" then
        local mult = card.ability.mult
        if not mult or mult == 0 then
            mult = 20
        end
        return mult
    elseif reward_type == "dollars" then
        local dollars = card.ability.p_dollars
        if not dollars or dollars == 0 then
            dollars = 20 
        end
        return dollars
    end
end

local apophenia = {
    key = "apophenia",
    name = "Apophenia",
    input = {
        "j_lucky_cat",
        "j_pareidolia",
    },
    joker = {
        config = {
            extra = {
            }
        },
        pos = { x = 0, y = 0 },
        blueprint_compat = true,
        atlas = "placeholder",
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky
        end,
        bfs_credits = {
            idea = { "ButterStutter" },
            art = {},
            code = { "ButterStutter"}
        }
    }
}

local clover = {
    key = "clover",
    name = "Four Leaf Clover",
    input = {
        "j_lucky_cat",
        "j_flower_pot",
    },
    joker = {
        config = {
            extra = {
                xmult = 2.5
            }
        },
        pos = { x = 0, y = 0 },
        blueprint_compat = true,
        atlas = "placeholder",
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
            info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky
            return {
                vars = {
                    card.ability.extra.xmult
                }
            }
        end,
        calculate = function (self,card,context)
            if context.individual and context.cardarea == G.play and BalatroFusion.check_flower_pot_suits(context.scoring_hand) and BalatroFusion.check_lucky_card(context.other_card) then
                return {
                    xmult = card.ability.extra.xmult,
                }
            end
        end,        
        bfs_credits = {
            idea = { "ButterStutter" },
            art = {},
            code = { "ButterStutter"}
        }
    }
}

local lucky_guess = {
    key = "lucky_guess",
    name = "Lucky Guess",
    input = {
        "j_lucky_cat",
        "j_sixth_sense",
    },
    joker = {
        config = {
            extra = {
                odds = 15
            }
        },
        pos = { x = 0, y = 0 },
        blueprint_compat = true,
        atlas = "placeholder",
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky
            local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "j_bfs_lucky_guess")
            return {
                vars = {
                    numerator,
                    denominator
                }
            }
        end,
        calculate = function (self, card, context)
            if context.individual and context.cardarea == G.play and BalatroFusion.check_lucky_card(context.other_card)
                and SMODS.pseudorandom_probability(context.other_card, "j_bfs_lucky_guess", 1, card.ability.extra.odds)
            then
                -- Currently does not trigger lucky cat scaling + similar effects that check card.lucky_trigger
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.0,
                        func = (function()
                                local card = create_card('Spectral',G.consumeables, nil, nil, nil, nil, nil, 'lucky_guess')
                                card:add_to_deck()
                                G.consumeables:emplace(card)
                                G.GAME.consumeable_buffer = 0
                            return true
                        end)}))
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral})
                end
            end
        end,        
        bfs_credits = {
            idea = { "ButterStutter" },
            art = {},
            code = { "ButterStutter"}
        }
    }
}

return {
    apophenia,
    clover,
    lucky_guess
}