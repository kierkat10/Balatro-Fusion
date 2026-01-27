SMODS.BalatroFusion = {}
if not BalatroFusion then
    BalatroFusion = {}
end

local function normalize_path(path)
    return path:gsub("\\", "/"):gsub("//+", "/"):gsub("/$", "")
end

local fusion_jokers = {}

local function load_jokers()
    print("LOADING JOKERS")
    local full_path = normalize_path(SMODS.current_mod.path .. "/items/joker")
    local files = NFS.getDirectoryItemsInfo(full_path)
    for _, file in ipairs(files) do
        local file_path = full_path .. "/" .. file.name
        if file.name:sub(-4):lower() == ".lua" then
            local loaded_joker = dofile(file_path)
            if loaded_joker then
                print(loaded_joker.joker.name)
                table.insert(fusion_jokers, loaded_joker)
            end
        end
    end
end

local function load_directory(relative_path)
    local full_path = normalize_path(SMODS.current_mod.path .. "/" .. relative_path)
    local files = NFS.getDirectoryItemsInfo(full_path)
    for _, file in ipairs(files) do
        local file_path = full_path .. "/" .. file.name
        print(file_path)
        if file.name == "joker" then 
            load_jokers()
        elseif file.type == "directory" then
            load_directory(relative_path .. "/" .. file.name)
        elseif file.name:sub(-4):lower() == ".lua" then
            local mod_relative_path = relative_path .. "/" .. file.name
            assert(SMODS.load_file(mod_relative_path))()
        end
    end
end

load_directory("lib")
load_directory("items")

for _, item in pairs(fusion_jokers) do
    SMODS.BalatroFusion.Fusion:new_generic(item.fusion)
    local input_joker_1, input_joker_2 = nil, nil
    for key, joker in pairs(G.P_CENTERS) do
        if joker.set == "Joker" then
            for _, input in pairs(item.fusion.input) do
                if input == key then
                    if not input_joker_1 then
                        input_joker_1 = joker
                    else
                        input_joker_2 = joker
                    end
                end
            end
        end
    end
    if input_joker_1 and input_joker_2 then
        item.order_value = input_joker_1.order * 150 + input_joker_2.order
        item.joker.cost = input_joker_1.cost + input_joker_2.cost
    end
end

table.sort(fusion_jokers, function(a, b)
    return a.order_value < b.order_value
end)
print("PRINTING JOKERSSSSS")
print(#fusion_jokers)
for _, item in ipairs(fusion_jokers) do
    SMODS.Joker(item.joker)
    print(item.joker.name)
end