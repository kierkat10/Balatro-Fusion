SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "mathematician",
    name = "Mathematician",
    input = {
        "j_scholar",
        "j_fibonacci",
    },
    output = "j_bfs_mathematician"
})

SMODS.Joker {
    key = "mathematician",
    name = "Mathematician",
    config = { 
        extra = { 
            repetitions = 1,
            chips = 21,
            mult = 13,
        }
    },
    pos = { x = 4, y = 2 },
    cost = 14,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = {
            card.ability.extra.repetitions,
            card.ability.extra.chips,
            card.ability.extra.mult
        } }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if context.other_card:get_id() == 14 then
                return {
                    repetitions = card.ability.extra.repetitions,
                    message = localize("k_again_ex"),
                    extra = {
                        chips = card.ability.extra.chips,
                        mult = card.ability.extra.mult,
                    },
                    card = card
                }
            elseif context.other_card:get_id() == 2 or context.other_card:get_id() == 3 or context.other_card:get_id() == 5 or context.other_card:get_id() == 8 then
                return {
                    chips = card.ability.extra.chips,
                    mult = card.ability.extra.mult,
                }
            end
        elseif context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 14 or context.other_card:get_id() == 2 or context.other_card:get_id() == 3 or context.other_card:get_id() == 5 or context.other_card:get_id() == 8 then
                return {
                    chips = card.ability.extra.chips,
                    mult = card.ability.extra.mult,
                }
            end
        end
    end,
    bfs_credits = {
        idea = { "ButterStutter" },
        art = { "MRJames246" },
		code = { "ButterStutter" }
	}
}