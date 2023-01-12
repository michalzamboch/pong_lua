ScreenHeight = love.graphics.getPixelHeight()
ScreenWidth = love.graphics.getPixelWidth()
BatPosY = (ScreenHeight / 2) - 120 / 2

Bat = {
    game = {},
    x = 0,
    y = BatPosY,
    w = 20,
    h = 120,
    speed = 200,
    acceleration = 10
}

--------------------------------------------------

function DefaultSettings(o)
    o.w = 20
    o.h = 120
    o.y = love.graphics.getPixelHeight() / 2 - o.h / 2
    o.speed = 200
    o.acceleration = 10
end

function Bat:new(game, xPos)
    local object = {}
    setmetatable(object, self)
    self.__index = self

    DefaultSettings(object)
    object.x = xPos
    object.game = game
    return object
end

function Bat:reset()
    DefaultSettings(self)
end

--------------------------------------------------

function Bat:getX()
    return self.x
end

function Bat:getX2()
    return self.x + self.w
end

function Bat:getY()
    return self.y
end

function Bat:getY2()
    return self.y + self.h
end

function Bat:setPosition(a, b)
    self.x = a
    self.y = b
end

function Bat:setHorizontalPos(x)
    self.x = x
end

function Bat:setVerticalPos(y)
    self.y = y
end

function Bat:setSpeed(s)
    self.speed = s
end

function Bat:setSize(w, h)
    self.w = w
    self.h = h
end

--------------------------------------------------

function Bat:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

function Bat:moveAutomatically()
    local dt = love.timer.getDelta()
    local ball = self.game.ball
    local tmp_y = ball.y - self.h / 2

    local tmp_h = love.graphics.getPixelHeight() - self.h
    if tmp_y > 0 and tmp_y < tmp_h then
        self.y = tmp_y
    end
end

function Bat:moveManually(dt, down, up)
    if love.keyboard.isDown(down) then
        self:down(dt)
    elseif love.keyboard.isDown(up) then
        self:up(dt)
    end
end

function Bat:up(dt)
    if self.y > 0 then
        self.y = self.y - self.speed * dt
    end
end

function Bat:down(dt)
    local tmp_h = love.graphics.getPixelHeight() - self.h
    if self.y < tmp_h then
        self.y = self.y + self.speed * dt
    end
end
