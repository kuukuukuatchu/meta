-- Required to access other files.
local meta      = ...
local spell     = require('conditions.spell')
local spellList = require('lists.spellList')

-- Init Buff
local buff = { }

-- Get Buff IDs for Spec
-- for k, v in pairs(idList.buffs) do
--     buff[k] = v
-- end
for unitClass , classTable in pairs(spellList.idList) do
    if unitClass == select(2,UnitClass('player')) or unitClass == 'Shared' then
        for spec, specTable in pairs(classTable) do
            if spec == GetSpecializationInfo(GetSpecialization()) or spec == 'Shared' then
                for spellType, spellTypeTable in pairs(specTable) do
                    if spellType == 'buffs' then
                        for spell, spellID in pairs(spellTypeTable) do
                            buff[spell] = spellID
                        end
                    end
                end
            end
        end
    end        
end

-----------------------------------
--- Buff Related Functions Here ---
-----------------------------------

-- Buff Exists
function buff.exists(unit, spellCheck, filter)
    filter = filter or 'player'
    if filter == nil or filter == 'player' then
		return UnitBuff(unit,spell.name(spellCheck)) ~= nil
	else
		return UnitBuff(unit,spell.name(spellCheck),filter) ~= nil
	end
end

-- Buff Count - return Number of Buffs applied
function buff.count(unit, spellCheck)

end

-- Buff Duration - return Duration of Buff on Unit
function buff.duration(unit, spellCheck)
    if buff.exists(unit,spellCheck) then
        return (select(6,UnitBuff(unit,spell.name(spellCheck))) * 1)
    end
    return 0
end

-- Buff Remain - return Time Remaining on Buff on Unit, if not Buff the returns 0
function buff.remain(unit, spellCheck)
    if buff.exists(unit,spellCheck) then
        return (select(7,UnitBuff(unit,spell.name(spellCheck))) - GetTime())
    end
    return 0
end

-- Buff Refresh - return True/False if Buff on Unit can be refreshed (Pandemic Mechanic)
function buff.refresh(unit, spellCheck)
    return buff.remain(unit, spellCheck) < buff.duration(unit, spellCheck) * 0.3
end

-- Buff Stack - return Stack count of Buff on Unit
function buff.stack(unit,spellCheck)
    if buff.exists(unit,spellCheck) then
        return select(4,UnitBuff(unit,spell.name(spellCheck)))
    end
    return 0
end

-- Return Functions
return buff
