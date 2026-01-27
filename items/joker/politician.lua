return {
    key = "politician",
    name = "Politician",
    input = {
        "j_hack",
        "j_hanging_chad"
    },
    joker = {
        config = { extra = { repetitions = 2 } },
        pos = { x = 0, y = 1 },
        blueprint_compat = true,
        atlas = "joker",
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.repetitions } }
        end,
        calculate = function(self, card, context)
            if context.repetition and context.cardarea == G.play then
                if context.other_card:get_id() == 2 or context.other_card:get_id() == 3 or context.other_card:get_id() == 4 or context.other_card:get_id() == 5 then
                    return {
                        repetitions = card.ability.extra.repetitions
                    }
                end
            end
        end,
        bfs_credits = {
            idea = { "SnowPickle" },
            art = { "Nice Cream" },
            code = { "Glitchkat10" }
        }
    }
}