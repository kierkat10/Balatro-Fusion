SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "compressed",
    name = "Compressed Joker",
    input = {
        "j_joker",
        "j_joker",
    },
    output = "j_bfs_compressed"
})

SMODS.Joker {
    key = "compressed",
    name = "Compressed Joker",
    config = {
        extra = {
            mult_mod = 4,
            mult = 0
        }
    },
    pos = { x = 0, y = 0 },
    cost = 4,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "placeholder",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult_mod,
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.post_trigger and context.other_card and context.other_card.config and context.other_card.config.center_key ~= "j_bfs_compressed" and not context.blueprint_card then
            if context.other_ret and context.other_ret.jokers and (type(context.other_ret.jokers) == "table" and context.other_ret.jokers.mult and context.other_ret.jokers.mult ~= 0) or (type(context.other_ret.jokers) == "table" and context.other_ret.jokers.mult_mod and context.other_ret.jokers.mult_mod ~= 0) then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
                return {
                    message = localize("k_upgrade_ex"),
                    colour = G.C.RED
                }
            end
        end
    end,
    bfs_credits = {
        idea = { "George The Rat" },
		code = { "Glitchkat10", "trif" }
	}
}