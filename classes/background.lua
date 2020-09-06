Background = Class:extend()

function Background:new(x, y)
    self.image = love.graphics.newImage("assets/images/background.png")
    self.x = x
    self.y = y
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
end

function Background:update(dt)
    self.y = self.y + 150*dt

    if self.y >= screenHeight then
        self.y = -self.height
    end
end

function Background:draw()
    love.graphics.draw(self.image, self.x, self.y)
end