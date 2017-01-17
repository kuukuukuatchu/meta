local meta      = ...
local loader    = { }
rotations = { }

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
    wipe(rotations)
    -- Search each Class Folder in the Rotations Folder
    for _, class in pairs(loader.classDirectories()) do
        -- Search each Spec Folder in the Class Folder
        for _, spec in pairs(loader.specDirectories(class)) do
            -- Search each Profile in the Spec Folder
            for _, profile in pairs(loader.profiles(class, spec)) do
                local rotation = require('rotations.'..class..'.'..spec..'.'..profile:sub(1, -5))
                if rotation then
                    if rotation.profileID == specID then
                        print('|cffa330c9[meta] |r Rotation Found: |cFFFF0000' .. rotation.profileName)
                        meta.magic(rotation.rotation)
                        rotations[rotation.profileName] = rotation
                    end
                end
            end
        end
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

-- run rotation
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
    -- if loader.timer('runRotation',math.random(0.15, 0.3)) then
        for k, v in pairs(rotations) do
            rotations[k].rotation()
        end
    -- end
end)

return loader
