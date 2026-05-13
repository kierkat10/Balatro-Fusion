return {
    key = "dyslexia",
    name = "Dyslexia",
    input = {
        "j_misprint",
        "j_hallucination"
    },
    joker = {
        pos = { x = 0, y = 0 },
        atlas = "placeholder",
        calculate = function(self,card,context)
            if context.create_booster_card then
                local card_type, forced_key = "", nil
                if context.booster.ability.name:find('Celestial') and G.GAME.used_vouchers.v_telescope and context.index == 1 then
                    local _hand, _tally = nil, 0
                    card_type = "Planet"
                    for _, v in ipairs(G.handlist) do
                        if G.GAME.hands[v].visible and G.GAME.hands[v].played > _tally then
                            _hand = v
                            _tally = G.GAME.hands[v].played
                        end
                    end
                    if _hand then
                        for _, v in pairs(G.P_CENTER_POOLS.Planet) do
                            if v.config.hand_type == _hand then
                                forced_key = v.key
                            end
                        end
                    end
                else
                    local booster_card_types = {"Tarot", "Spectral", "Planet", "Joker", "Enhanced", "Base"}
                    card_type = pseudorandom_element(booster_card_types, pseudoseed("dyslexia"))
                end
                return {
                    booster_create_flags = {
                        card_type = card_type,
                        forced_key = forced_key,
                        key_append = "dyslexia",
                        soulable = true
                    }
                }
            end
        end,
        bfs_credits = {
            code = { "ButterStutter" },
            idea = { "ButterStutter" }
        }
    }
}