local meta = ...

-- This creates the normal BadRotations Configuration Window
local window = meta.ui:createWindow("config", 275, 400, "Configuration")
meta.windows.config = window
-- window.rotations:AddListItem("None")
-- window.rotations:SetValue(1)
-- window.rotations:Hide()
window.rotations:ReleaseTextures()


local section
local page
-- General
page = window.createPage("General")
section = meta.ui:createSection(page, "")
meta.ui:createCheckbox(section, "Auto Delay", "Check to dynamically change update rate based on current FPS.")
meta.ui:createSpinnerWithout(section, "Bot Update Rate", 0.1, 0.0, 1.0, 0.01,
    "Adjust the update rate of Bot operations. Increase to improve FPS but may cause reaction delays. Will be ignored if Auto Delay is checked. Default: 0.1")
meta.rotationLog = meta.ui:createCheckbox(section, "Rotation Log", "Display Rotation Log.")
meta.ui:createDropdown(section, "Addon Debug Messages", {"System Only", "Profile Only", "All"}, 3,
    "Check this to display developer debug messages.")
meta.targetval = meta.ui:createCheckbox(section, "Target Validation Debug",
    "Check this to display current target's validation.")
meta.ui:createCheckbox(section, "Display Failcasts", "Dispaly Failcasts in Debug.")
meta.ui:createCheckbox(section, "Queue Casting", "Allow Queue Casting on some profiles.")
meta.ui:createSpinner(section, "Auto Loot", 0.5, 0.1, 3, 0.1, "Sets Autloot on/off.", "Sets a delay for Auto Loot.")
meta.ui:createCheckbox(section, "Auto-Sell/Repair",
    "Automatically sells grays and repairs when you open a repair vendor.")
meta.ui:createCheckbox(section, "Accept Queues", "Automatically accept LFD, LFR, .. queue.")
meta.ui:createCheckbox(section, "Overlay Messages", "Check to enable chat overlay messages.")
meta.ui:createSpinner(section, "Notify Not Unlocked", 10, 5, 60, 5,
    "Will alert you at the set interval when Unlocker is not attached.")
meta.ui:createCheckbox(section, "Reset Options",
    "|cffFF0000 WARNING!|cffFFFFFF Checking this will reset setting on reload!")
meta.ui:createCheckbox(section, "Reset Saved Profiles",
    "|cffFF0000 WARNING!|cffFFFFFF Checking this will reset saved profiles on reload!")
meta.ui:createCheckbox(section, "Auto Check for Updates",
    "EWT only. This uses the Git master head sha for comparison. |cffFF0000Experimental!")
meta.ui:createCheckbox(section, "Dev Mode",
    "|cffFF0000WARNING! This will expose the meta table to global for testing purposes.  Do not use unless you know what you're doing.")
section:UpdateHeight()



-- Enemies Engine
page = window.createPage("Enemies Engine")
section = meta.ui:createSection(page, "")

meta.ui:createDropdown(section, "Dynamic Targetting", {"Only In Combat", "Default", "Lite"}, 2,
    "Check this to allow dynamic targetting. If unchecked, profile will only attack current target.")
meta.ui:createCheckbox(section, "Include Range",
    "Checking this will pick a new target if current target is out of range. (Only valid on Lite mode)")
meta.ui:createCheckbox(section, "Target Dynamic Target", "Check this will target the current dynamic target.")
meta.ui:createCheckbox(section, "Tank Aggro = Player Aggro",
    "If checked, when tank gets aggro, player will go into combat")
meta.ui:createCheckbox(section, "Hostiles Only", "Checking this will target only units hostile to you.")
meta.ui:createCheckbox(section, "Attack MC Targets",
    "Check this to allow addon to attack charmed/mind controlled targets.")
meta.ui:createCheckbox(section, "Enhanced Time to Die", "A more precise time to die check, but can be ressource heavy.")
meta.ui:createCheckbox(section, "Prioritize Totems", "Check this to target totems first.")
meta.ui:createCheckbox(section, "Darter Targeter", "Auto target Darters on Hivemind")
meta.ui:createDropdown(section, "Wise Target",
    {"Highest %", "Lowest %", "abs Highest", "abs Lowest", "Nearest", "Furthest"}, 1,
    "|cffFFDD11Check if you want to use Wise Targetting, if unchecked there will be no priorisation from hp/range.")
