-- This is a simple Snake game implementation using LÖVE framework in Lua.
local love = require("love")
local gridSize = 32
local timer = 0
local score = 0
local interval = 0.3
local dir = "right"
local snake = {
    {x = 10, y = 10},
    {x = 9, y = 10},
    {x = 8, y = 10},
}
local apple_image, banana_image, orange_image, watermelon_image, head_image --variables for images of fruits and snake head    
local fruit_delay = 0
local gameover = false
local font_size
local song
local chompSound
local death
local fruit = nil
local scoremultiplier = 1 -- Multiplier for score, can be adjusted based on fruit type

-- Initialize the game window and settings
function love.load()
    head_image = love.graphics.newImage("head.png")
    love.window.setTitle("Snake Game")
    love.window.setMode(800, 600, { resizable = false, vsync = true })
    font_size = love.graphics.newFont(20)

    apple_image = love.graphics.newImage("apple.png")
    banana_image = love.graphics.newImage("banana.png")
    orange_image = love.graphics.newImage("orange.png")
    watermelon_image = love.graphics.newImage("watermelon.png")
    chompSound = love.audio.newSource("chomp.wav", "static")
    song = love.audio.newSource("Kubbi - Up In My Jam.mp3", "stream")
    death = love.audio.newSource("oof.mp3", "stream")
    song:setVolume(0.015)
    song:setLooping(true)
    song:play()
end

function love.update(dt)
    local grow = false
    if not gameover then
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
        if fruit and newX == fruit.x and newY == fruit.y then
            grow = true
        end
        table.insert(snake, 1, {x = newX, y = newY})
        if not grow then
            table.remove(snake)
        end
            if fruit == nil then
                fruit_delay = fruit_delay + 1 -- Fruit spawn delay
                if fruit_delay >= 2 then
                    fruit_delay = 0
                    fruit = {
                        x = math.random(0, (love.graphics.getWidth() / gridSize) - 1),
                        y = math.random(0, (love.graphics.getHeight() / gridSize) - 1),
                        type = math.random(1, 4)
                    }
                end
            end
            love.checkcollision()
        end
    end
end

function love.draw()
    love.graphics.setFont(font_size)
    love.graphics.setColor(1, 1, 1, 1) -- white
    local scoreText = "Score: " .. tostring(score)
    local textWidth = font_size:getWidth(scoreText)
    love.graphics.print(scoreText, love.graphics.getWidth() - textWidth - 10, 10)
    -- snake head
    local head = snake[1]
    love.graphics.draw(head_image, head.x * gridSize, head.y * gridSize)
    -- snake body
    for i = 2, #snake do
        local segment = snake[i]
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
    if gameover then
        love.graphics.setFont(font_size)
        love.graphics.setColor(1, 0, 0, 1) --red
        love.graphics.printf("YOU LOST, press r to restart the game", 0, love.graphics.getHeight() / 2 - 20, love.graphics.getWidth(), "center")
    end
end

function love.keypressed(key)
    if key == "d" and dir ~= "left" then dir = "right" end
    if key == "a" and dir ~= "right" then dir = "left" end
    if key == "w" and dir ~= "down" then dir = "up" end
    if key == "s" and dir ~= "up" then dir = "down" end
    if key == "r" and gameover then
        love.event.quit("restart") -- Restart the game
        gameover = false
    end
end

function love.checkcollision()
    if fruit then
        local head = snake[1]
        if head.x == fruit.x and head.y == fruit.y then
            love.audio.play(chompSound)
        if fruit.type == 1 then
            scoremultiplier = 1
        elseif fruit.type == 2 then
            scoremultiplier = 2
        elseif fruit.type == 3 then
            scoremultiplier = 2
        elseif fruit.type == 4 then
            scoremultiplier = 4
        end

        score = score + 1 * scoremultiplier
        
        if score == 10 then
            interval = 0.2 -- Speed up the game
        elseif score == 30 then
            interval = 0.15 -- Further speed up the game
        elseif score == 100 then
            interval = 0.1 -- Maximum speed
        end

        fruit = nil -- Remove the fruit after eating
        end
    end
    if snake[1].x < 0 or snake[1].x >= love.graphics.getWidth() / gridSize or
        snake[1].y < 0 or snake[1].y >= love.graphics.getHeight() / gridSize then
        love.audio.play(death)
        gameover = true
    end
    for i = 2, #snake do
        if snake[1].x == snake[i].x and snake[1].y == snake[i].y then
            love.audio.play(death)
            gameover = true
        end
    end
end