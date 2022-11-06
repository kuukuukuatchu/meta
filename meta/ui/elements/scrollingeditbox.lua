local DiesalGUI = LibStub("DiesalGUI-1.1")
local DiesalTools = LibStub("DiesalTools-1.1")
local DiesalStyle = LibStub("DiesalStyle-1.1")
local Colors = DiesalStyle.Colors
local meta = ...
meta.ui = meta.ui or {}
function meta.ui:createScrollingEditBox(parent, text, content, tooltip, width, height, hideCheckbox, base)
    if width == nil then
        width = 240
    end
    if height == nil then
        height = 50
    end
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
        checkBox:SetChecked(false)
        checkBox:Disable()
        checkBox:ReleaseTextures()
    end
    local inputStyleSheet = {
        ["frame-background"] = {
            type = "texture",
            layer = "BACKGROUND",
            color = "000000",
            alpha = .6
        },
        ["track-background"] = {
            type = "texture",
            layer = "BACKGROUND",
            color = "000000",
            alpha = .3
        },
        ["grip-background"] = {
            type = "texture",
            layer = "BACKGROUND",
            color = Colors.UI_400
        },
        ["grip-inline"] = {
            type = "outline",
            layer = "BORDER",
            color = "FFFFFF",
            alpha = .02
        },
        ["frame-outline"] = {
            type = "outline",
            layer = "BORDER",
            color = "FFFFFF",
            offset = 0
        }
    }
    -------------------------------

    ------------------------------
    --------Create input--------
    ------------------------------
    local input = DiesalGUI:Create("ScrollingEditBox")
    parent:AddChild(input)

    input:SetParent(parent.content)
    input:SetPoint("TOPLEFT", parent.content, "TOPLEFT", 5, Y - 14)
    input:SetStylesheet(inputStyleSheet)

    input.settings.contentPadding = {1, 1, 1, 1}

    --------------
    ---BR Stuff---
    --------------
    -- Read number from config or set default
    local state
    local location
    if not base then
        state = meta.data.settings[meta.currentProfile]
        location = meta.folder.."/Settings/"..meta.class.."/"..meta.specName.."/"..meta.currentProfile.."/settings.json"
    else
        state = meta.data.settings.base
        location = meta.folder.."/Settings/baseUI/settings.json"
    end
    if state[text .. "EditBox"] == nil then
        state[text .. "EditBox"] = content
    end
    local value = state[text .. "EditBox"]
    input:SetText(value)
    input:SetWidth(width)
    input:SetHeight(height)

    ------------------
    ------Events------
    ------------------
    -- Event: OnValueChange
    input:SetEventListener(
        "OnTextChanged",
        function()
            state[text .. "EditBox"] = input.editBox:GetText()
            input.settings.text = input.editBox:GetText()
            meta.json.save(state, location)
        end
    )
    ----------------------
    ------END Events------
    ----------------------
    input:ApplySettings()
    ---------------------------
    --------END input--------
    ---------------------------
    return input, checkBox
end

function meta.ui:createScrollingEditBoxWithout(parent, text, content, tooltip, width, height, base)
    return meta.ui:createScrollingEditBox(parent, text, content, tooltip, width, height, true)
end
