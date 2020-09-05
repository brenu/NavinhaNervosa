Game = Class:extend()

function Game:new()
    ship = Ship()
end

function Game:update(dt)
    ship:update(dt)
end

function Game:draw()
    ship:draw()
end