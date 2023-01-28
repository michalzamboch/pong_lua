require "configuration"

Bullet = {
    game = {},
    fired = false,
    x = 0,
    y = 0,
    a = BulletRadius,
    speed = BulletSpeed
}

--[[
fired
x
y
a
speed
]]

-------------------------------------------------------

local function DefaultSettings(o)
    o.x = 0
    o.y = 0
    o.a = BulletRadius
    o.speed = BulletSpeed
    o.fired = false
end

function Bullet:new(game, x, y)
    local object = {}
    setmetatable(object, self)
    self.__index = self

    DefaultSettings(object)

    self.game = game
    self.x = x
    self.y = y

    return object
end

-------------------------------------------------------

function Bullet:reset()
    DefaultSettings(self)
end

function Bullet:draw()
    love.graphics.circle("fill", self.x, self.y, self.a)
end

function Bullet:move()
    local dt = love.timer.getDelta()
    local tmp_x = self.x
    self.x = self.x + self.speed * dt * MotionConstant

    if CircleInRect(self, self.game.bat1) then

    end

    if CircleInRect(self, self.game.bat2) then

    end
end

-------------------------------------------------------

function Bullet:getX1()
    return self.x - self.a / 2
end

function Bullet:getY1()
    return self.y - self.a / 2
end

function Bullet:getX2()
    return self.x + self.a / 2
end

function Bullet:getY2()
    return self.y + self.a / 2
end

-------------------------------------------------------

function Bullet:copy(object)
    self.fired = object.fired
    self.x = object.x
    self.y = object.y
    self.a = object.a
    self.speed = object.speed
end

function Bullet:toString()
    return tostring(self.fired) .. " " ..
        tostring(self.x) .. " " ..
        tostring(self.y) .. " " ..
        tostring(self.a) .. " " ..
        tostring(self.speed)
end

function Bullet:fromString(string)
    local data = Split(string, " ")
    self.fired = toboolean(data[1])
    self.x = tonumber(data[2])
    self.y = tonumber(data[3])
    self.a = tonumber(data[4])
    self.speed = tonumber(data[5])
end

-------------------------------------------------------
