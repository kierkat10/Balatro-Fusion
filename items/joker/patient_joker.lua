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
    config = { extra = { xchips = 1.5 } },
    pos = { x = 0, y = 0 },
    cost = 12,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "placeholder",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xchips } }
    end,
    calculate = function(self, card, context)
        if context.individual then
            if context.other_card:is_suit("Spades") then
                return {
                    xchips = card.ability.extra.xchips
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