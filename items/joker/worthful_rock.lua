SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "worthful_rock",
    name = "Worthful Ancient Rock",
    input = {
        "j_ancient",
        "j_golden",
    },
    output = "j_bfs_worthful_rock"
})

SMODS.Joker {
    key = "worthful_rock",
    name = "Worthful Ancient Rock",
    config = {
        extra = {
            odds = 4,
            dollars = 10
        }
    },
    pos = { x = 0, y = 0 },
    cost = 14,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "placeholder",
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "j_bfs_worthful_rock")
        return {
            vars = {
                numerator,
                denominator,
                card.ability.extra.dollars
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and SMODS.pseudorandom_probability(card, "j_bfs_worthful_rock", 1, card.ability.extra.odds) then
            return {
                dollars = card.ability.extra.dollars,
            }
        end
    end,
	bfs_credits = {
        idea = { "Dima" },
		code = { "Glitchkat10" }
	}
}