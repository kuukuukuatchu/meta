-- Required to access other files.
local meta      = ...
local spell     = require('conditions.spell')
local spellList = require('lists.spellList')
-- for k, v in pairs(idList.buffs) do
--     buff[k] = v
-- end

-- Init Buff
local buff = {}
local buffID = {}
buff.__index = buff

function buff.new(spellID)
    local self = setmetatable({}, buff)
        self.Buff = spellID
    return self
end

function buff.name(self)
    return GetSpellInfo(self.Buff)
end

-- Get Buff IDs for Spec
for unitClass , classTable in pairs(spellList.idList) do
    if unitClass == select(2,UnitClass('player')) or unitClass == 'Shared' then
        for spec, specTable in pairs(classTable) do
            if spec == GetSpecializationInfo(GetSpecialization()) or spec == 'Shared' then
                for spellType, spellTypeTable in pairs(specTable) do
                    if spellType == 'buffs' then
                        for spell, spellID in pairs(spellTypeTable) do
                            buff[spell] = buff.new(spellID)
                            buffID[spell] = spellID
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

-- Buff Info
function buff.info(self,unit,filter)
    local unit = unit or "player"
    local filter = filter or 'player'
    return UnitBuff(unit,buff.name(self),filter)
end

-- Buff Exists
function buff.exists(self,unit,filter)
    return buff.info(self,unit,filter) ~= nil
end

-- Buff Count - return Number of Buffs applied
function buff.count(unit, spellCheck)
    return 0
end

-- Buff Duration - return Duration of Buff on Unit
function buff.duration(self,unit,filter)
    if buff.exists(self,unit,filter) then
        return (select(6,buff.info(self,unit,filter)) * 1)
    end
    return 0
end

-- Buff Remain - return Time Remaining on Buff on Unit, if not Buff the returns 0
function buff.remain(self,unit,filter)
    if buff.exists(self,unit,filter) then
        return (select(7,buff.info(self,unit,filter)) - GetTime())
    end
    return 0
end

-- Buff Refresh - return True/False if Buff on Unit can be refreshed (Pandemic Mechanic)
function buff.refresh(self,unit,filter)
    return buff.remain(self,unit,filter) < buff.duration(self,unit,filter) * 0.3
end

-- Buff Stack - return Stack count of Buff on Unit
function buff.stack(self,unit,filter)
    if buff.exists(self,unit,filter) then
        return select(4,buff.info(self,unit,filter))
    end
    return 0
end

-- Return Functions
return buff
