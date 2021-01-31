items = {}
animation = nil
local vector = require 'lib.vector'

function items.load()
    local i = love.graphics.newImage('assets/Items-Sheet.png')
    animation = items.animation(i, 0.3)

--set up 15 as targets
--set up one as current target
--once the current target has been found, iterate to the next target
end

function items.animation(image, duration)
    local animation = {}
    animation.sheet = image
    animation.tiles = {}
    animation.targets = {19, 18, 28, 53, 20, 39, 54, 25, 32, 46, 56, 5, 42, 44, 10}
    animation.targettext =
        {
            {colo = [[Entry 255:
At least colour is still present. 
Maybe some shades of the brighter 
tones are fading, but I remember 
clearly rich purple. If I can tune 
the frequency lasers to it..
]]
                
                
                
                
                
                ,
                item = [[...then I can also remember 
more clearly a description from long 
ago of smooth shining purple, not 
manufactured but still 
impervious and solid.]]
            
            
            
            },
            {colo = [[Entry 275:
I had been searching for more ancient 
tales about ‘oceans’ and ‘seas’, and 
discovered some small snippet about 
a mirroring colour, reflecting off 
surfaces of the seas...
]]
                
                
                
                
                
                , item = [[...and that despite it 
being made of practically nothing, it 
also housed sentient life, like the 
oceans.]]
            
            
            },
            {colo = [[Entry 276:
I had a trinket disappear yesterday. 
It was thought for a long time that only 
non-manufactured substances disappeared but 
I’ve seen otherwise. It was my favorite colour, 
a gently mix of yellow and blue...
(tune to green)
]]
                
                
                
                
                
                
                , item = [[...and apparently there was organic 
matter of the same colour, carpeting the ground 
as “grass”. It was alive, and even housed and 
fed creatures in their own micro-environment.]]
            
            
            },
            {colo = [[Entry 300:
After some research into the very beginnings of the 
age of disappearance, I found a reference 
to an organic material, like ruby...]]
                
                
                ,
                item = [[...But not hard and tough, 
but still shiny like little gems.]]
            },
            {colo = [[Entry 307:
Despite feeling thwarted nearly every day by 
disappearances, I’m pushing forward with my 
research. Searching through the dark annals 
with my bright light...
]]
                
                
                
                
                , item = [[...I became curious about what a 
non-manufactured laser might have been. 
Still in the process of searching out.]]
            
            },
            {colo = [[Entry 320:
Maybe my memories of colours are also disappearing. 
I must still review them every day, and fight 
against it. Something like my laser light, 
similar to its yellow but warmer...
]]
                
                
                
                
                , item = [[...and more comfortable feeling. 
Orange, that’s right!]]
            },
            {colo = [[Entry 334:
It feels like my research is at its most difficult 
but I now feel more resolved than ever. I’ve been 
searching through databases and odds and ends 
until my fingers are pink...
]]
                
                
                
                
                , item = [[...and I’m starting to think I may 
have exhausted all the documented resources available. 
Maybe it’s time I step outside on my own and see what 
could be left and start my own documentation. 
Even though it’s still night time, there’s no 
time to lose.]]
            
            
            
            
            },
            {colo = [[Entry 336:
Looking up into the night sky was a whole new 
experience. I’ve started setting myself reminders 
again for colour memories, so I don’t forget, 
starting with red...
]]
                
                
                
                
                , item = [[...and traveling down through the 
spectrum until I can reach purple. I have to 
keep hold of memories even as search out 
new ones. If I manage to venture out during 
the day hours, I’ll turn my gaze down. There 
my not be organic material left, but maybe 
there’s still something natural, 
laying still on the compacted ground.]]
            
            
            
            
            
            
            },
            {colo = [[Entry 340:
Today I’ll remember the colour just 
after red, the lower frequency; 
I always have trouble for some reason...
]]
                
                
                
                , item = [[...with orange, I don’t 
know why. I wonder if there could 
be other “edible fruits” and what 
it would be to eat.]]
            
            
            },
            {colo = [[Entry 341:
After orange, I’ll tune to just a little lighter...
]]
                
                , item = [[...and get ready for another 
first-hand research. I’ll search through 
the sky at day soon, and look for something 
I saw referenced once, that would float 
through it. Maybe there’s some left.]]
            
            
            
            },
            {colo = [[Entry 345:
Back to my favorite colour! I never forget...
]]
                
                , item = [[...especially now after all my 
research into green organic materials. 
Not only passive organics, but even 
sentient organics of the same colour.]]
            
            
            },
            {colo = [[Entry 349:
I started going back over my old notes, 
some of the first ones about the oceans. 
They must have had such a colour...
]]
                
                
                
                , item = [[...and housed so many creatures. 
I can picture some of the creatures now, 
even the ones that were living but stationary.]]
            
            },
            {colo = [[Entry 352:
I’ve learned about so many types of 
organics, and now I’ve found a whole 
database on flowers. There’s a new 
one, the violet...
]]
                
                
                
                
                , item = [[...along with so many others,
even some water affiliated ones.]]
            },
            {colo = [[Entry 365:
Even though it’s not truly on the colour 
spectrum, pink has it’s place in nature...
]]
                
                
                , item = [[...in flowers, fruits, insects, 
and so many things I’ve discovered. All the 
colours I know everyday were once reflected 
in the natural world. Maybe using all the 
colours, and all the knowledge through my 
research, one day I can bring back some 
of what has been lost.]]
            
            
            
            
            
            },
        }
    animation.foundloc = {vector(81, -2),
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
    animation.noness = {}
    animation.next = 1
    animation.currenttext = animation.targettext[animation.next]
    -- animation.targets = {}
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
                focus = false
            }
            --cx cy are center point, used to determine which items fall within a shape
            tile.cx = tile.tx + tile.tw / 2
            tile.cy = tile.ty + tile.th / 2
            table.insert(animation.tiles, tile)
        end
    end
    for _, i in pairs(animation.targets) do
        animation.tiles[i].target = true
    end
    for i = 1, #animation.tiles, 1 do
        if not animation.tiles[i].target then
            table.insert(animation.noness, i)
        end
    end
    
    animation.tiles[animation.targets[1]].ctarget = true
    
    animation.duration = duration or 1
    
    return animation
