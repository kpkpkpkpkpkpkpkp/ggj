--TODO needs to be made into a button type rather than a table of values
local vector = require 'lib.vector'
math.randomseed(os.time()) -- so that the results of random are always different
return {
    a = {
        x = 32,
        y = 2,
        sprite = love.graphics.newImage('assets/ButtonOne.png'),
        shine = true,
        pressed=false,
        down=false,
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
        x = 57,
        y = 2,
        sprite = love.graphics.newImage('assets/ButtonTwo.png'),
        shine = false,
        pressed=false,
        down=false,
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
        x = 2,
        y = 60,
        sprite = love.graphics.newImage('assets/ButtonThree.png'),
        shine = false,
        pressed=false,
        down=false,
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
        sprite = love.graphics.newImage('assets/ButtonFour.png'),
        shine = false,
        pressed=false,
        down=false,
        vectors = {
            vector.fromAngle((3*math.pi/4)),
            vector.fromAngle((3*math.pi/4)-math.pi)
        },
        color={r=math.random(0,255)/255,
        g=math.random(0,255)/255,
        b=math.random(0,255)/255,
        a=1}
    },
    e = {
        x = 228,
        y = 165,
        sprite = love.graphics.newImage('assets/ButtonFive.png'),
        shine = false,
        pressed=false,
        down=false,
        vectors = {
            vector.fromAngle((3*math.pi/4)),
            vector.fromAngle((3*math.pi/4)-math.pi)
        },
        color={r=math.random(0,255)/255,
        g=math.random(0,255)/255,
        b=math.random(0,255)/255,
        a=1}
    },
    f = {
        x = 228,
        y = 190,
        sprite = love.graphics.newImage('assets/ButtonSix.png'),
        shine = false,
        pressed=false,
        down=false,
        vectors = {
            vector.fromAngle(2 * math.pi),
            vector.fromAngle(math.pi)
        },
        color={r=math.random(0,255)/255,
        g=math.random(0,255)/255,
        b=math.random(0,255)/255,
        a=1}
    },
    g = {
        x = 43,
        y = 228,
        sprite = love.graphics.newImage('assets/ButtonSeven.png'),
        shine = false,
        pressed=false,
        down=false,
        vectors = {
            vector.fromAngle(math.pi/2),
            vector.fromAngle((math.pi/2)-math.pi)
        },
        color={r=math.random(0,255)/255,
        g=math.random(0,255)/255,
        b=math.random(0,255)/255,
        a=1}
    },
    h = {
        x = 75,
        y = 228,
        sprite = love.graphics.newImage('assets/ButtonEight.png'),
        shine = false,
        pressed=false,
        down=false,
        vectors = {
            vector.fromAngle((math.pi/4)),
            vector.fromAngle((math.pi/4)-math.pi)
        },
        color={r=math.random(0,255)/255,
        g=math.random(0,255)/255,
        b=math.random(0,255)/255,
        a=1}
    }

}
