local DiesalGUI = LibStub("DiesalGUI-1.0")
local DiesalTools = LibStub("DiesalTools-1.0")
local meta = ...
meta.ui = meta.ui or {}

function meta.ui:createDropdown(parent, text, itemlist, default, tooltip, tooltipDrop, hideCheckbox, base)
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
    local checkBox = meta.ui:createCheckbox(parent, text, tooltip, false, true)
    if hideCheckbox then
        local check = true
        if check == true then
            checkBox:SetChecked(false)
        end
        checkBox:Disable()
        checkBox:ReleaseTextures()
    end
    -------------------------------

    -------------------------------
    --------Create Dropdown--------
    -------------------------------
    local newDropdown = DiesalGUI:Create("Dropdown")
    local default = default or 1
    parent:AddChild(newDropdown)

    newDropdown:SetParent(parent.content)
    newDropdown:SetPoint("TOPRIGHT", parent.content, "TOPRIGHT", -5, Y)
    newDropdown:SetHeight(12)
    newDropdown:SetList(itemlist)

    --------------
    ---BR Stuff---
    --------------
    local state
    local location
    if not base then
        state = meta.data.settings[meta.currentProfile]
        location = meta.folder.."/Settings/"..GetRealmName().."/"..UnitName("player").."/"..meta.specName.."/settings.json"
    else
        state = meta.data.settings.base
        location = meta.folder.."/Settings/baseUI/settings.json"
    end
    -- Read from config or set default
    if state[text .. "Drop"] == nil then
        state[text .. "Drop"] = default
    end

    local value = state[text .. "Drop"]
    newDropdown:SetValue(value)

    ------------------
    ------Events------
    ------------------
    -- Event: OnClick
    local main_window = parent.content
    if main_window:GetParent() ~= UIParent then
        repeat
            main_window = main_window:GetParent()
        until main_window:GetParent() == nil or main_window:GetParent() == UIParent
    end 
    local strata = newDropdown.dropdown:GetFrameStrata()
    newDropdown:SetEventListener("OnClick", function(self, event, ...)
        if self.dropdown:IsShown() then
            strata = self.dropdown:GetFrameStrata()
            self.dropdown:SetParent(main_window)
            self.dropdown:SetFrameStrata("HIGH")
        else
            self.dropdown:SetParent(self.frame)
            self.dropdown:SetFrameStrata(strata)
        end
    end)
    -- Event: OnValueChange
    newDropdown:SetEventListener(
        "OnValueChanged",
        function(this, event, key, value, selection)
            state[text .. "Drop"] = key
            meta.json.save(state, location)
        end
    )
    -- Event: Tooltip
    if tooltip or tooltipDrop then
        local tooltip = tooltipDrop or tooltip
        newDropdown:SetEventListener(
            "OnEnter",
            function(this, event)
                GameTooltip:SetOwner(Minimap, "ANCHOR_CURSOR", 50, 50)
                GameTooltip:SetText(tooltip, 214 / 255, 25 / 255, 25 / 255)
                GameTooltip:Show()
            end
        )
        newDropdown:SetEventListener(
            "OnLeave",
            function(this, event)
                GameTooltip:Hide()
            end
        )
    end

    ----------------------
    ------END Events------
    ----------------------
    newDropdown:ApplySettings()
    ----------------------------
    --------END Dropdown--------
    ----------------------------

    return newDropdown, checkBox
end

function meta.ui:createDropdownWithout(parent, text, itemlist, default, tooltip, tooltipDrop, base)
    return meta.ui:createDropdown(parent, text, itemlist, default, tooltip, tooltipDrop, true, base)
end

-- function br.ui:createProfileDropdown(parent)
--     -------------------------------
--     ----Need to calculate Y Pos----
--     -------------------------------
--     local Y = -5
--     for i = 1, #parent.children do
--         if parent.children[i].type ~= "Spinner" and parent.children[i].type ~= "Dropdown" then
--             Y = Y - parent.children[i].frame:GetHeight() * 1.2
--         end
--     end
--     Y = DiesalTools.Round(Y)

--     local profiles = br.fetch(br.selectedSpec .. "_" .. "profiles", {{key = "default", text = "Default"}})
--     local selectedProfile = br.fetch(br.selectedSpec .. "_" .. "profile", "default")
--     local profile_drop = DiesalGUI:Create("Dropdown")
--     parent:AddChild(profile_drop)
--     profile_drop:SetParent(parent.content)
--     profile_drop:SetPoint("TOPLEFT", parent.content, "TOPLEFT", 1, Y)
--     profile_drop:SetHeight(18)
--     profile_drop:SetWidth(200)
--     local list = {}
--     for i, value in pairs(profiles) do
--         list[value.key] = value.key
--     end
--     profile_drop:SetList(list)
--     profile_drop:SetValue(br.fetch(br.selectedSpec .. "_" .. "profile", "Default Profile"))
--     profile_drop:SetEventListener(
--         "OnValueChanged",
--         function(this, event, key, value, selection)
--             br.profileDropValue = key
--         end
--     )
-- end
