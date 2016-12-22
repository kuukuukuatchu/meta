local meta      = ...
local loader    = { }

local specID = tostring(GetSpecializationInfo(GetSpecialization()))

function loader.getAddonFolder()
    return GetWoWDirectory() .. '\\Interface\\AddOns\\meta\\'
end

function loader.getRotationFolder()
    return loader.getAddonFolder() .. '\meta\\rotations\\'
end

function loader.getClassFoldersInRotationFolder()
    return GetSubdirectories(loader.getRotationFolder()..'*')
end

function loader.getClassFolderLocation(classFolder)
    return loader.getRotationFolder()..tostring(classFolder)..'\\'
end

function loader.getSpecFoldersInClassFolder(classFolder)
    return GetSubdirectories(loader.getClassFolderLocation(classFolder)..'*')
end

function loader.getSpecFolderLocation(specFolder)
    return loader.getClassFolderLocation(classFolder)..tostring(specFolder)..'\\'
end

function loader.getProfilesInSpecFolder(specFolder)
    return GetDirectoryFiles(loader.getSpecFolderLocation(specFolder)..'*.lua')
end

function loader.getProfileLocation(profile)
    return loader.getSpecFolderLocation(specFolder)..tostring(profile)
end

function loader.getRotationID(profile)
    local stringFile = ReadFile(profile)
    local i, j = strfind(stringFile,"profileID = ")
    local rawID = string.sub(stringFile, j, j+3)
    local profileID = string.gsub(rawID, "%s+", "")
    return tonumber(profileID)
end

print(loader.getAddonFolder())
print(loader.getRotationFolder())
-- Search each Class Folder in the Rotations Folder
for _, classFolder in pairs(loader.getClassFoldersInRotationFolder()) do
    print(loader.getClassFolderLocation(classFolder))
    -- Search each Spec Folder in the Class Folder
    for _, specFolder in pairs(loader.getSpecFoldersInClassFolder(classFolder)) do
        print(loader.getSpecFolderLocation(specFolder))
        -- Search each Profile in the Spec Folder
        for _, profile in pairs(loader.getProfilesInSpecFolder(specFolder)) do
            print(loader.getProfileLocation(profile))
            -- Check if Profile is for current Spec
            if loader.checkID(loader.getProfileLocation(profiles)) == specID then
                print("Valid Rotation for Spec Found!")
                -- Do Profile Selection
            end
        end
    end
end

return loader
