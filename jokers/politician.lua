SMODS.Joker{ --Politician
    key = "politician",
    config = {
        extra = {
            repetitions = 3
        }
    },
    loc_txt = {
        ['name'] = 'Politician',
        ['text'] = {
            [1] = 'Retrigger all played number cards 3 times'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 10,
    rarity = "balatrofusion_fused",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["balatrofusion_balatrofusion_jokers"] = true },

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play  then
            if ((function()
    local rankFound = false
    for i, c in ipairs(context.scoring_hand) do
        if (c:get_id() == 2 or c:get_id() == 4 or c:get_id() == 6 or c:get_id() == 8 or c:get_id() == 10) then
            rankFound = true
            break
        end
    end
    
    return rankFound
end)() or (function()
    local rankFound = false
    for i, c in ipairs(context.scoring_hand) do
        if (c:get_id() == 14 or c:get_id() == 3 or c:get_id() == 5 or c:get_id() == 7 or c:get_id() == 9) then
            rankFound = true
            break
        end
    end
    
    return rankFound
end)()) then
                return {
                    repetitions = card.ability.extra.repetitions,
                    message = localize('k_again_ex')
                }
            end
        end
    end
}

SMODS.BalatroFusions.Fusion:new_generic({
    id="joker_fusion",
    key="politician",
    name="Politician",
    input={
        "j_hanging_chad",
        "j_hack",
    },
    output={
        "j_balatrofusion_politician",
    },
})