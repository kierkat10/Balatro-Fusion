function BalatroFusion.check_fibonacci_rank(card)
    if card:get_id() == 14 or card:get_id() == 2 or card:get_id() == 3 or card:get_id() == 5 or card:get_id() == 8 then
        return true
    end
    if next(SMODS.find_card("j_bfs_nature_spiral")) then
        return true
    end
    if next(SMODS.find_card("j_bfs_calculated_gambling")) and card:get_id() == 12 then
        return true
    end
    -- Possibly add exceptions if card abilities end up using them
    return false
end

local function count_fibonacci(count)
    local total = 1
    local prev_value = 0
    for _ = 1, count do
        local temp_value = total
        total = total + prev_value
        prev_value = temp_value
    end
    return total
end

local ouroboros = {
    key = "ouroboros",
    name = "Ouroboros",
    input = {
        "j_joker",
        "j_fibonacci",
    },
    joker = {
        config = {
            extra={
                mult=0,
                mult_per_card_scored=8,
                mult_gain=4,
            },
        },
        pos = {x=0,y=0,},
        blueprint_compat = true,
        atlas = "placeholder",
        calculate = function (self,card,context)
            if context.cardarea == G.play and context.individual then
                if BalatroFusion.check_fibonacci_rank(context.other_card) then
                    SMODS.scale_card(card,{
                        ref_table=card.ability.extra,
                        ref_value="mult",
                        scalar_value="mult_gain",
                        message_key="a_mult",
                        message_colour=G.C.RED,
                    })
                end
                return {
                    mult=card.ability.extra.mult_per_card_scored,
                }
            end
            if context.joker_main then
                return {
                    mult=card.ability.extra.mult,
                }
            end
        end,
        loc_vars = function (self,info_queue,card)
            return {
                vars={
                    card.ability.extra.mult_per_card_scored,
                    card.ability.extra.mult_gain,
                    card.ability.extra.mult,
                }
            }
        end,
        bfs_credits = {
            idea = { "Maple" },
            art = { "Maple" },
            code = { "Lact4???" }
        },
    }
}

local mathematician = {
    key = "mathematician",
    name = "Mathematician",
    input = {
        "j_scholar",
        "j_fibonacci",
    },
    joker = {
        config = {
            extra = {
                repetitions = 1,
                chips = 21,
                mult = 13,
            }
        },
        pos = { x = 4, y = 2 },
        blueprint_compat = true,
        atlas = "joker",
        loc_vars = function(self, info_queue, card)
            return { vars = {
                card.ability.extra.chips,
                card.ability.extra.mult
            } }
        end,
        calculate = function(self, card, context)
            if context.repetition and context.cardarea == G.play then
                if context.other_card:get_id() == 14 then
                    return {
                        repetitions = card.ability.extra.repetitions,
                        message = localize("k_again_ex"),
                        extra = {
                            chips = card.ability.extra.chips,
                            mult = card.ability.extra.mult,
                        },
                        card = card
                    }
                elseif BalatroFusion.check_fibonacci_rank(context.other_card) then
                    return {
                        chips = card.ability.extra.chips,
                        mult = card.ability.extra.mult,
                    }
                end
            elseif context.individual and context.cardarea == G.play then
                if BalatroFusion.check_fibonacci_rank(context.other_card) then
                    return {
                        chips = card.ability.extra.chips,
                        mult = card.ability.extra.mult,
                    }
                end
            end
        end,
        bfs_credits = {
            idea = { "ButterStutter" },
            art = { "MRJames246" },
            code = { "ButterStutter" }
        }
    }
}

local nature_spiral = {
    key = "nature_spiral",
    name = "Nature Spiral",
    input = {
        "j_pareidolia",
        "j_fibonacci",
    },
    joker = {
        config = { extra = { mult = 8 } },
        pos = { x = 0, y = 0 },
        blueprint_compat = true,
        atlas = "placeholder",
        loc_vars = function(self, info_queue, card)
            return { vars = {
                card.ability.extra.mult
            } }
        end,
        calculate = function(self, card, context)
            if context.individual and context.cardarea == G.play then
                if BalatroFusion.check_fibonacci_rank(context.other_card) then
                    return {
                        mult = card.ability.extra.mult,
                    }
                end
            end
        end,
        bfs_credits = {
            idea = { "ButterStutter" },
            code = { "ButterStutter" }
        }
    }
}

