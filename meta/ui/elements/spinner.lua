local DiesalGUI = _G.LibStub("DiesalGUI-1.0")
local DiesalTools = _G.LibStub("DiesalTools-1.0")
local meta = ...
meta.ui = meta.ui or {}
function meta.ui:createSpinner(parent, text, number, min, max, step, tooltip, tooltipSpin, hideCheckbox, base)
    -------------------------------
    ----Need to calculate Y Pos----
    -------------------------------
    local Y = -5
    for i = 1, #parent.children do
        if parent.children[i].type ~= "Spinner" and parent.children[i].type ~= "Dropdown" then
            Y = Y - parent.children[i].frame:GetHeight() * 1.2
        end
    end
    Y = DiesalTools.Round(Y)

    -------------------------------
    --------Create CheckBox--------
    -------------------------------
    local checkBox = meta.ui:createCheckbox(parent, text, tooltip, false, base)
    if hideCheckbox then
        local check = true
        -- local check = br.data.settings[br.selectedSpec][br.selectedProfile][text .. "Check"]
        if check == true then
            checkBox:SetChecked(false)
        end
        checkBox:Disable()
        checkBox:ReleaseTextures()
    end
    -------------------------------

    ------------------------------
    --------Create Spinner--------
    ------------------------------
    local spinner = DiesalGUI:Create("Spinner")
    parent:AddChild(spinner)

    spinner:SetParent(parent.content)
    spinner:SetPoint("TOPRIGHT", parent.content, "TOPRIGHT", -10, Y)
    spinner:SetSettings(
        {
            height = 12,
            width = 29,
            mouse = true,
            mouseWheel = true,
            buttons = false,
            buttonsWidth = 0,
            bar = true,
            min = min or 0,
            max = max or 100,
            step = step or 5,
            shiftStep = 1
        }
    )
    --    spinner:AddStyleSheet(spinnerStyleSheet)

    --------------
    ---BR Stuff---
    --------------
    -- Read number from config or set default
    local state
    local location
    if not base then
        state = meta.data.settings[meta.currentProfile]
        location = meta.folder.."/Settings/"..GetRealmName().."/"..UnitName("player").."/"..meta.specName.."/settings.json"
    else
        state = meta.data.settings.base
        location = meta.folder.."/Settings/baseUI/settings.json"
    end
    if state[text .. "Status"] == nil then
        state[text .. "Status"] = number
    end

    -- -- Add to UI Settings **Do not comment out or remove, will result in loss of settings**
    -- if br.data.ui == nil then
    --     br.data.ui = {}
    -- end
    -- br.data.ui[text .. "Status"] = state[text .. "Status"]

    local value = state[text .. "Status"]
    spinner:SetNumber(value)

    ------------------
    ------Events------
    ------------------
    -- Event: OnValueChange
    spinner:SetEventListener(
        "OnValueChanged",
        function()
            state[text .. "Status"] = spinner:GetNumber()
            meta.json.save(state, location)
        end
    )
    -- Event: Tooltip
    if tooltip or tooltipSpin then
        local tooltip = tooltipSpin or tooltip
        spinner:SetEventListener(
            "OnEnter",
            function()
                GameTooltip:SetOwner(spinner.frame, "ANCHOR_TOPLEFT", 0 , 2)
                GameTooltip:AddLine(tooltip)
                GameTooltip:SetOwner(Minimap, "ANCHOR_CURSOR", 50, 50)
                GameTooltip:SetText(tooltip, 214 / 255, 25 / 255, 25 / 255)
                GameTooltip:Show()
            end
        )
        spinner:SetEventListener(
            "OnLeave",
            function()
                GameTooltip:Hide()
            end
        )
    end
    ----------------------
    ------END Events------
    ----------------------
    spinner:ApplySettings()
    ---------------------------
    --------END Spinner--------
    ---------------------------
    return spinner, checkBox
end

