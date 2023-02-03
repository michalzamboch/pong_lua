require "configuration"

Player = {
    points = 0,
    x = 0,
    y = PointsPositionY,
}

--[[
points
x
y
]]

---------------------------------------------------------------

function Player:new(xPos)
    local object = {}
    setmetatable(object, self)
    self.__index = self

    object.x = xPos
    return object
end

function Player:drawPoints()
    love.graphics.print(tostring(self.points), self.x, self.y, nil, ScaleX, ScaleY)
end

function Player:scale()
    
end

function Player:increasePoints()
    self.points = self.points + 1
    PlaySound(PointUpSound)
end

function Player:reset()
    self.points = 0
end

function Player:setPosition(x)
    self.x = x
end

---------------------------------------------------------------

function Player:toString()
    return tostring(self.points) .. " " ..
        tostring(self.x) .. " " ..
        tostring(self.y)
end

function Player:fromString(string)
    local data = Split(string, " ")
    self.points = tonumber(data[1])
    self.x = tonumber(data[2])
    self.y = tonumber(data[3])
end

function Player:copy(object)
    self.x = object.x
    self.y = object.y
    self.points = object.points
end
