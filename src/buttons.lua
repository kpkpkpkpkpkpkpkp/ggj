--TODO needs to be made into a button type rather than a table of values
local vector = require 'lib.vector'
math.randomseed(os.time())-- so that the results of random are always different
butt = {}
dropcounter = 1
droporder = {'h', 'g', 'f', 'e', 'd', 'c', 'b', 'a'}
restorecounter = 1
restoreorder = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'}

function butt.reset()
    dropcounter = 0
    restorecounter = 1
end

function butt.alldown(bs)
    r = true
    for i, b in pairs(bs) do
        if not b.dropped and not b.down then
            r = false
        end
    end
    return r
end

function butt.drop(bs, i)
    bs[i].dropped = true
end

function butt.restore(bs, i)
    bs[i].dropped = false
end

function butt.progress(bs)
    if dropcounter <= 7 then
        butt.drop(bs, droporder[dropcounter])
        dropcounter = dropcounter + 1
    elseif restorecounter <= 7 then
        restorecounter = restorecounter + 1
        butt.restore(bs, restoreorder[restorecounter])
    else
        print('win!')
        return 'win'
    end
end



return {
    a = {
        label='a',
        x = 32,
        y = 2,
        sprite = love.graphics.newImage('assets/sprites/ButtonOne.png'),
        spritep = love.graphics.newImage('assets/sprites/ButtonOnePressed.png'),
        shine = true,
        pressed = false,
        down = false,
        dropped = false,
        vectors = {
            vector.fromAngle(math.pi / 2),
            vector.fromAngle((math.pi / 2) - math.pi)
        },
        color = {r = 1,
        g = 0,
        b = 1,
        a = 1},
        colorcenter = {x=40,y=40}
    },
    b = {
        label='b',
        x = 57,
        y = 2,
        sprite = love.graphics.newImage('assets/sprites/ButtonTwo.png'),
        spritep = love.graphics.newImage('assets/sprites/ButtonTwoPressed.png'),
        shine = false,
        pressed = false,
        down = false,
        dropped = false,
        vectors = {
            vector.fromAngle(math.pi / 2),
            vector.fromAngle((math.pi / 2) - math.pi)
        },
        color = {r = 1,
        g = 0,
        b = 1,
        a = 1},
        
        colorcenter = vector(40, 80)
    },
    c = {
        label='c',
        x = 2,
        y = 60,
        sprite = love.graphics.newImage('assets/sprites/ButtonThree.png'),
        spritep = love.graphics.newImage('assets/sprites/ButtonThreePressed.png'),
        shine = false,
        pressed = false,
        down = false,
        dropped = false,
        vectors = {
            vector.fromAngle(math.pi),
            vector.fromAngle(2 * math.pi)
        },
        color = {r = 1,
        g = 0,
        b = 1,
        a = 1},
        
        colorcenter = vector(80, 80)
    },
    d = {
        label='d',
        x = 2,
        y = 85,
        sprite = love.graphics.newImage('assets/sprites/ButtonFour.png'),
        spritep = love.graphics.newImage('assets/sprites/ButtonFourPressed.png'),
        shine = false,
        pressed = false,
        down = false,
        dropped = false,
        vectors = {
            vector.fromAngle(math.pi),
            vector.fromAngle(2 * math.pi)
        },
        color = {r = 1,
        g = 0,
        b = 1,
        a = 1},
        
        colorcenter = vector(120, 80)
    },
    e = {
        label='e',
        x = 228,
        y = 165,
        sprite = love.graphics.newImage('assets/sprites/ButtonFive.png'),
        spritep = love.graphics.newImage('assets/sprites/ButtonFivePressed.png'),
        shine = false,
        pressed = false,
        down = false,
        dropped = false,
        vectors = {
            vector.fromAngle(math.pi / 4),
            vector.fromAngle((math.pi / 4) - math.pi)
        },
        color = {r = 1,
        g = 0,
        b = 1,
        a = 1},
        
        colorcenter = vector(200, 200)
    },
    f = {
        label='f',
        x = 228,
        y = 190,
        sprite = love.graphics.newImage('assets/sprites/ButtonSix.png'),
        spritep = love.graphics.newImage('assets/sprites/ButtonSixPressed.png'),
        shine = false,
        pressed = false,
        down = false,
        dropped = false,
        vectors = {
            vector.fromAngle(math.pi / 4),
            vector.fromAngle((math.pi / 4) - math.pi)
        },
        color = {r = 1,
        g = 0,
        b = 1,
        a = 1},
        
        colorcenter = vector(200, 80)
    },
    g = {
        label='g',
        x = 43,
        y = 228,
        sprite = love.graphics.newImage('assets/sprites/ButtonSeven.png'),
        spritep = love.graphics.newImage('assets/sprites/ButtonSevenPressed.png'),
        shine = false,
        pressed = false,
        down = false,
        dropped = false,
        vectors = {
            vector.fromAngle((3 * math.pi / 4)),
            vector.fromAngle((3 * math.pi / 4) - math.pi)
        },
        color = {r = 1,
        g = 0,
        b = 1,
        a = 1},
        
        colorcenter = vector(100, 200)
    },
    h = {
        label='h',
        x = 75,
        y = 228,
        sprite = love.graphics.newImage('assets/sprites/ButtonEight.png'),
        spritep = love.graphics.newImage('assets/sprites/ButtonEightPressed.png'),
        shine = false,
        pressed = false,
        down = false,
        dropped = false,
        vectors = {
            vector.fromAngle((3 * math.pi / 4)),
            vector.fromAngle((3 * math.pi / 4) - math.pi)
        },
        color = {r = 1,
        g = 0,
        b = 1,
        a = 1},
        
        colorcenter = vector(150, 150)
    }

}
