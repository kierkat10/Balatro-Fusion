SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "droll_todd",
    name = "Droll Todd",
    input = {
        "j_odd_todd",
        "j_droll",
    },
    output = "j_bfs_droll_todd"
})

SMODS.Joker {
    key = "droll_todd",
    name = "Droll Todd",
    config = {},
    pos = { x = 2, y = 2 },
    cost = 10,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "joker",
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main and next(context.poker_hands["Flush"]) then
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
                    mult = 23
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