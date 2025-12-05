SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "charity",
    name = "Charity Joker",
    input = {
        "j_greedy",
        "j_greedy",
    },
    output = "j_bfs_charity"
})

SMODS.Joker {
    key = "charity",
    name = "Charity Joker",
    pos = { x = 0, y = 0 },
    cost = 12,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "placeholder",
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit("Diamonds") then
                return {
                    xmult = 1.5
                }
            end
        end
    end,
	bfs_credits = {
        idea = { "The Wheel" },
		code = { "ButterStutter" },
        art = { "The Wheel" }
	}
}