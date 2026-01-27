return {
    key = "impossible_beef",
    name = "Impossible Beef",
    input = {
        "j_bull",
        "j_hologram"
    },
    joker = {
        config = { extra = { xchips = 0.1, dollars = 1 } },
        pos = { x = 3, y = 0 },
        soul_pos = { x = 4, y = 0 },
        blueprint_compat = true,
        atlas = "joker",
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    card.ability.extra.xchips,
                    card.ability.extra.dollars,
                    math.max(1, (G.GAME.dollars / card.ability.extra.dollars) * card.ability.extra.xchips + 1)
                }
            }
        end,
        calculate = function(self, card, context)
            if context.joker_main then
                return {
                    xchips = math.max(1, (G.GAME.dollars / card.ability.extra.dollars) * card.ability.extra.xchips + 1)
                }
            end
        end,
        bfs_credits = {
            idea = { "Scarlet Knight" },
            art = { "SnowPickle" },
            code = { "Glitchkat10" }
        }
    }
}