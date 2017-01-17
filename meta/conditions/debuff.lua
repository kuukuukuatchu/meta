-- Required to access other files.
local meta  	= ...
local spell 	= require('conditions.spell')
local spellList = require('lists.spellList')

-- Init Debuff
local debuff = { }

-- Get Debuff IDs for Spec
-- for k, v in pairs(idList.debuffs) do
--     debuff[k] = v
-- end
for unitClass , classTable in pairs(spellList.idList) do
    if unitClass == select(2,UnitClass('player')) or unitClass == 'Shared' then
        for spec, specTable in pairs(classTable) do
            if spec == GetSpecializationInfo(GetSpecialization()) or spec == 'Shared' then
                for spellType, spellTypeTable in pairs(specTable) do
                    if spellType == 'debuffs' then
                        for spell, spellID in pairs(spellTypeTable) do
                            debuff[spell] = spellID
                        end
                    end
                end
            end
        end
    end        
end

-----------------------------------
--- Debuff Related Functions Here ---
-----------------------------------

-- Debuff Exists
function debuff.exists(unit, spellCheck, source)
    source = source or 'player'
    local debuff, _, _, _, _, _, _, caster = UnitDebuff(unit, spell.name(spellCheck), source)
    if debuff and (caster == 'player' or caster == 'pet') then
      return true
    end
    return false
end

-- Return Functions
return debuff
