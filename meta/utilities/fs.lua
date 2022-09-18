local meta = ...

local function checkIfExists(dir)
    if not meta._G.DirectoryExists(dir) then
        meta._G.CreateDirectory(dir)
    end
    if not meta._G.DirectoryExists(dir) then
        meta._G.print("Creating Settings Directory " .. dir .. " failed!")
        return false
    end
    return true
end
-- Check Directories
function meta.checkDirectories(type)
    -- Set Settings Directory
    local mainDir = meta.folder .. "/Settings/"
    if checkIfExists(mainDir) then
        if type == "base" then
            local baseDir = mainDir .. "/baseUI/"
            if not meta._G.DirectoryExists(baseDir) then
                meta._G.CreateDirectory(baseDir)
            end
            if not meta._G.DirectoryExists(baseDir) then
                meta._G.print("Creating Base Settings Directory " .. baseDir .. " failed!")
            end
        else
            local realmDir = mainDir .. GetRealmName() .. "/"
            if checkIfExists(realmDir) then
                local unitDir = realmDir .. UnitName("player") .. "/"
                if checkIfExists(unitDir) then
                    local specDir = unitDir .. meta.specName .. "/"
                    if checkIfExists(specDir) then
                        local typeDir = specDir .. type .. "/"
                        if checkIfExists(typeDir) then
                            return true
                        end
                    end
                end
            end
            return false
        end
    end
end
