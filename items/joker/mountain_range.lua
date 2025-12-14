
SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "mountain_range",
    name = "Mountain Range",
    input = {
        "j_riff_raff",
        "j_mystic_summit",
    },
    output = "j_bfs_mountain_range"
})

SMODS.Joker {
    key = "mountain_range",
    name = "Mountain Range",
    config = {
        extra = {
            mult = 10
        },
    },
    pos = { x = 2, y = 2 },
    cost = 11,
    rarity = "bfs_fused",
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

