local function adjust_play_limit(card)
    if card:is_suit("Diamonds") and next(SMODS.find_card("j_bfs_clam")) then
        return true
    end
    if card:is_suit("Hearts") and next(SMODS.find_card("j_bfs_seashell")) then
        return true
    end
    if card:is_suit("Clubs") and next(SMODS.find_card("j_bfs_oyster")) then
        return true
    end
    if card:is_suit("Spades") and next(SMODS.find_card("j_bfs_conch_shell")) then
        return true
    end
    if SMODS.has_enhancement(card, "m_glass") and next(SMODS.find_card("j_bfs_message_bottle")) then
        return true
    end
    if SMODS.has_enhancement(card, "m_wild") and next(SMODS.find_card("j_bfs_algae")) then
        return true
    end
    if card:get_id() == "2" and next(SMODS.find_card("j_bfs_droplet")) then
        return true
    end
end

local function adjust_discard_limit(card)
    if card:is_suit("Diamonds") and next(SMODS.find_card("j_bfs_clam")) then
        return true
    end
    if card:is_suit("Hearts") and next(SMODS.find_card("j_bfs_seashell")) then
        return true
    end
    if card:is_suit("Clubs") and next(SMODS.find_card("j_bfs_oyster")) then
        return true
    end
    if card:is_suit("Spades") and next(SMODS.find_card("j_bfs_conch_shell")) then
        return true
    end
    if card.config.center.key == "c_base" and next(SMODS.find_card("j_bfs_leviathan")) then
        return true
    end
end

function BalatroFusion.adjust_play_limits(card, method)
    local play_size_change = adjust_play_limit(card)
    local discard_size_change = adjust_discard_limit(card)

    if play_size_change then SMODS.change_play_limit(method) end
    if discard_size_change then SMODS.change_discard_limit(method) end
end

local function generate_shell_fusion(input, key, name, suit)
    local c = suit == "Clubs"
    local h = suit == "Hearts"
    local d = suit == "Diamonds"
    local s = suit == "Spades"

    return {
        key = key,
        name = name,
        input = {
            "j_splash",
            input,
        },
        joker = {
            config = {
                extra = {
                    xmult = h and 1.4 or nil,
                    mult = c and 10 or nil,
                    chips = s and 65 or nil,
                    xchips = d and 1.2 or nil,
                    dollars = d and 1 or nil,
                }
            },
            pos = { x = 0, y = 0 },
            blueprint_compat = true,
            atlas = "placeholder",
            loc_vars = function(self, info_queue, card)
                if s then return { vars = {card.ability.extra.chips} } end
                if h then return { vars = {card.ability.extra.xmult} } end
                if c then return { vars = {card.ability.extra.mult} } end
                if d then return { vars = {card.ability.extra.dollars, card.ability.extra.xchips} } end
            end,
            calculate = function(self, card, context)
                if context.individual and context.cardarea == G.play and context.other_card and context.other_card:is_suit(suit) then
                    if s then return { chips = card.ability.extra.chips } end
                    if h then return { xmult = card.ability.extra.xmult } end
                    if c then return { mult = card.ability.extra.mult } end
                    if d then return { dollars = card.ability.extra.dollars, xchips = card.ability.extra.xchips } end
                elseif context.modify_scoring_hand and context.other_card:is_suit(suit) then
                    return { add_to_hand = true }
                end
            end,
            bfs_credits = {
                art = { "" },
                idea = { "ButterStutter" },
                code = { "ButterStutter" }
            }
        }
    }
end

local message_bottle = {
    key = "message_bottle",
    name = "Message in a Bottle",
    input = {
        "j_splash",
        "j_glass",
    },
    joker = {
        pos = { x = 0, y = 0 },
        blueprint_compat = false,
        atlas = "placeholder",
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue+1] = G.P_CENTERS.m_glass
        end,
        calculate = function(self, card, context)
            if context.ignore_debuff and SMODS.has_enhancement(context.debuff_card, "m_glass") then
                return { prevent_debuff = true }
            end
            if context.modify_scoring_hand and SMODS.has_enhancement(context.other_card, "m_glass") then
                return { add_to_hand = true }
            end
        end,
        bfs_credits = {
            art = { "" },
            idea = { "ButterStutter" },
            code = { "ButterStutter" }
        }
    }
}

