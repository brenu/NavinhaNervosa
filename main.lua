screenWidth = love.graphics.getWidth()
screenHeight = love.graphics.getHeight()

function love.load()
    Class = require "classic"
    require "scenes/game"
    require "scenes/menu"
    require "scenes/gameOver"

    game = Game()
    menu = Menu()
    gameOver = GameOver()

    scenes = {
        game = game,
        menu = menu,
        gameOver = gameOver
    }
    presentScene = "menu"
end

function love.update(dt)
    scenes[presentScene]:update(dt)
end

function love.draw()
    scenes[presentScene]:draw()
end