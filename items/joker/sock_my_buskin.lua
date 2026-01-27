return {
    key = "sock_my_buskin",
    name = "Sock My Buskin",
    input = {
        "j_riff_raff",
        "j_sock_and_buskin",
    },
    joker = {
        config = {
            extra={
                immutable={retriggers_per_common_joker=1,repetitions=1,},
            },
        },
        pos = {x=9,y=10,},
        blueprint_compat = true,
        atlas = "riff-raff",
        calculate = function (self,card,context)
            if context.repetition and context.cardarea == G.play and context.other_card:is_face() then
                return {
                    repetitions=card.ability.extra.immutable.repetitions,
                    message = localize('k_again_ex')
                }
            end
        end,
        update = function (self,card)
            local common_jokers_owned = 0
            if G.jokers then
                for i,v in ipairs(G.jokers.cards) do
                    if v:is_rarity("Common") then common_jokers_owned=common_jokers_owned+1 end
                end
            end
            card.ability.extra.immutable.repetitions=1+(card.ability.extra.immutable.retriggers_per_common_joker*common_jokers_owned)
        end,
        loc_vars = function (self,info_queue,card)
        return {
            vars={
                card.ability.extra.immutable.retriggers_per_common_joker,
                card.ability.extra.immutable.repetitions,
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