
SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "partnership",
    name = "Partnership",
    input = {
        "j_riff_raff",
        "j_riff_raff",
    },
    output = "j_bfs_partnership"
})

SMODS.Joker {
    key = "partnership",
    name = "Partnership",
    config = {
        
    },
    pos = {x=0,y=0,},
    cost = 12,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "placeholder",
    calculate = function (self,card,context)
        if context.setting_blind and G.GAME.blind.boss then
            if #G.jokers.cards <G.jokers.config.card_limit then
            local joker = SMODS.add_card{
                set="Joker",
                rarity=3,
                stickers={"rental"},
                force_stickers=true,
            }
            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_joker'), colour = G.C.RARITY[3]}) 
            end
        end
    end,
    loc_vars = function (self,info_queue,card)
        info_queue[#info_queue+1] = G.P_CENTERS["rental"]
    end,
    bfs_credits = {
        idea = { "Maple" },
        art = {"StellarBlue"},
        code = { "Lact4???"}
    },
}
