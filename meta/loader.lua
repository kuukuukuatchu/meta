local baseFolder = GetWoWDirectory() .. '\\Interface\\AddOns\\meta\\'
local classFolders = GetSubdirectories(baseFolder .. '\\meta\\rotations\\*')

--print(baseFolder)
for i = 1, #classFolders do
    --print(baseFolder..'\meta\\rotations\\'..classFolders[i])
    local specFolders = GetSubdirectories(baseFolder..'\meta\\rotations\\'..classFolders[i]..'\\*')
    for j = 1, #specFolders do
        --print(baseFolder..'\meta\\rotations\\'..classFolders[i]..'\\'..specFolders[j])
        local profiles = GetDirectoryFiles(baseFolder..'\meta\\rotations\\'..classFolders[i]..'\\'..specFolders[j]..'\\*.lua')
        for k = 1, #profiles do
            --print(profiles[k])
            -- Do Profile Selection
        end
    end
end
