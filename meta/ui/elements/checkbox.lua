local DiesalGUI = LibStub("DiesalGUI-1.0")
local DiesalTools = LibStub("DiesalTools-1.0")
local DiesalStyle = LibStub("DiesalStyle-1.0")
local meta = ...
meta.ui = meta.ui or {}


function meta.ui:createCheckbox(parent, text, tooltip, checked, base)
    if base == nil then
        base = false
    end
    -- Class Specific Color for UI Elements
    local classColor = {
        color = meta.classColor:sub(3)
    }
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
    checked = false


    -------------------------------
    --------Create CheckBox--------
    -------------------------------
    local checkBox = DiesalGUI:Create("CheckBox")

    checkBox:SetParent(parent.content)
    checkBox:SetPoint("TOPLEFT", parent.content, "TOPLEFT", 5, Y)
    checkBox:SetSettings(
        {
            height = 12,
            width = 12
        }
    )
    ----------------------------
    --------Create Label--------
    ----------------------------
    checkBox.text = DiesalGUI:Create("FontString")
    checkBox:AddChild(checkBox.text)
    checkBox.text:SetParent(checkBox.frame)
    checkBox.text:SetTextColor(1, 1, 1, 1)
    checkBox.text:SetWordWrap(false)
    checkBox.text:SetPoint("TOPLEFT", parent.content, "TOPLEFT", 20, Y)
    checkBox.text:SetPoint("TOPRIGHT", parent.content, "TOPRIGHT", -10, Y)
    checkBox.text:SetJustifyH("LEFT")
    checkBox.text:SetJustifyV("TOP")
    checkBox.text:SetText(text)

    -- Read check value from config, false if nothing found
    -- Set default
    local state
    local location
    if not base then
        state = meta.data.settings[meta.currentProfile]
        location = meta.folder.."/Settings/"..meta.class.."/"..meta.specName.."/"..meta.currentProfile.."/settings.json"
    else
        state = meta.data.settings.base
        location = meta.folder.."/Settings/baseUI/settings.json"
    end
    if state[text .. "Check"] == nil and not checked then
        state[text .. "Check"] = false
    end
    if state[text .. "Check"] == nil and checked then
        state[text .. "Check"] = true
    end

    local check = state[text .. "Check"]

    
    checkBox:SetChecked(check)
    ------------------
    ------Events------
    ------------------
    -- Event: OnValueChanged
    checkBox:SetEventListener(
        "OnValueChanged",
        function(this, event, checked)
            state[text .. "Check"] = checked
            meta.json.save(state, location)
            -- Create Chat Overlay
            if checked then
                DiesalStyle:StyleTexture(checkBox.check, classColor)
                -- br.ChatOverlay("|cff15FF00" .. text .. " Enabled")
            -- else
                -- br.ChatOverlay("|cFFED0000" .. text .. " Disabled")
            end
        end
    )
    -- Event: Tooltip
    if tooltip then
        checkBox:SetEventListener(
            "OnEnter",
            function()
               GameTooltip:SetOwner(checkBox.frame, "ANCHOR_TOPLEFT", 0, 2)
               GameTooltip:AddLine(tooltip)
               GameTooltip:Show()
            end
        )
        checkBox:SetEventListener(
            "OnLeave",
            function()
               GameTooltip:Hide()
            end
        )
    end
    ----------------------
    ------END Events------
    ----------------------

    DiesalStyle:StyleTexture(checkBox.check, classColor)
    checkBox:ApplySettings()
    ----------------------------
    --------END CheckBox--------
    ----------------------------
    parent:AddChild(checkBox)

    return checkBox
end
