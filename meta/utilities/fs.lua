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
        elseif type == "rotation" then
            local rotDir = mainDir .. "/rotation/"
            if checkIfExists(rotDir) then
                return true
            end
        else
            local unitDir = mainDir .. meta.class .. "/"
            if checkIfExists(unitDir) then
                local specDir = unitDir .. meta.specName .. "/"
                if checkIfExists(specDir) then
                    local profileDir = specDir .. meta.currentProfile .. "/"
                    if checkIfExists(profileDir) then
                        if type then
                            local typeDir = profileDir .. type .. "/"
                            if checkIfExists(typeDir) then
                                return true
                            end
                        end
                        return true
                    end
                end
            end
            return false
        end
    end
end
