
SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "anonymous",
    name = "Anonymous",
    input = {
        "j_hack",
        "j_midas_mask",
    },
    output = "j_bfs_anonymous"
})

SMODS.Joker {
    key = "anonymous",
    name = "Anonymous",
    config = {
        extra = {
            retriggers=1,
            gold_retriggers=2,
        }
    },
    pos = nil,
    cost = 13,
    rarity = "bfs_fused",
    blueprint_compat = true,
    atlas = nil,
    loc_vars = function(self, info_queue, card)
        return {
            card.ability.extra.retriggers,
            card.ability.extra.gold_retriggers,
        }
    end,
    calculate = function(self,card,context)
        if context.after and not context.blueprint then
        local ranks = {
        [2]=true,
        [3]=true,
        [4]=true,
        [5]=true,
        } 
        for i,v in ipairs(context.scoring_hand) do
        if ranks[v:get_id()] then
        v:set_ability(G.P_CENTERS.m_gold, nil, true)
        G.E_MANAGER:add_event(Event({
        func = function()
            v:juice_up()
            return true
        end,
        }))
        end
        end
        end
        if context.repetition and context.cardarea == G.play then
           if ranks[context.other_card:get_id()] then
           local retriggers = card.ability.extra.retriggers
           if SMODS.has_enhancement(context.other_card,"m_gold") then retriggers=card.ability.extra.gold_retriggers end
           return {
           repetitions=retriggers,
           message=localize("k_again_ex"),
           card=card,
           }
           end
        end
    end
    bfs_credits = {
        idea = { "Jesus" },
        art = {},
        code = { "Lact4"}
    }
}
