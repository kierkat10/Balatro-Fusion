SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "sunrise",
    name = "Sunrise",
    input = {
        "j_campfire",
        "j_dusk",
    },
    output = "j_bfs_sunrise"
})

SMODS.Joker {
    key = "sunrise",
    name = "Sunrise",
    config = {
        extra = {
            cards_to_sell = 2,
            current = 0,
            requirement = 2,
            repetitions = 0,
        }
    },
    pos = { x = 5, y = 2 },
    cost = 14,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.cards_to_sell,
                card.ability.extra.current,
                card.ability.extra.requirement,
                card.ability.extra.repetitions,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if card.ability.extra.repetitions > 0 then
                return {
                    message = localize("k_again_ex"),
                    repetitions = card.ability.extra.repetitions,
                    card = card
                }
            end
        end
        if context.selling_card then
            card.ability.extra.current = card.ability.extra.current + 1
            if card.ability.extra.current == card.ability.extra.requirement then
                card.ability.extra.current = 0
                card.ability.extra.repetitions = card.ability.extra.repetitions + 1
                return { 
                    message = card.ability.extra.repetitions .. " retriggers!" 
                }
            else
                return { 
                    message = card.ability.extra.current .. "/" .. card.ability.extra.requirement
                }
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint and context.beat_boss and card.ability.extra.repetitions > 0 then
            card.ability.extra.repetitions = 0
            return {
                message = localize("k_reset")
            }
        end
    end,
	bfs_credits = {
        idea = { "Maple" },
        art = { "Maple" },
        code = { "ButterStutter" }
	}
}