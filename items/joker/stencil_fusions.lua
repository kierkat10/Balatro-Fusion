local function check_joker(joker)
    if joker.config.center.key == "j_stencil" then
        return false
    elseif joker.config.center.rarity ~= "bfs_fused" then
        return true
    end
    local fusion_inputs = SMODS.BalatroFusion.Fusion:get_input_jokers(joker.config.center.key)
    if not fusion_inputs then return true end
    for _, v in ipairs(fusion_inputs) do
        if v.target == "j_stencil" then
            return false
        end
    end
    -- Implement "joker" in name exception + pareidolia fusion
    -- Implement cost less than $5 exception + vagabond
    -- Implement exceptions when stencil fusions that use the exceptions are added
    return true
end

local function check_consumable(consumable)
    -- Implement exceptions when stencil fusions that use the exceptions are added
    return true
end

local function check_playing_card(card, exceptions)
    -- Implement exceptions when stencil fusions that use the exceptions are added
    return true
end

function BalatroFusion.get_gap_count_for_card_area(card_areas) -- {location, type}
    local total_gaps = 0
    local area_functions = {
        joker = function(v) return check_joker(v) end,
        consumable = function(v) return check_consumable(v) end,
        playing_card = function(v) return check_playing_card(v) end
        -- possibly add other types if they get used
    }
    local areas = {
        jokers = (G.jokers and G.jokers.cards or {}),
        consumables = (G.consumeables and G.consumeables.cards or {}),
        deck = (G.deck and G.deck.cards or {})
        -- add playing card areas
    }
    local sizes = {
        jokers = (G.jokers and G.jokers.config and G.jokers.config.card_limit or 5),
        consumables = (G.consumeables and G.consumeables.config and G.consumeables.config.card_limit or 2),
        deck = (G.deck and G.deck.config and G.deck.config.card_limit or 52)
        -- add playing card areas
    }

    for _, area in ipairs(card_areas) do
        local area_filled_gaps = 0
        for _, v in pairs(areas[area.location]) do
            if area_functions[area.type](v) then
                area_filled_gaps = area_filled_gaps + 1
            end
        end
        local area_gaps = sizes[area.location] - area_filled_gaps
        total_gaps = area_gaps + total_gaps
    end

    return total_gaps
end

local jigsaw = {
    key = "jigsaw",
    name = "Jigsaw Joker",
    input = { "j_stencil", "j_stencil" },
    joker = {
        config = {
            extra = {
                xmult = 1.2,
                card_areas = {
                    { location = "jokers", type = "joker" },
                    { location = "consumables", type = "consumable" }
                }
            }
        },
        pos = { x = 3, y = 2 },
        blueprint_compat = true,
        atlas = "joker",
        loc_vars = function(self, info_queue, card)
            return { vars = {
                card.ability.extra.xmult,
                card.ability.extra.xmult * BalatroFusion.get_gap_count_for_card_area(card.ability.extra.card_areas)
            }}
        end,
        calculate = function(self, card, context)
            if context.joker_main then
                local xmult = card.ability.extra.xmult * BalatroFusion.get_gap_count_for_card_area(card.ability.extra.card_areas)
                if xmult ~= 1 then
                    return {
                        xmult = xmult
                    }
                end
            end
        end,
        credits = {
            idea = { "ButterStutter" },
            art = { "King" },
            code = { "ButterStutter" }
        }
    }
}

local blue_stencil = {
    key = "blue_stencil",
    name = "Blue Stencil",
    input = { "j_stencil", "j_blue_joker" },
    joker = {
        config = {
            extra = {
                xchips = 0.04,
                card_areas = {
                    { location = "deck", type = "playing_card" },
                }
            }
        },
        pos = { x = 4, y = 1 },
        blueprint_compat = true,
        atlas = "joker",
        loc_vars = function(self, info_queue, card)
            return { vars = {
                card.ability.extra.xchips,
                1 + card.ability.extra.xchips * BalatroFusion.get_gap_count_for_card_area(card.ability.extra.card_areas)
            }}
        end,
        calculate = function(self, card, context)
            if context.joker_main then
                local xchips = 1 + card.ability.extra.xchips * BalatroFusion.get_gap_count_for_card_area(card.ability.extra.card_areas)
                if xchips ~= 1 then
                    return {
                        xchips = xchips
                    }
                end
            end
        end,
        credits = {
            idea = { "ButterStutter" },
            art = { "The Wheel" },
            code = { "ButterStutter" }
        }
    }
}

local ice_cream_cone = {
    key = "ice_cream_cone",
    name = "Ice Cream Cone",
    input = { "j_stencil", "j_ice_cream" },
    joker = {
        config = {
            extra = {
                chips = 50,
                card_areas = {
                    { location = "jokers", type = "joker" },
                }
            }
        },
        pos = { x = 5, y = 3 },
        atlas = "joker",
        blueprint_compat = true,
        loc_vars = function(self, info_queue, card)
            return { vars = {
                card.ability.extra.chips,
                card.ability.extra.chips * BalatroFusion.get_gap_count_for_card_area(card.ability.extra.card_areas)
            }}
        end,
        calculate = function(self, card, context)
            if context.joker_main then
                local chips = card.ability.extra.chips * BalatroFusion.get_gap_count_for_card_area(card.ability.extra.card_areas)
                if chips ~= 0 then
                    return {
                        chips = chips
                    }
                end
            end
        end,
        credits = {
            idea = { "ButterStutter" },
            art = { "ButterStutter" },
            code = { "ButterStutter" }
        }
    }
}

local eggshells = {
    key = "eggshell",
    name = "Eggshell",
    input = { "j_stencil", "j_egg" },
    joker = {
        config = {
            extra = {
                value_gain = 2,
                card_areas = {
                    { location = "jokers", type = "joker" },
                }
            }
        },
        pos = { x = 0, y = 0 },
        atlas = "placeholder",
        blueprint_compat = false,
        loc_vars = function(self, info_queue, card)
            return { vars = {
                card.ability.extra.value_gain,
                card.ability.extra.value_gain * BalatroFusion.get_gap_count_for_card_area(card.ability.extra.card_areas)
            }}
        end,
        calculate = function(self, card, context)
            if context.end_of_round and context.game_over == false and not context.blueprint and context.main_eval then
                local sell_value_gain = card.ability.extra.value_gain * BalatroFusion.get_gap_count_for_card_area(card.ability.extra.card_areas)
                card.ability.extra_value = (card.ability.extra_value or 0) + sell_value_gain
                card:set_cost()
                return {
                    message = "+"..tostring(sell_value_gain).." Sell Value"
                }
            end
        end,
        credits = {
            idea = { "ButterStutter" },
            code = { "ButterStutter" }
        }
    }
}

return {
    jigsaw,
    blue_stencil,
    ice_cream_cone,
    eggshells
}