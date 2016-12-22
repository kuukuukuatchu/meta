-- Required to access other files.
local meta  = ...
local spell = require('conditions.spell')

-- Init Debuff
local debuff = { }

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
