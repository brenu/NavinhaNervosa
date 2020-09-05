screenWidth = love.graphics.getWidth()
screenHeight = love.graphics.getHeight()

function love.load()
    Class = require "classic"
    require "game"
    require "ship"

    game = Game()
end

function love.update(dt)
    game:update(dt)
end

function love.draw()
    game:draw()
end