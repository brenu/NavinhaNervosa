Ship = Class:extend()

function Ship:new()
    self.x, self.y = 400,300
    self.width = 50
    self.height = 50
    self.speed = 200
end

function Ship:update(dt)
    self:move(dt)
    self:keepInsideView()
end

function Ship:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Ship:move(dt)
    if love.keyboard.isDown("up") then
        self.y = self.y - self.speed*dt
    elseif love.keyboard.isDown("down") then
        self.y = self.y + self.speed*dt
    end

    if love.keyboard.isDown("left") then
        self.x = self.x - self.speed*dt
    elseif love.keyboard.isDown("right") then
        self.x = self.x + self.speed*dt
    end
end

function Ship:keepInsideView()
    if self.x < 0 then
        self.x = 0
    elseif self.x + self.width > screenWidth then
        self.x = screenWidth - self.width
    end

    if self.y < 0 then
        self.y = 0
    elseif self.y + self.height > screenHeight then
        self.y = screenHeight - self.height
    end
end