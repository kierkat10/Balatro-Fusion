SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "patient",
    name = "Patient Joker",
    input = {
        "j_wrathful",
        "j_wrathful",
    },
    output = "j_bfs_patient"
})

SMODS.Joker {
    key = "patient",
    name = "Patient Joker",
    pos = { x = 0, y = 0 },
    cost = 12,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "placeholder",
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit("Spades") then
                return {
                    xchips = 1.5
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