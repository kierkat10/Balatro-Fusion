SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "riff_raff_plus",
    name = "Riff-Raff Plus",
    input = {
        "j_golden_ticket",
        "j_riff_raff",
    },
    output = "j_bfs_riff_raff_plus"
})

SMODS.Joker {
    key = "riff_raff_plus",
    name = "Riff-Raff Plus",
    config = { extra = { dollars = 4 } },
    pos = { x = 0, y = 0 },
    cost = 12,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "placeholder",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,
    calculate = function(self, card, context)
        if context.other_joker and context.other_joker:is_rarity('Common') then
            return {
                dollars = card.ability.extra.dollars
            }
        end
    end,
    bfs_credits = {
        idea = { "StellarBlue" },
		code = { "Glitchkat10" }
	}
}