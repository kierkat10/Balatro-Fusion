local function check_joker(joker)
    if joker.config.center.key == "j_stencil" then
        return false
    elseif joker.config.center.rarity ~= "bfs_fused" then
        return true
    end
    local fusion_inputs = SMODS.BalatroFusion.Fusion:get_input_jokers(joker.config.center.key)
    if not fusion_inputs then return true end
    for _, v in ipairs(fusion_inputs) do
        if v == "j_stencil" then
            return false
        end
    end
    -- Implement exceptions when stencil fusions that use the exceptions are added
    return true
end

local function check_consumable(consumable)
    -- Implement exceptions when stencil fusions that use the exceptions are added
    return true
end

local function check_playing_card(card)
    -- Implement exceptions when stencil fusions that use the exceptions are added
    return true
end

local function get_gap_count_for_card_area(card_areas) -- {location, type}
    local total_gaps = 0
    local area_functions = {
        joker = function(v) return check_joker(v) end,
        consumable = function(v) return check_consumable(v) end,
        playing_card = function(v) return check_playing_card(v) end
        -- possibly add other types if they get used
    }
    local areas = {
        jokers = (G.jokers and G.jokers.cards or {}),
        consumables = (G.consumeables and G.consumeables.cards or {})
        -- add playing card areas
    }
    local sizes = {
        jokers = (G.jokers and G.jokers.config and G.jokers.config.card_limit or 5),
        consumables = (G.consumeables and G.consumeables.config and G.consumeables.config.card_limit or 2)
        -- add playing card areas
    }

    for _, area in ipairs(card_areas) do
        local area_filled_gaps = 0
        for _, v in pairs(areas[area.location]) do
            if area_functions[area.type](v) then
                area_filled_gaps = area_filled_gaps + 1
            end
        end
        local area_gaps = sizes[area.location] - area_filled_gaps
        total_gaps = area_gaps + total_gaps
    end

    return total_gaps
end

local function generate_fusion(key, name, input_2, position, scoring_type, scoring_amount, card_areas, credits)
    local input = {}
    input[1] = "j_stencil"
    input[2] = input_2

    local pos = position or { x = 0, y = 0 }
    local atlas = position and "joker" or "placeholder"

    local extra = { dollars = nil, xchips = nil, xmult = nil, mult = nil, chips = nil }
    extra[scoring_type] = {
        initial = scoring_amount.initial,
        scaling = scoring_amount.scaling
    }

    local scoring = {
        chips = function(amount) return { chips = amount } end,
        mult = function(amount) return { mult = amount } end,
        xchips = function(amount) return { xchips = amount } end,
        xmult = function(amount) return { xmult = amount } end,
        dollars = function(amount) return { dollars = amount } end,
    }

    return {
        key = key,
        name = name,
        input = { input[1], input[2] },
        joker = {
            config = { extra = { mult = extra.mult, chips = extra.chips, xmult = extra.xmult, xchips = extra.xchips, dollars = extra.dollars }},
            pos = {x = pos.x, y = pos.y},
            blueprint_compat = true,
            atlas = atlas,
            loc_vars = function(self, info_queue, card)
                local initial = card.ability.extra[scoring_type].initial
                local scaling = card.ability.extra[scoring_type].scaling
                return { vars = {
                    scaling,
                    initial + scaling * get_gap_count_for_card_area(card_areas)
                }}
            end,
            calculate = function(self, card, context)
                if context.joker_main then -- Implement other conditions when jokers that use them are added
                    local initial = card.ability.extra[scoring_type].initial
                    local scaling = card.ability.extra[scoring_type].scaling
                    local amount = initial + scaling * get_gap_count_for_card_area(card_areas)
                    return scoring[scoring_type](amount)
                end
            end,
            bfs_credits = credits
        }
    }
end

return {
    generate_fusion(
        "jigsaw",
        "Jigsaw Joker",
        "j_stencil",
        { x = 3, y = 2},
        "xmult",

        { initial = 0, scaling = 1.2 },
        {
            { location = "jokers", type = "joker" },
            { location = "consumables", type = "consumable" }
        },
        {
            idea = { "ButterStutter" },
            art = { "King" },
            code = { "ButterStutter" }
        }
    )
}