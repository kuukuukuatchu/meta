-- Required to access other files.
local meta = ...

-- Init slashList
local slashList = {}

function slashList.meta()
    if metaToggle == nil or metaToggle == 0 then
        metaToggle = 1;
        return print("|cff00FF00 Enabled")
    else
        metaToggle = 0;
        return print("|cffFF0000 Disabled")
    end
end


return slashList