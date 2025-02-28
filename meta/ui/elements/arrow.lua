local DiesalGUI = LibStub("DiesalGUI-1.1")
local meta = ...

meta.ui = meta.ui or {}
-- Right Arrow
function meta.ui:createRightArrow(window)
    local rArr = DiesalGUI:Create("Button")
    rArr:SetParent(window)
    rArr:SetStyle("frame", {
        type = "texture",
        offset = {-2, nil, -2, nil},
        height = 16,
        width = 16,
        alpha = .7,
        image = {"DiesalGUIcons", {7, 5, 16, 256, 128}}
    })
    rArr:SetPoint("TOPRIGHT", 0, 0)
    rArr:SetSettings({
        width           = 20,
        height          = 20,
        disabled        = false,
    },true)
    rArr:SetEventListener(
        "OnEnter",
        function()
            GameTooltip:SetOwner(rArr.frame, "ANCHOR_TOPLEFT", 0, 2)
            GameTooltip:AddLine("Next")
            GameTooltip:Show()
        end
    )
    rArr:SetEventListener(
        "OnLeave",
        function()
            GameTooltip:Hide()
        end
    )
    rArr:ApplySettings()
    return rArr
end
-- Left Arrow
function meta.ui:createLeftArrow(window)
    local lArr = DiesalGUI:Create("Button")
    lArr:SetParent(window)
    lArr:SetPoint("TOPLEFT", 0, 0)
    lArr:SetSettings(
        {
            width = 20,
            height = 20,
            disabled = false
        },
        true
    )
    lArr:SetStyle("frame", {
        type = "texture",
        offset = {-2, nil, -2, nil},
        height = 16,
        width = 16,
        alpha = .7,
        image = {"DiesalGUIcons", {8, 5, 16, 256, 128}}
    })
    lArr:SetEventListener(
        "OnEnter",
        function()
           GameTooltip:SetOwner(lArr.frame, "ANCHOR_TOPLEFT", 0, 2)
           GameTooltip:AddLine("Previous")
           GameTooltip:Show()
        end
    )
    lArr:SetEventListener(
        "OnLeave",
        function()
           GameTooltip:Hide()
        end
    )
    return lArr
end
