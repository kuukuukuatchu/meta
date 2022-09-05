local function rotation()

    ------------------------
    --- Guardian: Kuukuu ---
    ------------------------

    -- Action Lists
    local function actionList_Extras()
        if unit.exists("target") and unit.canAttack("target") and not unit.dead("target") and
            not buff.exists(buff.bearForm, "player") and
            ((unit.distance("target") < 30 and not unit.swimming()) or
                (unit.distance("target") < 10 and unit.swimming())) then
            --     -- unit.cancelForm()
            cast.spell(bearForm, "player")
            --     br.addonDebug("Casting Bear Form [Target In 20yrds]")
            --     return true
        end
    end

    if unit.valid('target') then
        actionList_Extras()
        -- Auto Attack
        -- auto_attack
        if not IsCurrentSpell(6603) and unit.distance("target") < 5 then
            startAttack()
        end

    end
end

local GuardianKuu = {
    profileID = 104,
    profileName = "GuardianKuu",
    rotation = rotation
}

-- Return Profile
return GuardianKuu
