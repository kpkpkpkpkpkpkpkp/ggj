local vector = require 'lib.vector'
require 'lib.sets'
HC = require 'lib.HC'
Polygon = require 'lib.HC.polygon'
require 'src.sounds'
require 'src.items'
require 'src.split_poly'
game = {}
apoints = {}
bg = {x = 0, y = 0}
scrollspeed = 1

x, y, dx, dy = 0, 0, 300, 140
--color centers (track where the mouse was when the line was palced)
cpoints = {}

ashapes = {}

-- Current vectors tracked by the mouse. Current color of vectors is also included
cvects = {color = {r = 255 / 255, g = 255 / 255, b = 255 / 255},
    colorcenter = {x = 0, y = 0}}
res = {x = 248, y = 248}
bgwidth = 720
-- All vectors placed on the screen
avects = {}
mode = {play = true, display = true,win=false}
-- Coords + image
buttons = require 'src.buttons'
lock = false
holding = false
lastbutton = nil
function game.load()
    -- love.audio.setVolume(0)
    font = love.graphics.newFont('assets/fonts/VT323-Regular.ttf', 80)
    font:setFilter('nearest', 'nearest')
    sounds.load()
    items.load()
    collider = HC.new()
    bgcanvas = love.graphics.newCanvas(bgwidth, res.x)
    border = love.graphics.newImage('assets/Screen.png')
    credits = love.graphics.newImage('assets/sprites/EndAnimation-Sheet.png')
    game.credits()
    dispbutton = love.graphics.newImage('assets/sprites/ButtonDisplay.png')
    display1 = love.graphics.newImage('assets/sprites/FullDisplayFile1.png')
    display2 = love.graphics.newImage('assets/sprites/FullDisplayFile2.png')
    display = display2
    displayct = 0
    screen = love.graphics.newImage('assets/ScreenBackground.png')
    cur = love.mouse.getSystemCursor("hand")
    love.mouse.setCursor(cur)
    
    --this is the bounding polygon for area detection. Use it to re-init the ashapes table when it needs to be cleared.
    shape = Polygon(20, 20, res.x - 20, 20, res.x - 20, res.y - 20, 20, res.y - 20)
    --Color can be used for debug but it will start off clear
    shape.colo = {
        0 / 255,
        255 / 255,
        160 / 255,
        0
    }
    table.insert(ashapes, shape)

end


function game.credits()
    quads={}
    for i=0,credits:getWidth(),248 do
        table.insert(quads,love.graphics.newQuad(i,0,248,744,credits:getWidth(),credits:getHeight()))
    end
    cquad=quads[1]
    credct=0
    credy=res.y-credits:getHeight()
speed=4
quadcount=1
credscrollspeed=30
end

function game.addshapepoints(points, shape)
    pts = {shape:unpack()}
    for i = 1, #pts - 1, 2 do
        table.insert(points, {p1 = pts[i], p2 = pts[i + 1]})
    end
end

function game.addintersects(points, shape, x, y, dx, dy)
    ray_parameters = shape:intersectionsWithRay(x, y, dx, dy)
    v1 = vector(x, y)
    v2 = vector(dx, dy)
    for i, rp in pairs(ray_parameters) do
        iv = v1 + (v2 * rp)
        ix, iy = iv:unpack()
        table.insert(points, {p1 = ix, p2 = iy})
    end
    return shape:intersectsRay(x, y, dx, dy)
end