meta.ui:createDropdownWithout(section, "Wise Target Frequency", {"Default", "Only on Target Death"}, 1,
    "Sets how often Wise Target checks for a better target.")
meta.ui:createCheckbox(section, "Forced Burn", "Check to allow forced Burn on specific whitelisted units.")
meta.ui:createCheckbox(section, "Avoid Shields", "Check to avoid attacking shielded units.")
meta.ui:createCheckbox(section, "Tank Threat", "Check add more priority to targets you lost aggro on(tank only).")
meta.ui:createCheckbox(section, "Safe Damage Check", "Check to prevent damage to targets you dont want to attack.")
meta.ui:createCheckbox(section, "Ignore Big Slime on PF", "Check to not attack Slimy Smorgasbord")
meta.ui:createSpinnerWithout(section, "Bursting Stack Limit", 2, 1, 10, 1,
    "**Requires Safe Damage Check** - Set to desired limit, will still dps targets but not kill until below limit.")
meta.ui:createCheckbox(section, "Don't metaeak CCs", "Check to prevent damage to targets that are CC.")
meta.ui:createCheckbox(section, "Skull First", "Check to enable focus skull dynamically.")
meta.ui:createCheckbox(section, "Boss Detection Only In Instance",
    "Check to only detect Dungeon/Raid Bosses, not Open World")
meta.ui:createCheckbox(section, "Dispel Only Whitelist", "Check to only dispel debuffs listed on the whitelist.")
meta.ui:createCheckbox(section, "Purge Only Whitelist", "Check to only purge buffs listed on the whitelist.")
meta.ui:createCheckbox(section, "Interrupt Only Whitelist", "Check to only interrupt casts listed on the whitelist.")
meta.ui:createDropdownWithout(section, "Interrupt Target", {"All", "Target", "Focus", "Marked"}, 1,
    "Interrupt target settings.")
meta.ui:createDropdownWithout(section, "Interrupt Mark",
    {"|cffffff00Star", "|cffffa500Circle", "|cff800080Diamond", "|cff008000Triangle", "|cffffffffMoon",
     "|cff0000ffSquare", "|cffff0000Cross", "|cffffffffSkull"}, 8,
    "Mark to interrupt if Marked is selected in Interrupt Target.")
meta.ui:createCheckbox(section, "Only Known Units", "Check this to interrupt only on known units using whitelist.")
-- meta.ui:createCheckbox(section, "Crowd Control", "Check to use crowd controls on select units/buffs.")
meta.ui:createCheckbox(section, "Enrages Handler", "Check this to allow Enrages Handler.")
section:UpdateHeight()

-- Healing Engine
page = window.createPage("Healing Engine")
section = meta.ui:createSection(page, "")
meta.ui:createCheckbox(section, "HE Active", "Uncheck to disable Healing Engine.\nCan improves FPS if you dont rely on Healing Engine.")
meta.ui:createCheckbox(section, "Handle Sorting in Healing Engine", "Uncheck this to handle sorting at the profile level if dev has made special sorting")
meta.ui:createDropdownWithout(section, "Sort Health By", { "Percent HP","Absolute HP"}, 1, "Sort HP by Percent or Absolute")
meta.ui:createCheckbox(section, "Heal Pets", "Check this to Heal Pets.")
meta.ui:createDropdown(section, "Special Heal", {"Target", "T/M", "T/M/F", "T/F"}, 1, "Check this to Heal Special Whitelisted Units.", "Choose who you want to Heal.")
meta.ui:createCheckbox(section, "Prioritize Special Targets", "Prioritize Special targets(mouseover/target/focus).")
meta.ui:createSpinner(
    section,
    "Blacklist",
    95,
    nil,
    nil,
    nil,
    "|cffFFBB00How much |cffFF0000%HP|cffFFBB00 do we want to add to |cffFFDD00Blacklisted |cffFFBB00units. Use /Blacklist while mouse-overing someone to add it to the black list."
)
meta.ui:createSpinner(section, "Prioritize Tank", 5, 0, 100, 1, "Check this to prioritize tanks below value set")
--meta.ui:createSpinner(section, "Prioritize Debuff", 3, 0, 100, 1, "Check this to give debuffed targets more priority")
meta.ui:createCheckbox(
    section,
    "Ignore Absorbs",
    "Check this if you want to ignore absorb shields. If checked, it will add shieldBuffValue/4 to hp. May end up as overheals, disable to save mana."
)
meta.ui:createCheckbox(section, "Incoming Heals", "If checked, it will add incoming health from other healers to hp. Check this if you want to prevent overhealing units.")
meta.ui:createSpinner(section, "Overhealing Cancel", 95, nil, nil, nil, "Set Desired Threshold at which you want to prevent your own casts. CURRENTLY NOT IMPLEMENTED!")
meta.healingDebug = meta.ui:createCheckbox(section, "Healing Debug", "Check to display Healing Engine Debug.")
--meta.ui:createSpinner(section, "Debug Refresh", 500, 0, 1000, 25, "Set desired Healing Engine Debug Table refresh for rate in ms.")
meta.ui:createSpinner(
    section,
    "Dispel delay",
    1.5,
    0.5,
    5,
    0.1,
    "Set desired dispel delay in seconds of debuff duration.\n|cffFF0000Will randomise around the value you set."
)
meta.ui:createCheckbox(section, "Healer Line of Sight Indicator", "Draws a line to healers. Green In Line of Sight / Red Not In Line of Sight")
section:UpdateHeight()

