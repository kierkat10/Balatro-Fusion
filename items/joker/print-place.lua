
SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "print_place",
    name = "Print-Place",
    input = {
        "j_riff_raff",
        "j_blueprint",
    },
    output = "j_bfs_print_place"
})

SMODS.Joker {
    key = "print_place",
    name = "Print Place",
    config = {
        
    },
    pos = {x=3,y=12,},
    cost = 16,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "riff-raff",
    calculate = function (self,card,context)
        if context.setting_blind then
            local js_right = nil
            for i,v in ipairs(G.jokers.cards) do
                if G.jokers.cards[i] == card then
                    js_right=G.jokers.cards[i+1]
                end
            end
            if js_right ~= nil then
            G.E_MANAGER:add_event(Event{
            func = function ()
                local copied_joker = copy_card(js_right)
                G.jokers:emplace(copied_joker)
                copied_joker:add_to_deck()
                return true
                    end,
                })
            end
        end
    end,
    bfs_credits = {
        idea = { "StellarBlue" },
        art = {"StellarBlue"},
        code = { "Lact4???"}
    },
}
