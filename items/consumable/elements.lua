SMODS.Consumable {
    key = "elements",
    name = "Elements",
    set = "Tarot",
    pos = { x = 1, y = 0 },
    config = {
        extra={
            chance=4,
        },
    },
    cost = 3,
    atlas = "consumable",
    can_use = function(self, card)
        local keys = {}
        for i,v in ipairs(G.jokers.cards) do
            table.insert(keys, v.config.center.key)
        end
        local possible_fusions = {}
        for i,v in pairs(keys) do
            local possible_fusion = SMODS.BalatroFusion.Fusion:get_fusions_that_contains_input({v})
            if possible_fusion ~= nil then
            table.insert(possible_fusions, possible_fusion)
            break
            end
        end
        if #possible_fusions >0 then return true end
    end,
    use = function(self, card, area, copier)
        if SMODS.pseudorandom_probability(card, "bfs_elements_tarot", 1, card.ability.extra.chance) then
        local jokers = {}
        for i,v in pairs(G.jokers.cards) do
            if SMODS.BalatroFusion.Fusion:get_fusions_that_contains_input({v.config.center.key}) ~= nil then
            table.insert(jokers, v)
            end
        end
        local chosen_joker = pseudorandom_element(jokers,"bfs_elements_tarot_joker_choice")
        --print("chosen joker for element is:",chosen_joker)
        local possible_fusion = SMODS.BalatroFusion.Fusion:get_fusions_that_contains_input({chosen_joker.config.center.key})[1]
        --print("possible fusions:",inspectDepth(possible_fusion))
        local chosen_fusion = pseudorandom_element(possible_fusion,"bfs_elements_tarot_choose_fusion")
        --print("chosen fusion is:",inspectDepth(chosen_fusion))
        SMODS.BalatroFusion.Fusion:fuse(chosen_fusion,{
            {config={center={key="null",},},}
        })
        chosen_joker:start_dissolve()
        end
    end,
    loc_vars = function (self,info_queue,card)
        local numerator,denominator = SMODS.get_probability_vars(card,1,card.ability.extra.chance)
        return {
            vars={
                numerator,
                denominator,
            }
        }
    end,

}
