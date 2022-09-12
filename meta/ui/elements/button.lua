local DiesalGUI = LibStub("DiesalGUI-1.0")
local DiesalTools = LibStub("DiesalTools-1.0")
local meta = ...
meta.ui = meta.ui or {}

local buttonStyleSheet = {
    ["frame-color"] = {
        type = "texture",
        layer = "BACKGROUND",
        color = "2f353b",
        offset = 0
    },
    ["frame-highlight"] = {
        type = "texture",
        layer = "BORDER",
        gradient = "VERTICAL",
        color = "FFFFFF",
        alpha = 0,
        alphaEnd = .1,
        offset = -1
    },
    ["frame-outline"] = {
        type = "outline",
        layer = "BORDER",
        color = "000000",
        offset = 0
    },
    ["frame-inline"] = {
        type = "outline",
        layer = "BORDER",
        gradient = "VERTICAL",
        color = "ffffff",
        alpha = .02,
        alphaEnd = .09,
        offset = -1
    },
    ["frame-hover"] = {
        type = "texture",
        layer = "HIGHLIGHT",
        color = "ffffff",
        alpha = .1,
        offset = 0
    },
    ["text-color"] = {
        type = "Font",
        color = "b8c2cc"
    }
}
function meta.ui:createButton(parent, buttonName, x, y, onClickFunction, alignRight)
    if y == nil then
        y = -5
        for i = 1, #parent.children do
            if parent.children[i].type ~= "Spinner" and parent.children[i].type ~= "Dropdown" then
                y = y - parent.children[i].frame:GetHeight() * 1.2
            end
        end
        y = DiesalTools.Round(y)
    end
    if x == nil then
        x = 5
    end
    local newButton = DiesalGUI:Create("Button")
    newButton:SetParent(parent.content)
    parent:AddChild(newButton)
    newButton:SetStylesheet(buttonStyleSheet)
    if alignRight then
        newButton:SetPoint("TOPRIGHT", parent.content, "TOPRIGHT", x, y)
    else
        newButton:SetPoint("TOPLEFT", parent.content, "TOPLEFT", x, y)
    end
    newButton:SetText(buttonName)
    newButton:SetWidth(100)
    newButton:SetHeight(20)
    newButton:SetEventListener(
        "OnClick",
        function()
            onClickFunction()
        end
    )
end