local DiesalGUI = _G.LibStub("DiesalGUI-1.0")
local DiesalStyle = _G.LibStub("DiesalStyle-1.0")
local DiesalTools = _G.LibStub("DiesalTools-1.0")
local SharedMedia = _G.LibStub("LibSharedMedia-3.0")
local meta = ...
meta.ui = meta.ui or {}

local messageStylesheet = {
    ["track-background"] = {
        type = "texture",
        layer = "BACKGROUND",
        color = "0e0e0e"
    },
    ["track-outline"] = {
        type = "outline",
        layer = "BORDER",
        color = "060606"
    },
    ["grip-background"] = {
        type = "texture",
        layer = "BACKGROUND",
        gradient = "HORIZONTAL",
        color = "5d5d5d",
        colorEnd = "252525"
    },
    ["grip-outline"] = {
        type = "outline",
        layer = "BORDER",
        color = "060606"
    }
}

-- Window creators
function meta.ui:createWindow(name, width, height, title, color, messageWindow)
    if title == nil then
        title = name
    end
    if color == nil then
        color = meta.classColor
    end
    local window = DiesalGUI:Create("Window")
    window.initializing = true
    window:SetTitle("|c" .. color .. "Meta", title)
    window.settings.width = width or 250
    window.settings.height = height or 250
    window.settings.header = true
    window.settings.footer = true
    window.frame:SetClampedToScreen(true)
    window:ApplySettings()

    window.closeButton:SetScript("OnClick", function(this, button)
        -- br.ui:savePosition(name)
        -- br.data.settings[br.selectedSpec][name]["active"] = false
        DiesalGUI:OnMouse(this, button)
        PlaySound(799)
        window:FireEvent("OnClose")
        window:Hide()
    end)

    window.rotations = DiesalGUI:Create("Dropdown")
    window.rotations:SetParent(window.titleBar)
    window.rotations:SetPoint("TOPRIGHT", window.closeButton, "TOPLEFT", 0, -2)
    window.rotations:SetPoint("BOTTOMRIGHT", window.closeButton, "BOTTOMLEFT", 0, -0.5)
    window.titletext:SetPoint("TOPRIGHT", window.rotations.frame, "TOPLEFT")
    window.rotations:SetHeight(window.titleBar:GetHeight())
    window.rotations:EnableMouse(false)

    window.dropdown = DiesalGUI:Create("Dropdown")
    window.dropdown:SetParent(window.header)
    window.dropdown:SetPoint("TOPLEFT", window.header, "TOPLEFT", 40, 0)
    window.dropdown:SetPoint("TOPRIGHT", window.header, "TOPRIGHT", -40, 0)
    window.dropdown:SetHeight(window.header:GetHeight())
    window.dropdown:Hide()

    local function AddListItem(self, item)
        local dropdownItem = DiesalGUI:Create("DropdownItem")
        self:AddChild(dropdownItem)
        dropdownItem:SetParentObject(self)
        dropdownItem:SetSettings({
            key = #self.children,
            value = item,
            position = #self.children
        }, true)
        self:ApplySettings()
        self:SetJustifyH("CENTER")
        return #self.children
    end

    local function RemoveListItem(self, item)
        window.initializing = true
        for key, child in pairs(self.children) do
            if child.settings.value == item then
                self:ReleaseChild(child)
                if key == window.current_page then
                    if window.current_page - 1 > 0 then
                        window.current_page = window.current_page - 1
                    else
                        window.current_page = 1
                    end
                    for _, child in pairs(window.children) do
                        child:Hide()
                    end
                    window.children[window.current_page]:Show()
                    self:SetValue(window.current_page)
                end
                break
            end
        end
        self:ApplySettings()
        for _, child in pairs(window.children) do
            if child.title == item then
                child:ReleaseChildren()
                window:ReleaseChild(child)
                break
            end
        end
        if #window.children < 2 then
            window.dropdown:Hide()
            window.rightArrow:Hide()
            window.leftArrow:Hide()
        end
        window.initializing = false
    end

    window.dropdown.AddListItem = AddListItem
    window.dropdown.RemoveListItem = RemoveListItem
    window.rotations.AddListItem = AddListItem

    window.createPage = function(name)
        local scrollFrame
        if messageWindow == nil or messageWindow == false then
            scrollFrame = DiesalGUI:Create("ScrollFrame")
        elseif messageWindow == true then
            scrollFrame = DiesalGUI:Create("ScrollingMessageFrame")
            scrollFrame:SetStylesheet(messageStylesheet)
        end
        window:AddChild(scrollFrame)
        scrollFrame:SetParent(window.content)
        scrollFrame:SetAllPoints(window.content)
        scrollFrame.parent = window
        scrollFrame.title = name
        scrollFrame.index = #window.children
        window.dropdown:AddListItem(name)
        scrollFrame:Hide()
        scrollFrame:Hide()
        if scrollFrame.index == 1 then
            window.dropdown:SetValue(1)
            scrollFrame:Show()
        elseif scrollFrame.index > 1 then
            if not window.dropdown:IsShown() then
                window.dropdown:Show()
                window.rightArrow:Show()
                window.leftArrow:Show()
            end
            if window.current_page == scrollFrame.index then
                window.dropdown:SetValue(scrollFrame.index)
                for _, child in pairs(window.children) do
                    child:Hide()
                end
                window.children[scrollFrame.index]:Show()
            end
        end
        return scrollFrame
    end
    
    window.leftArrow = meta.ui:createLeftArrow(window.header)
    window.rightArrow = meta.ui:createRightArrow(window.header)
    window.leftArrow:Hide()
    window.rightArrow:Hide()
    

    window.current_page = window.current_page or 1

    local function page_callback(right)
        if window.initializing then
            return
        end
        window.children[window.current_page]:Hide()
        local idx = 0
        if (right and window.current_page + 1 > #window.children) or (not right and window.current_page - 1 == 0) then
            idx = right and 1 or #window.children
            window.children[idx]:Show()
        else
            idx = right and window.current_page + 1 or window.current_page - 1
            window.children[idx]:Show()
        end
        window.current_page = idx
        window.dropdown:SetValue(idx)
    end

    window.dropdown:SetEventListener("OnValueChanged", function(self, event, key, value, table)
        if window.initializing then
            return
        end
        if key and window.current_page ~= key and window.current_page <= #self.children then
            window.children[window.current_page]:Hide()
            window.children[key]:Show()
            window.current_page = key
        end
    end)

    window.leftArrow:SetEventListener("OnClick", function()
        page_callback(true)
    end)
    window.rightArrow:SetEventListener("OnClick", function()
        page_callback(false)
    end)
    return window
end

-- Load saved position
-- function br.ui:loadWindowPositions(thisWindow)
--     local scrollFrame = br.ui.window[thisWindow]
--     if scrollFrame == nil then
--         return
--     end
--     if br.data.settings[br.selectedSpec] == nil then
--         br.data.settings[br.selectedSpec] = {}
--     end
--     if br.data.settings[br.selectedSpec][thisWindow] == nil then
--         br.data.settings[br.selectedSpec][thisWindow] = {}
--     end
--     local windows = br.data.settings[br.selectedSpec][thisWindow]
--     if windows["point"] ~= nil then
--         local point, relativeTo = windows["point"], windows["relativeTo"]
--         local relativePoint = windows["relativePoint"]
--         local xOfs, yOfs = windows["xOfs"], windows["yOfs"]
--         scrollFrame.parent:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs)
--     end
--     if windows["point2"] ~= nil then
--         local point, relativeTo = windows["point2"], windows["relativeTo2"]
--         local relativePoint = windows["relativePoint2"]
--         local xOfs, yOfs = windows["xOfs2"], windows["yOfs2"]
--         scrollFrame.parent:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs)
--     end
--     if windows["width"] and windows["height"] then
--         scrollFrame.parent:SetWidth(windows["width"])
--         scrollFrame.parent:SetHeight(windows["height"])
--     end
-- end

