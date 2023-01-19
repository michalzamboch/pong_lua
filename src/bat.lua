
Bat = {
    game = {},
    x = 0,
    y = BatPositionY,
    w = BatWidth,
    h = BatHeight,
    speed = BatSpeed,
    speedAi = BatSpeedAi
}

--------------------------------------------------

function DefaultSettings(o)
    o.w = BatWidth
    o.h = BatHeight
    o.y = BatPositionY
    o.speed = BatSpeed
    o.speedAi = BatSpeedAi
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

function Bat:towardsMe()
    local ball = self.game.ball
    local a1 = self.x > (ball.x - ball.a / 2) and ball.xSpeed > 0
    local a2 = self.x < (ball.x - ball.a / 2) and ball.xSpeed < 0
    return (a1 or a2)
end

function Bat:moveAutomatically()
    local dt = love.timer.getDelta()
    local ball = self.game.ball
    local ball_y = ball.y + ball.a / 2
    local bat_mid = self.y + self.h / 2

    if not self:towardsMe() then
        return
    end

    if bat_mid > ball_y then
        self:up(dt, self.speedAi)
    elseif bat_mid < ball_y then
        self:down(dt, self.speedAi)
    end
end

function Bat:moveManually(dt, down, up)
    if love.keyboard.isDown(down) then
        self:down(dt, self.speed)
    elseif love.keyboard.isDown(up) then
        self:up(dt, self.speed)
    end
end

function Bat:up(dt, sp)
    if self.y > 0 then
        self.y = self.y - sp * dt * MotionConstant
    end
end

function Bat:down(dt, sp)
    local tmp_h = love.graphics.getPixelHeight() - self.h
    if self.y < tmp_h then
        self.y = self.y + sp * dt * MotionConstant
    end
end
