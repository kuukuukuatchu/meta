local meta = ...

meta.update = {}
local update_handlers = {}
local handler_count = 0

local total_elapsed = 0;
local function update_handler(self, elapsed, ...)
    local throttle = 20 / 1000
    total_elapsed = total_elapsed + elapsed
    self.st = elapsed + (self.st or 0)
    if self.st < throttle then
        return
    end
    total_elapsed = total_elapsed - throttle
    self.st = 0
    for i = 1, handler_count do
        if update_handlers[i](elapsed, ...) then
            return
        end
    end
end

function meta.update.register_callback(func, idx)
    for i = 0, handler_count do
        if update_handlers[i] == func then
            error("Handler already exists in table!")
            return
        end
    end
    if idx then
        tinsert(update_handlers, idx, func)
    else
        tinsert(update_handlers, func)
    end
    handler_count = #update_handlers
end

function meta.update.unregister_callback(func)
    for i = 0, handler_count do
        if update_handlers[i] == func then
            tremove(update_handlers, i)
            handler_count = #update_handlers
        end
    end
end

-- function update.initialize()
    meta.frame:SetScript("OnUpdate", update_handler)
-- end