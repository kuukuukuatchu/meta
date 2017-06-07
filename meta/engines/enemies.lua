-- Required to access other files.
local meta  = ...
local base 	= require('conditions.base')
local unit 	= require('conditions.unit')

-- Init Enemies
enemies = { }

-- Collect Enemies
function enemies.engine()
	for i = 1, ObjectCount() do
		-- define our unit
		--local thisUnit = GetObjectIndex(i)
        local thisUnit = GetObjectWithIndex(i)
		-- check if it a unit first
        if ObjectIsType(thisUnit, ObjectTypes.Unit)  then
			-- sanity checks
			if unit.valid(thisUnit) then
				local unitName 			= UnitName(thisUnit)
				local unitID 			= ObjectID(thisUnit)
				local unitGUID 			= UnitGUID(thisUnit)
                -- Check if Enemy exists already and update info.
                local addEnemy
				if addEnemy == nil then addEnemy = true end
				if enemies ~= nil then
					for k, v in pairs(enemies) do
						if k == thisUnit then
							addEnemy = false
							break
						end
					end
				end
				-- If not then add enemy
				if addEnemy then							
					enemies[thisUnit] 	= {
						name 			= unitName,
						guid 			= unitGUID,
						id 				= unitID,
					}
				end
			end
		end
	end
end

-- Update Enemies
function enemies.update()
	if enemies ~= nil then
		for k, v in pairs(enemies) do
			if type(v) ~= 'function' then
				local thisUnit 			= k
				enemies[k].name 		= UnitName(thisUnit)
				enemies[k].guid 		= UnitGUID(thisUnit)
				enemies[k].id 			= unit.id(thisUnit)
				enemies[k].unit 		= thisUnit
			end
		end
	end
end

-- Remove Invalid Enemies
function enemies.cleanup()
	for k, v in pairs(enemies) do
		if type(v) ~= 'function' then
			-- here i want to scan the enemies table and find any occurances of invalid units
			if not unit.exists(enemies[k].unit) or UnitIsDeadOrGhost(enemies[k].unit) or not unit.visible(enemies[k].unit) or unit.distance('player',enemies[k].unit) > 40 then
				-- i will remove such units from table
				enemies[k] = nil
			-- elseif unit.distance(enemies[k].unit) > 40 then
			-- 	enemies[k] = nil
			end
		end
	end
end

-- Build Enemies
AddFrameCallback(function ()
    -- Initialize Enemies Engine
	enemies.engine()
	enemies.update()
	enemies.cleanup()
end)

function enemies.coeficient(thisUnit, distance)
	local coef = 0
	if distance == nil then distance = unit.distance(thisUnit) end
	-- check if unit is valid
	if unit.exists(thisUnit) then
		-- if unit is out of range, bad prio(0)
		if distance < 40 then
			-- increase coef of units closer to you
			coef = coef + (40 - distance)/100
			-- if its our actual target we give it a bonus
			if unit.isUnit("target",thisUnit) == true then
				coef = coef + 1
			end
		end
	end
	return coef
end

-- Target "Best" Enemy
function enemies.target(range,facing)
	local bestUnit = "target"
	local bestUnitCoef = 0
	for k, v in pairs(enemies) do
		if type(v) ~= 'function' then
			local thisUnit 			= enemies[k]
			local thisFacing 		= unit.facing('player',thisUnit.unit)
			local thisDistance 		= unit.distance("player",thisUnit.unit)
			local thisCoeficient 	= enemies.coeficient(thisUnit.unit,thisDistance)
			if unit.exists(thisUnit.unit) then
				if thisDistance < range and (facing == false or thisFacing == true) then
					if thisCoeficient >= 0 and thisCoeficient >= bestUnitCoef then
						bestUnitCoef = thisCoeficient
						bestUnit = thisUnit.unit
					end
				end
			end
		end
	end
	return bestUnit
end

-- Enemies In Range
function enemies.inRange(sourceUnit,radius,combat,precise)
	local combat = combat or false
	local precise = precise or false
	if unit.exists(sourceUnit) and unit.visible(sourceUnit) then
		local tempEnemiesTable = { }
		for k, v in pairs(enemies) do
			if type(v) ~= 'function' then
				local thisUnit = enemies[k].unit
				local thisDistance = unit.distance(thisUnit)
				-- check if unit is valid
				if unit.exists(thisUnit) and (not combat or base.combat(thisUnit)) then
	                if sourceUnit == "player" and not precise then
	                    if thisDistance <= radius then
	                        tinsert(tempEnemiesTable,thisUnit)
	                    end
	                else
	                    if unit.distance(sourceUnit,thisUnit) <= radius then
	                        tinsert(tempEnemiesTable,thisUnit)
	                    end
	                end
				end
			end
		end
		return tempEnemiesTable
	else
		return { }
	end
end

-- Return Functions
return enemies