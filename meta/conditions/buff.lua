-- Required to access other files.
local meta  = ...
local spell = require('conditions.spell')

-- Init Buff
local buff = { }

-----------------------------------
--- Buff Related Functions Here ---
-----------------------------------

-- Buff Exists
function buff.exists(unit, spellCheck, source)
    source = source or 'player'
    return UnitBuff(unit, spell.name(spellCheck), source)
end

-- Buff Count - return Number of Buffs applied
function buff.count(unit, spellCheck)

end

-- Buff Duration - return Duration of Buff on Unit
function buff.duration(unit, spellCheck)

end

-- Buff Refresh - return True/False if Buff on Unit can be refreshed (Pandemic Mechanic)
function buff.refresh(unit, spellCheck)

end

-- Buff Remain - return Time Remaining on Buff on Unit, if not Buff the returns 0
function buff.remain(unit, spellCheck)

end

-- Buff Stack - return Stack count of Buff on Unit
function buff.stack(unit,spellCheck)
    return select(4,UnitBuff(unit,spell.name(spellCheck))) or 0
end

-- Return Functions
return buff
