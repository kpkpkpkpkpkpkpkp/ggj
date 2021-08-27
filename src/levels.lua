
return {

    --mapping each vector's color center
    --numbers represent rows and columns, gaps between items
    --scale is to convert r/c into actual coordinates
    scale=1,
    --offset places 0 at top left of play area
    offset=24,
    --tolerance allows a certain area around point to be correct
    tolerance=12,
    --both diagonal coordinates are important

    --for diags, one of two coordinates needs to be n+1/2 and other needs to be a whole number.
    --this is because placement of diagonals needs to be between two items 
    -- rather than at the center intersection of a row/column
    --each vector's possible coordinates alternates between r being r+1/5 and c being c+1/5
    {
        --purple
        color = {r = 1,
        g = 0,
        b = 1,
        a = 1},
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
        a = 1},
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
        a = 1},
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
        a = 1},
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
        a = 1},
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
        a = 1},
        a={r=0,c=0},--vert, col is irrelevant 
        b={r=0,c=0},--vert, col is irrelevant
        c={r=0,c=0}--horiz, row is irrelevant
    },
    {
        --orange
        color = {r = 1,
        g = 1,
        b = 0,
        a = 1},
        a={r=0,c=0},--vert, col is irrelevant
        b={r=0,c=0}--vert, col is irrelevant
    },
    {
        --pink
        color = {r = 0.5,
        g = 0,
        b = 0,
        a = 1},
        a={r=0,c=0}--vert, col is irrelevant
    },
    {
        --red?
        color = {r = 1,
        g = 0,
        b = 0,
        a = 1},
        a={r=0,c=0},--vert, col is irrelevant 
        b={r=0,c=0}--vert, col is irrelevant
    },
    {
        --orange?
        color = {r = 1,
        g = 1,
        b = 0,
        a = 1},
        a={r=0,c=0},--vert, col is irrelevant 
        b={r=0,c=0},--vert, col is irrelevant
        c={r=0,c=0}--horiz, row is irrelevant
    },
    {
        --yellow
        color = {r = 1,
        g = 1,
        b = 1,
        a = 1},
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
        a = 1},
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
        a = 1},
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
        a = 1},
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
        a = 1},
        a={r=0,c=0}, --vert, col is irrelevant 
        b={r=0,c=0}, --vert, col is irrelevant
        c={r=0,c=0}, --horiz, row is irrelevant
        d={r=0,c=0}, --horiz, row is irrelevant
        e={r=0,c=0}, --diag +30deg
        f={r=0,c=0}, --diag +30deg
        g={r=0,c=0}, --diag -30deg
        h={r=0,c=0}  --diag -30deg
    } 
}
