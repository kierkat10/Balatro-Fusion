return {
    key = "joker_cola",
    name = "Joker Cola",
    input = {
        "j_joker",
        "j_diet_cola",
    },
    joker = {
        config = {
            extra={
                mult=4,
                mult_gain=4,
            },
        },
        pos = {x=0,y=0,},
        blueprint_compat = true,
        atlas = "placeholder",
        calculate = function (self,card,context)
            if context.end_of_round and context.cardarea == G.jokers and G.GAME.blind.boss then
                SMODS.scale_card(card,{
                    ref_table=card.ability.extra,
                    ref_value="mult",
                    scalar_value="mult_gain",
                    message_key="a_mult",
                    message_colour=G.C.RED,
                })
                add_tag(Tag('tag_double'))
            end
            if context.joker_main then
                return {
                    mult=card.ability.extra.mult
                }
            end
        end,
        loc_vars = function (self,info_queue,card)
            return {
                vars={
                    card.ability.extra.mult_gain,
                    card.ability.extra.mult,
                }
            }
        end,
        bfs_credits = {
            idea = { "Maple" },
            art = {"Nice Cream"},
            code = { "Lact4???"}
        },
    }
}