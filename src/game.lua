require 'lib.sets'
HC = require 'lib.HC'
Polygon = require 'lib.HC.polygon'
local vector = require 'lib.vector'
local buttons = require 'src.buttons'
require 'src.sounds'
require 'src.items'
require 'src.split_poly'
local levels = require 'src.levels'

releasecounter = 0
game = {}
mode = {play = false, 
        display = false, 
        win = false, 
        title = true}

bg = {x = 0, y = 0}
scrollspeed = 1

x, y, dx, dy = 0, 0, 300, 140
--color centers (track where the mouse was when the line was palced)
ashapes = {}

-- Current vectors tracked by the mouse. Current color of vectors is also included
cvects = {color = {r = 1, g = 1, b = 1}, colorcenter = {x = 0, y = 0}}
res = {x = 248, y = 248}
ibwidth = 720
bgwidth = 720
-- All vectors placed on the screen
avects = {}

--click anywhere to start and switch to play=true and display=true
-- Coords + image
lock = false
holding = false
lastbutton = nil

function game.load()
    -- love.audio.setVolume(0.5)
    love.audio.setVolume(0)
    cur = love.mouse.getSystemCursor("hand")
    love.mouse.setCursor(cur)
    
    
    font = love.graphics.newFont('assets/fonts/VT323-Regular.ttf', 80)
    font:setFilter('nearest', 'nearest')
    -- collider = HC.new()
    bgcanvas = love.graphics.newCanvas(bgwidth, res.x)
    border = love.graphics.newImage('assets/Screen.png')
    title = love.graphics.newImage('assets/sprites/TitleScreenWMNMachine.png')
    
    dispbutton = love.graphics.newImage('assets/sprites/ButtonDisplay.png')
    display1 = love.graphics.newImage('assets/sprites/FullDisplayFile1.png')
    display2 = love.graphics.newImage('assets/sprites/FullDisplayFile2.png')
    display = display2
    displayct = 0
    

    
    game.progress()
    
    --this is the bounding polygon for area detection. Use it to re-init the ashapes table when it needs to be cleared.
    --Color can be used for debug but it will start off clear
    shape = Polygon(20, 20, res.x - 20, 20, res.x - 20, res.y - 20, 20, res.y - 20)
    shape.colo = {1, 1, 1, 0}
    table.insert(ashapes, shape)
    sounds.load()
    items.load()
    game.credits()
end

function game.progress()
    level.progress(levels)
    screen = level.screen(levels)
    inbetween = level.inbetween(levels)
    --this is going to switch between the screens and
    --inbetweens after we switch to a new level
    currentbg = screen
    targetcolor = level.getcolor(levels)
end

function game.credits()
    credits = love.graphics.newImage('assets/sprites/EndAnimation-Sheet.png')
    quads = {}
    for i = 0, credits:getWidth(), 248 do
        table.insert(quads, love.graphics.newQuad(i, 0, 248, 744, credits:getWidth(), credits:getHeight()))
    end
    cquad = quads[1]
    credct = 0
    credy = res.y - credits:getHeight()
    speed = 4
    quadcount = 1
    credscrollspeed = 30
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
    mx, my = love.mouse.getPosition()
    
    if mode.title then
        love.audio.play(openingbg)
    elseif mode.win then
        game.reset()
        love.audio.play(endingbg)
        --credits
        if credy < 0 then
            credy = credy + (dt * credscrollspeed)
            credct = credct + (dt * speed)
            if credct > 1 and #quads > quadcount then
                cquad = quads[quadcount]
                quadcount = quadcount + 1
                credct = 0
            end
        end
    elseif mode.display then
        dispaly = display2
        if displayct > 2 then
            displayct = 0
        else
            displayct = displayct + dt
        end
    else
        --scroll the gradient
        bg.x = bg.x - scrollspeed
        if bg.x < -screen:getWidth() then bg.x = 0 end
        if not locked then items.update(dt) end
        
        ww = love.graphics.getWidth()
        wh = love.graphics.getHeight()
        
        --this updates the color of the currently held vectors 
        --based on mouse position and level constants
        game.updatecolor(mx,my)

    end
end

