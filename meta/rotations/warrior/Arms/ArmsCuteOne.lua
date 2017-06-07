local function rotation()

---------------------
--- Arms: CuteOne ---
---------------------

	-- Action Lists
	local function actionList_Multi()
	-- Mortal Strike
		-- mortal_strike,if=cooldown_react
		if cast.check(mortalStrike) and spell.cd(mortalStrike) == 0 then
			cast.spell(mortalStrike)
		end
	-- Execute
		-- execute,if=buff.stone_heart.react
		if cast.check(execute) and buff.stoneHeart:exists() then
			cast.spell(execute)
		end
	-- Colossus Smash
		-- colossus_smash,if=cooldown_react&buff.shattered_defenses.down&buff.precise_strikes.down
		if cast.check(colossusSmash) and spell.cd(colossusSmash) == 0 and not buff.shatteredDefenses:exists() and not buff.preciseStrikes:exists() then
			cast.spell(colossusSmash)
		end
	-- Warbreaker
		-- warbreaker,if=buff.shattered_defenses.down
		if cast.check(warbreaker) and not buff.shatteredDefenses:exists() then
			cast.spell(warbreaker)
		end
	-- Whirlwind
		-- whirlwind,if=talent.fervor_of_battle.enabled&(debuff.colossus_smash.up|rage.deficit<50)&(!talent.focused_rage.enabled|buff.battle_cry_deadly_calm.up|buff.cleave.up)
		if cast.check(whirlwind) and talent.fervorOfBattle and (debuff.colossusSmash:exists("target") and rage:amount() < 50) 
			and (not talent.focusedRage or (buff.battleCry:exists() and talent.deadlyCalm) or buff.cleave:exists()) 
		then
			cast.spell(whirlwind)
		end
	-- Rend
		-- rend,if=remains<=duration*0.3
		if cast.check(rend) and debuff.rend:refresh("target") then
			cast.spell(rend)
		end
	-- Bladestorm
		-- bladestorm
		if cast.check(bladestorm) then
			cast.spell(bladestorm)
		end
	-- Cleave
		-- cleave
		if cast.check(cleave) then
			cast.spell(cleave)
		end
	-- Execute
		-- execute,if=rage>90
		if cast.check(execute) and rage:amount() > 90 then
			cast.spell(execute)
		end
	-- Whirlwind
		-- whirlwind,if=rage>=40
		if cast.check(whirlwind) and rage:amount() >= 40 then
			cast.spell(whirlwind)
		end
	-- Shockwave
		-- shockwave
		if cast.check(shockwave) then
			cast.spell(shockwave)
		end
	-- Storm Bolt
		-- storm_bolt
		if cast.check(stormBolt) then
			cast.spell(stormBolt)
		end
	end

	local function actionList_Cleave()
	-- Mortal Strike
		-- mortal_strike
		if cast.check(mortalStrike) and spell.cd(mortalStrike) == 0 then
			cast.spell(mortalStrike)
		end
	-- Execute
		-- execute,if=buff.stone_heart.react
		if cast.check(execute) and buff.stoneHeart:exists() then
			cast.spell(execute)
		end
	-- Colossus Smash
		-- colossus_smash,if=buff.shattered_defenses.down&buff.precise_strikes.down
		if cast.check(colossusSmash) and not buff.shatteredDefenses:exists() and not buff.preciseStrikes:exists() then
			cast.spell(colossusSmash)
		end
	-- Warbreaker
		-- warbreaker,if=buff.shattered_defenses.down
		if cast.check(warbreaker) and not buff.shatteredDefenses:exists() then
			cast.spell(warbreaker)
		end
	-- Focused Rage
		-- focused_rage,if=rage>100|buff.battle_cry_deadly_calm.up
		if cast.check(focusedRage) and (rage:amount() > 100 or (buff.battleCry:exists() and talent.deadlyCalm)) then
			cast.spell(focusedRage)
		end 
	-- Whirlwind
		-- whirlwind,if=talent.fervor_of_battle.enabled&(debuff.colossus_smash.up|rage.deficit<50)&(!talent.focused_rage.enabled|buff.battle_cry_deadly_calm.up|buff.cleave.up)
		if cast.check(whirlwind) and talent.fervorOfBattle and (debuff.colossusSmash:exists("target") and rage:amount() < 50) 
			and (not talent.focusedRage or (buff.battleCry:exists() and talent.deadlyCalm) or buff.cleave:exists()) 
		then
			cast.spell(whirlwind)
		end
	-- Rend
		-- rend,if=remains<=duration*0.3
		if cast.check(rend) and debuff.rend:refresh("target") then
			cast.spell(rend)
		end
	-- Bladestorm
		-- bladestorm
		if cast.check(bladestorm) then
			cast.spell(bladestorm)
		end
	-- Cleave
		-- cleave
		if cast.check(cleave) then
			cast.spell(cleave)
		end
	-- Whirlwind
		-- whirlwind,if=rage>40|buff.cleave.up
		if cast.check(whirlwind) and (rage:amount() > 40 or buff.cleave:exists()) then
			cast.spell(whirlwind)
		end
	-- Shockwave
		-- shockwave
		if cast.check(shockwave) then
			cast.spell(shockwave)
		end
	-- Storm Bolt
		-- storm_bolt
		if cast.check(stormBolt) then
			cast.spell(stormBolt)
		end
	end

	local function actionList_Execute()
	-- Mortal Strike
		-- mortal_strike,if=cooldown_react&buff.battle_cry.up&buff.focused_rage.stack=3
		if cast.check(mortalStrike) and spell.cd(mortalStrike) == 0 and buff.battleCry:exists() and buff.focusedRage:stack() == 3 then
			cast.spell(mortalStrike)
		end
	-- Execute
		-- execute,if=buff.battle_cry_deadly_calm.up
		if cast.check(execute) and buff.battleCry:exists() and talent.deadlyCalm then
			cast.spell(execute)
		end
	-- Colossus Smash
		-- colossus_smash,if=cooldown_react&buff.shattered_defenses.down
		if cast.check(colossusSmash) and spell.cd(colossusSmash) == 0 and not buff.shatteredDefenses:exists() then
			cast.spell(colossusSmash) 
		end
	-- Execute
		-- execute,if=buff.shattered_defenses.up&(rage>=17.6|buff.stone_heart.react)
		if cast.check(execute) and buff.shatteredDefenses:exists() and rage:amount() >= 17.6 or buff.stoneHeart:exists() then
			cast.spell(execute)
		end
	-- Mortal Strike
		-- mortal_strike,if=cooldown_react&equipped.archavons_heavy_hand&rage<60|talent.in_for_the_kill.enabled&buff.shattered_defenses.down
		if cast.check(mortalStrike) and spell.cd(mortalStrike) == 0 and (item.equiped(137060) or (talent.inForTheKill and not buff.shatteredDefenses:exists())) then
			cast.spell(mortalStrike)
		end
	-- Execute
		-- execute,if=buff.shattered_defenses.down
		if cast.check(execute) and not buff.shatteredDefenses:exists() then
			cast.spell(execute)
		end
	-- Bladestorm
		-- bladestorm,interrupt=1,if=raid_event.adds.in>90|!raid_event.adds.exists|spell_targets.bladestorm_mh>desired_targets
		if cast.check(bladestorm) and #enemies.inRange("player",8,true) > 2 then
			cast.spell(bladestorm)
		end
	end

	local function actionList_Single()
	-- Colossus Smash
		-- colossus_smash,if=cooldown_react&buff.shattered_defenses.down&(buff.battle_cry.down|buff.battle_cry.up&buff.battle_cry.remains>=gcd|buff.corrupted_blood_of_zakajz.remains>=gcd)
		if cast.check(colossusSmash) and spell.cd(colossusSmash) == 0 and not buff.shatteredDefenses:exists() 
			and (not buff.battleCry:exists() or (buff.battleCry:exists() and buff.battleCry:remain() >= spell.gcd()) 
				or buff.corruptedBloodOfZakajz:remain() >= spell.gcd()) 
		then
			cast.spell(colossusSmash)
		end
	-- Focused Rage
		-- focused_rage,if=!buff.battle_cry_deadly_calm.up&buff.focused_rage.stack<3&!cooldown.colossus_smash.up&(rage>=50|debuff.colossus_smash.down|cooldown.battle_cry.remains<=8)|cooldown.battle_cry.remains<=8&cooldown.battle_cry.remains>0&rage>100
		if cast.check(focusedRage) and (not buff.battleCry:exists() and talent.deadlyCalm) and buff.focusedRage:stack() < 3 and spell.cd(colossusSmash) ~= 0 
			and (rage:amount() >= 50 or not debuff.colossusSmash:exists("target") or spell.cd(battleCry) <= 8) or spell.cd(battleCry) <= 8 and spell.cd(battleCry) > 0 and rage:amount() > 100 
		then
			cast.spell(focusedRage)
		end
	-- Mortal Strike
		-- mortal_strike,if=cooldown.battle_cry.remains>8|!buff.battle_cry.up&buff.focused_rage.stack<3|buff.battle_cry.remains<=gcd
		if cast.check(mortalStrike) and (spell.cd(battleCry) > 8 or not buff.battleCry:exists() and buff.focusedRage:stack() < 3 or buff.battleCry:remain() <= spell.gcd()) then
			cast.spell(mortalStrike) 
		end
	-- Execute
		-- execute,if=buff.stone_heart.react
		if cast.check(execute) and buff.stoneHeart:exits() then
			cast.spell(execute)
		end
	-- Whirlwind
		-- whirlwind,if=spell_targets.whirlwind>1|talent.fervor_of_battle.enabled
		if cast.check(whirlwind) and (#enemies.inRange("player",8,true) > 1 or talent.fervorOfBattle) then
			cast.spell(whirlwind)
		end
	-- Slam
		-- whirlwind,if=spell_targets.whirlwind=1&!talent.fervor_of_battle.enabled
		if cast.check(slam) and #enemies.inRange("player",8,true) == 1 and not talent.fervorOfBattle then
			cast.spell(slam)
		end
	-- Bladestorm
		-- bladestorm,interrupt=1,if=raid_event.adds.in>90|!raid_event.adds.exists|spell_targets.bladestorm_mh>desired_targets
		if cast.check(bladestorm) and #enemies.inRange("player",8,true) > 2 then
			cast.spell(bladestorm)
		end
	end

	local function actionList_Defensive()
	-- Gift of the Naaru
		if cast.check(giftOfTheNaaru) and unit.hp("player") <= 60 and unit.race == "Draenei" and spell.cd(giftOfTheNaaru) == 0 then
			cast.spell(giftOfTheNaaru)
		end
	-- Commanding Shout
		if cast.check(commandingShout) and unit.hp("player") <= 40 and unit.combat("player") then
			cast.spell(commandingShout)
		end
	-- Defensive Stance
        if cast.check(defensiveStance) then
            if unit.hp("player") <= 35 and not buff.defensiveStance:exists() then
                cast.spell(defensiveStance)
            elseif buff.defensiveStance:exists() then
                cast.spell(defensiveStance)
            end
        end
    -- Die By The Sword
        if cast.check(dieByTheSword) and unit.combat("player") and unit.hp("player") <= 40 then
            cast.spell(dieByTheSword)
        end
    -- Intimidating Shout
        if cast.check(intimidatingShout) and unit.combat("player") and unit.hp("player") <= 35 then
            cast.spell(intimidatingShout)
        end
    -- Shockwave
        if cast.check(shockwave) and unit.combat("player") and (unit.hp("player") <= 45 or #enemies.inRange("player",8,true) >= 3) then
            cast.spell(shockwave)
        end
    -- Storm Bolt
        if cast.check(stormBolt) and unit.combat("player") and unit.hp("player") <= 45 then
            cast.spell(stormBolt)
        end
    -- Victory Rush
        if cast.check(victoryRush) and unit.combat("player") and unit.hp("player") <= 80 and buff.victorious:exists() then
            cast.spell(victoryRush)
        end
	end

	local function actionList_Interrupt()
		for i=1, #enemies.inRange("player",40,true) do
			thisUnit = enemies.inRange("player",40,true)[i]
			if spell.canInterrupt(thisUnit) then
			-- Pummel
                if cast.check(pummel) and unit.distance("player") < 5 then
                    cast.spell(pummel,thisUnit)
                end
            end
        end
	end

	-- Begin Rotation
	actionList_Defensive()
	if unit.valid('target') then
		actionList_Interrupt()
	-- Charge
		-- charge
		if cast.check(charge) then
			cast.spell(charge)
		end
	-- Auto Attack
		-- auto_attack
		if not IsCurrentSpell(6603) and unit.distance("target") < 5 then
			StartAttack()
		end
	-- Potion
		-- potion,name=old_war,if=buff.avatar.up&buff.battle_cry.up&debuff.colossus_smash.up|target.time_to_die<=26
	-- Blood Fury
		-- blood_fury,if=buff.battle_cry.up|target.time_to_die<=16
	-- Berserking
		-- berserking,if=buff.battle_cry.up|target.time_to_die<=11
	-- Arcane Torrent
		-- arcane_torrent,if=buff.battle_cry_deadly_calm.down&rage.deficit>40&cooldown.battle_cry.remains
	-- Battle Cry
		-- battle_cry,if=gcd.remains<0.25&cooldown.avatar.remains>=10&(buff.shattered_defenses.up|cooldown.warbreaker.remains>7&cooldown.colossus_smash.remains>7|cooldown.colossus_smash.remains&debuff.colossus_smash.remains>gcd)|target.time_to_die<=7
		if cast.check(battleCry) and spell.gcd() < 0.25 and spell.cd(avatar) >= 10 
			and (buff.shatteredDefenses:exists() or spell.cd(warbreaker) > 7 and spell.cd(colossusSmash) > 7 
				or spell.cd(colossusSmash) > 0 and debuff.colossusSmash:remain("target") > spell.gcd())
			and unit.distance("target") < 5 
		then
			cast.spell(battleCry)
		end
	-- Avatar
		-- avatar,if=gcd.remains<0.25&(buff.battle_cry.up|cooldown.battle_cry.remains<15)|target.time_to_die<=20
		if cast.check(avatar) and spell.gcd() < 0.25 and (buff.battleCry:exists() or spell.cd(battleCry) < 15) and unit.distance("target") < 5 then
			cast.spell(avatar)
		end
	-- Ring of Collapsing Futures
		-- use_item,name=ring_of_collapsing_futures,if=buff.battle_cry.up&debuff.colossus_smash.up&!buff.temptation.up
	-- Draught of Souls
		-- use_item,name=draught_of_souls,if=equipped.draught_of_souls&((prev_gcd.1.mortal_strike|cooldown.mortal_strike.remains>=3)&buff.battle_cry.remains>=3&debuff.colossus_smash.up&buff.avatar.remains>=3)
	-- Heroic Leap
		-- heroic_leap,if=(debuff.colossus_smash.down|debuff.colossus_smash.remains<2)&cooldown.colossus_smash.remains&equipped.weight_of_the_earth|!equipped.weight_of_the_earth&debuff.colossus_smash.up
		if cast.check(heroicLeap) and (not debuff.colossusSmash:exists("target") or debuff.colossusSmash:remain("target") < 2) 
			and spell.cd(colossusSmash) > 0 and item.equiped(137077) or not item.equiped(137077) and debuff.colossusSmash:exists("target") 
		then
			cast.spell(heroicLeap,"target")
		end 
	-- Rend
		-- rend,if=remains<gcd
		if cast.check(rend) and debuff.rend:remain("target") < spell.gcd() then
			cast.spell(rend)
		end
	-- Focused Rage
		-- focused_rage,if=buff.battle_cry_deadly_calm.remains>cooldown.focused_rage.remains&(buff.focused_rage.stack<3|cooldown.mortal_strike.remains)
		if cast.check(focusedRage) and buff.battleCry:remain() > spell.cd(focusedRage) and talent.deadlyCalm and (buff.focusedRage:stack() < 3 or spell.cd(mortalStrike) > 0) then
			cast.spell(focusedRage)
		end
	-- Colossus Smash
		-- colossus_smash,if=cooldown_react&debuff.colossus_smash.remains<gcd
		if cast.check(colossusSmash) and spell.cd(colossusSmash) == 0 and debuff.colossusSmash:remain("target") < spell.gcd() then
			cast.spell(colossusSmash)
		end
	-- Warbreaker
		-- warbreaker,if=debuff.colossus_smash.remains<gcd
		if cast.check(warbreaker) and debuff.colossusSmash:remain("target") < spell.gcd() and unit.distance("target") < 5 then
			cast.spell(warbreaker)
		end
	-- Ravager
		-- ravager
		if cast.check(ravager) then
			cast.spell(ravager)
		end
	-- Overpower
		-- overpower,if=buff.overpower.react
		if cast.check(overpower) and buff.overpower:exists() then
			cast.spell(overpower)
		end
	-- Action List - Cleave Target
		-- run_action_list,name=cleave,if=spell_targets.whirlwind>=2&talent.sweeping_strikes.enabled
		if #enemies.inRange("player",8,true) >= 2 and talent.sweepingStrikes then
			actionList_Cleave()
		end
	-- Action List - Multi Target
		-- run_action_list,name=aoe,if=spell_targets.whirlwind>=5&!talent.sweeping_strikes.enabled
		if #enemies.inRange("player",8,true) >= 5 and not talent.sweepingStrikes then
			actionList_Multi()
		end
	-- Action List - Execute Target
		-- run_action_list,name=execute,target_if=target.health.pct<=20&spell_targets.whirlwind<5
		if unit.hp("target") <= 20 and #enemies.inRange("player",8,true) < 5 then
			actionList_Execute()
		end
	-- Action List - Single Target
		-- run_action_list,name=single,if=target.health.pct>20
		if unit.hp("target") > 20 then
			actionList_Single()
		end
	end
end

local ArmsCuteOne = {
    profileID = 71,
    profileName = "CuteOne",
    rotation = rotation
}

-- Return Profile
return ArmsCuteOne