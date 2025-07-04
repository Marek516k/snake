local x

function love.load()
    love.window.setTitle("Snake Game")
    x = 100
end

function love.update(dt)
    if love.keyboard.isDown("d") then
        x = x + 200 * dt -- Move right when 'd' is pressed
    end
end

function love.draw()
    love.graphics.rectangle("line", x, 200, 50, 80)
end