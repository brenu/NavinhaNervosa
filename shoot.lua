Shoot = Class:extend()

function Shoot:new(x, y)
    self.x, self.y = x, y
    self.width = 3
    self.height = 8
    self.speed = 1000
end 

function Shoot:update(dt)
    self.y = self.y - self.speed*dt
end

function Shoot:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Shoot:isOutOfView()
    if self.y < -self.height then
        return true
    end

    return false
end