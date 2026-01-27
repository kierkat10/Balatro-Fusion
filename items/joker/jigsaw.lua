return {
    key = "jigsaw",
    name = "Jigsaw Joker",
    input = {
        "j_stencil",
        "j_stencil",
    },
    joker = {
        config = { extra = {
            xmult_gain = 1.2,
        }},
        pos = { x = 3, y = 2 },
        blueprint_compat = true,
        atlas = "joker",
        loc_vars = function(self, info_queue, card)
            local total_slots = (G.jokers and G.jokers.config and G.jokers.config.card_limit or 5) + (G.consumeables and G.consumeables.config and G.consumeables.config.card_limit or 2)
            local empty_slots = (G.jokers and #G.jokers.cards or 0) + (G.consumeables and #G.consumeables.cards or 0)
            -- Need to add Joker Stencil bypass check + also fusions
            -- Maybe turn into a separate function? Mainly due to stencil + pareidolia fusion ability maybe adding complexities
            return {vars = {
                card.ability.extra.xmult_gain,
                card.ability.extra.xmult_gain * (total_slots - empty_slots),
            }}
        end,
        calculate = function(self, card, context)
            if context.joker_main then
                local total_slots = (G.jokers and G.jokers.config and G.jokers.config.card_limit or 5) + (G.consumeables and G.consumeables.config and G.consumeables.config.card_limit or 2)
                local empty_slots = (G.jokers and #G.jokers.cards or 0) + (G.consumeables and #G.consumeables.cards or 0)
                return {
                    xmult = card.ability.extra.xmult_gain * (total_slots - empty_slots),
                }
            end
        end,
        bfs_credits = {
            idea = { "ButterStutter" },
            art = { "King" },
            code = { "ButterStutter" }
        }
    }
}