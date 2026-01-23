SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "fudged",
    name = "Fudged Joker",
    input = {
        "j_scholar",
        "j_smeared",
    },
    output = "j_bfs_fudged"
})

SMODS.Joker {
    key = "fudged",
    name = "Fudged Joker",
    config = { extra = {
        chips = 10,
        mult = 3
    }},
    pos = { x = 8, y = 5 },
    cost = 14,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {vars = {
            card.ability.extra.chips,
            card.ability.extra.mult,
            G.GAME.current_round.fudged_1_card.id,
            G.GAME.current_round.fudged_2_card.id,
        }}
    end,
    set_ability = function(self, card, initial)
        G.GAME.current_round.fudged_1_card = { id = 2 }
        G.GAME.current_round.fudged_2_card = { id = 3 }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false then
            if G.playing_cards then
                local valid_ranks = {}
                for _, v in ipairs(G.playing_cards) do
                    if v.center ~= "m_stone" and v:get_id() <= 10 then
                        valid_ranks[#valid_ranks + 1] = v:get_id()
                    end
                end
                if valid_ranks[1] then
                    local first_rank = pseudorandom_element(valid_ranks, pseudoseed('fudge1' .. G.GAME.round_resets.ante))
                    G.GAME.current_round.fudged_1_card.id = first_rank
                    local valid_ranks_2 = {}
                    for i, v in ipairs(valid_ranks) do
                        if v ~= first_rank then
                            valid_ranks_2[#valid_ranks_2 + 1] = v
                        end
                    end
                    if valid_ranks_2[1] then
                        local second_rank = pseudorandom_element(valid_ranks_2, pseudoseed('fudge2' .. G.GAME.round_resets.ante))
                        G.GAME.current_round.fudged_2_card.id = second_rank
                    end
                end
            end
        end
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 14 then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult,
            }
        end
    end,
    bfs_credits = {
        idea = { "Maple Arc" },
        art = { "Maple Arc" },
		code = { "ButterStutter" }
	}
}

local card_get_id_ref = Card.get_id
function Card:get_id()
    local original_id = card_get_id_ref(self)
    if not original_id then return original_id end

    if next(SMODS.find_card("j_bfs_fudged")) then
        local source_ids = {G.GAME.current_round.fudged_1_card.id, G.GAME.current_round.fudged_2_card.id}
        for _, source_id in pairs(source_ids) do
            if original_id == source_id then return 14 end
        end
    end
    return original_id
end