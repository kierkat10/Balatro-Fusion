return {
    key = "crazy_todd",
    name = "Crazy Todd",
    input = {
        "j_odd_todd",
        "j_crazy",
    },
    joker = {
        config = { extra = { mult = 25 } },
        pos = { x = 3, y = 2 },
        blueprint_compat = true,
        atlas = "basic-joker",
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.mult } }
        end,
        calculate = function(self, card, context)
            if context.joker_main and next(context.poker_hands["Straight"]) then
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
                        mult = card.ability.extra.mult
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