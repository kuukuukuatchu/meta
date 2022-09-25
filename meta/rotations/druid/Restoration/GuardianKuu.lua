local meta = ...

local function onSelect()
    local window = meta.windows.profile
    meta.checkDirectories()

    local section
    local page
    ----------------------
    --- General Options---
    ----------------------
    page = window.createPage("Settings")
    section = meta.ui:createSection(page, "General - Version 1.04")
    meta.ui:createDropdownWithout(section, "Cat Key", meta.dropOptions.Toggle, 6, "Set a key for cat")
    meta.ui:createDropdownWithout(section, "Travel Key", meta.dropOptions.Toggle, 6, "Set a key for travel")
    meta.ui:createDropdown(section, "Big Hit Oh Shit!", meta.dropOptions.Toggle, 6,
        "Hold down key to use defensives for large hits")
    meta.ui:createCheckbox(section, "Auto Engage On Target", "Cast Moonfire on target OOC to engage in combat")
    meta.ui:createCheckbox(section, "Auto Stealth in Cat Form", 1)
    meta.ui:createCheckbox(section, "Auto Dash in Cat Form", 1)
    -- Wild Charge
    meta.ui:createCheckbox(section, "Wild Charge", "Enables/Disables Auto Charge usage.")
    -- Max Moonfire Targets
    meta.ui:createSpinnerWithout(section, "Max Moonfire Targets", 3, 1, 10, 1,
        "|cff0070deSet to maximum number of targets to dot with Moonfire. Min: 1 / Max: 10 / Interval: 1")
    section:UpdateHeight()
    ----------------------
    ---    Covenants   ---
    ----------------------
    section = meta.ui:createSection(page, "Covenants")
    meta.ui:createCheckbox(section, "Use Covenant")
    section:UpdateHeight()

    -----------------------
    --- Cooldown Options---
    -----------------------
    section = meta.ui:createSection(page, "Cooldowns")
    meta.ui:createCheckbox(section, "Racial")
    -- Trinkets
    meta.ui:createDropdownWithout(section, "Trinket Type", {"DPS", "Tank"}, 1,
        "|cffFFFFFFWhat type of trinkets are being used.")
    meta.ui:createDropdownWithout(section, "Trinket Use",
        {"|cff00FF00Everything", "|cffFFFF00Cooldowns", "|cffFF0000Never,"}, 1, "|cffFFFFFFWhen to use trinkets.")
    meta.ui:createSpinner(section, "Trinket 1", 70, 0, 100, 5, "(Tank Trinkets Only) Health Percent to Cast At")
    meta.ui:createSpinner(section, "Trinket 2", 70, 0, 100, 5, "(Tank Trinkets Only) Health Percent to Cast At")
    section:UpdateHeight()
    -- Radar
    section = meta.ui:createSection(page, "Radar")
    meta.ui:createCheckbox(section, "All - Root the thing")
    meta.ui:createCheckbox(section, "FH - Root grenadier")
    meta.ui:createCheckbox(section, "AD - Root Spirit of Gold")
    meta.ui:createCheckbox(section, "KR - Root Minions of Zul")
    meta.ui:createCheckbox(section, "KR - Animated gold")
    section:UpdateHeight()
    ------------------------
    --- Defensive Options---
    ------------------------
    section = meta.ui:createSection(page, "Defensive")
    meta.ui:createSpinner(section, "Healthstone/Potion", 60, 0, 100, 5, "Health Percent to Cast At")
    -- Survival Instincts
    meta.ui:createSpinner(section, "Survival Instincts", 40, 0, 100, 5, "Health Percent to Cast At")
    -- Rage Dump
    meta.ui:createSpinnerWithout(section, "Rage Dump Amount", 40, 0, 100, 5, "Rage Deficit to use Ironfur/Maul")
    -- Ironfur Stacks
    meta.ui:createSpinner(section, "Ironfur", 0, 0, 10, 1,
        "Set max stacks of ironfur before dumping rage into maul instead (0 for no limit)")
    -- Ironfur
    meta.ui:createSpinner(section, "Ironfur (No Aggro)", 85, 0, 100, 5,
        "Use Ironfur on Adds/Bosses you can't aggro such as Carapace of N'Zoth if below %hp")
    -- Incarnation/Berserk
    meta.ui:createSpinner(section, "Incarnation/Berserk", 50, 0, 100, 5, "Use Incarnation/Berserk when below %hp")
    -- Barkskin
    meta.ui:createSpinner(section, "Barkskin", 50, 0, 100, 5, "Health Percentage to use at.")
    -- Renewal
    meta.ui:createSpinner(section, "Renewal", 50, 0, 100, 5, "Health Percentage to use at.")
    -- Frenzied Regen
    meta.ui:createCheckbox(section, "Frenzied Regeneration", "Enable FR")
    meta.ui:createSpinnerWithout(section, "FR - HP Interval (2 Charge)", 65, 0, 100, 5,
        "Health Interval to use at with 2 charges.")
    meta.ui:createSpinnerWithout(section, "FR - HP Interval (1 Charge)", 40, 0, 100, 5,
        "Health Interval to use at with 1 charge.")
    -- Swiftmend
    meta.ui:createSpinner(section, "OOC Swiftmend", 70, 10, 90, 5, "Will use Swiftmend Out of Combat.")
    -- Rejuvenation
    meta.ui:createSpinner(section, "OOC Rejuvenation", 70, 10, 90, 5, "Minimum HP to cast Out of Combat.")
    -- Regrowth
    meta.ui:createSpinner(section, "OOC Regrowth", 70, 10, 90, 5, "Minimum HP to cast Out of Combat.")
    -- Wild Growth
    meta.ui:createSpinner(section, "OOC Wild Growth", 70, 10, 90, 5, "Mninimum HP to cast Out of Combat.")
    meta.ui:createSpinnerWithout(section, "Friendly Targets", 4, 1, 5, 1,
        "Number of friendly targets below set HP to cast Wild Growth.")
    -- Soothe
    meta.ui:createCheckbox(section, "Auto Soothe")
    -- Revive
    meta.ui:createDropdown(section, "Revive",
        {"|cffFFFF00Selected Target", "|cffFF0000Mouseover Target", "|cffFFBB00Auto"}, 1, "|ccfFFFFFFTarget to Cast On")
    -- Rebirth
    meta.ui:createDropdown(section, "Rebirth",
        {"|cffFFFFFFTarget", "|cffFFFFFFMouseover", "|cffFFFFFFTank", "|cffFFFFFFHealer", "|cffFFFFFFHealer/Tank",
         "|cffFFFFFFAny"}, 1, "|cffFFFFFFTarget to cast on")
    -- Remove Corruption
    meta.ui:createCheckbox(section, "Remove Corruption")
    meta.ui:createDropdownWithout(section, "Remove Corruption - Target", {"Player", "Target", "Mouseover"}, 1,
        "Target to cast on")
    section:UpdateHeight()
    ------------------------
    --- Interrupt Options---
    ------------------------
    section = meta.ui:createSection(page, "Interrupts")
    meta.ui:createCheckbox(section, "Skull Bash")
    meta.ui:createCheckbox(section, "Mighty Bash")
    meta.ui:createCheckbox(section, "Incapacitating Roar")
    meta.ui:createCheckbox(section, "Incapacitating Roar Logic (M+)")
    meta.ui:createSpinner(section, "Interrupt At", 0, 0, 95, 5, "Cast Percent to Cast At")
    section:UpdateHeight()

    for _, page in ipairs(window.children) do
        if page.index == window.current_page then
            page:Show()
        else
            page:Hide()
        end
    end

    window:Show()
    window.initializing = false
