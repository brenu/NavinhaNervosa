screenWidth = love.graphics.getWidth()
screenHeight = love.graphics.getHeight()

function love.load()
    Class = require "classic"
    require "game"

    game = Game()
end

function love.update(dt)
    game:update(dt)
end

function love.draw()
    game:draw()
end