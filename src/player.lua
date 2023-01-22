require "configuration"

Player = {
    points = 0,
    x = 0,
    y = PointsPositionY,
}

function Player:new(xPos)
    local object = {}
    setmetatable(object, self)
    self.__index = self

    object.x = xPos
    return object
end

function Player:drawPoints()
    love.graphics.print(tostring(self.points), self.x, self.y)
end

function Player:increasePoints()
    self.points = self.points + 1
end

function Player:reset()
    self.points = 0
end

function Player:setPosition(x)
    self.x = x
end