end

local function onDeselect()
    window.dropdown:RemoveListItem("Settings")
end

local function onLoad()

end

local function onUnload()
end

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
            --     meta.addonDebug("Casting Bear Form [Target In 20yrds]")
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
        if meta.isChecked("Revive") and not unit.combat() and not unit.moving("player") and
            meta.timer:useTimer("Resurrect", 4) then
            if meta.getValue("Revive") == 1 and UnitIsPlayer("target") and GetUnitIsDeadOrGhost("target") and
                GetUnitIsFriend("target", "player") then
                cast.spell(revive, "target")
            end
            if meta.getValue("Revive") == 2 and UnitIsPlayer("mouseover") and GetUnitIsDeadOrGhost("mouseover") and
                GetUnitIsFriend("mouseover", "player") then
                cast.spell(revive, "mouseover")
            end
            if meta.getValue("Revive") == 3 then
                local unit = meta.getUnit(friends, function(testUnit)
                    return UnitIsPlayer(testUnit) and UnitIsDeadOrGhost(testUnit)
                end)
                if unit then
                    cast.spell(revive, unit)
                end
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
    profileID = 105,
    profileName = "RestoKuu",
    rotation = rotation,
    onLoad = onLoad,
    onSelect = onSelect
}

-- Return Profile
return GuardianKuu
