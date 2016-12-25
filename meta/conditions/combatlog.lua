local meta = ...
local cast = require('conditions.cast')
cast.complete = cast.complete

-- Init Combat Log
local combatlog = { }

-----------------------------------------
--- Combat Log Related Functions Here ---
-----------------------------------------
--[[ Combat Log Reader --]]
-- combatlog.frame1 = CreateFrame("FRAME")
-- combatlog.frame1:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED")
-- combatlog.frame1:RegisterUnitEvent("UNIT_SPELLCAST_FAILED")
-- function combatlog.frame1:OnEvent(event, arg1, arg2, arg3, arg4, arg5)
--     if event == "UNIT_SPELLCAST_SUCCEEDED" or event == "UNIT_SPELLCAST_FAILED" then
--     	local sourceName, spellName, rank, line, spellID = arg1, arg2, arg3, arg4, arg5
--         if not cast.complete then cast.complete = true end
--     end
-- end
-- combatlog.frame1:SetScript("OnEvent", combatlog.frame1.OnEvent)

AddEventCallback("UNIT_SPELLCAST_SUCCEEDED",function (...)
    local SourceUnit 	= select(1,...)
	local SpellID 		= select(5,...)
    if SourceUnit == "player" then
        for k, v in pairs(cast.list) do
            if SpellID == k then
                table.remove(cast.list,k)
                break
            end
        end
    end
end)
AddEventCallback("UNIT_SPELLCAST_FAILED",function (...)
    local SourceUnit 	= select(1,...)
	local SpellID 		= select(5,...)
    if SourceUnit == "player" then
        for k, v in pairs(cast.list) do
            if SpellID == k then
                table.remove(cast.list,k)
                break
            end
        end
    end
end)
AddEventCallback("SPELL_CAST_SUCCESS",function (...)
    local SourceUnit 	= select(4,...)
	local SpellID 		= select(12,...)
    if SourceUnit == "player" then
        for k, v in pairs(cast.list) do
            if SpellID == k then
                table.remove(cast.list,k)
                break
            end
        end
    end
end)
AddEventCallback("SPELL_CAST_FAILED",function (...)
    local SourceUnit 	= select(4,...)
	local SpellID 		= select(12,...)
    if SourceUnit == "player" then
        for k, v in pairs(cast.list) do
            if SpellID == k then
                table.remove(cast.list,k)
                break
            end
        end
    end
end)
-- combatlog.frame2 = CreateFrame("FRAME")
-- combatlog.frame2:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
-- function combatlog.frame2(...)
--     local timeStamp, param = ...
--     if event == "SPELL_CAST_SUCCESS" or event == "SPELL_CAST_FAILED" then
--         if not cast.complete then cast.complete = true end
--     end
-- end
-- combatlog.frame2:SetScript("OnEvent", combatlog.frame2)

-- Return Functions
return combatlog