local fibonabstracti = {
    key = "fibonabstracti",
    name = "Fibonabstracti",
    input = {
        "j_abstract",
        "j_fibonacci",
    },
    joker = {
        config = { extra = { } },
        pos = { x = 0, y = 0 },
        blueprint_compat = true,
        atlas = "placeholder",
        loc_vars = function(self, info_queue, card)
            return { vars = {
                count_fibonacci(1 + (G and G.jokers and #G.jokers.cards or 0))
            } }
        end,
        calculate = function(self, card, context)
            if context.individual and context.cardarea == G.play then
                if BalatroFusion.check_fibonacci_rank(context.other_card) then
                    local mult = count_fibonacci(1 + (G and G.jokers and #G.jokers.cards or 0))
                    return {
                        mult = mult
                    }
                end
            end
        end,
        bfs_credits = {
            idea = { "The Wheel", "ButterStutter" },
            code = { "ButterStutter" }
        }
    }
}

local helix = {
    key = "helix",
    name = "Helix",
    input = {
        "j_dna",
        "j_fibonacci",
    },
    joker = {
        config = { extra = { waiting_fibonacci_rank = false } },
        pos = { x = 0, y = 0 },
        blueprint_compat = true,
        atlas = "placeholder",
        loc_vars = function(self, info_queue, card)
            return { vars = {
            } }
        end,
        calculate = function(self, card, context)
            if context.first_hand_drawn and not context.blueprint then
                card.ability.extra.waiting_fibonacci_rank = true
                local eval = function(_card) return _card.ability.extra.waiting_fibonacci_rank end
                juice_card_until(card, eval)
            elseif context.before and card.ability.extra.waiting_fibonacci_rank then
                for _, v in ipairs(context.full_hand) do
                    if BalatroFusion.check_fibonacci_rank(v) then
                        card.ability.extra.waiting_fibonacci_rank = false
                        local _card = copy_card(v, nil, nil, G.playing_card)
                        _card:add_to_deck()
                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                        table.insert(G.playing_cards, _card)
                        G.hand:emplace(_card)
                        _card.states.visible = nil

                        G.E_MANAGER:add_event(Event({
                            func = function()
                                _card:start_materialize()
                                return true
                            end
                        }))
                        return {
                            message = localize('k_copied_ex'),
                            colour = G.C.CHIPS,
                            card = card,
                            playing_cards_created = {_card}
                        }
                    end
                end
            end
        end,
        bfs_credits = {
            idea = { "ButterStutter" },
            code = { "ButterStutter" }
        }
    }
}

local calculated_gambling = {
    key = "calculated_gambling",
    name = "Caclulate Gambling",
    input = {
        "j_shoot_the_moon",
        "j_fibonacci",
    },
    joker = {
        config = { extra = { mult = 13 } },
        pos = { x = 0, y = 0 },
        blueprint_compat = true,
        atlas = "placeholder",
        loc_vars = function(self, info_queue, card)
            return { vars = {
                card.ability.extra.mult
            } }
        end,
        calculate = function(self, card, context)
            if context.individual and context.cardarea == G.play and BalatroFusion.check_fibonacci_rank(context.other_card) then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end,
        bfs_credits = {
            idea = { "ButterStutter" },
            code = { "ButterStutter" }
        }
    }
}

local incorrect_math = {
    key = "incorrect_math",
    name = "Incorrect Math",
    input = {
        "j_red_card",
        "j_fibonacci",
    },
    joker = {
        config = { extra = { skipped = 1 } },
        pos = { x = 0, y = 0 },
        blueprint_compat = true,
        atlas = "placeholder",
        loc_vars = function(self, info_queue, card)
            return { vars = {
                count_fibonacci(card.ability.extra.skipped),
                count_fibonacci(card.ability.extra.skipped + 1)
            } }
        end,
        calculate = function(self, card, context)
            if context.skipping_booster then
                card.ability.extra.skipped = card.ability.extra.skipped + 1
                return {
                    message = count_fibonacci(card.ability.extra.skipped).." Mult!"
                }
            elseif context.joker_main then
                return {
                    mult = count_fibonacci(card.ability.extra.skipped)
                }
            end
        end,
        bfs_credits = {
            idea = { "ButterStutter" },
            code = { "ButterStutter" }
        }
    }
}

return {
    ouroboros,
    mathematician,
    nature_spiral,
    fibonabstracti,
    helix,
    calculated_gambling,
    incorrect_math
}