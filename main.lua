if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end
love.graphics.setDefaultFilter("nearest", "nearest" )
require 'src.game'
scale={x=2.5,y=2.5}
local __newImage = love.graphics.newImage -- old function
local __getPosition = love.mouse.getPosition -- old function
-- DEBUG = false
DEBUG = true

function love.mouse.getPosition() -- new function that sets nearest filter
    local x,y = __getPosition() -- call old function with all arguments to this function
    x=x/scale.x
    y=y/scale.y
    return x,y
end

function love.graphics.newImage(...) -- new function that sets nearest filter
    local img = __newImage(...) -- call old function with all arguments to this function
    img:setFilter('nearest', 'nearest')
    return img
end

function love.load()
    debuglines = {}
    love.window.setMode(res.x*scale.x, res.y*scale.y)
    canvas = love.graphics.newCanvas(res.x, res.y)
    canvas:setFilter("nearest", "nearest")
    game.load()
end

function love.update(dt)
    mx, my = love.mouse.getPosition()
    debuglines[1] = 'mouse x=' .. mx .. ' y=' .. my
    game.update(dt)
end

function love.draw()
    love.graphics.setCanvas(canvas)
    love.graphics.clear()
    game.draw()
    love.graphics.setCanvas()
    love.graphics.draw(canvas,0,0,0,scale.x,scale.y)

    -- DEBUG not drawn on canvas
    if DEBUG then
        offset = 16 -- distance from edges for debug text
        love.graphics.setColor(255, 0, 255, 255)
        for i, debug in pairs(debuglines) do
            offset = offset + 16
            love.graphics.print(debug, 16, love.graphics.getHeight() - offset)
        end
        offset = offset + 16
    end
    love.graphics.setColor(255, 255, 255)

end
