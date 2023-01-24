require "bat"
require "ball"
require "player"
require "configuration"

-------------------------------------------------------------

GameState = {
    unknown = 0,
    playing = 1,
    paused = 2,
    ended = 3,
}

GameNetSettings = {
    single = 0,
    multiLocal = 1,
    multiLan = 2
}

NetRole = {
    unknown = 0,
    client = 1,
    server = 2
}

Game = {
    state = GameState.playing,
    maxPoints = MaxPoints,
    gameNetSettings = GameNetSettings.single,
    netRole = NetRole.unknown
}

-------------------------------------------------------------

function Game:new()
    local object = {}
    setmetatable(object, self)
    self.__index = self
    local plMode1, plMode2 = PlayerMode1, PlayerMode2

    if self.gameNetSettings == GameNetSettings.single then
        plMode1, plMode2 = true, false
    elseif self.gameNetSettings == GameNetSettings.multiLocal then
        plMode1, plMode2 = true, true
    else
        plMode1, plMode2 = true, true
        self.netRole = CurrentNetRole
    end

    object.bat1 = Bat:new(object, BatStartPosition, plMode1)
    object.bat2 = Bat:new(object, ScreenWidth() - BatStartPosition * 2, plMode2)
    object.player1 = Player:new(ScorePosition)
    object.player2 = Player:new(ScorePosition * 3)
    object.ball = Ball:new(object)

    return object
end

-------------------------------------------------------------

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

-------------------------------------------------------------

function Game:update()
    if self.gameNetSettings == GameNetSettings.multiLan then
        self:updateLan()
    else
        self:updateLocal()
    end
end

function Game:updateLan()
    if self.netRole == NetRole.server then

    else

    end
end

function Game:updateLocal()
    if self.state == GameState.playing then
        self:moveBats()
        self.ball:move()
    end
end

function Game:moveBats()
    self.bat1:move(Player1Down, Player1Up)
    self.bat2:move(Player2Down, Player2Up)
end

function Game:reset()
    self.ball:reset()
    self.bat1:reset()
    self.bat2:reset()
    self.player1:reset()
    self.player2:reset()
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

function Game:drawLine()
    local tmp_m = ScreenWidth() / 2
    love.graphics.rectangle("fill", tmp_m - 1, 0, 2, ScreenHeight())
end

function Game:switchModeBat1()
    self.bat1:switchMode()
end

function Game:switchModeBat2()
    self.bat2:switchMode()
end

function Game:checkScore()
    if self.player1.points >= self.maxPoints or self.player2.points >= self.maxPoints then
        self.state = GameState.ended
        PlaySound(WinSound)
    end
end
