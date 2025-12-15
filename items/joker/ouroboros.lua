
SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "ouroboros",
    name = "Ouroboros",
    input = {
        "j_joker",
        "j_fibonacci",
    },
    output = "j_bfs_ouroboros"
})

SMODS.Joker {
    key = "ouroboros",
    name = "Ouroboros",
    config = {
        extra={
            mult=0,
            mult_per_card_scored=8,
            mult_gain=4,
        },
    },
    pos = {x=0,y=0,},
    cost = 10,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "placeholder",
    calculate = function (self,card,context)
        if context.cardarea == G.play and context.individual then
            local ranks = {
                [2]=true,
                [3]=true,
                [5]=true,
                [8]=true,
                [14]=true,
            }
            if ranks[context.other_card:get_id()] then
                SMODS.scale_card(card,{
                    ref_table=card.ability.extra,
                    ref_value="mult",
                    scalar_value="mult_gain",
                    message_key="a_mult",
                    message_colour=G.C.RED,
                })
            end
            return {
                mult=card.ability.extra.mult_per_card_scored,
            }
        end
        if context.joker_main then
            return {
                mult=card.ability.extra.mult,
            }
        end
    end,
    loc_vars = function (self,info_queue,card)
        return {
            vars={
                card.ability.extra.mult_per_card_scored,
                card.ability.extra.mult_gain,
                card.ability.extra.mult,
            }
        }
    end,
    bfs_credits = {
        idea = { "Maple" },
        art = {" Maple "},
        code = { "Lact4???"}
    },
}
