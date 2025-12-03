SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "politician",
    name = "Politician",
    input = {
        "j_hack",
        "j_hanging_chad"
    },
    output = "j_bfs_politician"
})


SMODS.Joker {
    key = "politician",
    name = "Politician",
    config = { extra = { repetitions = 3 } },
    pos = { x = 0, y = 1 },
    cost = 10,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.repetitions } }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if not context.other_card:is_face() then
                return {
                    repetitions = card.ability.extra.repetitions
                }
            end
        end
    end,
	bfs_credits = {
        idea = { "SnowPickle" },
        art = { "Nice Cream" },
		code = { "Glitchkat10" }
	}
}
