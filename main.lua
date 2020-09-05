function love.load()
    Class = require "classic.lua"
    require "game.lua"

    game = Game()
end

function love.update(dt)
    game:update(dt)
end

function love.draw()
    game:draw()
end