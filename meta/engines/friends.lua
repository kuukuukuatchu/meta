-- Required to access other files.
local meta  = ...
local update = meta.update
local base 	= require('conditions.base')
local unit 	= require('conditions.unit')
local om = meta.om

-- Init Friends
local friends = { }
-- party = { }

local function create(thisUnit)
    if type(thisUnit) ~= "string" then
        return nil
    end
    local id, uid = unit.id(thisUnit)
    if not id then
        return nil
    end
    local u = {}
    u.unit = thisUnit
    u.guid = meta._G.UnitGUID(thisUnit)
    u.id = id
    u.uid = uid and uid or id
    u.class = meta._G.UnitClass(thisUnit)
    u.name = meta._G.UnitName(thisUnit)
    function u.update(self)
        if self.name == "Unknown" then
            self.name = meta._G.UnitName(self.unit)
        end
        if self.guid == "0000000000000000" then
            self.guid = meta._G.UnitGUID(self.unit)
            local id, uid = unit.id(self.unit)
            self.uid = uid and uid or id
            self.id = id
        end
        if self.class == "Unknown" then
            self.class = meta._G.UnitClass(self.unit)
        end
        self.hp = unit.hp(self.unit)
    end
    
    return setmetatable(u, {
        __index = function(table, key)
            if unit[key] then
                rawset(table, key, function(...)
                    return unit[key](u.guid, ...)
                end)
                return table[key]
            end
        end
    })
end

function friends.update(self)
    for i = 1, #self do
        self[i]:update()
    end
    table.sort(self, function(x,y)
        return x.hp < y.hp
    end)
end

function friends.populate(self, ...)
    local group = IsInRaid() and "raid" or "party"
    local size = group == "raid" and GetNumGroupMembers() or GetNumGroupMembers() - 1
    if group == "party" then
        tinsert(self, create("player"))
    end
    for i = 1, size do
        local unit = group..i
        local member = create(unit)
        if member then
            tinsert(self, member)
        end
        local pettoken = unit.."pet"
        if UnitExists(pettoken) then
            local pet = create(pettoken)
            if pet then
                tinsert(self, pet)
            end
        end
    end
end

function friends.reset(self)
    for i = 1, #self do
        self[i] = nil
    end
    self:populate()
end

function friends.remove(self, token)
    for i = 1, #self do
        if self[i].unit == token then
            tremove(self, i)
            return
        end
    end
end

local function event_handler(event, ...)
    if event == "UNIT_PET" then
        local unit = ...
        for i = 1, #friends do
            if friends[i].unit == unit then
                local pettoken = friends[i].unit.."pet"
                if UnitExists(pettoken) then
                    tinsert(friends, cache:create(pettoken))
                else
                    friends:remove(pettoken)
                end
                return
            end
        end
    else
        friends:reset()
    end
end

meta.events.register_callback("UNIT_PET", event_handler)
meta.events.register_callback("GROUP_ROSTER_UPDATE", event_handler)
meta.events.register_callback("PLAYER_ENTERING_WORLD", event_handler)
meta.update.register_callback(function()
    friends:update()
end)

-- -- Collect Friends
-- function friends.engine()
--     for k,v in pairs(om) do
-- 		-- define our unit
--         local thisUnit = k
-- 		-- check if it a unit first
-- 			-- sanity checks
--         if unit.friend(thisUnit) then
--             -- Check if Friend exists already and update info.
--             local addFriend
--             if addFriend == nil then addFriend = true end
--             if friends ~= nil then
--                 for k, v in pairs(friends) do
--                     if k == thisUnit then
--                         addFriend = false
--                         break
--                     end
--                 end
--             end
--             -- If not then add friend
--             if addFriend then		
--                 friends[thisUnit] 	= {
--                     name 			= thisUnit.unitName,
--                     guid 			= thisUnit,
--                     id 				= thisUnit.UnitID,
--                     unit            = thisUnit
--                 }
--             end
--         end
-- 	end
-- end

-- -- Update Friends
-- function friends.update()
-- 	if friends ~= nil then
-- 		for k, v in pairs(friends) do
-- 			if type(v) ~= 'function' then
-- 				local thisUnit 			= k
-- 				friends[k].name 		= meta._G.UnitName(thisUnit)
-- 				friends[k].guid 		= meta._G.UnitGUID(thisUnit)
-- 				friends[k].id 			= unit.id(thisUnit)
-- 				friends[k].unit 		= thisUnit
-- 			end
-- 		end
-- 	end
-- end

-- -- Remove Invalid Friends
-- function friends.cleanup()
-- 	for k, v in pairs(friends) do
-- 		if type(v) ~= 'function' then
-- 			-- here i want to scan the friends table and find any occurances of invalid units
-- 			if not unit.exists(friends[k].unit) or meta._G.UnitIsDeadOrGhost(friends[k].unit) or not unit.visible(friends[k].unit) or unit.distance('player',friends[k].unit) > 40 then
-- 				-- i will remove such units from table
-- 				friends[k] = nil
-- 			end
-- 		end
-- 	end
-- end

-- -- Build Friends
-- update.register_callback(function ()
--     -- Initialize Friends Engine
-- 	-- friends.engine()
-- 	-- friends.update()
-- 	-- friends.cleanup()
-- end)

-- Friends In Range
function friends.inRange(sourceUnit,radius,combat,precise)
	local combat = combat or false
	local precise = precise or false
	if unit.exists(sourceUnit) and unit.visible(sourceUnit) then
		local tempFriendsTable = { }
		for k, v in pairs(om.friends) do
			if type(v) ~= 'function' then
				local thisUnit = om.friends[k].unit
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