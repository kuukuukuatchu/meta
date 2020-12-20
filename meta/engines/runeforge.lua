local meta 		= ...
local base 		= require('conditions.base')
local powerList = require('lists.runeforge')

-- Init Base
local runeforge      = { }
local itemLink

function runeforge.update()
	for i = 1, 19 do
		itemLink = GetInventoryItemLink("player", i)
		if itemLink then
			local leggoID = select(15, strsplit(":", itemLink))
			local powerID = powerList.bonusToPowerId[tonumber(leggoID)]
			if powerID ~= nil then
				local powerInfo = C_LegendaryCrafting.GetRuneforgePowerInfo(powerID)
				-- Print("Legendary Item Effect: "..tostring(powerInfo.name).." found on item: "..tostring(C_Item.GetItemName(item)))
				runeforge[powerInfo.descriptionSpellID] = {
					equiped = true,
					id = powerInfo.descriptionSpellID,
					name = powerInfo.name,
					state = powerInfo.state,
				}
			end
		end
	end
end

runeforge.update()

AddEventCallback("PLAYER_EQUIPMENT_CHANGED", function()
    runeforge.update()
end)

return runeforge