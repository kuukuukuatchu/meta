local meta  = ...
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
function base.cast(spellCast,castAt,castType,minimalUnits,effectRange)
    local spellName,_,_,_,minRange,maxRange,spellID = GetSpellInfo(spellCast)
    local minimalUnits                              = minimalUnits or 1
    local effectRange                               = effectRange or 8
    local inRange                                   = inRange or false
    local castCheck                                 = castCheck or false
    -- Assign Target and Verify in Range to Cast
    if castAt == nil then
        if not spell.harm(spellID) and not spell.help(spellID) then
            if unit.exists('target') then
                castAt = 'target'
            else
                castAt = 'player'
            end
            inRange =  spell.inRange(spellID,castAt)
        elseif maxRange and maxRange > 0 then
            if spell.help(spellID) and not spell.harm(spellID) then
                castAt = 'player' -- Assign dynamic friendly for range
            else
                castAt = 'target' -- Assign dynamic target for range
            end
            inRange = unit.distance(castAt) < maxRange and unit.distance(castAt) -- Verify unit is in range
        else
            if spell.help(spellID) and not spell.harm(spellID) then
                castAt = 'player' -- Assign player
            else
                castAt = 'target' -- Assign dynamic melee target
            end
            inRange = unit.distance(castAt) < 5 -- Verify in melee
        end
    elseif castType == "best" then
        -- Need a check to verify if best X/Y/Z coord is within spell's cast range
        inRange = true
    else
        inRange =  spell.inRange(spellID,castAt)
    end
    if spell.usable(spellID) and spell.cd(spellID) and spell.known(spellID) and inRange then
        if castType == "check" and unit.exists(castAt) and unit.sight(castAt) then
            castCheck = true
            return castCheck
        elseif castType == "best" then
            -- Find best location for minimalUnits and effectRange args and castAt
            return true
        elseif unit.exists(castAt) and unit.sight(castAt) then
            -- What type of spell are we trying to use at unit. (Help: Alive Friends, Harm: Alive Enemy, Dead: Dead Friends)
            if spell.help(spellID) and unit.friend(castAt) then
                -- If we are trying to ressurect only do so on dead friendly targets
                if castType == "dead" and unit.dead(castAt) then
                    CastSpellByName(spellName, castAt)
                    spell.last = spellID
                    unit.last = castAt
                elseif not castType == dead and not unit.dead(castAt) then
                    CastSpellByName(spellName, castAt)
                    if IsAoEPending() then
                        local X,Y,Z = unit.position(castAt)
                        ClickPosition(X,Y,Z)
                    end
                    spell.last = spellID
                    unit.last = castAt
                else
                    print('No Valid Friendly Units to cast '..spellName)
                end
            elseif unit.enemy(castAt) and not unit.dead(castAt) then
                CastSpellByName(spellName, castAt)
                if IsAoEPending() then
                    local X,Y,Z = unit.position(castAt)
                    ClickPosition(X,Y,Z)
                end
                spell.last = spellID
                unit.last = castAt
            else
                print('No Valid Enemy Units to cast '..spellName)
            end
        end
    else
        return castCheck
    end
end

return base
