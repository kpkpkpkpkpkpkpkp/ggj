local vector = require 'lib.vector'
require 'lib.sets'

game = {}

-- Current vectors tracked by the mouse. Current color of vectors is also included
cvects = {color = {r = 255, g = 255, b = 255}}
-- All vectors placed on the screen
avects = {}

-- Coords + image
buttons = require 'src.buttons'
lock = false
holding = false
lastbutton = nil

function game.load()
    bgcanvas = love.graphics.newCanvas(720, 208)
    border = love.graphics.newImage('assets/edge.png')
    screen = love.graphics.newImage('assets/Screen.png')
    items = love.graphics.newImage('assets/ItemsCropped.png')
    cross = love.image.newImageData('assets/testing/crosshairs.png')
    shine = love.graphics.newImage('assets/testing/shine.png')
    cur = love.mouse.newCursor(cross, 32, 32)
    love.mouse.setCursor(cur)
end

bg = {x = 0, y = 0}
scrollspeed = 1
function game.update(dt)
    bg.x = bg.x - scrollspeed
    if bg.x < -screen:getWidth() then bg.x = 0 end

    mx, my = love.mouse.getPosition()

    for i, button in pairs(buttons) do
        if mx > button.x and mx < button.x + button.sprite:getWidth() and my >
            button.y and my < button.y + button.sprite:getHeight() then
            button.shine = true
        else
            button.shine = false
        end
    end

    ww = love.graphics.getWidth()
    wh = love.graphics.getHeight()

    
    for i, v in pairs(cvects) do
        if i ~= 'color' then
            -- these vectors extend from the cursor. create a cursor vector and add the two to get final position.
            vx, vy = v:unpack()
            love.graphics.line(mx, my, vx + mx, vy + my)
        end
    end


end

function game.draw()
    -- love.graphics.setCanvas(bgcanvas)
    love.graphics.draw(screen, bg.x, bg.y)
    love.graphics.draw(screen, bg.x + screen:getWidth(), bg.y)
    -- love.graphics.setCanvas(canvas)
    -- love.graphics.draw(bgcanvas)
    love.graphics.draw(items, 0, 0)

    mx, my = love.mouse.getPosition()
    ww = love.graphics.getWidth()
    wh = love.graphics.getHeight()
    love.graphics.setLineStyle('rough')
    love.graphics.setLineWidth(4)
    -- Draw lines for vects array
    for i, vgrp in pairs(avects) do
        --vgrp corresponds to a previous cvects (avects is saved current vector tables that include a color)
        -- love.graphics.setColor(coord.rgb.hr, coord.rgb.hg, coord.rgb.hb)
         
        love.graphics.setColor(vgrp.vs['color'].r, vgrp.vs['color'].g, vgrp.vs['color'].b,vgrp.vs['color'].a)

        for i, v in pairs(vgrp.vs) do
            if i ~= 'color' then
                love.graphics.line(vgrp.x, vgrp.y, v.x + vgrp.x, v.y + vgrp.y)
            end
        end
    end
    -- love.graphics.setColor(255, 255, 255)
    if cvects.color then
        love.graphics.setColor(cvects['color'].r, cvects['color'].g, cvects['color'].b,cvects['color'].a)
    end
    for i, v in pairs(cvects) do
        if i ~= 'color' then
            -- these vectors extend from the cursor. create a cursor vector and add the two to get final position.
            vx, vy = v:unpack()
            love.graphics.line(mx, my, vx + mx, vy + my)
        end
    end
    love.graphics.setColor(255,255,255)

    -- love.graphics.setColor(255, 255, 255)
    love.graphics.draw(border, 0, 0)

    for i, button in pairs(buttons) do
        if button.pressed then
            love.graphics.draw(button.sprite,
                               button.x + button.sprite:getWidth(),
                               button.y + button.sprite:getHeight(), math.pi)
        else

            love.graphics.draw(button.sprite, button.x, button.y)
        end

        if button.shine then
            love.graphics.draw(shine, button.x-16, button.y-16)
        end
    end
end

function love.keypressed(key, isrepeat) if key == 'escape' then avects = {} end end

function love.mousepressed(argx, argy, button, istouch, presses)
    -- Add current mouse position to vects array
    argx, argy = love.mouse.getPosition()
    wasbutton = false
    c = nil
    for i, button in pairs(buttons) do
        if argx > button.x and argx < button.x + button.sprite:getWidth() and
            argy > button.y and argy < button.y + button.sprite:getHeight() then
            wasbutton = true
            if button.pressed and button == lastbutton then
                cvects = {color = button.color}
                locked = false
                button.pressed = not button.pressed
            else
                if not locked then
                    lastbutton = button
                    -- generate new vectors tied to the cursor for this button
                    mag = 500
                    for i, v in pairs(button.vectors) do
                        cvects.color = button.color
                        table.insert(cvects, mag * v)
                    end
                    -- 
                    -- vector.fromAngle(math.pi / 5.5)
                    -- vector.fromAngle(math.pi * 2 / 3)
                    locked = true
                end
                button.pressed = not button.pressed
            end
        end
    end

    -- if we are inside the viewing area, place the current vectors on the screen
    if not wasbutton and locked then
        table.insert(avects, {x = argx, y = argy, vs = cvects})
        cvects = {color = cvects.color}
        locked = false
    end
end

function love.mousereleased(argx, argy, button, istouch, presses)
    -- Add current mouse position to vects array
    argx, argy = love.mouse.getPosition()

    for i, button in pairs(buttons) do
        
        if argx > button.x and argx < button.x + button.sprite:getWidth() and
            argy > button.y and argy < button.y + button.sprite:getHeight() then
            if button.pressed then
                
                cvects.color = button.color
                button.pressed = not button.pressed
            end
        end
    end
end

function love.wheelmoved(x, y) end
