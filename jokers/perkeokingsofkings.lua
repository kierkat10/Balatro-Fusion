SMODS.Joker{ --Perkeo - Kings of Kings
    key = "perkeokingsofkings",
    config = {
        extra = {
            consumablesheld = 0
        }
    },
    loc_txt = {
        ['name'] = 'Perkeo - Kings of Kings',
        ['text'] = {
            [1] = 'Creates a {C:spectral}Negative{} of {C:attention}1{} random {C:attention}consumable{} card',
            [2] = 'in your possession at the end of the {C:attention}shop{}',
            [3] = 'And when  a hand is played {X:red,C:white}X1.5{} {C:red} Mult{} for each consumable'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 5,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 20,
    rarity = "balatrofusion_fused",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    soul_pos = {
        x = 6,
        y = 0
    },

    calculate = function(self, card, context)
        if context.ending_shop  then
                return {
                    func = function()
            local target_cards = {}
            for i, consumable in ipairs(G.consumeables.cards) do
                table.insert(target_cards, consumable)
            end
            if #target_cards > 0  then
                local card_to_copy = pseudorandom_element(target_cards, pseudoseed('copy_consumable'))
                
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local copied_card = copy_card(card_to_copy)
                        copied_card:set_edition("e_negative", true)
                        copied_card:add_to_deck()
                        G.consumeables:emplace(copied_card)
                        
                        return true
                    end
                }))
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Copied Consumable!", colour = G.C.GREEN})
            end
                    return true
                end
                }
        end
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    Xmult = (#(G.consumeables and G.consumeables.cards or {})) * 1.5
                }
        end
    end
}

SMODS.BalatroFusions.Fusion:new_generic({
    id="joker_fusion",
    key="perkeokingsofkings",
    name="Perkeo King of Kings",
    input={
        "j_barron",
        "j_perkeo",
    },
    output={
        "j_balatrofusion_perkeokingsofkings",
    },
})