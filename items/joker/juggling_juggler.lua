
SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "juggling_juggler",
    name = "Juggling Juggler",
    input = {
        "j_riff_raff",
        "j_juggler",
    },
    output = "j_bfs_juggling_juggler"
})

SMODS.Joker {
    key = "juggling_juggler",
    name = "Juggling Juggler",
    config = {
        extra = {
            immutable = {
                hand_size = 0,
                hand_size_per_common_joker = 1,
            },
        },
    },
    pos = {x=7,y=8,},
    cost = 9,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "riff-raff",
    update = function (self, card)
        local common_jokers_owned = 0
        if G.jokers then
            for i, v in ipairs(G.jokers.cards) do
                if v:is_rarity("Common") then common_jokers_owned = common_jokers_owned+1 end
            end
        end
        if G.hand and G.hand.config then
            G.hand.config.card_limit = G.hand.config.card_limit - card.ability.extra.immutable.hand_size
            card.ability.extra.immutable.hand_size = card.ability.extra.immutable.hand_size_per_common_joker * common_jokers_owned
            G.hand.config.card_limit = G.hand.config.card_limit + card.ability.extra.immutable.hand_size
        end
    end,
    remove_from_deck = function (self,card)
        G.hand:change_size(-card.ability.extra.immutable.hand_size)
    end,
    loc_vars = function (self,info_queue,card)
       return {
        vars={
            card.ability.extra.immutable.hand_size_per_common_joker,
            card.ability.extra.immutable.hand_size,
        }
       } 
    end,
    bfs_credits = {
        idea = { "StellarBlue" },
        art = {"StellarBlue"},
        code = { "Lact4???"}
    },
}
