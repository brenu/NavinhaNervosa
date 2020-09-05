GameOver = Class:extend()

function GameOver:new()
    self.image = love.graphics.newImage("assets/images/game_over.png")
end

function GameOver:update(dt)
    if love.keyboard.isDown("space") then
        presentScene = "menu"
    end
end

function GameOver:draw()
    love.graphics.draw(self.image)

    love.graphics.print("Press space to go back", 330, screenHeight/2+100)
end