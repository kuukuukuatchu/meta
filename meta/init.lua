local meta, require = ...

meta.frame = CreateFrame("frame")
meta.om = {}
-- meta.frame:RegisterAllEvents()
require('conditions.update')
meta.events =require('conditions.events')
meta.magic = require('magic')
meta.loader = require('loader')

-- _meta = meta
