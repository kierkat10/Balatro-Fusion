return {
    key = "mad_steven",
    name = "Mad Steven",
    input = {
        "j_even_steven",
        "j_mad"
    },
    joker = {
        config = { extra = { mult = 22 } },
        pos = { x = 2, y = 3 },
        blueprint_compat = true,
        atlas = "basic-joker",
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.mult } }
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
                local pair_count = 0
                for _, v in pairs(tp_ranks) do 
                    if v == 2 or v == 4 or v == 6 or v == 8 or v == 10 then
                        pair_count = pair_count + 1
                    end
                end
                if pair_count >= 2 then 
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