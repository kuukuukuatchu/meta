local meta 		= ...
local base 		= require('conditions.base')

-- Init Base
local conduit      = { }

function conduit.update()
    local soulbindID = C_Soulbinds.GetActiveSoulbindID()
    local soulbindData = C_Soulbinds.GetSoulbindData(soulbindID)
    for _, node in pairs(soulbindData.tree.nodes) do
        local conduitID = C_Soulbinds.GetInstalledConduitID(node.ID)
        if conduitID > 0 then
            local collectionData = C_Soulbinds.GetConduitCollectionData(conduitID)
            if collectionData.conduitID > 0 then
                local spellID = C_Soulbinds.GetConduitSpellID(collectionData.conduitID, collectionData.conduitRank)
                local spellName, spellRank, spellIcon = GetSpellInfo(spellID)
				conduit[spellID] = {
					state = node.state,
					icon = spellIcon,
					row = node.row,
					conduitID = collectionData.conduitID,
					name = spellName,
					rank = spellRank,
					id = spellID,
					enabled = true;
				}
            end
        end
    end
end

conduit.update()

AddEventCallback("SOULBIND_ACTIVATED", function()
    conduit.update()
end)
AddEventCallback("SOULBIND_CONDUIT_COLLECTION_REMOVED", function()
    conduit.update()
end)
AddEventCallback("SOULBIND_CONDUIT_COLLECTION_UPDATED", function()
    conduit.update()
end)
AddEventCallback("SOULBIND_CONDUIT_INSTALLED", function()
    conduit.update()
end)
AddEventCallback("SOULBIND_CONDUIT_UNINSTALLED", function()
    conduit.update()
end)
return conduit