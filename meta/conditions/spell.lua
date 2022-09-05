-- Required to access other files.
local meta 		= ...
-- local base 		= require('conditions.base')
-- local spellList = require('lists.spellList')

-- Init Spell
local spell = { }
spell.__index = spell

function spell.new(spellID)
    local self = setmetatable({}, spell)
        self.Spell = spellID
    return self
end

function spell.object(spellID)
	for k, v in pairs(spell) do
		if spell[k].Spell == spellID then
			return k
		end
	end
end

function spell.id(self)
	-- local spellID = self.Spell
	if self == nil then return 0 end
	return self.Spell
end

function spell.info(self)
	if type(self) == "number" then
		return GetSpellInfo(self)
	else
		return GetSpellInfo(self.Spell)
	end
end

function spell.name(self)
	return select(1,spell.info(self))
end

-- shear = spell.new(203782)
-- -- print(shear:name())

-- Returns current world Latency
local function latency()
	local lag = select(4,GetNetStats()) / 1000
	if lag < .05 then
		lag = .05
	elseif lag > .4 then
		lag = .4
	end
	return lag
end

------------------------------------
--- Spell Related Functions Here ---
------------------------------------

function spell.bestHelp(self)
    if spell.maxRange(self) > 0 then
        return 'player' -- Dynamic Assign Friendly in Range
    else
        return 'player' -- Default to 'player'
    end
end

function spell.last(self)
	if not lastSpell then lastSpell = 0 end
	if self == nil then
		return lastSpell
	else
		lastSpell = spell.id(self)
	end
end

-- Returns current seconds remaining on cooldown accounting for latency
function spell.cd(self)
	local spellID = spell.id(self)
    if GetSpellCooldown(spellID) == 0 then
		return 0
	else
		local Start ,CD = GetSpellCooldown(spellID)
		local MyCD = Start + CD - GetTime()
		MyCD = MyCD - latency()
		return MyCD
	end
end

function spell.gcd()
	return spell.cd(global)
end

function spell.help(self)
	local spellName = spell.name(self)
    return IsHarmfulSpell(spellName) == nil
end

function spell.harm(self)
	local spellName = spell.name(self)
    return IsHarmfulSpell(spellName) ~= nil
end

function spell.inSpellbook(self)
	return GetSpellBookItemInfo(spell.name(self)) ~= nil
end

function spell.playerSpell(self)
	local spellID = spell.id(self)
	return IsPlayerSpell(tonumber(spellID))
end

function spell.known(self)
	local spellID = spell.id(self)
	return spell.inSpellbook(self) or spell.playerSpell(self) or IsSpellKnown(spellID)
end

function spell.minRange(self)
	return select(5, spell.info(self))
end

function spell.maxRange(self)
	return select(6, spell.info(self))
end

function spell.castable(self)
	local spellID = spell.id(self)
	return select(1, IsUsableSpell(spellID))
end

function spell.casting(thisUnit)
	if meta._G.UnitCastingInfo(thisUnit) ~= nil or meta._G.UnitChannelInfo(thisUnit) ~= nil then
		return true
	end
	return false
end

function spell.canInterrupt(thisUnit)
	if spell.casting(thisUnit) then
		if meta._G.UnitCastingInfo(thisUnit) ~= nil and select(6,meta._G.UnitCastingInfo(thisUnit)) and not select(9,meta._G.UnitCastingInfo(thisUnit)) then --Get spell cast time
			castStartTime = select(5,meta._G.UnitCastingInfo(thisUnit))
			castEndTime = select(6,meta._G.UnitCastingInfo(thisUnit))
			castType = "spellcast"
		elseif meta._G.UnitChannelInfo(thisUnit) ~= nil and select(6,meta._G.UnitChannelInfo(thisUnit)) and not select(8,meta._G.UnitChannelInfo(thisUnit)) then -- Get spell channel time
			castStartTime = select(5,meta._G.UnitChannelInfo(thisUnit))
			castEndTime = select(6,meta._G.UnitChannelInfo(thisUnit))
			castType = "spellchannel"
		else
			castStartTime = 0
			castEndTime = 0
		end
		if castEndTime > 0 and castStartTime > 0 then
			castDuration = (castEndTime - castStartTime)/1000
			castTimeRemain = ((castEndTime/1000) - GetTime())
		else
			castDuration = 0
			castTimeRemain = 0
		end
		if (castType == "spellcast" and (castTimeRemain/castDuration)*100 < 90) or (castType == "spellchannel" and (castTimeRemain/castDuration)*100 < 99) then
			return true
		end
	end
	return false
end

function spell.hasResources(self)
	local spellID = spell.id(self)
	return not select(2, IsUsableSpell(spellID))
end

function spell.usable(self)
    return spell.castable(self) and spell.hasResources(self)
end

function spell.charges(self)
	return select(1,spell.GetSpellCharges(self:id()))
end

function spell.chargesMax(self)
	return select(2,spell.GetSpellCharges(self:id()))
end

function spell.chargesFrac(self)
	local spellID = spell.id(self)
	local charges,maxCharges,start,duration = GetSpellCharges(self:id())
	local endTime = start + duration
	local percentRemaining = 1 - (endTime - GetTime()) / duration
	if maxCharges ~= nil then
		if start <= GetTime() then
			return charges + percentRemaining
		else
			return charges
		end
	end
	return 0
end

function spell.recharge(self)
	local spellID = spell.id(self)
	local charges,maxCharges,start,duration = GetSpellCharges(self:id())
	local chargeEnd = chargeStart + chargeDuration
	if maxCharges ~= nil then
		if charges < maxCharges then
			return chargeEnd - GetTime()
		end
	end
	return 0
end

-- Return Functions
return spell
