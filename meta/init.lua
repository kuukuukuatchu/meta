local meta, require = ...

meta.magic = require('magic')

--[[

function test()
    print( health('player') )
    print( buff.exists('player', 'Immolation Aura') )
    if not buff.exists('player', 'Immolation Aura') then
        cast('Immolation Aura')
    end
end

_meta.magic(test)

test()

]]

local NAME = 'metaOnUpdateFrame'
local UPDATE_INTERVAL = 0.1 -- OnUpdate interval in seconds

local frame = _G[NAME] or CreateFrame('Frame',NAME,UIParent)
local function OnUpdate(this, elapsed)
    this.lastUpdate = this.lastUpdate + elapsed
    if this.lastUpdate > UPDATE_INTERVAL then
        --~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        -- start code
        --~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        local specIdFunction = {
    	[ 62] = MageArcane,
    	[ 63] = MageFire,
    	[ 64] = MageFrost,
    	[ 65] = PaladinHoly,
    	[ 66] = PaladinProtection,
    	[ 70] = PaladinRetribution,
    	[ 71] = WarriorArms,
    	[ 72] = WarriorFury,
    	[ 73] = WarriorProtection,
    	[102] = DruidBalance,
    	[103] = DruidFeral,
    	[104] = DruidGuardian,
    	[105] = DruidRestoration,
     	[250] = DeathKnightBlood,
     	[251] = DeathKnightFrost,
     	[252] = DeathKnightUnholy,
     	[253] = HunterBeastMastery,
     	[254] = HunterMarksmanship,
     	[255] = HunterSurvival,
     	[256] = PriestDiscipline,
     	[257] = PriestHoly,
     	[258] = PriestShadow,
     	[259] = RogueAssassination,
     	[260] = RogueOutlaw,
     	[261] = RogueSubtlety,
     	[262] = ShamanElemental,
     	[263] = ShamanEnhancement,
     	[264] = ShamanRestoration,
     	[265] = WarlockAffliction,
     	[266] = WarlockDemonology,
     	[267] = WarlockDestruction,
     	[268] = MonkBrewmaster,
     	[269] = MonkWindwalker,
     	[270] = MonkMistweaver,
     	[577] = DemonHunterHavoc,
     	[581] = DemonHunterVengeance,
    }
    -- AddFrameCallback(function ()
    	local playerSpec = GetSpecializationInfo(GetSpecialization())
    	-- specIdFunction[playerSpec]()
    -- end)
        --~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        -- end code
        --~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        this.lastUpdate = 0
    end
end
frame.lastUpdate = 0
frame:SetScript("OnUpdate",OnUpdate)
frame:Show()

-- leak ourself into wow global so we can debug stuff
_meta = meta
