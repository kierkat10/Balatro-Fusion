SMODS.Joker{ --Golden Record
    key = "goldenrecord",
    config = {
        extra = {
            totalhandlevels = 0,
            odds = 2,
            odds2 = 5,
            levels = 1
        }
    },
    loc_txt = {
        ['name'] = 'Golden Record',
        ['text'] = {
            [1] = '{C:green}1 in 2{} chance to upgrade level of played {C:attention}poker hand{}',
            [2] = '{C:green}1 in 5{} chance to upgrade level of played hand',
            [3] = 'by total levels in all poker hands'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
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
        if context.cardarea == G.jokers and context.joker_main  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_8fc56cff', 1, card.ability.extra.odds, 'j_balatrofusion_goldenrecord', false) then
              local target_hand = (context.scoring_name or "High Card")
                        SMODS.calculate_effect({level_up = card.ability.extra.levels,
      level_up_hand = target_hand}, card)
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_level_up_ex'), colour = G.C.RED})
          end
                if SMODS.pseudorandom_probability(card, 'group_1_7353b168', 1, card.ability.extra.odds2, 'j_balatrofusion_goldenrecord', false) then
              local target_hand2 = (context.scoring_name or "High Card")
                        SMODS.calculate_effect({level_up = (function() local total = 0; for hand, data in pairs(G.GAME.hands) do if data.level >= to_big(1) then total = total + data.level end end; return total end)(),
      level_up_hand = target_hand2}, card)
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_level_up_ex'), colour = G.C.RED})
          end
            end
        end
    end
}

SMODS.BalatroFusions.Fusion:new_generic({
    id="joker_fusion",
    key="goldenrecord",
    name="Equal Evan",
    input={
        "j_space_joker",
        "j_obelisk",
    },
    output={
        "j_balatrofusion_goldenrecord",
    },
})