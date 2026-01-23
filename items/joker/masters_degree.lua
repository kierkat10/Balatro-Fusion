SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "masters_degree",
    name = "Master's Degree",
    input = {
        "j_scholar",
        "j_certificate",
    },
    output = "j_bfs_masters_degree"
})

SMODS.Joker {
    key = "masters_degree",
    name = "Master's Degree",
    config = { 
        extra = { 
            chips = 25,
            mult = 5,
        }
    },
    pos = { x = 4, y = 10 },
    cost = 14,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = {
            card.ability.extra.chips,
            card.ability.extra.mult
        } }
    end,
    calculate = function(self, card, context)
        if context.first_hand_drawn then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local _rank = 'A'
                    local _suit = pseudorandom_element({'S','H','D','C'}, pseudoseed('master_create'))
                    local cen_pool = {}
                    for _, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                        if v.key ~= 'm_stone' then 
                            cen_pool[#cen_pool+1] = v
                        end
                    end
                    local _card = create_playing_card({
                        front = G.P_CARDS[_suit..'_'.._rank],
                        center = pseudorandom_element(cen_pool, pseudoseed('master_ce'))},
                        G.hand, nil, nil, {G.C.SECONDARY_SET.Enhanced}
                    )
                    G.GAME.blind:debuff_card(_card)
                    G.hand:sort()
                    if context_blueprint_card then 
                        context_blueprint_card:juice_up() 
                    else
                        card:juice_up() 
                    end
                    playing_card_joker_effects({_card})
                    save_run()
                    return true
                end}))  
            return nil, true
        end
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 14 then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult,
            }
        end
    end,
    bfs_credits = {
        idea = { "iwas_nevergood" },
        art = { "iwas_nevergood" },
		code = { "ButterStutter" }
	}
}