SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "tempered",
    name = "Tempered Joker",
    input = {
        "j_gluttenous_joker",
        "j_gluttenous_joker",
    },
    output = "j_bfs_tempered"
})

SMODS.Joker {
    key = "tempered",
    name = "Tempered Joker",
    config = { extra = { xchips = 1.5 } },
    pos = { x = 0, y = 0 },
    cost = 10,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "placeholder",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xchips } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit("Clubs") then
            return {
                xchips = card.ability.extra.xchips
            }
        end
    end,
	bfs_credits = {
        idea = { "The Wheel" },
        art = { "The Wheel" },
		code = { "ButterStutter" }
	}
}