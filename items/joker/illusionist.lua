return {
    key = "illusionist",
    name = "Illusionist",
    input = {
        "j_juggler",
        "j_hallucination",
    },
    joker = {
        pos = { x = 0, y = 0 },
        blueprint_compat = true,
        atlas = "placeholder",
        add_to_deck = function(self, card, from_debuff)
            SMODS.change_booster_limit(1)
        end,
        remove_from_deck = function(self, card, from_debuff)
            SMODS.change_booster_limit(-1)
        end,
        bfs_credits = {
            idea = { "ButterStutter" },
            art = {},
            code = { "ButterStutter" }
        }
    }
}