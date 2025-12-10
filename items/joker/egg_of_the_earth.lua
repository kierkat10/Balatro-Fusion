
SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "egg_of_the_earth",
    name = "Egg Of The Earth",
    input = {
        "j_invisible",
        "j_madness",
    },
    output = "j_bfs_egg_of_the_earth"
})

SMODS.Joker {
    key = "egg_of_the_earth",
    name = "Egg Of The Earth",
    config = {
        extra = {
            x_mult = 1,
            x_mult_gain = 0.5,
        }
    },
    cost = 12,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = "joker",
    pos = { x = 1, y = 4 },
    soul_pos = { x = 0, y = 4},
    loc_vars = function(self, info_queue, card)
        return {
            vars={
            card.ability.extra.x_mult_gain,
            card.ability.extra.x_mult,
            },
        }
    end,
    calculate = function(self,card,context)
        if context.setting_blind and not context.blind.boss and not context.blueprint then
            local destructable_jokers = {}
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] ~= card and not SMODS.is_eternal(G.jokers.cards[i], self) and not G.jokers.cards[i].getting_sliced then destructable_jokers[#destructable_jokers+1] = G.jokers.cards[i] end
                end
            local joker_to_destroy = #destructable_jokers > 0 and pseudorandom_element(destructable_jokers, pseudoseed('bfs_egg_of_the_earth')) or nil
            if joker_to_destroy and not (context.blueprint_card or self).getting_sliced then
                    joker_to_destroy.getting_sliced = true
                    G.E_MANAGER:add_event(Event({func = function()
                        card:juice_up(0.8, 0.8)
                        joker_to_destroy:start_dissolve({G.C.RED}, nil, 1.6)
                    return true end }))
            end
            if not card.getting_sliced then
                SMODS.scale_card(card or self, {
                        ref_table = card.ability.extra,
                        ref_value = "x_mult",
                        scalar_value = "x_mult_gain",
                        message_key = 'a_xmult'
                })
                local duplicable_jokers = {}
                for i = 1,#G.jokers.cards do
                    if G.jokers.cards[i] ~= card and not G.jokers.cards[i].getting_sliced then duplicable_jokers[#duplicable_jokers+1] = G.jokers.cards[i] end
                end
                local joker_to_copy = pseudorandom_element(duplicable_jokers, pseudoseed("bfs_egg_of_the_earth_copy")) or nil
                if joker_to_copy then
                    local copied = copy_card(joker_to_copy)
                    copied:add_to_deck()
                    G.jokers:emplace(copied)
                end
            end
        end
        if context.joker_main then
            return {
                x_mult=card.ability.extra.x_mult,
            }
        end
    end,
    bfs_credits = {
        idea = { "Maple" },
        art = {"Maple"},
        code = { "Lact4"}
    }
}
