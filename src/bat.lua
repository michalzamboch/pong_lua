Bat = {
    x = 0,
    y = 0,
    w = 25,
    h = 125,

    horizontalSpeed = 0.1
}

function Bat:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Bat:setPosition(a, b)
    self.x = a
    self.y = b
end

function Bat:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

function Bat:moveUp()
    
end

function Bat:moveDown()
    
end