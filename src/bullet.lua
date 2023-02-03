require "configuration"

Bullet = {
    game = {},
    bat = {},
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
    o.a = BulletRadius
    o.speed = BulletSpeed
    o.fired = false
    if o.bat.position == BatPosition.left then
        o.x = o.bat.x + o.bat.w
    else
        o.x = o.bat.x - o.a
    end
    o.y = o.bat.y + o.bat.h / 2
end

function Bullet:new(game, bat)
    local object = {}
    setmetatable(object, self)
    self.__index = self

    object.game = game
    object.bat = bat
    DefaultSettings(object)

    return object
end

-------------------------------------------------------

function Bullet:reset()
    self = nil
end

function Bullet:draw()
    if not self.fired then
        return
    end
    love.graphics.circle("fill", self.x, self.y, self.a)
end

function Bullet:scale()

end

function Bullet:move()
    if not self.fired then
        return
    end

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
