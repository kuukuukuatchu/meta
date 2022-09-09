local meta      = ...
local spell     = require('conditions.spell')
local spellList = require('lists.spellList')

-- Init Base
local base      = { }

castable = {}

for unitClass , classTable in pairs(spellList.idList) do
    if unitClass == select(2,UnitClass('player')) or unitClass == 'Shared' then
        for spec, specTable in pairs(classTable) do
            if spec == GetSpecializationInfo(GetSpecialization()) or spec == 'Shared' then
                for spellType, spellTypeTable in pairs(specTable) do
                    if spellType == 'abilities' then
                        for spellRef, spellID in pairs(spellTypeTable) do
                            base[spellRef] = spell.new(spellID)
                            castable[spellRef] = spellID
                        end
                    end
                end
            end
        end
    end        
end

-- Tag print return with [Name] - Colored to current class.
local function join(...)
    local ret = ' '
    for n = 1, select('#', ...) do
        ret = ret .. ', ' .. tostring(select(n, ...))
    end
    return ret:sub(3)
end

function base.print(...)
    local class = select(2, UnitClass('player'))
    local color = CreateColor(GetClassColor(class))
    print(color:WrapTextInColorCode('[meta]')..join(...))
end

-- Return Combat for Unit - True/False
function base.combat(unitCheck)
    return meta._G.UnitAffectingCombat(unitCheck) ~= nil
end

function base.inPvp()
    return GetPVPTimer() ~= 301000 and GetPVPTimer() ~= -1
end

-- Starts the Auto Attack
function base.startAttack(unitCheck)
    local unit = unitCheck or 'target'
    if not IsCurrentSpell(6603) then
        return meta._G.StartAttack(unit)
    end
end

-- Stops the Auto Attack
function base.stopAttack(unitCheck)
    local unit = unitCheck or 'target'
    if IsCurrentSpell(6603) then
        return meta._G.StopAttack(unit)
    end
end

return base
