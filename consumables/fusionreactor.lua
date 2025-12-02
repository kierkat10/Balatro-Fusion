SMODS.Consumable {
    key = 'fusionreactor',
    set = 'Spectral',
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = 'Fusion Reactor',
        text = {
        [1] = 'Creates a {C:attention}Fusion Card{} to fuse two or more jokers'
    }
    },
    cost = 10,
    unlocked = true,
    discovered = true,
    hidden = false,
    can_repeat_soul = false,
    atlas = 'CustomConsumables',
        use = function(self, card, area, copier)
        local input = G.jokers.highlighted
        local result = SMODS.BalatroFusions.Fusion:get(G.jokers.highlighted)
        SMODS.BalatroFusions.Fusion:fuse(result,input)
    end,
    can_use = function(self, card)
        return #G.jokers.highlighted == 2 and SMODS.BalatroFusions.Fusion:get(G.jokers.highlighted) ~= nil
    end
}