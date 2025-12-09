SMODS.Booster {
    key = 'fusion_pack',
    name = 'Fusion Pack',
    config = { extra = 3, choose = 1 },
    atlas = "booster",
    group_key = "k_bfs_fusion_pack",
    kind = "Fusion",
    weight = 1,
    cost = 1,
    pos = { x = 0, y = 0 },
    discovered = true,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or card.config.extra
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    create_card = function(self, card, i)
        if i == 1 then
            local possible_jokers = {}
            local rarity_pool_1 = {}
            local rarity_pool_2 = {}
            if math.random(1,4) == 2 then
                rarity_pool_1 = G.P_JOKER_RARITY_POOLS[2]
            else
                rarity_pool_1 = G.P_JOKER_RARITY_POOLS[1]
            end

            local rng_roll = math.random(1,20)
            
            if rng_roll == 15 then
                rarity_pool_2 = G.P_JOKER_RARITY_POOLS[3]
            elseif rng_roll > 15 then
                rarity_pool_2 = G.P_JOKER_RARITY_POOLS[2]
            else
                rarity_pool_2 = G.P_JOKER_RARITY_POOLS[1]
            end

            for _, joker in pairs(rarity_pool_1) do
                possible_jokers[#possible_jokers+1] = joker.key
            end

            if not card.ability.joker_key then
                card.ability.joker_key = pseudorandom_element(possible_jokers, 'random_key')
            end
            local joker_key_input = card.ability.joker_key
            local possible_joker_fusions = {}
            for _, joker in pairs(rarity_pool_2) do
                local result = SMODS.BalatroFusion.Fusion:get({joker_key_input, joker.key})
                if result then
                    possible_joker_fusions[#possible_joker_fusions+1] = "j_bfs_"..result.key
                end
            end
            local key_list = {}
            for _=1, card.ability.extra do
                if #possible_joker_fusions == 0 then
                    key_list[#key_list+1] = card.ability.joker_key
                else
                    local index = math.random(#possible_joker_fusions)
                    key_list[#key_list+1] = possible_joker_fusions[index]
                    table.remove(possible_joker_fusions, index)
                end
            end
            card.ability.fusion_list = key_list
        end
        return {
            key = card.ability.fusion_list[i],
            set = "Joker",
            area = G.pack_cards,
            skip_materialize = true,
        }
    end,
    particles = function(self)
        -- No particles for joker packs
        end,
    }
