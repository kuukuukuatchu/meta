local meta  = ...
local cast  = require('conditions.cast')
local spell = require('conditions.spell')
local unit 	= require('conditions.unit') 

-- Init Combat Log
local combatlog = { }
local destUnit = "player"

-----------------------------------------
--- Combat Log Related Functions Here ---
-----------------------------------------

AddEventCallback("COMBAT_LOG_EVENT_UNFILTERED",function (...)
    local timeStamp, param, hideCaster, source, sourceName, sourceFlags, sourceRaidFlags, destination,
        destName, destFlags, destRaidFlags, spellID, spellName, _, spellType = ...
    if param == "SPELL_CAST_SUCCESS" or param == "SPELL_CAST_FAILED" then
        if sourceName == unit.name('player') and destName ~= nil then
        	destUnit = destName
        end
    end
end)

AddEventCallback("PLAYER_REGEN_ENABLED", function (...)
    print("|cffa330c9 [meta] |r Combat Ended")
end)

AddEventCallback("UNIT_SPELLCAST_SUCCEEDED", function (...)
    local SourceUnit, SpellName, _, _, SpellID = ...
    if SourceUnit == "player" and SpellID == spell.last() then
        print('|cffa330c9 [meta] |cff00FF00 Cast Sucess: |r'..string.format("%-15.15s", SpellName)..'|cffFFFF00 with Id: |r'..string.format("%-6s", SpellID)..'|cffFFFF00 on |r'..string.format("%-15.15s", destUnit))
    end
end)

AddEventCallback("UNIT_SPELLCAST_FAILED", function (...)
    local SourceUnit, SpellName, _, _, SpellID = ...
    if SourceUnit == "player" and SpellID == spell.last() then
        print('|cffa330c9 [meta] |cffFF0000 Cast Failed:  |r'..string.format("%-15.15s", SpellName)..'|cffFFFF00 with Id: |r'..string.format("%-6s", SpellID)..'|cffFFFF00 on |r'..string.format("%-15.15s", destUnit))
    end
end)


-- Return Functions
return combatlog
