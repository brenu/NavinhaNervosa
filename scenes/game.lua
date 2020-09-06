Game = Class:extend()

function Game:new()
    require "../classes/ship"
    require "../classes/enemy"
    require "../classes/item"

    ship = Ship()

    enemyTime = 0
    enemyList = {}
    itemList = {}

    level = {
        -- XPosition, Speed, Time to show up
        {100, 75, 2},
        {200, 75, 2},
        {300, 75, 2},
        {700, 150, 1},
        {600, 150, 1},
        {500, 150, 1},
        {150, 200, 1},
        {0, 200, 1},
        {650, 200, 1},
        {500, 250, 3},
        {230, 300, 3},
    }

    levelIndex = 1

    self.gameTheme = love.audio.newSource("assets/sounds/game_theme.wav", "stream")
    self.gameTheme:setLooping(true)

    self.pickItemSound = love.audio.newSource("assets/sounds/pick_item.ogg", "static")
end

function Game:update(dt)
    enemyTime = enemyTime + dt

    if levelIndex <= #level and enemyTime > level[levelIndex][3] then
        Game:newEnemy(level[levelIndex][1], level[levelIndex][2])
        enemyTime = 0
        levelIndex = levelIndex + 1
    end

    ship:update(dt)

    for i, enemy in pairs(enemyList) do
        enemy:update(dt)

        if Game:verifyCollision(enemy, ship) then            
            table.remove(enemyList, i)
            
            ship:loseHP()
            ship:normalizeSpeed()
            ship:normalizeDamage()

            local explosion = love.audio.newSource("assets/sounds/explosion.ogg", "static")
            explosion:play()

            if ship.hp <= 0 then
                presentScene = "gameOver"
                self.gameTheme:stop()
                gameOver.loseTheme:play()
            end
        end

        if enemy:isOutOfView() then
            table.remove(enemyList, i)
        end

        for j, shoot in pairs(ship.shootList) do
            if Game:verifyCollision(enemy, shoot) then
                local shootCollisionSound = love.audio.newSource("assets/sounds/shoot_collision.wav", "static")
                shootCollisionSound:play()

                enemy.hp = enemy.hp - ship.damage
                if enemy.hp <= 0 then
                    local explosionSound = love.audio.newSource("assets/sounds/explosion.ogg", "static")
                    explosionSound:play()

                    table.remove(enemyList, i)
                    ship:updateScore(enemy.score)
    
                    Game:newItem(enemy.x, enemy.y)
                end
                table.remove(ship.shootList, j)
                
            end
        end
    end

    for i, item in pairs(itemList) do
        item:update(dt)

        if item:isOutOfView() then
            table.remove(itemList, i)
        end

        if Game:verifyCollision(item, ship) then
            self.pickItemSound:play()

            if item.type == 1 then
                ship:incrementShoots()
            elseif item.type == 2 then
                ship:incrementSpeed()
            end

            table.remove(itemList, i)
        end
    end
end

function Game:draw()
    ship:draw()

    for i, enemy in pairs(enemyList) do
        enemy:draw()
    end

    for i = 1, ship.hp do
        love.graphics.draw(ship.image, 20*i, 30, 0, 0.2)
    end

    for i, item in pairs(itemList) do
        item:draw()
    end

    love.graphics.setFont(font20)
    love.graphics.print("Score: "..ship.score, 20, 50, 0, 1.3)
end

function Game:newEnemy(x, speed)
    local enemy = Enemy(x, -100, speed)

    table.insert(enemyList, enemy)
end

function Game:newItem(x, y)
    local item = Item(love.math.random(1,2), x, y)

    table.insert(itemList, item)
end

function Game:verifyCollision(a, b)
    if a.x < b.x + b.width and
        a.x + a.width > b.x and
        a.y < b.y + b.height and
        a.y + a.width > b.y then
            return true
    end

    return false
end