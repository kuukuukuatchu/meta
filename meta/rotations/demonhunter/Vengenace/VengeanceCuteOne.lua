-- Required to access other files.
local meta      = ...
local spellList = require('conditions.spellList')
local unit      = require('conditions.unit')

local profileID = 581
local profileName = "CuteOne"

-- Init VengeanceCuteOne
local VengeanceCuteOne = {}
-- local rotation.ID = 581
-- local rotation.Name = "CuteOne"
-- local rotationFunction = VengeanceCuteOne.runRotation()

-- Get Vengeance Spells
-- local idList = {}
-- idList = spellList.mergeIdTables(idList)
-- for k, v in pairs(idList) do
--     base[k] = v
-- end

--------------------------
--- Vengeance: CuteOne ---
--------------------------

-- Start Attack
    -- actions=auto_attack
    startAttack()


-- Throw Glaive
    if cast.check(throwGlaive) and unit.distance('target') > 5 then
        cast(throwGlaive)
    end

-- end

-- Return Profile
return VengenaceCuteOne
