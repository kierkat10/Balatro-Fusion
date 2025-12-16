SMODS.Consumable {
    key = "the_universe",
    name = "The Universe",
    set = "Tarot",
    pos = { x = 3, y = 0 },
    cost = 3,
    atlas = "consumable",
    can_use = function(self, card)
        local highlighted = G.jokers.highlighted or {}
        if #highlighted < 2 then
            return false
        end
        local result = SMODS.BalatroFusion.Fusion:get(highlighted)
        return result ~= nil
    end,
    use = function(self, card, area, copier)
        local input = G.jokers.highlighted
        if #input > 0 then
            local result = SMODS.BalatroFusion.Fusion:get(input)
            if result then
                SMODS.BalatroFusion.Fusion:fuse(result, input)
            end
        end
    end
}