return {
    key = "golden_record",
    name = "Golden Record",
    input = {
        "j_obelisk",
        "j_space"
    },
    joker = {
        config = {
            extra = {
                odds = 2,
                odds2 = 5
            }
        },
        pos = { x = 2, y = 0 },
        blueprint_compat = true,
        atlas = "joker",
        loc_vars = function(self, info_queue, card)
            local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "j_bfs_golden_record")
            local numerator2, denominator2 = SMODS.get_probability_vars(card, 1, card.ability.extra.odds2, "j_bfs_golden_record")
            return {
                vars = {
                    numerator,
                    denominator,
                    numerator2,
                    denominator2
                }
            }
        end,
        calculate = function(self, card, context)
            if context.joker_main then
                if SMODS.pseudorandom_probability(card, "j_bfs_golden_record", 1, card.ability.extra.odds) then
                    return {
                        level_up = true,
                        message = localize("k_level_up_ex")
                    }
                end
                if SMODS.pseudorandom_probability(card, "j_bfs_golden_record", 1, card.ability.extra.odds2) then
                    local target_hand = (context.scoring_name or "High Card")
                    local total = 0
                    for hand, value in pairs(G.GAME.hands) do
                        if to_big(value.level) >= to_big(1) then
                            total = total + value.level
                        end
                    end
                    return {
                        level_up = total,
                        level_up_hand = target_hand,
                        message = localize("k_level_up_ex")
                    }
                end
            end
        end,
        bfs_credits = {
            code = { "Glitchkat10" }
        }
    }
}