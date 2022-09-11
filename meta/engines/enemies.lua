-- Required to access other files.
local meta = ...
local update = meta.update
local base = require('conditions.base')
local unit = require('conditions.unit')
local om = meta.om

-- -- Init Enemies
local enemies = {}

function enemies.coeficient(thisUnit, distance)
    local coef = 0
    -- check if unit is valid
    if unit.exists(thisUnit) then
        if distance == nil then
            distance = unit.distance(thisUnit)
        end
        -- if unit is out of range, bad prio(0)
        if distance < 40 then
            -- increase coef of units closer to you
            coef = coef + (40 - distance) / 100
            -- if its our actual target we give it a bonus
            if unit.isUnit("target", thisUnit) == true then
                coef = coef + 1
            end
        end
    end
    return coef
end

-- Target "Best" Enemy
function enemies.target(range, facing)
    local bestUnit = "target"
    local bestUnitCoef = 0
    for k, v in pairs(om.enemies) do
        local thisUnit = om.enemies[k]
        if unit.exists(thisUnit.unit) then
            local thisFacing = unit.facing('player', thisUnit.unit)
            local thisDistance = unit.distance("player", thisUnit.unit)
            local thisCoeficient = om.enemies.coeficient(thisUnit.unit, thisDistance)
            if thisDistance < range and (facing == false or thisFacing == true) then
                if thisCoeficient >= 0 and thisCoeficient >= bestUnitCoef then
                    bestUnitCoef = thisCoeficient
                    bestUnit = thisUnit.unit
                end
            end
        end
    end
    return bestUnit
end

-- Enemies In Range
function enemies.inRange(sourceUnit, radius, combat, precise)
    local combat = combat or false
    local precise = precise or false
    if unit.exists(sourceUnit) and unit.visible(sourceUnit) then
        local tempEnemiesTable = {}
        for k, v in pairs(om.enemies) do
            local thisUnit = om.enemies[k].unit
            -- check if unit is valid
            if unit.exists(thisUnit) and (not combat or base.combat(thisUnit)) then
                if sourceUnit == "player" and not precise then
                    if unit.distance(thisUnit) <= radius then
                        tinsert(tempEnemiesTable, thisUnit)
                    end
                else
                    if unit.distance(sourceUnit, thisUnit) <= radius then
                        tinsert(tempEnemiesTable, thisUnit)
                    end
                end
            end
        end
        return tempEnemiesTable
    else
        return {}
    end
end

-- Return Functions
return enemies
