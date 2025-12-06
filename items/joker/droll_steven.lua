SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "droll_steven",
    name = "Droll Steven",
    input = {
        "j_droll",
        "j_even_steven"
    },
    output = "j_bfs_droll_steven"
})

SMODS.Joker {
    key = "droll_steven",
    name = "Droll Steven",
    config = { extra = { mult = 24 } },
    pos = { x = 3, y = 2 },
    cost = 8,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands["Flush"]) then
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