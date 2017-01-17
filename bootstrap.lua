local addonName, meta = ...

C_Timer.After(1, function()
    -- if FireHack then
    if GetFireHackVersion () then
        print('|cffa330c9[meta] |r FireHack Detected, Loading...')
        local baseFolder = GetWoWDirectory() .. '\\Interface\\AddOns\\meta\\'
        function require(fileResolver, ...)
            local filepath = string.gsub(fileResolver, "[.]", "\\")
            local lua = ReadFile(baseFolder .. 'meta\\' .. filepath .. '.lua')
            if not lua then
                print('|cffa330c9[meta] |r Load LUA files failed.')
                return nil
            end
            local lambda, fault = loadstring(lua, fileResolver)
            if fault then
                print('|cffa330c9[meta] |r Unable to require file: |cFFFF0000'.. fileResolver)
                error(fault)
                return false
            else
                return lambda(meta, require, ...)
            end
        end
        print('|cffa330c9[meta] |r Load Complete.')
        require('init')
    else
        print('|cffa330c9[meta] |r Load FireHack.')
    end
end)
