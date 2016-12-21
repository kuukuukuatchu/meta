-- Required to access other files.
local meta = ...

-- Init Cast
local spell = { }

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

function spell.name(spellID)
	return select(1, GetSpellInfo(spellID))
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

function spell.inRange(spellID,unit)
    return IsSpellInRange(spell.name(spellID),unit) == nil or IsSpellInRange(spell.name(spellID),unit) == 1
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

function spell.minRange(spell)
	return select(5, GetSpellInfo(spell))
end

function spell.maxRange(spellID)
	return select(6, GetSpellInfo(spell))
end

function spell.castable(spellID)
	return select(1, IsUsableSpell(spellID))
end

function spell.hasResouces(spellID)
	return not select(2, IsUsableSpell(spellID))
end

function spell.usable(spellID)
    return spell.castable(spellID) and spell.hasREsources(spellID)
end

-- Return Functions
return spell
