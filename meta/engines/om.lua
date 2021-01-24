-- Required to access other files.
local meta  = ...
local base 	= require('conditions.base')
local unit 	= require('conditions.unit')

-- Init Friends
om = { }

local initOM = true
-- The first frame call to GetObjectCount(true) should have total == #added and 'added' will contain all objects.
-- The next GetObjectCount(true) calls should have only the updated objects.
function omUpdate()
    local total, updated, added, removed = GetObjectCount(true, "customId")
    if initOM then
        initOM = false
        for i = 1,total do
            local thisUnit = GetObjectWithIndex(i)  -- thisUnit contains the '0x' string representing the object address 
            if ObjectIsUnit(thisUnit)  then
                -- sanity checks
                if unit.distance('player',thisUnit) <= 50 then
                    om[thisUnit] 	= {
                        name 			= unitName,
                        guid 			= unitGUID,
                        id 				= unitID,
                    }
                end
            end
        end
    end
    for k,v in pairs(added) do
        -- k - Number = Array index = Don't confuse this with the Object Index used by GetObjectWithIndex. It's not the same thing.
        -- v - String = Object address
        if ObjectIsUnit(v) then
            local thisUnit = GetObjectWithIndex(i)  -- thisUnit contains the '0x' string representing the object address 
            --print('Added ' .. v)
            if ObjectIsUnit(v)  then
                -- sanity checks
                if unit.distance('player',v) <= 50 then
                    local unitName 			= UnitName(v)
                    local unitID 			= ObjectID(v)
                    local unitGUID 			= UnitGUID(v)
                    om[v] 	= {
                        name 			= unitName,
                        guid 			= unitGUID,
                        id 				= unitID,
                    }
                end
            end
        end
    end
    for k,v in pairs(removed) do
        --print('Removed ' .. v)
        om[v] = nil
    end
end

-- Build Friends
AddFrameCallback(function ()
    -- Initialize Friends Engine
    omUpdate()
end)

return om