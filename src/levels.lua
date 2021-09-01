level={}

function level.progress(lv) 
    if lv.counter > 15 then
        lv.counter=0
    end
    lv.counter = lv.counter+1
end

function level.getcenter(lv,buttonlabel)
    colorcenter = lv[lv.counter][buttonlabel]
    return {
        y=(colorcenter.r * lv.scale)+lv.offset,
        x=(colorcenter.c * lv.scale)+lv.offset
    }
end

function level.getcolor(lv)
    return lv[lv.counter].color
end

function level.screen(lv)
    return lv.screens[lv.counter]
end

function level.inbetween(lv)
    return lv.inbetweens[lv.counter]
end

return {

    --24X24
    --224X224
    --play area is 200x200
    --coordinates are in rows and columns, there are 8 of each

    counter = 0,
    --mapping each vector's color center
    --numbers represent rows and columns, gaps between items
    --scale is to convert r/c into actual coordinates
    scale=25, --200/8, playable area dimensions divided by number of rows and columns
    --offset places 0 at top left of play area
    offset=24,
    --tolerance allows a certain area around point to be correct
    tolerance=12,
    --both diagonal coordinates are important

    --for diags, one of two coordinates needs to be n+1/2 and other needs to be a whole number.
    --this is because placement of diagonals needs to be between two items 
    -- rather than at the center intersection of a row/column
    --each vector's possible coordinates alternates between r being r+1/5 and c being c+1/5


    -- levelct = 0,
    --TODO pick constants here to decide
    --what the level's target color is
    -- levelcolors = {
    --     

    --     {r = 0, g = 0, b = 80, fixed = g}, --dark blue
    --     {r = 255, g = 255, b = 150, fixed = r}, --light blue
    --     {r = 255, g = 200, b = 255, fixed = r}, --green
    --     {r = 255, g = 0, b = 0, fixed = b}, --red
    --     {r = 255, g = 255, b = 255, fixed = b}, --yellow
    --     {r = 255, g = 100, b = 0, fixed = b}, --orange
    --     {r = 255, g = 255, b = 255, fixed = g}, --pink
    --     {r = 255, g = 0, b = 255, fixed = b}, --red
    --     {r = 255, g = 255, b = 255, fixed = b}, --orange
    --     {r = 255, g = 255, b = 0, fixed = b}, --yellow?
    --     {r = 0, g = 255, b = 255, fixed = r}, --green
    --     {r = 255, g = 255, b = 255, fixed = r}, --blue
    --     {r = 255, g = 255, b = 255, fixed = g}, --purple?
    --     {r = 255, g = 255, b = 255, fixed = g}--pink?
    -- }

    {
        --purple
        color = {r = 0.7,
        g = 0.2,
        b = 1,
        a = 1,
        fixed = 'g',
        cx=r,
        cy=b},
        a={r=6,c=2},   --vert, col is irrelevant  
        b={r=6,c=4},   --vert, col is irrelevant
        c={r=1,c=1},   --horiz, row is irrelevant
        d={r=4,c=4},   --horiz, row is irrelevant
        e={r=3,c=0.5}, --diag +30deg
        f={r=1.5,c=6}, --diag +30deg
        g={r=4,c=6.5}, --diag -30deg
        h={r=5,c=2.5}  --diag -30deg
    },
    {
        --dark blue
        color = {r = 0.7,
        g = 0.7,
        b = 1,
        a = 1,
        fixed = 'r',
        cx=b,
        cy=g},
        a={r=7,c=2}, --vert, col is irrelevant  
        b={r=6,c=4}, --vert, col is irrelevant
        c={r=1,c=1}, --horiz, row is irrelevant
        d={r=1,c=3}, --horiz, row is irrelevant
        e={r=2,c=5.5}, --diag +30deg
        f={r=5.5,c=5}, --diag +30deg
        g={r=1,c=7.5}  --diag -30deg
    },
    {
        --light blue
        color = {r = 0,
        g = 0,
        b = 0.5,
        a = 1,
        fixed = 'r',
        cx=b,
        cy=g},
        a={r=1,c=1}, --vert, col is irrelevant 
        b={r=5,c=7}, --vert, col is irrelevant
        c={r=0,c=0}, --horiz, row is irrelevant
        d={r=0,c=0}, --horiz, row is irrelevant
        e={r=0,c=0}, --diag +30deg
        f={r=0,c=0} --diag +30deg
    },
    {
        --green
        color = {r = 0,
        g = 1,
        b = 0,
        a = 1,
        fixed = 'r',
        cx=g,
        cy=b},
        a={r=0,c=0},--vert, col is irrelevant 
        b={r=0,c=0},--vert, col is irrelevant
        c={r=0,c=0},--horiz, row is irrelevant
        d={r=0,c=0},--horiz, row is irrelevant
        e={r=0,c=0} --diag +30deg
    },
    {
        --red
        color = {r = 1,
        g = 0,
        b = 0,
        a = 1,
        fixed = 'b',
        cx=r,
        cy=g},
        a={r=0,c=0},--vert, col is irrelevant 
        b={r=0,c=0},--vert, col is irrelevant
        c={r=0,c=0},--horiz, row is irrelevant
        d={r=0,c=0}--horiz, row is irrelevant
    },
    {
        --yellow
        color = {r = 1,
        g = 1,
        b = 1,
        a = 1,
        fixed = 'b',
        cx=r,
        cy=g},
        a={r=0,c=0},--vert, col is irrelevant 
        b={r=0,c=0},--vert, col is irrelevant
        c={r=0,c=0}--horiz, row is irrelevant
    },
    {
        --orange
        color = {r = 1,
        g = 1,
        b = 0,
        a = 1,
        fixed = 'b',
        cx=g,
        cy=r},
        a={r=0,c=0},--vert, col is irrelevant
        b={r=0,c=0}--vert, col is irrelevant
    },
    {
        --pink
        color = {r = 0.5,
        g = 0,
        b = 0,
        a = 1,
        fixed = 'g',
        cx=r,
        cy=b},
        a={r=0,c=0}--vert, col is irrelevant
    },
    {
        --red?
        color = {r = 1,
        g = 0,
        b = 0,
        a = 1,
        fixed = 'b',
        cx=r,
        cy=g},
        a={r=0,c=0},--vert, col is irrelevant 
        b={r=0,c=0}--vert, col is irrelevant
    },
    {
        --orange?
        color = {r = 1,
        g = 1,
        b = 0,
        a = 1,
        fixed = 'b',
        cx=r,
        cy=g},
        a={r=0,c=0},--vert, col is irrelevant 
        b={r=0,c=0},--vert, col is irrelevant
        c={r=0,c=0}--horiz, row is irrelevant
    },
    {
        --yellow
        color = {r = 1,
        g = 1,
        b = 1,
        a = 1,
        fixed = 'b',
    
        cx=g,
        cy=r},
        a={r=0,c=0},--vert, col is irrelevant 
        b={r=0,c=0},--vert, col is irrelevant
        c={r=0,c=0},--horiz, row is irrelevant
        d={r=0,c=0} --horiz, row is irrelevant
    },
    {
        --green
        color = {r = 0,
        g = 1,
        b = 0,
        a = 1,
        fixed = 'r',
        cx=g,
        cy=b},
        a={r=0,c=0},--vert, col is irrelevant 
        b={r=0,c=0},--vert, col is irrelevant
        c={r=0,c=0},--horiz, row is irrelevant
        d={r=0,c=0},--horiz, row is irrelevant
        e={r=0,c=0} --diag +30deg
    },
    {
        --blue
        color = {r = 0,
        g = 0,
        b = 1,
        a = 1,
        fixed = 'r',
        cx=g,
        cy=b},
        a={r=0,c=0},--vert, col is irrelevant 
        b={r=0,c=0},--vert, col is irrelevant
        c={r=0,c=0},--horiz, row is irrelevant
        d={r=0,c=0},--horiz, row is irrelevant
        e={r=0,c=0},--diag +30deg
        f={r=0,c=0} --diag +30deg
    },
    {
        --purple
        color = {r = 1,
        g = 0,
        b = 1,
        a = 1,
        fixed = 'g',
        cx=b,
        cy=r},
        a={r=0,c=0},--vert, col is irrelevant 
        b={r=0,c=0},--vert, col is irrelevant
        c={r=0,c=0},--horiz, row is irrelevant
        d={r=0,c=0},--horiz, row is irrelevant
        e={r=0,c=0},--diag +30deg
        f={r=0,c=0},--diag +30deg
        g={r=0,c=0}--diag -30deg
    },
    {
        --pink
        color = {r = 0.5,
        g = 0,
        b = 0,
        a = 1,
        fixed = 'g',
        cx=r,
        cy=b},
        a={r=0,c=0}, --vert, col is irrelevant 
        b={r=0,c=0}, --vert, col is irrelevant
        c={r=0,c=0}, --horiz, row is irrelevant
        d={r=0,c=0}, --horiz, row is irrelevant
        e={r=0,c=0}, --diag +30deg
        f={r=0,c=0}, --diag +30deg
        g={r=0,c=0}, --diag -30deg
        h={r=0,c=0}  --diag -30deg
    },

    screens = {
        love.graphics.newImage('assets/Backgrounds/GradientOne.png'),
        love.graphics.newImage('assets/Backgrounds/GradientTwo.png'),
        love.graphics.newImage('assets/Backgrounds/GradientThree.png'),
        love.graphics.newImage('assets/Backgrounds/GradientFour.png'),
        love.graphics.newImage('assets/Backgrounds/GradientFive.png'),
        love.graphics.newImage('assets/Backgrounds/GradientSix.png'),
        love.graphics.newImage('assets/Backgrounds/GradientSeven.png'),
        love.graphics.newImage('assets/Backgrounds/GradientEight.png'),
        love.graphics.newImage('assets/Backgrounds/GradientNine.png'),
        love.graphics.newImage('assets/Backgrounds/GradientTen.png'),
        love.graphics.newImage('assets/Backgrounds/GradientEleven.png'),
        love.graphics.newImage('assets/Backgrounds/GradientTwelve.png'),
        love.graphics.newImage('assets/Backgrounds/GradientThirteen.png'),
        love.graphics.newImage('assets/Backgrounds/GradientFourteen.png'),
        love.graphics.newImage('assets/Backgrounds/GradientFifteen.png')
    },
    inbetweens = {
        love.graphics.newImage('assets/Backgrounds/InbetweenOne.png'),
        love.graphics.newImage('assets/Backgrounds/InbetweenTwo.png'),
        love.graphics.newImage('assets/Backgrounds/InbetweenThree.png'),
        love.graphics.newImage('assets/Backgrounds/InbetweenFour.png'),
        love.graphics.newImage('assets/Backgrounds/InbetweenFive.png'),
        love.graphics.newImage('assets/Backgrounds/InbetweenSix.png'),
        love.graphics.newImage('assets/Backgrounds/InbetweenSeven.png'),
        love.graphics.newImage('assets/Backgrounds/InbetweenEight.png'),
        love.graphics.newImage('assets/Backgrounds/InbetweenNine.png'),
        love.graphics.newImage('assets/Backgrounds/InbetweenTen.png'),
        love.graphics.newImage('assets/Backgrounds/InbetweenEleven.png'),
        love.graphics.newImage('assets/Backgrounds/InbetweenTwelve.png'),
        love.graphics.newImage('assets/Backgrounds/InbetweenThirteen.png'),
        love.graphics.newImage('assets/Backgrounds/InbetweenFourteen.png')
    }
}
