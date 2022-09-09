-- Required to access other files.


-- Init Unit
local power = { }
power.__index = power

function power.new(powerType)
    local self = setmetatable({}, power)
    self.Power = powerType
    return self
end

function power.amount(self)
    return UnitPower('player',self.Power)
end

function power.max(self)
    return UnitPowerMax('player',self.Power)
end

function power.deficit(self)
	return UnitPowerMax('player',self.Power) - UnitPower('player',self.Power)
end

mana            = power.new(SPELL_POWER_MANA)
rage            = power.new(SPELL_POWER_RAGE)
focus           = power.new(SPELL_POWER_FOCUS)
energy          = power.new(SPELL_POWER_ENERGY)
comboPoints     = power.new(SPELL_POWER_COMBO_POINTS)
runes           = power.new(SPELL_POWER_RUNES)
runicPower      = power.new(SPELL_POWER_RUNIC_POWER)
soulShards      = power.new(SPELL_POWER_SOUL_SHARDS)
lunarPower      = power.new(SPELL_POWER_LUNAR_POWER)
holyPower       = power.new(SPELL_POWER_HOLY_POWER)
altPower        = power.new(SPELL_POWER_ALTERNATE_POWER)
maelstrom       = power.new(SPELL_POWER_MAELSTROM)
chi             = power.new(SPELL_POWER_CHI)
insanity        = power.new(SPELL_POWER_INSANITY)
arcaneCharges   = power.new(SPELL_POWER_ARCANE_CHARGES)
fury            = power.new(SPELL_POWER_FURY)
pain            = power.new(SPELL_POWER_PAIN)


-- Return Functions
return power