-- Other Features
page = window.createPage("Other Features")
section = meta.ui:createSection(page, "")
--meta.ui:createCheckbox(section, "PokeRotation")
meta.ui:createCheckbox(section, "Bypass Vehicle Check")
meta.ui:createSpinner(section, "Profession Helper", 0.5, 0, 1, 0.1, "Check to enable Professions Helper.", "Set Desired Recast Delay.")
meta.ui:createDropdown(section, "Prospect Ores", {"SL", "BFA", "Legion", "WoD", "MoP", "Cata", "All"}, 1, "Prospect Desired Ores. Profession Helper must be checked.")
meta.ui:createDropdown(section, "Mill Herbs", {"SL", "BFA", "Legion", "WoD", "MoP", "Cata", "All"}, 1, "Mill Desired Herbs. Profession Helper must be checked.")
meta.ui:createCheckbox(section, "Disenchant", "Disenchant Cata blues/greens. Profession Helper must be checked.")
meta.ui:createCheckbox(section, "Leather Scraps", "Combine leather scraps. Profession Helper must be checked.")
meta.ui:createCheckbox(section, "Lockboxes", "Unlock Lockboxes. Profession Helper must be checked.")
meta.ui:createDropdown(section, "Fishing", {"Enabled", "Disabled"}, 2, "Turn EWT Fishing On/Off")
meta.ui:createCheckbox(section, "Fish Oil", "Turn Fish into Aromatic Fish Oil. Profession Helper must be checked.")
meta.ui:createDropdown(
    section,
    "Bait",
    {
        "Lost Sole Bait",
        "Silvergill Pike Bait",
        "Pocked Bonefish Bait",
        "Iridescent Amberjack Bait",
        "Spinefin Piranha Bait",
        "Elysian Thade Bait"
    },
    1,
    "Using the bait."
)
meta.ui:createCheckbox(section, "Debug Timers", "Useless to users, for Devs.")
meta.ui:createCheckbox(section, "Cache Debuffs", "Experimental feature still in testing")
meta.ui:createCheckbox(section, "Unit ID In Tooltip", "Show/Hide Unit IDs in Tooltip")
meta.ui:createCheckbox(section, "Show Drawings", "Show drawings on screen using Lib Draw")
section:UpdateHeight()

section = meta.ui:createSection(page, "Dungeon Helpers")
meta.ui:createCheckbox(section, "Quaking Helper", "Auto cancel channeling and block casts during mythic+ affix quaking")
meta.ui:createSpinnerWithout(section, "Catcher/Snatcher Delay", 0.5, 0, 1, 0.1)
meta.ui:createCheckbox(section, "Freehold - Pig Catcher", "Catch pig in Ring of Booty")
meta.ui:createCheckbox(section, "De Other Side - Bomb Snatcher", "Catch bomb in The Manastorms fight")
section:UpdateHeight()

