local x
local y
fruits = {apple, banana, orange, watermelon}

function love.load()
    love.window.setTitle("Snake Game")
    x = 100
    y = 100
    love.window.setMode(800, 800, { resizable = false, vsync = true })
end

function love.update(dt)
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
    love.graphics.rectangle("line", x, y, 50, 80)
end