local algae = {
    key = "algae",
    name = "Algae",
    input = {
        "j_splash",
        "j_flower_pot",
    },
    joker = {
        pos = { x = 0, y = 0 },
        blueprint_compat = false,
        atlas = "placeholder",
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue+1] = G.P_CENTERS.m_wild
        end,
        calculate = function(self, card, context)
            if context.ignore_debuff and SMODS.has_enhancement(context.debuff_card, "m_wild") then
                return { prevent_debuff = true }
            end
            if context.modify_scoring_hand and SMODS.has_enhancement(context.other_card, "m_wild") then
                return { add_to_hand = true }
            end
        end,
        bfs_credits = {
            art = { "" },
            idea = { "ButterStutter" },
            code = { "ButterStutter" }
        }
    }
}

local leviathan = {
    key = "leviathan",
    name = "Leviathan",
    input = {
        "j_splash",
        "j_vampire",
    },
    joker = {
        config = {
            extra = {
                xmult = 1,
                xmult_gain = 0.1,
            }
        },
        pos = { x = 0, y = 0 },
        blueprint_compat = true,
        atlas = "placeholder",
        loc_vars = function(self, info_queue, card)
            return { vars = {
                card.ability.extra.xmult_gain,
                card.ability.extra.xmult
            }}
        end,
        calculate = function(self, card, context)
            if context.ignore_debuff and context.debuff_card.config.center.key == "c_base" then
                return { prevent_debuff = true }
            end
            if context.discard and context.other_card.config.center.key == "c_base" and not context.blueprint then
                card.ability.extra.xmult = card.ability.extra.xmult_gain + card.ability.extra.xmult
                return {
                    message = "X"..card.ability.extra.xmult.." Mult!",
                    colour = G.C.RED
                }
            end
            if context.individual and context.cardarea == G.play and context.other_card.config.center.key == "c_base" then
                return { xmult = card.ability.extra.xmult }
            end
        end,
        bfs_credits = {
            art = { "" },
            idea = { "ButterStutter" },
            code = { "ButterStutter" }
        }
    }
}

local droplet = {
    key = "droplet",
    name = "Droplet",
    input = {
        "j_splash",
        "j_wee",
    },
    joker = {
        config = {
            extra = {
                chips = 0,
                chips_gain = 10,
            }
        },
        pos = { x = 0, y = 0 },
        blueprint_compat = true,
        atlas = "placeholder",
        loc_vars = function(self, info_queue, card)
            return { vars = {
                card.ability.extra.chips_gain,
                card.ability.extra.chips
            }}
        end,
        calculate = function(self, card, context)
            if context.joker_main then
                if card.ability.extra.chips > 0 then
                    return {
                        chips = card.ability.extra.chips
                    }
                end
            end
            if context.modify_scoring_hand and context.other_card:get_id() == 2 then
                return { add_to_hand = true }
            end
            if context.individual and context.cardarea == G.play and context.other_card:get_id() == 2 and not context.blueprint then
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_gain
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "+"..card.ability.extra.chips.." Chips!", colour = G.C.BLUE})
            end
        end,
        bfs_credits = {
            art = { "" },
            idea = { "ButterStutter" },
            code = { "ButterStutter" }
        }
    }
}

return {
    generate_shell_fusion("j_rough_gem", "clam", "Clam", "Diamonds"),
    generate_shell_fusion("j_bloodstone", "seashell", "Seashell", "Hearts"),
    generate_shell_fusion("j_arrowhead", "conch_shell", "Conch Shell", "Spades"),
    generate_shell_fusion("j_onyx_agate", "oyster", "Oyster", "Clubs"),
    message_bottle,
    algae,
    leviathan,
    droplet
}