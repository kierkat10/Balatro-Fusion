function BalatroFusion.create_booster_pack_card(booster, booster_obj, i)
    local card = nil

    if booster_obj.create_card and type(booster_obj.create_card) == "function" then
        local _card_to_spawn = booster_obj:create_card(booster, i)
        if type((_card_to_spawn or {}).is) == 'function' and _card_to_spawn:is(Card) then
            card = _card_to_spawn
        else
            card = SMODS.create_card(_card_to_spawn)
        end

    elseif booster.ability.name:find('Arcana') then
        if G.GAME.used_vouchers.v_omen_globe and pseudorandom('omen_globe') > 0.8 then
            card = create_card("Spectral", G.pack_cards, nil, nil, true, true, nil, 'ar2')
        else
            card = create_card("Tarot", G.pack_cards, nil, nil, true, true, nil, 'ar1')
        end

    elseif booster.ability.name:find('Celestial') then
        if G.GAME.used_vouchers.v_telescope and i == 1 then
            local _planet, _hand, _tally = nil, nil, 0
            for k, v in ipairs(G.handlist) do
                if G.GAME.hands[v].visible and G.GAME.hands[v].played > _tally then
                    _hand = v
                    _tally = G.GAME.hands[v].played
                end
            end
            if _hand then
                for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                    if v.config.hand_type == _hand then
                        _planet = v.key
                    end
                end
            end
            card = create_card("Planet", G.pack_cards, nil, nil, true, true, _planet, 'pl1')
        else
            card = create_card("Planet", G.pack_cards, nil, nil, true, true, nil, 'pl1')
        end

    elseif booster.ability.name:find('Spectral') then
        card = create_card("Spectral", G.pack_cards, nil, nil, true, true, nil, 'spe')

    elseif booster.ability.name:find('Standard') then
        card = create_card((pseudorandom(pseudoseed('stdset'..G.GAME.round_resets.ante)) > 0.6) and "Enhanced" or "Base", G.pack_cards, nil, nil, nil, true, nil, 'sta')

        local edition_rate = 2
        local edition = poll_edition('standard_edition'..G.GAME.round_resets.ante, edition_rate, true)
        card:set_edition(edition)
        card:set_seal(SMODS.poll_seal({mod = 10}), true, true)

    elseif booster.ability.name:find('Buffoon') then
        card = create_card("Joker", G.pack_cards, nil, nil, true, true, nil, 'buf')
    end

    if card then
        if booster.ability.name:find('Standard') then

            if next(SMODS.find_card("j_bfs_ghoul")) and card.config.center ~= G.P_CENTERS.c_base then
                card:set_ability(G.P_CENTERS.c_base)
            end

        end
    end
    return card
end