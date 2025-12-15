
SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "jimbo",
    name = "Jimbo",
    input = {
        "j_riff_raff",
        "j_joker",
    },
    output = "j_bfs_jimbo"
})

SMODS.Joker {
    key = "jimbo",
    name = "Jimbo",
    config = {
        extra={
            mult=0,
            mult_gain=8,
        },
    },
    pos = {x=0,y=0,},
    cost = 8,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "riff-raff",
    calculate = function (self,card,context)
        if context.setting_blind then
            local jokers_to_create = math.min(2, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
            G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
            G.E_MANAGER:add_event(Event({
                func = function() 
                    for i = 1, jokers_to_create do
                        local card = create_card('Joker', G.jokers, nil, 0, nil, nil, nil, card.config.center.key)
                        card:add_to_deck()
                        G.jokers:emplace(card)
                        card:start_materialize()
                        G.GAME.joker_buffer = 0
                    end
                        return true
                end}))   
                card_eval_status_text(context_blueprint_card or self, 'extra', nil, nil, nil, {message = localize('k_plus_joker'), colour = G.C.BLUE}) 
            return nil, true
        end
        if context.joker_main then
            return {
                mult=card.ability.extra.mult,
            }
        end
    end,
    update = function (self,card)
        local common_jokers_owned = 0
        if G.jokers then
        for i,v in pairs(G.jokers.cards) do
            if v:is_rarity("Common") then common_jokers_owned=common_jokers_owned+1 end    
        end
        end
        card.ability.extra.mult=card.ability.extra.mult_gain*common_jokers_owned
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
        art = {"StellarBlue"},
        code = { "Lact4???"}
    },
}
