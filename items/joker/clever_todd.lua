return {
    key = "clever_todd",
    name = "Clever Todd",
    input = {
        "j_clever",
        "j_odd_todd"
    },
    joker =  {
        config = { extra = { chips = 135 } },
        pos = { x = 7, y = 2 },
        blueprint_compat = true,
        atlas = "basic-joker",
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.chips } }
        end,
        calculate = function(self, card, context)
            if context.joker_main then
                local tp_ranks = {}
                for i = 2, 13 do 
                    local count = 0
                    for _, v in ipairs(context.scoring_hand) do 
                        if v:get_id() == i then
                            count = count + 1
                        end
                    end
                    if count >= 2 then 
                        tp_ranks[#tp_ranks+1] = i
                    end
                end
                local two_pair_count = 0
                for _, v in pairs(tp_ranks) do 
                    if v == 3 or v == 5 or v == 7 or v == 9 or v == 14 then
                        two_pair_count = two_pair_count + 1
                    end
                end
                if two_pair_count >= 2 then 
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