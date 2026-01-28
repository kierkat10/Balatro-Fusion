return {
    key = "riff_ring",
    name = "Riff-Ring",
    input = {
        "j_acrobat",
        "j_riff_raff",
    },
    joker = {
        config = { extra = { xmult = 2 } },
        pos = { x = 8, y = 10 },
        blueprint_compat = true,
        atlas = "riff-raff",
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.xmult } }
        end,
        calculate = function(self, card, context)
            if context.other_joker and context.other_joker:is_rarity("Common") and G.GAME.current_round.hands_left == 0 then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end,
        bfs_credits = {
            idea = { "StellarBlue" },
            art = { "StellarBlue" },
            code = { "Glitchkat10" }
        }
    }
}