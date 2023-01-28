require "bat"
require "ball"
require "player"
require "configuration"

Socket = require "socket"

Udp = Socket.udp()
Udp:setsockname('*', 12345)
Udp:settimeout(0)

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
    local plMode1, plMode2 = PlayerMode1, PlayerMode2

    if self.gameNetSettings == GameNetSettings.single then
        plMode1, plMode2 = true, false
    elseif self.gameNetSettings == GameNetSettings.multiLocal then
        plMode1, plMode2 = true, true
    else
        plMode1, plMode2 = true, true
        self.netRole = CurrentNetRole
    end

    object.bat1 = Bat:new(object, BatPosition.left, plMode1)
    object.bat2 = Bat:new(object, BatPosition.right, plMode2)
    object.player1 = Player:new(ScorePosition)
    object.player2 = Player:new(ScorePosition * 3)
    object.ball = Ball:new(object)

    object.universe = love.graphics.newImage(ImagePath .. "universe.png")
    object.planets = love.graphics.newImage(ImagePath .. "planets.png")

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
    self:drawBackground()
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

function Game:drawBackground()
    love.graphics.draw(self.universe, 0, 0)
    local halfWidth, halfHeight = self.planets:getWidth() / 2, self.planets:getHeight() / 2
    love.graphics.draw(self.planets, halfWidth, halfHeight, self.planetsRotation, 1, 1, halfWidth, halfHeight)
end

-------------------------------------------------------------

function Game:update()
    local dt = love.timer.getDelta()
    self.planetsRotation = self.planetsRotation + 0.05 * dt

    if self.gameNetSettings == GameNetSettings.multiLan then
        self:updateLan()
    else
        self:updateLocal()
    end
end

function Game:updateLocal()
    if self.state == GameState.playing then
        self:moveBats()
        self.ball:move()
    end
end

function Game:updateLan()
    if self.netRole == NetRole.server then
        self:server()
    else
        self:client()
    end
end

function Game:server()
    local data, msg_or_ip, port_or_nil = Udp:receivefrom()
    print(data)
    if data then
        local meString = self:toString()
        print("s: " .. meString)
        -- self:fromString(data)
        -- Udp:sendto(meString, msg_or_ip, port_or_nil)
        self.bat1:move(Player1Down, Player1Up)
    else
        self.state = GameState.unknown
    end
end

function Game:client()
    local meString = self:toString()
    print("c: " .. meString)

    Udp:send(meString)
    local data = Udp:receive()
    if data then
        -- self:fromString(data)
    else
        self.state = GameState.unknown
    end
end

-------------------------------------------------------------

function Game:toString()
    if self.netRole == NetRole.server then
        return self.bat1:toString() .. "|" .. self.ball:toString()
    else
        return self.bat2:toString()
    end
end

function Game:fromString(string)
    if self.netRole == NetRole.server then
        self.bat2:fromString(string)
    else
        local data = Split(string, "|")
        self.bat1:fromString(data[1])
        self.ball:fromString(data[2])
    end
end

function Game:copy(object)
    self.bat1 = object.bat1
    self.bat2 = object.bat2
    self.player1 = object.player1
    self.player2 = object.player2
    self.ball = object.ball
end

-------------------------------------------------------------

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
