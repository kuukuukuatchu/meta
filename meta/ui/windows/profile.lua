local meta = ...

local window = meta.ui:createWindow("profile", 275, 400, meta.class)
meta.windows.profile = window

for _, page in ipairs(window.children) do
    if page.index == window.current_page then
        page:Show()
    else
        page:Hide()
    end
end

window:Hide()
window.initializing = false
