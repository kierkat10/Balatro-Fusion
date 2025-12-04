SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "crazy_steven",
    name = "Crazy Steven",
    input = {
        "j_even_steven",
        "j_crazy",
    },
    output = "j_bfs_crazy_steven"
})

SMODS.Joker {
    key = "crazy_steven",
    name = "Crazy Steven",
    config = {},
    pos = { x = 1, y = 2 },
    cost = 10,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "joker",
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main and next(context.poker_hands["Straight"]) then
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
                    mult = 26
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