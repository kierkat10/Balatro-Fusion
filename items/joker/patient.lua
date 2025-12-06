SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "patient",
    name = "Patient Joker",
    input = {
        "j_wrathful_joker",
        "j_wrathful_joker",
    },
    output = "j_bfs_patient"
})

SMODS.Joker {
    key = "patient",
    name = "Patient Joker",
    config = { extra = { xchips = 1.5 } },
    pos = { x = 9, y = 2 },
    cost = 10,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "placeholder",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xchips } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit("Spades") then
                return {
                    xchips = card.ability.extra.xchips
                }
            end
        end
    end,
	bfs_credits = {
        idea = { "The Wheel" },
        art = { "The Wheel" },
		code = { "ButterStutter" }
	}
}