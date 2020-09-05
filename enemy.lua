Enemy = Class:extend()

function Enemy:new(x, y, speed)
    self.image = love.graphics.newImage("assets/images/enemy.png")
    self.x, self.y = x,y
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.speed = speed
end

function Enemy:update(dt)
    self.y = self.y + self.speed * dt
end

function Enemy:draw()
    love.graphics.draw(self.image, self.x, self.y)
end

function Enemy:isOutOfView()
    if self.y > screenHeight then
        return true
    end

    return false
end