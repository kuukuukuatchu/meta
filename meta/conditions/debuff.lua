-- Required to access other files.
local meta = ...
local spell = require('conditions.spell')
local spellList = require('lists.spellList')

-- Init Debuff
local debuff = {}
local debuffID = {}
debuff.__index = debuff

function debuff.new(spellID)
    local self = setmetatable({}, debuff)
    self.Debuff = spellID
    return self
end

function debuff.name(self)
    return GetSpellInfo(self.Debuff)
end

-- Get Debuff IDs for Spec
for unitClass, classTable in pairs(spellList.idList) do
    if unitClass == select(2, UnitClass('player')) or unitClass == 'Shared' then
        for spec, specTable in pairs(classTable) do
            if spec == GetSpecializationInfo(GetSpecialization()) or spec == 'Shared' then
                for spellType, spellTypeTable in pairs(specTable) do
                    if spellType == 'debuffs' then
                        for spell, spellID in pairs(spellTypeTable) do
                            debuff[spell] = debuff.new(spellID)
                            debuffID[spell] = spellID
                        end
                    end
                end
            end
        end
    end
end

-------------------------------------
--- Debuff Related Functions Here ---
-------------------------------------

-- Debuff Info
function debuff.info(self, unit, filter)
    local unit = unit or "player"
    local filter = filter or 'player'
    local exactSearch = filter == "EXACT"
    if exactSearch then
        for i = 1, 40 do
            local buffName, icon, count, debuffType, duration, expire, source, isStealable, showPersonal, buffSpellID = meta._G.UnitDebuff(unit, i, "player")
            if buffName == nil then
                return nil
            end
            if buffSpellID == self.Buff then
                return buffName, icon, count, debuffType, duration, expire, source, isStealable, showPersonal, buffSpellID
            end
        end
    else
        if filter == "PLAYER" then
            return meta._G.AuraUtil.FindAuraByName(debuff.name(self), unit, "HARMFUL|PLAYER")
        end
        return meta._G.AuraUtil.FindAuraByName(debuff.name(self), unit, "HARMFUL")
    end
end

-- Debuff Exists
function debuff.exists(self, unit, filter)
    local debuff, icon, _, _, _, _, caster = debuff.info(self, unit, filter)
    return debuff ~= nil and (caster == 'player' or caster == 'pet')
end

-- Debuff Count - return Number of Debuffs applied
function debuff.count(unit, spellCheck)
    return select("#", UnitAuraSlots(unit, "HARMFUL"))
end

-- Debuff Duration - return Duration of Debuff on Unit
function debuff.duration(self, unit, filter)
    local duration = select(5, debuff.info(self, unit, filter))
    return duration or 0
end

-- Debuff Remain - return Time Remaining on Debuff on Unit, if not Debuff the returns 0
function debuff.remain(self, unit, filter)
    local remain = select(6, debuff.info(self, unit, filter)) - GetTime()
    return remain or 0
end

-- Debuff Refresh - return True/False if Debuff on Unit can be refreshed (Pandemic Mechanic)
function debuff.refresh(self, unit, filter)
    return debuff.remain(self, unit, filter) < debuff.duration(self, unit, filter) * 0.3
end

-- Debuff Stack - return Stack count of Debuff on Unit
function debuff.stack(self, unit, filter)
    local stack = select(3, debuff.info(self, unit, filter))
    return stack or 0
end

-- Return Functions
return debuff
