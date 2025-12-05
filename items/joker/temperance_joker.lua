SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "temperance",
    name = "Temperance Joker",
    input = {
        "j_gluttonous",
        "j_gluttonous",
    },
    output = "j_bfs_temperance"
})

SMODS.Joker {
    key = "temperance",
    name = "Temperance Joker",
    pos = { x = 0, y = 0 },
    cost = 12,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "placeholder",
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit("Clubs") then
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