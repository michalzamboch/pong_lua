require "bat"
require "ball"
require "player"
require "general.configuration"
require "general.enums"

-------------------------------------------------------------

Game = {
    state = GameState.playing,
    maxPoints = MaxPoints,
    gameNetSettings = GameNetSettings.single,
    netRole = NetRole.unknown,
    universe = nil,
    planets = nil,
    planetsRotation = 0
}

-------------------------------------------------------------

function Game:new()
    local object = {}
    setmetatable(object, self)
    self.__index = self

    object.batLeft = Bat:new(object, BatPosition.left, PlayerMode1)
    object.batRight = Bat:new(object, BatPosition.right, PlayerMode2)
    object.playerLeft = Player:new(ScorePosition)
    object.playerRight = Player:new(ScorePosition * 3)
    object.ball = Ball:new(object)

    object.universe = love.graphics.newImage(ImagePath .. "universe.png")
    object.planets = love.graphics.newImage(ImagePath .. "planets.png")

    return object
end

-------------------------------------------------------------

function Game:scale()

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
    self:drawBackground()
    self:drawLine()
    self.batLeft:draw()
    self.batRight:draw()
    self.ball:draw()
    self.playerLeft:drawPoints()
    self.playerRight:drawPoints()
    self:drawFPS()
end

function Game:drawResult()
    self:drawBackground()
    local message = self:GetVictoryMessage()

    local tmpX = 10
    local tmpY = ScreenHeight() / 2 - MyFontSize
    local scale = 0.7

    love.graphics.print(message, tmpX, tmpY, nil, scale * ScaleX, scale * ScaleY)
    love.graphics.print("Press F5 to play new game.", tmpX, tmpY + MyFontSize, nil, scale * ScaleX, scale * ScaleY)
end

function Game:GetVictoryMessage()
    if self.playerLeft.points >= self.maxPoints then
        return "Player on the left won."
    elseif self.playerRight.points >= self.maxPoints then
        return "Player on the right won."
    end
end

function Game:drawError()
    local tmpX = 10
    local tmpY = ScreenHeight() / 2 - MyFontSize
    love.graphics.print("Game is in unknown state.", tmpX, tmpY, nil, ScaleX, ScaleY)
end

function Game:drawLine()
    local tmp_m = ScreenWidth() / 2
    love.graphics.rectangle("fill", tmp_m - 1, 0, 2 * ScaleX, ScreenHeight())
end

function Game:drawBackground()
    love.graphics.draw(self.universe, 0, 0)
    local halfWidth = self.planets:getWidth() / 2
    local halfHeight = self.planets:getHeight() / 2
    love.graphics.draw(self.planets, halfWidth, halfHeight, self.planetsRotation, ScaleX, ScaleY, halfWidth, halfHeight)
end

function Game:drawFPS()
    if ShowFPS then
        love.graphics.print(tostring(love.timer.getFPS()), 1, 1, nil, 0.4 * ScaleX, 0.4 * ScaleY)
    end
end

-------------------------------------------------------------

function Game:update()
    local dt = love.timer.getDelta()
    self.planetsRotation = self.planetsRotation + 0.05 * dt

    self:updateLocal()
end

function Game:updateLocal()
    if self.state == GameState.playing then
        self:moveBats()
        self.ball:move()
    end
end

-------------------------------------------------------------

function Game:toString()
    if self.netRole == NetRole.server then
        return self.batLeft:toString() .. "|" .. self.ball:toString()
    else
        return self.batRight:toString()
    end
end

function Game:fromString(string)
    if self.netRole == NetRole.server then
        self.batRight:fromString(string)
    else
        local data = Split(string, "|")
        self.batLeft:fromString(data[1])
        self.ball:fromString(data[2])
    end
end

function Game:copy(object)
    self.batLeft = object.batLeft
    self.batRight = object.batRight
    self.playerLeft = object.playerLeft
    self.playerRight = object.playerRight
    self.ball = object.ball
end

-------------------------------------------------------------

function Game:moveBats()
    self.batLeft:move(PlayerLeftDown, PlayerLeftUp, PlayerLeftPush)
    self.batRight:move(PlayerRightDown, PlayerRightUp, PlayerRightPush)
end

function Game:reset()
    self.ball:reset()
    self.batLeft:reset()
    self.batRight:reset()
    self.playerLeft:reset()
    self.playerRight:reset()
    self.state = GameState.playing
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

function Game:switchModeBatLeft()
    self.batLeft:switchMode()
end

function Game:switchModeBatRight()
    self.batRight:switchMode()
end

function Game:checkScore()
    if self.playerLeft.points >= self.maxPoints or self.playerRight.points >= self.maxPoints then
        self.state = GameState.ended
        PlaySound(WinSound)
    end
end

function Game:showFPS()
    ShowFPS = not ShowFPS
end
