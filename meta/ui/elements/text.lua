local DiesalGUI = LibStub("DiesalGUI-1.0")
local DiesalTools = LibStub("DiesalTools-1.0")
local meta = ...
meta.ui = meta.ui or {}

local BRFont = "DiesalFontNormal"
do
    local locale = GetLocale()
    if locale == "koKR" or locale == "zhCN" or locale == "zhTW" then
        BRFont = "GameFontNormalSmall"
    end
end

DiesalGUI:RegisterObjectConstructor(
    "FontString",
    function()
        local self = DiesalGUI:CreateObjectBase(Type)
        local frame = CreateFrame("Frame", nil, UIParent)
        local fontString = frame:CreateFontString(nil, "OVERLAY", BRFont)
        self.frame = frame
        frame:SetHeight(select(2, fontString:GetFont()))
        self.fontString = fontString
        self.SetParent = function(self, parent)
            self.frame:SetParent(parent)
        end
        self.OnRelease = function(self)
            self.fontString:SetText("")
        end
        self.OnAcquire = function(self)
            self:Show()
        end
        self.SetPoint = function(self, ...)
            self.fontString:SetPoint(...)
        end
        self.SetText = function(self, text)
            self.fontString:SetText(text)
        end
        self.SetJustifyH = function(self, position)
            self.fontString:SetJustifyH(position)
        end
        self.SetJustifyV = function(self, position)
            self.fontString:SetJustifyV(position)
        end
        self.SetWordWrap = function(self, enabled)
            self.fontString:SetWordWrap(enabled)
        end
        self.SetTextColor = function(self, ...)
            self.fontString:SetTextColor(...)
        end
        self.type = "FontString"
        return self
    end,
    1
)
function meta.ui:createText(parent, text, isCheckbox)
    if isCheckbox == nil then
        isCheckbox = false
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
    ----------------------------
    --------Create Label--------
    ----------------------------
    local label = DiesalGUI:Create("FontString")

    label:SetParent(parent.content)

    parent:AddChild(label)

    label = label.fontString

    label:SetPoint("TOPLEFT", parent.content, "TOPLEFT", 20, Y)
    label:SetWidth(parent.content:GetWidth() - 10)
    label:SetJustifyH("LEFT")
    label:SetJustifyV("TOP")
    label:SetText(text)
    label:SetWordWrap(false)

    -------------------------
    --------END Label--------
    -------------------------

    return label
end
