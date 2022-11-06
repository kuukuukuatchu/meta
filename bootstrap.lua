local addonName, meta, icc = ...

C_Timer.After(1, function()
    local unlocker = icc and "ICC" or nil
    if icc then
        -- if GetFireHackVersion () then
        print('|cffa330c9[meta] |r ' .. unlocker .. ' Detected, Loading...')
        local baseFolder = icc.GetBaseFolder(true) .. '\\AddOns\\meta\\'
        local packages = {}
        function require(fileResolver, ...)
            local filepath = string.gsub(fileResolver, "[.]", "\\")
            local lua = icc.GetContents(string.gsub(baseFolder .. 'meta\\' .. filepath .. '.lua', "\\+", "/"))
            if not lua then
                print('|cffa330c9[meta] |r Load LUA files failed. '.. filepath)
                return nil
            end
            if not packages[fileResolver] then
                local lambda, fault = loadstring(lua, fileResolver)
                if fault then
                    print('|cffa330c9[meta] |r Unable to require file: |cFFFF0000' .. fileResolver)
                    error(fault)
                    return false
                else
                    packages[fileResolver] = {lambda(meta, require, ...)}
                end
            end
            return unpack(packages[fileResolver])
        end
        print('|cffa330c9[meta] |r Load Complete.')
        local unlocked = require('unlockers.icc', icc)
        if unlocked then
            require('init')
        else 
            print('|cffa330c9[meta] |r  Unlock Failed')
        end
    else
        print('|cffa330c9[meta] |r Load Unlocker.')
    end
end)
