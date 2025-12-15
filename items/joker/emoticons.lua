SMODS.BalatroFusion.Fusion:new_generic({
    id = "joker_fusion",
    key = "emoticons",
    name = "Emoticons",
    input = {
        "j_scholar",
        "j_smiley",
    },
    output = "j_bfs_emoticons"
})

SMODS.Joker { 
    key = "emoticons",
	name = "Emoticons",
    config = {
        extra = {
            chips = 10,
            mult = 10
        }
    },
	pos = { x = 0, y = 0 },
    cost = 8,
    rarity = "bfs_fused",
    blueprint_compat = true,
	atlas = "placeholder",
    loc_vars = function(self, info_queue, card)
        return {
		    vars={
            card.ability.extra.chips,
            card.ability.extra.mult
            },
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            local ranks = {
            [2]=true,
            [3]=true,
            [4]=true,
            [5]=true,
            [6]=true,
            [7]=true,
            [8]=true,
            [9]=true,
            [10]=true, 
            }
            if ranks[context.other_card:get_id()] then
            return {mult=card.ability.extra.mult,chips=card.ability.extra.chips}
            end
        end
    end,
    bfs_credits = {
        idea = { "Jesus" },
        art = {"Jesus"},
        code = { "Jesus"}
    }
}
