SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "mad_steven",
    name = "Mad Steven",
    input = {
        "j_even_steven",
        "j_mad",
    },
    output = "j_bfs_mad_steven"
})

SMODS.Joker {
    key = "mad_steven",
    name = "Mad Steven",
    config = {},
    pos = { x = 9, y = 1 },
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
            local pair_count = 0
            for _, v in pairs(tp_ranks) do 
                if v == 2 or v == 4 or v == 6 or v == 8  or v == 10 then
                    pair_count = pair_count + 1
                end
            end
            if pair_count >= 2 then 
                return {
                    mult = 22
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