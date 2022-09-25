local meta = ...

local function getSettingsLocation(base)
    if not base then
        return meta.data.settings[meta.currentProfile]
    else
        return meta.data.settings.base
    end
end

-- if meta.isChecked("Debug") then
function meta.isChecked(Value, base)
    local location = getSettingsLocation(base)
    if not location then
        return false
    end
    if location[Value .. "Check"] then
        return true
    end
    return false
end

-- if isSelected("Stormlash Totem") then
function meta.isSelected(Value, base)
    local location = getSettingsLocation(base)
    if not location then
        return false
    end
    if -- (location.toggles["Cooldowns"] == 3 or 
    (meta.isChecked(Value, base) and (meta.getValue(Value, base) == 3 or (meta.getValue(Value, base) == 2))) -- and location.toggles["Cooldowns"] == 2)))) 
    then
        return true
    end
    return false
end

function meta.getValue(Value, base)
    local location = getSettingsLocation(base)
    if not location then
        return 0
    end

    if location[Value .. "Status"] ~= nil then
        return location[Value .. "Status"]
    elseif location[Value .. "Drop"] ~= nil then
        return location[Value .. "Drop"]
    elseif location[Value .. "EditBox"] ~= nil then
        return location[Value .. "EditBox"]
    else
        return 0
    end
end

function meta.getText(Value, base)
    local location = getSettingsLocation(base)
    if not location then
        return ""
    end

    if location[Value .. "Data"] ~= nil then
        if location[Value .. "Drop"] ~= nil then
            if location[Value .. "Data"][location[Value .. "Drop"]] ~= nil then
                return location[Value .. "Data"][location[Value .. "Drop"]]
            end
        end
    end
    return ""
end

meta.timer = {}
function meta.timer:useTimer(timerName, interval)
    if self[timerName] == nil then
        self[timerName] = 0
    end
    if GetTime() - self[timerName] >= interval then
        self[timerName] = GetTime()
        return true
    else
        return false
    end
end

function meta.getUnit(table, callback)
    for i = 1, #table do
      if callback(table[i]) then return table[i] end
    end
  end
