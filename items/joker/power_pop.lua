
SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "power_pop",
    name = "Power Pop",
    input = {
        "j_throwback",
        "j_diet_cola",
    },
    output = "j_bfs_green_grass"
})

SMODS.Joker {
    key = "power_pop",
    name = "Power Pop",
    config = {
        extra={
            x_mult=1,
            x_mult_gain=0.3,
        },
    },
    pos = {x=1,y=10,},
    cost = 12,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "joker",
    calculate = function (self,card,context)
        if context.tag_added and not context.tag_added.bfs_power_pop then
            local Tag = Tag(context.tag_added.key)
            Tag.bfs_power_pop = true
            add_tag(Tag)
        end
        if context.joker_main then
            return {
                x_mult=card.ability.extra.x_mult,
            }
        end
    end,
    loc_vars = function (self,info_queue,card)
        return {
            vars={
                card.ability.extra.x_mult_gain,
            },
        }
    end,
    update = function (self,card)
        card.ability.extra.x_mult = 1 + G.GAME.skips*card.ability.extra.x_mult_gain 
    end,
    bfs_credits = {
        idea = { "iwas_nevergood" },
        art = {"iwas_nevergood"},
        code = { "Lact4???"}
    },
}
