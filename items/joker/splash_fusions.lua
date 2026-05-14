function BalatroFusion.adjust_play_limits(card, method)
    if card:is_suit("Diamonds") then
        if next(SMODS.find_card("j_bfs_clam")) then
            SMODS.change_play_limit(method * 1)
            SMODS.change_discard_limit(method * 1)
            return
        end
    end
    if card:is_suit("Hearts") then
        if next(SMODS.find_card("j_bfs_seashell")) then
            SMODS.change_play_limit(method * 1)
            SMODS.change_discard_limit(method * 1)
            return
        end
    end
    if card:is_suit("Clubs") then
        if next(SMODS.find_card("j_bfs_oyster")) then
            SMODS.change_play_limit(method * 1)
            SMODS.change_discard_limit(method * 1)
            return
        end
    end
    if card:is_suit("Spades") then
        if next(SMODS.find_card("j_bfs_conch_shell")) then
            SMODS.change_play_limit(method * 1)
            SMODS.change_discard_limit(method * 1)
            return
        end
    end
end

function BalatroFusion.check_splash_scoring(card)
    if card:is_suit("Diamonds") then
        if next(SMODS.find_card("j_bfs_clam")) then
            return true
        end
    end
    if card:is_suit("Hearts") then
        if next(SMODS.find_card("j_bfs_seashell")) then
            return true
        end
    end
    if card:is_suit("Clubs") then
        if next(SMODS.find_card("j_bfs_oyster")) then
            return true
        end
    end
    if card:is_suit("Spades") then
        if next(SMODS.find_card("j_bfs_conch_shell")) then
            return true
        end
    end
end

local function generate_shell_fusion(input, key, name, suit)
    local c = suit == "Clubs"
    local h = suit == "Hearts"
    local d = suit == "Diamonds"
    local s = suit == "Spades"

    return {
        key = key,
        name = name,
        input = {
            "j_splash",
            input,
        },
        joker = {
            config = {
                extra = {
                    xmult = h and 1.4 or nil,
                    mult = c and 10 or nil,
                    chips = s and 65 or nil,
                    xchips = d and 1.2 or nil,
                    dollars = d and 1 or nil,
                }
            },
            pos = { x = 0, y = 0 },
            blueprint_compat = true,
            atlas = "placeholder",
            loc_vars = function(self, info_queue, card)
                if s then return { vars = {card.ability.extra.chips} } end
                if h then return { vars = {card.ability.extra.xmult} } end
                if c then return { vars = {card.ability.extra.mult} } end
                if d then return { vars = {card.ability.extra.dollars, card.ability.extra.xchips} } end
            end,
            calculate = function(self, card, context)
                if context.individual and context.cardarea == G.play and context.other_card and context.other_card:is_suit(suit) then
                    if s then return { chips = card.ability.extra.chips } end
                    if h then return { xmult = card.ability.extra.xmult } end
                    if c then return { mult = card.ability.extra.mult } end
                    if d then return { dollars = card.ability.extra.dollars, xchips = card.ability.extra.xchips } end
                end
            end,
            bfs_credits = {
                art = { "" },
                idea = { "ButterStutter" },
                code = { "ButterStutter" }
            }
        }
    }
end

return {
    generate_shell_fusion("j_rough_gem", "clam", "Clam", "Diamonds"),
    generate_shell_fusion("j_bloodstone", "seashell", "Seashell", "Hearts"),
    generate_shell_fusion("j_arrowhead", "conch_shell", "Conch Shell", "Spades"),
    generate_shell_fusion("j_onyx_agate", "oyster", "Oyster", "Clubs")
}