function game.update(dt)
    if credy < 0 then 
        credy=credy+(dt*credscrollspeed) 
        credct=credct+(dt*speed)
        if credct>1 and #quads > quadcount then
            cquad=quads[quadcount]
            quadcount=quadcount+1
            credct=0
        end
    end
    
    mx, my = love.mouse.getPosition()
    bg.x = bg.x - scrollspeed
    if bg.x < -screen:getWidth() then bg.x = 0 end
    
    if mode.display then
        dispaly = display2
        if displayct > 2 then
            displayct = 0
        else
            displayct = displayct + dt
        end
    else
        if not locked then items.update(dt) end
        
        ww = love.graphics.getWidth()
        wh = love.graphics.getHeight()
        
        
        
        rm = {}
        
        cpoints = {}
        --FIND INTERSECTS
        for i, shape in pairs(ashapes) do
            for j, v in pairs(cvects) do
                
                if j ~= 'color' and j ~= 'colorcenter' then
                    game.addintersects(cpoints, shape, mx, my, v.x, v.y)
                end
            end
        end
        
        --this is for things relating to the currently held vectors
        --Changes color based on mouse position.
        --TODO: Right now, any line will always create the same color when the mouse is in the same position on the screen.
        --WANT to make an offset per-button per-level that 'shifts' the location of colors for that line.
        --FOR EXAMPLE: White is always at the max width and height. We can change the position of white to a different location, which will shift where the line needs to be placed for the color to work.
        v = cvects['color']
        cc = cvects['colorcenter']
        if v and cc then
            cx, cy = cc.x, cc.y
            v.r = (((mx + cx) % 255) / 255)
            v.b = (((my + cy) % 255) / 255)
            v.g = 0 / 255 -- (my-mx/255)
        end
    
    --Once all lines are on the screen, they all need to be close to the same color or it won't work! (drop all the lines) (within some tolerance) That's all the color checking we need to do
    --Then check any intersected areas. Any one of them that has the item we are currently looking for gets higlighted. If none have the item, bad sound plays and drop all the lines.
    --If after this there is a highlighted area, the player can now click on the items in the area. Clicking on wrong ones causes something to fall off randomly.
    end
end

function game.draw()
    if mode.win then        
        love.graphics.draw(credits,cquad,0,credy)
    else
        
        
        love.graphics.draw(screen, bg.x, bg.y)
        love.graphics.draw(screen, bg.x + screen:getWidth(), bg.y)
        
        items.draw()
        for i, shape in pairs(ashapes) do
            love.graphics.setColor(shape.colo)
            love.graphics.polygon('fill', shape:unpack())
            love.graphics.setColor(shape.colo)
            love.graphics.polygon('line', shape:unpack())
        end
        love.graphics.setColor(255, 255, 255)
        
        mx, my = love.mouse.getPosition()
        ww = love.graphics.getWidth()
        wh = love.graphics.getHeight()
        love.graphics.setLineStyle('rough')
        love.graphics.setLineWidth(3)
        -- Draw lines for vects array
        for i, vgrp in pairs(avects) do
            -- vgrp corresponds to a previous cvects (avects is saved current vector tables that include a color)
            love.graphics.setColor(vgrp.vs['color'].r, vgrp.vs['color'].g,
                vgrp.vs['color'].b, vgrp.vs['color'].a)
            
            for i, v in pairs(vgrp.vs) do
                if i ~= 'color' and i ~= 'colorcenter' then
                    love.graphics.line(vgrp.x, vgrp.y, v.x + vgrp.x, v.y + vgrp.y)
                end
            end
        end
        if cvects.color then
            love.graphics.setColor(cvects['color'].r,
                cvects['color'].g,
                cvects['color'].b,
                cvects['color'].a)
        end
        for i, v in pairs(cvects) do
            if i ~= 'color' and i ~= 'colorcenter' then
                -- these vectors extend from the cursor. create a cursor vector and add the two to get final position.
                vx, vy = v:unpack()
                love.graphics.line(mx, my, vx + mx, vy + my)
            end
        end
        
        love.graphics.setColor(255, 255, 255)
        items.draw()
        
        love.graphics.draw(border, 0, 0)
        items.drawfound()
        
        love.graphics.setNewFont(10)

        -- disparea = {x = 228, y = 228, w = 228 + 16, h = 228 + 16}
        love.graphics.draw(dispbutton,
                        228,
                        228)
    
    --journal
        for i, button in pairs(buttons) do
            if not button.dropped then
                if button.pressed then
                    love.graphics.draw(button.spritep,
                        button.x,
                        button.y)
                    love.graphics.setColor(0, 0, 255)
                    -- love.graphics.print(i,
                    --     button.x,
                    --     button.y)
                    love.graphics.setColor(255, 255, 255)
                else
                    
                    love.graphics.draw(button.sprite, button.x, button.y)
                    love.graphics.setColor(0, 0, 255)
                    -- love.graphics.print(i,
                    --     button.x,
                    --     button.y)
                    love.graphics.setColor(255, 255, 255)
                end
            
            end
        end
        
        if mode.display then
            deffont = love.graphics.getFont()
            love.graphics.draw(display, 0, 0)
            
            love.graphics.setFont(font)
            love.graphics.setColor(0, 0, 255, 255)
            love.graphics.print(animation.currenttext.colo, 10, 10, 0, 0.2, 0.2)
            if colorsset then
                love.graphics.print(animation.currenttext.item, 10, 130, 0, 0.2, 0.2)
            end
            love.graphics.setFont(deffont)
        
        end
    
    end
    love.graphics.setColor(255, 255, 255)
