SMODS.Joker{ --Impossible Beef
    key = "impossiblebeef",
    config = {
        extra = {
            currentmoney = 1
        }
    },
    loc_txt = {
        ['name'] = 'Impossible Beef',
        ['text'] = {
            [1] = 'Gains {X:blue,C:white}X0.1{} for amount of {C:money}money{} you have',
            [2] = '{C:inactive}(Currently{} {C:blue}X#1#{} {C:inactive}Chips){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
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
    soul_pos = {
        x = 4,
        y = 0
    },

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.currentmoney + ((G.GAME.dollars or 0)) * 0.1}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    x_chips = card.ability.extra.currentmoney + (G.GAME.dollars) * 0.1
                }
        end
    end
}

SMODS.BalatroFusions.Fusion:new_generic({
    id="joker_fusion",
    key="impossiblebeef",
    name="Impossible Beef",
    input={
        "j_bull",
        "j_Hologram",
    },
    output={
        "j_balatrofusion_impossiblebeef",
    },
})