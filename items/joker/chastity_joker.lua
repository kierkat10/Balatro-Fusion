SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "patient",
    name = "Chastity Joker",
    input = {
        "j_lusty",
        "j_lusty",
    },
    output = "j_bfs_chastity"
})

SMODS.Joker {
    key = "chastity",
    name = "j_lusty",
    pos = { x = 0, y = 0 },
    cost = 12,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "placeholder",
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit("Hearts") then
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