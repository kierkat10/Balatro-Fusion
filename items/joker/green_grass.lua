
SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "green_grass",
    name = "Green Grass",
    input = {
        "j_riff_raff",
        "j_green_joker",
    },
    output = "j_bfs_green_grass"
})

SMODS.Joker {
    key = "green_grass",
    name = "Green Grass",
    config = {
        
    },
    pos = {x=7,y=5,},
    cost = 10,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "riff-raff",
    calculate = function (self,card,context)
        if context.discard and context.other_card == context.full_hand[#context.full_hand] then
            local leftmost = G.jokers.cards[1]
            SMODS.destroy_cards({leftmost})
        end
        if context.joker_main then
            if #G.jokers.cards <G.jokers.config.card_limit then
                local created_joker = SMODS.create_card{
                    set="Joker"
                }
                created_joker:add_to_deck()
                G.jokers:emplace(created_joker)
            end
        end
    end,
    bfs_credits = {
        idea = { "StellarBlue" },
        art = {"StellarBlue"},
        code = { "Lact4"}
    },
}
