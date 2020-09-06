Enemy = Class:extend()

function Enemy:new(x, y, speed)
    self.image = love.graphics.newImage("assets/images/enemy.png")
    self.x, self.y = x,y
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.speed = speed

    self.score = 1

    self.hp = 3
end

function Enemy:update(dt)
    self.y = self.y + self.speed * dt
end

function Enemy:draw()
    love.graphics.draw(self.image, self.x, self.y)

    love.graphics.setColor(1,0,0)
    love.graphics.rectangle("fill", self.x, self.y - 20, self.width * self.hp/3, 3)
    love.graphics.setColor(1,1,1)
end

function Enemy:isOutOfView()
    if self.y > screenHeight then
        return true
    end

    return false
end