require "physics"
require "configuration"

function RandomSpeed(minSpeed, maxSpeed)
    local speed = Rng:random(minSpeed, maxSpeed)

    local indexes = { -1, 1 }
    return speed * indexes[math.random(#indexes)]
end

function RandomSpeedX()
    return RandomSpeed(BallMinSpeedX, BallMinSpeedX)
end

function RandomSpeedY()
    return RandomSpeed(BallMinSpeedY, BallMinSpeedY)
end

---------------------------------------------------------------

Ball = {
    game = {},
    x = BallPositionX,
    y = BallPositionY,
    a = BallSize,

    xSpeed = RandomSpeedX(),
    ySpeed = RandomSpeedY(),
    bounce = false,
    image = nil
}

--[[
x
y
a
xSpeed
ySpeed
bounce
]]

---------------------------------------------------------------

local function DefaultSettings(o)
    o.a = o.image:getWidth()
    o.x = ScreenWidth() / 2 - o.a / 2
    o.y = ScreenHeight() / 2 - o.a / 2
    o.xSpeed = RandomSpeedX()
    o.ySpeed = RandomSpeedY()
end

function Ball:new(game)
    local object = {}
    setmetatable(object, self)
    self.__index = self

    object.game = game
    object.image = love.graphics.newImage(ImagePath .. "ball.png")

    DefaultSettings(object)
    return object
end

function Ball:reset()
    DefaultSettings(self)
end

---------------------------------------------------------------

function Ball:draw()
    love.graphics.draw(self.image, self.x, self.y)
end

function Ball:move()
    local dt = love.timer.getDelta()
    local tmp_x = self.x + self.xSpeed * dt * MotionConstant
    local tmp_y = self.y + self.ySpeed * dt * MotionConstant

    self:HorizontalCollision(tmp_y)
    self:VerticalCollision(tmp_x)

    if self.bounce then
        PlaySound(BounceSound)
        self.bounce = false
    end
end

---------------------------------------------------------------

function Ball:toString()
    return tostring(self.x) .. " " ..
        tostring(self.y) .. " " ..
        tostring(self.a) .. " " ..
        tostring(self.xSpeed) .. " " ..
        tostring(self.ySpeed) .. " " ..
        tostring(self.bounce)
end

function Ball:fromString(string)
    local data = Split(string, " ")
    self.x = tonumber(data[1])
    self.y = tonumber(data[2])
    self.a = tonumber(data[3])
    self.xSpeed = tonumber(data[4])
    self.ySpeed = tonumber(data[5])
    self.bounce = toboolean(data[6])
end

function Ball:copy(object)
    self.x = object.x
    self.y = object.y
    self.a = object.a
    self.xSpeed = object.xSpeed
    self.ySpeed = object.ySpeed
    self.bounce = object.bounce
end

---------------------------------------------------------------

function Ball:addCollisionSpeed(bat)
    if bat.moving then
        self.ySpeed = self.ySpeed + (bat:getCurrentSpeed() / 2 * SpeedUpBounce(self.ySpeed, bat.direction))
        if self.xSpeed > 0 then
            self.xSpeed = self.xSpeed + 10
        else
            self.xSpeed = self.xSpeed - 10
        end
        print(self.xSpeed, self.ySpeed)
    end
end

function Ball:BatCollision(tmp_x)
    self.x = tmp_x

    if CollidesRect(self, self.game.bat1) then
        self:invertXSpeed()
        self:addCollisionSpeed(self.game.bat1)
        self.x = self.game.bat1:getX2()
        self.bounce = true
        return
    end

    if CollidesRect(self, self.game.bat2) then
        self:invertXSpeed()
        self:addCollisionSpeed(self.game.bat2)
        self.x = self.game.bat2:getX() - self.a
        self.bounce = true
    end
end

function Ball:HorizontalCollision(tmp_y)
    local height = love.graphics.getPixelHeight()

    if tmp_y > (height - self.a) then
        tmp_y = height - self.a
        self:invertYSpeed()
        self.bounce = true
    end

    if tmp_y < 0 then
        tmp_y = 0
        self:invertYSpeed()
        self.bounce = true
    end

    self.y = tmp_y
end

function Ball:VerticalCollision(tmp_x)
    local width = love.graphics.getPixelWidth()

    if tmp_x > (width - self.a) then
        self.game.player1:increasePoints()
        self.game:checkScore()
        self:reset()
    elseif tmp_x < 0 then
        self.game.player2:increasePoints()
        self.game:checkScore()
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

function Ball:setRandomSpeed()
    self.xSpeed = RandomSpeedX()
    self.ySpeed = RandomSpeedY()
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
