-- Required to access other files.
local meta = ...
local update = meta.update
local unit     = require('conditions.unit')

-- Init Friends
local om = meta.om
om.objects = {}
om.friends = {}
om.enemies= {}

-- The first frame call to GetObjectCount(true) should have total == #added and 'added' will contain all objects.
-- The next GetObjectCount(true) calls should have only the updated objects.
local function omUpdate()
    local objects = meta._G.GetObjects()
    for i = 1, #objects do
        local thisUnit = objects[i].GUID -- thisUnit contains the '0x' string representing the object address 
        local objectType = meta._G.ObjectType(thisUnit)
        if objectType and objectType > 2 and objectType < 17 then
            local name = meta._G.UnitName(thisUnit)
            local id = meta._G.ObjectID(thisUnit)
            if objectType == 5 then
                if unit.canAttack(thisUnit) then
                    om.enemies[thisUnit] = {
                        name = name,
                        guid = thisUnit,
                        id = id,
                        unit = thisUnit
                    }
                end
                if unit.friend(thisUnit) then
                    om.friends[thisUnit] 	= {
                        name 			= name,
                        guid 			= thisUnit,
                        id 				= id,
                        unit            = thisUnit
                    }
                end
            else 
                om.objects[thisUnit] = {
                    name 			= name,
                    guid 			= thisUnit,
                    id 				= id,
                    unit            = thisUnit
                }
            end
        end
    end

end

-- omUpdate()
update.register_callback(omUpdate)
_om = om
return om
