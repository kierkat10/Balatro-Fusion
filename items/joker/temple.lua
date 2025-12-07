SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "temple",
    name = "Temple",
    input = {
        "j_ancient",
        "j_castle",
    },
    output = "j_bfs_temple"
})

SMODS.Joker {
    key = "temple",
    name = "Temple",
    config = {
        extra = {
            xmult = 2,
            chips_mod = 5,
            chips = 0
        }
    },
    pos = { x = 0, y = 0 },
    cost = 14,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "placeholder",
    loc_vars = function(self, info_queue, card)
        local suit = (G.GAME.current_round.bfs_temple or {}).suit or "Spades"
        return {
            vars = {
                localize(suit, "suits_singular"),
                card.ability.extra.xmult,
                card.ability.extra.chips_mod,
                card.ability.extra.chips,
                colours = {
                    G.C.SUITS[suit]
                }
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit(G.GAME.current_round.bfs_temple.suit) then
            if not context.blueprint then
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_mod
                return {
                    xmult = card.ability.extra.xmult,
                    extra = {
                        message = localize("k_upgrade_ex"),
                        colour = G.C.CHIPS,
                        message_card = card
                    }
                }
            else
                return {
                    xmult = card.ability.extra.xmult,
                }
            end
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end,
	bfs_credits = {
        idea = { "Glitchkat10" },
		code = { "Glitchkat10" }
	}
}

local function reset_bfs_temple()
    G.GAME.current_round.bfs_temple = G.GAME.current_round.bfs_temple or { suit = "Spades" }
    local valid_suits = {}
    for k, v in ipairs({ "Spades", "Hearts", "Clubs", "Diamonds" }) do
        if v ~= G.GAME.current_round.bfs_temple.suit then valid_suits[#valid_suits + 1] = v end
    end
    local temple_card = pseudorandom_element(valid_suits, "bfs_temple" .. G.GAME.round_resets.ante)
    G.GAME.current_round.bfs_temple.suit = temple_card
end

function SMODS.current_mod.reset_game_globals(run_start)
    reset_bfs_temple()
end