end

function love.keypressed(key, isrepeat)
    if key == 'escape' then
        game.reset()
    end
end

function game.reset()
    
    avects = {}
    apoints = {}
    cpoints = {}-- initial shape
    cvects = {}-- initial shape
    ashapes = {shape}-- initial shape
    for i, t in pairs(animation.tiles) do
        t.focus = false
        t.selected = false
    end
    for i, button in pairs(buttons) do
        button.down = false
        button.pressed = false
    end
    sounds.playnone()
    love.mouse.setVisible(true)
    locked = false
    colorsset = false
    
    mode.display = true
end

function game.colorsmatch(colo1, colo2, tolerance)
    if DEBUG then return true end
    r1 = colo1.r * 255
    g1 = colo1.g * 255
    b1 = colo1.b * 255
    
    r2 = colo2.r * 255
    g2 = colo2.g * 255
    b2 = colo2.b * 255
    
    rboundlow, rboundhigh = r1 - tolerance, r1 + tolerance
    gboundlow, gboundhigh = g1 - tolerance, g1 + tolerance
    bboundlow, bboundhigh = b1 - tolerance, b1 + tolerance
    if rboundhigh < r2 or rboundlow > r2 then
        return false
    end
    if gboundhigh < g2 or gboundlow > g2 then
        return false
    end
    if bboundhigh < b2 or bboundlow > b2 then
        return false
    end
    return true
end

