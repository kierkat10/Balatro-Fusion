return {
    key = "devious_steven",
    name = "Devious Steven",
    input = {
        "j_even_steven",
        "j_devious",
    },
    joker = {
        config = { extra = { chips = 136 } },
        pos = { x = 8, y = 3 },
        blueprint_compat = true,
        atlas = "basic-joker",
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.chips } }
        end,  
        calculate = function(self, card, context)
            if context.joker_main and next(context.poker_hands["Straight"]) then
                local even_count = 0
                local not_even_count = 0
                for _, v in ipairs(context.scoring_hand) do 
                    if v:get_id() == 2 or v:get_id() == 4 or v:get_id() == 6 or v:get_id() == 8 or v:get_id() == 10 then
                        even_count = even_count + 1
                    else
                        not_even_count = not_even_count + 1
                    end
                end
                if even_count > not_even_count then 
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