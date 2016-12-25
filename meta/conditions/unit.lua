-- Required to access other files.
local meta  = ...
local spell = require('conditions.spell')

-- Init Unit
local unit = { }

-----------------------------------
--- Unit Related Functions Here ---
-----------------------------------

function unit.bestHelp(spellID)
    if spell.maxRange(spellID) > 0 then
        return 'player' -- Dynamic Assign Friendly in Range
    else
        return 'player' -- Default to 'player'
    end
end

function unit.bestHarm(spellID)
    if spell.maxRange(spellID) > 0 then
        return 'target' -- Dynamic Assign Enemy in Range
    else
        return 'target' -- Default to Melee Range
    end
end

function unit.bestNone(spellID)
    if unit.exists('target') then
        return 'target'
    else
        return 'player'
    end
end

function unit.getBest(spellID)
    if spell.help(spellID) and not spell.harm(spellID) then
        return unit.bestHelp(spellID)
    end
    if spell.harm(spellID) then
        return unit.bestHarm(spellID)
    end
    if not spell.help(spellID) and not spell.harm(spellID) then
        return unit.bestNone(spellID)
    end
end

function unit.exists(unit)
    if (FireHack and ObjectExists(unit)) or (not FireHack and UnitExists(unit)) then
        return true
    end
end

function unit.visible(unit)
    return UnitIsVisible(unit)
end

function unit.position(unit)
    return ObjectPosition(unit)
end

function unit.id(unit)
    if FireHack and ObjectExists(unit) then
		return ObjectID(unit)
	else
		return 0
	end
end

function unit.noSightValid(unit1,unit2)
    unit2 = unit2 or 'player'
    local skipLoSTable = {
        76585, 	-- Ragewing
        77692, 	-- Kromog
        77182, 	-- Oregorger
        96759, 	-- Helya
        100360,	-- Grasping Tentacle (Helya fight)
        100354,	-- Grasping Tentacle (Helya fight)
        100362,	-- Grasping Tentacle (Helya fight)
        98363,	-- Grasping Tentacle (Helya fight)
        98696, 	-- Illysanna Ravencrest (Black Rook Hold)
        114900, -- Grasping Tentacle (Trials of Valor)
        114901, -- Gripping Tentacle (Trials of Valor)
        116195, -- Bilewater Slime (Trials of Valor)
        --86644, -- Ore Crate from Oregorger boss
    }
    for i = 1,#skipLoSTable do
        if unit.id(unit1) == skipLoSTable[i] or unit.id(unit2) == skipLoSTable[i] then
            return true
        end
    end
    return false
end

function unit.sight(unit1,unit2)
    unit2 = unit2 or 'player'
    if unit.exists(unit1) and unit.visible(unit1) and unit.exists(unit2) and unit.visible(unit2) then
        local X1,Y1,Z1 = unit.position(unit1)
        local X2,Y2,Z2 = unit.position(unit2)
        return unit.noSightValid(unit1,unit2) or not TraceLine(X1,Y1,Z1 + 2,X2,Y2,Z2 + 2, 0x10)
    end
end

function unit.moving(unit)
    return GetUnitSpeed(unit) > 0
end

function unit.distance(unit1,unit2)
    local unit2 = unit2 or 'player'
    -- Check if objects exists and are visible
	if unit.sight(unit1,unit2) then
	-- Get the distance
		local X1,Y1,Z1 = unit.position(unit1)
		local X2,Y2,Z2 = unit.position(unit2)
		local TargetCombatReach = UnitCombatReach(unit1)
    	local PlayerCombatReach = UnitCombatReach(unit2)
		local MeleeCombatReachConstant = 4/3
    	if unit.moving(unit1) and unit.moving(unit2) then
			IfSourceAndTargetAreRunning = 8/3
		else
			IfSourceAndTargetAreRunning = 0
    	end
		local dist = math.sqrt(((X2-X1)^2) + ((Y2-Y1)^2) + ((Z2-Z1)^2)) - (PlayerCombatReach + TargetCombatReach) --  - rangeMod
		local dist2 = dist + 0.03 * ((13 - dist) / 0.13)
		local dist3 = dist + 0.05 * ((8 - dist) / 0.15) + 1
		local dist4 = dist + (PlayerCombatReach + TargetCombatReach)
    	local meleeRange = max(5, PlayerCombatReach + TargetCombatReach + MeleeCombatReachConstant + IfSourceAndTargetAreRunning)
		if dist > 13 then
			return dist
		elseif dist2 > 8 then
			return dist2
		elseif dist3 > 5 then
			return dist3
		elseif dist4 > meleeRange then -- Thanks Ssateneth
			return dist4
		else
			return 0
		end
	else
		return 100
	end
end

function unit.inRange(spellID,unitCheck)
	local spellName = spell.name(spellID)
	if not SpellHasRange(spellName) then
		return unit.distance(unitCheck) < 5
	else
    	return IsSpellInRange(spellName,unitCheck) == 1
	end
end

function unit.friend(unit1,unit2)
    local unit2 = unit2 or 'player'
    return UnitIsFriend(unit1,unit1) ~= nil
end

function unit.enemy(unit1,unit2)
    local unit2 = unit2 or 'player'
    return UnitIsEnemy(unit1,unit1) ~= nil
end

function unit.dead(unit)
    return UnitIsDeadOrGhost(unit)
end

-- Return Functions
return unit
