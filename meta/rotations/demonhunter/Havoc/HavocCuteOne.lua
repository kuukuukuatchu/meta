local function rotation()
--------------------------
--- Havoc: CuteOne ---
--------------------------
	local function cancelRushAnimation()
        if cast.check(felRush) then
            MoveBackwardStart()
            JumpOrAscendStart()
            cast.felRush()
            MoveBackwardStop()
            AscendStop()
        end
        return
    end

	if unit.valid('target') then
	-- Start Attack
        -- actions=auto_attack
        startAttack()
    -- Fel Rush
    	-- fel_rush,animation_cancel=1,if=!talent.momentum.enabled&raid_event.movement.in>charges*10
    	if cast.check(felRush) and unit.facing('player','target',10) and not talent.momentum then
    		if unit.distance('target') >= 10 then
    			cast.felRush()
    		else
    			cancelRushAnimation()
    		end
    	end
	-- Demon's Bite
        -- demons_bite
        if cast.check(demonsBite) then
        	cast.demonsBite()
        end
    -- Throw Glaive
        -- throw_glaive,if=buff.out_of_range.up
        if cast.check(throwGlaive) and unit.distance('target') >= 15 then
        	cast.throwGlaive()
        end
    -- Felblade
    	-- felblade,if=movement.distance|buff.out_of_range.up
    	if cast.check(felblade) and unit.distance('target') >= 15 then
    		cast.felblade()
    	end
    -- Fel Rush
    	--fel_rush,if=movement.distance>15|(buff.out_of_range.up&!talent.momentum.enabled)
    	if cast.check(felRush) and unit.facing('player','target',10) then
    		if unit.distance('target') >= 10 then
    			cast.felRush()
    		else
    			cancelRushAnimation()
    		end
    	end
	end
end

local HavocCuteOne = {
    profileID = 577,
    profileName = "CuteOne",
    rotation = rotation
}

-- Return Profile
return HavocCuteOne