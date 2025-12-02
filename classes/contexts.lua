local l_update = Card.update
function Card:update(dt)
    local ret=l_update(self,dt)
    SMODS.calculate_context{
        balatrofusion_update=true,
        updated_card=self,
        balatrofusion_dt=dt,
    }
    return ret
end