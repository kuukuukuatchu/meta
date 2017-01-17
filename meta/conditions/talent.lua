-- Required to access other files.
local meta  	= ...
local base 		= require('conditions.base')
local spellList = require('lists.spellList')

-- Init Talent
local talent = { }


-------------------------------------
--- Talent Related Functions Here ---
-------------------------------------

-- Update Talent Info
function talent.info()
    local activeSpecGroup = GetActiveSpecGroup()
    for r = 1, 7 do --search each talent row
        for c = 1, 3 do -- search each talent column
        -- Cache Talent IDs for talent checks
            local _,_,_,selected,_,talentID = GetTalentInfo(r,c,activeSpecGroup)
            -- Compare Row/Column Spell Id to Talent Id List for matches
            for unitClass , classTable in pairs(spellList.idList) do
			    if unitClass == select(2,UnitClass('player')) or unitClass == 'Shared' then
			        for spec, specTable in pairs(classTable) do
			            if spec == GetSpecializationInfo(GetSpecialization()) or spec == 'Shared' then
			                for spellType, spellTypeTable in pairs(specTable) do
			                    if spellType == 'talents' then
			                        for spell, spellID in pairs(spellTypeTable) do
			                        	if spellID == talentID then 
			                        		talent[k] = selected
			                        		if not IsPassiveSpell(spellID) then
			                            		base[spell] = spellID
			                            		castable[spell] = spellID
			                            	end
			                            end
			                        end
			                    end
			                end
			            end
			        end
			    end        
			end
        end
    end
end

-- Update Talent Info on Init and Talent Change
talent.info()

AddEventCallback("PLAYER_TALENT_UPDATE",function()
    talent.info()
end)

-- Return Functions
return talent