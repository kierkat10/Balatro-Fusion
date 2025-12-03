SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "sparkling_wine",
    name = "Sparkling Wine",
    input = {
        "j_diet_cola",
        "j_selzer",
    },
    output = "j_bfs_sparkling_wine"
})

SMODS.Joker {
    key = "sparkling_wine",
    name = "Sparkling Wine",
    config = { extra = { blinds = 10 } },
    pos = { x = 9, y = 0 },
    cost = 15,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.blinds } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local selected_tag = pseudorandom_element(G.P_TAGS, pseudoseed("j_bfs_sparkling_wine")).key
                    local tag = Tag(selected_tag)
                    if tag.name == "Orbital Tag" then
                        local _poker_hands = {}
                        for k, v in pairs(G.GAME.hands) do
                            if v.visible then
                                _poker_hands[#_poker_hands + 1] = k
                            end
                        end
                        tag.ability.orbital_hand = pseudorandom_element(_poker_hands, "j_bfs_sparkling_wine")
                    end
                    tag:set_ability()
                    add_tag(tag)
                    play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
                    return true
                end
            }))
            card.ability.extra.blinds = card.ability.extra.blinds - 1
        end
    end,
	bfs_credits = {
        idea = { "Nice Cream" },
        art = { "Nice Cream" },
		code = { "Glitchkat10" }
	}
}