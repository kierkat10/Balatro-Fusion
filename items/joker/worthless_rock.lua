SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "worthless_rock",
    name = "Worthless Ancient Rock",
    input = {
        "j_ancient",
        "j_marble",
    },
    output = "j_bfs_worthless_rock"
})

SMODS.Joker {
    key = "worthless_rock",
    name = "Worthless Ancient Rock",
    config = {
        extra = {
            odds = 2,
            xchips = 1.75
        }
    },
    pos = { x = 0, y = 0 },
    cost = 14,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "placeholder",
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "j_bfs_worthless_rock")
        return {
            vars = {
                numerator,
                denominator,
                card.ability.extra.xchips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and SMODS.pseudorandom_probability(card, "j_bfs_worthless_rock", 1, card.ability.extra.odds) then
            return {
                xchips = card.ability.extra.xchips
            }
        end
    end,
	bfs_credits = {
        idea = { "RandomGuy" },
		code = { "Glitchkat10" }
	}
}