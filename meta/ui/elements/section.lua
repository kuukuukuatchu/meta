local DiesalGUI = _G.LibStub("DiesalGUI-1.1")
local meta = ...
meta.ui = meta.ui or {}

function meta.ui:createSection(parent, sectionName, tooltip, settings)
    local newSection = DiesalGUI:Create("AccordianSection")
    settings = settings or {}
    newSection:SetParentObject(parent)
    newSection:ClearAllPoints()
    -- Calculate Position
    if #parent.children == nil then
        newSection.settings.position = 1
    else
        newSection.settings.position = #parent.children + 1
    end
    newSection.settings.sectionName = sectionName
    -- if br.data.settings[br.selectedSpec][br.selectedProfile] == nil then
    --     br.data.settings[br.selectedSpec][br.selectedProfile] = {}
    -- end
    newSection.settings.expanded = true
        -- br.data.settings[br.selectedSpec][br.selectedProfile][sectionName .. "Section"] or true
    -- newSection.settings.contentPadding = {0,0,12,32}

    newSection:SetEventListener(
        "OnStateChange",
        function(this, event)
            -- br.data.settings[br.selectedSpec][br.selectedProfile][sectionName .. "Section"] =
            --     newSection.settings.expanded
        end
    )
    -- Event: Tooltip
    if tooltip then
        newSection:SetEventListener(
            "OnEnter",
            function(this, event)
               GameTooltip:SetOwner(Minimap, "ANCHOR_CURSOR", 50, 50)
               GameTooltip:SetText(tooltip, 214 / 255, 25 / 255, 25 / 255)
               GameTooltip:Show()
            end
        )
        newSection:SetEventListener(
            "OnLeave",
            function(this, event)
               GameTooltip:Hide()
            end
        )
    end

    newSection:ApplySettings()

    newSection["UpdateHeight"] = function(self)
        local settings, children = self.settings, self.children
        local contentHeight = 0
        self.content:SetPoint("TOPLEFT", self.frame, 0, settings.button and -settings.buttonHeight or 0)

        if settings.expanded then
            contentHeight = settings.contentPadding[3] + settings.contentPadding[4]
            for _, child in ipairs(children) do
                if child.type ~= "Spinner" and child.type ~= "Dropdown" then
                    contentHeight = contentHeight + child.frame:GetHeight() * 1.2
                end
            end
        end
        self.content:SetHeight(contentHeight)
        self:SetHeight((settings.button and settings.buttonHeight or 0) + contentHeight)
        self:FireEvent("OnHeightChange", contentHeight)
    end

    newSection:UpdateHeight()

    parent:AddChild(newSection)

    return newSection
end

-- Restore last saved state of section (collapsed or expanded)
-- function meta.ui:checkSectionState(section)
--     -- local state = br.data.settings[br.selectedSpec][br.selectedProfile][section.settings.sectionName .. "Section"]
--     local state

--     if state then
--         section:Expand()
--         section:UpdateHeight(section)
--     else
--         section:Collapse()
--     end
-- end
