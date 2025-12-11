
SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "demand_driven",
    name = "Demand-Driven",
    input = {
        "j_riff_raff",
        "j_to_the_moon",
    },
    output = "j_bfs_demand_driven"
})

SMODS.Joker {
    key = "demand_driven",
    name = "Demand Driven",
    config = {
        extra={
            interest_gain=1,
            immutable={
            current_interest=0,
            },
        },
    },
    pos = {x=4,y=8,},
    cost = 11,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "riff-raff",
    loc_vars = function(self, info_queue, card)
        return {
            vars={
            card.ability.extra.interest_gain,
            card.ability.extra.immutable.current_interest,
            },
        }
    end,
    update = function (self,card)
        if G.jokers and card then
        local last_interest = card.ability.extra.immutable.current_interest
        local common_jokers_owned = 0
        for i,v in ipairs(G.jokers.cards) do
            if v:is_rarity("Common") then
                common_jokers_owned=common_jokers_owned+1
            end
        end
        card.ability.extra.immutable.current_interest=card.ability.extra.interest_gain*common_jokers_owned
        if last_interest ~= card.ability.extra.immutable.current_interest then
            G.GAME.interest_amount=G.GAME.interest_amount-last_interest
            G.GAME.interest_amount=G.GAME.interest_amount+card.ability.extra.immutable.current_interest
        end

        end
    end,
    bfs_credits = {
        idea = { "StellarBlue" },
        art = {"StellarBlue"},
        code = { "Lact4"}
    },
}
