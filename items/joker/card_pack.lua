SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "card_pack",
    name = "Card Pack",
    input = {
        "j_baseball_card",
        "j_baseball_card",
    },
    output = "j_bfs_card_pack"
})

SMODS.Joker {
    key = "card_pack",
    name = "Card Pack",
    config = {
        extra = {
            xmult = 2,
            odds = 100,
            dollars = 100
        }
    },
    pos = { x = 0, y = 0 },
    cost = 16,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "placeholder",
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "j_bfs_card_pack")
        return {
            vars = {
                card.ability.extra.xmult,
                numerator,
                denominator,
                card.ability.extra.dollars
            }
        }
    end,
    calculate = function(self, card, context)
        if context.other_joker and context.other_joker:is_rarity("Rare") then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
    calc_dollar_bonus = function(self, card)
        if SMODS.pseudorandom_probability(card, "j_bfs_card_pack", 1, card.ability.extra.odds) then
            return {
                dollars = card.ability.extra.dollars
            }
        end
    end,
    bfs_credits = {
        idea = { "RandomGuy" },
		code = { "Glitchkat10" }
	}
}