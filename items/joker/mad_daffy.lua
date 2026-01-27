return {
    key = "mad_daffy",
    name = "Mad Daffy",
    input = {
        "j_riff_raff",
        "j_mad",
    },
    joker = {
        config = {
            extra={
                played_hand="Two Pair",
                immutable={jokers_to_create=2,},
            },
        },
        pos = {x=7,y=0,},
        blueprint_compat = true,
        atlas = "riff-raff",
        calculate = function (self,card,context)
            if context.joker_main and context.scoring_name == card.ability.extra.played_hand then
                local jokers_to_create = math.min(card.ability.extra.immutable.jokers_to_create, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
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
        end,
        loc_vars = function (self,info_queue,card)
            return {
                vars={
                    card.ability.extra.immutable.jokers_to_create,
                }
            }
        end,
        bfs_credits = {
            idea = { "StellarBlue" },
            art = {"StellarBlue"},
            code = { "Lact4???"}
        },
    }
}