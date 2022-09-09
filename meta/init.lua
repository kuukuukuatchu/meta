local meta, require = ...

meta.frame = CreateFrame("frame") -- create frame we can set all our scripts on
meta.om = {} -- create om that is available throughout addon
require('conditions.update') -- load update handler
meta.events =require('conditions.events') -- load events handlers
meta.magic = require('magic') -- setup environment and functions needed in profiles
meta.loader = require('loader') -- load profiles and start rotation engine

-- _meta = meta
