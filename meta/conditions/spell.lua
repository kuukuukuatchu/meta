-- Required to access other files.
local meta 		= ...
-- local base 		= require('conditions.base')
-- local spellList = require('conditions.spellList')

-- Init Spell
local spell = { }
-- spell.__index = spell

-- function spell.new(spellID)
--     local self = setmetatable({}, spell)
--         self.Spell = spellID
--     return self
-- end

-- function spell.id(self)
--     local spellID = self.Spell
-- 	return spellID
-- end

-- function spell.name(self)
--     local spellID = self.Spell
-- 	return GetSpellInfo(spellID)
-- end

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
    if spell:maxRange() > 0 then
        return 'player' -- Dynamic Assign Friendly in Range
    else
        return 'player' -- Default to 'player'
    end
end

function spell.last(spellID)
	if not lastSpell then lastSpell = 0 end
	if not spellID then
		return lastSpell
	else
		lastSpell = spellID
	end
end

-- Returns current seconds remaining on cooldown accounting for latency
function spell.cd(spellID)
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
	return spell.cd(61304)
end

function spell.name(spellID)
	local spellName = GetSpellInfo(spellID)
	return spellName
end

function spell.help(spellID)
	local spellName = spell.name(spellID)
    return IsHelpfulSpell(spellName) ~= nil
end

function spell.harm(spellID)
	local spellName = spell.name(spellID)
    return IsHarmfulSpell(spellName) ~= nil
end

function spell.id(spellName)
	return select(7,GetSpellInfo(spellName))
end

function spell.inSpellbook(spellID)
	return GetSpellBookItemInfo(spell.name(spellID)) ~= nil
end

function spell.playerSpell(spellID)
	return IsPlayerSpell(tonumber(spellID))
end

function spell.known(spellID)
	return spell.inSpellbook(spellID) or spell.playerSpell(spellID)
end

function spell.minRange(spellID)
	return select(5, GetSpellInfo(spellID))
end

function spell.maxRange(spellID)
	return select(6, GetSpellInfo(spellID))
end

function spell.castable(spellID)
	return select(1, IsUsableSpell(spellID))
end

function spell.hasResources(spellID)
	return not select(2, IsUsableSpell(spellID))
end

function spell.usable(spellID)
    return spell.castable(spellID) and spell.hasResources(spellID)
end

function spell.charges(spellID)
	return select(1,GetSpellCharges(spellID))
end

function spell.chargesFrac(spellID,chargeMax)
	local charges,maxCharges,start,duration = GetSpellCharges(spellID)
	if chargeMax == nil then chargeMax = false end
	if maxCharges ~= nil then
		if chargeMax then 
			return maxCharges 
		else
			if start <= GetTime() then
				local endTime = start + duration
				local percentRemaining = 1 - (endTime - GetTime()) / duration
				return charges + percentRemaining
			else
				return charges
			end
		end
	end
	return 0
end

function spell.recharge(spellID)
	local charges,maxCharges,chargeStart,chargeDuration = GetSpellCharges(spellID)
	if charges then
		if charges < maxCharges then
			chargeEnd = chargeStart + chargeDuration
			return chargeEnd - GetTime()
		end
		return 0
	end
end

-- Return Functions
return spell