end --animation.targets = {1, 2, 3, 4, 17, 18, 10, 25, 11, 12, 13, 14, 19, 21, 22}

function items.find(i)
    local tile = animation.tiles[i]
    if not tile.dropped then
        if tile.ctarget == true then
            tile.found = true
            tile.ctarget = false
            tile.tx, tile.ty = animation.foundloc[animation.next]:unpack()
            tile.cx = tile.tx + tile.tw / 2
            tile.cy = tile.ty + tile.th / 2
            items.next()
            return true
        else
            r = math.random(1, #animation.noness)
            ri = animation.noness[r]
            table.remove(animation.noness, r)
            items.drop(ri)
            return false
        end
    end
end

function items.next()
    if animation.next < 15 then
        animation.next = animation.next + 1
        
        ti = animation.targets[animation.next]
        animation.tiles[ti].ctarget = true
        animation.currenttext = animation.targettext[animation.next]
        return animation.tiles[animation.next]
    else
        print('win!')
    end
end

function items.drop(i)
    tile = animation.tiles[i]
    if i then
        tile.dropped = true
    else
        r = math.random(1, #animation.noness)
        ri = animation.noness[r]
        tile = animation.tiles[ri]
        if tile then
            tile.dropped = true
        end
    end
end

timer = 0
function items.update(dt)
    mx, my = love.mouse.getPosition()
    for i, t in pairs(animation.tiles) do
        -- print(t.tx,t.ty)
        -- print(mx,my,t.tx,)
        if mx > t.tx and mx < t.tx + t.tw and my > t.ty and my < t.ty + t.th then
            t.selected = true
        else
            t.selected = false
        end
        t.ct = t.ct + dt
        if t.ct > 2 * t.d then t.ct = 0 end
    end
    timer = timer + (dt * 10)
    if timer % 2 == 0 then
        end

end

function items.draw()
    for i, t in pairs(animation.tiles) do
        if not t.dropped and not t.found then
            if t.selected then
                if t.ct > t.d then
                    love.graphics.draw(animation.sheet, t.f1, t.tx, t.ty)
                else
                    love.graphics.draw(animation.sheet, t.f2, t.tx, t.ty)
                end
            else
                love.graphics.draw(animation.sheet, t.f1, t.tx, t.ty)
            end
        end
    end
end


function items.drawfound()
    for i, t in pairs(animation.tiles) do
        if t.found then
            if t.ct > t.d then
                love.graphics.draw(animation.sheet, t.f1, t.tx, t.ty)
            else
                love.graphics.draw(animation.sheet, t.f2, t.tx, t.ty)
            end
        
        end
    end
end
