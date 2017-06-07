-- Required to access other files.
local meta  	= ...
local spell 	= require('conditions.spell')
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
for unitClass , classTable in pairs(spellList.idList) do
    if unitClass == select(2,UnitClass('player')) or unitClass == 'Shared' then
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
function debuff.info(self,unit,filter)
    local unit = unit or "player"
    local filter = filter or 'player'
    return UnitDebuff(unit,debuff.name(self),filter)
end

-- Debuff Exists
function debuff.exists(self,unit,filter)
    local debuff, _, _, _, _, _, _, caster = debuff.info(self,unit,filter)
    return debuff ~= nil and (caster == 'player' or caster == 'pet')
end

-- Debuff Count - return Number of Debuffs applied
function debuff.count(unit, spellCheck)
    return 0
end

-- Debuff Duration - return Duration of Debuff on Unit
function debuff.duration(self,unit,filter)
    if debuff.exists(self,unit,filter) then
        return (select(6,debuff.info(self,unit,filter)) * 1)
    end
    return 0
end

-- Debuff Remain - return Time Remaining on Debuff on Unit, if not Debuff the returns 0
function debuff.remain(self,unit,filter)
    if debuff.exists(self,unit,filter) then
        return (select(7,debuff.info(self,unit,filter)) - GetTime())
    end
    return 0
end

-- Debuff Refresh - return True/False if Debuff on Unit can be refreshed (Pandemic Mechanic)
function debuff.refresh(self,unit,filter)
    return debuff.remain(self,unit,filter) < debuff.duration(self,unit,filter) * 0.3
end

-- Debuff Stack - return Stack count of Debuff on Unit
function debuff.stack(self,unit,filter)
    if debuff.exists(self,unit,filter) then
        return select(4,debuff.info(self,unit,filter))
    end
    return 0
end

-- Return Functions
return debuff
