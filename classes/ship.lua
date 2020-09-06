Ship = Class:extend()

function Ship:new()
    require "classes/shoot"

    self.image = love.graphics.newImage("assets/images/ship.png")
    self.x, self.y = 400,300
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.speed = 400
    
    self.hp = 3
    self.score = 0

    self.damage = 1
    self.shootTimer = 0
    
    self.shootList = {}

    self.shootSound = love.audio.newSource("assets/sounds/shoot.wav", "static")
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

    self.shootTimer = self.shootTimer+dt
    if love.keyboard.isDown("space") and self.shootTimer > 0.2 then
        self.shootTimer = 0
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
    self.shootSound:play()

    local shoot = Shoot(self.x + self.width/2-5, self.y)

    table.insert(self.shootList, shoot)
end

function Ship:updateScore(enemyScore)
    self.score = self.score + enemyScore
end

function Ship:earnHP()
    self.hp = self.hp + 1
end

function Ship:loseHP()
    self.hp = self.hp - 1
end

function Ship:incrementShoots()
    self.damage = self.damage + 0.1
end

function Ship:incrementSpeed()
    self.speed = self.speed + 10
end

function Ship:normalizeSpeed()
    self.speed = 400
end

function Ship:normalizeDamage()
    self.damage = 1
end