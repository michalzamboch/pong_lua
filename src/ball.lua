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

function Ball:move()
    local dt = love.timer.getDelta()
    local tmp_x = self.x + self.xSpeed * dt
    local tmp_y = self.y + self.ySpeed * dt

    self:BatCollision(tmp_x, tmp_y)
    self:HorizontalWallCollision(tmp_y)
    self:VerticalWallCollision(tmp_x)
end

---------------------------------------------------------------

function Ball:BatCollision(tmp_x, tmp_y)
    local bat1 = self.game.bat1
    local bat2 = self.game.bat2


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
        self.x = width - self.a
        self:invertXSpeed()
        self.game.player1:increasePoints()
        -- self:reset()
    end

    if tmp_x < 0 then
        self.x = 0
        self:invertXSpeed()
        self.game.player2:increasePoints()
        -- self:reset()
    end

    self.x = tmp_x
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
