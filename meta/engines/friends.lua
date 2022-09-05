-- Required to access other files.
local meta  = ...
local update = meta.update
local base 	= require('conditions.base')
local unit 	= require('conditions.unit')
local om = meta.om

-- Init Friends
friends = { }
party = { }

-- Collect Friends
function friends.engine()
    for k,v in pairs(om) do
		-- define our unit
        local thisUnit = k
		-- check if it a unit first
			-- sanity checks
        if unit.friend(thisUnit) then
            -- Check if Friend exists already and update info.
            local addFriend
            if addFriend == nil then addFriend = true end
            if friends ~= nil then
                for k, v in pairs(friends) do
                    if k == thisUnit then
                        addFriend = false
                        break
                    end
                end
            end
            -- If not then add friend
            if addFriend then		
                friends[thisUnit] 	= {
                    name 			= thisUnit.unitName,
                    guid 			= thisUnit,
                    id 				= thisUnit.UnitID,
                    unit            = thisUnit
                }
            end
        end
	end
end

-- Update Friends
function friends.update()
	if friends ~= nil then
		for k, v in pairs(friends) do
			if type(v) ~= 'function' then
				local thisUnit 			= k
				friends[k].name 		= meta._G.UnitName(thisUnit)
				friends[k].guid 		= meta._G.UnitGUID(thisUnit)
				friends[k].id 			= unit.id(thisUnit)
				friends[k].unit 		= thisUnit
			end
		end
	end
end

-- Remove Invalid Friends
function friends.cleanup()
	for k, v in pairs(friends) do
		if type(v) ~= 'function' then
			-- here i want to scan the friends table and find any occurances of invalid units
			if not unit.exists(friends[k].unit) or meta._G.UnitIsDeadOrGhost(friends[k].unit) or not unit.visible(friends[k].unit) or unit.distance('player',friends[k].unit) > 40 then
				-- i will remove such units from table
				friends[k] = nil
			end
		end
	end
end

-- Build Friends
update.register_callback(function ()
    -- Initialize Friends Engine
	friends.engine()
	friends.update()
	friends.cleanup()
end)

-- Friends In Range
function friends.inRange(sourceUnit,radius,combat,precise)
	local combat = combat or false
	local precise = precise or false
	if unit.exists(sourceUnit) and unit.visible(sourceUnit) then
		local tempFriendsTable = { }
		for k, v in pairs(friends) do
			if type(v) ~= 'function' then
				local thisUnit = friends[k].unit
				local thisDistance = unit.distance(thisUnit)
				-- check if unit is valid
				if unit.exists(thisUnit) and (not combat or base.combat(thisUnit)) then
	                if sourceUnit == "player" and not precise then
	                    if thisDistance <= radius then
	                        tinsert(tempFriendsTable,thisUnit)
	                    end
	                else
	                    if unit.distance(sourceUnit,thisUnit) <= radius then
	                        tinsert(tempFriendsTable,thisUnit)
	                    end
	                end
				end
			end
		end
		return tempFriendsTable
	else
		return { }
	end
end

-- Return Functions
return friends