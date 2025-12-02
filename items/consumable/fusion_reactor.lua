SMODS.Consumable {
    key = "fusion_reactor",
    name = "Fusion Reactor",
    set = "Spectral",
    pos = { x = 0, y = 0 },
    cost = 4,
    atlas = "consumable",
    use = function(self, card, area, copier)
        local input = G.jokers.highlighted
        local result = SMODS.BalatroFusion.Fusion:get(G.jokers.highlighted)
        SMODS.BalatroFusion.Fusion:fuse(result,input)
    end,
    can_use = function(self, card)
        return #G.jokers.highlighted == 2 and SMODS.BalatroFusion.Fusion:get(G.jokers.highlighted) ~= nil
    end
}