local meta      = ...
local loader    = { }
local rotations = { }

SLASH_META1 = '/meta'
if metaToggle == nil then metaToggle = 0 end
function SlashCmdList.META(msg, editBox)
    if metaToggle == 0 then
        metaToggle = 1;
        return print("|cffa330c9[meta] |r Rotation |cff00FF00 Enabled")
    else
        metaToggle = 0;
        return print("|cffa330c9[meta] |r Rotation |cffFF0000 Disabled")
    end
end

function loader.rotationsDirectory()
    return GetWoWDirectory() .. '\\Interface\\AddOns\\meta\\meta\\rotations\\'
end

function loader.classDirectories()
    return GetSubdirectories(loader.rotationsDirectory()..'*')
end

function loader.specDirectories(class)
    return GetSubdirectories(loader.rotationsDirectory() .. class .. '\\*')
end

function loader.profiles(class, spec)
    return GetDirectoryFiles(loader.rotationsDirectory() .. class .. '\\' .. spec .. '\\*.lua')
end

function loader.loadProfiles()
    local specID = GetSpecializationInfo(GetSpecialization())
    local rotationFound = false
    wipe(rotations)
    -- Search each Class Folder in the Rotations Folder
    for _, class in pairs(loader.classDirectories()) do
        if class ~= "." and class ~= ".." then
            -- Search each Spec Folder in the Class Folder
            for _, spec in pairs(loader.specDirectories(class)) do
                -- Search each Profile in the Spec Folder
                for _, profile in pairs(loader.profiles(class, spec)) do
                    local rotation = require('rotations.'..class..'.'..spec..'.'..profile:sub(1, -5))
                    if rotation then
                        if rotation.profileID == specID then
                            if rotationFound == false then rotationFound = true end
                            print('|cffa330c9[meta] |r Rotation Found: |cFFFF0000' .. rotation.profileName)
                            if metaToggle == 0 then print("|cffa330c9[meta] |r Rotation Status:|cffFF0000 Disabled") end
                            if metaToggle == 1 then print("|cffa330c9[meta] |r Rotation Status:|cff00FF00 Enabled") end
                            meta.magic(rotation.rotation)
                            rotations[rotation.profileName] = rotation
                        end
                    end
                end
            end
        end
    end
    if not rotationFound then
        print('|cffa330c9[meta] |r No Rotation Found For Spec: |cFFFF0000' .. specID)
    end
end

loader.loadProfiles()

AddEventCallback("ACTIVE_TALENT_GROUP_CHANGED", function()
    loader.loadProfiles()
end)

-- AddEventCallback("PLAYER_ENTERING_WORLD", function()
--     loader.loadProfiles()
-- end)

-- for debug
_G['_rotations'] = rotations

--run rotation
local timer = {}
function loader.timer(timerName,timerLength)
    if timer[timerName] == nil then timer[timerName] = 0 end
    if GetTime() - timer[timerName] >= timerLength then
        timer[timerName] = GetTime()
        return true
    else
        return false
    end
end
AddFrameCallback(function ()
    -- Initialize Rotation
    -- if loader.timer('runRotation',math.random(0.15, 0.3)) then
        for k, v in pairs(rotations) do
            rotations[k].rotation()
        end
    -- end
end)

return loader