function game.draw(debuglines)
    if mode.title then
        love.graphics.draw(title, 0, 0)
    elseif mode.win then
        love.graphics.draw(credits, cquad, 0, credy)
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
            if vgrp.vs.color then
                love.graphics.setColor(vgrp.vs['color'].r, 
                    vgrp.vs['color'].g,
                    vgrp.vs['color'].b, 
                    vgrp.vs['color'].a)
            end
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
        
            for i, button in pairs(buttons) do
                if not button.dropped then
                if button.pressed then
                    love.graphics.draw(button.spritep,
                    button.x,
                    button.y)
                    love.graphics.setColor(0, 0, 255)
                    love.graphics.setColor(255, 255, 255)
                else
                    
                    love.graphics.draw(button.sprite, button.x, button.y)
                    love.graphics.setColor(0, 0, 255)
                    love.graphics.print(i,
                    button.x,
                    button.y)
                    love.graphics.setColor(255, 255, 255)
                end
            end
        end
        
        --journal
        if mode.display then
            deffont = love.graphics.getFont()
            love.graphics.draw(display, 0, 0)
            
            love.graphics.setFont(font)
            love.graphics.setColor(0, 0, 255, 255)
            love.graphics.print(matrix.currenttext.colo, 10, 10, 0, 0.2, 0.2)
            if colorsset then
                love.graphics.print(matrix.currenttext.item, 10, 130, 0, 0.2, 0.2)
            end
            love.graphics.setFont(deffont)
        end
    end
    
    if DEBUG then
        tc=level.getcolor(levels)
        love.graphics.setColor(tc.r, 
        tc.g, 
        tc.b,
        tc.a)
        love.graphics.rectangle('fill', 2, 2, 8, 8)
        debuglines[6] = ' target for square r=' .. tc.r .. ' g=' .. tc.g .. ' b=' .. tc.b
        
        if cvects.color then
            fixcolor = tc.fixed        
            cc = cvects.colorcenter
            tx,ty=tc.cx,tc.cy
            cx = math.abs(cc.x - mx)/res.x
            cy = math.abs(cc.y - my)/res.y
            
            debuglines[5] = 'r=' .. cvects['color'].r .. ' g=' .. cvects['color'].g .. ' b=' .. cvects['color'].b
            debuglines[4] = 'cc location '..cc.x..', '..cc.y
            debuglines[3] = 'shift values '..cx..', '..cy
            debuglines[2] = 'releasecounter ' .. releasecounter
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
    cvects = {}-- initial shape
    ashapes = {shape}-- initial shape
    for i, t in pairs(matrix.tiles) do
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

function game.startgame()
    mode.title = false
    mode.display = true
    mode.play = true
    openingbg:stop()
end

function game.gototitle()
    mode.title = true
    mode.display = false
    mode.play = false
    openingbg:play()
end

function game.createvectors(button)
    mag = 400
    coords = level.getcenter(levels,button.label)
    if not cvects.colorcenter then
        cvects.colorcenter = {}
    end
    cvects.colorcenter.x = coords.x
    cvects.colorcenter.y = coords.y
    

    for i, v in pairs(button.vectors) do
        table.insert(cvects, mag * v)
    end
    -- love.mouse.setVisible(false)
    sounds.playmore()
end

function game.updatecolor(mx,my)
    --this indicates the color that should be displayed at the color center
    target = level.getcolor(levels)
    --this is for things relating to the currently held vectors
    --Changes color based on mouse position.
    -- offset per-button per-level that 'shifts' the location of colors for that line towards a target.
    --FOR EXAMPLE: White is always at the max width and height. We can change the position of white to a different location, which will shift where the line needs to be placed for the color to work.
    
    --these coordinates were saved to the collection based on the pressed button when the vectors were created
    cc = cvects.colorcenter
    if cvects.color and cc then
        -- at (color center (scaled to window coordinates) - mouse position=0), we want to set color to the level target.
        -- The correct function is as follows: 
        -- normalize each value to a number between 0 and 1, subtract one from the other, 
        -- then subtract the absolute value of this number from target color.
        -- color center is initially defined by row/column, and then scaled to play area coordinates
        -- mouse position is already at play area coordinates
        cx = math.abs(cc.x - mx)/200
        cy = math.abs(cc.y - my)/200
        
        if target.fixed == 'r' then 
            cvects.color.g = target.g - cx
            cvects.color.b = (target.b - cy)
        elseif target.fixed == 'g' then
            cvects.color.r = (target.r - cx)
            cvects.color.b = target.b - cy
        elseif target.fixed == 'b' then
            cvects.color.r = target.r - cy
            cvects.color.g = (target.g - cx)
        end
    end
end