function love.mousepressed(argx, argy, button, istouch, presses)
    -- Add current mouse position to vects array
    argx, argy = love.mouse.getPosition()
    wasbutton = false
    c = nil
    if not mode.display then
        
        
        --button section
        for i, button in pairs(buttons) do
            if argx > button.x and argx < button.x + button.sprite:getWidth() and
                argy > button.y and argy < button.y + button.sprite:getHeight() then
                love.audio.play(button.clickd)
                wasbutton = true
                if button.pressed and button == lastbutton then
                    -- cvects = {color = button.color}
                    locked = false
                    button.pressed = not button.pressed
                else
                    if not locked and not button.down then
                        lastbutton = button
                        -- generate new vectors tied to the cursor for this button
                        mag = 400
                        if cvects.colorcenter then
                            cvects.colorcenter.x = button.colorcenter.x
                            cvects.colorcenter.y = button.colorcenter.y
                        else
                            
                            cvects.colorcenter = {x = 0, y = 0}
                        end
                        cvects.color = button.color
                        for i, v in pairs(button.vectors) do
                            
                            table.insert(cvects, mag * v)
                        end
                        -- love.mouse.setVisible(false)
                        sounds.playmore()
                        locked = true
                        button.pressed = not button.pressed
                    end
                end
            end
        end
        
        -- if we are inside the viewing area, place the current vectors on the screen
        if not wasbutton and locked then
            lastbutton.down = true
            vgrp = {
                x = argx,
                y = argy,
                -- this needs to be deep copy
                vs = cvects
            }
            match = true
            --go through avects and verify whether they're all the same color
            for i, colvg in pairs(avects) do
                if not game.colorsmatch(colvg.vs.color, vgrp.vs.color, 100) then
                    --error and drop!
                    match = false
                    game.reset()
                end
            end
            if match then
                
                --insert the vector and
                table.insert(avects, vgrp)
                -- table.insert(apoints, {p1 = argx, p2 = argy})
                if cvects.colorcenter then
                    cvects = {colorcenter = {x = cvects.colorcenter.x, y = cvects.colorcenter.y}}
                else
                    cvects = {colorcenter = {x = 0, y = 0}}
                end
                love.mouse.setVisible(true)
                -- cvects = {color = cvects.color}
                locked = false
                if butt.alldown(buttons) then
                    colorsset = true
                    mode.display = true
                end
                
                ps = {}
                rm = {}
                for i, shape in pairs(ashapes) do
                    --NEXT do this for each line in avects
                    --vgrp is a group of two vectors "radiating" from a point. Each of the two vectors might
                    --intersect with the current shape either zero, one, or two times, but only two times combined between the two vecotrs.
                    --compose a line using two of the intersect points, and pass that line into the split function
                    pts = {}
                    for k, v in pairs(vgrp.vs) do
                        if k ~= 'color' and k ~= 'colorcenters' then
                            --This is for adding the points to the screen for debugging
                            intr = game.addintersects(apoints, shape, vgrp.x, vgrp.y, v.x, v.y)
                            if intr then
                                --This is added in order to split this shape. If there aren't any intersects then we want to keep the shape
                                game.addintersects(pts, shape, vgrp.x, vgrp.y, v.x, v.y)
                            -- else
                            --     table.insert(ps, shape)
                            end
                        end
                    end
                    if intr and #pts >= 2 then
                        p = pts[1]
                        q = pts[2]
                        poly1, poly2 = split_poly(shape, p.p1, p.p2, q.p1 - p.p1, q.p2 - p.p2)
                        table.insert(ps, poly1)
                        table.insert(ps, poly2)
                    end
                end
                ashapes = {}
                for _, poly in pairs(ps) do
                    table.insert(ashapes, poly)
                end
                
                for i, shape in pairs(ashapes) do
                    foundtarget = false
                    selecteditems = {}
                    for i, t in pairs(animation.tiles) do
                        if shape:contains(t.cx, t.cy) then
                            if t.ctarget then
                                foundtarget = true
                            end
                            table.insert(selecteditems, t)
                        end
                    end
                    if not foundtarget then
                        shape.colo = {
                            250 / 255,
                            210 / 255,
                            100 / 255,
                            0.5
                        
                        }
                        for i, t in pairs(selecteditems) do
                            t.focus = false
                        end
                    else
                        for i, t in pairs(selecteditems) do
                            t.focus = true
                        end
                        shape.colo[4] = 0
                    end
                end
            end
        elseif not locked then
            
            --item section
            if animation then
                for i, tile in pairs(animation.tiles) do
                    if tile and tile.focus and butt.alldown(buttons) then
                        --enter displaymode
                        if argx > tile.tx and argx < tile.tx + tile.tw and
                            argy > tile.ty and argy < tile.ty + tile.th then
                            found = items.find(i)
                            if found then
                                game.reset()
                                win = butt.progress(buttons)
                                if win then
                                    mode.win = true
                                end
                            end
                        end
                    end
                
                
                end
            end
        end
    end
    --journal
    disparea = {x = 228, y = 228, w = 228 + 16, h = 228 + 16}
    if not mode.display and argx > disparea.x and argx < disparea.w and
        argy > disparea.y and argy < disparea.h then
        --pause and show journal
        mode.display = true
    end
    
    disparea = {x = 219, y = 14, w = 232, h = 27}
    if mode.display and argx > disparea.x and argx < disparea.w and
        argy > disparea.y and argy < disparea.h then
        mode.display = false
    end
end


function love.mousereleased(argx, argy, button, istouch, presses)
    -- Add current mouse position to vects array
    argx, argy = love.mouse.getPosition()
    
    for i, button in pairs(buttons) do
        
        if argx > button.x and argx < button.x + button.sprite:getWidth() and
            argy > button.y and argy < button.y + button.sprite:getHeight() then
            love.audio.play(button.clicku)
            if button.pressed then
                
                cvects.color = button.color
                if cvects.colorcenter then
                    cvects.colorcenter.x = button.colorcenter.x
                    cvects.colorcenter.y = button.colorcenter.y
                else
                    
                    cvects.colorcenter = {x = 0, y = 0}
                end
            end
        end
    end
end
