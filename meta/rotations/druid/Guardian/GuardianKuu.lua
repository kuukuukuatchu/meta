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
        if not buff.exists(buff.travelForm, "player") and #enemies.inRange("player", 10, false, false) == 0 and
            player.level() >= 24 and not buff.exists(buff.prowl, "player") and IsOutdoors() and
            not ((unit.distance("target") < 30 and not unit.swimming()) or
                (unit.distance("target") < 10 and unit.swimming())) then
            -- if br.timer:useTimer("Travel Delay", 1) then
            -- if unit.form() ~= 0 and not cast.last.travelForm() then
            -- unit.cancelForm()
            --     br.addonDebug("Cancel Form [Flying]")
            -- elseif unit.form() == 0 then
            cast.spell(travelForm, "player")
        end
        if not buff.exists(buff.catForm, "player") and #enemies.inRange("player", 10, false, false) == 0 and
            not unit.mounted() and not unit.flying() and unit.distance("target") > 30 and not unit.swimming() then
            -- Cat Form when not swimming or flying or stag and not in combat
            if unit.moving("player") and not buff.exists(buff.travelForm, "player") and
                not buff.exists(buff.soulshape, "player") then
                cast.spell(catForm, "player")
            end
            -- Cat Form - Less Fall Damage
            if (not unit.canFly() or unit.combat() or unit.level() < 24 or not IsOutdoors()) and
                (not unit.swimming() or (not unit.moving() and unit.swimming())) and player.getFallDistance() > 90 then -- falling > ui.value("Fall Timer")
                cast.spell(catForm, "player")
            end
        end
    end

    actionList_Extras()
    if unit.valid('target') then
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
