return {
    key = "tax_collector",
    name = "Tax Collector",
    input = {
        "j_golden",
        "j_juggler"
    },
    joker = {
        config = { extra = { dollars = -3 } },
        pos = { x = 5, y = 10 },
        blueprint_compat = false,
        atlas = "joker",
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.dollars } }
        end,
        calculate = function(self, card, context)
            if context.end_of_round and not context.game_over and context.main_eval and not context.blueprint then
                return {
                    dollars = card.ability.extra.dollars
                }
            end
        end,
        add_to_deck = function(self, card, from_debuff)
            G.hand:change_size(1)
            SMODS.change_play_limit(1)
            SMODS.change_discard_limit(1)
        end,
        remove_from_deck = function(self, card, from_debuff)
            G.hand:change_size(-1)
            SMODS.change_play_limit(-1)
            SMODS.change_discard_limit(-1)
        end,
        bfs_credits = {
            art = { "ButterStutter" },
            idea = { "ButterStutter" },
            code = { "ButterStutter" }
        }
    }
}