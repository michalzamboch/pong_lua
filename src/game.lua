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

GameState = {
    unknown = 0,
    playing = 1,
    paused = 2,
    ended = 3,
}

Game = {
    state = GameState.playing,
    maxPoints = 10,
}

-------------------------------------------------------------

function Game:new()
    local object = {}
    setmetatable(object, self)
    self.__index = self

    object.bat1 = Bat:new(object, BatStartPosition)
    object.bat2 = Bat:new(object, ScreenWidth() - BatStartPosition * 2)
    object.player1 = Player:new(ScorePosition, true)
    object.player2 = Player:new(ScorePosition * 3, false)
    object.ball = Ball:new(object)

    return object
end

function Game:draw()
    if self.state == GameState.playing or self.state == GameState.paused then
        self:drawGame()
    elseif self.state == GameState.ended then
        self:drawResult()
    elseif self.state == GameState.unknown then
        self:drawError()
    end
end

function Game:drawGame()
    self.bat1:draw()
    self.bat2:draw()
    self.ball:draw()
    self.player1:drawPoints()
    self.player2:drawPoints()
    self:drawLine()
end

function Game:drawResult()
    local message = "Nobody won yet."

    if self.player1.points >= self.maxPoints then
        message = "Player num. 1 (on the right) won."
    elseif self.player2.points >= self.maxPoints then
        message = "Player num. 2 (on the left) won."
    end

    local tmpX = 0
    local tmpY = ScreenHeight() / 2 - MyFontSize
    love.graphics.print(message, tmpX, tmpY)
    love.graphics.print("Press F5 to play new game.", tmpX, tmpY + MyFontSize)
end

function Game:drawError()
    love.graphics.print("Game is in unknown state.")
end

function Game:update(dt)
    if self.state == GameState.playing then
        self:moveBats(dt)
        self.ball:move()
    end
end

function Game:moveBats(dt)
    if self.player1.manual then
        self.bat1:moveManually(dt, "down", "up")
    else
        self.bat1:moveAutomatically()
    end

    if self.player2.manual then
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
    self.state = GameState.playing
end

function Game:fullscreen()
    Fullscreen = not Fullscreen
    love.window.setFullscreen(Fullscreen)
    local vertical = ScreenHeight() / 2 - self.bat1.h / 2

    self.bat1:setVerticalPos(vertical)
    self.bat2:setHorizontalPos(ScreenWidth() - self.bat2.w * 2)
    self.bat2:setVerticalPos(vertical)
    self.player1.x = ScreenWidth() / 4
    self.player2.x = self.player1.x * 3
    self.ball:reset()
end

function Game:pauseGame()
    if self.state == GameState.ended then
        return
    end

    if self.state == GameState.paused then
        self.state = GameState.playing
    elseif self.state == GameState.playing then
        self.state = GameState.paused
    end
end

function Game:drawLine()
    local tmp_m = ScreenWidth() / 2
    love.graphics.rectangle("fill", tmp_m - 1, 0, 2, ScreenHeight())
end

function Game:switchModeBat1()
    self.player1.manual = not self.player1.manual
end

function Game:switchModeBat2()
    self.player2.manual = not self.player2.manual
end

function Game:checkScore()
    if self.player1.points >= self.maxPoints or self.player2.points >= self.maxPoints then
        self.state = GameState.ended
    end
end
