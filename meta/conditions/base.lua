local meta  = ...
local cast = require('conditions.cast')
local spell = require('conditions.spell')
local unit  = require('conditions.unit')
local base  = { }

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
function base.combat(unit)
    return UnitAffectingCombat(unit) ~= nil
end

-- Starts the Auto Attack
function base.startAttack(unit)
    local unit = unit or 'target'
    if not IsCurrentSpell(6603) then
        return StartAttack(unit)
    end
end

-- Stops the Auto Attack
function base.stopAttack(unit)
    local unit = unit or 'target'
    if IsCurrentSpell(6603) then
        return StopAttack(unit)
    end
end

-- Return Cast
function base.castSpell(spellCast,unitCast)
    if unitCast == nil then
        unitCast = unit.best(spellCast)
    end
    if cast.check(spellCast,unitCast) then
        --cast.best(spellID) -- not sure how to add this one
        if unit.dead(unitCast) then
            cast.dead(spellCast,unitCast)
        elseif unit.friend(unit) then
            cast.friend(spellCast,unitCast)
        else
            cast.enemy(spellCast,unitCast)
        end
    end
end

return base
