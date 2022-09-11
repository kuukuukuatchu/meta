local meta = ...

local events = {}


-- Table to store the registered event handlers
local event_handlers = {}
-- Creating for count to prevent lookup time of the table length
local function event_handler(self, event, ...)
    local handlers = event_handlers[event]
    if handlers then
        for _, handler in ipairs(handlers) do
            handler(event, ...)
        end
    end
end

function events.register_callback(event, func)
    local handlers = event_handlers[event]
    if handlers then
        for _, handler in ipairs(handlers) do
            if func == handler then
                error("Handler already exists in table!")
                return
            end
        end
    else
        event_handlers[event] = {}
    end
    meta.frame:RegisterEvent(event)
    tinsert(event_handlers[event], func)
end

function events.unregister_callback(event, func)
    local handlers = event_handlers[event]
    if handlers then
        for key, handler in ipairs(handlers) do
            if handler == func then
                tremove(event_handlers[event], key)
                return
            end
        end
    end
end

--[[--
Initializes the event handler to be used.
]]
-- function events.initialize()
    meta.frame:SetScript("OnEvent", event_handler)
-- end

return events
