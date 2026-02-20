return {
    key = "green_card",
    name = "Green Card",
    input = {
        "j_green_joker",
        "j_red_card",
    },
    joker = {
        config = {
            extra = {
                mult = 0,
                scaling_increment = 5
            }
        },
        pos = { x = 6, y = 3 },
        blueprint_compat = true,
        atlas = "joker",
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    card.ability.extra.scaling_increment,
                    2*card.ability.extra.scaling_increment,
                    card.ability.extra.mult
                }
            }
        end,
        calculate = function(self, card, context)
            if context.skipping_booster then
                card.ability.extra.mult = card.ability.extra.mult + 2 * card.ability.extra.scaling_increment
                return {
                    message = "+"..2 * card.ability.extra.scaling_increment.." Mult!",
                    colour = G.C.RED,
                }
            elseif (context.card_added or context.playing_card_added or context.using_consumeable) and G.STATE == G.STATES.SMODS_BOOSTER_OPENED then
                local type = SMODS.OPENED_BOOSTER.config.center.kind
                if (type == "Arcana" or type == "Celestial" or type == "Spectral") and not context.using_consumeable then return {} end
                if card.ability.extra.mult >= card.ability.extra.scaling_increment then
                    card.ability.extra.mult = card.ability.extra.mult - card.ability.extra.scaling_increment
                    return {
                        message = "-"..card.ability.extra.scaling_increment.." Mult",
                        colour = G.C.RED,
                    }
                elseif card.ability.extra.mult ~= 0 then
                    local decrease = card.ability.extra.mult
                    card.ability.extra.mult = 0
                    return {
                        message = "-"..decrease.." Mult",
                        colour = G.C.RED,
                    }
                end
            elseif context.joker_main and card.ability.extra.mult ~= 0 then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end,
        bfs_credits = {
            idea = { "ButterStutter" },
            art = { "ButterStutter" },
            code = { "ButterStutter" }
        }
    }
}