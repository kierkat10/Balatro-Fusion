SMODS.Consumable {
    key = "house_devil",
    name = "House of the Devil",
    config = { extra = { max_highlighted = 1 } },
    set = "Tarot",
    pos = { x = 0, y = 0 },
    cost = 3,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.max_highlighted } }
    end,
    can_use = function(self, card)
        local highlighted = G.jokers.highlighted or {}
        if #highlighted < 1 or #highlighted > card.ability.extra.max_highlighted then
            return false
        end
        local joker = highlighted[1]
        return joker:is_rarity("bfs_fused")
    end,
    use = function(self, card, area, copier)
        local input = G.jokers.highlighted
        if #input > 0 then
            local joker = input[1]
            SMODS.BalatroFusion.Fusion:unfuse_joker(joker)
        end
    end
}