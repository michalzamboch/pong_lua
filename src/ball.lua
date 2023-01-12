require "physics"

local BallSize = 20
local DefX = love.graphics.getPixelWidth() / 2 - BallSize / 2
local DefY = love.graphics.getPixelHeight() / 2 - BallSize / 2
local DefXSpeed = 150
local DefYSpeed = -150

Ball = {
    game = {},
    x = DefX,
    y = DefY,
    a = BallSize,

    xSpeed = DefXSpeed,
    ySpeed = DefYSpeed
}

local function RandomSpeed(minSpeed, maxSpeed)
    local rng = love.math.newRandomGenerator(os.time())
    local speed = rng:random(minSpeed, maxSpeed)

    if rng:random(0, 100) < 50 then
        return speed * (-1)
    else
        return speed
    end
end

local function DefaultSettings(o)
    o.x = love.graphics.getWidth() / 2 - BallSize / 2
    o.y = love.graphics.getHeight() / 2 - BallSize / 2
    o.a = BallSize
    o.xSpeed = RandomSpeed(175, 250)
    o.ySpeed = RandomSpeed(125, 175)
end

function Ball:new(game)
    local object = {}
    setmetatable(object, self)
    self.__index = self

    DefaultSettings(object)
    object.game = game
    return object
end

function Ball:reset()
    DefaultSettings(self)
end

---------------------------------------------------------------

function Ball:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.a, self.a)
end

function Ball:move()
    local dt = love.timer.getDelta()
    local tmp_x = self.x + self.xSpeed * dt
    local tmp_y = self.y + self.ySpeed * dt

    self:HorizontalCollision(tmp_y)
    self:VerticalCollision(tmp_x)
end

---------------------------------------------------------------

function Ball:BatCollision(tmp_x)
    self.x = tmp_x

    if CollidesRect(self, self.game.bat1) then
        self:invertXSpeed()
        self.x = self.game.bat1:getX2()
        return
    end

    if CollidesRect(self, self.game.bat2) then
        self:invertXSpeed()
        self.x = self.game.bat2:getX() - self.a
    end
end

function Ball:HorizontalCollision(tmp_y)
    local height = love.graphics.getPixelHeight()

    if tmp_y > (height - self.a) then
        tmp_y = height - self.a
        self:invertYSpeed()
    end

    if tmp_y < 0 then
        tmp_y = 0
        self:invertYSpeed()
    end

    self.y = tmp_y
end

function Ball:VerticalCollision(tmp_x)
    local width = love.graphics.getPixelWidth()

    if tmp_x > (width - self.a) then
        self.game.player1:increasePoints()
        self:reset()
    elseif tmp_x < 0 then
        self.game.player2:increasePoints()
        self:reset()
    else
        self:BatCollision(tmp_x)
    end
end

---------------------------------------------------------------

function Ball:getX()
    return self.x
end

function Ball:getY()
    return self.y
end

function Ball:getX2()
    return self.x + self.a
end

function Ball:getY2()
    return self.y + self.a
end

---------------------------------------------------------------

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
