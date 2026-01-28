return {
    key = "mountain_range",
    name = "Mountain Range",
    input = {
        "j_riff_raff",
        "j_mystic_summit",
        },
    joker = {
        config = {
            extra = {
                mult = 10
            },
        },
        pos = { x = 2, y = 2 },
        blueprint_compat = true,
        atlas = "riff-raff",
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.mult } }
        end,
        calculate = function(self, card, context)
            if context.other_joker and context.other_joker.config.center.rarity == 1 and G.GAME.current_round.discards_left == 0 then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end,
        bfs_credits = {
            idea = { "StellarBlue" },
            art = { "StellarBlue" },
            code = { "ButterStutter" }
        },
    }
}
