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

-- leak ourself into wow global so we can debug stuff
_meta = meta
