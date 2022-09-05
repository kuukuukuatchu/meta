local meta 		= ...
local base 		= require('conditions.base')
local events    = meta.events

-- Init Base
local covenant      = { }

local covenantTable = {
	[1] = "Kyrian",
	[2] = "Venthyr",
	[3] = "NightFae",
	[4] = "Necrolord"
}

function covenant.update()
	local covenantId 	= C_Covenants.GetActiveCovenantID()
	local current = covenantTable[covenantId]
	if current ~= nil  then
		covenant.active = current
	end
end

covenant.update()

events.register_callback("COVENANT_CHOSEN", function()
    covenant.update()
end)

return covenant