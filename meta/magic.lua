local meta = ...

-- setup the magic global stuff
local magic

-- load in all the base calls, conditions, etc
magic           = require('conditions.base')
magic.buff      = require('conditions.buff')
magic.cast      = require('conditions.cast')
magic.combatlog = require('conditions.combatlog')
magic.debuff    = require('conditions.debuff')
magic.health    = require('conditions.health')
magic.item 		= require('conditions.item')
magic.power     = require('conditions.power')
magic.spell     = require('conditions.spell')
magic.talent 	= require('conditions.talent')
magic.unit      = require('conditions.unit')
magic.artifact 	= require('engines.artifact')
magic.enemies 	= require('engines.enemies')

return function(func)
    return setfenv(func, setmetatable(magic, { __index = _G }))
end
