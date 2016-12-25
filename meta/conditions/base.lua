local meta      = ...
local cast      = require('conditions.cast')
local unit      = require('conditions.unit')
local spellList = require('conditions.spellList')
local base      = { }

idList = {}
idList = spellList.mergeIdTables(idList)
for k, v in pairs(idList) do
    base[k] = v
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
    return UnitAffectingCombat(unitCheck) ~= nil
end

-- Starts the Auto Attack
function base.startAttack(unitCheck)
    local unit = unit or 'target'
    if not IsCurrentSpell(6603) then
        return StartAttack(unitCheck)
    end
end

-- Stops the Auto Attack
function base.stopAttack(unitCheck)
    local unit = unit or 'target'
    if IsCurrentSpell(6603) then
        return StopAttack(unitCheck)
    end
end

-- -- Return Cast
-- function base.castSpell(spellCast,unitCast)
--     unitCast = unitCast or unit.getBest(spellCast)
--     -- cast.best(spellID) -- not sure how to add this one
--     if unit.friend(unitCast) and unit.dead(unitCast) then
--     cast.dead(spellCast,unitCast)
--     cast.friend(spellCast,unitCast)
--     cast.enemy(spellCast,unitCast)
-- end

return base
