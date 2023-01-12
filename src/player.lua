
local myFont = love.graphics.newFont(45)

Player = {
    manual = true,
    points = 0,
    x = 0,
    y = 25,
}

function Player:new(xPos, mode)
    local object = {}
    setmetatable(object, self)
    self.__index = self
    love.graphics.setFont(myFont)

    object.x = xPos
    object.manual = mode
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
