local meta = ...
local unit = require('conditions.unit')

local player = {}

setmetatable(player, {
    __index = function(table, key)
        if unit[key] then
            rawset(table, key, function(...)
                return unit[key]("player", ...)
            end)
            return table[key]
        end
    end
})

function player.getFallDistance()
    local zDist
    local zCoord = nil
    local _, _, position = meta._G.ObjectPosition("player")

    if position == nil then
        return 0
    end
    if zCoord == nil then
        zCoord = position
    end
    if not IsFalling() or IsFlying() then
        zCoord = position
    end
    if position - zCoord < 0 then
        zDist = math.sqrt(((position - zCoord) ^ 2))
    else
        zDist = 0
    end

    return zDist
end

return player