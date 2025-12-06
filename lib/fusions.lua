local emplace_areas = setmetatable({}, {
    __index = function(t, k)
        local fn = loadstring("return " .. k)()
        rawset(t, k, fn)
        return fn
    end
})

local last_start_run = Game.start_run
function Game:start_run(args)
    if SMODS.BalatroFusion and SMODS.BalatroFusion.Fusion then
        SMODS.BalatroFusion.Fusion:clear()
    end
    local r = last_start_run(self, args)
    G.E_MANAGER:add_event(Event({
        func = function()
            if G.consumeables and G.consumeables.config and G.consumeables.config.highlighted_limit then
                G.consumeables.config.highlighted_limit = 1e300
                G.jokers.config.highlighted_limit = 1e300
                return true
            end
        end,
        blocking = false
    }))
    return r
end

local FusionClass = {}
local available_fusions = {}
local stored_fusions = {}
local fusion_index = {}

function FusionClass:rebuild_index()
    fusion_index = {}
    for _, fusion in ipairs(available_fusions) do
        if fusion.input then
            for _, input in ipairs(fusion.input) do
                local key = type(input) == "table" and input.target or input
                fusion_index[key] = fusion_index[key] or {}
                table.insert(fusion_index[key], fusion)
            end
        end
    end
end

function FusionClass:clear()
    if #available_fusions == 0 then
        available_fusions = {}
        stored_fusions = {}
        fusion_index = {}
        collectgarbage()
    end
end

function FusionClass:cleanup()
    local new_available = {}
    for _, fusion in ipairs(available_fusions) do
        if fusion.is_valid ~= false then
            table.insert(new_available, fusion)
        end
    end
    if #new_available < #available_fusions then
        available_fusions = new_available
        self:rebuild_index()
        collectgarbage()
    end
end

function FusionClass:new(t)
    local new_fusion = setmetatable({}, FusionClass)
    new_fusion.name = t.name
    new_fusion.key = t.key
    new_fusion.input = t.input
    new_fusion.output = t.output
    new_fusion.required_value = t.required_value or (t.input and #t.input) or 0
    new_fusion.check_op = t.check_op or "=="
    new_fusion.is_valid = true

    if t.store_key then
        stored_fusions[t.key] = t
    end

    table.insert(available_fusions, new_fusion)
    self:rebuild_index()
    return new_fusion
end

function FusionClass:new_generic(t)
    t = copy_table(t)
    if t.id ~= "joker_fusion" then
        return nil
    end

    local output = {}
    local input = {}

    if type(t.output) == "string" then
        table.insert(output, {
            id = "create_card",
            args = {
                key = t.output
            },
            emplace_area = "G.jokers"
        })
    else
        for _, v in ipairs(t.output) do
            table.insert(output, {
                id = "create_card",
                args = {
                    key = v
                },
                emplace_area = "G.jokers"
            })
        end
    end

    for _, v in ipairs(t.input) do
        table.insert(input, {
            target = v,
            input_worth = 1
        })
    end

    t.output = output
    t.input = input
    return FusionClass:new(t)
end

local function check_condition(op, a, b)
    if op == "==" then
        return a == b
    end
    if op == ">=" then
        return a >= b
    end
    if op == "<=" then
        return a <= b
    end
    if op == ">" then
        return a > b
    end
    if op == "<" then
        return a < b
    end
    return false
end

function FusionClass:can_fuse(fusion, input)
    if not fusion or not fusion.input or not input then
        return false
    end

    local current_value = 0
    local input_keys = {}
    local input_count = 0

    for _, card in ipairs(input) do
        if card and card.config and card.config.center then
            local key = card.config.center.key
            input_keys[key] = (input_keys[key] or 0) + 1
            input_count = input_count + 1
        end
    end

    if input_count < #fusion.input then
        return false
    end

    local matched_inputs = 0
    local input_requirements = {}

    for _, input_req in ipairs(fusion.input) do
        local target = input_req.target or input_req
        input_requirements[target] = (input_requirements[target] or 0) + 1
    end

    for target, required in pairs(input_requirements) do
        local available = input_keys[target] or 0
        if available < required then
            return false
        end
        matched_inputs = matched_inputs + 1
        current_value = current_value + (available * (input_requirements.input_worth or 1))
    end

    if fusion.check_op and fusion.required_value then
        return check_condition(fusion.check_op, current_value, fusion.required_value)
    end

    return matched_inputs > 0
end

function FusionClass:fuse(fusion, input)
    self:handle_destroying(fusion, input)
    self:handle_output(fusion, input)
end

function FusionClass:handle_destroying(fusion, input)
    local cards_to_destroy = {}
    local current_value = 0

    for _, card in ipairs(input) do
        for _, input_req in ipairs(fusion.input) do
            if input_req.target == card.config.center.key then
                table.insert(cards_to_destroy, card)
                current_value = current_value + (input_req.input_worth or 1)
            end
            if check_condition(fusion.check_op or "==", current_value, fusion.required_value or 0) then
                break
            end
        end
    end

    for _, card in ipairs(cards_to_destroy) do
        card:start_dissolve()
    end
end

function FusionClass:handle_output(fusion, _)
    if not fusion or not fusion.output then
        return
    end

    for _, output in ipairs(fusion.output) do
        if output.id == "create_card" and output.emplace_area then
            local created_card = SMODS.create_card(output.args)
            if created_card then
                local area_to_emplace = emplace_areas[output.emplace_area]
                if area_to_emplace then
                    created_card:add_to_deck()
                    area_to_emplace:emplace(created_card)
                end
            end
        end
    end
end

function FusionClass:get(input)
    if not input or #input == 0 then
        return nil
    end

    local input_counts = {}
    for _, card in ipairs(input) do
        if card and card.config and card.config.center then
            local key = card.config.center.key
            input_counts[key] = (input_counts[key] or 0) + 1
        end
    end

    local best_fusion, best_score = nil, -1
    local potential_fusions = {}

    for card_key, _ in pairs(input_counts) do
        if fusion_index[card_key] then
            for _, fusion in ipairs(fusion_index[card_key]) do
                potential_fusions[fusion] = true
            end
        end
    end

    if not next(potential_fusions) then
        for _, fusion in ipairs(available_fusions) do
            potential_fusions[fusion] = true
        end
    end

    for fusion, _ in pairs(potential_fusions) do
        if self:can_fuse(fusion, input) then
            local remaining_inputs = {}
            for k, v in pairs(input_counts) do
                remaining_inputs[k] = v
            end

            local score = 0
            local all_requirements_met = true

            for _, input_req in ipairs(fusion.input) do
                local target = input_req.target
                local required = input_req.required or 1

                if remaining_inputs[target] and remaining_inputs[target] >= required then
                    score = score + (remaining_inputs[target] == required and 10 or 5)
                    remaining_inputs[target] = remaining_inputs[target] - required
                else
                    all_requirements_met = false
                    break
                end
            end

            if all_requirements_met then
                local has_remaining = false
                for _, count in pairs(remaining_inputs) do
                    if count > 0 then
                        has_remaining = true;
                        break
                    end
                end
                if not has_remaining then
                    score = score + 100
                end
                if score > best_score then
                    best_score, best_fusion = score, fusion
                end
            end
        end
    end

    return best_fusion
end

SMODS.BalatroFusion.Fusion = FusionClass
