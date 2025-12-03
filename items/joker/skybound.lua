SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "skybound",
    name = "Skybound",
    input = {
        "j_cloud_9",
        "j_rocket"
    },
    output = "j_bfs_equal_evan"
})

SMODS.Joker{
    key = "skybound",
    name = "Skybound",
    config = {
        extra = {
            dollars = 1,
            dollars_mod = 1
        }
    },
    pos = { x = 0, y = 0 },
    cost = 8,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "placeholder",
    loc_vars = function(self, info_queue, card)
        local nine_tally = 0
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
                if playing_card:get_id() == 9 then nine_tally = nine_tally + 1 end
            end
        end
        return {
            vars = {
                card.ability.extra.dollars,
                card.ability.extra.dollars_mod,
                card.ability.extra.dollars * nine_tally
            }
        }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and context.beat_boss then
            card.ability.extra.dollars = card.ability.extra.dollars + card.ability.extra.dollars_mod
            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.MONEY
            }
        end
    end,
    calc_dollar_bonus = function(self, card)
        local nine_tally = 0
        for _, playing_card in ipairs(G.playing_cards) do
            if playing_card:get_id() == 9 then nine_tally = nine_tally + 1 end
        end
        return nine_tally > 0 and card.ability.extra.dollars * nine_tally or nil
    end,
	bfs_credits = {
        idea = { "Glitchkat10" },
		code = { "Glitchkat10" }
	}
}