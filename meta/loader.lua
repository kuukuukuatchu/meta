local meta, require = ...
local loader = {}
local rotations = {}
local events = meta.events
local update = meta.update

meta.checkDirectories("rotation")
local rotationInfo = meta.folder .. "\\Settings\\rotation\\" .. strlower(UnitName("player")) .. ".json"
rotations.settings = rotations.settings or meta.json.load(rotationInfo)
local settings = rotations.settings

SLASH_META1 = '/meta'
if metaToggle == nil then
    metaToggle = 0
end
function SlashCmdList.META(msg, editBox)
    if metaToggle == 0 then
        metaToggle = 1;
        return print("|cffa330c9[meta] |r Rotation |cff00FF00 Enabled")
    else
        metaToggle = 0;
        return print("|cffa330c9[meta] |r Rotation |cffFF0000 Disabled")
    end
end

local function switchProfiles(name)
    if not rotations[name] then
        print("Rotation " .. name .. " does not exist")
        return false
    end
    if settings.enabled and name == settings.activeProfile then
        print("Rotation " .. name .. " is already active")
        return false
    end
    settings.activeProfile = name
    settings.enabled = true
    if settings.lastProfile and rotations[settings.lastProfile] and
        rotations[settings.lastProfile].onDeselect then
        -- print("Removing profile " .. settings.lastProfile)
        rotations[settings.lastProfile]:onDeselect()
    end
    if rotations[name].onSelect then
        -- print("Selecting profile " .. name)
        rotations[name]:onSelect()
    end
    if settings.lastProfile ~= name then
        settings.lastProfile = name
    end
    if settings[meta.specName].lastProfile ~= name then
        settings[meta.specName].lastProfile = name
    end
    meta.json.save(settings, rotationInfo)
    return true
end

function loader.rotationsDirectory()
    return meta.folder .. '\\meta\\rotations\\'
end

function loader.profiles(class, spec)
    return meta._G.GetDirectoryFiles(loader.rotationsDirectory() .. class .. '\\' .. spec .. '\\*.lua')
end

function loader.loadProfiles()
    local specID, specName = GetSpecializationInfo(GetSpecialization())
    local rotationFound = false
    wipe(rotations)
    for _, profile in pairs(loader.profiles(meta.class, specName)) do
        local rotation = require('rotations.' .. meta.class .. '.' .. specName .. '.' .. profile:sub(1, -5))
        if rotation then
            if rotation.profileID == specID then
                if rotationFound == false then
                    rotationFound = true
                end
                print('|cffa330c9[meta] |r Rotation Found: |cFFFF0000' .. rotation.profileName)
                meta.magic(rotation.rotation)
                rotations[rotation.profileName] = rotation
                meta.windows.profile.rotations:AddListItem(rotation.profileName)
            end
        end
    end
    print("|cffa330c9[meta] |r All Profiles Added")
    if settings[meta.specName] then
        meta.currentProfile = settings[meta.specName].lastProfile
    elseif meta.windows.profile.rotations.children[1] then
        meta.currentProfile = meta.windows.profile.rotations.children[1].settings.value
        settings[meta.specName] = {}
        settings[meta.specName].lastProfile = meta.currentProfile
    else
        print("No profiles found for spec " .. meta.specName)
        meta.windows.profile.rotations:AddListItem("None")
        meta.windows.profile.rotations:SetValue(1)
        return false
    end
    meta.data.settings[meta.currentProfile] = {}
    for k, v in pairs(meta.windows.profile.rotations.children) do
        if v and v.settings.value == meta.currentProfile then
            meta.windows.profile.rotations:SetValue(k)
            break
        end
    end
    settings.enabled = false
    switchProfiles(meta.currentProfile)
    if metaToggle == 0 then
        print("|cffa330c9[meta] |r Rotation Status:|cffFF0000 Disabled")
    end
    if metaToggle == 1 then
        print("|cffa330c9[meta] |r Rotation Status:|cff00FF00 Enabled")
    end
    if not rotationFound then
        print('|cffa330c9[meta] |r No Rotation Found For Spec: |cFFFF0000' .. specID)
    end
end

loader.loadProfiles()

meta.windows.profile.rotations:SetEventListener("OnValueChanged", function(this, event, key, value, selection)
    if value ~= nil  then
        switchProfiles(value)
    end
end)

events.register_callback("ACTIVE_TALENT_GROUP_CHANGED", function()
    local _, currentSpec = GetSpecializationInfo(GetSpecialization())
    if meta.specName ~= currentSpec then
        meta.windows.profile.rotations:ReleaseChildren()
        if settings.lastProfile and rotations[settings.lastProfile] and
            rotations[settings.lastProfile].onDeselect then
            rotations[settings.lastProfile]:onDeselect()
        end
        meta.specName = currentSpec
        loader.loadProfiles()
    end
end)

events.register_callback("PLAYER_ENTERING_WORLD", function()
    print("Enter")
    loader.loadProfiles()
end)

-- for debug
_G['_rotations'] = rotations

-- run rotation
local timer = {}
function loader.timer(timerName, timerLength)
    if timer[timerName] == nil then
        timer[timerName] = 0
    end
    if GetTime() - timer[timerName] >= timerLength then
        timer[timerName] = GetTime()
        return true
    else
        return false
    end
end

update.register_callback(function()
    -- Initialize Rotation
    -- if loader.timer('runRotation',math.random(0.15, 0.3)) then
    if metaToggle == 1 then
        for k, v in pairs(rotations) do
            rotations[k].rotation()
        end
    end
end)

return loader
