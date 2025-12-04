SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "jolly_steven",
    name = "Jolly Steven",
    input = {
        "j_even_steven",
        "j_jolly",
    },
    output = "j_bfs_jolly_steven"
})

SMODS.Joker {
    key = "jolly_steven",
    name = "Jolly Steven",
    config = {},
    pos = { x = 5, y = 1 },
    cost = 8,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "joker",
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            local pair_ranks = {}
            for i = 2, 13 do 
                local count = 0
                for _, v in ipairs(context.scoring_hand) do 
                    if v:get_id() == i then
                        count = count + 1
                    end
                end
                if count >= 2 then 
                    pair_ranks[#pair_ranks+1] = i
                end
            end
            local succeeds = false
            for _, v in pairs(pair_ranks) do 
                if v == 2 or v == 4 or v == 6 or v == 8  or v == 10 then
                    succeeds = true
                    break
                end
            end
            if succeeds then 
                return {
                    mult = 14
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