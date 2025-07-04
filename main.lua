-- This is a simple Snake game implementation using LÖVE framework in Lua.
local x
local y
local timer = 0
local fruits = {apple = 1, banana = 2, orange = 3, watermelon = 4}
local score = 0
local interval = 2

function love.load()
    love.window.setTitle("Snake Game")
    x = 100
    y = 100
    love.window.setMode(800, 800, { resizable = false, vsync = true })
end

function love.update(dt)
    timer = timer + dt
if timer >= interval then
    timer = 0
    if dir == "right" then x = x + gridSize end
    if dir == "left" then x = x - gridSize end
    -- etc.
end
    if love.keyboard.isDown("d") then
        x = x + 100 * dt -- Move right when 'd' is pressed
    end
    if love.keyboard.isDown("w") then
        y = y - 100 * dt -- Move up when 'w' is pressed
    end
    if love.keyboard.isDown("s") then
        y = y + 100 * dt -- Move down when 's' is pressed
    end
    if love.keyboard.isDown("a") then
        x = x - 100 * dt -- Move left when 'a' is pressed
    end
end

function love.draw()
    love.graphics.rectangle("fill", x, y, 10, 10)
end