-- Spinner Object : {number, min, max, step, tooltip}
function meta.ui:createDoubleSpinner(parent, text, spinner1, spinner2, hideCheckbox,base)
    -------------------------------
    ----Need to calculate Y Pos----
    -------------------------------
    local Y = -5
    for i = 1, #parent.children do
        if parent.children[i].type ~= "Spinner" and parent.children[i].type ~= "Dropdown" then
            Y = Y - parent.children[i].frame:GetHeight() * 1.2
        end
    end
    Y = DiesalTools.Round(Y)

    -------------------------------
    --------Create CheckBox--------
    -------------------------------
    local checkBox = meta.ui:createCheckbox(parent, text, "Enable auto usage of this spell", false, base)
    if hideCheckbox then
        checkBox:SetChecked(false)
        checkBox:Disable()
        checkBox:ReleaseTextures()
    end

    ------------------------------
    --------Create Spinner--------
    ------------------------------
    local spinnerElement1 = DiesalGUI:Create("Spinner")
    local spinnerElement2 = DiesalGUI:Create("Spinner")
    parent:AddChild(spinnerElement1)
    parent:AddChild(spinnerElement2)

    spinnerElement1:SetParent(parent.content)
    spinnerElement2:SetParent(parent.content)
    spinnerElement1:SetPoint("TOPRIGHT", parent.content, "TOPRIGHT", -50, Y)
    spinnerElement2:SetPoint("TOPRIGHT", parent.content, "TOPRIGHT", -10, Y)
    spinnerElement1:SetSettings(
        {
            height = 12,
            width = 29,
            mouse = true,
            mouseWheel = true,
            buttons = false,
            buttonsWidth = 0,
            bar = true,
            min = spinner1.min or 0,
            max = spinner1.max or 100,
            step = spinner1.step or 5,
            shiftStep = 1
        }
    )
    spinnerElement2:SetSettings(
        {
            height = 12,
            width = 29,
            mouse = true,
            mouseWheel = true,
            buttons = false,
            buttonsWidth = 0,
            bar = true,
            min = spinner2.min or 0,
            max = spinner2.max or 100,
            step = spinner2.step or 5,
            shiftStep = 1
        }
    )

    --------------
    ---BR Stuff---
    --------------
    local state
    local location
    if not base then
        state = meta.data.settings[meta.currentProfile]
        location = meta.folder.."/Settings/"..meta.class.."/"..meta.specName.."/"..meta.currentProfile.."/settings.json"
    else
        state = meta.data.settings.base
        location = meta.folder.."/Settings/baseUI/settings.json"
    end
    -- Read number from config or set default
    if state[text .. "1Status"] == nil then
        state[text .. "1Status"] = spinner1.number
    end
    if state[text .. "2Status"] == nil then
        state[text .. "2Status"] = spinner2.number
    end

    local state1 = state[text .. "1Status"]
    spinnerElement1:SetNumber(state1)
    local state2 = state[text .. "2Status"]
    spinnerElement2:SetNumber(state2)

    ------------------
    ------Events------
    ------------------
    -- Event: OnValueChange
    spinnerElement1:SetEventListener(
        "OnValueChanged",
        function()
            state[text .. "1Status"] = spinnerElement1:GetNumber()
            meta.json.save(state, location)
        end
    )
    spinnerElement2:SetEventListener(
        "OnValueChanged",
        function()
            state[text .. "2Status"] = spinnerElement2:GetNumber()
            meta.json.save(state, location)
        end
    )
    -- Event: Tooltip
    if spinner1.tooltip then
        spinnerElement1:SetEventListener(
            "OnEnter",
            function()
                GameTooltip:SetOwner(Minimap, "ANCHOR_CURSOR", 50, 50)
                GameTooltip:SetText(spinner1.tooltip, 214 / 255, 25 / 255, 25 / 255)
                GameTooltip:Show()
            end
        )
        spinnerElement1:SetEventListener(
            "OnLeave",
            function()
                GameTooltip:Hide()
            end
        )
    end
    if spinner2.tooltip then
        spinnerElement2:SetEventListener(
            "OnEnter",
            function()
                GameTooltip:SetOwner(Minimap, "ANCHOR_CURSOR", 50, 50)
                GameTooltip:SetText(spinner2.tooltip, 214 / 255, 25 / 255, 25 / 255)
                GameTooltip:Show()
            end
        )
        spinnerElement2:SetEventListener(
            "OnLeave",
            function()
                GameTooltip:Hide()
            end
        )
    end
    ----------------------
    ------END Events------
    ----------------------
    spinnerElement1:ApplySettings()
    spinnerElement2:ApplySettings()
    ---------------------------
    --------END Spinner--------
    ---------------------------
    return spinner1, spinner2
end

function meta.ui:createSpinnerWithout(parent, text, number, min, max, step, tooltip, tooltipSpin, base)
    return meta.ui:createSpinner(parent, text, number, min, max, step, tooltip, tooltipSpin, true, base)
end
