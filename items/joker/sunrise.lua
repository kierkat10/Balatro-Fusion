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
            sold_cards = 0,
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
                card.ability.extra.sold_cards,
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
            card.ability.extra.sold_cards = card.ability.extra.sold_cards + 1
            if card.ability.extra.sold_cards == 2 then
                card.ability.extra.sold_cards = 0
                card.ability.extra.repetitions = card.ability.extra.repetitions + 1
                card_eval_status_text(card, "extra", nil, nil, nil, { message = card.ability.extra.repetitions .. " retriggers!" })
            else
                card_eval_status_text(card, "extra", nil, nil, nil, { message = "1/2" })
            end
        end
        if context.end_of_round and context.game_over and G.GAME.blind.boss then
            card.ability.extra.repetitions = 0
            card_eval_status_text(card, "extra", nil, nil, nil, { message = "Reset" })
        end
    end,
	bfs_credits = {
        idea = { "Maple" },
        art = { "Maple" },
        code = { "ButterStutter" }
	}
}