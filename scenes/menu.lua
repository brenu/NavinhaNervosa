Menu = Class:extend()

function Menu:new()
    self.image = love.graphics.newImage("assets/images/landing.png")
    self.options = {"Play", "Exit"}

    self.selectorIcon = love.graphics.newImage("assets/images/ship.png")
    self.selectorX = screenWidth/2 - 60
    self.selectorY = screenHeight/2 + 50
    self.selectedOption = 1

    self.optionTime = 0

    self.menuSong = love.audio.newSource("assets/sounds/menu.ogg", "stream")
    self.menuSong:play()
end

function Menu:update(dt)
    self.optionTime = self.optionTime + dt

    if love.keyboard.isDown("up", "down") and self.optionTime > 0.2 then
        local optionChangeSound = love.audio.newSource("assets/sounds/menu_option.ogg", "static")
        optionChangeSound:play()

        if self.selectorY == screenHeight/2 + 50 then
            self.selectorY = screenHeight/2 + 50 * 2
            self.selectedOption = 2
        else
            self.selectorY = screenHeight/2 + 50
            self.selectedOption = 1
        end

        self.optionTime = 0
    end

    if love.keyboard.isDown("space") and self.optionTime > 0.2 then
        local selectedOptionSound = love.audio.newSource("assets/sounds/menu_option_select.ogg", "static")
        selectedOptionSound:play()

        self.optionTime = 0
        if self.selectedOption == 1 then
            presentScene = "game"
            game:new()
            self.menuSong:stop()
            game.gameTheme:play()
        elseif self.selectedOption == 2 then
            love.event.quit()
        end
    end
end

function Menu:draw()
    love.graphics.draw(self.image)

    love.graphics.setFont(font30)

    for i=1, #self.options do
        love.graphics.print(self.options[i], screenWidth/2-40, screenHeight/2 + 50*i)
    end

    love.graphics.draw(self.selectorIcon, self.selectorX, self.selectorY, 1.5, 0.3);
end