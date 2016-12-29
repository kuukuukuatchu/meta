local meta  = ...
local cast  = require('conditions.cast')
local spell = require('conditions.spell')

-- Init Combat Log
local combatlog = { }

-----------------------------------------
--- Combat Log Related Functions Here ---
-----------------------------------------

-- AddEventCallback("COMBAT_LOG_EVENT_UNFILTERED",function (...)
--     local timeStamp, param, hideCaster, source, sourceName, sourceFlags, sourceRaidFlags, destination,
--         destName, destFlags, destRaidFlags, spellID, spellName, _, spellType = ...
--     if param == "SPELL_CAST_SUCCESS" or param == "SPELL_CAST_FAILED" then
--         if source == "player" then
--             if param == "SPELL_CAST_SUCCESS" then print('|cffa330c9[meta] |cff00FF00 Cast Sucess: |r'..spellName..'|cffFFFF00 with Id: |r'..spellID..'|cffFFFF00 at: |r'..destName) end
--             if param == "SPELL_CAST_FAILED" then print('|cffa330c9[meta] |cffFF0000 Cast Sucess: |r'..spellName..'|cffFFFF00 with Id: |r'..spellID..'|cffFFFF00 at: |r'..destName) end
--             for k, v in pairs(cast.list) do
--                 if SpellID == k then
--                     table.remove(cast.list,k)
--                     break
--                 end
--             end
--         end
--     end
-- end)

-- AddEventCallback("UNIT_SPELLCAST_SENT", function(...)
--     local SourceUnit, SpellName = ...
--     local SpellID = select(7,GetSpellInfo(SpellName))
--     if SourceUnit == "player" then
--         -- print('|cffa330c9 [meta] |cff00FF00 Cast Start: |r'..SpellName..'|cffFFFF00 with Id: |r'..SpellID)
--         table.insert(cast.list, SpellID)
--     end
-- end)

AddEventCallback("PLAYER_REGEN_ENABLED", function (...)
    print("|cffa330c9 [meta] |r Combat Ended")
end)

AddEventCallback("UNIT_SPELLCAST_SUCCEEDED", function (...)
    local SourceUnit, SpellName, _, _, SpellID = ...
    if SourceUnit == "player" and SpellID == spell.last() then
        print('|cffa330c9 [meta] |cff00FF00 Cast Sucess: |r'..SpellName..'|cffFFFF00 with Id: |r'..SpellID)
    end
end)
AddEventCallback("UNIT_SPELLCAST_FAILED", function (...)
    local SourceUnit, SpellName, _, _, SpellID = ...
    if SourceUnit == "player" and SpellID == spell.last() then
        print('|cffa330c9 [meta] |cffFF0000 Cast Failed: |r'..SpellName..'|cffFFFF00 with Id: |r'..SpellID)
    end
end)


-- Return Functions
return combatlog
