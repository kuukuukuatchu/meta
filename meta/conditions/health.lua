-- Required to access other files.


-- Init Health
local health = { }

-------------------------------------
--- Health Related Functions Here ---
-------------------------------------

-- Return Unit Health Amount
function health.amount(unit)
    return meta._G.UnitHealth(unit)
end

-- Return Unit Health Max
function health.max(unit)
    return meta._G.UnitHealthMax(unit)
end

-- Return Unit Health Percent
function health.percent(unit)
    return (meta._G.UnitHealth(unit) / meta._G.UnitHealthMax(unit)) * 100
end

-- Return Unit Health Deficit (Amount)
function health.deficitAmount(unit)
    return meta._G.UnitHealthMax(unit) - meta._G.UnitHealth(unit)
end

-- Return Unit Health Deficit (Percent)
function health.deficitPercent(unit)
    return (meta._G.UnitHealthMax(unit) / meta._G.UnitHealth(unit)) * 100
end

-- Return Functions
return health