-- function br.ui:checkWindowStatus(windowName)
--     if br.data.settings[br.selectedSpec][windowName] == nil then
--         br.data.settings[br.selectedSpec][windowName] = {}
--     end
--     local windows = br.data.settings[br.selectedSpec][windowName]
--     if windows["active"] == true or windows["active"] == nil then
--         if br.ui.window[windowName].parent then
--             br.ui.window[windowName].parent:Show()
--             return
--         end
--     else
--         if br.ui.window[windowName].parent then
--             br.ui.window[windowName].parent:Hide() --.closeButton:Click()
--             return
--         end
--     end
-- end

-- function br.ui:savePosition(windowName)
--     if br.data.settings[br.selectedSpec] == nil then
--         br.data.settings[br.selectedSpec] = {}
--     end
--     if br.data.settings[br.selectedSpec][windowName] == nil then
--         br.data.settings[br.selectedSpec][windowName] = {}
--     end
--     if br.ui.window[windowName] ~= nil then
--         if br.ui.window[windowName].parent ~= nil then
--             local point, relativeTo, relativePoint, xOfs, yOfs = br.ui.window[windowName].parent:GetPoint(1)
--             br.data.settings[br.selectedSpec][windowName]["point"] = point
--             br.data.settings[br.selectedSpec][windowName]["relativeTo"] = relativeTo:GetName()
--             br.data.settings[br.selectedSpec][windowName]["relativePoint"] = relativePoint
--             br.data.settings[br.selectedSpec][windowName]["xOfs"] = xOfs
--             br.data.settings[br.selectedSpec][windowName]["yOfs"] = yOfs
--             point, relativeTo, relativePoint, xOfs, yOfs = br.ui.window[windowName].parent:GetPoint(2)
--             if point then
--                 br.data.settings[br.selectedSpec][windowName]["point2"] = point
--                 br.data.settings[br.selectedSpec][windowName]["relativeTo2"] = relativeTo:GetName()
--                 br.data.settings[br.selectedSpec][windowName]["relativePoint2"] = relativePoint
--                 br.data.settings[br.selectedSpec][windowName]["xOfs2"] = xOfs
--                 br.data.settings[br.selectedSpec][windowName]["yOfs2"] = yOfs
--             end
--             br.data.settings[br.selectedSpec][windowName]["width"] = br.ui.window[windowName].parent:GetWidth()
--             br.data.settings[br.selectedSpec][windowName]["height"] = br.ui.window[windowName].parent:GetHeight()
--         end
--     end
-- end

