Game = Class:extend()

function Game:new()
    require "ship.lua"

    ship = Ship()

end

function Game:update(dt)
    Ship:update(dt)
end

function Game:draw()
    Ship:draw()
end