-- Required to access other files.
local meta  = ...
local spell = require('conditions.spell')

-- Init Unit
local player = { }

local powerList     = {
    mana            = 0,
    rage            = 1,
    focus           = 2,
    energy          = 3,
    comboPoints     = 4,
    runes           = 5,
    runicPower      = 6,
    soulShards      = 7,
    lunarPower      = 8,
    holyPower       = 9,
    altPower        = 10,
    maelstrom       = 11,
    chi             = 12,
    insanity        = 13,
    obsolete        = 14,
    obsolete2       = 15,
    arcaneCharges   = 16,
    fury            = 17,
    pain            = 18,
}

function player.power(powerType)
    return UnitPower('player',powerList[powerType])
end

-- Return Functions
return unit
