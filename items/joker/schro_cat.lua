SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "schro_cat",
    name = "Schrodinger\'s Cat",
    input = {
        "j_lucky_cat",
        "j_superposition",
    },
    output = "j_bfs_schro_cat"
})

SMODS.Joker{
    key = "schro_cat",
    name = "Schrodinger\'s Cat",
    config = {
        extra = {
            xmult_mod = 0.2,
            max = 20,
            xmult = 1
        }
    },
    pos = { x = 8, y = 0 },
    cost = 10,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult_mod,
                card.ability.extra.max,
                card.ability.extra.xmult
            }
        }
    end,
    calculate = function(self, card, context)
        if (context.end_of_round or context.reroll_shop or context.buying_card or
            context.selling_card or context.ending_shop or context.starting_shop or
            context.ending_booster or context.open_booster or
            context.skip_blind or context.before or context.pre_discard or context.setting_blind or
            context.using_consumeable) 
        then
            if pseudorandom("j_bfs_schro_cat") < 0.5 then
                card.ability.extra.xmult = math.max(0, card.ability.extra.xmult - card.ability.extra.xmult_mod)
				if card.ability.extra.xmult <0.01 then card.ability.extra.xmult = 0.01 end
            else
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
            end
            if card.ability.extra.xmult > card.ability.extra.max then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound("tarot1")
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = "after",
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                G.jokers:remove_card(card)
                                card:remove()
                                card = nil
                                return true
                            end
                        }))
                        return true
                    end
                }))
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
	bfs_credits = {
        idea = { "Glitchkat10", "seu pai" },
        art = { "Nice Cream" },
		code = { "Glitchkat10" }
	},
}
