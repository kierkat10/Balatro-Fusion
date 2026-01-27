return {
    key = "joker_pack",
    name = "Joker Pack",
    input = {
        "j_joker",
        "j_hallucination",
    },
    joker = {
        config = {
            extra={
                mult=0,
                mult_gain=4,
                chance=2,
            },
        },
        pos = {x=0,y=0,},
        blueprint_compat = true,
        atlas = "placeholder",
        calculate = function (self,card,context)
            if context.open_booster and SMODS.pseudorandom_probability(card, 'bfs_joker_pack'..G.GAME.round_resets.ante, 1, card.ability.extra.chance) then
                SMODS.scale_card(card,{
                    scalar_table=card.ability.extra,
                    scalar_value="mult_gain",
                    ref_table=card.ability.extra,
                    ref_value="mult",
                    message_key="a_mult",
                    message_colour=G.C.RED,
                })
                if #G.consumeables.cards < G.consumeables.config.card_limit then
                    local tarot_card = SMODS.create_card{
                        set="Tarot",
                        key_append="bfs_joker_pack",
                    }
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_plus_tarot'), colour = G.C.PURPLE})
                    G.consumeables:emplace(tarot_card)
                    tarot_card:add_to_deck()
                end
            end
            if context.joker_main then
                return {
                    mult=card.ability.extra.mult
                }
            end
        end,
        loc_vars = function (self,info_queue,card)
            local numerator,denominator=SMODS.get_probability_vars(card,1,card.ability.extra.chance)
            return {
                vars={
                    numerator,
                    denominator,
                    card.ability.extra.mult_gain,
                    card.ability.extra.mult,
                }
            }
        end,
        bfs_credits = {
            idea = { "Maple" },
            art = {"Maple"},
            code = { "Lact4???"}
        },
    }
}