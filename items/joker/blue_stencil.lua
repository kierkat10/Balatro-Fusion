SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "blue_stencil",
    name = "Blue Stencil",
    input = {
        "j_stencil",
        "j_blue_joker",
    },
    output = "j_bfs_blue_stencil"
})

SMODS.Joker {
    key = "blue_stencil",
    name = "Blue Stencil",
    config = { extra = {
        xmult_gain = 0.04,
    }},
    pos = { x = 4, y = 1 },
    cost = 14,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        local deck_limit = G.deck and G.deck.config and G.deck.config.card_limit or 52
        local deck_size = G.deck and #G.deck.cards or 52
        return {vars = {
            card.ability.extra.xmult_gain,
            1 + card.ability.extra.xmult_gain * (deck_limit - deck_size),
        }}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = 1 + card.ability.extra.xmult_gain * (G.deck.config.card_limit - #G.deck.cards),
            }
        end
    end,
    bfs_credits = {
        idea = { "ButterStutter" },
        art = { "The Wheel" },
		code = { "ButterStutter" }
	}
}