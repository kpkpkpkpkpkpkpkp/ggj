items = {}
matrix = nil
local vector = require 'lib.vector'

itemdroptime = 8
function items.load()
    local i = love.graphics.newImage('assets/sprites/Items-Sheet.png')
    matrix = items.animation(i, 0.3)

--set up 15 as targets
--set up one as current target
--once the current target has been found, iterate to the next target
end

function items.animation(image, duration)
    local matrix = {}
    matrix.sheet = image
    matrix.tiles = {}
    matrix.targets = {19, 24, 28, 53, 18, 39, 54, 25, 32, 46, 8, 5, 42, 23, 10}
    matrix.targettext =
        {
            {colo = [[Entry 255:


At least colour hasn't been 
lost. Maybe some brighter 
shades are fading, but I 
clearly remember a rich 
purple. Maybe if I can tune 
the frequency lasers to it...
]],
item = [[...then I might be able to 
remember an boject I knew long 
ago. A smooth shining purple, 
not manufactured but still 
impervious and solid.]]
},
{colo = [[Entry 270:


While tuning several days ago, 
I found a deep colour, 
reminiscent of purple, but 
still unique. Not a light 
faded blue, but...
]], 
item = [[...dark blue, like I heard 
stories about. A substance so 
vast and transient that still 
held life deep inside.]]
},
{colo = [[Entry 275:


I had been searching for more 
ancient tales about oceans 
and seas, and discovered some 
small snippet about a 
mirroring colour, reflecting 
off surfaces of the seas...
]]
, item = [[...and that despite it being 
made of practically nothing, 
there were also things living 
there like the oceans.]]


},
{colo = [[Entry 276:


One of my trinkets 
disappeared yesterday. It 
was thought for a long time 
that manufactured substances 
hadn't vanished but I’ve 
seen otherwise. It was my 
favorite colour, a gentle 
mix of yellow and blue...
]]
, item = [[...and apparently 
there was organic matter of 
the same colour carpeting the 
ground. It was alive, and 
even housed and fed 
creatures in their own 
micro-environment.]]
 
},
{colo = [[Entry 300:


After some research into the 
very beginnings of the age 
of disappearance, I found a 
reference to an organic 
material, like ruby...]]

,
item = [[...But not hard 
nor tough. But still as 
shiny as little gems.]]
},
{colo = [[Entry 307:


Despite feeling thwarted 
nearly every day by 
disappearances, I’m pushing 
forward with my research. 
Searching through the dark 
annals with my bright light...
]]
, item = [[...I became curious about 
what a non-manufactured laser 
might have been like. Still 
in the process of searching 
one out.]]

},
{colo = [[Entry 320:


Maybe my memories of colours 
are also disappearing. I must 
still review them every day 
to fight against it. 
Something like my laser light, 
similar to its yellow 
but warmer...
]]
, item = [[...and more comfortable 
feeling. Orange, that’s right!]]
},
{colo = [[Entry 334:


It feels like my research is 
at its most difficult but I 
now feel more resolve than 
ever. I’ve been searching 
through databases and odds 
and ends until my fingers are 
pink...
]]
, item = [[...and I’m starting to think 
I may have exhausted all the 
documented resources 
available. Maybe it’s time I 
step outside on my own and 
see what could be left and 
start my own documentation. 
Even though it’s still night 
time, there’s no time to lose.]]

},
{colo = [[Entry 336:


Looking up into the night sky 
was a whole new experience. 
I’ve started setting myself 
reminders again for colour 
memories, so I don’t forget, 
starting with red...
]]

, item = [[...and traveling down through 
the spectrum until I reach 
purple. I have to keep hold 
of memories even as search 
out new ones. If I manage to 
venture out during the day 
hours, I’ll turn my gaze 
down. There my not be organic 
material left, but maybe 
there’s still something 
natural, laying still on the 
compacted ground.]]
            
},
{colo = [[Entry 340:


Today I’ll remember the 
colour just after red, the 
lower frequency; I always 
have trouble for 
some reason...
]]
                
                
                
, item = [[...with orange, I don’t know 
why. I wonder if there could 
be other edible fruits and 
what they would be to eat.]]
            
            
},
{colo = [[Entry 341:


After orange, I’ll tune to 
just a little lighter...
]]
                
, item = [[...and get ready for more 
first-hand research. I’ll 
search through the sky at day 
soon, and look for something 
I saw referenced once, that 
would float through it. 
Maybe there’s some left.]]
            
            
            
},
{colo = [[Entry 345:


Back to my favorite colour! 
I could never forget...
]]
                
, item = [[...especially now after all 
my research into green 
organic materials. Not only 
passive organics, but even 
sentient organics of the same 
colour.]]

},
{colo = [[Entry 349:


I started going back over my 
old notes, some of the first 
ones about the oceans. They 
must have had such a colour...
]]
, item = [[...and housed so many 
creatures. I can picture some 
of the creatures now, even 
the ones that were living but 
stationary.]]
            
},
{colo = [[Entry 352:


I’ve learned about so many 
types of organics, and now 
I’ve found a whole database 
on flowers. There’s a new 
one, the violet...
]]                                
,item = [[...along with so many others,
even some that are affiliated 
with water.]]
},
{colo = [[Entry 365:


Even though it’s not truly on 
the colour spectrum, pink has 
its place in nature...
]]
                
, item = [[...in flowers, fruits, 
insects, and so many things 
I’ve discovered. All the 
colours I know were once 
found in the natural world. 
Maybe using all the colours, 
and all the knowledge through 
my research, one day I can 
bring back some of what has 
been lost.]]}
}
matrix.foundloc = {vector(81, -2),
        vector(100, -2),
        vector(124, -2),
        vector(148, -2),
        vector(172, -2),
        vector(196, -2),
        vector(220, -2),
        vector(220, 28),
        vector(220, 52),
        vector(220, 76),
        vector(220, 100),
        vector(220, 124),
        vector(102, 230),
        vector(126, 230),
        vector(150, 230)
    }
    matrix.noness = {}
    matrix.next = 1
    matrix.currenttext = matrix.targettext[matrix.next]
    -- matrix.targets = {}
    for y = 28, 196, 24 do
        for x = 28, 196, 24 do
            tile = {
                tx = x,
                ty = y,
                tw = 24,
                th = 24,
                f1 = love.graphics.newQuad(x, y, 24, 24, image:getDimensions()),
                f2 = love.graphics.newQuad(x + 248, y, 24, 24, image:getDimensions()),
                d = duration,
                ct = 0,
                selected = false,
                dropped = false,
                target = false,
                ctarget = false,
                found = false,
                focus = false,
                itemdropcount = 0
            }
            --cx cy are center point, used to determine which items fall within a shape
            tile.cx = tile.tx + tile.tw / 2
            tile.cy = tile.ty + tile.th / 2
            table.insert(matrix.tiles, tile)
        end
    end
    for _, i in pairs(matrix.targets) do
        matrix.tiles[i].target = true
    end
    for i = 1, #matrix.tiles, 1 do
        if not matrix.tiles[i].target then
            table.insert(matrix.noness, i)
        end
    end
    
    matrix.tiles[matrix.targets[1]].ctarget = true
    
    matrix.duration = duration or 1
    
    return matrix
