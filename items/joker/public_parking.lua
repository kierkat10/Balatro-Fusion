SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "public_parking",
    name = "Public Parking",
    input = {
        "j_reserved_parking",
        "j_riff_raff",
    },
    output = "j_bfs_public_parking"
})

SMODS.Joker {
    key = "public_parking",
    name = "Public Parking",
    config = { extra = { 
        odds = 2,
        dollars = 2 
    } },
    pos = { x = 2, y = 8 },
    cost = 12,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "riff-raff",
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "j_bfs_public_parking")
        return {
            vars = {
                numerator,
                denominator,
                card.ability.extra.dollars
            }
        }
    end,
    calculate = function(self, card, context)
        if context.other_joker and context.other_joker:is_rarity("Common") and SMODS.pseudorandom_probability(card, "j_bfs_public_parking", 1, card.ability.extra.odds) then
            return {
                dollars = card.ability.extra.dollars
            }
        end
    end,
    bfs_credits = {
        art = { "StellarBlue" },
        idea = { "ButterStutter" },
		code = { "ButterStutter" }
	}
}