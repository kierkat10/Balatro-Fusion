return {
    key = "stop_sign",
    name = "Stop Sign",
    input = {
        "j_red_card",
        "j_reserved_parking",
    },
    joker = {
        config = {
            extra = {
                booster_count = 0,
                booster_increase = 1,
                odds = 2,
            },
        },
        pos = { x = 2, y = 11 },
        blueprint_compat = true,
        atlas = "joker",
        loc_vars = function(self, info_queue, card)
            local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "j_bfs_stop_sign")
            return {
                vars = { 
                    numerator,
                    denominator,
                    card.ability.extra.booster_count,
                    card.ability.extra.booster_increase,
                } 
            }
        end,
        calculate = function(self, card, context)
            if context.individual and context.cardarea == G.hand and context.other_card:is_face() and not context.end_of_round and SMODS.pseudorandom_probability(card, "j_bfs_stop_sign", 1, card.ability.extra.odds) then
                card.ability.extra.booster_count = card.ability.extra.booster_count + card.ability.extra.booster_increase
                return {
                    message = "+"..card.ability.extra.booster_increase.." Booster!"
                }
            end
            if context.starting_shop and card.ability.extra.booster_count > 0 then
                local count = card.ability.extra.booster_count
                local message = "+"..count.." Booster"
                if count ~= 1 then
                    message = message.."s"
                end
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    func = function()
                        for _ = 1, card.ability.extra.booster_count do
                            SMODS.add_booster_to_shop()
                        end
                        card.ability.extra.booster_count = 0
                        return true
                    end,
                }))
                return {
                    message = message.."!",
                    colour = G.C.Blue
                }
            end
        end,
        bfs_credits = {
            art = { "Jammuu" },
            idea = { "mechaclownking" },
            code = { "ButterStutter" },
        }
    }
}