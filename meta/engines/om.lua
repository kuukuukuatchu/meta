-- Required to access other files.
local meta = ...
local update = meta.update

-- Init Friends
local om = meta.om

-- The first frame call to GetObjectCount(true) should have total == #added and 'added' will contain all objects.
-- The next GetObjectCount(true) calls should have only the updated objects.
local function omUpdate()
    local objects = meta._G.GetObjects()
    for i = 1, #objects do
        local thisUnit = objects[i].GUID -- thisUnit contains the '0x' string representing the object address 
        if meta._G.ObjectIsUnit(thisUnit) then
            -- sanity checks
            -- if unit.distance('player', thisUnit) <= 50 then
            om[thisUnit] = {
                name = meta._G.UnitName(thisUnit),
                guid = thisUnit,
                id = meta._G.ObjectID(thisUnit)
            }
            -- end
        end
    end

end

-- omUpdate()
update.register_callback(omUpdate)

return om
