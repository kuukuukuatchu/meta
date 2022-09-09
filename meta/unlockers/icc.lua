--------------------------------------------------------------------------------------------------------------------------------
-- unlockList
--------------------------------------------------------------------------------------------------------------------------------
local unlockList =
{
	"AcceptBattlefieldPort",
	"AcceptProposal",
	"AcceptTrade",
	"AscendStop",
	"AssistUnit",
	"AttackTarget",
	"CameraOrSelectOrMoveStart",
	"CameraOrSelectOrMoveStop",
	"CancelItemTempEnchantment",
	"CancelLogout",
	"CancelShapeshiftForm",
	"CancelUnitBuff",
	"CanSummonFriend",
	"CastPetAction",
	"CastShapeshiftForm",
	"CastSpell",
	"CastSpellByID",
	"CastSpellByName",
	"ChangeActionBarPage",
	"CheckInteractDistance",
	"ClearOverrideBindings",
	"ClearTarget",
	"CombatTextSetActiveUnit",
	"CopyToClipboard",
	"CreateMacro",
	"DeleteCursorItem",
	"DeleteMacro",
	"DemoteAssistant",
	"DescendStop",
	"DestroyTotem",
	"DropItemOnUnit",
	"FocusUnit",
	"FollowUnit",
	"ForceQuit",
	"GetDefaultLanguage",
	"GetPartyAssignment",
	"GetPlayerInfoByGUID",
	"GetRaidTargetIndex",
	"GetReadyCheckStatus",
	"GetUnitName",
	"GetUnitSpeed",
	"GetUnscaledFrameRect",
	"GuildControlSetRank",
	"GuildControlSetRankFlag",
	"GuildDemote",
	"GuildPromote",
	"GuildUninvite",
	"InitiateTrade",
	"InteractUnit",
	"IsItemInRange",
	"IsSpellInRange",
	"JoinBattlefield",
	"JumpOrAscendStart",
	"Logout",
	"MoveBackwardStart",
	"MoveBackwardStop",
	"MoveForwardStart",
	"MoveForwardStop",
	"PetAssistMode",
	"PetAttack",
	"PetDefensiveAssistMode",
	"PetDefensiveMode",
	"PetFollow",
	"PetPassiveMode",
	"PetStopAttack",
	"PetWait",
	"PickupAction",
	"PickupCompanion",
	"PickupMacro",
	"PickupPetAction",
	"PickupSpell",
	"PickupSpellBookItem",
	"PitchDownStart",
	"PitchDownStop",
	"PitchUpStart",
	"PromoteToAssistant",
	"Quit",
	"ReplaceEnchant",
	"ReplaceTradeEnchant",
	"RunMacro",
	"RunMacroText",
	"SendChatMessage",
	"SetBinding",
	"SetBindingClick",
	"SetBindingItem",
	"SetBindingMacro",
	"SetBindingSpell",
	"SetCurrentTitle",
	"SetMoveEnabled",
	"SetOverrideBinding",
	"SetOverrideBindingClick",
	"SetOverrideBindingItem",
	"SetOverrideBindingMacro",
	"SetOverrideBindingSpell",
	"SetPortraitTexture",
	"SetRaidTarget",
	"SetTurnEnabled",
	"ShowUIPanel",
	"SitStandOrDescendStart",
	"SpellCanTargetUnit",
	"SpellIsTargeting",
	"SpellStopCasting",
	"SpellStopTargeting",
	"SpellTargetItem",
	"SpellTargetUnit",
	"StartAttack",
	"StrafeLeftStart",
	"StrafeLeftStop",
	"StrafeRightStart",
	"StrafeRightStop",
	"Stuck",
	"SummonFriend",
	"SwapRaidSubgroup",
	"TargetLastEnemy",
	"TargetLastTarget",
	"TargetNearestEnemy",
	"TargetNearestFriend",
	"TargetUnit",
	"ToggleAutoRun",
	"ToggleGameMenu",
	"ToggleRun",
	"ToggleSpellAutocast",
	"TurnLeftStart",
	"TurnLeftStop",
	"TurnOrActionStart",
	"TurnOrActionStop",
	"TurnRightStart",
	"TurnRightStop",
	"UninviteUnit",
	"UnitAffectingCombat",
	"UnitArmor",
	"UnitAttackPower",
	"UnitAttackSpeed",
	"UnitAura",
	"UnitAuraSlots",
	"UnitBuff",
	"UnitCanAssist",
	"UnitCanAttack",
	"UnitCanCooperate",
	"UnitCastingInfo",
	"UnitChannelInfo",
	"UnitClass",
	"UnitClassification",
	"UnitCreatureFamily",
	"UnitCreatureType",
	"UnitDamage",
	"UnitDebuff",
	"UnitDetailedThreatSituation",
	"UnitExists",
	"UnitGetIncomingHeals",
	"UnitGetTotalHealAbsorbs",
	"UnitGroupRolesAssigned",
	"UnitGUID",
	"UnitHealth",
	"UnitHealthMax",
	"UnitInBattleground",
	"UnitInParty",
	"UnitInRaid",
	"UnitInRange",
	"UnitIsAFK",
	"UnitIsCharmed",
	"UnitIsConnected",
	"UnitIsCorpse",
	"UnitIsDead",
	"UnitIsDeadOrGhost",
	"UnitIsDND",
	"UnitIsEnemy",
	"UnitIsFeignDeath",
	"UnitIsFriend",
	"UnitIsGhost",
	"UnitIsInMyGuild",
	"UnitIsPlayer",
	"UnitIsPossessed",
	"UnitIsPVP",
	"UnitIsPVPFreeForAll",
	"UnitIsPVPSanctuary",
	"UnitIsSameServer",
	"UnitIsTrivial",
	"UnitIsUnit",
	"UnitIsVisible",
	"UnitLevel",
	"UnitName",
	"UnitOnTaxi",
	"UnitPhaseReason",
	"UnitPlayerControlled",
	"UnitPlayerOrPetInParty",
	"UnitPlayerOrPetInRaid",
	"UnitPower",
	"UnitPower",
	"UnitPowerMax",
	"UnitPowerType",
	"UnitPVPName",
	"UnitRace",
	"UnitRangedAttackPower",
	"UnitRangedDamage",
	"UnitReaction",
	"UnitSelectionColor",
	"UnitSex",
	"UnitStat",
	"UnitThreatSituation",
	"UnitUsingVehicle",
	"UnitXP",
	"UnitXPMax",
	"UseAction",
	"UseContainerItem",
	"UseInventoryItem",
	"UseItemByName",
	"UseToy",
	"UseToyByName"
}
print("Is this loading")
--------------------------------------------------------------------------------------------------------------------------------
-- functions exported to BadRotations
--------------------------------------------------------------------------------------------------------------------------------
local meta = ...
meta.unlock = {}
meta._G = {}
local m = meta._G
local unlock = meta.unlock
local funcCopies = {}