-- function br.ui:saveWindowPosition()
--     for k, _ in pairs(br.ui.window) do
--         if br.ui.window[k].parent ~= nil then
--             br.ui:savePosition(k)
--         end
--     end
-- end

-- function br.ui:showWindow(windowName)
--     for k, _ in pairs(br.ui.window) do
--         if k == windowName then
--             if br.ui.window[k].parent ~= nil then
--                 br.ui.window[k].parent:Show()
--                 br.data.settings[br.selectedSpec][k].active = true
--             end
--         end
--     end
-- end

-- function br.ui:closeWindow(windowName)
--     for k, _ in pairs(br.ui.window) do
--         if k == windowName or windowName == "all" then
--             if br.ui.window[k].parent ~= nil then
--                 if k == windowName then
--                     br.ui.window[k].parent.closeButton:Click()
--                     break
--                 else
--                     for l, w in pairs(br.data.settings) do
--                         if
--                             br.data.settings[tostring(l)] ~= nil and type(w) ~= "string" and type(w) ~= "number" and
--                                 type(w) ~= "boolean"
--                          then
--                             for m, _ in pairs(br.data.settings[tostring(l)]) do
--                                 if m == k then
--                                     if
--                                         br.data.settings[br.selectedSpec].toggles ~= nil and
--                                             br.data.settings[br.selectedSpec].toggles["Power"] ~= 1
--                                      then
--                                         if br.data.settings[l][m].active == nil or br.data.settings[l][m].active then
--                                             br.ui.window[k].parent.closeButton:Click()
--                                             br.data.settings[l][m].active = false
--                                         end
--                                     elseif br.data.settings[l][m].active == nil or br.data.settings[l][m].active then
--                                         br.ui.window[k].parent.closeButton:Click()
--                                         br.data.settings[l][m].active = false
--                                     end
--                                 end
--                             end
--                         end
--                     end
--                 end
--             end
--         end
--     end
-- end

-- function br.ui:toggleWindow(windowName)
--     for k, _ in pairs(br.ui.window) do
--         if k == windowName then
--             if br.ui.window[k].parent ~= nil then
--                 if br.data.settings[br.selectedSpec][k] ~= nil then
--                     if br.data.settings[br.selectedSpec][k].active == nil then
--                         br.ui.window[k].parent:Show()
--                         br.data.settings[br.selectedSpec][k].active = true
--                     elseif br.data.settings[br.selectedSpec][k].active then
--                         br.ui.window[k].parent.closeButton:Click()
--                         br.data.settings[br.selectedSpec][k].active = false
--                     else
--                         br.ui.window[k].parent:Show()
--                         br.data.settings[br.selectedSpec][k].active = true
--                     end
--                 end
--             end
--         end
--     end
-- end

-- function br.ui:recreateWindows()
--     br.ui:closeWindow("all")
--     br.ui:createConfigWindow()
--     br.ui:createDebugWindow()
-- end
