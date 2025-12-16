SMODS.Consumable {
    key = "meld",
    name = "Meld",
    set = "Spectral",
    pos = { x = 0, y = 1 },
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
            local joker_to_give_back = pseudorandom_element(input,"bfs_meld")
            local result = SMODS.BalatroFusion.Fusion:get(input)
            if result then
                joker_to_give_back=copy_card(joker_to_give_back)

                SMODS.BalatroFusion.Fusion:fuse(result, input)
                G.jokers:emplace(joker_to_give_back)
                joker_to_give_back:add_to_deck()
            end
        end
    end,
}