end --matrix.targets = {1, 2, 3, 4, 17, 18, 10, 25, 11, 12, 13, 14, 19, 21, 22}

function items.find(i)
    local tile = matrix.tiles[i]
    if not tile.dropped then
        if tile.ctarget == true then
            tile.found = true
            tile.ctarget = false
            tile.tx, tile.ty = matrix.foundloc[matrix.next]:unpack()
            tile.cx = tile.tx + tile.tw / 2
            tile.cy = tile.ty + tile.th / 2
            items.next()
            matrix.currenttext = matrix.targettext[matrix.next]
            return true
        else
            r = math.random(1, #matrix.noness)
            ri = matrix.noness[r]
            -- table.remove(matrix.noness, r)
            -- items.drop(i)
            items.drop(ri)
            return false
        end
    end
end

function items.reset()
    matrix.next=1
    for i, t in pairs(matrix.tiles) do
        t.ct = 0
        t.selected = false
        t.dropped = false
        t.target = false
        t.ctarget = false
        t.found = false
        t.focus = false
    end
end

function items.next()
    if matrix.next < 15 then
        matrix.next = matrix.next + 1
        
        ti = matrix.targets[matrix.next]
        matrix.tiles[ti].ctarget = true
        return matrix.tiles[matrix.next]
    else
        print('win!')
    end
end

function items.drop(i)
    tile = matrix.tiles[i]
    --if there is a specified tile, simply drop it
    if i then
        tile.dropped = true
    else
        --if no tile is specified, drop a random tile that isn't one of the correct choices
        r = math.random(1, #matrix.noness)
        ri = matrix.noness[r]
        tile = matrix.tiles[ri]
        if tile then
            tile.itemdropcount = itemdroptime
            tile.dropped = true
        end
    end
end

itemdropcount = 0

function items.update(dt)
    --itemdropcount is initialized when items.drop is called.
    
    mx, my = love.mouse.getPosition()
    for i, t in pairs(matrix.tiles) do
        if t.itemdropcount > 0 then
            t.itemdropcount = t.itemdropcount - (dt*itemdroptime)
        end
        if mx > t.tx and mx < t.tx + t.tw and my > t.ty and my < t.ty + t.th then
            t.selected = true
        else
            t.selected = false
        end
        t.ct = t.ct + dt
        if t.ct > 2 * t.d then t.ct = 0 end
    end
    -- timer = timer + (dt * 10)
    -- if timer % 2 == 0 then
    -- end
end

function items.draw()
    for i, t in pairs(matrix.tiles) do
        if not t.dropped and not t.found then
            if t.selected then
                if t.ct > t.d then
                    love.graphics.draw(matrix.sheet, t.f1, t.tx, t.ty)
                else
                    love.graphics.draw(matrix.sheet, t.f2, t.tx, t.ty)
                end
            else
                love.graphics.draw(matrix.sheet, t.f1, t.tx, t.ty)
            end
        elseif t.dropped and not t.found then
            local idc = 1-(t.itemdropcount/itemdroptime)
            r,g,b,a=love.graphics.getColor()
            love.graphics.setColor(r,g,b,a-idc) --reduce alpha
            love.graphics.draw(matrix.sheet, t.f1, t.tx, t.ty)
            love.graphics.setColor(r,g,b,a) --reset opacity
            
        end
    end
end


function items.drawfound()
    for i, t in pairs(matrix.tiles) do
        if t.found then
            if t.ct > t.d then
                love.graphics.draw(matrix.sheet, t.f1, t.tx, t.ty)
            else
                love.graphics.draw(matrix.sheet, t.f2, t.tx, t.ty)
            end
        end
    end
end