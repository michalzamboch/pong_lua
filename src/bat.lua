BatPosition = {
    left = 1,
    right = 2,
}

Bat = {
    game = {},
    stop = false,
    manual = true,
    moving = false,
    x = 0,
    y = BatPositionY,
    w = BatWidth,
    h = BatHeight,
    speed = BatSpeed,
    speedAi = BatSpeedAi,
    direction = 0,
    image = nil
}

--[[
stop
manual
moving
x
y
w
h
speed
speedAi
direction
image
]]

--------------------------------------------------

local function DefaultSettings(o)
    o.w = o.image:getWidth()
    o.h = o.image:getHeight()
    o.y = BatPositionY
    o.speed = BatSpeed
    o.speedAi = BatSpeedAi
    o.moving = false
    o.stop = false
    o.direction = 0
end

function Bat:new(game, position, manual)
    local object = {}
    setmetatable(object, self)
    self.__index = self

    object.game = game
    object.manual = manual

    if position == BatPosition.left then
        object.image = love.graphics.newImage(ImagePath .. "1.png")
        object.x = object.image:getWidth() / 2
    else
        object.image = love.graphics.newImage(ImagePath .. "2.png")
        object.x = ScreenWidth() - object.image:getWidth() * 1.5
    end
    DefaultSettings(object)

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

function Bat:getCurrentSpeed()
    if self.manual then
        return self.speed
    else
        return self.speedAi
    end
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
    love.graphics.draw(self.image, self.x, self.y)
end

function Bat:move(down, up)
    if self.stop then
        return
    end

    if self.manual then
        self:moveManually(down, up)
    else
        self:moveAutomatically()
    end
end

function Bat:switchMode()
    self.manual = not self.manual
end

--------------------------------------------------

function Bat:copy(object)
    self.manual = object.manual
    self.moving = object.moving
    self.x = object.x
    self.y = object.y
    self.w = object.w
    self.h = object.h
    self.speed = object.speed
    self.speedAi = object.speedAi
    self.direction = object.direction
    self.stop = object.stop
end

function Bat:toString()
    return tostring(self.manual) .. " " ..
        tostring(self.moving) .. " " ..
        tostring(self.x) .. " " ..
        tostring(self.y) .. " " ..
        tostring(self.w) .. " " ..
        tostring(self.h) .. " " ..
        tostring(self.speed) .. " " ..
        tostring(self.speedAi) .. " " ..
        tostring(self.direction) .. " " ..
        tostring(self.stop)
end

function Bat:fromString(string)
    local data = Split(string, " ");
    self.manual = toboolean(data[1])
    self.moving = toboolean(data[2])
    self.x = tonumber(data[3])
    self.y = tonumber(data[4])
    self.w = tonumber(data[5])
    self.h = tonumber(data[6])
    self.speed = tonumber(data[7])
    self.speedAi = tonumber(data[8])
    self.direction = tonumber(data[9])
    self.stop = toboolean(data[10])
end

--------------------------------------------------

function Bat:towardsMe()
    local ball = self.game.ball
    local a1 = self.x > (ball.x - ball.a / 2) and ball.xSpeed > 0
    local a2 = self.x < (ball.x - ball.a / 2) and ball.xSpeed < 0
    return (a1 or a2)
end

function Bat:moveAutomatically()
    local ball = self.game.ball
    local ball_y = ball.y + ball.a / 2
    local bat_mid = self.y + self.h / 2

    if not self:towardsMe() then
        return
    end

    if bat_mid < ball_y then
        self.direction = 1
        self.moving = true
    elseif bat_mid > ball_y then
        self.direction = -1
        self.moving = true
    else
        self.direction = 0
        self.moving = false
    end

    self:moveInDirection()
end

--------------------------------------------------

function Bat:moveManually(down, up)
    if love.keyboard.isDown(down) then
        self.direction = 1
        self.moving = true
    elseif love.keyboard.isDown(up) then
        self.direction = -1
        self.moving = true
    else
        self.direction = 0
        self.moving = false
    end

    self:moveInDirection()
end

function Bat:moveInDirection()
    local tmp_h = love.graphics.getPixelHeight() - self.h
    local dt = love.timer.getDelta()

    if self.y > 0 and self.direction == -1 then
        self.y = self.y - self:getCurrentSpeed() * dt * MotionConstant
    end

    if self.y < tmp_h and self.direction == 1 then
        self.y = self.y + self:getCurrentSpeed() * dt * MotionConstant
    end
end

--------------------------------------------------

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
