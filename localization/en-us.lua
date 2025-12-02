return {
    descriptions = {
        Joker = {
            j_bfs_equal_evan = {
                name = "Equal Evan",
                text = {
                    "Played {C:attention}non-face{} cards",
                    "give {C:chips}+#1#{} Chips and",
                    "{C:mult}+#2#{} Mult when scored"
                }
            },
            j_bfs_four_arm = {
                name = "Four Arm",
                text = {
                    "Adds {C:attention}quadruple{} the rank of {C:attention}lowest",
                    "ranked card held in hand to Mult",
                    "All {C:attention}Flushes{} and {C:attention}Straights{}",
                    "can be made with {C:attention}3{} cards"
                }
            },
            j_bfs_golden_record = {
                name = "Golden Record",
                text = {
                    "{C:green}#1# in #2#{} chance to upgrade",
                    "level of played {C:attention}poker hand",
                    "{C:green}#3# in #4#{} chance to upgrade",
                    "level of played {C:attention}poker hand",
                    "by total level of all {C:attention}poker hands"
                }
            },
            j_bfs_impossible_beef = {
                name = "Impossible Beef",
                text = {
                    "{C:white,X:chips}X#1#{} Chip#<s>1# for every {C:money}${} you have",
                    "{C:inactive}(Currently {C:white,X:blue}X#2#{}{C:inactive} Chip#<s>2#)"
                }
            },
            j_bfs_perkeo_king = {
                name = "Perkeo - Kings of Kings",
                text = {
                    "Creates a {C:dark_edition}Negative{} copy of {C:attention}1{} random {C:attention}consumable{}",
                    "card in your possession at the end of the {C:attention}shop{}",
                    "{C:attention}Consumables{} each give {C:white,X:mult}X#1#{} Mult"
                }
            },
            j_bfs_politician = {
                name = "Politician",
                text = {
                    "Retrigger all played",
                    "{C:attention}non-face{} cards {C:attention}#1#{} time#<s>1#"
                }
            },
            j_bfs_schro_cat = {
                name = "Schrodinger's Cat",
                text = {
                    "This Joker randomly either loses or gains",
                    "{C:white,X:mult}X#1#{} Mult on every {C:attention}game action",
                    "Destroyed if {C:white,X:mult}XMult{} is ever greater than {C:white,X:mult}X#2#",
                    "{C:inactive}(Currently {X:red,C:white}X#3#{C:inactive} Mult)"
                }
            },
            j_bfs_sparkling_wine = {
                name = "Sparkling Wine",
                text = {
                    "The next {C:attention}#1# Blinds",
                    "create a random {C:attention}Tag",
                    "when selected"
                }
            }
        },
        Spectral = {
            c_bfs_fusion_reactor = {
                name = "Fusion Reactor",
                text = {
                    "{C:bfs_fused,E:1}Fuse{} two or",
                    "more Jokers"
                }
            }
        }
    },
    misc = {
        dictionary = {
            k_bfs_fused = "Fused"
        }
    }
}