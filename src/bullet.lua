require "configuration"

Bullet = {
    fired = false,
    x = 0,
    y = 0,
    r = BulletRadius,
    speed = BulletSpeed
}

local function DefaultSettings(o)
    o.x = 0
    o.y = 0
    o.r = BulletRadius
    o.speed = BulletSpeed
    o.fired = false
end

function Bullet:new(x, y)
    local object = {}
    setmetatable(object, self)
    self.__index = self

    DefaultSettings(object)
    return object
end

function Bullet:draw()
    love.graphics.circle("fill", self.x, self.y, self.r)
end

function Bullet:move()
    local dt = love.timer.getDelta()
    local tmp_x = self.x + self.speed * dt * MotionConstant
end

function Bullet:reset()
    DefaultSettings(self)
end
