return {
    key = "loose_cannon",
    name = "Loose Cannon",
    input = {
        "j_chaos",
        "j_loyalty_card",
    },
    joker = {
        config = { extra = { reroll_req = 3, counter = 0 } },
        pos = { x = 0, y = 0 },
        blueprint_compat = false,
        atlas = "placeholder",
        loc_vars = function(self, info_queue, card)
            local reroll_req = card.ability.extra.reroll_req + 1
            local remaining = card.ability.extra.reroll_req - card.ability.extra.counter
            local number_position_texts = {
                [1] = "st",
                [2] = "nd",
                [3] = "rd",
                [4] = "th"
            }
            local text = number_position_texts[reroll_req % 10 <= 3 and reroll_req % 10 > 0 and reroll_req % 10 or 4]
            return {
                vars = {
                    reroll_req,
                    text,
                    remaining
                }
            }
        end,
        calculate = function(self, card, context)
            if context.reroll_shop then
                if card.ability.extra.counter == card.ability.extra.reroll_req then
                    card.ability.extra.counter = 0
                else
                    card.ability.extra.counter = card.ability.extra.counter + 1
                    if card.ability.extra.counter == card.ability.extra.reroll_req then
                        G.GAME.current_round.reroll_cost = 0
                        G.GAME.current_round.reroll_cost_increase = G.GAME.current_round.reroll_cost_increase - 1
                        return {
                            message = "Free Reroll!",
                            colour = G.C.GREEN
                        }
                    end
                end
            elseif context.starting_shop and card.ability.extra.counter == card.ability.extra.reroll_req then
                G.GAME.current_round.reroll_cost = 0
                G.GAME.current_round.reroll_cost_increase = G.GAME.current_round.reroll_cost_increase - 1
                return {
                    message = "Free Reroll!",
                    colour = G.C.GREEN
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