return {
    key = "partnership",
    name = "Partnership",
    input = {
        "j_riff_raff",
        "j_riff_raff",
    },
    joker = {
        config = {},
        pos = {x=6,y=6},
        blueprint_compat = true,
        atlas = "riff-raff",
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
            info_queue[#info_queue+1] = {key = 'rental', set = 'Other', vars = {G.GAME.rental_rate or 1}}
        end,
        bfs_credits = {
            idea = { "Maple" },
            art = {"StellarBlue"},
            code = { "Lact4???"}
        },
    }
}