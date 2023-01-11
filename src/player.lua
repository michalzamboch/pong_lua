
PlayerId = {
    unknown = 0,
    player = 1,
    ai = 2
}

local myFont = love.graphics.newFont(45)

Player = {
    id = PlayerId.unknown,
    points = 0,
    x = 0,
    y = 25,
}

function Player:new(xPos, id)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    love.graphics.setFont(myFont)
    o.x = xPos
    o.id = id
    return o
end

function Player:setPlayerId(id)
    self.id = id
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