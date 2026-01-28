return {
    key = "the_fool",
    name = "The Fool-Fool",
    input = {
        "j_cartomancer",
        "j_riff_raff"
    },
    joker = {
        config = { extra = { create = 1 } },
        pos = { x = 2, y = 14 },
        blueprint_compat = true,
        atlas = "riff-raff",
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.create } }
        end,
        calculate = function(self, card, context)
            if context.setting_blind then
                for _, v in pairs(G.jokers.cards) do
                    if v.config.center.rarity == 1 and #G.consumeables.cards < G.consumeables.config.card_limit then
                        for i = 1, card.ability.extra.create do
                            SMODS.add_card({ set = 'Tarot' })
                        end
                    end
                end
            end
        end,
        bfs_credits = {
            art = { "StellarBlue" },
            idea = { "StellarBlue" },
            code = { "ButterStutter", "Glitchkat10" }
        }
    }
}