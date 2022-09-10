-- Required to access other files.
local meta = ...
local update = meta.update
local unit = require('conditions.unit')

-- Init Friends
local om = meta.om
om.objects = {}
om.friends = {}
om.enemies = {}

-- The first frame call to GetObjectCount(true) should have total == #added and 'added' will contain all objects.
-- The next GetObjectCount(true) calls should have only the updated objects.
local function omUpdate()
    for k, v in pairs(om.objects) do
        om.objects[k] = nil
    end
    for k, v in pairs(om.friends) do
        om.friends[k] = nil
    end
    for k, v in pairs(om.enemies) do
        om.enemies[k] = nil
    end
    local numOfObjects = meta._G.GetObjectCount()
    for i = 1, numOfObjects do
        local thisUnit = meta._G.GetObjectWithIndex(i) -- thisUnit contains the '0x' string representing the object address 
        local objectType = meta._G.ObjectType(thisUnit)
        if objectType and objectType > 2 and objectType < 17 then
            local name = meta._G.UnitName(thisUnit)
            local id = meta._G.ObjectID(thisUnit)
            if objectType == 5 or objectType == 6 or objectType == 7 then
                if unit.canAttack(thisUnit) then
                    om.enemies[thisUnit] = {
                        name = name,
                        guid = thisUnit,
                        id = id,
                        unit = thisUnit
                    }
                end
                if unit.friend(thisUnit) then
                    om.friends[thisUnit] = {
                        name = name,
                        guid = thisUnit,
                        id = id,
                        unit = thisUnit
                    }
                end
            else
                om.objects[thisUnit] = {
                    name = name,
                    guid = thisUnit,
                    id = id,
                    unit = thisUnit
                }
            end
        end
    end

end

-- omUpdate()
update.register_callback(omUpdate)
_om = om
return om
