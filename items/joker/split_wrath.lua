SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "split_wrath",
    name = "Split Wrath",
    input = {
        "j_half",
        "j_wrathful_joker",
    },
    output = "j_bfs_split_wrath"
})

SMODS.Joker {
    key = "split_wrath",
    name = "Split Wrath",
    config = {
        extra = {
            xmult = 2,
            size = 3
        }
    },
    pos = { x = 0, y = 0 },
    cost = 10,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "placeholder",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.size
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit("Spades") and #context.full_hand <= card.ability.extra.size then
            return {
                xmult = card.ability.extra.xmult,
            }
        end
    end,
    bfs_credits = {
        idea = { "The Wheel" },
		code = { "Glitchkat10" }
	}
}