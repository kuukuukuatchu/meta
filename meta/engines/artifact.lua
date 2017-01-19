local meta 		= ...
local base 		= require('conditions.base')
local spellList = require('lists.spellList')

-- Init Base
local artifact      = { }
local LAD 			= LibStub("LibArtifactData-1.0")

function artifact.hasPerk(spellID)
	if artifact ~= nil then
		if artifact.info ~= nil then
			if artifact.info.traits ~= nil then
				for i = 1, #artifact.info.traits do
					if spellID == artifact.info.traits[i]['spellID'] then
						return true
					end
				end
			end
		end
	end
	return false
end

function artifact.perkRank(spellID)
    if artifact ~= nil then
        if artifact.info ~= nil then
            if artifact.info.traits ~= nil then
                for i=1, #artifact.info.traits do
                    if spellID == artifact.info.traits[i]["spellID"] then
                        return artifact.info.traits[i]["currentRank"]
                    end
                end
            end
        end
    end
    return 0
end

function artifact.update()
    local artifactId 	= select(1,C_ArtifactUI.GetEquippedArtifactInfo())
    local _, data 		= LAD:GetArtifactInfo(artifactId)
    artifact.id 		= artifactId
    artifact.info 		= data
    for unitClass , classTable in pairs(spellList.idList) do
	    if unitClass == select(2,UnitClass('player')) or unitClass == 'Shared' then
	        for spec, specTable in pairs(classTable) do
	            if spec == GetSpecializationInfo(GetSpecialization()) or spec == 'Shared' then
	                for spellType, spellTypeTable in pairs(specTable) do
	                    if spellType == 'artifacts' then
	                        for spell, spellID in pairs(spellTypeTable) do
	                            artifact[spell] 		= artifact.hasPerk(spellID)
	                            if artifact.rank == nil then artifact.rank = {} end
	                            artifact.rank[spell] 	= artifact.perkRank(spellID)
	                            if not IsPassiveSpell(spellID) then
	                        		base[spell] 		= spellID
	                        		castable[spell] 	= spellID
	                        	end
	                        end
	                    end
	                end
	            end
	        end
	    end        
	end
end

artifact.update()

AddEventCallback("ARTIFACT_ADDED", function()
    artifact.update()
end)
AddEventCallback("ARTIFACT_EQUIPPED_CHANGED", function()
    artifact.update()
end)
AddEventCallback("ARTIFACT_DATA_MISSING", function()
    artifact.update()
end)
AddEventCallback("ARTIFACT_RELIC_CHANGED", function()
    artifact.update()
end)
AddEventCallback("ARTIFACT_TRAITS_CHANGED", function()
    artifact.update()
end)

return artifact