level={}
Orientation={
    VERTICAL=1,
    HORIZONTAL=2,
    DIAG_ASC=3,
    DIAG_DEC=4
}

function level.progress(lv) 
    if lv.counter > 15 then level.reset(lv) end
    lv.counter = lv.counter+1
end

function level.reset(lv)
    lv.counter = 1
end

function level.getcenter(lv,buttonlabel)
    colorcenter = lv[lv.counter][buttonlabel]
    return {
        y=(colorcenter.r * lv.scale)+lv.offset,
        x=(colorcenter.c * lv.scale)+lv.offset
    }
end

function level.getor(lv,buttonlabel)
    colorcenter = lv[lv.counter][buttonlabel]
    return colorcenter.orien
end

function level.getcolor(lv)
    if lv.counter > 15 then level.reset(lv) end
    return lv[lv.counter].color
end

function level.screen(lv)
    if lv.counter > 15 then level.reset(lv) end
    return lv.screens[lv.counter]
end

function level.inbetween(lv)
    if lv.counter > 15 then level.reset(lv) end
    return lv.inbetweens[lv.counter]
end

return {

    --24X24
    --224X224
    --play area is 200x200
    --coordinates are in rows and columns, there are 8 of each

    counter = 1,
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

    --NOTE: I picked this method of doing a color center when I thought both x and y directions would change the color.
    --The intended gameplay was that only the direction perpandicular to the vectors changes the color. 
    --This means that only one of the 'color center' coordinates is important for horizontal and vertical lines.
    --Both coordinates are needed for diagonals, but the chosen coordinates could be at any point on the correct line placment.
    --I have kept things this way because it's the easiest way I could think of to still do the line checks. 
    --As long as the placed line intersects an area around the color center, it will pass the check.
    --Whatever function is used to set the line's current color must approach the color defined here, and must vary perpendicular to the defined orientation.


    --due to the new method of shifting current color, it may be better to define RGB in 0<n<255 than 0<n<1?

    {
        --purple
        color = {r = 0.55,
        g = 0.10,
        b = 1,
        a = 1,
        fixed = 'g',
        cx=r,
        cy=b},
        a={r=6,c=2,orien=Orientation.VERTICAL},   --vert, col is irrelevant  
        b={r=6,c=4,orien=Orientation.VERTICAL},   --vert, col is irrelevant
        c={r=1,c=1,orien=Orientation.HORIZONTAL},   --horiz, row is irrelevant
        d={r=4,c=4,orien=Orientation.HORIZONTAL},   --horiz, row is irrelevant
        e={r=3,c=0.5,orien=Orientation.DIAG_ASC}, --diag +30deg
        f={r=1.5,c=6,orien=Orientation.DIAG_ASC}, --diag +30deg
        g={r=4,c=6.5,orien=Orientation.DIAG_DEC}, --diag -30deg
        h={r=5,c=2.5,orien=Orientation.DIAG_DEC}  --diag -30deg
    },
    {
        --dark blue
        color = {r = 0,
        g = 0,
        b = 0.60,
        a = 1,
        fixed = 'r',
        cx=b,
        cy=g},
        a={r=7,c=2,orien=Orientation.VERTICAL}, --vert, col is irrelevant  
        b={r=6,c=8,orien=Orientation.VERTICAL}, --vert, col is irrelevant
        c={r=2,c=1,orien=Orientation.HORIZONTAL}, --horiz, row is irrelevant
        d={r=4,c=1,orien=Orientation.HORIZONTAL}, --horiz, row is irrelevant
        e={r=2,c=5.5,orien=Orientation.DIAG_ASC}, --diag +30deg
        f={r=5.5,c=5,orien=Orientation.DIAG_ASC}, --diag +30deg
        g={r=1,c=7.5,orien=Orientation.DIAG_DEC}  --diag -30deg
    },
    {
        --light blue
        color = {r = 0.50,
        g = 0.83,
        b = 1.00,
        a = 1,
        fixed = 'r',
        cx=b,
        cy=g},
        a={r=0,c=1,orien=Orientation.VERTICAL}, --vert, col is irrelevant 
        b={r=0,c=6,orien=Orientation.VERTICAL}, --vert, col is irrelevant
        c={r=1,c=0,orien=Orientation.HORIZONTAL}, --horiz, row is irrelevant
        d={r=5,c=0,orien=Orientation.HORIZONTAL}, --horiz, row is irrelevant
        e={r=3,c=0.5,orien=Orientation.DIAG_ASC}, --diag +30deg
        f={r=8,c=0.5,orien=Orientation.DIAG_ASC}, --diag +30deg
    },
    {
        --green
        color = {r = 0,
        g = 0.90,
        b = 0.45,
        a = 1,
        fixed = 'r',
        cx=g,
        cy=b},
        a={r=0,c=1,orien=Orientation.VERTICAL}, --vert, col is irrelevant 
        b={r=0,c=7,orien=Orientation.VERTICAL}, --vert, col is irrelevant
        c={r=4,c=0,orien=Orientation.HORIZONTAL}, --horiz, row is irrelevant
        d={r=7,c=0,orien=Orientation.HORIZONTAL}, --horiz, row is irrelevant
        e={r=7.5,c=4,orien=Orientation.DIAG_ASC}, --diag +30deg
    },
    {
        --red
        color = {r = 1,
        g = 0.20,
        b = 0.20,
        a = 1,
        fixed = 'b',
        cx=r,
        cy=g},
        a={r=0,c=1,orien=Orientation.VERTICAL}, --vert, col is irrelevant 
        b={r=0,c=5,orien=Orientation.VERTICAL}, --vert, col is irrelevant
        c={r=1,c=0,orien=Orientation.HORIZONTAL}, --horiz, row is irrelevant
        d={r=6,c=0,orien=Orientation.HORIZONTAL}, --horiz, row is irrelevant
    },
    {
        --yellow
        color = {r = 1,
        g = 1,
        b = 0.40,
        a = 1,
        fixed = 'b',
        cx=r,
        cy=g},
        a={r=0,c=2,orien=Orientation.VERTICAL}, --vert, col is irrelevant 
        b={r=0,c=7,orien=Orientation.VERTICAL}, --vert, col is irrelevant
        c={r=3,c=0,orien=Orientation.HORIZONTAL}, --horiz, row is irrelevant
    },
    {
        --orange
        color = {r = 1,
        g = 0.60,
        b = 0.20,
        a = 1,
        fixed = 'b',
        cx=g,
        cy=r},
        a={r=0,c=1,orien=Orientation.VERTICAL}, --vert, col is irrelevant 
        b={r=0,c=7,orien=Orientation.VERTICAL}, --vert, col is irrelevant
    },
    {
        --pink
        color = {r = 1.00,
        g = 0.70,
        b = 0.80,
        a = 1,
        fixed = 'g',
        cx=r,
        cy=b},
        a={r=0,c=4,orien=Orientation.VERTICAL}, --vert, col is irrelevant 
    },
    {
        --red
        color = {r = 0.90,
        g = 0,
        b = 0.15,
        a = 1,
        fixed = 'b',
        cx=r,
        cy=g},
        a={r=0,c=6,orien=Orientation.VERTICAL}, --vert, col is irrelevant 
        b={r=0,c=8,orien=Orientation.VERTICAL}, --vert, col is irrelevant
    },
    {
        --orange
        color = {r = 1,
        g = 0.40,
        b = 0.10,
        a = 1,
        fixed = 'b',
        cx=r,
        cy=g},
        a={r=0,c=2,orien=Orientation.VERTICAL}, --vert, col is irrelevant 
        b={r=0,c=6,orien=Orientation.VERTICAL}, --vert, col is irrelevant
        c={r=2,c=0,orien=Orientation.HORIZONTAL}, --horiz, row is irrelevant
    },
    {
        --yellow
        color = {r = 1,
        g = 1,
        b = 0.60,
        a = 1,
        fixed = 'b',
    
        cx=g,
        cy=r},
        a={r=0,c=8,orien=Orientation.VERTICAL}, --vert, col is irrelevant 
        b={r=0,c=4,orien=Orientation.VERTICAL}, --vert, col is irrelevant
        c={r=5,c=0,orien=Orientation.HORIZONTAL}, --horiz, row is irrelevant
        d={r=8,c=0,orien=Orientation.HORIZONTAL}, --horiz, row is irrelevant
    },
    {
        --green
        color = {r = 0.20,
        g = 1,
        b = 0.60,
        a = 1,
        fixed = 'r',
        cx=g,
        cy=b},
        a={r=0,c=3,orien=Orientation.VERTICAL}, --vert, col is irrelevant 
        b={r=0,c=7,orien=Orientation.VERTICAL}, --vert, col is irrelevant
        c={r=0,c=0,orien=Orientation.HORIZONTAL}, --horiz, row is irrelevant
        d={r=6,c=0,orien=Orientation.HORIZONTAL}, --horiz, row is irrelevant
        e={r=7.5,c=4,orien=Orientation.DIAG_ASC}, --diag +30deg
    },
    {
        --blue
        color = {r = 0,
        g = 0.40,
        b = 0.80,
        a = 1,
        fixed = 'r',
        cx=g,
        cy=b},
        a={r=0,c=0,orien=Orientation.VERTICAL}, --vert, col is irrelevant 
        b={r=0,c=6,orien=Orientation.VERTICAL}, --vert, col is irrelevant
        c={r=2,c=0,orien=Orientation.HORIZONTAL}, --horiz, row is irrelevant
        d={r=7,c=0,orien=Orientation.HORIZONTAL}, --horiz, row is irrelevant
        e={r=4,c=0.5,orien=Orientation.DIAG_ASC}, --diag +30deg
        f={r=7.5,c=4,orien=Orientation.DIAG_ASC}, --diag +30deg
    },
    {
        --purple
        color = {r = 0.50,
        g = 0,
        b = 1,
        a = 1,
        fixed = 'g',
        cx=b,
        cy=r},
        a={r=0,c=2,orien=Orientation.VERTICAL}, --vert, col is irrelevant 
        b={r=0,c=7,orien=Orientation.VERTICAL}, --vert, col is irrelevant
        c={r=1,c=0,orien=Orientation.HORIZONTAL}, --horiz, row is irrelevant
        d={r=6,c=0,orien=Orientation.HORIZONTAL}, --horiz, row is irrelevant
        e={r=4,c=0.5,orien=Orientation.DIAG_ASC}, --diag +30deg
        f={r=7.5,c=3,orien=Orientation.DIAG_ASC}, --diag +30deg
        g={r=0.5,c=5,orien=Orientation.DIAG_DEC}, --diag -30deg
    },
    {
        --pink
        color = {r = 1.00,
        g = 0.70,
        b = 1.00,
        a = 1,
        fixed = 'g',
        cx=r,
        cy=b},
        a={r=0,c=1,orien=Orientation.VERTICAL}, --vert, col is irrelevant 
        b={r=0,c=7,orien=Orientation.VERTICAL}, --vert, col is irrelevant
        c={r=1,c=0,orien=Orientation.HORIZONTAL}, --horiz, row is irrelevant
        d={r=4,c=0,orien=Orientation.HORIZONTAL}, --horiz, row is irrelevant
        e={r=2,c=0.5,orien=Orientation.DIAG_ASC}, --diag +30deg
        f={r=7.5,c=3,orien=Orientation.DIAG_ASC}, --diag +30deg
        g={r=2,c=0.5,orien=Orientation.DIAG_DEC}, --diag -30deg
        h={r=0.5,c=5,orien=Orientation.DIAG_DEC}  --diag -30deg
    },

    screens = {
        love.graphics.newImage('assets/sprites/backgrounds/GradientOne.png'),
        love.graphics.newImage('assets/sprites/backgrounds/GradientTwo.png'),
        love.graphics.newImage('assets/sprites/backgrounds/GradientThree.png'),
        love.graphics.newImage('assets/sprites/backgrounds/GradientFour.png'),
        love.graphics.newImage('assets/sprites/backgrounds/GradientFive.png'),
        love.graphics.newImage('assets/sprites/backgrounds/GradientSix.png'),
        love.graphics.newImage('assets/sprites/backgrounds/GradientSeven.png'),
        love.graphics.newImage('assets/sprites/backgrounds/GradientEight.png'),
        love.graphics.newImage('assets/sprites/backgrounds/GradientNine.png'),
        love.graphics.newImage('assets/sprites/backgrounds/GradientTen.png'),
        love.graphics.newImage('assets/sprites/backgrounds/GradientEleven.png'),
        love.graphics.newImage('assets/sprites/backgrounds/GradientTwelve.png'),
        love.graphics.newImage('assets/sprites/backgrounds/GradientThirteen.png'),
        love.graphics.newImage('assets/sprites/backgrounds/GradientFourteen.png'),
        love.graphics.newImage('assets/sprites/backgrounds/GradientFifteen.png')
    },
    inbetweens = {
        love.graphics.newImage('assets/sprites/backgrounds/InbetweenOne.png'),
        love.graphics.newImage('assets/sprites/backgrounds/InbetweenTwo.png'),
        love.graphics.newImage('assets/sprites/backgrounds/InbetweenThree.png'),
        love.graphics.newImage('assets/sprites/backgrounds/InbetweenFour.png'),
        love.graphics.newImage('assets/sprites/backgrounds/InbetweenFive.png'),
        love.graphics.newImage('assets/sprites/backgrounds/InbetweenSix.png'),
        love.graphics.newImage('assets/sprites/backgrounds/InbetweenSeven.png'),
        love.graphics.newImage('assets/sprites/backgrounds/InbetweenEight.png'),
        love.graphics.newImage('assets/sprites/backgrounds/InbetweenNine.png'),
        love.graphics.newImage('assets/sprites/backgrounds/InbetweenTen.png'),
        love.graphics.newImage('assets/sprites/backgrounds/InbetweenEleven.png'),
        love.graphics.newImage('assets/sprites/backgrounds/InbetweenTwelve.png'),
        love.graphics.newImage('assets/sprites/backgrounds/InbetweenThirteen.png'),
        love.graphics.newImage('assets/sprites/backgrounds/InbetweenFourteen.png')
    }
}
