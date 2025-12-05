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
    name = "Chastity Joker",
    config = { extra = { xmult = 1.5 } },
    pos = { x = 0, y = 0 },
    cost = 10,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "placeholder",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit("Hearts") then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
	bfs_credits = {
        idea = { "The Wheel" },
		code = { "ButterStutter" },
        art = { "The Wheel" }
	}
}