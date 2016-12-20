local addonName, meta = ...

C_Timer.After(1, function()
    if FireHack then
        print('[meta] FireHack Detected, Loading...')
        local baseFolder = GetWoWDirectory() .. '\\Interface\\AddOns\\meta\\'
        function require(fileResolver, ...)
            local filepath = string.gsub(fileResolver, "[.]", "\\")
            local lua = ReadFile(baseFolder .. 'meta\\' .. filepath .. '.lua')
            if not lua then
                print('[meta] Load LUA files failed.')
                return nil
            end
            local lambda, fault = loadstring(lua, fileResolver)
            if fault then
                print('[meta] Unable to require file: '.. fileResolver)
                error(fault)
                return false
            else
                print('[meta] Load Complete.')
                return lambda(meta, require, ...)
            end
        end
        require('init')
    else
        print('[meta] Load FireHack.')
    end
end)
