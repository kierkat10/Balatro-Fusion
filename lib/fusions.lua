local last_start_run = Game.start_run
function Game:start_run(args)
    local r = last_start_run(self, args)
    -- sets highlighted limit to very high amount for fusion compatibility
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
function FusionClass:new(t)
    local new_fusion = setmetatable({}, FusionClass)
    new_fusion.name = t.name
    new_fusion.key = t.key
    new_fusion.input = t.input
    new_fusion.output = t.output
    new_fusion.required_value = t.required_value or #new_fusion.input
    new_fusion.check_op = t.check_op or "=="
    if t.store_key then
        stored_fusions[t.key] = t
    end
    table.insert(available_fusions, new_fusion)
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

function FusionClass:can_fuse(fusion, input)
    local current_value = 0
    for x, l in ipairs(input) do
        for i, v in ipairs(fusion.input) do
            if v.target == l.config.center.key then
                current_value = current_value + (v.input_worth or 1)
            end
        end
    end
    local function check()
        print("required value:", fusion.required_value)
        print("current value:", current_value)
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
    local result = check()
    print("check result:", result)
    if result == true then
        print("yes result is true?")
    end
    return check()
end

function FusionClass:fuse(fusion, input)
    self:handle_destroying(fusion, input)
    self:handle_output(fusion, input)
end

function FusionClass:handle_destroying(fusion, input)
    local cards_to_destroy = {}
    local current_value = 0
    local function check()
        print("required value:", fusion.required_value)
        print("current value:", current_value)
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
        print("card to destroy:", inspect(v))
        v:start_dissolve()
    end
end

function FusionClass:handle_output(fusion, input)
    for i, v in pairs(fusion.output) do
        if v.id == "create_card" then
            local created_card = SMODS.create_card(v.args)
            local area_to_emplace = loadstring("return " .. v.emplace_area)()
            created_card:add_to_deck()
            area_to_emplace:emplace(created_card)
        end
    end
end

function FusionClass:get(input)
    for i, v in ipairs(available_fusions) do
        if self:can_fuse(v, input) then
            return v
        end
    end
end

SMODS.BalatroFusion.Fusion = FusionClass