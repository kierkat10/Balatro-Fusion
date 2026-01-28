return {
    key = "infuriating",
    name = "Infuriating Joker",
    input = {
        "j_joker",
        "j_wrathful_joker",
    },
    joker = {
        config = { extra = { mult = 0,mult_gain=1,suit="Spades" } },
        pos = { x = 0, y = 0 },
        atlas="placeholder",
        blueprint_compat = true,
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.mult_gain,card.ability.extra.mult } }
        end,
        calculate = function(self, card, context)
            if context.individual and context.cardarea == G.play then
                if context.other_card:is_suit(card.ability.extra.suit) then
                    SMODS.scale_card(card,{
                        ref_table=card.ability.extra,
                        ref_value="mult",
                        scalar_value="mult_gain",
                        message_key = 'a_mult',
                    })
                end
            end
            if context.joker_main then
                return {
                    mult=card.ability.extra.mult
                }
            end
        end,
        bfs_credits = {
            idea = { "The Wheel" },
            art = { "The Wheel" },
            code = { "Lact4" }
        }
    }
}