return {
    key = "crafty_todd",
    name = "Crafty Todd",
    input = {
        "j_odd_todd",
        "j_crafty",
    },
    joker = {
        config = { extra = { chips = 163 } },
        pos = { x = 9, y = 2 },
        blueprint_compat = true,
        atlas = "basic-joker",
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.chips } }
        end,
        calculate = function(self, card, context)
            if context.joker_main and next(context.poker_hands["Flush"]) then
                local odd_count = 0
                local not_odd_count = 0
                for _, v in ipairs(context.scoring_hand) do 
                    if v:get_id() == 3 or v:get_id() == 5 or v:get_id() == 7 or v:get_id() == 9 or v:get_id() == 14 then
                        odd_count = odd_count + 1
                    else
                        not_odd_count = not_odd_count + 1
                    end
                end
                if odd_count > not_odd_count then 
                    return {
                        chips = card.ability.extra.chips
                    }
                end
            end
        end,
        bfs_credits = {
            idea = { "ButterStutter" },
            art = { "ButterStutter" },
            code = { "ButterStutter" }
        }
    }
}