-- helper function
local function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t = {}
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		table.insert(t, str)
	end
	return t
end

-- obtain references to WA APIs from the BadRotations plugin
-- if _G.BR_ICC then
-- 	icc = _G.BR_ICC
-- 	_G.BR_ICC = nil

	-- make a backup copy of all APIs before AddOns hook them
	for i = 1, #unlockList do
		local func = unlockList[i]
		funcCopies[func] = _G[func]
	end
-- else
	-- either not WA or BR addon is not enabled
-- end

print("Loaded")
local function ICC()
	if not icc then
		return false
	end
	--------------------------------
	-- API unlocking
	--------------------------------
	for k, v in pairs(funcCopies) do
		m[k] = function(...) return icc.CallProtected(v, ...) end
	end

	function tablelength(T)
		local count = 0
		for _ in pairs(T) do count = count + 1 end
		return count
	  end
	
	--------------------------------
	-- API copy/rename/unlock
	--------------------------------
	m.ClickPosition = icc.ClickAt
	m.GetKeyState = icc.GetKeyState
	m.ObjectName = icc.ObjectName
	m.GetObjectWithIndex = icc.ObjectByIndex
	m.ObjectPosition = icc.ObjectPosition
	m.UnitMovementFlags = icc.UnitMovementFlags
	m.GetWoWDirectory = icc.GetBaseFolder
	m.ObjectFacing = icc.ObjectFacing
	m.GetMousePosition = icc.GetCursorPosition
	m.ObjectExists = icc.ObjectExists
	m.GetCameraPosition = icc.GetCameraPosition
	m.CancelPendingSpell = m.SpellStopTargeting
	m.ObjectIsVisible = m.UnitIsVisible
	m.IsAoEPending = m.SpellIsTargeting
	m.ObjectInteract = m.InteractUnit
	m.UnitFacing = icc.ObjectFacing
	m.GetObjectCount = icc.ObjectCount
	--------------------------------
	-- object fields
	--------------------------------
	m.UnitTarget = function(unit)
		return icc.ObjectField(unit, 0x17C8, 15)
	end
	m.UnitCreator = function(unit)
		return icc.ObjectField(unit, 0x1788, 15)
	end
	m.UnitBoundingRadius = function(unit)
		return icc.ObjectField(unit, 0x185C, 10)
	end
	m.UnitCombatReach = function(unit)
		return icc.ObjectField(unit, 0x1860, 10)
	end	
	--------------------------------
	-- API conversions
	--------------------------------
	m.GetObjects = icc.GetObjects
		
	m.ObjectPointer = function(...)
		if m.UnitExists(...) then
			return m.UnitGUID(...)
		end
	end
	m.ObjectType = icc.ObjectType
	m.ObjectIsUnit = function(...)
		local ObjType = icc.ObjectType(...)
		return ObjType == 5
	end
	m.ObjectID = function(object)
		local guid = m.UnitGUID(object)
		if guid then
			local _, _, _, _, _, objectId, _ = strsplit("-", guid);
			return tonumber(objectId);
		else
			return 0
		end
	end
	m.TraceLine = function(...)
		local hit, hitx, hity, hitz = icc.Intersection(...)
		if hit == 1 then
			return hitx, hity, hitz
		else
			return nil
		end
	end
	m.UnitCastID = function(...)
		local spellId1 = select(9, m.UnitCastingInfo(...)) or 0
		local spellId2 = select(9, m.UnitChannelInfo(...)) or 0
		local castGUID = m.UnitTarget(select(1,...))
		return spellId1, spellId2, castGUID, castGUID
	end
	m.CreateDirectory = function(...)
		local path = string.gsub(..., "\\+", "/")
		return icc.CreateFolder(path)
	end
	m.DirectoryExists = function(...)
		local path = string.gsub(..., "\\+", "/")
		return icc.PathExists(path)
	end
	m.WriteFile = function(path, content)
		local filePath = path:gsub("\\+", "/");
		icc.SaveContents(filePath, content)
	end
	m.ReadFile = function(...)
		local file = string.gsub(..., "\\+", "/")
		return icc.GetContents(file)
	end
	m.GetDirectoryFiles = function(...)
		local extension = string.match(..., "^.+(%..+)$")
		local directory = string.gsub(..., "\\+", "/"):gsub("/+*.lua", "")
		local count = 1
		local profiles = {}
		local files = icc.GetContents(directory)
		if files and #files then
			for _, file in ipairs(files) do
				if file.dir == false then
					local path = file.path:gsub("\\+", "/")
					if path:match(extension) then
						profiles[count] = path:match("^.+/(.+)$")
						count = count + 1
					end
				end
			end
		end
		return profiles
		
	end
	m.WorldToScreen = function(...)
		local multiplier = UIParent:GetScale()
		local sX, sY = icc.WorldToScreen(...)
		return sX * multiplier, -sY * multiplier
	end
	m.FaceDirection = function(arg)
		if type(arg) == "number" then
			icc.FaceDirection(arg)
		else
			arg = m.GetAnglesBetweenObjects("player", arg)
			icc.FaceDirection(arg)
		end
	end
	m.GetObjectWithGUID = function(...)
		return ...
	end
    m.IsHackEnabled = function(...) return false end
	--------------------------------
	-- math
	--------------------------------
	m.GetDistanceBetweenPositions = function(X1, Y1, Z1, X2, Y2, Z2)
		return math.sqrt(math.pow(X2 - X1, 2) + math.pow(Y2 - Y1, 2) + math.pow(Z2 - Z1, 2))
	end
	m.GetAnglesBetweenObjects = function(Object1, Object2)
		if Object1 and Object2 then
			local X1, Y1, Z1 = m.ObjectPosition(Object1)
			local X2, Y2, Z2 = m.ObjectPosition(Object2)
			return math.atan2(Y2 - Y1, X2 - X1) % (math.pi * 2),
				math.atan((Z1 - Z2) / math.sqrt(math.pow(X1 - X2, 2) + math.pow(Y1 - Y2, 2))) % math.pi
		else
			return 0, 0
		end
	end
	m.GetAnglesBetweenPositions = function(X1, Y1, Z1, X2, Y2, Z2)
		return math.atan2(Y2 - Y1, X2 - X1) % (math.pi * 2),
			math.atan((Z1 - Z2) / math.sqrt(math.pow(X1 - X2, 2) + math.pow(Y1 - Y2, 2))) % math.pi
	end
	m.GetPositionFromPosition = function(X, Y, Z, Distance, AngleXY, AngleXYZ)
		return math.cos(AngleXY) * Distance + X, math.sin(AngleXY) * Distance + Y, math.sin(AngleXYZ) * Distance + Z
	end
	m.GetPositionBetweenPositions = function(X1, Y1, Z1, X2, Y2, Z2, DistanceFromPosition1)
		local AngleXY, AngleXYZ = m.GetAnglesBetweenPositions(X1, Y1, Z1, X2, Y2, Z2)
		return m.GetPositionFromPosition(X1, Y1, Z1, DistanceFromPosition1, AngleXY, AngleXYZ)
	end
	m.GetPositionBetweenObjects = function(unit1, unit2, DistanceFromPosition1)
		local X1, Y1, Z1 = m.ObjectPosition(unit1)
		local X2, Y2, Z2 = m.ObjectPosition(unit2)
		if not X1 or not X2 then return end
		local AngleXY, AngleXYZ = m.GetAnglesBetweenPositions(X1, Y1, Z1, X2, Y2, Z2)
		return m.GetPositionFromPosition(X1, Y1, Z1, DistanceFromPosition1, AngleXY, AngleXYZ)
	end
	m.GetDistanceBetweenObjects = function(unit1, unit2)
		local X1, Y1, Z1 = m.ObjectPosition(unit1)
		local X2, Y2, Z2 = m.ObjectPosition(unit2)
		return math.sqrt((X2-X1)^2 + (Y2-Y1)^2 + (Z2-Z1)^2)
	end
	m.ObjectIsFacing = function(obj1, obj2, degrees)
		local Facing = m.UnitFacing(obj1)
		local AngleToUnit = m.GetAnglesBetweenObjects(obj1, obj2)
		local AngleDifference = Facing > AngleToUnit and Facing - AngleToUnit or AngleToUnit - Facing
		local ShortestAngle = AngleDifference < math.pi and AngleDifference or math.pi * 2 - AngleDifference
		degrees = degrees and m.rad(degrees) / 2 or math.pi / 2
		return ShortestAngle < degrees
	end
	--------------------------------
	-- extra APIs
	--------------------------------
	m.AuraUtil = {}
	m.AuraUtil.FindAuraByName = function(...)
		return icc.CallProtected(_G.AuraUtil["FindAuraByName"], ...)
	end
	m.ObjectIsGameObject = function(...)
		local ObjType = icc.ObjectType(...)
		return ObjType == 8 or ObjType == 11
	end
	m.GetMapId = function()
		return select(8, GetInstanceInfo())
	end
	--------------------------------
	-- missing APIs
	--------------------------------
	m.IsQuestObject = function(obj)
		return false
	end
	m.ScreenToWorld = function()
		return 0, 0
	end
		
	m.UnitIsUnit = function(unit1, unit2)
		return m.UnitGUID(unit1) == m.UnitGUID(unit2)
	end
	meta.unlocker = "ICC"
	return true
end

return ICC()