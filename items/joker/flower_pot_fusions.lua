function BalatroFusion.check_flower_pot_suits(hand_to_check, get_counts)
    local suits = {
        ['Hearts'] = 0,
        ['Diamonds'] = 0,
        ['Spades'] = 0,
        ['Clubs'] = 0
    }
    for i = 1, #hand_to_check do
        if not SMODS.has_any_suit(hand_to_check[i]) then
            if hand_to_check[i]:is_suit('Hearts', true) and suits["Hearts"] == 0 then suits["Hearts"] = suits["Hearts"] + 1
            elseif hand_to_check[i]:is_suit('Diamonds', true) and suits["Diamonds"] == 0  then suits["Diamonds"] = suits["Diamonds"] + 1
            elseif hand_to_check[i]:is_suit('Spades', true) and suits["Spades"] == 0  then suits["Spades"] = suits["Spades"] + 1
            elseif hand_to_check[i]:is_suit('Clubs', true) and suits["Clubs"] == 0  then suits["Clubs"] = suits["Clubs"] + 1 end
        end
    end
    for i = 1, #hand_to_check do
        if SMODS.has_any_suit(hand_to_check[i]) then
            if hand_to_check[i]:is_suit('Hearts') and suits["Hearts"] == 0 then suits["Hearts"] = suits["Hearts"] + 1
            elseif hand_to_check[i]:is_suit('Diamonds') and suits["Diamonds"] == 0  then suits["Diamonds"] = suits["Diamonds"] + 1
            elseif hand_to_check[i]:is_suit('Spades') and suits["Spades"] == 0  then suits["Spades"] = suits["Spades"] + 1
            elseif hand_to_check[i]:is_suit('Clubs') and suits["Clubs"] == 0  then suits["Clubs"] = suits["Clubs"] + 1 end
        end
    end
    if get_counts or suits["Hearts"] > 0 and suits["Diamonds"] > 0 and suits["Spades"] > 0 and suits["Clubs"] > 0 then
        return suits
    else
        return {}
    end
end

local corn = {
    key = "corn",
    name = "Corn",
    input = {
        "j_popcorn",
        "j_flower_pot",
    },
    joker = {
        config = {
            extra = {
                mult = 60,
                mult_loss_reduction = 2,
            },
        },
        pos = {x=0,y=0},
        blueprint_compat = true,
        atlas = "placeholder",
        loc_vars = function (self,info_queue,card)
            return {
                vars = {
                    card.ability.extra.mult,
                    card.ability.extra.mult_loss_reduction
                }
            }
        end,
        calculate = function (self,card,context)
            if context.after then
                local suits = BalatroFusion.check_flower_pot_suits(context.full_hand, true)
                local decrease = 0
                for _, v in pairs(suits) do
                    if v == 0 then
                        decrease = decrease + card.ability.extra.mult_loss_reduction
                    end
                end
                if decrease > 0 then
                    if card.ability.extra.mult - decrease <= 0 then
                        SMODS.destroy_cards(card, nil, nil, true)
                        return {
                            message = "Eaten!",
                            colour = G.C.RED
                        }
                    else
                        card.ability.extra.mult = card.ability.extra.mult - decrease
                        return {
                            message = "-"..decrease.." Mult!",
                            colour = G.C.RED
                        }
                    end
                end
            elseif context.joker_main then
                return {
                    mult = card.ability.extra.mult,
                }
            end
        end,
        bfs_credits = {
            idea = { "ButterStutter" },
            art = { },
            code = { "ButterStutter" }
        },
    }
}

return {
    corn
}