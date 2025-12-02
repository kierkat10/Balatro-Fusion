SMODS.Joker{ --Schrodingers cat
    key = "schrodingerscat",
    config = {
        extra = {
            x_mult=1,
            x_mult_gain=0.2,
            x_mult_lose=0.2,
            x_mult_gain_odd=16,
            x_mult_lose_odd=16,
        }
    },
    loc_txt = {
        ['name'] = 'Schrodingers cat',
        ['text'] = {
            [1] = 'Randomly gains {X:red,C:white}X#1#{}',
            [2] = 'Randomly Looses {X:red,C:white}X#2#{}',
            [3] = '{C:inactive}(Currently{} {X:red,C:white}X#3#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 15,
    rarity = "balatrofusion_fused",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["balatrofusion_balatrofusion_jokers"] = true },

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_mult=card.ability.extra.x_mult,
            }
        end
        if context.balatrofusion_update and context.updated_card == card then
            if pseudorandom(pseudoseed("j_balatrofusion_schrodingerscat_mult_gain"), 1, card.ability.extra.x_mult_gain_odd) == card.ability.extra.x_mult_gain_odd then
                card.ability.extra.x_mult=card.ability.extra.x_mult+card.ability.extra.x_mult_gain
            elseif pseudorandom(pseudoseed("j_balatrofusion_schrodingerscat_mult_lose"),1,card.ability.extra.x_mult_lose_odd) == card.ability.extra.x_mult_lose_odd then
            card.ability.extra.x_mult=card.ability.extra.x_mult-card.ability.extra.x_mult_lose
            end
        end
    end,
    loc_vars = function (self,info_queue,card)
       return {
        vars={
            card.ability.extra.x_mult_gain,
            card.ability.extra.x_mult_lose,
            card.ability.extra.x_mult,
        }
       } 
    end
}

SMODS.BalatroFusions.Fusion:new_generic({
    id="joker_fusion",
    key="schrodingerscat",
    name="Schrodingers Cat",
    input={
        "j_lucky_cat",
        "j_superposition",
    },
    output={
        "j_balatrofusion_schrodingerscat",
    },
})