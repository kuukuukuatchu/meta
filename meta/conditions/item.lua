-- Required to access other files.
local meta      = ...

-- Init Item
local item = { }

-----------------------------------
--- Item Related Functions Here ---
-----------------------------------

function item.equiped(ItemID, Slot)
	--Scan Armor Slots to see if specified item was equiped
	local foundItem = false
	for i=1, 19 do
		-- if there is an item in that slot
        if GetInventoryItemID("player", i) ~= nil then
        	-- check if it matches
            if GetInventoryItemID("player", i) == ItemID then
                if i == Slot or Slot == nil then
                    foundItem = true
                    break
                end
            end
        end
    end
	return foundItem;
end

-- Return Functions
return item