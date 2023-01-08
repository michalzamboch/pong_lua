Ball = {
    x = 0,
    y = 0,
    r = 50,

    xSpeed = 0,
    ySpeed = 0
}

function Ball:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Ball:draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.circle("fill", self.x, self.y, self.w, self.h)
end

function Ball:move()
    self.x = self.x + self.xSpeed
    self.y = self.y + self.ySpeed
end

function Ball:setSpeed(xs, ys)
    self.xSpeed = xs
    self.ySpeed = ys
end