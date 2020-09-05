Game = Class:extend()

function Game:new()
    require "ship"
    require "enemy"
    require "item"

    ship = Ship()

    enemyTime = 0
    enemyList = {}
    itemList = {}
end

function Game:update(dt)
    enemyTime = enemyTime + dt

    if enemyTime > 1 then
        Game:newEnemy()
        enemyTime = 0
    end

    ship:update(dt)

    for i, enemy in pairs(enemyList) do
        enemy:update(dt)

        if Game:verifyCollision(enemy, ship) then
            table.remove(enemyList, i)
            
            ship:loseHP()
            ship:normalizeSpeed()
        end

        if enemy:isOutOfView() then
            table.remove(enemyList, i)
        end

        for j, shoot in pairs(ship.shootList) do
            if Game:verifyCollision(enemy, shoot) then
                table.remove(enemyList, i)
                table.remove(ship.shootList, j)
                
                ship:updateScore(enemy.score)

                Game:newItem(enemy.x, enemy.y)
            end
        end
    end

    for i, item in pairs(itemList) do
        item:update(dt)

        if item:isOutOfView() then
            table.remove(itemList, i)
        end

        if Game:verifyCollision(item, ship) then
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

    love.graphics.print("Score: "..ship.score, 20, 50, 0, 1.3)
end

function Game:newEnemy()
    local enemy = Enemy(love.math.random(0, 700), -100, 200)

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