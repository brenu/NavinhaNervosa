Ship = Class:extend()

function Ship:new()
    require "shoot"

    self.image = love.graphics.newImage("assets/images/ship.png")
    self.x, self.y = 400,300
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.speed = 500

    self.shootList = {}
end

function Ship:update(dt)
    self:move(dt)
    self:keepInsideView()

    for i, shoot in pairs(self.shootList) do
        shoot:update(dt)

        if shoot:isOutOfView() then
            table.remove(self.shootList, i)
        end
    end

    if love.keyboard.isDown("space") then
        self:shoot(dt)
    end
end

function Ship:draw()
    for i, shoot in pairs(self.shootList) do
        shoot:draw()
    end

    love.graphics.draw(self.image, self.x, self.y)
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

function Ship:shoot(dt)
    local shoot = Shoot(self.x + self.width/2, self.y)

    table.insert(self.shootList, shoot)
end