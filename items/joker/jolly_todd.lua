SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "jolly_todd",
    name = "Jolly Todd",
    input = {
        "j_jolly",
        "j_odd_todd"
    },
    output = "j_bfs_jolly_todd"
})

SMODS.Joker {
    key = "jolly_todd",
    name = "Jolly Todd",
    config = { extra = { mult = 13 } },
    pos = { x = 4, y = 1 },
    cost = 7,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
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
                if v == 3 or v == 5 or v == 7 or v == 9 or v == 14 then
                    succeeds = true
                    break
                end
            end
            if succeeds then 
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