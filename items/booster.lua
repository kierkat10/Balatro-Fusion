SMODS.Booster {
    key = 'fusion_pack_1',
    name = 'Fusion Pack',
    config = { extra = 3, choose = 1 },
    group_key = "k_bfs_fusion_pack",
    kind = "Fusion",
    weight = 1,
    cost = 7,
    atlas = "booster", -- Uses temporary booster art for now, change later
    pos = { x = 0, y = 0 },
    discovered = true,
    in_pool = function(self, args)
        if G.GAME.selected_back.name == "Fusion Deck" then
            return true
        else
            return false
        end
    end,
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
                    if result and (function()
                        for _, v in ipairs(key_list) do
                            if v == "j_bfs_"..result.key then
                                return false
                            end
                        end
                        return true
                    end)() then
                        possible_joker_fusions[#possible_joker_fusions+1] = "j_bfs_"..result.key
                    end
                end

                if #possible_joker_fusions == 0 then
                    key_list[#key_list+1] = joker_key_input -- When not enough Fusions are coded, returns base Joker input
                else
                    local joker_key = pseudorandom_element(possible_joker_fusions)
                    key_list[#key_list+1] = joker_key
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

SMODS.Booster {
    key = 'fusion_pack_2',
    name = 'Fusion Pack',
    config = { extra = 3, choose = 1 },
    group_key = "k_bfs_fusion_pack",
    kind = "Fusion",
    weight = 0.8,
    cost = 7,
    atlas = "booster", -- Uses temporary booster art for now, change later
    pos = { x = 0, y = 0 },
    discovered = true,
    in_pool = function(self, args)
        if G.GAME.selected_back.name == "Fusion Deck" then
            return true
        else
            return false
        end
    end,    
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
            if rarity_roll > 38 then
                rarity_pool_1 = G.P_JOKER_RARITY_POOLS[1] -- 62% common
            elseif rarity_roll > 30 then
                rarity_pool_1 = G.P_JOKER_RARITY_POOLS[3] -- 8% rare
            else
                rarity_pool_1 = G.P_JOKER_RARITY_POOLS[2] -- 30% uncommon
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
                    if result and (function()
                        for _, v in ipairs(key_list) do
                            if v == "j_bfs_"..result.key then
                                return false
                            end
                        end
                        return true
                    end)() then
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

SMODS.Booster {
    key = 'jumbo_fusion_pack_1',
    name = 'Jumbo Fusion Pack',
    config = { extra = 5, choose = 1 },
    group_key = "k_bfs_fusion_pack",
    kind = "Fusion",
    weight = 0.45,
    cost = 9,
    atlas = "booster", -- Uses temporary booster art for now, change later
    pos = { x = 0, y = 0 },
    discovered = true,
    in_pool = function(self, args)
        if G.GAME.selected_back.name == "Fusion Deck" then
            return true
        else
            return false
        end
    end,    
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
            if rarity_roll > 35 then
                rarity_pool_1 = G.P_JOKER_RARITY_POOLS[1] -- 65% common
            elseif rarity_roll > 28 then
                rarity_pool_1 = G.P_JOKER_RARITY_POOLS[3] -- 7% rare
            else
                rarity_pool_1 = G.P_JOKER_RARITY_POOLS[2] -- 28% uncommon
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
                    if result and (function()
                        for _, v in ipairs(key_list) do
                            if v == "j_bfs_"..result.key then
                                return false
                            end
                        end
                        return true
                    end)() then
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

SMODS.Booster {
    key = 'mega_fusion_pack_1',
    name = 'Mega Fusion Pack',
    config = { extra = 5, choose = 2 },
    group_key = "k_bfs_fusion_pack",
    kind = "Fusion",
    weight = 0.12,
    cost = 12,
    atlas = "booster", -- Uses temporary booster art for now, change later
    pos = { x = 0, y = 0 },
    discovered = true,
    in_pool = function(self, args)
        if G.GAME.selected_back.name == "Fusion Deck" then
            return true
        else
            return false
        end
    end,    
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
            if rarity_roll > 38 then
                rarity_pool_1 = G.P_JOKER_RARITY_POOLS[1] -- 62% common
            elseif rarity_roll > 29 then
                rarity_pool_1 = G.P_JOKER_RARITY_POOLS[3] -- 9% rare
            else
                rarity_pool_1 = G.P_JOKER_RARITY_POOLS[2] -- 29% uncommon
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
                    if result and (function()
                        for _, v in ipairs(key_list) do
                            if v == "j_bfs_"..result.key then
                                return false
                            end
                        end
                        return true
                    end)() then
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

