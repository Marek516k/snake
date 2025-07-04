local snake{
    x,y = 0, 0,
    direction = 'right',
    body = {},
    length = 1,
    speed = 5,
}


function love.load()
    love.window.setTitle("Snake Game")
    love.window.setMode(800, 600)
end

function love.draw()
    love.graphics.rectangle("fill", 100, 200, 50, 80)
end

