
PlayerId = {
    unknown = 0,
    player1 = 1,
    player2 = 2,
    ai = 3
}

Player = {
    id = PlayerId.unknown,
    points = 0,
    x = 0,
    y = 50,
    font = love.graphics.newFont("helvetica", 20)
}

function Player:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    love.graphics.setFont(self.font)
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

function Player:resetPoints()
    self.points = 0
end

function Player:setPosition(x)
    self.x = x
end