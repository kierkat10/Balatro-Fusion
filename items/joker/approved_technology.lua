SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "approved_technology",
    name = "Approved Technology",
    input = {
        "j_certificate",
        "j_hologram",
    },
    output = "j_bfs_approved_technology"
})

SMODS.Joker {
    key = "approved_technology",
    name = "Approved Technology",
    config = { extra = { xmult = 0.5 } },
    pos = { x = 0, y = 0 },
    cost = 13,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "placeholder",
    loc_vars = function(self, info_queue, card)
        local count = 0
        for _, card in ipairs(G.playing_cards or {}) do
            if card.seal then
                count = count + 1 
            end
        end
        return {
            vars = {
                card.ability.extra.xmult,
                (card.ability.extra.xmult * count) + 1
            }
        }
    end,
    calculate = function(self, card, context)
        local count = 0
        for _, card in ipairs(G.playing_cards or {}) do
            if card.seal then
                count = count + 1 
            end
        end
        if context.joker_main then
            return {
                xmult = math.max(1, (card.ability.extra.xmult * count) + 1)
            }
        end
    end,
	bfs_credits = {
        idea = { "RandomGuy" },
		code = { "Glitchkat10" }
	}
}