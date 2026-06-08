local game_startrun_ref = Game.start_run
function Game:start_run(args)
  game_startrun_ref(self, args)
  if not args.savetext then
    G.GAME.bfs_cards_sold_len=0
  end
end

local l_sell_card = Card.sell_card
function Card:sell_card()
local ret = l_sell_card(self)
if not G.GAME.bfs_cards_sold_len then G.GAME.bfs_cards_sold_len = 0 end
G.GAME.bfs_cards_sold_len=G.GAME.bfs_cards_sold_len+1
return ret
end

function BalatroFusion.check_has_enhancement(card)
    if BalatroFusion.check_lucky_card(card) then
        return true
    elseif card.ability.set == 'Enhanced' then
        return true
    else
        return false
    end
end