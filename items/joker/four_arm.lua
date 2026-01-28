local smods_four_fingers_ref = SMODS.four_fingers
function SMODS.four_fingers()
    if next(SMODS.find_card("j_bfs_four_arm")) then
        return 3
    end
    return smods_four_fingers_ref()
end

return {
    key = "four_arm",
    name = "Four Arm",
    input = {
        "j_four_fingers",
        "j_raised_fist"
    },
    joker = {
        pos = { x = 1, y = 0 },
        blueprint_compat = true,
        atlas = "joker",
        calculate = function(self, card, context)
            if context.individual and context.cardarea == G.hand and not context.end_of_round then
                local temp_Mult, temp_ID = 15, 15
                local raised_card = nil
                for i = 1, #G.hand.cards do
                    if temp_ID >= G.hand.cards[i].base.id and not SMODS.has_no_rank(G.hand.cards[i]) then
                        temp_Mult = G.hand.cards[i].base.nominal
                        temp_ID = G.hand.cards[i].base.id
                        raised_card = G.hand.cards[i]
                    end
                end
                if raised_card == context.other_card then
                    if context.other_card.debuff then
                        return {
                            message = localize("k_debuffed"),
                            colour = G.C.RED
                        }
                    else
                        return {
                            mult = 3 * temp_Mult
                        }
                    end
                end
            end
        end,
        bfs_credits = {
            idea = { "SnowPickle" },
            art = { "SnowPickle" },
            code = { "Glitchkat10" }
        }
    }
}