function game.buttonclicked(argx, argy, button, istouch, presses)
    local lastbutton = nil
    local wasbutton = false
    --button section
    if mode.display then
        --close display button
        cdisparea = {x = 219, y = 14, w = 232, h = 27}
        if mode.display and argx > cdisparea.x and argx < cdisparea.w and
            argy > cdisparea.y and argy < cdisparea.h then
            mode.display = false
        end
    elseif mode.play then
        --open display button
        --todo fix journal buttons
        disparea = {x = 228, y = 228, w = 228 + 16, h = 228 + 16}
        if not mode.display and argx > disparea.x and argx < disparea.w and
            argy > disparea.y and argy < disparea.h then
            --pause and show journal
            mode.display = true
        else
            for i, button in pairs(buttons) do
                if argx > button.x and argx < button.x + button.sprite:getWidth() and
                    argy > button.y and argy < button.y + button.sprite:getHeight() then
                    love.audio.play(button.clickd)
                    wasbutton = true
                    if button.pressed and button == lastbutton then
                        --unclick button but only if it is the last one pressed
                        locked = false
                        button.pressed = false
                        button.pressed = false
                        cvects = {}
                    elseif not locked and not button.down then
                        lastbutton = button
                        -- generate new vectors tied to the cursor for this button
                        game.createvectors(button)
                        --lock all other buttons
                        locked = true
                        button.pressed = not button.pressed
                        button.down = true
                    end
                end
            end
        end
    end
    return wasbutton, lastbutton
end

function game.placevectors(argx, argy)
    --cloning current vectors into placed vectors
    vgrp = {
        x = argx,
        y = argy,
        -- this needs to be deep copy
        vs = cvects
    }
    
    --go through avects and verify whether they're all the same color
    if not game.colorsmatch(targetcolor, vgrp.vs.color, 100) then
        game.reset()
    else
        locked = false
        --insert the vector and re-init cvects
        table.insert(avects, vgrp)
        love.mouse.setVisible(true)
        -- cvects = {}
        if cvects.colorcenter then
            --retain old colorcenter
            cvects = {colorcenter = {x = cvects.colorcenter.x, y = cvects.colorcenter.y}}
        else
            --init new color center
            cvects = {colorcenter = {x = 0, y = 0}}
        end
        
        --if you have made it this far and all the lines have been placed, then we go to the next stage
        --NOTE: Do we want to do this here?
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
                    intr = game.addintersects(pts, shape, vgrp.x, vgrp.y, v.x, v.y)
                end
            end
            
            if intr and #pts >= 2 then
                p = pts[1]
                q = pts[2]
                poly1, poly2 = split_poly(shape, p.p1, p.p2, q.p1 - p.p1, q.p2 - p.p2)
                table.insert(ps, poly1)
                table.insert(ps, poly2)
            else
                --didn't split, keep this shape
                table.insert(ps, shape)
            end
        end
        
        ashapes = {}
        for _, poly in pairs(ps) do
            table.insert(ashapes, poly)
        end
        
        --Once we have split all the shapes, check items in them to decide what to highlight
        for i, shape in pairs(ashapes) do
            foundtarget = false
            selecteditems = {}
            for i, t in pairs(matrix.tiles) do
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
end

function love.mousepressed(argx, argy, button, istouch, presses)
    --this converts to scaled position
    argx, argy = love.mouse.getPosition()
    if mode.title then
        game.startgame()
    else
        --init check for button press
        wasbutton, lastbutton = game.buttonclicked(argx, argy, button, istouch, presses)
        
        -- if we are inside the viewing area, place the current vectors on the screen
        if not wasbutton and locked and not mode.display then
            game.placevectors(argx, argy)
        else
            
            --item section
            if matrix then
                for i, tile in pairs(matrix.tiles) do
                    if argx > tile.tx and argx < tile.tx + tile.tw and
                        argy > tile.ty and argy < tile.ty + tile.th then
                        --clicked on an item
                        print(sets.tostring(tile))
                        --not nil, in the correct shape, and all lines have been placed
                        if tile and tile.focus and butt.alldown(buttons) then
                            found = items.find(i)
                            if found then
                                game.reset()
                                mode.display = true
                                game.progress()
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
end

function love.mousereleased(argx, argy, button, istouch, presses)
    releasecounter=releasecounter+1
    -- Add current mouse position to vects array
    argx, argy = love.mouse.getPosition()
    
    for i, button in pairs(buttons) do
        
        if argx > button.x and argx < button.x + button.sprite:getWidth() and
            argy > button.y and argy < button.y + button.sprite:getHeight() then
            love.audio.play(button.clicku)
            if button.pressed then
                
                c = level.getcolor(levels)
                cvects.color = {r=c.r,g=c.g,b=c.b,a=c.a}
                cvects.colorcenter = level.getcenter(levels,button.label)
            end
        end
    end
end
