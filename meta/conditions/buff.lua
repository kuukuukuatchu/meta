-- Required to access other files.
local meta = ...

-- Init Buff
local buff = { }

-----------------------------------
--- Buff Related Functions Here ---
-----------------------------------

-- Buff Exists
function buff.exists(unit, spell)
	-- if tonumber(spell) then end
    local buff, _, _, _, _, _, _, caster = UnitBuff(unit, spell)
    if buff and (caster == 'player' or caster == 'pet') then
      return true
    end
    return false
end

-- Buff Count - return Number of Buffs applied
function buff.count(spell)

end

-- Buff Duration - return Duration of Buff on Unit
function buff.duration(unit, spell)

end

-- Buff Refresh - return True/False if Buff on Unit can be refreshed (Pandemic Mechanic) 
function buff.refresh(unit,spell)

end

-- Buff Remain - return Time Remaining on Buff on Unit, if not Buff the returns 0
function buff.remain(unit, spell)

end

-- Buff Stack - return Stack count of Buff on Unit
function buff.stack(unit,spell)

end


-- Return Functions
return buff
