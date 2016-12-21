local meta      = ...
local loader    = { }

local baseFolder = GetWoWDirectory() .. '\\Interface\\AddOns\\meta\\'
local classFolders = GetSubdirectories(baseFolder .. '\\meta\\rotations\\*')

-- function loader.selectProfiles()
    loader.rotation = {}
    --print(baseFolder)
    for i = 1, #classFolders do
        --print(baseFolder..'\meta\\rotations\\'..classFolders[i])
        local specFolders = GetSubdirectories(baseFolder..'\meta\\rotations\\'..classFolders[i]..'\\*')
        for j = 1, #specFolders do
            --print(baseFolder..'\meta\\rotations\\'..classFolders[i]..'\\'..specFolders[j])
            local profiles = GetDirectoryFiles(baseFolder..'\meta\\rotations\\'..classFolders[i]..'\\'..specFolders[j]..'\\*.lua')
            for k = 1, #profiles do
                table.insert(loader.rotation,profiles[k])
                --print(profiles[k])
                local currentFile = GetDirectoryFiles(baseFolder..'\meta\\rotations\\'..classFolders[i]..'\\'..specFolders[j]..'\\'..profiles[k])
                ReadFile(currentFile)
                -- Do Profile Selection
            end
        end
    end
-- end

return loader
