local meta, require = ...

meta.class = select(2, UnitClass("player"))
meta.classColor = select(4, GetClassColor(meta.class))
meta.frame = CreateFrame("frame") -- create frame we can set all our scripts on
meta.data = {}
meta.data.settings = {}
meta.data.settings.base = {}
meta.windows = {}
meta.debug = {}
meta.currentProfile = "None"
meta.folder = meta._G.GetWoWDirectory(true).."/AddOns/meta"
meta.specID, meta.specName = GetSpecializationInfo(GetSpecialization())
meta.om = {} -- create om that is available throughout addon
meta.dropOptions = {}
meta.dropOptions.Toggle = {
	"LeftCtrl",
	"LeftShift",
	"RightCtrl",
	"RightShift",
	"RightAlt",
	"None",
	"MMouse",
	"Mouse4",
	"Mouse5"
}
require('handlers.update') -- load update handler
meta.events = require('handlers.events') -- load events handlers
meta.magic = require('magic') -- setup environment and functions needed in profiles
require('utilities.fs')
require('utilities.json')
require('utilities.helpers')
require('ui.elements.arrow')
require('ui.elements.window')
require('ui.elements.section')
require('ui.elements.checkbox')
require('ui.elements.text')
require('ui.elements.dropdown')
require('ui.elements.scrollingeditbox')
require('ui.elements.spinner')
require('ui.elements.button')
require('ui.minimap')
require('ui.windows.config')
require('ui.windows.profile')
meta.loader = require('loader') -- load profiles and start rotation engine

-- _meta = meta
