require "bat"
require "ball"
require "player"

function ScreenWidth()
    return love.graphics.getPixelWidth()
end

function ScreenHeight()
    return love.graphics.getPixelHeight()
end

-------------------------------------------------------------

local ScorePosition = ScreenWidth() / 4
local BatHeight = 140
local BatStartPosition = 25
local BatPosY = love.graphics.getPixelHeight() / 2 - BatHeight / 2

Game = {
    pause = false
}

-------------------------------------------------------------

function Game:new()
    local object = {}
    setmetatable(object, self)
    self.__index = self

    object.bat1 = Bat:new(object, BatStartPosition)
    object.bat2 = Bat:new(object, ScreenWidth() - BatStartPosition * 2)
    object.player1 = Player:new(ScorePosition, PlayerId.player)
    object.player2 = Player:new(ScorePosition * 3, PlayerId.ai)
    object.ball = Ball:new(object)

    return object
end

function Game:draw()
    self.bat1:draw()
    self.bat2:draw()
    self.ball:draw()
    self.player1:drawPoints()
    self.player2:drawPoints()
    self:drawLine()
end

function Game:update(dt)
    if self.pause == false then
        self:moveBats(dt)
        self.ball:move()
    end
end

function Game:moveBats(dt)
    if self.player1.id == PlayerId.player then
        self.bat1:moveManually(dt, "down", "up")
    else
        self.bat1:moveAutomatically()
    end

    if self.player2.id == PlayerId.player then
        self.bat2:moveManually(dt, "s", "w")
    else
        self.bat2:moveAutomatically()
    end
end

function Game:reset()
    self.ball:reset()
    self.bat1:reset()
    self.bat2:reset()
    self.player1:reset()
    self.player2:reset()
    self.pause = false
end

function Game:fullscreen()
    Fullscreen = not Fullscreen
    love.window.setFullscreen(Fullscreen)

    self.bat1:setVerticalPos(ScreenHeight() / 2 - self.bat1.h / 2)
    self.bat2:setHorizontalPos(ScreenWidth() - self.bat2.w * 2)
    self.player1.x = ScreenWidth() / 4
    self.player2.x = self.player1.x * 3
    self.ball:reset()
end

function Game:pauseGame()
    self.pause = not self.pause
end

function Game:drawLine()
    local tmp_m = ScreenWidth() / 2
    love.graphics.rectangle("fill", tmp_m - 1, 0, 2, ScreenHeight())
end
