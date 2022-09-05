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

return player