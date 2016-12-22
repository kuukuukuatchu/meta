local function rotation()
--------------------------
--- Vengeance: CuteOne ---
--------------------------

-- Start Attack
    -- actions=auto_attack
    startAttack()

-- Throw Glaive
    if cast.check(throwGlaive) and unit.distance('target') > 5 then
        -- castSpell(throwGlaive)
        cast.throwGlaive()
    end

end

local VengeanceCuteOne = {
    profileID = 581,
    profileName = "CuteOne",
    rotation = rotation
}

-- Return Profile
return VengeanceCuteOne
