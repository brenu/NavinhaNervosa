Item = Class:extend()

function Item:new(type, x, y)
    self.x, self.y = x, y 
    
    self.type = type
    self.speed = 200

    if self.type == 1 then
        self.image = love.graphics.newImage("assets/images/item_shoot.png")
    elseif self.type == 2 then
        self.image = love.graphics.newImage("assets/images/item_speed.png")
    end

    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
end

function Item:update(dt)
    self.y = self.y + self.speed*dt
end

function Item:draw()
    love.graphics.draw(self.image, self.x, self.y)
end

function Item:isOutOfView()
    if self.y > screenHeight then
        return true
    end

    return false
end