-- Required to access other files.
local meta      = ...
local spellList = require('conditions.spellList')
local unit      = require('conditions.unit')

-- Init VengeanceCuteOne
local VengeanceCuteOne = {}

-- Get Vengeance Spells
local idList = {}
idList = spellList.mergeIdTables(idList)
for k, v in pairs(idList) do
    base[k] = v
end

--------------------------
--- Vengeance: CuteOne ---
--------------------------

-- Start Attack
-- actions=auto_attack
startAttack()


-- Throw Glaive
if cast(throwGlaive,nil,'check') and unit.distance('target') > 5 then
    cast(throwGlaive)
end

-- Return Profile
return VengenaceCuteOne
