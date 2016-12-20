-- Required to access other files.
local meta = ...

-- Init Health
local health = { }

-------------------------------------
--- Health Related Functions Here ---
-------------------------------------

-- Return Unit Health Amount
function health.amount(unit)
    return UnitHealth(unit)
end

-- Return Unit Health Max
function health.max(unit)
    return UnitHealthMax(unit)
end

-- Return Unit Health Percent
function health.percent(unit)
    return (UnitHealth(unit) / UnitHealthMax(unit)) * 100
end

-- Return Unit Health Deficit (Amount)
function health.deficitAmount(unit)
    return UnitHealthMax(unit) - UnitHealth(unit)
end

-- Return Unit Health Deficit (Percent)
function health.deficitPercent(unit)
    return (UnitHealthMax(unit) / UnitHealth(unit)) * 100
end

-- Return Functions
return health
