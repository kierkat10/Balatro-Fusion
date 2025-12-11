SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "explosive_cola",
    name = "Explosive Cola",
    input = {
        "j_diet_cola",
        "j_crazy",
    },
    output = "j_bfs_explosive_cola"
})

SMODS.Joker {
    key = "explosive_cola",
    name = "Explosive Cola",
    config = { extra = { odds = 3 } },
    pos = { x = 3, y = 1 },
    cost = 13,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "basic-joker",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_TAGS.tag_double
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "j_bfs_explosive_cola")
        return {
            vars = {
                numerator,
                denominator
            }
        }
    end,
    calculate = function(self, card, context)
        if context.after and next(context.poker_hands["Straight"]) and SMODS.pseudorandom_probability(card, "j_bfs_explosive_cola", 1, card.ability.extra.odds) then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.5,
                func = function()    
                    local tag = G.P_TAGS["tag_double"]
                    add_tag(tag)
                    return true
                end,
            }))
            return {
                message = "Double Tag!",
                colour = G.C.Blue
            }
        end
    end,
	bfs_credits = {
        art = { "Nice Cream" },
        idea = { "The Wheel" },
		code = { "ButterStutter" }
	}
}