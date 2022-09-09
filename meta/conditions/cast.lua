-- Required to access other files.
local meta  = ...
local unit  = require('conditions.unit')
local spell = require('conditions.spell')
local spellList = require('lists.spellList')

-- Init Buff
local cast = { }
cast.__index = cast

function cast.new(spellID)
    local self = setmetatable({}, cast)
        self.Cast = spellID
    return self
end

for k, v in pairs(castable) do
    cast[k] = cast.new(v)
end

-----------------------------------
--- Cast Related Functions Here ---
-----------------------------------

function cast.spell(self, unitCast)
    if self ~= nil then
        local unitCast = unitCast
        -- print('|cffa330c9 [meta] |cffFFFF00 Casting: |r'..spell.name(self)..'|cffFFFF00 with Id: |r'..spell.id(self)..'|cffFFFF00 at: |r'..unitCast)
        -- print('Casting '..spell.name(v)..' with Id: '..v..' at: '..unitCast)
        meta._G.CastSpellByName(spell.name(self),unitCast)
        spell.last(self)
    end
end

function cast.ground(self, x, y, z)
    if self ~= nil then
        cast.spell(self)
        meta._G.ClickPosition(x,y,z)
    end
end

function cast.on(self, unitCast)
    if self ~= nil then
        local x, y, z = unit.position(unitCast)
        cast.ground(self, x,y,z)
    end
end

-- function cast.dead(spellCast,unitCast)
--     if unit.friend(unitCast) and unit.dead(unitCast) then
--         cast.spell(spellCast,unitCast)
--     end
-- end
--
-- function cast.enemy(spellCast,unitCast)
--     if unit.enemy(unitCast) and not unit.dead(unitCast) then
--         cast.spell(spellCast,unitCast)
--     end
-- end
--
-- function cast.friend(spellCast,unitCast)
--     if unit.friend(unitCast) and not unit.enemy(unitCast) and not unit.dead(unitCast) then
--         cast.spell(spellCast,unitCast)
--     end
-- end
--
-- function cast.best(spellCast)
--     -- TODO: Find best location to cast AoE for spells effective range for given minimal Units
-- end

function cast.check(self,unitCast)
    local unitCast = unitCast or unit.getBest(self)
    return spell.usable(self) and spell.cd(self) == 0 --[[and spell.known(spellCast)]] and unit.inRange(self,unitCast) and unit.sight(unitCast) and spell.gcd() == 0 and unit.facing('player',unitCast)
end

-- Return Functions
return cast
