SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "grat_brat",
    name = "Grat Brat",
    input = {
        "j_delayed_grat",
        "j_riff_raff",
    },
    output = "j_bfs_grat_brat"
})

SMODS.Joker{
    key = "grat_brat",
    name = "Grat Brat",
    config = {
        extra={
        dollars=2,
        
        },
    },
    pos = nil,
    cost = 10,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = nil,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult_mod,
                card.ability.extra.max,
                card.ability.extra.xmult
            }
        }
    end,
    calc_dollar_bonus = function(self,card)
      local commons_owned = 0
      for i,v in pairs(G.jokers.cards) do
      if v:is_rarity("Common") then commons_owned=commons_owned+1 if commons_owned >=2 then break end
      end
      if G.GAME.current_round.discards_used == 0 and G.GAME.current_round.discards_left >0 or commons_owned >=2 then
        local dollars = G.GAME.current_round.discards_left*card.ability.extra.dollars
        if commons_owned >=2 then dollars=dollars*2 end
       end
    end,
	bfs_credits = {
        idea = { "RandomGuy" },
        art = { "StellarBlue" },
		code = { "Lact4" }
	},
}
