SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "the_foolfoolfool",
    name = "The FoolFoolFoolFoolfool",
    input = {
        "j_cartomancer",
        "j_riff_raff",
    },
    output = "j_bfs_the_foolfoolfool"
})

SMODS.Joker {
    key = "the_foolfoolfool",
    name = "The FoolFoolFoolFoolfool",
    pos = { x = 2, y = 14 },
    cost = 14,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "riff-raff",
    calculate = function(self, card, context)
        if context.setting_blind then
            local count = 0
            for _, v in pairs(G.jokers.cards) do
                if v.config.center.rarity == 1 and #G.consumeables.cards < G.consumeables.config.card_limit then
                    SMODS.add_card({ set = 'Tarot' }) -- If someone wants to add animation/shader bits here that would be helpful
                end
            end
        end
    end,
	bfs_credits = {
        art = { "StellarBlue" },
        idea = { "StellarBlue" },
		code = { "ButterStutter" }
	}
}