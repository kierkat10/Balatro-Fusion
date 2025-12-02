SMODS.Rarity {
    key = "fused",
    pools = {
        ["Joker"] = true
    },
    default_weight = 0,
    badge_colour = HEX('ff00f6'),
    loc_txt = {
        name = "Fused"
    },
    get_weight = function(self, weight, object_type)
        return weight
    end,
}