local function rotation()
--------------------------
--- Vengeance: CuteOne ---
--------------------------
-- Start Attack
    -- actions=auto_attack
    startAttack()
-- Soul Carver
    if cast.check(soulCarver) then
        cast.soulCarver()
    end
-- Fiery Brand
    -- actions+=/fiery_brand,if=buff.demon_spikes.down&buff.metamorphosis.down
    if cast.check(fieryBrand) and not buff.exists('player',fieryBrand) and not buff.exists('player',metamorphosis) then
        cast.fieryBrand()
    end
-- Demon Spikes
    -- actions+=/demon_spikes,if=charges=2|buff.demon_spikes.down&!dot.fiery_brand.ticking&buff.metamorphosis.down
    if cast.check(demonSpikes) and (spell.charges(demonSpikes) == 2 or not buff.exists('player',demonSpikes)) and not debuff.exists('target',fieryBrand) and not buff.exists('player',metamorphosis) then
        cast.demonSpikes()
    end
-- Infernal Strike
    -- actions+=/infernal_strike,if=!sigil_placed&!in_flight&remains-travel_time-delay<0.3*duration&artifact.fiery_demise.enabled&dot.fiery_brand.ticking
    -- actions+=/infernal_strike,if=!sigil_placed&!in_flight&remains-travel_time-delay<0.3*duration&(!artifact.fiery_demise.enabled|(max_charges-charges_fractional)*recharge_time<cooldown.fiery_brand.remains+5)&(cooldown.sigil_of_flame.remains>7|charges=2)
    if cast.check(infernalStrike) and unit.distance('target') < 5 and spell.charges(infernalStrike) > 1 then
        cast.infernalStrike()
    end
-- Spirit Bomb
    -- actions+=/spirit_bomb,if=debuff.frailty.down
    if cast.check(spiritBomb) and not debuff.exists('target',frailty) then
        cast.spiritBomb()
    end
-- Immolation Aura
    -- actions+=/immolation_aura,if=pain<=80
    if cast.check(immolationAura) and power.amount(pain) <= 80 and unit.distance('target') < 8 then
        cast.immolationAura()
    end
-- Felblade
    -- actions+=/felblade,if=pain<=70
    if cast.check(felblade) and power.amount(pain) <= 70 then
        cast.felblade()
    end
-- Soul Barrier
    -- actions+=/soul_barrier
    if cast.check(soulBarrier) and health.percent('player') < 50 then
        cast.soulBarrier()
    end
-- Soul Cleave
    -- actions+=/soul_cleave,if=soul_fragments=5
    if cast.check(soulCleave) and buff.stack('player',soulFragments) == 5 then
        cast.soulCleave()
    end
-- Metamorphosis
    -- actions+=/metamorphosis,if=buff.demon_spikes.down&!dot.fiery_brand.ticking&buff.metamorphosis.down&incoming_damage_5s>health.max*0.70
    if cast.check(metamorphosis) and not buff.exists('target',demonSpikes)
        and not debuff.exists('target',fieryBrand) and health.percent('player') < 30
    then
        cast.metamorphosis()
    end
-- Fel Devastation
    -- actions+=/fel_devastation,if=incoming_damage_5s>health.max*0.70
    if cast.check(felDevastation) and health.percent('player') < 40 then
        cast.felDevastation()
    end
-- Soul Cleave
    -- actions+=/soul_cleave,if=incoming_damage_5s>=health.max*0.70
    if cast.check(soulCarver) and health.percent('player') < 70 then
        cast.soulCarver()
    end
-- Fel Eruption
    -- actions+=/fel_eruption
    if cast.check(felEruption) then
        cast.felEruption()
    end
-- Sigil of Flame
    -- actions+=/sigil_of_flame,if=remains-delay<=0.3*duration
    if cast.check(sigilOfFlame) and not unit.moving('target') then
        cast.sigilOfFlame()
    end
-- Fracture
    -- actions+=/fracture,if=pain>=80&soul_fragments<4&incoming_damage_4s<=health.max*0.20
    if cast.check(fracture) and power.amount(pain) >= 80 and buff.stack('player',soulFragments) < 4 then
        cast.fracture()
    end
-- Soul Cleave
    -- actions+=/soul_cleave,if=pain>=80
    if cast.check(soulCleave) and power.amount(pain) >= 80 then
        cast.soulCleave()
    end
-- Shear
    -- actions+=/shear
    if cast.check(shear) then
        cast.shear()
    end
-- Throw Glaive
    if cast.check(throwGlaive) and unit.distance('target') > 5 then
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
