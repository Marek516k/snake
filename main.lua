-- This is a simple Snake game implementation using LÖVE framework in Lua.
local gridSize = 32
local timer = 0
local fruits = {apple = 1, banana = 2, orange = 3, watermelon = 4}
local score = 0
local interval = 0.3
local dir = "right"
local snake = {
    {x = 10, y = 10},
    {x = 9, y = 10},
    {x = 8, y = 10},
}
local fruit_delay = 0
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
        fruit_delay = fruit_delay + 1
        -- Get head position
        local head = snake[1]
        local newX, newY = head.x, head.y

        if dir == "right" then newX = newX + 1 end
        if dir == "left" then newX = newX - 1 end
        if dir == "up" then newY = newY - 1 end
        if dir == "down" then newY = newY + 1 end

        -- Add new head
        table.insert(snake, 1, {x = newX, y = newY})

        -- Remove tail (so the snake doesn't grow yet)
        table.remove(snake)
    end
end

function love.draw()
    for i, segment in ipairs(snake) do
        love.graphics.rectangle("fill", segment.x * gridSize, segment.y * gridSize, gridSize, gridSize)
    end
    if fruit_delay >= 2 then
        local fruitType = math.random(1, #fruits)
        local fruitX = math.random(0, love.graphics.getWidth() / gridSize - 1)
        local fruitY = math.random(0, love.graphics.getHeight() / gridSize - 1)
        if fruitType == 1 then
            love.graphics.draw(apple_image, fruitX * gridSize, fruitY * gridSize) end
        elseif fruitType == 2 then
            love.graphics.draw(banana_image, fruitX * gridSize, fruitY * gridSize)
        elseif fruitType == 3 then
            love.graphics.draw(orange_image, fruitX * gridSize, fruitY * gridSize)
        elseif fruitType == 4 then
            love.graphics.draw(watermelon_image, fruitX * gridSize, fruitY * gridSize)
        fruit_delay = 0
    end
end

function love.keypressed(key)
    if key == "d" and dir ~= "left" then dir = "right" end
    if key == "a" and dir ~= "right" then dir = "left" end
    if key == "w" and dir ~= "down" then dir = "up" end
    if key == "s" and dir ~= "up" then dir = "down" end
end