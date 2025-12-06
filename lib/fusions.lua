local emplace_areas = setmetatable({}, {
    __index = function(t, k)
        local fn = loadstring("return " .. k)()
        rawset(t, k, fn)
        return fn
    end
})

local last_start_run = Game.start_run
function Game:start_run(args)
    local r = last_start_run(self, args)
    if SMODS.BalatroFusion and SMODS.BalatroFusion.Fusion then
        SMODS.BalatroFusion.Fusion:clear()
    end
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
                fusion_index[input.target] = fusion_index[input.target] or {}
                table.insert(fusion_index[input.target], fusion)
            end
        end
    end
end

function FusionClass:clear()
    available_fusions = {}
    stored_fusions = {}
    fusion_index = {}
    collectgarbage()
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
    new_fusion.required_value = t.required_value or #new_fusion.input
    new_fusion.check_op = t.check_op or "=="
    new_fusion.is_valid = true
    
    if t.store_key then
        stored_fusions[t.key] = t
    end
    
    table.insert(available_fusions, new_fusion)
    
    if new_fusion.input then
        for _, input in ipairs(new_fusion.input) do
            fusion_index[input.target] = fusion_index[input.target] or {}
            table.insert(fusion_index[input.target], new_fusion)
        end
    end
    
    return new_fusion
end

function FusionClass:new_generic(t)
    t = copy_table(t)
    if t.id == "joker_fusion" then
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
            for i, v in ipairs(t.output) do
                table.insert(output, {
                    id = "create_card",
                    args = {
                        key = v
                    },
                    emplace_area = "G.jokers"
                })
            end
        end
        for i, v in ipairs(t.input) do
            table.insert(input, {
                target = v,
                input_worth = 1
            })
        end
        t.output = output
        t.input = input
        FusionClass:new(t)
    end
end

local function check_condition(check_op, current_value, required_value)
    if check_op == "==" then
        return current_value == required_value
    elseif check_op == ">=" then
        return current_value >= required_value
    elseif check_op == "<=" then
        return current_value <= required_value
    elseif check_op == ">" then
        return current_value > required_value
    elseif check_op == "<" then
        return current_value < required_value
    end
    return false
end

function FusionClass:can_fuse(fusion, input)
    if not fusion or not fusion.input or not input then return false end
    
    local current_value = 0
    local input_keys = {}
    
    for _, card in ipairs(input) do
        if card and card.config and card.config.center then
            input_keys[card.config.center.key] = (input_keys[card.config.center.key] or 0) + 1
        end
    end
    
    for _, input_req in ipairs(fusion.input) do
        local count = input_keys[input_req.target] or 0
        current_value = current_value + (count * (input_req.input_worth or 1))
        
        if fusion.check_op == "<" and current_value >= fusion.required_value then
            return false
        elseif fusion.check_op == "<=" and current_value > fusion.required_value then
            return false
        end
    end
    
    return check_condition(fusion.check_op, current_value, fusion.required_value)
end

function FusionClass:fuse(fusion, input)
    self:handle_destroying(fusion, input)
    self:handle_output(fusion, input)
end

function FusionClass:handle_destroying(fusion, input)
    local cards_to_destroy = {}
    local current_value = 0
    local function check()
        if fusion.check_op == "==" then
            return current_value == fusion.required_value
        end
        if fusion.check_op == ">=" then
            return current_value >= fusion.required_value
        end
        if fusion.check_op == "<=" then
            return current_value <= fusion.required_value
        end
        if fusion.check_op == ">" then
            return current_value > fusion.required_value
        end
        if fusion.check_op == "<" then
            return current_value < fusion.required_value
        end
        return false
    end
    for x, l in ipairs(input) do
        for i, v in ipairs(fusion.input) do
            if v.target == l.config.center.key then
                table.insert(cards_to_destroy, l)
                current_value = current_value + (v.input_worth or 1)
            end
            if check() == true then
                break
            end
        end
    end

    for i, v in ipairs(cards_to_destroy) do
        v:start_dissolve()
    end
end

function FusionClass:handle_output(fusion, input)
    if not fusion or not fusion.output then return end
    
    for i, output in ipairs(fusion.output) do
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
    if not input or #input == 0 then return nil end
    
    local potential_fusions = {}
    for _, card in ipairs(input) do
        if card and card.config and card.config.center and fusion_index[card.config.center.key] then
            for _, fusion in ipairs(fusion_index[card.config.center.key]) do
                potential_fusions[fusion] = (potential_fusions[fusion] or 0) + 1
            end
        end
    end

    for fusion, _ in pairs(potential_fusions) do
        if self:can_fuse(fusion, input) then
            return fusion
        end
    end

    for _, fusion in ipairs(available_fusions) do
        if self:can_fuse(fusion, input) then
            return fusion
        end
    end
    
    return nil
end

SMODS.BalatroFusion.Fusion = FusionClass