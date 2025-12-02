SMODS.Joker{ --Four Arm
    key = "fourarm",
    config = {
        extra = {
            reduction_value = 1,
            lowestrankinhand = 0
        }
    },
    loc_txt = {
        ['name'] = 'Four Arm',
        ['text'] = {
            [1] = 'Adds an amount of Mult equal to fourfold the smallest card currently held in your hand',
            [2] = 'And all {C:attention} Flushes{} and {C:attention} Straights{} can be made with 4 cards'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = "balatrofusion_fused",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["balatrofusion_mycustom_jokers"] = true },

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    mult = ((function() local min = 14; for _, card in ipairs(G.hand and G.hand.cards or {}) do if card.base.id < min then min = card.base.id end end; return min end)()) * 4
                }
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        -- Flush/Straight requirements reduced by 1
    end,

    remove_from_deck = function(self, card, from_debuff)
        -- Flush/Straight requirements restored
    end
}


local smods_four_fingers_ref = SMODS.four_fingers
function SMODS.four_fingers()
    if next(SMODS.find_card("j_balatrofusion_fourarm")) then
        return 4
    end
    return smods_four_fingers_ref()
end

SMODS.BalatroFusions.Fusion:new_generic({
    id="joker_fusion",
    key="fourarm",
    name="Four Arm",
    input={
        "j_raised_fist",
        "j_four_fingers",
    },
    output={
        "j_balatrofusion_fourarm",
    },
})