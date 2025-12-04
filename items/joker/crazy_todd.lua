SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "crazy_todd",
    name = "Crazy Todd",
    input = {
        "j_odd_todd",
        "j_crazy",
    },
    output = "j_bfs_crazy_todd"
})

SMODS.Joker {
    key = "crazy_todd",
    name = "Crazy Todd",
    config = {},
    pos = { x = 0, y = 2 },
    cost = 10,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "joker",
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main and next(context.poker_hands["Straight"]) then
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
                    mult = 25
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