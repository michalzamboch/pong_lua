require "physics"

Ball = {
    x = 0,
    y = 0,
    r = 15,

    xSpeed = 150,
    ySpeed = 150
}

function Ball:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Ball:draw()
    love.graphics.circle("fill", self.x, self.y, self.r)
end

function Ball:move(dt, bat1, bat2)
    local tmp_x = self.x + self.xSpeed * dt
    local tmp_y = self.y + self.ySpeed * dt

    tmp_x, tmp_y = self:WallColision(tmp_x, tmp_y)
    tmp_x, tmp_y = self:BatCollision(bat1, tmp_x, tmp_y)
    tmp_x, tmp_y = self:BatCollision(bat2, tmp_x, tmp_y)

    self:setPosition(tmp_x, tmp_y)
end

function Ball:BatCollision(bat, tmp_x, tmp_y)
    local collides = Intersects(bat, tmp_x, tmp_y, self.r)

    return tmp_x, tmp_y
end

function Ball:WallColision(tmp_x, tmp_y)
    local width = love.graphics.getPixelWidth()
    local height = love.graphics.getPixelHeight()

    if tmp_x > (width - self.r) then
        tmp_x = width - self.r
        self:invertXSpeed()
    end

    if tmp_x < self.r then
        tmp_x = self.r
        self:invertXSpeed()
    end

    if tmp_y > (height - self.r) then
        tmp_y = height - self.r
        self:invertYSpeed()
    end

    if tmp_y < self.r then
        tmp_y = self.r
        self:invertYSpeed()
    end

    return tmp_x, tmp_y
end

function Ball:setPosition(x, y)
    self.x = x
    self.y = y
end

function Ball:setSpeed(xs, ys)
    self.xSpeed = xs
    self.ySpeed = ys
end

function Ball:invertXSpeed()
    self.xSpeed = self.xSpeed * (-1)
end

function Ball:invertYSpeed()
    self.ySpeed = self.ySpeed * (-1)
end
