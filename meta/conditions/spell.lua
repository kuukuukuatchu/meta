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
    if IsSpellInRange(spell.name(spellID),unit) == nil or IsSpellInRange(spell.name(spellID),unit) == 1 then
        return true
    end
end

function spell.known(spellID)
	if GetSpellBookItemInfo(spell.name(spellID)) ~= nil then
		return true
	end
    if IsPlayerSpell(tonumber(spellID)) == true then
		return true
	end
    -- if hasPerk(spellID) then
    -- then
	-- 	return true
	-- end
end

function spell.minRange(spell)
	return select(5, GetSpellInfo(spell))
end

function spell.maxRange(spellID)
	return select(6, GetSpellInfo(spell))
end

function spell.usable(spellID)
    local castable, notEnoughResource = IsUsableSpell(spellID)
    if castable and not notEnoughResource then
        return true
    end
end

-- Return Functions
return spell
