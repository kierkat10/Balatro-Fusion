SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "riff_raff_pro",
    name = "Riff-Raff Pro",
    input = {
        "j_golden",
        "j_riff_raff",
    },
    output = "j_bfs_riff_raff_pro"
})

SMODS.Joker {
    key = "riff_raff_pro",
    name = "Riff-Raff Pro",
    config = { extra = { create = 1 } },
    pos = { x = 0, y = 0 },
    cost = 13,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "placeholder",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.create } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            local jokers_to_create = math.min(card.ability.extra.create, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
            G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
            G.E_MANAGER:add_event(Event({
                func = function()
                    for _ = 1, jokers_to_create do
                        SMODS.add_card {
                            set = "Joker",
                            rarity = "Uncommon",
                            key_append = "bfs_riff_raff_pro"
                        }
                        G.GAME.joker_buffer = 0
                    end
                    return true
                end
            }))
            return {
                message = localize("k_plus_joker"),
                colour = G.C.GREEN,
            }
        end
    end,
    bfs_credits = {
        idea = { "StellarBlue" },
		code = { "Glitchkat10" }
	}
}