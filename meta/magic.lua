local meta = ...

-- setup the magic global stuff
local magic

-- load in all the base calls, conditions, etc
magic           = require('conditions.base')
magic.buff      = require('conditions.buff')
magic.cast      = require('conditions.cast')
magic.health    = require('conditions.health')
magic.player    = require('conditions.player')
magic.spell     = require('conditions.spell')
magic.spellList = require('conditions.spellList')
magic.unit      = require('conditions.unit')

return function(func)
    return setfenv(func, setmetatable(magic, { __index = _G }))
end
