local meta = ...

-- Handle different shaped minimaps
local minimap_shape_quads = {
    ["ROUND"] = {true,true,true,true},
    ["SQUARE"] = {false,false,false,false},
    ["CORNER-TOPLEFT"] = {false,false,false,true},
    ["CORNER-TOPRIGHT"] = {false, false, true, false},
    ["CORNER-BOTTOMLEFT"] = {false, true, false, false},
    ["CORNER-BOTTOMRIGHT"] = {true, false, false, false},
    ["SIDE-LEFT"] = {false, true, false, true},
    ["SIDE-RIGHT"] = {true,false,true,false},
    ["SIDE-TOP"] = {false,false,true,true},
    ["SIDE-BOTTOM"] = {true,true,false,false},
    ["TRICORNER-TOPLEFT"] = {false,true,true,true},
    ["TRICORNER-TOPRIGHT"] = {true,false,true,true},
    ["TRICORNER-BOTTOMLEFT"] = {true,true,false,true},
    ["TRICORNER-BOTTOMRIGHT"] = {true,true,true,false},
}

local function update_position(self, position)
    local angle = math.rad(position or 225)
    local x, y, q = math.cos(angle), math.sin(angle), 1
    if x < 0 then q = q + 1 end
    if y > 0 then q = q + 2 end
    local shape = GetMinimapShape and GetMinimapShape() or "ROUND"
    local quad_table = minimap_shape_quads[shape]
    local w = (Minimap:GetWidth() / 2) + 5
    local h = (Minimap:GetHeight() / 2) + 5
    if quad_table[q] then
        x, y = x * w, y * h
    else
        local radiusw = math.sqrt(2*(w)^2)-10
        local radiush = math.sqrt(2*(h)^2)-10
        x = math.max(-w, math.min(x*radiusw, w))
        y = math.max(-h, math.min(y*radiush, h))
    end
    self:ClearAllPoints()
    self:SetPoint("CENTER", Minimap, "CENTER", x, y)
end

-- Minimap Button
local dragMode = nil -- "free", nil
local function moveButton(self)
    local centerX, centerY = Minimap:GetCenter()
    local x, y = GetCursorPosition()
    x, y = x / self:GetEffectiveScale(), y / self:GetEffectiveScale()
    local pos = math.deg(math.atan2(y - centerY, x - centerX)) % 360
    update_position(self, pos)
end
local button = CreateFrame("Button", "MetaMinimapButton", Minimap)
button:SetHeight(25)
button:SetWidth(25)
button:SetFrameStrata("MEDIUM")
button:SetPoint("CENTER", 75.70, -6.63)
button:SetMovable(true)
button:SetUserPlaced(true)
button:SetNormalTexture("Interface\\HelpFrame\\HotIssueIcon.blp")
button:SetPushedTexture("Interface\\HelpFrame\\HotIssueIcon.blp")
button:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-Background.blp")
button:SetScript("OnMouseDown", function(self, button)
    if button == "RightButton" then
        print("Right Button Down")
    end
    if button == "MiddleButton" then
        print("Middle Button Down")
    end
    if IsShiftKeyDown() and IsAltKeyDown() then
        self:SetScript("OnUpdate", moveButton)
    end
end)
button:SetScript("OnMouseUp", function(self)
    self:SetScript("OnUpdate", nil)
end)
button:SetScript("OnClick", function(self, button)
    if button == "LeftButton" then
        print("Left Button Clicked")
    end
end)
button:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(Minimap, "ANCHOR_CURSOR", 50, 50)
    GameTooltip:SetText("BadRotations", 214 / 255, 25 / 255, 25 / 255)
    GameTooltip:AddLine("by CuteOne")
    GameTooltip:AddLine("Left Click to toggle config frame.", 1, 1, 1, 1)
    GameTooltip:AddLine("Shift+Left Click to toggle toggles frame.", 1, 1, 1, 1)
    GameTooltip:AddLine("Alt+Shift+LeftButton to drag.", 1, 1, 1, 1)
    GameTooltip:AddLine("Right Click to open profile options.", 1, 1, 1, 1)
    GameTooltip:AddLine("Middle Click to open help frame.", 1, 1, 1, 1)
    GameTooltip:Show()
end)
button:SetScript("OnLeave", function(self)
    GameTooltip:Hide()
end)

