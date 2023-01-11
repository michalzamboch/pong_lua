require "physics"

Collisions = {
    nothing = 0,
    up = 1,
    down = 2,
    right = 3,
    left = 4,
    rightBat = 5,
    leftBat = 6
}

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

local function DefaultSettings(o)
    o.x = DefX
    o.y = DefY
    o.a = BallSize
    o.xSpeed = DefXSpeed
    o.ySpeed = DefYSpeed
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

function Ball:move(dt, bat1, bat2)
    local tmp_x = self.x + self.xSpeed * dt
    local tmp_y = self.y + self.ySpeed * dt
    --local collision = Collisions.nothing

    self:BatCollision(bat1, bat2, tmp_x, tmp_y)
    self:HorizontalWallCollision(tmp_y)
    local collision = self:VerticalWallCollision(tmp_x)

    --self:setPosition(tmp_x, tmp_y)
    return collision
end

---------------------------------------------------------------

function Ball:BatCollision(bat1, bat2, tmp_x, tmp_y)


    return tmp_x, tmp_y
end

function Ball:HorizontalWallCollision(tmp_y)
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

function Ball:VerticalWallCollision(tmp_x)
    local width = love.graphics.getPixelWidth()

    if tmp_x > (width - self.a) then
        --DefaultSettings(self)
        self.x = width - self.a
        self:invertXSpeed()
        self.game.player1:increasePoints()
        return Collisions.left
    end

    if tmp_x < 0 then
        --DefaultSettings(self)
        self.x = 0
        self:invertXSpeed()
        self.game.player2:increasePoints()
        return Collisions.right
    end

    self.x = tmp_x
    return Collisions.nothing
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
