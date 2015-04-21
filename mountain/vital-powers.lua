-- using Long Sword, Steel Striker
function pickUpNearestCoin()
    i = self:findNearest(self:findItems())
    if i then
        self:moveXY(i.pos.x, i.pos.y)
    end
end

function summonSoldier()
    if self.gold >= self:costOf("soldier") then
        self:summon("soldier")
    end
end
function commandSoldiers()
    local f = self:findFriends()
    for i = 1, #f do
        local e = f[i]:findNearest(f[i]:findEnemies())
        if e then
            self:command(f[i], "attack", e)
        end
    end
end

loop
    e = self:findNearest(self:findEnemies())
    i = self:findNearest(self:findItems())
    f = self:findFlag()
    if f then
        self:pickUpFlag(f)
    elseif e and i then
        de = self:distanceTo(e)
        di = self:distanceTo(i)
        if de < di and self:isReady("cleave") then
            self:cleave(e)
        elseif de < di and self:isReady("bash") then
            self:bash(e)
        else
            pickUpNearestCoin()
        end
    elseif i then
        pickUpNearestCoin()
    end
    summonSoldier()
    commandSoldiers()
end