SMODS.Booster {
    key = 'fusion_pack',
    name = 'Fusion Pack',
    config = { extra = 3, choose = 1 },
    group_key = "k_bfs_fusion_pack",
    kind = "Fusion",
    weight = 1.8, -- Currently 1.8 because only 1 unique pack. 1 * 1.8 = 1.8 total weight
    cost = 7,
    atlas = "booster", -- Uses temporary booster art for now, change later
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
            -- Determining the first Fusion input Joker, the same for all Cards in pack
            local possible_jokers = {}
            local rarity_pool_1 = {}
            local rarity_roll = math.random(1,100)
            if rarity_roll > 30 then
                rarity_pool_1 = G.P_JOKER_RARITY_POOLS[1] -- 70% common
            elseif rarity_roll > 25 then
                rarity_pool_1 = G.P_JOKER_RARITY_POOLS[3] -- 5% rare
            else
                rarity_pool_1 = G.P_JOKER_RARITY_POOLS[2] -- 25% uncommon
            end

            for _, joker in pairs(rarity_pool_1) do
                possible_jokers[#possible_jokers+1] = joker.key
            end

            local joker_key_input = pseudorandom_element(possible_jokers, 'random_key')

            -- Generating the other Fusion input Jokers, unique for each Card in pack
            local key_list = {}
            for _=1, card.ability.extra do
                local rarity_pool_2 = {}
                local rng_roll = math.random(1,1000)

                if rng_roll > 302 then
                    rarity_pool_2 = G.P_JOKER_RARITY_POOLS[1] -- 69.8% common
                elseif rng_roll > 298 then
                    rarity_pool_2 = G.P_JOKER_RARITY_POOLS[4] -- 0.4% legendary
                elseif rng_roll > 249 then 
                    rarity_pool_2 = G.P_JOKER_RARITY_POOLS[3] -- 4.9% rare
                else
                    rarity_pool_2 = G.P_JOKER_RARITY_POOLS[2] -- 24.9% uncommon
                end

                local possible_joker_fusions = {}
                for _, joker in pairs(rarity_pool_2) do
                    local result = SMODS.BalatroFusion.Fusion:get({joker_key_input, joker.key})
                    if result then
                        possible_joker_fusions[#possible_joker_fusions+1] = "j_bfs_"..result.key
                    end
                end

                if #possible_joker_fusions == 0 then
                    key_list[#key_list+1] = joker_key_input -- When not enough Fusions are coded, returns base Joker input
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
}
