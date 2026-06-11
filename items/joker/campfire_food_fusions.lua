local campfire_popcorn = {
    key = "campfire_popcorn",
    name = "Campfire Popcorn",
    input = {
        "j_popcorn",
        "j_campfire",
    },
    joker = {
        config = {
            extra = {
                mult = 40,
                mult_loss = 4,
                mult_gain = 5,
            }
        },
        pos = { x = 0, y = 0 },
        blueprint_compat = true,
        atlas = "placeholder",
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    card.ability.extra.mult,
                    card.ability.extra.mult_loss,
                    card.ability.extra.mult_gain,
                }
            }
        end,
        calculate = function(self, card, context)
            if context.joker_main then
                return {
                    mult = card.ability.extra.mult
                }
            elseif context.end_of_round and context.game_over == false and not context.blueprint then
                local decrease = card.ability.extra.mult_loss
                if card.ability.extra.mult - decrease <= 0 then
                    SMODS.destroy_cards(card, nil, nil, true)
                    return {
                        message = "Eaten!",
                        colour = G.C.RED
                    }
                else
                    card.ability.extra.mult = card.ability.extra.mult - decrease
                    return {
                        message = "-"..decrease.." Mult!",
                        colour = G.C.RED
                    }
                end
            elseif context.selling_card then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                return {
                    message = "+"..card.ability.extra.mult.." Mult!",
                    colour = G.C.RED
                }
            end
        end,
        bfs_credits = {
            art = { },
            idea = { "ButterStutter" },
            code = { "ButterStutter" }
        }
    }
}

local smore = {
    key = "smore",
    name = "Smore",
    input = {
        "j_ice_cream",
        "j_campfire",
    },
    joker = {
        config = {
            extra = {
                chips = 140,
                chip_loss = 8,
                chip_gain = 12,
            }
        },
        pos = { x = 0, y = 0 },
        blueprint_compat = true,
        atlas = "placeholder",
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    card.ability.extra.chips,
                    card.ability.extra.chip_loss,
                    card.ability.extra.chip_gain,
                }
            }
        end,
        calculate = function(self, card, context)
            if context.joker_main then
                return {
                    chips = card.ability.extra.chips
                }
            elseif context.after then
                local decrease = card.ability.extra.chip_loss
                if card.ability.extra.chips - decrease <= 0 then
                    SMODS.destroy_cards(card, nil, nil, true)
                    return {
                        message = "Eaten!",
                        colour = G.C.BLUE
                    }
                else
                    card.ability.extra.chips = card.ability.extra.chips - decrease
                    return {
                        message = "-"..decrease.." Chips!",
                        colour = G.C.BLUE
                    }
                end
            elseif context.selling_card then
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_gain
                return {
                    message = "+"..card.ability.extra.chips.." Chips!",
                    colour = G.C.BLUE
                }
            end
        end,
        bfs_credits = {
            art = { },
            idea = { "ButterStutter" },
            code = { "ButterStutter" }
        }
    }
}

local ho_cho = {
    key = "ho_cho",
    name = "Hot Chocolate",
    input = {
        "j_ramen",
        "j_campfire",
    },
    joker = {
        config = {
            extra = {
                xmult = 2.5,
                xmult_loss = 0.04,
                xmult_gain = 0.1,
            }
        },
        pos = { x = 0, y = 0 },
        blueprint_compat = true,
        atlas = "placeholder",
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    card.ability.extra.xmult,
                    card.ability.extra.xmult_loss,
                    card.ability.extra.xmult_gain,
                }
            }
        end,
        calculate = function(self, card, context)
            if context.joker_main then
                return {
                    xmult = card.ability.extra.xmult
                }
            elseif context.discard then
                local decrease = card.ability.extra.xmult_loss
                if card.ability.extra.xmult - decrease <= 1 then
                    SMODS.destroy_cards(card, nil, nil, true)
                    return {
                        message = "Drained!",
                        colour = G.C.RED
                    }
                else
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = "xmult",
                        scalar_value = "xmult_loss",
                        operation = "-",
                        message_key = 'a_xmult_minus',
                        colour = G.C.RED,
                        message_delay = 0.2,
                    })
                end
            elseif context.selling_card then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                return {
                    message = "X"..card.ability.extra.xmult.." Mult!",
                    colour = G.C.RED
                }
            end
        end,
        bfs_credits = {
            art = { },
            idea = { "ButterStutter" },
            code = { "ButterStutter" }
        }
    }
}

return {
    campfire_popcorn,
    smore,
    ho_cho
}