SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "zany_todd",
    name = "Zany Todd",
    input = {
        "j_odd_todd",
        "j_zany",
    },
    output = "j_bfs_zany_todd"
})

SMODS.Joker {
    key = "zany_todd",
    name = "Zany Todd",
    config = {},
    pos = { x = 6, y = 1 },
    cost = 8,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "joker",
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            local toak_ranks = {}
            for i = 2, 13 do 
                local count = 0
                for _, v in ipairs(context.scoring_hand) do 
                    if v:get_id() == i then
                        count = count + 1
                    end
                end
                if count >= 3 then 
                    toak_ranks[#toak_ranks+1] = i
                end
            end
            local succeeds = false
            for _, v in pairs(toak_ranks) do 
                if v == 3 or v == 5 or v == 7 or v == 9  or v == 14 then
                    succeeds = true
                    break
                end
            end
            if succeeds then 
                return {
                    mult = 19
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