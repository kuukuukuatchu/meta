local meta, require = ...

meta.frame = CreateFrame("frame") -- create frame we can set all our scripts on
meta.om = {} -- create om that is available throughout addon
require('handlers.update') -- load update handler
meta.events = require('handlers.events') -- load events handlers
meta.magic = require('magic') -- setup environment and functions needed in profiles
meta.loader = require('loader') -- load profiles and start rotation engine
require('ui.minimap')

-- _meta = meta
