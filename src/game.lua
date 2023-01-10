require "bat"
require "ball"

function ScreenWidth()
    return love.graphics.getPixelWidth()
end

function ScreenHeight()
    return love.graphics.getPixelHeight()
end

-------------------------------------------------------------

BatHeight = 140
function BatPosY()
    return love.graphics.getPixelHeight() / 2 - BatHeight / 2
end

Game = {}

function Game:new()
    local object = {}
    setmetatable(object, self)
    self.__index = self

    object.bat1 = Bat:new(25)
    object.bat2 = Bat:new(ScreenWidth() - 50)
    object.ball = Ball:new()

    return object
end

function Game:draw()
    self.bat1:draw()
    self.bat2:draw()

    self.ball:draw()
end

function Game:update(dt)
    self:moveBats(dt)

    self.ball:move(dt, self.bat1, self.bat2)
end

function Game:moveBats(dt)
    self.bat1:moveManually(dt, "down", "up")
    self.bat2:moveManually(dt, "s", "w")
end
