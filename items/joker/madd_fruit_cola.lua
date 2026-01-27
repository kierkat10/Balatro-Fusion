return {
    key = "madd_fruit_cola",
    name = "Madd Fruit Cola",
    input = {
        "j_diet_cola",
        "j_mad",
    },
    joker = {
        config = { extra = { odds = 4 } },
        pos = { x = 2, y = 1 },
        blueprint_compat = true,
        atlas = "basic-joker",
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue+1] = G.P_TAGS.tag_double
            local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "j_bfs_madd_fruit_cola")
            return {
                vars = {
                    numerator,
                    denominator
                }
            }
        end,
        calculate = function(self, card, context)
            if context.after and next(context.poker_hands["Two Pair"]) and SMODS.pseudorandom_probability(card, "j_bfs_madd_fruit_cola", 1, card.ability.extra.odds) then
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.5,
                    func = function()     
                        local tag = G.P_TAGS["tag_double"]
                        add_tag(tag)
                        return true
                    end,
                }))
                return {
                    message = "Double Tag!",
                    colour = G.C.Blue
                }
            end
        end,
        bfs_credits = {
            art = { "Nice Cream" },
            idea = { "The Wheel" },
            code = { "ButterStutter" }
        }
    }
}