Shoot = Class:extend()

function Shoot:new(x, y)
    self.x, self.y = x, y
    self.image = love.graphics.newImage("assets/images/shoot.png")
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.speed = 1000
end 

function Shoot:update(dt)
    self.y = self.y - self.speed*dt
end

function Shoot:draw()
    love.graphics.draw(self.image, self.x, self.y)
end

function Shoot:isOutOfView()
    if self.y < -self.height then
        return true
    end

    return false
end