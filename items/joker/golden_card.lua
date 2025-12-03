SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "golden_card",
    name = "Golden Card",
    input = {
        "j_golden",
        "j_red_card",
    },
    output = "j_bfs_golden_card"
})

SMODS.Joker {
    key = "golden_card",
    name = "Golden Card",
    config = {
        extra = {
            money = 1,
            money_mod = 1
        }
    },
    pos = { x = 0, y = 0 },
    cost = 13,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "placeholder",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.money,
                card.ability.extra.money_mod
            }
        }
    end,
    calculate = function(self, card, context)
        if context.skipping_booster then
            card.ability.extra.money = card.ability.extra.money + card.ability.extra.money_mod
            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.MONEY,
            }
        end
    end,
    calc_dollar_bonus = function(self, card)
        return card.ability.extra.money
    end,
    bfs_credits = {
        idea = { "ButterStutter" },
		code = { "Glitchkat10" }
	}
}