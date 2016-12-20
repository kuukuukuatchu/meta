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

function spell.help(spellID)
	local spellName = GetSpellInfo(spellID)
    return IsHelpfulSpell(spellName) ~= nil
end

function spell.harm(spellID)
	local spellName = GetSpellInfo(spellID)
    return IsHarmfulSpell(spellName) ~= nil
end

function spell.inRange(spellID,unit)
    local spellName = GetSpellInfo(spellID)
    if IsSpellInRange(spellName,unit) == nil or IsSpellInRange(spellName,unit) == 1 then
        return true
    end
end

function spell.known(spellID)
    local spellName = GetSpellInfo(spellID)
	if GetSpellBookItemInfo(spellName) ~= nil then
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

function spell.usable(spellID)
    local castable, notEnoughResource = IsUsableSpell(spellID)
    if castable and not notEnoughResource then
        return true
    end
end

-- Return Functions
return spell
