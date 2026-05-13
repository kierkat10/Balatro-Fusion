return {
    key = "beanstalk",
    name = "Magic Beanstalk",
    input = {
        "j_turtle_bean",
        "j_rocket",
    },
    joker = {
        config = {
            extra = {
                hand_size = 0,
                hand_size_gain = 1,
                dollars_gain = 1,
                dollars = 0
            }
        },
        pos = { x = 0, y = 0 },
        blueprint_compat = false,
        atlas = "placeholder",
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    card.ability.extra.dollars_gain,
                    card.ability.extra.hand_size,
                    card.ability.extra.hand_size_gain
                }
            }
        end,
        calc_dollar_bonus = function(self, card)
            local dollars = card.ability.extra.dollars
            return dollars > 0 and dollars or nil
        end,
        calculate = function(self, card, context)
            if context.setting_blind then
                card.ability.extra.dollars = 0
            end
            if context.end_of_round and not context.blueprint then
                if context.individual and context.cardarea == G.hand and not context.retrigger then
                    card.ability.extra.dollars = card.ability.extra.dollars + card.ability.extra.dollars_gain
                elseif context.end_of_round and G.GAME.blind.boss and not (context.individual or context.repetition) then
                    card.ability.extra.hand_size = card.ability.extra.hand_size + card.ability.extra.hand_size_gain
                    G.hand:change_size(card.ability.extra.hand_size_gain)
                    return {
                        message = "+"..card.ability.extra.hand_size_gain.."Hand Size!",
                        colour = G.C.ORANGE
                    }
                end
            end
        end,
        remove_from_deck = function(self, card, from_debuff)
            if card.ability.extra.hand_size > 0 then
                G.hand:change_size(-card.ability.extra.hand_size)
            end
        end,        
        bfs_credits = {
            art = { "" },
            idea = { "ButterStutter" },
            code = { "ButterStutter" }
        }
    }
}