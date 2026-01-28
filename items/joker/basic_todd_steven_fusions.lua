local function check_rank(v, required_rank, id)
    if id and (v:get_id() == 3 or v:get_id() == 5 or v:get_id() == 7 or v:get_id() == 9 or v:get_id() == 14) or (v == 3 or v == 5 or v == 7 or v == 9 or v == 14) then
        if required_rank == "odd" then
            return true
        else
            return false
        end
    elseif id and (v:get_id() == 2 or v:get_id() == 4 or v:get_id() == 6 or v:get_id() == 8 or v:get_id() == 10) or (v == 2 or v == 4 or v == 6 or v == 8 or v == 10) then
        if required_rank == "even" then
            return true
        else
            return false
        end
    else 
        return false
    end
end

local function matching_ranks_logic(context, required_value, required_matching_ranks, required_rank)
    local matching_ranks = {}
    for i = 2, 13 do
        local count = 0
        for _, v in ipairs(context.scoring_hand) do 
            if v:get_id() == i then
                count = count + 1
            end
        end
        if count >= required_value then 
            matching_ranks[#matching_ranks+1] = i
        end
    end
    local valid_ranks = 0
    for _, v in pairs(matching_ranks) do 
        if check_rank(v, required_rank, false) then
            valid_ranks = valid_ranks + 1
        end
    end 
    return valid_ranks >= required_matching_ranks
end

local function check_rank_majority(context, required_rank)
    local valid_count = 0
    local invalid_count = 0
    for _, v in ipairs(context.scoring_hand) do 
        if check_rank(v, required_rank, true) then
            valid_count = valid_count + 1
        else
            invalid_count = invalid_count + 1
        end
    end
    return valid_count > invalid_count
end

local function check_score(context, type, rank_type)
    if type == "Pair" then
        return matching_ranks_logic(context, 2, 1, rank_type)
    end
    if type == "Three of a Kind" then
        return matching_ranks_logic(context, 3, 1, rank_type)
    end
    if type == "Two Pair" then
        return matching_ranks_logic(context, 2, 2, rank_type)
    end
    if type == "Straight" then
        return next(context.poker_hands["Straight"]) and check_rank_majority(context, rank_type)
    end
    if type == "Flush" then
        return next(context.poker_hands["Flush"]) and check_rank_majority(context, rank_type)
    end
end

local function generate_fusion(key, name, hand_type, scoring_type, scoring_amount, rank_type)
    local input = {}
    if rank_type == "odd" then
        input[1] = "j_odd_todd"
        input[2] = "j_"..key:sub(1, -6)
    else
        input[1] = "j_even_steven"
        input[2] = "j_"..key:sub(1, -8)
    end

    local pos = { x = 0, y = 2 }
    if rank_type == "even" then
        pos.y = 3
    end
    if scoring_type == "chips" then
        pos.x = 5
    end
    local hands = {"Pair", "Three of a Kind", "Two Pair", "Straight", "Flush"}
    for i, v in ipairs(hands) do
        if v == hand_type then
            pos.x = pos.x + i - 1
        end
    end

    local extra = { mult = nil, chips = nil }
    if scoring_type == "chips" then
        extra.chips = scoring_amount
    else
        extra.mult = scoring_amount
    end

    local loc_vars = {
        mult = function(self, info_queue, card) return { vars = { card.ability.extra.mult }} end,
        chips = function(self, info_queue, card) return { vars = { card.ability.extra.chips }} end
    }

    return {
        key = key,
        name = name,
        input = { input[1], input[2] },
        joker = {
            config = { extra = { mult = extra.mult, chips = extra.chips }},
            pos = {x = pos.x, y = pos.y},
            blueprint_compat = true,
            atlas = "basic-joker",
            loc_vars = loc_vars[scoring_type],
            calculate = function(self, card, context)
                if context.joker_main and check_score(context, hand_type, rank_type) then
                    if scoring_type == "chips" then
                        return { chips = card.ability.extra.chips }
                    else
                        return { mult = card.ability.extra.mult }
                    end
                end
            end,
            bfs_credits = {
                idea = { "ButterStutter" },
                art = { "ButterStutter" },
                code = { "ButterStutter" }
            }
        }
    }
end

return {
    generate_fusion("jolly_todd", "Jolly Todd", "Pair", "mult", 13, "odd"),
    generate_fusion("jolly_steven", "Jolly Steven", "Pair", "mult", 14, "even"),
    generate_fusion("zany_todd", "Zany Todd", "Three of a Kind", "mult", 19, "odd"),
    generate_fusion("zany_steven", "Zany Steven", "Three of a Kind", "mult", 20, "even"),
    generate_fusion("mad_todd", "Mad Todd", "Two Pair", "mult", 21, "odd"),
    generate_fusion("mad_steven", "Mad Steven", "Two Pair", "mult", 22, "even"),
    generate_fusion("crazy_todd", "Crazy Todd", "Straight", "mult", 25, "odd"),
    generate_fusion("crazy_steven", "Crazy Steven", "Straight", "mult", 26, "even"),
    generate_fusion("droll_todd", "Droll Todd", "Flush", "mult", 23, "odd"),
    generate_fusion("droll_steven", "Droll Steven", "Flush", "mult", 24, "even"),
    generate_fusion("sly_todd", "Sly Todd", "Pair", "chips", 85, "odd"),
    generate_fusion("sly_steven", "Sly Steven", "Pair", "chips", 88, "even"),
    generate_fusion("wily_todd", "Wily Todd", "Three of a Kind", "chips", 145, "odd"),
    generate_fusion("wily_steven", "Wily Steven", "Three of a Kind", "chips", 150, "even"),
    generate_fusion("clever_todd", "Clever Todd", "Two Pair", "chips", 135, "odd"),
    generate_fusion("clever_steven", "Clever Steven", "Two Pair", "chips", 140, "even"),
    generate_fusion("devious_todd", "Devious Todd", "Straight", "chips", 153, "odd"),
    generate_fusion("devious_steven", "Devious Steven", "Straight", "chips", 156, "even"),
    generate_fusion("crafty_todd", "Crafty Todd", "Flush", "chips", 163, "odd"),
    generate_fusion("crafty_steven", "Crafty Steven", "Flush", "chips", 166, "even"),
}