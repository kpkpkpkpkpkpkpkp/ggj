--TODO needs to be made into a button type rather than a table of values
local vector = require 'lib.vector'
math.randomseed(os.time()) -- so that the results of random are always different
return {
    a = {
        x = 80,
        y = 2,
        sprite = love.graphics.newImage('assets/buttonstar.png'),
        shine = true,
        pressed=false,
        vectors = {
            vector.fromAngle(math.pi/2),
            vector.fromAngle((math.pi/2)-math.pi)
            -- vector.fromAngle((3*math.pi)/2)
        },
        color={r=math.random(0,255)/255,
        g=math.random(0,255)/255,
        b=math.random(0,255)/255,
        a=1}
    },
    b = {
        x = 45,
        y = 2,
        sprite = love.graphics.newImage('assets/buttoncircle.png'),
        shine = false,
        pressed=false,
        vectors = {
            vector.fromAngle(math.pi/4),
            vector.fromAngle((math.pi/4)-math.pi)
        },
        color={r=math.random(0,255)/255,
        g=math.random(0,255)/255,
        b=math.random(0,255)/255,
        a=1}
    },
    c = {
        x = 1,
        y = 60,
        sprite = love.graphics.newImage('assets/buttondiamond.png'),
        shine = false,
        pressed=false,
        vectors = {
            vector.fromAngle(2 * math.pi),
            vector.fromAngle(math.pi)
        },
        color={r=math.random(0,255)/255,
        g=math.random(0,255)/255,
        b=math.random(0,255)/255,
        a=1}
    },
    d = {
        x = 2,
        y = 85,
        sprite = love.graphics.newImage('assets/buttongem.png'),
        shine = false,
        pressed=false,
        vectors = {
            vector.fromAngle((3*math.pi/4)),
            vector.fromAngle((3*math.pi/4)-math.pi)
        },
        color={r=math.random(0,255)/255,
        g=math.random(0,255)/255,
        b=math.random(0,255)/255,
        a=1}
    }
}
