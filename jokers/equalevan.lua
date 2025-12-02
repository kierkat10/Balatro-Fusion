SMODS.Joker{ --Equal Evan
    key = "equalevan",
    config = {
        extra = {
            chips = 53,
            mult = 8
        }
    },
    loc_txt = {
        ['name'] = 'Equal Evan',
        ['text'] = {
            [1] = 'Gives {C:blue}53 chips{} and {C:red}8 mult{} when a number card is scored.'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = "balatrofusion_fused",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["balatrofusion_mycustom_jokers"] = true },

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
                return {
                    chips = card.ability.extra.chips,
                    extra = {
                        mult = card.ability.extra.mult
                        }
                }
        end
    end
}