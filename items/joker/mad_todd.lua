SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "mad_todd",
    name = "Mad Todd",
    input = {
        "j_odd_todd",
        "j_mad",
    },
    output = "j_bfs_mad_todd"
})

SMODS.Joker {
    key = "mad_todd",
    name = "Mad Todd",
    config = {},
    pos = { x = 8, y = 1 },
    cost = 9,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "joker",
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
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
                if v == 3 or v == 5 or v == 7 or v == 9  or v == 14 then
                    two_pair_count = two_pair_count + 1
                end
            end
            if two_pair_count >= 2 then 
                return {
                    mult = 21
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