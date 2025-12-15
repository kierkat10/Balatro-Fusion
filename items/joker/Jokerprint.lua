
SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "joker_print",
    name = "Joker Print",
    input = {
        "j_joker",
        "j_blueprint",
    },
    output = "j_bfs_joker_print"
})

SMODS.Joker {
    key = "joker_print",
    name = "Joker Print",
    config = {
        extra={
            mult=0,
            mult_gain=4,
        },
    },
    pos = {x=0,y=0,},
    cost = 12,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "placeholder",
    calculate = function (self,card,context)
        local other_joker = nil
        for i = 1,#G.jokers.cards do
            if G.jokers.cards[i] == card then other_joker=G.jokers.cards[i+1] end
        end
        local ret = SMODS.blueprint_effect(card,other_joker,context) or {}
        if context.joker_main then
            if ret.mult == nil then ret.mult = 0 end
            ret.mult=ret.mult+card.ability.extra.mult
        end
        if context.post_trigger and context.other_card == other_joker then
            SMODS.scale_card(card,{
                ref_table=card.ability.extra,
                ref_value="mult",
                scalar_value="mult_gain",
                message="a_mult",
                colour=G.C.RED,
            })
        end
        return ret
    end,
    loc_vars = function (self,info_queue,card)
        local main_end
        if card.area and card.area == G.jokers then
            local other_joker
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i + 1] end
            end
            local compatible = other_joker and other_joker ~= card and other_joker.config.center.blueprint_compat
            main_end = {
                {
                    n = G.UIT.C,
                    config = { align = "bm", minh = 0.4 },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = { ref_table = card, align = "m", colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                            nodes = {
                                { n = G.UIT.T, config = { text = ' ' .. localize('k_' .. (compatible and 'compatible' or 'incompatible')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                            }
                        }
                    }
                }
            }
        end
        return {
            vars={
                card.ability.extra.mult_gain,
                card.ability.extra.mult,
            },
            main_end=main_end,
        }
    end,
    bfs_credits = {
        idea = { "Maple" },
        art = {" The Wheel "},
        code = { "Lact4???"}
    },
}
