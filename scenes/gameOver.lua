GameOver = Class:extend()

function GameOver:new()
    self.image = love.graphics.newImage("assets/images/game_over.png")

    self.loseTheme = love.audio.newSource("assets/sounds/game_over.ogg", "stream")
end

function GameOver:update(dt)
    if love.keyboard.isDown("space") then
        presentScene = "menu"
        self.loseTheme:stop()
        menu.menuSong:play()
    end
end

function GameOver:draw()
    love.graphics.draw(self.image)

    love.graphics.setFont(font30)
    love.graphics.print("Press space to go back", 210, screenHeight/2+100)
end