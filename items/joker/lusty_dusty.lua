
SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "lusty_dusty",
    name = "Lusty-Dusty",
    input = {
        "j_lusty_joker",
        "j_riff_raff",
    },
    output = "j_bfs_lusty_dusty"
})

SMODS.Joker {
    key = "lusty_dusty",
    name = "Lusty-Dusty",
    config = {
        extra={
            mult=0,
            mult_gain=2,
            suit="Hearts",
        },
    },
    pos = {x=2,y=0,},
    cost = 11,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "riff-raff",
    calculate = function (self,card,context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit(card.ability.extra.suit) then
            return {
                mult=card.ability.extra.mult,
            }
        end
    end,
    update = function (self,card)
        local common_jokers = 0
        if G.jokers then
        for i,v in ipairs(G.jokers.cards) do
            if v:is_rarity("Common") then
                common_jokers=common_jokers+1
            end
        end
        end
        card.ability.extra.mult=card.ability.extra.mult_gain*common_jokers
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
        idea = { "StellarBlue" },
        art = {"StellarBlue"},
        code = { "Lact4???"}
    },
}