-- Tracker Engine
page = window.createPage("Tracker Settings")
section = meta.ui:createSection(page, "")
meta.ui:createCheckbox(section, "Enable Tracker")
meta.ui:createCheckbox(section, "Draw Lines to Tracked Objects")
meta.ui:createCheckbox(section, "Auto Interact with Any Tracked Object")
meta.ui:createCheckbox(section, "Rare Tracker", "Track All Rares In Range")
meta.ui:createDropdown(section, "Quest Tracker", {"Units", "Objects", "Both"}, 3, "Track Quest Units/Objects")
meta.ui:createScrollingEditBox(section, "Custom Tracker", nil, "Type custom search, Can Seperate items by comma", 300, 40)
section:UpdateHeight()

local function pairsByKeys(t, f)
    local a = {}
    for n in pairs(t) do
        table.insert(a, n)
    end
    table.sort(a, f)
    local i = 0 -- iterator variable
    local iter = function()
        -- iterator function
        i = i + 1
        if a[i] == nil then
            return nil
        else
            return a[i], t[a[i]]
        end
    end
    return iter
end
-- Smart Queue
page = window.createPage("Smart Queue")
section = meta.ui:createSection(page, "")
meta.ui:createSpinner(section, "Smart Queue", 2, 0.5, 3, 0.1, "Auto cast spells you press (Only EWT support)", "Seconds to attempt cast")
if meta.player ~= nil and meta.player.spell ~= nil and meta.player.spell.abilities ~= nil then
    for _, v in pairsByKeys(meta.player.spell.abilities) do
        local spellName = GetSpellInfo(v)
        if v ~= 61304 and spellName ~= nil then
            meta.ui:createDropdown(
                section,
                spellName .. " (Queue)",
                {"Normal", "Cursor", "Cursor (No Cast)", "Mouseover"},
                1,
                "Active Queueing Of " .. spellName .. " (ID: " .. v .. ")",
                "Select cast mode"
            )
        end
    end
end
section:UpdateHeight()

page = window.createPage("Healing Options")
section = meta.ui:createSection(page, "")
meta.ui:createCheckbox(section, "Ignore Range Check", "Will ignore any range checks for dispels")
meta.ui:createCheckbox(section, "Ignore Stack Count", "Will ignore any stack checks for dispels")
meta.ui:createSpinnerWithout(section, "Bwonsamdi's Wrath HP", 30, 1, 100, 5, "Set HP to decurse Bwonsamdi's Wrath (Mythic Conclave)")
meta.ui:createSpinnerWithout(section, "Reaping", 20, 1, 100, 5, "Set how many stacks of reaping needed to dispel.")
meta.ui:createSpinnerWithout(section, "Promise of Power", 8, 1, 10, 1, "Set how many stacks of promise of power needed to dispel.")
meta.ui:createSpinner(section, "Toxic metaand", 10, 1, 20, 1, "Set how many stacks of toxic metaand to stop healing party members at.")
meta.ui:createCheckbox(section, "Arcane Burst", "Will dispel Arcane Burst if checked.")
meta.ui:createSpinner(section, "Necrotic Rot", 40, 1, 100, 5, "Set how many stacks of necrotic rot to stop healing party members at.")
meta.ui:createSpinnerWithout(section, "Decaying Strike Timer", 5, 1, 20, 1, "Set how long to stop healing tank before Decaying Strike is cast.")
section:UpdateHeight()

-- Debug Info
meta.debug.labels = {}
local labels = meta.debug.labels
page = window.createPage("Debug Info")
section = meta.ui:createSection(page, "")
meta.ui:createCheckbox(section, "Enable Debug Info")
labels.updateRate = meta.ui:createText(section, "")
-- meta.ui:createText(section, "Lowest Unit")
-- labels.lowest   = meta.ui:createText(section, "")
labels.target     = meta.ui:createText(section, "")
labels.ttd        = meta.ui:createText(section, "")
section:UpdateHeight()

for _, page in ipairs(window.children) do
    print("Index " .. tostring(page.index))
    print(window.current_page)
    if page.index == window.current_page then
        page:Show()
    else
        page:Hide()
    end
end

window:Show()
window.initializing = false
