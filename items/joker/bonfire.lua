SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "bonfire",
    name = "Bonfire",
    input = {
        "j_campfire",
        "j_campfire",
    },
    output = "j_bfs_bonfire"
})

SMODS.Joker {
    key = "bonfire",
    name = "Bonfire",
    config = {
        extra = {
            xmult_mod = 0.2,
            xmult = 1
        }
    },
    pos = { x = 0, y = 0 },
    cost = 18,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "placeholder",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult_mod,
                card.ability.extra.xmult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.selling_card and not context.blueprint then
            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
            return {
                message = localize("k_upgrade_ex")
            }
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
    bfs_credits = {
        idea = { "ButterStutter" },
		code = { "Glitchkat10" }
	}
}