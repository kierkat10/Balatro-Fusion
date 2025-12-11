SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "cherry_cola",
    name = "Cherryful Cola",
    input = {
        "j_diet_cola",
        "j_jolly",
    },
    output = "j_bfs_cherry_cola"
})

SMODS.Joker {
    key = "cherry_cola",
    name = "Cherryful Cola",
    config = { extra = { odds = 6 } },
    pos = { x = 0, y = 1 },
    cost = 13,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "basic-joker",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_TAGS.tag_double
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "j_bfs_cherry_cola")
        return {
            vars = {
                numerator,
                denominator
            }
        }
    end,
    calculate = function(self, card, context)
        if context.after and next(context.poker_hands["Pair"]) and SMODS.pseudorandom_probability(card, "j_bfs_cherry_cola", 1, card.ability.extra.odds) then
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