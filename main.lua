-- This is a simple Snake game implementation using LÖVE framework in Lua.
local love = require("love")
local gridSize = 32
local timer = 0
local fruits = {apple = 1, banana = 2, orange = 3, watermelon = 4}
local score = 0
local interval = 0.35
local dir = "right"
local snake = {
    {x = 10, y = 10},
    {x = 9, y = 10},
    {x = 8, y = 10},
}
local apple_image, banana_image, orange_image, watermelon_image
local fruit_delay = 0
local fruit = nil
-- Initialize the game window and settings
function love.load()
    love.window.setTitle("Snake Game")
    love.window.setMode(800, 600, { resizable = false, vsync = true })

    apple_image = love.graphics.newImage("apple.png")
    banana_image = love.graphics.newImage("banana.png")
    orange_image = love.graphics.newImage("orange.png")
    watermelon_image = love.graphics.newImage("watermelon.png")
end

function love.update(dt)
    timer = timer + dt
    if timer >= interval then
        timer = 0

        -- Snake movement
        local head = snake[1]
        local newX, newY = head.x, head.y
        if dir == "right" then newX = newX + 1 end
        if dir == "left" then newX = newX - 1 end
        if dir == "up" then newY = newY - 1 end
        if dir == "down" then newY = newY + 1 end
        table.insert(snake, 1, {x = newX, y = newY})
        table.remove(snake)

        -- Fruit spawn delay
        if fruit == nil then
            fruit_delay = fruit_delay + 1
            if fruit_delay >= 2 then
                fruit_delay = 0
                fruit = {
                    x = math.random(0, (love.graphics.getWidth() / gridSize) - 1),
                    y = math.random(0, (love.graphics.getHeight() / gridSize) - 1),
                    type = math.random(1, 4)
                }
            end
        end
    end
end

function love.draw()
    for i, segment in ipairs(snake) do
        love.graphics.rectangle("fill", segment.x * gridSize, segment.y * gridSize, gridSize, gridSize)
    end

    if fruit then
        local fx, fy = fruit.x * gridSize, fruit.y * gridSize
        if fruit.type == 1 then
            love.graphics.draw(apple_image, fx, fy)
        elseif fruit.type == 2 then
            love.graphics.draw(banana_image, fx, fy)
        elseif fruit.type == 3 then
            love.graphics.draw(orange_image, fx, fy)
        elseif fruit.type == 4 then
            love.graphics.draw(watermelon_image, fx, fy)
        end
    end
end

function love.keypressed(key)
    if key == "d" and dir ~= "left" then dir = "right" end
    if key == "a" and dir ~= "right" then dir = "left" end
    if key == "w" and dir ~= "down" then dir = "up" end
    if key == "s" and dir ~= "up" then dir = "down" end
end